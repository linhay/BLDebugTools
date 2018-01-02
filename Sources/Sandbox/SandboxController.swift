//
//  SandboxController.swift
//  BLDebugTools
//
//  Created by bigl on 2017/12/29.
//

import UIKit

struct SandFile {
  enum Style: String {
    case folder = "📂"
    case file = "📃"
    case back = "🔙"
    case unknown = "🐔"

    init(name: String){
      if name == "..." {
        self = .back
      }else if name.isEmpty {
        self = .folder
      }
      else {
        self = .file
      }
    }
  }

  var style = Style.unknown
  var type = ""
  var name = ""
  var path = ""

  init(path: String,name: String) {

    let coms = name.components(separatedBy: ".")
    if name == "..." {
      style = .back
    }else if coms.count > 1 {
      type = coms.last!
      style = Style(name: type)
    }else {
      style = Style(name: "")
    }

    self.path = path + "/" + name
    self.name = name
  }
}


open class SandboxController: UITableViewController {

  var path = NSHomeDirectory()
  let cellId = "SandboxCell"
  var filePath = [SandFile]()

  static var windowFrame = CGRect.zero


  public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }

  public override init(style: UITableViewStyle) {
    super.init(style: style)
    if SandboxController.windowFrame == .zero {
      SandboxController.windowFrame = DebugWindow.shared.frame
    }

    DebugWindow.shared.frame = CGRect(x: UIScreen.main.bounds.width * 0.1,
                                      y: UIScreen.main.bounds.height * 0.1,
                                      width: UIScreen.main.bounds.width * 0.8,
                                      height: UIScreen.main.bounds.height * 0.8)
  }

  required public init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override open func viewDidLoad() {
    super.viewDidLoad()
    navigationController?.setNavigationBarHidden(true, animated: false)
    buildUI()
  }

}


extension SandboxController {


  private func buildUI() {
    automaticallyAdjustsScrollViewInsets = false
    buildLayout()
    buildSubview()
  }

  private func buildLayout() {

  }

  private func buildSubview() {
    do {
      filePath = try FileManager.default.contentsOfDirectory(atPath: path).map({ (item) -> SandFile in
        return SandFile(path: path, name: item)
      })

      let back = SandFile(path: "", name: "...")
      filePath.insert(back, at: 0)
    } catch {
      filePath = [SandFile(path: "", name: "...")]
      print(error.localizedDescription)
    }
    if #available(iOS 11.0, *) {
      tableView.contentInsetAdjustmentBehavior = .never
    } 
    tableView.rowHeight = 40
    tableView.separatorStyle = .none
    tableView.register(DebugBaseCell.self, forCellReuseIdentifier: cellId)
  }


}




extension SandboxController {

  open override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  open override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return filePath.count
  }

  open override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let item = filePath[indexPath.item]
    let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as! DebugBaseCell
    cell.name = item.name
    cell.icon = item.style.rawValue
    return cell
  }

  open override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return true
  }

  open override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
    return UITableViewCellEditingStyle.delete
  }

  open override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      if indexPath.item < filePath.count {
        do{
          try FileManager.default.removeItem(atPath: filePath[indexPath.item].path)
          filePath.remove(at: indexPath.item)
          tableView.deleteRows(at: [indexPath], with: .left)
        }catch {
          print(error.localizedDescription)
        }
      }
    }
  }

  open override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let item = filePath[indexPath.item]

    switch item.style {
    case .back:
      if navigationController!.viewControllers.count > 1 {
        navigationController?.popViewController(animated: true)
      }else{
        navigationController?.dismiss(animated: true, completion: nil)
        DebugWindow.shared.frame = SandboxController.windowFrame
      }
    case .folder:
      let vc = SandboxController()
      vc.path = item.path
      navigationController?.pushViewController(vc, animated: true)

    case .file:

      let url = URL(fileURLWithPath: item.path)
      let vc = UIActivityViewController(activityItems: [url], applicationActivities: nil)

      let activities = [UIActivityType.airDrop,
                        UIActivityType.mail,
                        UIActivityType.copyToPasteboard,
                        UIActivityType.postToTwitter,
                        UIActivityType.postToWeibo]

      vc.excludedActivityTypes = activities

      present(vc, animated: true, completion: nil)
      break
    case .unknown:
      break
    }

  }

}
