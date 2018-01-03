//
//  SandboxCell.swift
//  BLDebugTools
//
//  Created by bigl on 2018/1/3.
//

import UIKit
import SnapKit

protocol SandboxCellDelegate: NSObjectProtocol {

  func sandboxCell(cell: SandboxCell,
                   indexPath: IndexPath,
                   long event: UILongPressGestureRecognizer)
  func sandboxCell(cell: SandboxCell,
                   indexPath: IndexPath,
                   tap event: UITapGestureRecognizer)

}

class SandboxCell: UITableViewCell {

  weak var delegate: SandboxCellDelegate?

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

  var url = ""

  var indexPath = IndexPath(item: 0, section: 0)

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


extension SandboxCell {

  @objc func longEvent(ges: UILongPressGestureRecognizer) {
    delegate?.sandboxCell(cell: self, indexPath: indexPath, long: ges)
  }

  @objc func tapEvent(ges: UITapGestureRecognizer) {
    delegate?.sandboxCell(cell: self, indexPath: indexPath, tap: ges)
  }

}


extension SandboxCell {

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
    let long = UILongPressGestureRecognizer(target: self, action: #selector(longEvent(ges:)))
    contentView.addGestureRecognizer(long)

    let tap = UITapGestureRecognizer(target: self, action: #selector(tapEvent(ges:)))
    contentView.addGestureRecognizer(tap)
  }

}


