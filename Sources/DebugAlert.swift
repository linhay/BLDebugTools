//
//  DebugAlert.swift
//  BLDebugTools
//
//  Created by bigl on 2018/1/3.
//

import UIKit

struct DebugAlert {

  static func show(message: String,time: TimeInterval = 2.0){
    let alert = UIAlertController(title: message,
                                  message: nil,
                                  preferredStyle: UIAlertControllerStyle.alert)

    guard let rootVC = DebugWindow.shared.rootViewController else { return }

    if let vc = rootVC.presentedViewController {
      vc.present(alert, animated: true, completion: nil)
    }else{
      rootVC.present(alert, animated: true, completion: nil)
    }

    let time = DispatchTime.now() + .milliseconds(Int(time * 1000))
    DispatchQueue.main.asyncAfter(deadline: time) {
      alert.dismiss(animated: true, completion: nil)
    }
  }
  
}
