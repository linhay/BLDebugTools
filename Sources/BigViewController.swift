//
//  BigViewController.swift
//  BLDebugTools
//
//  Created by bigl on 2018/1/2.
//

import UIKit
protocol BigVCDelegate: NSObjectProtocol {
  func bigvc(tapToSmall event: BigViewController)
}

class BigViewController: UIViewController {

  weak var delegate: BigVCDelegate?

  let tableView = UITableView(frame: .zero, style: .grouped)

  override func viewDidLoad() {
    super.viewDidLoad()
    navigationController?.setNavigationBarHidden(true, animated: false)
    view.addSubview(tableView)
    tableView.frame = view.bounds
    tableView.delegate = self
    tableView.dataSource = self
    if #available(iOS 11.0, *) {
      tableView.contentInsetAdjustmentBehavior = .never
    }
    tableView.register(DebugBaseCell.self, forCellReuseIdentifier: "cellId")
  }

}

extension BigViewController: UITableViewDataSource,UITableViewDelegate {

  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 6
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    var cell = tableView.dequeueReusableCell(withIdentifier: "cellId") as! DebugBaseCell
    cell.name = "沙盒文件管理"
    return cell
  }
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    delegate?.bigvc(tapToSmall: self)
  }

}







