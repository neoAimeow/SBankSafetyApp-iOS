//
//  EngineerAPI.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/12/12.
//

import Foundation
import HandyJSON

// MARK: - 维修工程师

// MARK: - URL
let URLEngineerArrive = "/engineer/arrive" /// 服务工程师-到达
let URLEngineerDetail = "/engineer/detail" /// 服务工程师-巡检详情
let URLEngineerFinish = "/engineer/finish" /// 服务工程师-完工
let URLEngineerPatrol = "/engineer/patrol" /// 巡检
let URLEngineerRemind = "/engineer/remind" /// 服务工程师-未完成任务提醒
let URLEngineerUpdate = "/engineer/update" /// 状态

// MARK: - API

/// Common
class EngineerParam: Encodable {
    var formId: Int64? /// formId 巡检单ID
    var sign: String? /// sign 图片路径
    /// context 总结
    /// imgUrl 签字图片
    /// deptId 部门ID 过期未完成-必传
    /// type 类型 空参工程师提醒 0过期未完成
    init(formId: Int64? = nil, sign: String? = nil) {
        self.formId = formId
        self.sign = sign
    }
}

/// 巡检
class EngineerPatrolParam: Encodable {
    /// comment 情况说明
    /// imgUrl 签字图片
    /// recordId 巡检记录ID
    /// status 状态 0正常1异常
    /// tmplId 巡检项ID
}

extension API {
    /// 服务工程师-到达
    class func postEngineerArrive(withParam param: EngineerParam, block: ResponseBlock<RespModal>?) {
        NetManager.request(url: URLEngineerArrive, parameters: param, modelType: RespModal.self, resultBlock: block)
    }
    
    /// 服务工程师-巡检详情
    class func getEngineerDetail(withParam param: EngineerParam, block: ResponseBlock<ParListModal>?) {
        NetManager.request(url: URLEngineerDetail, method: .get, parameters: param, modelType: ParListModal.self, resultBlock: block)
    }
    
    /// 服务工程师-完工
    class func postEngineerFinish(withParam param: EngineerParam, block: ResponseBlock<RespModal>?) {
        NetManager.request(url: URLEngineerFinish, parameters: param, modelType: RespModal.self, resultBlock: block)
    }
    
    /// 巡检
    class func postEngineerPatrol(withParam param: EngineerParam, block: ResponseBlock<RespModal>?) {
        NetManager.request(url: URLEngineerPatrol, parameters: param, modelType: RespModal.self, resultBlock: block)
    }
    
    /// 服务工程师-未完成任务提醒
    class func getEngineerRemind(withParam param: EngineerParam, block: ResponseBlock<RespModal>?) {
        NetManager.request(url: URLEngineerRemind, method: .get, parameters: param, modelType: RespModal.self, resultBlock: block)
    }
    
    /// 状态
    class func postEngineerUpdate(withParam param: EngineerParam, block: ResponseBlock<RespModal>?) {
        NetManager.request(url: URLEngineerUpdate, parameters: param, modelType: RespModal.self, resultBlock: block)
    }
    
}

// MARK: - Modals

struct PatrolRecordModal: HandyJSON {
    var boscPatrolTemplate: String?
    var createBy: String?
    var createTime: String?
    var disposeStatus: String?
    var formId: Int64?
    var formSn: String?
    var images: [[String: String]]?
    var itemId: String?
    var itemName : String?
    var lngLat: String?
    var location: String?
    var recordId : Int64?
    var remark: String?
    var status: Int64?
    var summary: String?
    var tmplId: Int64?
    var tmplName: String?
}
