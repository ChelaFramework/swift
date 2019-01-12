//
//  UIButton+AddAction.swift
//  Chela
//
//  Created by SeungChul Kang on 2019. 1. 12..
//  Copyright © 2019년 Chela. All rights reserved.
//

import Foundation
import UIKit

typealias UIButtonTargetClosure = (UIButton) -> Void

class ClosureWrapper: NSObject {
  let closure: UIButtonTargetClosure
  init(_ closure: @escaping UIButtonTargetClosure) {
    self.closure = closure
  }
}

/////// Button Action 처리
//extension UIButton {
//  private struct AssociatedKeys {
//    static var touchUpInside    = "touchUpInsideAction"
//    static var touchUpOutside   = "touchUpOutsideAction"
//  }
//  // swiftlint:disable line_length
//  private var touchUpInside: UIButtonTargetClosure? {
//    get {
//      guard let closureWrapper = objc_getAssociatedObject(self, &AssociatedKeys.targetClosure) as? ClosureWrapper else { return nil }
//      return closureWrapper.closure
//    }
//    set(newValue) {
//      guard let newValue = newValue else { return }
//      objc_setAssociatedObject(self, &AssociatedKeys.targetClosure, ClosureWrapper(newValue),
//                               objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//    }
//  }
//
//  private var touchDown: UIButtonTargetClosure? {
//    get {
//      guard let closureWrapper = objc_getAssociatedObject(self, &AssociatedKeys.touchUpInside) as? ClosureWrapper else { return nil }
//      return closureWrapper.closure
//    }
//    set(newValue) {
//      guard let newValue = newValue else { return }
//      objc_setAssociatedObject(self, &AssociatedKeys.touchUpInside, ClosureWrapper(newValue),
//                               objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//    }
//  }
//
//  private var touchUpOutside: UIButtonTargetClosure? {
//    get {
//      guard let closureWrapper = objc_getAssociatedObject(self, &AssociatedKeys.touchUpOutside) as? ClosureWrapper else { return nil }
//      return closureWrapper.closure
//    }
//    set(newValue) {
//      guard let newValue = newValue else { return }
//      objc_setAssociatedObject(self, &AssociatedKeys.touchUpOutside, ClosureWrapper(newValue),
//                               objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//    }
//  }
//
//  @objc func touchDownAction() {
//    touchDown?(self)
//  }
//
//  @objc func touchUpInsideAction() {
//    touchUpInside?(self)
//  }
//
//  @objc func touchUpOutsideAction() {
//    touchUpOutside?(self)
//  }
//
//  func addAction(_ event: UIControl.Event = .touchUpInside, closure: @escaping UIButtonTargetClosure) {
//    switch event {
//    case .touchDown:
//      self.touchDown = closure
//      addTarget(self, action: #selector(UIButton.touchDownAction), for: event)
//    case .touchUpOutside:
//      self.touchUpOutside = closure
//      addTarget(self, action: #selector(UIButton.touchUpOutsideAction), for: event)
//    default:
//      self.touchUpInside = closure
//      addTarget(self, action: #selector(UIButton.touchUpInsideAction), for: event)
//    }
//
//  }
//}
