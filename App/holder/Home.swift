//
//  Main.swift
//  Chela
//
//  Created by 배인진 on 12/01/2019.
//  Copyright © 2019 Chela. All rights reserved.
//

import UIKit

class Home: ChViewHolder {
  static let shared = Home()
  private let view = UIButton()
  override func create(base: ChHolderBase<UIView>) -> UIView {
    view.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
    view.backgroundColor = .blue
    view.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
    return view
  }
  
  @objc private func buttonClicked(_ sender: UIButton) {
    router.pop()
  }
  
  override func resume(_ base: ChHolderBase<ChViewHolder.T>, _ isRestore: Bool) {
    view.isHidden = false
  }
  
  override func pause(_ base: ChHolderBase<ChViewHolder.T>, _ isJump: Bool) {
    view.isHidden = true
  }
  
}
