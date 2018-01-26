//
//  PopGesture+ScrollView.swift
//  Pods-PopGesture_Example
//
//  Created by linhey on 2018/1/18.
//

import UIKit

extension UIScrollView: UIGestureRecognizerDelegate {

  public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
    if contentOffset.x <= 0 { return otherGestureRecognizer.delegate is PopGestureRecognizerDelegate }
    return false
  }

}
