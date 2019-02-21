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

fileprivate let concurrentQueue = DispatchQueue(
    label: "com.chela.lopper.queue",
    attributes: .concurrent
)

func testaaaaa123123() {
  ChLooper { dsl in
    dsl.time = 350
    dsl.block = { item in
//      item.backIn(from: <#T##Double#>, to: <#T##Double#>)
    }
  } + { dsl in
  }
}

class ItemDSL {
  var time: Int = -1
  var delay: Int = 0
  var loop: Int = 1
  var block: ItemBlock = empty
  var ended: ItemBlock = empty
  var isInfinity: Bool = false
}

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

  var ref: ChLooper?

  convenience init (_ block: (ItemDSL) -> Void) {
    self.init()
    let i = ItemDSL()
    block(i)
  }

  @discardableResult
  static func + (lhs: ChLooper, rhs: (ItemDSL) -> Void) -> ChLooper {
    lhs.ref = ChLooper(rhs)
    return lhs.ref!
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

    concurrentQueue.sync {
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
    }

    if !remove.isEmpty || !add.isEmpty {
      concurrentQueue.async(flags: .barrier) { [weak self] in
        guard let self = self else { return }
        if !self.remove.isEmpty {
          self.items = self.items.filter { v in
            self.remove.contains { $0 === v }
          }
          self.itemPool = self.itemPool + self.remove
        }
        if !self.add.isEmpty {
          self.items = self.items + self.add
        }
      }
    }

  }
  func invoke(block: (ItemDSL) -> Void) -> Sequence {
    let dsl = ItemDSL()
    block(dsl)
    let item = getItem(dsl)
    item.start += now()
    item.end = item.term == -1.0 ? -1.0 : item.start + item.term
    concurrentQueue.sync(flags: .barrier) { [weak self] in
      self?.items.append(item)
    }
    sequence.item = item
    return Sequence(looper: self)
  }

  func getItem(_ i: ItemDSL) -> ChItem {
    var item: ChItem! = itemPool.removeLast()
    if item == nil { item = ChItem() }
    item.term  = Double(i.time)
    item.start = Double(i.delay)
    item.loop  = i.loop
    item.block = i.block
    item.ended = i.ended
    item.isInfinity = i.isInfinity
    item.next  = nil
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
    var item: ChItem?
    init(looper: ChLooper) {
      self.looper = looper
    }
  }
  
}
