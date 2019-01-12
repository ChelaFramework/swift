//
//  Splash.swift
//  Chela
//
//  Created by 배인진 on 12/01/2019.
//  Copyright © 2019 Chela. All rights reserved.
//

import Foundation
import UIKit

class Splash: ChViewHolder {
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

  
  override func resume(_ base: ChHolderBase<ChViewHolder.T>, _ isRestore: Bool) {
    view.isHidden = false
  }
  
  override func pause(_ base: ChHolderBase<ChViewHolder.T>, _ isJump: Bool) {
    view.isHidden = true
  }
}
