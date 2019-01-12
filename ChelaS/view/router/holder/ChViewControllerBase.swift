//
//  ChViewControllerBase.swift
//  Chela
//
//  Created by Taehyeon Jake Lee on 12/01/2019.
//  Copyright © 2019 Chela. All rights reserved.
//

import UIKit

class ChViewControllerBase: ChHolderBase<UIViewController> {
  var viewController: UIViewController!
  func viewController(it: UIViewController) {
    viewController = it
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
