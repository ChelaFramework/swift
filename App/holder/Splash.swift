//
//  Splash.swift
//  Chela
//
//  Created by 배인진 on 12/01/2019.
//  Copyright © 2019 Chela. All rights reserved.
//

import Foundation
import UIKit

class Splash: ChHolder {
  typealias T = UIView
  static let shared = Splash()
  
  func create(base: ChHolderBase<UIView>) -> UIView {
    let view = UIButton()
    view.addTarget(self, action: Selector("buttonClicked:"), for: .touchUpInside)
    return view
  }
  
  func buttonClicked(_ sender: UIButton) {
    ChRouter.push(Home, false)
  }
}
