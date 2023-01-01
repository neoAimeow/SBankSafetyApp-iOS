//
//  WblistAPI.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/12/6.
//

import Foundation
import HandyJSON

// MARK: - 维保服务完成率

// MARK: - URL
let URLWbListCountListFirst = "/wbList/getCountListFirst" // getCountListFirst
let URLWbListCountList = "/wbList/getCountList" /// 查询完成率

/// Common
class WbListParam: Encodable {
    var date: String?
    var dateType: Int?
    var deptId: Int64?
    var wbtype: String?
    
    init(date: String? = nil, dateType: Int? = nil, deptId: Int64? = nil, wbtype: String? = nil) {
        self.date = date
        self.dateType = dateType
        self.deptId = deptId
        self.wbtype = wbtype
    }
}

extension API {
    /// getCountListFirst
    class func getWbListCountListFirst(withParam param: WbListParam, block: ResponseBlock<WbCLFirstModal>?) {
        NetManager.request(url: URLWbListCountListFirst, method: .get, parameters: param, modelType: WbCLFirstModal.self, resultBlock: block)
    }
     
    /// 查询完成率
    class func getWbListCountList(withParam param: WbListParam, block: ResponseBlock<CommonScaleByDeptModal>?) {
        NetManager.request(url: URLWbListCountList, method: .get, parameters: param, modelType: CommonScaleByDeptModal.self, resultBlock: block)
    }
}

// 维保查询完成率First
struct WbCLFirstModal: HandyJSON {
    var wwcs: Int64?
    var ywcs: Int64?
    var wclList: [WbWclModal?]?
    var rwzs: Int64?
    var zwcl: Int64?
    var cqwwcList: [Any]?
}

struct WbWclModal: HandyJSON {
    var name: String?
    var wbType: String?
    var wcl: String?
}
