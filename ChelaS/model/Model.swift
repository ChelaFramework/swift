//
//  Model.swift
//  Chela
//
//  Created by SeungChul Kang on 2019. 1. 15..
//  Copyright © 2019년 Chela. All rights reserved.
//

import Foundation

class ChModel: NSObject {
  static var repo = [String: ChModel]()
  var mirror: Mirror!
  override init() {
    super.init()
    if classForCoder.responds(to: NSSelectorFromString("shared")),
      let name = NSStringFromClass(classForCoder).components(separatedBy: ".").last {
      ChModel.repo[name] = self
    }
    mirror = Mirror.init(reflecting: self)
  }

  func val(_ key: String) -> Any? {
    for (_, attr) in mirror.children.enumerated() {
      if let attrName = attr.label, attrName == key {
        return attr.value
      }
    }
    return nil
  }

  func set(_ key: String, _ val: Any) {
    guard !key.isEmpty else { return }
    let first = String(key.prefix(1)).capitalized
    let other = String(key.dropFirst())
    let sel   = NSSelectorFromString("set\(first + other):")
    if responds(to: sel) {
//      NSMethodSignature *signature = [r methodSignatureForSelector:selector];
//      NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
//      [invocation setSelector:selector];
//      int x = 5;
//      int y = 6;
//      [invocation setArgument:&x atIndex:2]; // 0 and 1 are reserved
//      [invocation setArgument:&y atIndex:3];
//      [invocation invokeWithTarget:r];

        print(type(of: val))
        perform(sel, with: val)
    }
  }

}

class ChModel2: ChModel {
  @objc var name: String = "kang"
  @objc var a: Float = 39
  @objc static var shared = ChModel2()
}


struct ASCIILogger: TextOutputStream {
    mutating func write(_ string: String) {
        let ascii = string.unicodeScalars.lazy.map { scalar in
            scalar == "\n"
              ? "\n"
              : scalar.escaped(asASCII: true)
        }
        print(ascii.joined(separator: ""), terminator: "")
    }
}
///
/// The `ASCIILogger` type's `write(_:)` method processes its string input by
/// escaping each Unicode scalar, with the exception of `"\n"` line returns.
/// By sending the output of the `print(_:to:)` function to an instance of
/// `ASCIILogger`, you invoke its `write(_:)` method.
///
///     let s = "Hearts ♡ and Diamonds ♢"
///     print(s)
///     // Prints "Hearts ♡ and Diamonds ♢"
///
///     var asciiLogger = ASCIILogger()
///     print(s, to: &asciiLogger)
///     // Prints "Hearts \u{2661} and Diamonds \u{2662}"


func test123123() {
  let model = ChModel2()
  var asciiLogger = ASCIILogger()
  dump(model, to: &asciiLogger)

  print(model.val("name"))
//  model.set("name", "hika")
    print(model.val("a"))
    model.set("a", 33.0)
  print(model.val("name"))
    print(model.val("a"))

//    model.a = 40
    print(model.val("a"))
  print("ref")


}
