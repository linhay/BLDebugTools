//
//  ViewController.swift
//  BLDebugTools
//
//  Created by 158179948@qq.com on 12/29/2017.
//  Copyright (c) 2017 158179948@qq.com. All rights reserved.
//

import UIKit
import BLDebugTools

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    let data = """
      测试文件
      测试文件
      测试文件
      测试文件
      测试文件
      """.data(using: String.Encoding.unicode)
    FileManager.default.createFile(atPath: NSHomeDirectory() + "/Library/test.txt",
                                   contents: data,
                                   attributes: nil)
    DebugWindow.shared.begin()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

}

