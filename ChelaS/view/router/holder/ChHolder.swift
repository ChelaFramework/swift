//
//  ChHolder.swift
//  Chela
//
//  Created by SeungChul Kang on 2019. 1. 12..
//  Copyright © 2019년 Chela. All rights reserved.
//

import Foundation
import UIKit

protocol ChHolder {
  associatedtype T
  func create(base: ChHolderBase<T>) -> T
}

extension ChHolder {
  func push(base: ChHolderBase<T>, isRestore: Bool) {}
  func resume(base: ChHolderBase<T>, isRestore: Bool) {}
  func pause(base: ChHolderBase<T>, isJump: Bool) {}
  func pop(base: ChHolderBase<T>, isJump: Bool) {}
}

class Sample: ChHolder {
  func create(base: ChHolderBase<UIView>) -> UIView {
    return UIView.init()
  }
}
