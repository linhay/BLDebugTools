//
//  SmallViewController.swift
//  BLDebugTools
//
//  Created by bigl on 2018/1/2.
//

import UIKit
import SnapKit

protocol SmallVCDelegate: NSObjectProtocol {
  func smallvc(tapToBig event: SmallViewController)
  func smallvc(panForMove event: SmallViewController,ges: UIPanGestureRecognizer)
}

class SmallViewController: UIViewController {

  weak var delegate: SmallVCDelegate?

  let fpsLabel = FPSLabel()

  override func viewDidLoad() {
    super.viewDidLoad()
    buildUI()
  }
}

// MARK: - buildUI
extension SmallViewController {

  private func buildUI() {
    view.backgroundColor = UIColor.darkGray
    view.addSubview(fpsLabel)
    buildLayout()
    buildSubview()
  }

  private func buildLayout() {
    fpsLabel.snp.makeConstraints { (make) in
      make.top.bottom.equalToSuperview()
      make.right.equalToSuperview().offset(-5)
      make.left.equalToSuperview().offset(5)
    }
  }

  private func buildSubview() {
    let pan = UIPanGestureRecognizer(target: self, action: #selector(panEvent(ges:)))
    view.addGestureRecognizer(pan)

    let tap = UITapGestureRecognizer(target: self, action: #selector(tapEvent(ges:)))
    view.addGestureRecognizer(tap)
  }
}

// MARK: - Delegate Event
extension SmallViewController {

  @objc func tapEvent(ges: UITapGestureRecognizer) {
    delegate?.smallvc(tapToBig: self)
  }


  @objc func panEvent(ges: UIPanGestureRecognizer) {
    delegate?.smallvc(panForMove: self, ges: ges)
  }

}


