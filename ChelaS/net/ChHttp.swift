//
//  ChHttp.swift
//  Chela
//
//  Created by SeungChul Kang on 2019. 1. 15..
//  Copyright © 2019년 Chela. All rights reserved.
//

import Alamofire

typealias HttpCallBack = (_ response: ChResponse) -> Void
//abstract class ChHttp{
//  companion object {
//  val EXTRA_JSON = "json"
//  val EXTRA_REQUEST = "request"
//  }
//  val extra = mutableMapOf<String, Any>()
//  abstract fun header(key:String, value:String): ChHttp
//  abstract fun form(key:String, value:String): ChHttp
//  abstract fun json(json:String): ChHttp
//  abstract fun body(body:String): ChHttp
//  abstract fun file(key: String, filename: String, mine: String, file: ByteArray): ChHttp
//  abstract fun send(callback: httpCallBack)
//}
protocol ChHttpProtocol: class {
  var extra: [String: Any] { get }
  func header(key:String, value:String) -> ChHttpProtocol
  func parameters(key: String, value: Any) -> ChHttpProtocol
  func encoding(_ encoding: ParameterEncoding) -> ChHttpProtocol
//  func form(key:String, value:String) -> ChHttpProtocol
//  func json(_ json:String) -> ChHttpProtocol
//  func body(_ body:String) -> ChHttpProtocol
//  func file(key: String, filename: String, mine: String, file: [UInt8]) -> ChHttpProtocol
  func send(callback: @escaping HttpCallBack)
}

//private let okHttpClient = OkHttpClient.Builder()
//.connectTimeout(3, TimeUnit.SECONDS).writeTimeout(10, TimeUnit.SECONDS).readTimeout(5, TimeUnit.SECONDS)
//.build()
//private let JSON = MediaType.parse("application/json; charset=utf-8")
//private let BODY = MediaType.parse("plain/text; charset=utf-8")
//

//private val okHttpClient = OkHttpClient.Builder()
//.connectTimeout(3, TimeUnit.SECONDS).writeTimeout(10, TimeUnit.SECONDS).readTimeout(5, TimeUnit.SECONDS)
//.build()
//let JSON = MediaType.parse("application/json; charset=utf-8")
//let BODY = MediaType.parse("plain/text; charset=utf-8")

class ChHttp : ChHttpProtocol {

  private(set) var extra = [String: Any]()
  private var headers: HTTPHeaders = [String: String]()
  private var parameters: Parameters = [String: Any]()
  private var encoding: ParameterEncoding = URLEncoding.default

  private let method: HTTPMethod
  private let url: URL

  private var form: Data? // FormBody.Builder?
  private var json: String?
  private var body: String?
  private var multi: MultipartFormData? // MultipartBody.Builder?

  init?(url: String, method: String = "GET") {
    guard let method = HTTPMethod(rawValue: method),
      let url = URL(string: url) else { return nil }
    self.method = method
    self.url = url
  }

  @discardableResult
  func header(key: String, value: String) -> ChHttpProtocol {
    headers[key] = value
    return self
  }

  @discardableResult
  func parameters(key: String, value: Any) -> ChHttpProtocol {
    parameters[key] = value
    return self
  }

  @discardableResult
  func encoding(_ encoding: ParameterEncoding) -> ChHttpProtocol {
    self.encoding = encoding
    return self
  }
//  func form(key: String, value: String) -> ChHttpProtocol {
//    if form == nil {
//      form = FormBody.Builder()
//    }
//    form?.add(key, value)
//    return self
//  }
//  func json(_ json: String) -> ChHttpProtocol {
//    self.json = json
//    return self
//  }
//  func body(_ body: String) -> ChHttpProtocol {
//    self.body = body
//    return self
//  }

  @discardableResult
  func file(key: String, filename: String, mime: String, file: Data)-> ChHttpProtocol {
    if multi == nil {
      multi = MultipartFormData()// MultipartBody.Builder().setType(MultipartBody.FORM)
      multi?.append(file, withName: key, fileName: filename, mimeType: mime)
    }
    return self
  }

  func send(callback: @escaping HttpCallBack) {
    /* 업로드용
    Alamofire.upload(
      multipartFormData: { [weak self] (multipartFormData) in
        guard let self = self else { return }
        var multiFormData = multipartFormData
        self.parameters
          .keys
          .sorted(by: <)
          .reduce([(String, String)]()) {
            $0 + self.queryComponents(fromKey: $1, value: (self.parameters[$1])!)
          }
          .forEach {
            if let data = $0.1.data(using: .utf8) {
              multiFormData.append(data, withName: $0.0)
            }
        }

      },
      to: self.url.absoluteString,
      method: self.method,
      headers: headers,
      encodingCompletion: { encodingResult in
        switch encodingResult {
        case .success(let upload, _, _): break

        case .failure(let encodingError): break

        }
      }
    )
    */

//    if method != .get {
//      if let multi = multi {
//    Alamofire.upload
//        Alamofire.upload(
//          multipartFormData: { multipartFormData in
//            multipartFormData.append(file, withName: key, fileName: filename, mimeType: mime)
//          },
//          with: url,
//          encodingCompletion: { encodingResult in
//            switch encodingResult {
//            case .success(let upload, _, _):
//              upload.responseJSON { response in
//
//              }
//            case .failure(let encodingError): break
//          }
//        })
//      }
//    }
//    if method != "GET" {
//      if let multi = multi {
//        if let json = json {
//          multi.addPart(RequestBody.create(JSON, $0))
//        } else if let body = body {
//          multi.addPart(RequestBody.create(BODY, $0))
//        } else if let form = form {
//          multi.addPart($0.build())
//        }
//        request = request.post(multi.build())
//      } else if json = json {
//        request = request.post(RequestBody.create(JSON, $0))
//      } else if body = body {
//        request = request.post(RequestBody.create(BODY, $0))
//      } else if form = form {
//        request = request.post($0.build())
//      }
//    }

    Alamofire.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers).responseJSON { res in
      guard res.data != nil else {
        print("fail")
        callback(ChResponse(response: nil, err: "fail"))
        return
      }
      print("success")
      callback(ChResponse(response: res, err: nil))

//      .responseJSON { response in
//      switch response.result {
//      case .success(let value):
//        break
//      case .failure(let error):
//        break
//      }
    }
//    okHttpClient.newCall(request.build()).enqueue(object: Callback {
//      override fun onFailure(call: Call, e: IOException){
//        Ch.thread.main(Runnable{callback(ChResponse(null, e.toString(), 0, null))})}
//      override fun onResponse(call: Call, response: Response){
//        val code = response.code()
//        response.body()?.let {
//          val b = it.string()
//          response.close()
//          Ch.thread.main(Runnable {callback(ChResponse(b, null, code, response))})
//          } ?: Ch.thread.main(Runnable {callback(ChResponse(null, "body error", code, response))})
//      }
//    })
  }

  private func queryComponents(fromKey key: String, value: Any) -> [(String, String)] {
    var components: [(String, String)] = []
    if let dictionary = value as? [String: Any] {
      for (nestedKey, value) in dictionary {
        components += queryComponents(fromKey: "\(key)[\(nestedKey)]", value: value)
      }
    } else if let array = value as? [Any] {
      for value in array {
        components += queryComponents(fromKey: "\(key)[]", value: value)
      }
    } else if let value = value as? NSNumber {
      components.append(
        (key.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!, "\(value)")
      )
    } else if let bool = value as? Bool {
      components.append(
        (key.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!, bool ? "1" : "0")
      )
    } else {
      components.append(
        (key.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!, "\(value)")
      )
    }
    return components
  }
}
