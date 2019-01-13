//
//  ChHolder.swift
//  Chela
//
//  Created by SeungChul Kang on 2019. 1. 12..
//  Copyright © 2019년 Chela. All rights reserved.
//

import Foundation

protocol ChHolder: class {
  associatedtype T
  func create(base: ChHolderBase<T>) -> T
  func push(_ base: ChHolderBase<T>, _ isRestore: Bool)
  func resume(_ base: ChHolderBase<T>, _ isRestore: Bool)
  func pause(_ base: ChHolderBase<T>, _ isJump: Bool)
  func pop(_ base: ChHolderBase<T>, _ isJump: Bool) -> Bool
}

class ChHolderBase<T> {
//  var router: ChRouter<T>!
  func _push<H>(_ holder: H, _ isRestore: Bool) where H.T == T, H: ChHolder {
    push(holder)
    holder.push(self, isRestore)
    _resume(holder, isRestore)
  }

  func _pop<H>(_ holder: H, _ isJump: Bool) where H.T == T, H: ChHolder {
    _pause(holder, isJump)
    if holder.pop(self, isJump) {
      pop(holder)
    }
  }

  func _pause<H>(_ holder: H, _ isJump: Bool) where H.T == T, H: ChHolder {
    pause(holder)
    holder.pause(self, isJump)
  }

  func _resume<H>(_ holder: H, _ isRestore: Bool) where H.T == T, H: ChHolder {
    resume(holder)
    holder.resume(self, isRestore)
  }

  func restore() {
//    router.restore()
  }
  func push<H>(_ holder: H)   where H.T == T, H: ChHolder {}
  func pop<H>(_ holder: H)    where H.T == T, H: ChHolder {}
  func pause<H>(_ holder: H)  where H.T == T, H: ChHolder {}
  func resume<H>(_ holder: H) where H.T == T, H: ChHolder {}
}

