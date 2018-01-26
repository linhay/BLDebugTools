//
//  PopGesture.swift
//  Pods-PopGesture_Example
//
//  Created by linhey on 2018/1/17.
//

import UIKit

typealias PopGes_Closure = ((_ vc: UIViewController,_ animated: Bool) -> ())

struct RunTime {
  /// 交换方法
  ///
  /// - Parameters:
  ///   - selector: 被交换的方法
  ///   - replace: 用于交换的方法
  ///   - classType: 所属类型
  static func exchangeMethod(selector: Selector,
                             replace: Selector,
                             class classType: AnyClass) {
    let select1 = selector
    let select2 = replace
    let select1Method = class_getInstanceMethod(classType, select1)
    let select2Method = class_getInstanceMethod(classType, select2)
    let didAddMethod  = class_addMethod(classType,
                                        select1,
                                        method_getImplementation(select2Method!),
                                        method_getTypeEncoding(select2Method!))
    if didAddMethod {
      class_replaceMethod(classType,
                          select2,
                          method_getImplementation(select1Method!),
                          method_getTypeEncoding(select1Method!))
    }else {
      method_exchangeImplementations(select1Method!, select2Method!)
    }
  }
}


public class PopGesture {

 static var once = false
  
  public class func begin() {
    if once { return }
    once = true
    RunTime.exchangeMethod(selector: #selector(UIViewController.viewWillAppear(_:)),
                           replace: #selector(UIViewController.popGes_viewWillAppear(_:)),
                           class: UIViewController.self)

    RunTime.exchangeMethod(selector: #selector(UIViewController.viewWillDisappear(_:)),
                           replace: #selector(UIViewController.popGes_viewWillDisappear(_:)),
                           class: UIViewController.self)
    
    RunTime.exchangeMethod(selector: #selector(UINavigationController.pushViewController(_:animated:)),
                           replace: #selector(UINavigationController.popGes_pushViewController(_:animated:)),
                           class: UINavigationController.self)
  }
  
}
