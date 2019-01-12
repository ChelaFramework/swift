//
//  ChHolder.swift
//  Chela
//
//  Created by SeungChul Kang on 2019. 1. 12..
//  Copyright © 2019년 Chela. All rights reserved.
//

import Foundation
import UIKit

//abstract class ChHolder<T>{
//  @JvmField internal var key:String = ""
//  init{
//    @Suppress("LeakingThis")
//    this::class.simpleName?.let{key = it}
//  }
//  abstract fun create(base: ChHolderBase<T>):T
//  open fun push(base: ChHolderBase<T>, isRestore:Boolean){}
//  open fun resume(base: ChHolderBase<T>, isRestore:Boolean){}
//  open fun pause(base: ChHolderBase<T>, isJump:Boolean){}
//  open fun pop(base: ChHolderBase<T>, isJump:Boolean):Boolean = true
//}
protocol ChHolderProtocol {
  associatedtype T
  func create(base: ChHolderBase<T>) -> T
  func push(base: ChHolderBase<T>, isRestore: Bool)
  func resume(base: ChHolderBase<T>, isRestore: Bool)
  func pause(base: ChHolderBase<T>, isJump: Bool)
  func pop(base: ChHolderBase<T>, isJump: Bool)
}
class ChHolder<T: UIView>: ChHolderProtocol {
}

func test() {
  let holder = ChHolder<UIView>.init()
}

//object Main : ChHolder<View>() {
//  override fun create(base: ChHolderBase<View>): View {
//    if(base !is ChGroupBase) throw Exception("invalid holder_alpha:$base")
//    //Splash.model.start()
//    return Ch.scanner.scan(this, base.inflate(R.layout.main)).render()
//  }
//
//}

extension ChHolderProtocol where T: UIView {
  func create(base: ChHolderBase<T>) -> T {
    return UIView.init() as! Self.T
  }
}

extension ChHolderProtocol {
  func push(base: ChHolderBase<T>, isRestore: Bool) {
    
  }
  
  func resume(base: ChHolderBase<T>, isRestore: Bool) {
    
  }
  
  func pause(base: ChHolderBase<T>, isJump: Bool) {
    
  }
  
  func pop(base: ChHolderBase<T>, isJump: Bool) {
    
  }
}


