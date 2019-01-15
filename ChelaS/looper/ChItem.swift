//
//  ChItem.swift
//  Chela
//
//  Created by 배인진 on 15/01/2019.
//  Copyright © 2019 Chela. All rights reserved.
//

import Foundation

fileprivate let PI = Double.pi
fileprivate let HPI = Double.pi / 2
class ChItem {
  var rate = 0.0
  var current = 0.0
  internal var start = 0.0
  internal var end = 0.0
  internal var term = 0.0
  internal var isTurn = false
  internal var loop = 1
  internal var isPaused = false
  internal var isInfinity = false
  
  internal var block: ItemBlock = empty
  internal var ended: ItemBlock = empty
  internal var next: ChItem? = nil
  internal var isStop = false
  private var pauseStart = 0.0
  
  func stop() { isStop = true }
  func pause() {
    if (isPaused) { return }
    isPaused = true
    pauseStart = now()
  }
  func resume() {
    if (!isPaused) { return }
    isPaused = false
    pauseStart = now() - pauseStart
    start += pauseStart
    end += pauseStart
    pauseStart = 0.0
  }
  func linear(from: Double, to: Double) -> Double {
    return from + rate * (to - from)
  }
  func backIn(from: Double, to: Double) -> Double {
    let b = to - from
    return b * rate * rate * (2.70158 * rate - 1.70158) + from
  }
  func backOut(from: Double, to: Double) -> Double {
    let a = rate - 1
    let b = to - from
    return b * (a * a * (2.70158 * a + 1.70158) + 1) + from
  }
  func backInOut(from: Double, to: Double) -> Double {
    var a = rate * 2
    let b = to - from
    if (1 > a) {
        return 0.5 * b * a * a * (3.5949095 * a - 2.5949095) + from
    } else {
      a -= 2.0
      return 0.5 * b * (a * a * (3.70158 * a + 2.70158) + 2) + from
    }
  }
  func sineIn(from: Double, to: Double) -> Double {
    let b = to - from
    return -b * cos(rate * HPI) + b + from
  }
  func sineOut(from: Double, to: Double) -> Double {
    return (to - from) * sin(rate * HPI) + from
  }
  func sineInOut(from: Double, to: Double) -> Double {
    return 0.5 * -(to - from) * (cos(PI * rate) - 1) + from
  }
  func circleIn(from: Double, to: Double) -> Double {
    return -(to - from) * (sqrt(1 - rate * rate) - 1) + from
  }
  func circleOut(from: Double, to: Double) -> Double {
    let a = rate - 1
    return (to - from) * sqrt(1 - a * a) + from
  }
  func circleInOut(from: Double, to: Double) -> Double {
    var a = rate * 2
    let b = to - from
    if (1 > a) {
      return 0.5 * -b * (sqrt(1 - a * a) - 1) + from
    } else {
      a -= 2.0
      return 0.5 * b * (sqrt(1 - a * a) + 1) + from
    }
  }
  func quadraticIn(from: Double, to: Double) -> Double {
    return (to - from) * rate * rate + from
  }
  func quadraticOut(from: Double, to: Double) -> Double {
    return -(to - from) * rate * (rate - 2) + from
  }
  func bounceOut(from: Double, to: Double) -> Double {
    var a = rate
    let b = to - from
    if (0.363636 > a) {
        return 7.5625 * b * a * a + from
    } else if (0.727272 > a) {
      a -= 0.545454
      return b * (7.5625 * a * a + 0.75) + from
    } else if (0.90909 > a) {
      a -= 0.818181
      return b * (7.5625 * a * a + 0.9375) + from
    } else {
      a -= 0.95454
      return b * (7.5625 * a * a + 0.984375) + from
    }
  }
}
