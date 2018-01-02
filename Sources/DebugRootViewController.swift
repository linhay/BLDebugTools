//
//  DebugRootViewController.swift
//  BLDebugTools
//
//  Created by bigl on 2017/12/29.
//

import UIKit

class DebugRootViewController: UIViewController {

  let big = BigViewController()
  let small = SmallViewController()

  var smallPoint = CGPoint.zero

  override func viewDidLoad() {
    super.viewDidLoad()
    big.delegate = self
    small.delegate = self

    addChildViewController(small)
    addChildViewController(big)
    view.addSubview(small.view)
  }
 
}

extension DebugRootViewController: BigVCDelegate,SmallVCDelegate {
  func smallvc(tapToBig event: SmallViewController) {
    view.subviews.forEach { (item) in
      item.removeFromSuperview()
    }
    DebugWindow.shared.frame = CGRect(x: UIScreen.main.bounds.width * 0.1,
                                      y: 88,
                                      width: UIScreen.main.bounds.width * 0.8,
                                      height: UIScreen.main.bounds.width * 0.8)
    view.addSubview(big.view)
  }

  func smallvc(panForMove event: SmallViewController, ges: UIPanGestureRecognizer) {
    let centerPoint = ges.location(in: UIApplication.shared.keyWindow)
  smallPoint = CGPoint(x: centerPoint.x - DebugWindow.shared.frame.width * 0.5,
                    y: centerPoint.y - DebugWindow.shared.frame.height * 0.5)
    DebugWindow.shared.frame.origin = smallPoint
  }

  func bigvc(tapToSmall event: BigViewController) {
    view.subviews.forEach { (item) in
      item.removeFromSuperview()
    }

    DebugWindow.shared.frame = CGRect(x: smallPoint.x,
                                      y: smallPoint.y,
                                      width: 100,
                                      height: 100)
    view.addSubview(small.view)
  }

}
