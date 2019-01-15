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
  final func create(base: ChHolderBase<T>) -> T { return T.init() }
  final func push(_ base: ChHolderBase<T>, _ isRestore: Bool) {
    if let vBase = base as? ChViewBase {
      push(vBase, isRestore)
    }
  }
  final func resume(_ base: ChHolderBase<T>, _ isRestore: Bool) {
    if let vBase = base as? ChViewBase {
      resume(vBase, isRestore)
    }
  }
  final func pause(_ base: ChHolderBase<T>, _ isJump: Bool) {
    if let vBase = base as? ChViewBase {
      pause(vBase, isJump)
    }
  }
  final func pop(_ base: ChHolderBase<T>, _ isJump: Bool) -> Bool {
    if let vBase = base as? ChViewBase {
      return pop(vBase, isJump)
    }
    return true
  }

  func create(base: ChViewBase) -> UIView { return UIView.init() }
  func push(_ base: ChViewBase, _ isRestore: Bool) {}
  func resume(_ base: ChViewBase, _ isRestore: Bool) {}
  func pause(_ base: ChViewBase, _ isJump: Bool) {}
  func pop(_ base: ChViewBase, _ isJump: Bool) -> Bool { return true }

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
