//
//  FileInfoViewController.swift
//  BLDebugTools
//
//  Created by bigl on 2018/1/3.
//

import UIKit
import WebKit

class FileInfoViewController: UIViewController {
  
  let webview = WKWebView()
  let closeBtn = UIButton()
  var fileURL: URL?
  
  init(path: URL) {
    super.init(nibName: nil, bundle: nil)
    fileURL = path
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    buildUI()
  }
  
}

extension FileInfoViewController {

  @objc func closeEvent() {
    dismiss(animated: true, completion: nil)
  }

}

extension FileInfoViewController {

  private func buildUI() {
    view.addSubview(webview)
    view.addSubview(closeBtn)
    buildLayout()
    buildSubview()
  }
  
  private func buildLayout() {
    webview.snp.makeConstraints { (make) in
      make.top.bottom.left.right.equalToSuperview()
    }
    closeBtn.snp.makeConstraints { (make) in
      make.top.right.equalToSuperview()
      make.width.height.equalTo(44)
    }
  }
  
  private func buildSubview() {
    closeBtn.addTarget(self, action: #selector(closeEvent), for: .touchUpInside)
    closeBtn.setTitle("✘", for: .normal)
    closeBtn.setTitleColor(UIColor.black, for: .normal)
    closeBtn.titleLabel?.adjustsFontSizeToFitWidth = true

    guard let url = fileURL else { return }
    if #available(iOS 9.0, *) {
      webview.loadFileURL(url, allowingReadAccessTo: url)
    }
  }
}
