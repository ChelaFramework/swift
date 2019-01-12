//
//  ChRouter.swift
//  Chela
//
//  Created by SeungChul Kang on 2019. 1. 12..
//  Copyright © 2019년 Chela. All rights reserved.
//

import Foundation
import UIKit

class ChRouter<T, H: ChHolder> where H.T == T {
  let base: ChHolderBase<T>
  private var stack = [H]()
  private var pushLock = false
  private var popLock = false
  init(base: ChHolderBase<T>) {
    self.base = base
    // TODO: self.base.router = self
  }
  func restore() {
//    stack.forEach { it in
////      base._push(holder: it)
//    }
  }
  func push(holder: H) {
    stack.append(holder)
  }
}



class ChGroup : ChHolderBase<UIView> {

}

func test42423423() {
//  let router = ChRouter.init(base: ChGroup.init())
//  router.push(holder: Sample.init())
}
