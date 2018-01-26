//
//  SandboxController.swift
//  BLDebugTools
//
//  Created by bigl on 2017/12/29.
//

import UIKit
import SnapKit
import PopGesture

struct SandFile {
  enum Style: String {
    case folder = "📂"
    case file = "📃"
    case back = "🔙"
    case unknown = "🐔"
  }
  
  var style = Style.unknown
  var type = ""
  var name = ""
  var path = ""
  
  init(path: String,name: String) {
    self.path = path + "/" + name
    self.name = name
    
    if name == "..." {
      style = .back
      return
    }
    
    var isDirectory = ObjCBool(false)
    let exists = FileManager.default.fileExists(atPath: self.path, isDirectory: &isDirectory)
    if  exists {
      style = isDirectory.boolValue ? .folder : .file
    }
  }
}


open class SandboxController: UIViewController {
  
  var path = NSHomeDirectory()
  let cellId = "SandboxCell"
  var filePath = [SandFile]()
  
  static var windowFrame = CGRect.zero
  
  let tableView = UITableView(frame: .zero, style: .grouped)
  
  init() {
    super.init(nibName: nil, bundle: nil)
    DebugWindow.shared.state.style = .big
  }
  
  
  init(path: String) {
    super.init(nibName: nil, bundle: nil)
    self.path = path
    buildItems()
  }
  
  
  required public init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override open func viewDidLoad() {
    super.viewDidLoad()
    isSetNavHidden = true
    buildItems()
    buildUI()
  }
  
  func buildItems() {
    do {
      filePath = try FileManager.default.contentsOfDirectory(atPath: path).map({ (item) -> SandFile in
        return SandFile(path: path, name: item)
      })
      
      let back = SandFile(path: "", name: "...")
      filePath.insert(back, at: 0)
    } catch {
      filePath = [SandFile(path: "", name: "...")]
      DebugAlert.show(message: error.localizedDescription)
    }
  }
  
}


extension SandboxController {
  
  
  private func buildUI() {
    navigationController?.setNavigationBarHidden(true, animated: false)
    view.addSubview(tableView)
    buildLayout()
    buildSubview()
  }
  
  private func buildLayout() {
    tableView.snp.makeConstraints { (make) in
      make.top.left.right.bottom.equalToSuperview()
    }
  }
  
  private func buildSubview() {
    tableView.delegate = self
    tableView.dataSource = self
    tableView.rowHeight = 40
    tableView.register(SandboxCell.self, forCellReuseIdentifier: cellId)
  }
  
  
}

// MARK: - SandboxCellDelegate
extension SandboxController: SandboxCellDelegate {
  
  func sandboxCell(cell: SandboxCell, indexPath: IndexPath, tap event: UITapGestureRecognizer) {
    let item = filePath[indexPath.item]
    switch item.style {
    case .back:
      if navigationController!.viewControllers.count > 1 {
        navigationController?.popViewController(animated: true)
      }else{
        navigationController?.dismiss(animated: true, completion: nil)
        DebugWindow.shared.state.style = .normal
      }
    case .folder:
      guard FileManager.default.isReadableFile(atPath: item.path) else {
        DebugAlert.show(message: "无法读取")
        return
      }
      let vc = SandboxController(path: item.path)
      navigationController?.pushViewController(vc, animated: true)
    case .file:
      guard FileManager.default.isReadableFile(atPath: item.path) else {
        DebugAlert.show(message: "无法读取")
        return
      }
      let url = URL(fileURLWithPath: item.path)
      let vc = FileInfoViewController(path: url)
      present(vc, animated: true, completion: nil)
      break
    case .unknown:
      break
    }
  }
  
  func sandboxCell(cell: SandboxCell, indexPath: IndexPath, long event: UILongPressGestureRecognizer) {
    let item = filePath[indexPath.item]
    guard presentedViewController == nil else { return }
    guard FileManager.default.isReadableFile(atPath: item.path) else {
      DebugAlert.show(message: "无法读取")
      return
    }
    let url = URL(fileURLWithPath: item.path)
    let vc = UIActivityViewController(activityItems: [url], applicationActivities: nil)
    present(vc, animated: true, completion: nil)
  }
  
}


extension SandboxController: UITableViewDelegate,UITableViewDataSource {
  
  open func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return filePath.count
  }
  
  open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let item = filePath[indexPath.item]
    let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as! SandboxCell
    cell.name = item.name
    cell.icon = item.style.rawValue
    cell.indexPath = indexPath
    cell.delegate = self
    return cell
  }
  
  open func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return true
  }
  
  open func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
    return UITableViewCellEditingStyle.delete
  }
  
  open func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      if indexPath.item < filePath.count {
        do{
          try FileManager.default.removeItem(atPath: filePath[indexPath.item].path)
          filePath.remove(at: indexPath.item)
          tableView.deleteRows(at: [indexPath], with: .left)
        }catch {
          DebugAlert.show(message: error.localizedDescription)
        }
      }
    }
  }
  
}
