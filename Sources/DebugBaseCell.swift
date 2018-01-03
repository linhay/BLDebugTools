//
//  SandboxCell.swift
//  BLDebugTools
//
//  Created by bigl on 2017/12/29.
//

import UIKit
import SnapKit

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

}

extension DebugBaseCell {

  private func buildUI() {
    contentView.addSubview(iconLabel)
    contentView.addSubview(nameLabel)
    buildLayout()
    buildSubview()
  }

  private func buildLayout() {
    iconLabel.snp.makeConstraints { (make) in
      make.width.equalTo(self.iconLabel.snp.height)
      make.left.top.bottom.equalToSuperview()
    }
    nameLabel.snp.makeConstraints { (make) in
      make.top.bottom.right.equalToSuperview()
      make.left.equalTo(self.iconLabel.snp.right)
    }
  }

  private func buildSubview() {
    iconLabel.textAlignment = .center
  }

}
