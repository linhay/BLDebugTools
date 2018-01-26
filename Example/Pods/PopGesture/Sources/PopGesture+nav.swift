//
//  PopGesture+nav.swift
//  Pods-PopGesture_Example
//
//  Created by linhey on 2018/1/17.
//

import UIKit

extension UINavigationController {

  private struct PopGesKey {
    static let gesKey = UnsafeRawPointer(bitPattern:"popges_gesKey".hashValue)!
    static let delegateKey = UnsafeRawPointer(bitPattern:"popges_delegateKey".hashValue)!
    static let appearanceEnabled = UnsafeRawPointer(bitPattern:"popges_appearanceEnabled".hashValue)!
  }

  var popGesture: UIPanGestureRecognizer {
    get {
      if let value = objc_getAssociatedObject(self,PopGesKey.gesKey) as? UIPanGestureRecognizer{ return value }
      let pan = UIPanGestureRecognizer()
      pan.maximumNumberOfTouches = 1
      self.popGesture = pan
      return pan
    }
    set {
      objc_setAssociatedObject(self,PopGesKey.gesKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
  }

  var popGes_delegate: PopGestureRecognizerDelegate {
    get {
      if let value = objc_getAssociatedObject(self,PopGesKey.delegateKey) as? PopGestureRecognizerDelegate { return value }
      let delegate = PopGestureRecognizerDelegate()
      delegate.navigationController = self
      self.popGes_delegate = delegate
      return delegate
    }
    set {
      objc_setAssociatedObject(self,PopGesKey.delegateKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
  }

  var navigationBarAppearanceEnabled: Bool {
    get {
      if let value = objc_getAssociatedObject(self,PopGesKey.appearanceEnabled) as? Bool { return value }
      self.navigationBarAppearanceEnabled = true
      return true
    }
    set {
      objc_setAssociatedObject(self,PopGesKey.appearanceEnabled, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
  }


  @objc open func popGes_pushViewController(_ viewController: UIViewController, animated: Bool) {
    guard let gestureRecognizers = interactivePopGestureRecognizer?.view?.gestureRecognizers else {
      saveVCNavState(vc: viewController)
      popGes_pushViewController(viewController,animated: animated)
      return
    }

    if !gestureRecognizers.contains(popGesture) {
      self.interactivePopGestureRecognizer?.view?.addGestureRecognizer(popGesture)
      let targets = interactivePopGestureRecognizer?.value(forKey: "targets") as! [NSObject]
      let target = targets.first?.value(forKey: "target") as! NSObject
      let action = NSSelectorFromString("handleNavigationTransition:")
      popGesture.delegate = popGes_delegate
      popGesture.addTarget(target, action: action)
      interactivePopGestureRecognizer?.isEnabled = false
    }

    saveVCNavState(vc: viewController)
    if !viewControllers.contains(viewController) {
      popGes_pushViewController(viewController, animated: animated)
    }
  }


  func saveVCNavState(vc: UIViewController) {
    if !navigationBarAppearanceEnabled { return }

    let closure: PopGes_Closure = {[weak self]  (_ vc: UIViewController, _ animated: Bool) in
      guard let base = self else { return }
      base.setNavigationBarHidden(vc.isSetNavHidden, animated: animated)
    }
    vc.popGes_closure = closure
    guard let disappearingViewController = viewControllers.last,
      disappearingViewController.popGes_closure == nil else { return }
    disappearingViewController.popGes_closure = closure
  }

}
