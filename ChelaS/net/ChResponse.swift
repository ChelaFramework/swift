////
////  ChResponse.swift
////  Chela
////
////  Created by Taehyeon Jake Lee on 15/01/2019.
////  Copyright © 2019 Chela. All rights reserved.
////
//
//import Alamofire
//
//class ChResponse {
//  var response: DataResponse<Any>?
//  var err: String?
//
//  var key: String = ""
//  var arg: [(String, Any)]?
//  var extra = [String: Any]()
//  var result: Any = ""
//  var state: String {
//    return response?.description ?? ""
//  }
//  private lazy var isOpened: Bool = response == nil
//  var body: String? {
//    if isOpened { return nil }
//    else {
//      isOpened = true
//      guard let data = response?.data else { return nil }
//      return String(data: data, encoding: .utf8)
//    }
//  }
//  var byte: [UInt8]? {
//    if isOpened { return nil }
//    else {
//      guard let data = response?.data else { return nil }
//      return Array(data)
//    }
//  }
//
//  init(response: DataResponse<Any>?, err: String? = nil) {
//    self.response = response
//    self.err = err
//  }
//
//  func header(k: String) -> Any? {
//    return response?.response?.allHeaderFields[k]
//  }
//}
