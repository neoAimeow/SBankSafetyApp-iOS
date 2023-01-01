//
//  ParAPI.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/12/2.
//

import Foundation
import HandyJSON

// MARK: - 维保服务

// MARK: - URL
let URLParBranchStaffConfirm = "/par/branchStaffConfirm" /// 网点工作人员确认
let URLParCaptchaImage = "/par/captchaImage"             /// 图形验证码
let URLParCnameList = "/par/cname_list"                  /// 获取工程商列表
let URLParCoordinatConvert = "/par/coordinate/convert"   /// 坐标转换
let URLParFromList = "/par/from_list"                    /// 维保服务-巡检记录
let URLParList = "/par/list"                             /// 维保服务-首页
let URLParRecord = "/par/record"                         /// 巡检结果
let URLParResult = "/par/result"                         /// 维保服务-巡检结果
let URLParSave = "/par/save"                             /// 新增巡检服务单
let URLParSetting = "/par/setting"                       /// 系统设置
let URLParUpload = "/par/upload"                         /// 维保服务-上传图片
let URLParZrwd = "/par/zrwd"                             /// 维保服务-责任网点

/// Common
class ParParam: Encodable {
    var bxqm: String?      // 签名地址
    var id: Int64?           // 巡检维修单id
    var dictValue: String? // 服务范围
    var lngLat: String?    // 坐标点，逗号分割
    var data: String?      // data
    var fromId: Int64?       // 巡检单ID 3运行正常 4运行异常
    init(bxqm: String? = nil, id: Int64? = nil, dictValue: String? = nil, lngLat: String? = nil, data: String? = nil, fromId: Int64? = nil) {
        self.bxqm = bxqm
        self.id = id
        self.dictValue = dictValue
        self.lngLat = lngLat
        self.data = data
        self.fromId = fromId
    }
}

/// 维保服务-巡检记录
class ParFormParam: Encodable {
    var deptid: Int64?      // 部门ID
    var dictLabel: String?  // 模板标签 getCountListFirst的wbType
    var endTime: String?     // 巡检结束时间 例如 2022.11.21 23:21:12
    var startTime: String?  // 巡检开始时间 例如 2022.11.20 23:21:12
    var status: String?      // 状态 0-6
    var type: String?       // 类型 总行/分行/支行/网点都为空，工程师传0：我的巡检；1是巡检列表
    var pageSize: Int64?
    var pageNum: Int64?
    
    init(deptid: Int64? = nil, dictLabel: String? = nil, endTime: String? = nil, startTime: String? = nil, status: String? = nil, type: String? = nil, pageSize: Int64? = nil, pageNum: Int64? = nil) {
        self.deptid = deptid
        self.dictLabel = dictLabel
        self.endTime = endTime
        self.startTime = startTime
        self.status = status
        self.type = type
        self.pageSize = pageSize
        self.pageNum = pageNum
    }
}

/// 维保服务-首页
class ParHomeParam: Encodable {
    var deptId: Int64? // 网点是：自己的部门，工程师不用传
    var mouth: String? // 巡检月份 例如：2022年11月 mouth=202211
    
    init(deptId: Int64? = nil, mouth: String? = nil) {
        self.deptId = deptId
        self.mouth = mouth
    }
}

// 新增巡检服务单
class ParSaveParam: Encodable {
    var deptId: Int64? // 网点ID
    var deptName: String? // 网点名称
    var jsonStr: String? // jsonStr
    var pcpName: String? // 网点责任人
    var serviceCompanyId: Int64? // 服务商ID
    var serviceCompanyName: String? // 服务商名称
    var tmplLable: String?  // 巡检模板名称 模板列表中的dictLabel
    var tmplValue: Int64? // 巡检模板值 模板列表中的dictValue
}

// 维保服务-责任网点
class ParZrwdParam: Encodable {
    var bxqm: String?
    var createBy: String?
    var createTime: String?
    var deptId: Int64?
    var deptName: String?
    var dictLable: String?
    var endTime: String?
    var formId: Int64?
    var formSn: String?
    var formType: String?
    var local: String?
    var mouth: String?
    var `operator`: String?
    var operatorPhone: String?
//    var params: Any?
}

// MARK: - API
extension API {
    /// 网点工作人员确认
    class func postParBranchStaffConfirm(withParam param: ParParam, block: ResponseBlock<RespModal>?) {
        NetManager.request(url: URLParBranchStaffConfirm, parameters: param, modelType: RespModal.self, resultBlock: block)
    }
    
    /// 图形验证码
    class func getParCaptchaImage(withBlock block: ResponseBlock<RespModal>?) {
        NetManager.request(url: URLParCaptchaImage, method: .get, modelType: RespModal.self, resultBlock: block)
    }
    
    /// 获取工程商列表
    class func getParCnameList(withParam param: ParParam, block: ResponseBlock<RespModal>?) {
        NetManager.request(url: URLParCnameList, method: .get, parameters: param, modelType: RespModal.self, resultBlock: block)
    }
    
    /// 坐标转换
    class func getParCoordinatConvert(withParam param: ParParam, block: ResponseBlock<RespModal>?) {
        NetManager.request(url: URLParCoordinatConvert, method: .get, parameters: param, modelType: RespModal.self, resultBlock: block)
    }
    
    /// 维保服务-巡检记录
    class func getParFromList(withParam param: ParFormParam, block: ResponseBlock<ParListModal>?) {
        NetManager.request(url: URLParFromList, method: .get, parameters: param, modelType: ParListModal.self, resultBlock: block)
    }
    
    /// 维保服务-首页
    class func getParList(withParam param: ParHomeParam, block: ResponseBlock<ParTemplateModal>?) {
        NetManager.request(url: URLParList, method: .get, parameters: param, modelType: ParTemplateModal.self, resultBlock: block)
    }
    
    /// 巡检结果
    class func postParRecord(withParam param: ParParam, block: ResponseBlock<RespModal>?) {
        NetManager.request(url: URLParRecord, parameters: param, modelType: RespModal.self, resultBlock: block)
    }
    
    /// 维保服务-巡检结果
    class func getParResult(withParam param: ParParam, block: ResponseBlock<RespModal>?) {
        NetManager.request(url: URLParResult, method: .get, parameters: param, modelType: RespModal.self, resultBlock: block)
    }
    
    /// 新增巡检服务单
    class func postParSave(withParam param: ParSaveParam, block: ResponseBlock<RespModal>?) {
        NetManager.request(url: URLParSave, parameters: param, modelType: RespModal.self, resultBlock: block)
    }
    
    /// 系统设置
    class func getParSetting(withBlock block: ResponseBlock<RespModal>?) {
        NetManager.request(url: URLParSetting, method: .get, modelType: RespModal.self, resultBlock: block)
    }
    
    /// 维保服务-上传图片  post
    class func postParUpload(withParam param: ParParam, block: ResponseBlock<RespModal>?) {
        NetManager.request(url: URLParUpload, parameters: param, modelType: RespModal.self, resultBlock: block)
    }
    
    /// 维保服务-责任网点
    class func getParZrwd(withParam param: ParZrwdParam, block: ResponseBlock<RespModal>?) {
        NetManager.request(url: URLParZrwd, method: .get, parameters: param, modelType: RespModal.self, resultBlock: block)
    }
}

// MARK: - Modals
// 维保服务-首页
struct ParTemplateModal: HandyJSON {
    var dictCode: Int64?
    var dictLabel: String?
    var dictValue: String?
    var isAbnormal: Int64?
    var status: Int64?
    var dictSort: Int64?
    var dictType: String?
    var remark: String?
    var sfyc: Int64?
}

// 维保服务-巡检记录
struct ParListModal: HandyJSON {
    var bxqm: String?
    var createBy: String?
    var createTime: String?
    var deptId: Int64?
    var deptName: String?
    var dictLable: String?
    var endTime: String?
    var formId: Int64?
    var formSn: String?
    var formType: Int64?
    var gcsjssj: String?
    var gcskssj: String?
    var local: String?
    var mouth: String?
    var mouthTime: String?
    var `operator`: String?
    var operatorPhone: String?
    var patrolTemplate: String?
    var pcpName: String?
    var pcpPhone: String?
    var qrsj: String?
    var remark: String?
    var rwxfpc: String?
    var searchValue: String?
    var serviceCompanyId: Int64?
    var serviceCompanyName: String?
    var serviceEngineerName: String?
    var serviceEngineerPhone: String?
    var serviceEngineerUserId: String?
    var sign: String?
    var startTime: String?
    var status: Int64?
    var statusStr: String?
    var tmplLable: String?
    var tmplValue: Int64?
    var type: String?
    var userId: String?
    var wdqm: String?
    var patrolRecord: [PatrolRecordModal]?
}
