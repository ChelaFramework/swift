//
//  ChRouter.swift
//  Chela
//
//  Created by SeungChul Kang on 2019. 1. 12..
//  Copyright © 2019년 Chela. All rights reserved.
//

import Foundation
import UIKit

class ChRouter<H, T> where H.T == T, H: ChHolder {
  private let base: ChHolderBase<T>
  private var stack = [H]()
  private var pushLock = false
  private var popLock = false
  init(of: H.Type, base: ChHolderBase<T>) {
    self.base = base
    // TODO: self.base.router = self
  }
  func restore() {
    stack.forEach { it in
      base._push(it, true)
    }
  }

  func unlockPush() {
    if pushLock { pushLock = false }
  }
  func unlockPop() {
    if popLock { popLock = false }
  }
  func push(holder: H, _ isAutoUnlock: Bool = true) {
    guard !pushLock else { return }
    if !isAutoUnlock { pushLock = true }
    if let last = stack.last {
      base._pause(last, false)
    }
    base._push(holder, false)
    stack.append(holder)
  }
  @discardableResult
  func pop(_ isAutoUnlock: Bool = true) -> Int {
    guard !popLock else { return -1 }
    if !isAutoUnlock { popLock = true }

    if let last = stack.last {
      base._pop(last, false)
      stack.removeLast()
      if let last = stack.last {
        base._resume(last, false)
      }
      return stack.count
    } else {
        return 0
    }
  }
  func jump(holder: H) {
    for i in (stack.count - 1)...0 {
      if stack[i] === holder {
        base._resume(holder, false)
        break
      } else {
        base._pop(holder, true)
      }
    }
  }
}
