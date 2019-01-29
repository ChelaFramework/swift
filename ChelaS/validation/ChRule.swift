//
//  ChRule.swift
//  Chela
//
//  Created by Bsidesoft on 29/01/2019.
//  Copyright © 2019 Chela. All rights reserved.
//

import Foundation

class ChRule {
//  (arg:List<String>)->(v:Any)->Any
  typealias RuleF = (_ v: Any, _ arg: [String]) -> Any
  typealias ClosureRuleF = (_ arg: [String]) -> (_ v: Any) -> Any
  var mirror: Mirror!
  var _defined = [String: ClosureRuleF]()
  init() {
    mirror = Mirror.init(reflecting: self)
    for case let (label?, value) in mirror.children {
      print(label)
      print(value)
      let k = label.lowercased()
      if let f = value as? RuleF {
        _defined[k] = { arg in { v in f(v, arg) } }
        
      }
    }
  }
}

class ChBaseRule: ChRule {
  let mirror44: RuleF = { (v, arg) in return "4378563487" }
}


func test098778() {
  let _ = ChBaseRule.init()
}
