//
//  SandboxCell.swift
//  BLDebugTools
//
//  Created by bigl on 2017/12/29.
//

import UIKit

class SandboxCell: UITableViewCell {

  let icon = UILabel()
  let name = UILabel()

  let url = ""


  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    selectionStyle = .none
    buildUI()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}

extension SandboxCell {

  private func buildUI() {
    contentView.addSubview(icon)
    contentView.addSubview(name)
    buildLayout()
    buildSubview()
  }

  private func buildLayout() {

    icon.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
    name.frame = CGRect(x: 40, y: 0, width: 400, height: 40)

//    let iconLay0 = NSLayoutConstraint(item: icon, attribute: .left, relatedBy: .equal,
//                                      toItem: contentView,
//                                      attribute: .left,multiplier: 1,constant: 0)
//    let iconLay1 = NSLayoutConstraint(item: icon, attribute: .height, relatedBy: .equal,
//                                      toItem: icon,
//                                      attribute: .width,multiplier: 1,constant: 0)
//    let iconLay2 = NSLayoutConstraint(item: icon, attribute: .top, relatedBy: .equal,
//                                      toItem: contentView,
//                                      attribute: .top,multiplier: 1,constant: 0)
//    let iconLay3 = NSLayoutConstraint(item: icon, attribute: .bottom, relatedBy: .equal,
//                                      toItem: contentView,
//                                      attribute: .bottom,multiplier: 1,constant: 0)
//    icon.addConstraints([iconLay0,iconLay1,iconLay2,iconLay3])
//
//    let name0 = NSLayoutConstraint(item: name, attribute: .left, relatedBy: .equal,
//                                      toItem: icon,
//                                      attribute: .right,multiplier: 1,constant: 0)
//    let name2 = NSLayoutConstraint(item: name, attribute: .top, relatedBy: .equal,
//                                      toItem: contentView,
//                                      attribute: .top,multiplier: 1,constant: 0)
//    let name3 = NSLayoutConstraint(item: name, attribute: .bottom, relatedBy: .equal,
//                                      toItem: contentView,
//                                      attribute: .bottom,multiplier: 1,constant: 0)
//    name.addConstraints([name0,name2,name3])
  }

  private func buildSubview() {
    name.text = "2222"
  }
}
