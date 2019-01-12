//
//  ChViewBase.swift
//  Chela
//
//  Created by SeungChul Kang on 2019. 1. 12..
//  Copyright © 2019년 Chela. All rights reserved.
//

import UIKit

class ChViewBase: ChHolderBase<UIView> {
  var view: UIView!
  func view(it: UIView) {
    view = it
    view.subviews.forEach { $0.removeFromSuperview() }
    restore()
  }
  override func push<H>(_ holder: H) where UIView == H.T, H: ChHolder {
    view.addSubview(holder.create(base: self))
  }
  override func pop<H>(_ holder: H) where UIView == H.T, H: ChHolder {
    view.subviews.last?.removeFromSuperview()
  }
  
}
