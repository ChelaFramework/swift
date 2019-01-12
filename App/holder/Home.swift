//
//  Main.swift
//  Chela
//
//  Created by 배인진 on 12/01/2019.
//  Copyright © 2019 Chela. All rights reserved.
//

import Foundation
import UIKit

class Home: ChHolder {
  typealias T = UIView
  static let shared = Home()
  
  func create(base: ChHolderBase<UIView>) -> UIView {
    let view = UIView()
    view.backgroundColor = UIColor.blue
    return view
  }
}
