//
//  HomeAPI.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/12/1.
//

import Foundation
import HandyJSON

// MARK: - 入口-首页

// MARK: - URL
let URLHomeDeptall = "/home/deptall"   /// 支行态势
let URLHomeStastic = "/home/stastic"   /// 报警、撤布妨统计
let URLHomeStateall = "/home/stateall" /// 全行态势

class HomeParam: Encodable {
    var deptName: String? // 网点名称
    var type: Int?      // 类型： 0.日 1.月 3.年
    var deptId: Int64?    // 支行网点ID
    var date: String?    // 日期
    var dateType: Int?  // 类型： 0.日 1.月 3.年

    init(deptName: String? = nil, type: Int? = nil, deptId: Int64? = nil, date: String? = nil, dateType: Int? = nil) {
        self.deptName = deptName
        self.type = type
        self.deptId = deptId
        self.date = date
        self.dateType = dateType
    }
}

// MARK: - API
extension API {
    /// 支行态势
    class func getHomeDeptall(withParam param: HomeParam, block: ResponseBlock<DeptModal>?) {
        NetManager.request(url: URLHomeDeptall, method: .get, parameters: param, modelType: DeptModal.self, resultBlock: block)
    }

    /// 报警、撤布妨统计
    class func getHomeStastic(withParam param: HomeParam, block: ResponseBlock<HomeStasticModal>?) {
        NetManager.request(url: URLHomeStastic, method: .get, parameters: param, modelType: HomeStasticModal.self, resultBlock: block)
    }

    /// 全行态势
    class func getHomeStateall(withParam param: HomeParam, block: ResponseBlock<HomeTallModal>?) {
        NetManager.request(url: URLHomeStateall, method: .get, parameters: param, modelType: HomeTallModal.self, resultBlock: block)
    }
}

// MARK: - Modals
// 全行态势
struct HomeTallModal: HandyJSON {
    var patorlPercent: HomeTallItemModal?
    var repairPercent: HomeTallItemModal?
    var yjczTotal: HomeTallItemModal?
    var bazgl: HomeTallItemModal?
    var baPercent: HomeTallItemModal?
    var lzPercent: HomeTallItemModal?
    var bookPercent: HomeTallItemModal?
}

struct HomeTallItemModal: HandyJSON {
    var wcl: Double = 0.0
    var qsbl: Double = 0.0
}

// 报警、撤布妨统计
struct HomeStasticModal: HandyJSON {
    var uncbfTotal: Int64?
    var alarmCount: Int64?
    var repairCount: Int64?
    var cbfTotal: Int64?
}
