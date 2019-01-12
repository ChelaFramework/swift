//
//  ChGroupBase.swift
//  Chela
//
//  Created by SeungChul Kang on 2019. 1. 12..
//  Copyright © 2019년 Chela. All rights reserved.
//

import Foundation
import UIKit

class ChGroupBase: ChHolderBase<UIView> {
  var group: UIView!
  func group(it: UIView) {
    group = it
    group.subviews.forEach { $0.removeFromSuperview() }
    restore()
  }
  override func push<H>(_ holder: H) where UIView == H.T, H: ChHolder {
    group.addSubview(holder.create(base: self))
  }
  override func pop<H>(_ holder: H) where UIView == H.T, H: ChHolder {
    group.subviews.last?.removeFromSuperview()
  }
  
}
