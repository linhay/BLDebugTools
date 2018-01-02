//
//  SandboxCell.swift
//  BLDebugTools
//
//  Created by bigl on 2017/12/29.
//

import UIKit

class DebugBaseCell: UITableViewCell {

  var name: String = "" {
    didSet{
      nameLabel.text = name
    }
  }

  var icon: String = "" {
    didSet{
      iconLabel.text = icon
    }
  }

  private let iconLabel = UILabel()
  private let nameLabel = UILabel()

  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    selectionStyle = .none
    buildUI()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    iconLabel.frame = CGRect(x: 0,
                             y: 0,
                             width: bounds.height,
                             height: bounds.height)
    nameLabel.frame = CGRect(x: bounds.height,
                             y: 0,
                             width: bounds.width - bounds.height,
                             height: bounds.height)
  }

}

extension DebugBaseCell {

  private func buildUI() {
    contentView.addSubview(iconLabel)
    contentView.addSubview(nameLabel)
    buildLayout()
  }

  private func buildLayout() {
    iconLabel.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
    nameLabel.frame = CGRect(x: 40, y: 0, width: 400, height: 40)
  }
}
