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

  struct CellItem {
    var name = ""
    var icon = ""
    var block: (()->())? = nil
  }

  var items = [CellItem]()

  weak var delegate: BigVCDelegate?

  let tableView = UITableView(frame: .zero, style: .grouped)
  let cellID = "cellID"

  override func viewDidLoad() {
    super.viewDidLoad()
    buildItems()
    buildUI()
  }


  func buildItems() {
    items.append(CellItem(name: "...", icon: "🔙", block: {
      self.delegate?.bigvc(tapToSmall: self)
    }))

    items.append(CellItem(name: "沙盒文件管理", icon: "📂", block: {
      let vc = UINavigationController(rootViewController: SandboxController())
      self.present(vc, animated: true, completion: nil)
    }))
  }

}

extension BigViewController {

  private func buildUI() {
    navigationController?.setNavigationBarHidden(true, animated: false)
    view.addSubview(tableView)
    buildLayout()
    buildSubview()
  }

  private func buildLayout() {
    tableView.snp.makeConstraints { (make) in
      make.top.bottom.left.right.equalToSuperview()
    }
  }

  private func buildSubview() {
    tableView.delegate = self
    tableView.dataSource = self
    tableView.rowHeight = 40
    if #available(iOS 11.0, *) {
      tableView.contentInsetAdjustmentBehavior = .never
    }
    tableView.register(DebugBaseCell.self, forCellReuseIdentifier: cellID)
  }

}

extension BigViewController: UITableViewDataSource,UITableViewDelegate {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return items.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as! DebugBaseCell
    cell.name = items[indexPath.item].name
    cell.icon = items[indexPath.item].icon
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    items[indexPath.item].block?()
  }

}







