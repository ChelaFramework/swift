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
  
}
