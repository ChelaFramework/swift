//
//  ChHttp.swift
//  Chela
//
//  Created by SeungChul Kang on 2019. 1. 15..
//  Copyright © 2019년 Chela. All rights reserved.
//

import Foundation

class ChHttp {
  let extra = [String: Any]()
//  func header(key:String, value:String) -> ChHttp {}
//  func form(key:String, value:String) -> ChHttp {}
//  func json(json:String) -> ChHttp {}
//  func body(body:String) -> ChHttp {}
//  func file(key: String, filename: String, mine: String, file: [UInt8]) -> ChHttp {}
//  func send(callback: httpCallBack) {}
}


//private let okHttpClient = OkHttpClient.Builder()
//.connectTimeout(3, TimeUnit.SECONDS).writeTimeout(10, TimeUnit.SECONDS).readTimeout(5, TimeUnit.SECONDS)
//.build()
//private let JSON = MediaType.parse("application/json; charset=utf-8")
//private let BODY = MediaType.parse("plain/text; charset=utf-8")
//
//class ChHttpOk3: ChHttp {
//  private let method: String
////  private var request: Request.Builder
//  private var form: FormBody.Builder?
//  private var json:String?
//  private var body:String?
//  private var multi: MultipartBody.Builder?
//
////  init(method: String, request: Request.Builder) {
////    self.method = method
////    self.request = request
////  }
//
//  override func header(key:String, value:String) -> ChHttp {
//    request = request.addHeader(key, value)
//    return self
//  }
//  override func form(key:String, value:String) -> ChHttp {
//    if form == nil {
//      form = FormBody.Builder()
//    }
//    form?.add(key, value)
//    return self
//  }
//  override func json(json:String) -> ChHttp {
//    self.json = json
//    return self
//  }
//  override func body(body:String) -> ChHttp {
//    self.body = body
//    return self
//  }
//  override func file(key:String, filename:String, mine:String, file:[UInt8])-> ChHttp {
//    if(multi == nil) multi = MultipartBody.Builder().setType(MultipartBody.FORM)
//    multi?.addFormDataPart(key, filename, RequestBody.create(MediaType.parse(mine), file))
//    return self
//  }
//  override func send(callback: httpCallBack){
//    when(method){
//      "POST"->{
//        multi?.let {multi->
//          json?.let {multi.addPart(RequestBody.create(JSON, it))} ?:
//          body?.let {multi.addPart(RequestBody.create(BODY, it))} ?:
//          form?.let {multi.addPart(it.build())}
//          request = request.post(multi.build())
//          } ?:
//        json?.let {request = request.post(RequestBody.create(JSON, it))} ?:
//        body?.let {request = request.post(RequestBody.create(BODY, it))} ?:
//        form?.let {request = request.post(it.build())}
//      }
//    }
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
//  }
//}
