//
//  CountAPI.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/12/2.
//

import Foundation
import HandyJSON

// MARK: - 维保服务-数据统计
// MARK: - URL

let URLCountEngineerCount = "/count/engineer_count" /// 巡检记录-服务工程师-头部红色
let URLCountItemCount = "/count/item_count"         /// 报表2-单项巡检结果
let URLCountPatrolCount = "/count/patrol_count"     /// 巡检记录-巡检质量统计
let URLCountPatrolPatr = "/count/patrol_patr"       /// 巡检记录-网点-头部红色
let URLCountSelectCount = "/count/selectCount"      /// 巡检记录-服务工程师-数据统计
let URLCountStutasCount = "/count/stutas_count"     /// 报表1-网点巡检状况统计
let URLCountTopfiveList = "/count/topfive_list"     /// 报表3-获取报修前五项

/// Common
class CountParam: Encodable {
    var deptId: Int64?
    var cretime: String?      // 月份例如2022年11月 202211
    var tmplValue: String?
    var startTime: String?
    var endTime: String?
    
    init(deptId: Int64? = nil, cretime: String? = nil, tmplValue: String? = nil, startTime: String? = nil, endTime: String? = nil) {
        self.deptId = deptId
        self.cretime = cretime
        self.tmplValue = tmplValue
        self.startTime = startTime
        self.endTime = endTime
    }
}

// MARK: - API
extension API {
    /// 巡检记录-服务工程师-头部红色
    class func getCountEngineerCount(withBlock block: ResponseBlock<RespModal>?) {
        NetManager.request(url: URLCountEngineerCount, method: .get, modelType: RespModal.self, resultBlock: block)
    }
    
    /// 报表2-单项巡检结果
    class func getCountItemCount(withParam param: CountParam, block: ResponseBlock<CountItemModal>?) {
        NetManager.request(url: URLCountItemCount, method: .get, parameters: param, modelType: CountItemModal.self, resultBlock: block)
    }
    
    /// 巡检记录-巡检质量统计
    class func getCountPatrolCount(withParam param: CountParam, block: ResponseBlock<RespModal>?) {
        NetManager.request(url: URLCountPatrolCount, method: .get, parameters: param, modelType: RespModal.self, resultBlock: block)
    }
    
    /// 巡检记录-网点-头部红色
    class func getCountPatrolPatr(withParam param: CountParam, block: ResponseBlock<CountPatrolPatrModal>?) {
        NetManager.request(url: URLCountPatrolPatr, method: .get, parameters: param, modelType: CountPatrolPatrModal.self, resultBlock: block)
    }
    
    /// 巡检记录-服务工程师-数据统计
    class func getCountSelectCount(withParam param: CountParam, block: ResponseBlock<RespModal>?) {
        NetManager.request(url: URLCountSelectCount, method: .get, parameters: param, modelType: RespModal.self, resultBlock: block)
    }
    
    /// 报表1-网点巡检状况统计
    class func getCountStutasCount(withParam param: CountParam, block: ResponseBlock<CountStutasModal>?) {
        NetManager.request(url: URLCountStutasCount, method: .get, parameters: param, modelType: CountStutasModal.self, resultBlock: block)
    }
    
    /// 报表3-获取报修前五项
    class func getCountTopfiveList(withParam param: CountParam, block: ResponseBlock<CountStutasModal>?) {
        NetManager.request(url: URLCountTopfiveList, method: .get, parameters: param, modelType: CountStutasModal.self, resultBlock: block)
    }
}

// MARK: - Modals
struct CountPatrolPatrModal: HandyJSON {
    var doing: Int64?
    var percent: Int64?
    var total: Int64?
    var undoing: Int64?
}

struct CountStutasModal: HandyJSON {
    var bq: String?
    var percent: Int64?
    var sl: Int64?
}

struct CountItemModal: HandyJSON {
    var ycwcl: Int64?
    var ycycl: Int64?
    var ycycll: String?
    var ycywll: String?
    var zc: Int64?
    var zcl: String?
    var zs: Int64?
}
