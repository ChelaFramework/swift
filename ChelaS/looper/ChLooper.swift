//
//  ChLooper.swift
//  Chela
//
//  Created by 배인진 on 15/01/2019.
//  Copyright © 2019 Chela. All rights reserved.
//

import Foundation

typealias ItemBlock = (ChItem)->Void
typealias Now = ()->Double
internal let empty: ItemBlock = {_ in }
internal let now: Now = { Date().timeIntervalSinceNow }
class ChLooper {
  enum Item {
    case Time(ms: Int)
    case Delay(ms: Int)
    case Loop(cnt: Int)
    case Ended(block: (ChItem) -> Void)
    case Infinity
  }

// https://github.com/ChelaFramework/ios/blob/9102f458a50695d04e816313c4f8094febe5c1c5/Empty/MV/ChLooper.m
//  private class Ani: UIView() {
//    init() {
//
//    }
//  }
  
//  private class Ani(ctx: Context, private val looper: ChLooper): View(ctx){
//  init{tag = "CHELA_ANI"}
//  override fun onDraw(canvas: Canvas?){
//  looper.loop()
//  invalidate()
//  }
//  }
  
  class Sequence {
    private let looper: ChLooper
//    internal var item: ChItem
    init(looper: ChLooper) {
      self.looper = looper
    }
  }
  
}
