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
  
  override func create(base: ChHolderBase<UIView>) -> UIView {
    let view = UIButton()
    view.frame = CGRect(x: 20, y: 20, width: 100, height: 100)
    view.backgroundColor = .red
    view.addTarget(self, action: Selector("buttonClicked:"), for: .touchUpInside)
    return view
  }
  
  func buttonClicked(_ sender: UIButton) {
    router.push(holder: Home.shared, false)
//    ChRouter<T, self>.push(holder: Home, false)
//    router.push(holder: Home.shared, false)
  }
}
