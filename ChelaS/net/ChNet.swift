//
//  ChNet.swift
//  Chela
//
//  Created by Taehyeon Jake Lee on 15/01/2019.
//  Copyright © 2019 Chela. All rights reserved.
//

import Foundation

typealias httpCallBack = (_ response: ChResponse) -> Void
typealias requestTaskF = (ChHttp, [(String, Any)]) -> Bool
typealias responseTaskF = (_ response: ChResponse) -> Bool

//struct ChNet {
//  struct Api {
//    let url: String
//    let method: String
//    let requestTask: [String]
//    let responseTask: [String]
//    let request: [String: ApiRequest]
//  }
//
//  struct ApiRequest {
//    let name: String
//    let rules: String
//    let task: [String]
//  }
//
//  private let apis = [String: Api]()
//  private var requestTask = [String: requestTaskF]()
//  private var requestItemTask = [String: (Any) -> Any?]()
//  private var responseTask = [String: responseTaskF]()
//
//  mutating func apiRequestTask(key: String, block: @escaping requestTaskF) {
//    requestTask[key] = block
//  }
//
//  mutating func apiRequestItemTask(key: String, block: @escaping (Any) -> Any?) {
//    requestItemTask[key] = block
//  }
//
//  mutating func apiResponseTask(key: String, block: @escaping responseTaskF) {
//    responseTask[key] = block
//  }
//
//  func getApi(k: String) -> Api? {
//    api.get()
//    return apis[k]
//  }
//
//  func setApi(k: String, url: String, method: String, reqTask: String, resTask: String, req: [String: [String]], isWriteDB: Bool = true) {
//    if isWriteDB {
//      api.addApi(k, url, method, reqTask, resTask)
//    }
//    apis[k] = Api(url, method,
//    reqTask.split("|").map { $0.trim() },
//    resTask.split("|").map { $0.trim() },
//    with([String, ApiRequest]()) {
//      req.forEach { (rk, v) ->
//      val (name, rule, task) = v
//      if (isWriteDB) api.addItem(rk, name, rule, task)
//      if (rule.isNotBlank() && rule.indexOf(".") == -1 && ChRuleSet["$k.$rk"] == null) ChRuleSet.set("$k.$rk", rule)
//      this[rk] = ApiRequest(name, rule, task.split("|").map { $0.trim() })
//      }
//      this
//    }
//    )
//  }
//  /**
//   * Parse json file list to MutableMap, and cached on [apis].
//   * @param files json format file list.
//   */
//  func loadApi(files: [String]) = files.forEach { v ->
//    _try { JSONObject(v) }?.let { v ->
//      if (id.isExist(v._string(id.ID) ?: "")) return@let
//      v._forObject { k, obj ->
//        setApi(k,
//        obj._string(api.URL) ?: throw Exception("no url: $k"),
//        obj._string(api.METHOD) ?: "POST",
//        obj._string(api.REQUESTTASK) ?: "",
//        obj._string(api.RESPONSETASK) ?: "",
//        with(mutableMapOf<String, List<String>>()) {
//        obj._forObject(api.REQUEST){ rk, item ->
//        this[rk] = listOf(
//        item._string(api.REQUEST_NAME) ?: rk,
//        item._string(api.REQUEST_RULES) ?: "",
//        item._string(api.REQUEST_TASK) ?: ""
//        )
//        }
//        this
//        }
//        )
//      }
//    }
//  }
//
//  /**
//   * @key json object key on Api
//   * @arg Pair you want to validate and send HTTP request.
//   * <pre>
//   *     Ch.net.api(jsonObjectKey, key to value...) { response ->
//   *        App.data = response.result
//   *     }
//   * </pre>
//   */
//  func api(key:String, vararg arg: (String, Any), block:(ChResponse) -> Void) -> Ch.ApiResult{
//    val api = getApi(key) ?: return Ch.ApiResult.fail("invalid api:$key")
//    if(arg.size != api.request.size) return Ch.ApiResult.fail("invalid arg count:arg ${arg.size}, api ${api.request.size}")
//    val reqItem = mutableListOf<Pair<String, Any>>()
//    arg.forEach{(k, v)->
//      val req = api.request[k] ?: return Ch.ApiResult.fail("invalid request param:$k")
//      var r = v
//      if(req.rules.isNotBlank()){
//        r = Ch.ruleset.isOk(req.rules, r)
//        if(r is ChRuleSet) return Ch.ApiResult.fail("rule check fail $k : $v")
//      }
//      req.task.forEach ch@{
//        if(it.isBlank()) return@ch
//        val task = requestItemTask[it] ?: return Ch.ApiResult.fail("invalid request item task:$it for $k")
//        r = task(r) ?: return Ch.ApiResult.fail("request item task stop:$it for $k")
//      }
//      reqItem += (req.name) to r
//    }
//    if(reqItem.size != arg.size) return Ch.ApiResult.fail("invalid request param expected:${reqItem.size} actual:${arg.size}")
//    val net = http(api.method, api.url)
//    var msg = ""
//    if(!api.requestTask.all {
//      return@all requestTask[it]?.let{
//        if(!it(net, reqItem)){
//        msg = "request task stop:$it for $key"
//        false
//        }else true
//        } ?: run{
//          msg = "invalid request task:$it for $key"
//          false
//      }
//      }) return Ch.ApiResult.fail(msg)
//    net.send{
//      var response = it
//      response.key = key
//      response.arg = reqItem
//      api.responseTask.all {
//        val (k, arg) = reParam.parse(it)
//        response.responseTaskParam.clear()
//        response.responseTaskParam.addAll(arg)
//        responseTask[k]?.let {it(response)} ?: run{
//          response.body = null
//          response.err = "invalid response task:$it for $key"
//          false
//        }
//      }
//      block(response)
//    }
//    return Ch.ApiResult.ok
//  }
//  func http(method:String, url:String) -> ChHttp {
//    return ChHttpOk3(method, Request.Builder().url(url))
//  }
//  func isOn() -> Bool {
//    return connectedType() != Ch.NONE
//  }
//  func connectedType() -> Ch.Value {
//    if(SDK_INT < 23){
//      ChApp.cm.activeNetworkInfo?.let{
//        return when(it.type){
//          TYPE_WIFI -> Ch.WIFI
//          TYPE_MOBILE -> Ch.MOBILE
//          else -> Ch.NONE
//        }
//      }
//    }else{
//      ChApp.cm.activeNetwork?.let {
//        val nc = ChApp.cm.getNetworkCapabilities(it)
//        return when{
//          nc.hasTransport(TRANSPORT_WIFI) -> Ch.WIFI
//          nc.hasTransport(TRANSPORT_CELLULAR) -> Ch.MOBILE
//          else -> Ch.NONE
//        }
//      }
//    }
//    return Ch.NONE
//  }
//}
