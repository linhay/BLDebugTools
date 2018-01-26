//
//  PopGesture+vc.swift
//  Pods-PopGesture_Example
//
//  Created by linhey on 2018/1/17.
//

import UIKit
extension UIViewController {

  private struct EmptyDataKey {
    static let popGestureClosureKey = UnsafeRawPointer(bitPattern:"popGestureClosureKey".hashValue)!
    static let PopGestureDisabledKey = UnsafeRawPointer(bitPattern:"PopGestureDisabledKey".hashValue)!
    static let popGestureMaxLeftEdgeKey = UnsafeRawPointer(bitPattern:"popGestureMaxLeftEdgeKey".hashValue)!
    static let isSetNavHiddenKey = UnsafeRawPointer(bitPattern:"isSetNavHiddenKey".hashValue)!
  }

  public var popGestureMaxLeftEdge: CGFloat {
    get {
      #if CGFLOAT_IS_DOUBLE
        return objc_getAssociatedObject(self,EmptyDataKey.popGestureMaxLeftEdgeKey) as? Double ?? 0
      #else
        return objc_getAssociatedObject(self,EmptyDataKey.popGestureMaxLeftEdgeKey) as? CGFloat ?? 0
      #endif
    }
    set {
      objc_setAssociatedObject(self,EmptyDataKey.popGestureMaxLeftEdgeKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
  }

  public var isSetNavHidden: Bool {
    get {
      return objc_getAssociatedObject(self,EmptyDataKey.isSetNavHiddenKey) as? Bool ?? false
    }
    set {
      objc_setAssociatedObject(self,EmptyDataKey.isSetNavHiddenKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
  }


  public var popGestureDisabled: Bool {
    get {
      return objc_getAssociatedObject(self,EmptyDataKey.PopGestureDisabledKey) as? Bool ?? false
    }
    set {
      objc_setAssociatedObject(self,EmptyDataKey.PopGestureDisabledKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
  }

  var popGes_closure: PopGes_Closure? {
    get {
      return objc_getAssociatedObject(self,EmptyDataKey.popGestureClosureKey) as? PopGes_Closure
    }
    set {
      objc_setAssociatedObject(self,EmptyDataKey.popGestureClosureKey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
    }
  }

  @objc func popGes_viewWillAppear(_ animated: Bool){
    popGes_viewWillAppear(animated)
    popGes_closure?(self,animated)
  }

  @objc func popGes_viewWillDisappear(_ animated: Bool) {
    popGes_viewWillDisappear(animated)
    DispatchQueue.main.asyncAfter(deadline: .now()) {[weak self] in
      guard let base = self,
        let vc = base.navigationController?.viewControllers.last,
        !vc.isSetNavHidden else { return }
      base.navigationController?.setNavigationBarHidden(false, animated: false)
    }
  }

}









