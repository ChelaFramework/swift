//
//  ViewController.swift
//  Chela
//
//  Created by bsidesoft on 2019. 1. 12..
//  Copyright © 2019년 Chela. All rights reserved.
//

import UIKit

var viewBase: ChViewBase = ChViewBase()
var router = { return ChRouter.init(of: ChViewHolder.self, base: viewBase) }()

class ViewController: UIViewController {
	override func viewDidLoad() {
		super.viewDidLoad()
    viewBase.view(view)
    router.push(holder: Splash.shared, true)
//    let net = ChNet.init()
//    let http = net.http(url: "https://www.naver.com")
//    http?.send { res in
//      guard let data = res.byte else {
//        return
//      }
//      print("res: \(data)")
//    }

//    ChHttp.init(method: "GET", url: "https://www.google.com/search?q=strongpassword+receiver+ios&newwindow=1&rlz=1C5CHFA_enKR826KR827&source=lnms&tbm=isch&sa=X&ved=0ahUKEwjo4bOGgJPgAhVFUN4KHU3mC00Q_AUIDigB&biw=1680&bih=940#imgrc=RzRo1ST8AgwIEM:")?
//    .send(callback: { res in
//      print("dddd")
//      })
	}
}

