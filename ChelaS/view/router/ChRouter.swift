//
//  ChRouter.swift
//  Chela
//
//  Created by SeungChul Kang on 2019. 1. 12..
//  Copyright © 2019년 Chela. All rights reserved.
//

import Foundation

class ChRouter<T> {
  private let base: ChHolderBase<T>
  init(base: ChHolderBase<T>) {
    self.base = base
  }
}
