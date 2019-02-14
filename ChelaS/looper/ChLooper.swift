//
//  ChLooper.swift
//  Chela
//
//  Created by 배인진 on 15/01/2019.
//  Copyright © 2019 Chela. All rights reserved.
//

import Foundation
import UIKit

typealias ItemBlock = (ChItem)->Void
typealias Now = ()->Double
let empty: ItemBlock = {_ in }
let now: Now = { Date().timeIntervalSinceNow }
class ChLooper: UIView {
  enum Item {
    case Time(ms: Int)
    case Delay(ms: Int)
    case Loop(cnt: Int)
    case Ended(block: (ChItem) -> Void)
    case Infinity
  }

  override func draw(_ rect: CGRect) {

  }

  private class Ani {
    let looper = ChLooper()
  }

  private var sequence: Sequence {
    return Sequence(looper: self)
  }
  private var fps        = 0.0
  private var previus    = 0.0
  private var pauseStart = 0.0
  private var pausedTime = 0.0
  private var items    = [ChItem]()
  private var remove   = [ChItem]()
  private var add      = [ChItem]()
  private var itemPool = [ChItem]()

  func loop() {
    let c = now()
    let gap = c - previus
    if gap > 0.0 {
      fps = 1000.0 / gap
    }
    previus = c
    guard !items.isEmpty else { return }
    remove.removeAll()
    add.removeAll()

    var i = 0
    while i < items.count {
      let item = items[i]
      i += 1
      if item.isPaused || item.start > c {
        break
      }
      item.isTurn = false
      var isEnd = false
      item.rate = {
        if !item.isInfinity && item.end <= c {
          item.loop -= 1
          if item.loop == 0 {
            isEnd = true
            return 1.0
          } else {
            item.isTurn = true
            item.start = c
            item.end = c + item.term
            return 0.0
          }
        } else if item.term == 0.0 {
          return 0.0
        } else {
          return (c - item.start) / item.term
        }
      }()
      item.current = c
      item.isStop = false
      item.block(item)
      if item.isStop || isEnd {
        item.ended(item)
        if let n = item.next {
          n.start += c
          n.end = n.start + n.term
          add.append(n)
        }
        remove.append(item)
      }
    }

    if !remove.isEmpty || !add.isEmpty {

      if !remove.isEmpty {
        items = items.filter { v in
          remove.contains(where: { $0 === v })
        }
        itemPool = itemPool + remove
      }
      if !add.isEmpty {
        items = items + add
      }

    }

  }
  func invoke(param: Item..., block: ItemBlock = empty) -> Sequence {
    return Sequence(looper: self)
  }

  func getItem(param: Item..., block: ItemBlock = empty) -> ChItem {
    var item: ChItem! = itemPool.removeLast()

    if item == nil {
      item = ChItem()
    }

    return item
  }
// https://github.com/ChelaFramework/ios/blob/9102f458a50695d04e816313c4f8094febe5c1c5/Empty/MV/ChLooper.m

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
