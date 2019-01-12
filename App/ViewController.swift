//
//  ViewController.swift
//  Chela
//
//  Created by bsidesoft on 2019. 1. 12..
//  Copyright © 2019년 Chela. All rights reserved.
//

import UIKit


//func router<T>(base: ChHolderBase<T>) -> ChRouter<T> {
//  return ChRouter.init(base: base)
//}
var groupBase: ChViewBase = ChViewBase()
var router = { () -> ChRouter<Splash, Splash.T> in
  return ChRouter.init(of: Splash.self, base: groupBase)
}()

class ViewController: UIViewController {
	override func viewDidLoad() {
		super.viewDidLoad()
    groupBase.view(it: view)
    router.push(holder: Splash.shared, false)
	}


}

