//
//  FPSLabel.swift
//  BLDebugTools
//
//  Created by bigl on 2017/12/29.
//

import UIKit

open class FPSLabel: UILabel {

  var link: CADisplayLink?
  var lastTime: TimeInterval = 0
  var count = 0.0
  var fps = 0

  override public init(frame: CGRect) {
    super.init(frame: frame)
    buildUI()
  }

  required public init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  deinit {
    link?.invalidate()
    link = nil
  }

}


extension FPSLabel {

  @objc func fps(link: CADisplayLink) {
    if lastTime == 0 {
      lastTime = link.timestamp
      return
    }

    count += 1
    let delta = link.timestamp - lastTime
    if delta < 1 { return }
    lastTime = link.timestamp
    let newFPS = Int((count / delta).rounded())
    count = 0
    if newFPS == fps { return }
    fps = newFPS

    let progress = Double(fps) / 60
    let color = UIColor(hue: CGFloat(0.27 * (progress - 0.2)),
                        saturation: 1,
                        brightness: 0.9,
                        alpha: 1)

    let text = NSMutableAttributedString(string: String(format: "%d FPS", Int(fps)),
                                         attributes: [.foregroundColor : color,
                                                      .font: UIFont.systemFont(ofSize: 14)])
    attributedText = text
  }

}

extension FPSLabel {

  private func buildUI() {

    buildLayout()
    buildSubview()
  }

  private func buildLayout() {

  }

  private func buildSubview() {
    layer.cornerRadius = 5
    clipsToBounds = true
    textAlignment = .center
    isUserInteractionEnabled = false
    backgroundColor = UIColor.darkGray
    link = CADisplayLink(target: self, selector: #selector(fps(link:)))
    link?.add(to: RunLoop.main, forMode: RunLoopMode.commonModes)
  }

}









