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
    DebugWindow.shared.state.style = .normal
    view.addSubview(big.view)
  }

  func smallvc(panForMove event: SmallViewController, ges: UIPanGestureRecognizer) {
    let centerPoint = ges.location(in: UIApplication.shared.keyWindow)
    var x = max(0, centerPoint.x - DebugWindow.shared.frame.width * 0.5)

    if centerPoint.x + DebugWindow.shared.frame.width > UIScreen.main.bounds.width {
      x = UIScreen.main.bounds.width - DebugWindow.shared.frame.width
    }

    var y = max(0, centerPoint.y - DebugWindow.shared.frame.height * 0.5)

    if centerPoint.y + DebugWindow.shared.frame.height > UIScreen.main.bounds.height {
      y = UIScreen.main.bounds.height - DebugWindow.shared.frame.height
    }

    smallPoint = CGPoint(x: x, y: y)
    DebugWindow.shared.state.point = smallPoint
  }

  func bigvc(tapToSmall event: BigViewController) {
    view.subviews.forEach { (item) in
      item.removeFromSuperview()
    }
    DebugWindow.shared.state.style = .small
    view.addSubview(small.view)
  }

}
