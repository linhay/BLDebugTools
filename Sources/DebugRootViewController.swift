//
//  DebugRootViewController.swift
//  BLDebugTools
//
//  Created by bigl on 2017/12/29.
//

import UIKit

class DebugRootViewController: UIViewController {

  let normalSize = CGSize(width: 100, height: 100)

  public enum State: Int {
    case normal
    case spreads
  }

  
  let fpsLabel = FPSLabel()
  public var state = State.normal
  public var point = CGPoint.zero


  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UIColor.clear
    view.addSubview(fpsLabel)
    let pan = UIPanGestureRecognizer(target: self, action: #selector(panEvent(ges:)))
    view.addGestureRecognizer(pan)

    let tap = UITapGestureRecognizer(target: self, action: #selector(tapEvent(ges:)))
    view.addGestureRecognizer(tap)
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)


  }

  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    fpsLabel.frame = view.frame
  }

  @objc func tapEvent(ges: UITapGestureRecognizer) {
    state = State(rawValue: state.rawValue == 0 ? 1 : 0)!
    switch state {
    case .normal:
      let newFrame = CGRect(origin: point, size: normalSize)
      DebugWindow.shared.frame = newFrame
    case .spreads:
      let minValue = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height) * 0.8
      let center = CGPoint(x: (UIScreen.main.bounds.width - minValue) * 0.5,
                       y: 50)
      let newFrame = CGRect(origin: center,size: CGSize(width: minValue, height: minValue))
      DebugWindow.shared.frame = newFrame

      let vc = UINavigationController(rootViewController: SandboxController())
      vc.modalPresentationStyle = .overFullScreen
      vc.modalTransitionStyle = .crossDissolve
      present(vc,animated: true, completion: nil)
    }
  }


  @objc func panEvent(ges: UIPanGestureRecognizer) {
    if state == .spreads { return }
    let centerPoint = ges.location(in: UIApplication.shared.keyWindow)
    point = CGPoint(x: centerPoint.x - DebugWindow.shared.frame.width * 0.5,
                    y: centerPoint.y - DebugWindow.shared.frame.height * 0.5)
    DebugWindow.shared.frame.origin = point
  }
}
