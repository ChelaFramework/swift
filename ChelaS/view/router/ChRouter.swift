//
//  ChRouter.swift
//  Chela
//
//  Created by SeungChul Kang on 2019. 1. 12..
//  Copyright © 2019년 Chela. All rights reserved.
//

import Foundation

class ChRouter<T> {
  private let base: ChHolderBase<T>
//  private var stack = [ChHolder<T>]()
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
}
