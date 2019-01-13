//
//  ChViewBase.swift
//  Chela
//
//  Created by SeungChul Kang on 2019. 1. 12..
//  Copyright © 2019년 Chela. All rights reserved.
//

import UIKit

class ChViewHolder: ChHolder {
  typealias T = UIView
  func create(base: ChHolderBase<T>) -> T { return T.init() }
  func push(_ base: ChHolderBase<T>, _ isRestore: Bool) {}
  func resume(_ base: ChHolderBase<T>, _ isRestore: Bool) {}
  func pause(_ base: ChHolderBase<T>, _ isJump: Bool) {}
  func pop(_ base: ChHolderBase<T>, _ isJump: Bool) -> Bool { return true }
}

class ChViewBase: ChHolderBase<UIView> {
  var view: UIView!
  func view(_ v: UIView) {
    view = v
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
