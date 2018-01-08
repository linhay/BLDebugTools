//
//  DebugWindow.swift
//  BLDebugTools
//
//  Created by bigl on 2017/12/29.
//

import UIKit

open class DebugWindow: UIWindow {

  public static let shared = DebugWindow(frame: CGRect(x: 20, y: 40, width: 60, height: 60))


  struct DebugWindowState {
    var style = DebugWindowStyle.small
    var point = CGPoint.zero
  }


  enum DebugWindowStyle {
    case small
    case normal
    case big

    var size: CGSize {
      switch self {
      case .small:
        return CGSize(width: 60, height: 60)
      case .normal:
        let wh = UIScreen.main.bounds.width * 0.8
        return CGSize(width: wh, height: wh)
      case .big:
        let bounds = UIScreen.main.bounds
        return CGSize(width: bounds.width * 0.8, height: bounds.height * 0.8)
      }
    }
  }


  var state = DebugWindowState(){
    didSet{
      DebugWindow.shared.frame.size = state.style.size
      switch state.style {
      case .small:
        DebugWindow.shared.frame.origin = state.point
      default:
        let x = (UIScreen.main.bounds.width - DebugWindow.shared.bounds.width) * 0.5
        DebugWindow.shared.frame.origin = CGPoint(x: x, y: 88)
      }
    }
  }


  public func begin() {
    rootViewController = DebugRootViewController()
    DebugWindow.shared.windowLevel = 10
    DebugWindow.shared.layer.borderWidth = 1
    DebugWindow.shared.layer.borderColor = UIColor.black.cgColor.copy(alpha: 0.8)
    DebugWindow.shared.layer.cornerRadius = 10
    DebugWindow.shared.layer.masksToBounds = true
    DebugWindow.shared.makeKeyAndVisible()
  }

}
