//
//  Splash.swift
//  Chela
//
//  Created by 배인진 on 12/01/2019.
//  Copyright © 2019 Chela. All rights reserved.
//

import Foundation
import UIKit

class ViewHolder: ChHolder {
  func create(base: ChHolderBase<UIView>) -> UIView { return UIView.init() }
}

class Splash: ViewHolder {
  static let shared = Splash()
  private let view = UIButton()
  override func create(base: ChHolderBase<UIView>) -> UIView {
    view.frame = CGRect(x: 20, y: 20, width: 100, height: 100)
    view.backgroundColor = .red
    view.addTarget(self, action: #selector(Splash.buttonClicked(_:)), for: .touchUpInside)
    return view
  }
  
  @objc func buttonClicked(_ sender: UIButton) {
    router.push(holder: Home.shared, true)
  }
  
  func resume(_ base: ChHolderBase<UIView>, _ isRestore: Bool) {
    view.isHidden = false
  }
  
  func pause(_ base: ChHolderBase<UIView>, _ isJump: Bool) {
    view.isHidden = true
  }
}
