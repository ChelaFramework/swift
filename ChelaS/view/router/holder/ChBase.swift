//
//  ChBase.swift
//  Chela
//
//  Created by SeungChul Kang on 2019. 1. 12..
//  Copyright © 2019년 Chela. All rights reserved.
//

import Foundation

protocol ChHolderBaseProtocol {
  associatedtype T
  func _push(holder: ChHolder<T>)
}

extension ChHolderBaseProtocol {
  func _push(holder: ChHolder<T>) {

  }
}

class ChHolderBase<T>: ChHolderBaseProtocol {

}
