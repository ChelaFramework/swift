//
//  ChBase.swift
//  Chela
//
//  Created by SeungChul Kang on 2019. 1. 12..
//  Copyright © 2019년 Chela. All rights reserved.
//

import Foundation

//abstract class ChHolderBase<T>{
//  internal lateinit var router: ChRouter<T>
//  internal fun _push(holder: ChHolder<T>, isRestore:Boolean){
//  push(holder)
//  holder.push(this, isRestore)
//  _resume(holder, isRestore)
//  }
//  internal fun _pop(holder: ChHolder<T>, isJump:Boolean){
//  _pause(holder, isJump)
//  if(holder.pop(this, isJump)) pop(holder)
//  }
//  internal fun _pause(holder: ChHolder<T>, isJump:Boolean){
//  pause(holder)
//  holder.pause(this, isJump)
//  }
//  internal fun _resume(holder: ChHolder<T>, isRestore:Boolean){
//  resume(holder)
//  holder.resume(this, isRestore)
//  }
//  protected fun restore(){router.restore()}
//  protected open fun push(holder: ChHolder<T>){}
//  open fun pop(holder: ChHolder<T>){}
//  protected open fun pause(holder: ChHolder<T>){}
//  protected open fun resume(holder: ChHolder<T>){}
//}

protocol ChHolderBaseProtocol {
  associatedtype T
//  func _push(holder: ChHolder<T>)
}

extension ChHolderBaseProtocol {
//  func _push(holder: ChHolder<T>) {
//
//  }
}

class ChHolderBase<T> {

  init() { }
  func _push<H: ChHolder>(_ holder: H, _ isRestore: Bool) where H.T == T {
    push(holder: holder)
    holder.push(base: self, isRestore: isRestore)
    _resume(holder, isRestore)
  }
  
  func _pop<H: ChHolder>(_ holder: H, _ isJump: Bool) where H.T == T {
    
  }
  
  func _pause<H: ChHolder>(_ holder: H, _ isJump: Bool) where H.T == T {
    
  }
  
  func _resume<H: ChHolder>(_ holder: H, _ isRestore: Bool) where H.T == T {
    
  }
  
  fileprivate func restore() {
    
  }
  fileprivate func push<H: ChHolder>(holder: H) where H.T == T {}
  func pop<H: ChHolder>(holder: H) where H.T == T {}
  fileprivate func pause<H: ChHolder>(holder: H) where H.T == T {}
  fileprivate func resume<H: ChHolder>(holder: H) where H.T == T {}
}

