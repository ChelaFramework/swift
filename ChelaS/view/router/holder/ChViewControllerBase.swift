//
//  ChViewControllerBase.swift
//  Chela
//
//  Created by Taehyeon Jake Lee on 12/01/2019.
//  Copyright © 2019 Chela. All rights reserved.
//

import UIKit

class ChViewControllerHolder: ChHolder {
  typealias T = UIViewController
  func create(base: ChHolderBase<T>) -> T { return T.init() }
  func push(_ base: ChHolderBase<T>, _ isRestore: Bool) {}
  func resume(_ base: ChHolderBase<T>, _ isRestore: Bool) {}
  func pause(_ base: ChHolderBase<T>, _ isJump: Bool) {}
  func pop(_ base: ChHolderBase<T>, _ isJump: Bool) -> Bool { return true }
}

class ChViewControllerBase: ChHolderBase<UIViewController> {
  var viewController: UIViewController!
  func viewController(_ vc: UIViewController) {
    viewController = vc
    viewController.children.forEach { $0.removeFromParent() }
    restore()
  }
  override func push<H>(_ holder: H) where UIViewController == H.T, H: ChHolder {
    viewController.addChild(holder.create(base: self))
  }
  override func pop<H>(_ holder: H) where UIViewController == H.T, H: ChHolder {
    viewController.children.last?.removeFromParent()
  }

}
