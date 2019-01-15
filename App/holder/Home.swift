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

  @objc private func buttonClicked(_ sender: UIButton) {
    router.pop()
  }

  override func create(base: ChViewBase) -> UIView {
    view.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
    view.backgroundColor = .blue
    view.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
    return view
  }

  override func resume(_ base: ChViewBase, _ isRestore: Bool) {
    view.isHidden = false
  }
  
  override func pause(_ base: ChViewBase, _ isJump: Bool) {
    view.isHidden = true
  }
  
}
