//
//  DebugWindow.swift
//  BLDebugTools
//
//  Created by bigl on 2017/12/29.
//

import UIKit

open class DebugWindow: UIWindow {

  public static let shared = DebugWindow(frame: CGRect(x: 20, y: 40, width: 100, height: 100))

  public func begin() {
    rootViewController = DebugRootViewController()
    DebugWindow.shared.windowLevel = 10
    DebugWindow.shared.layer.cornerRadius = 5
    DebugWindow.shared.clipsToBounds = true
    DebugWindow.shared.makeKeyAndVisible()
  }

}
