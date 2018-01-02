//
//  SmallViewController.swift
//  BLDebugTools
//
//  Created by bigl on 2018/1/2.
//

import UIKit

protocol SmallVCDelegate: NSObjectProtocol {
  func smallvc(tapToBig event: SmallViewController)
  func smallvc(panForMove event: SmallViewController,ges: UIPanGestureRecognizer)
}

class SmallViewController: UIViewController {

  weak var delegate: SmallVCDelegate?

  let fpsLabel = FPSLabel()

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UIColor.clear
    view.addSubview(fpsLabel)
    let pan = UIPanGestureRecognizer(target: self, action: #selector(panEvent(ges:)))
    view.addGestureRecognizer(pan)

    let tap = UITapGestureRecognizer(target: self, action: #selector(tapEvent(ges:)))
    view.addGestureRecognizer(tap)

  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    fpsLabel.frame = view.frame
  }

  @objc func tapEvent(ges: UITapGestureRecognizer) {
    delegate?.smallvc(tapToBig: self)
  }


  @objc func panEvent(ges: UIPanGestureRecognizer) {
    delegate?.smallvc(panForMove: self, ges: ges)
  }

}
