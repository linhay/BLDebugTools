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
      DebugWindow.shared.begin()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

