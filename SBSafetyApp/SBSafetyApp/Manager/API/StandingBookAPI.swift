//
//  StandingBook.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/12/1.
//

import Foundation
import HandyJSON

// MARK: - 电子台账
// MARK: - URL
let URLStandingBookDetail = "/standingBook/"                /// 获取详细信息
let URLStandingBookList = "/standingBook/list"             /// 台账历史记录列表
let URLStandingBookSave = "/standingBook/save"             /// 电子台账提交
let URLStandingBookSignout = "/standingBook/signout"       /// 签到离场
let URLStandingBookStatistics = "/standingBook/statistics" /// 统计
let URLStandingBookTypelist = "/standingBook/typelist"     /// 获取台账类型
let URLStandingBookUpload = "/standingBook/upload"         /// 上传图片
let URLStandingBookVisitor = "/standingBook/visitor"       /// 访客登记
let URLYjwxDztzSelectScaleByDept = "/yjwx/selectDztzScaleByDept" /// 根据部门查询电子台账完成率

class StandingBookStaticParam: Encodable {
    var date: String?     // 时间 2022-11-25
    var deptId: Int64?    // 部门ID
    var dateType: Int?    // 日：1月：2季：3年：4
    var tzlx: String?     // bookType
    
    init(date: String? = nil, deptId: Int64? = nil, dateType: Int? = nil, tzlx: String? = nil) {
        self.date = date
        self.deptId = deptId
        self.dateType = dateType
        self.tzlx = tzlx
    }
}

class StandingBookParam: Encodable {
    var date: String?     // 时间 2022-11-25
    var deptId: Int64?    // 部门ID
    var dateType: Int?    // 日：1月：2季：3年：4
    var bookId: Int64?    // 台账ID
    var bookType: String? // 台账类型
    var pageNum: Int64?   // 页数
    var pageSize: Int64?  // 每页条数
    
    init(date: String? = nil, deptId: Int64? = nil, dateType: Int? = nil, bookId: Int64? = nil, bookType: String? = nil, pageNum: Int64? = nil, pageSize: Int64? = nil) {
        self.date = date
        self.deptId = deptId
        self.dateType = dateType
        self.bookId = bookId
        self.bookType = bookType
        self.pageNum = pageNum
        self.pageSize = pageSize
    }
}

/// 电子台账提交
class StandingBookJsonParam: Encodable {
    var jsonStr: String?
}

class ElecParam: Encodable {
    var bookType: String?
    var tjrq: String?
    var attrValue0: String?
    var attrValue1: String?
    var attrValue2: String?
    var attrValue3: String?
    var attrValue4: String?
    var attrValue5: String?
    var attrValue6: String?
    var attrValue7: String?
    var attrValue8: String?
    var attrValue9: String?
    var attrValue10: String?
    var attrValue11: String?
    var attrValue12: String?
    var attrValue13: String?
    var attrValue14: String?
    var attrValue15: String?
    var attrValue16: String?
    var attrValue17: String?
    var attrValue18: String?
    var attrValue19: String?
    var attrValue20: String?
    var attrValue21: String?
    var attrValue22: String?
    var attrValue23: String?
    var attrValue24: String?
    var attrValue25: String?
    var attrValue26: String?
    var attrValue27: String?
    var attrValue28: String?
    var attrValue29: String?
    var attrValue30: String?
    var attrValue31: String?
    var attrValue32: String?
    var attrValue33: String?
    var attrValue34: String?
    
    init(bookType: String? = nil, tjrq: String? = nil, attrValue0: String? = nil, attrValue1: String? = nil, attrValue2: String? = nil, attrValue3: String? = nil, attrValue4: String? = nil, attrValue5: String? = nil, attrValue6: String? = nil, attrValue7: String? = nil, attrValue8: String? = nil, attrValue9: String? = nil, attrValue10: String? = nil, attrValue11: String? = nil, attrValue12: String? = nil, attrValue13: String? = nil, attrValue14: String? = nil, attrValue15: String? = nil, attrValue16: String? = nil, attrValue17: String? = nil, attrValue18: String? = nil, attrValue19: String? = nil, attrValue20: String? = nil, attrValue21: String? = nil, attrValue22: String? = nil, attrValue23: String? = nil, attrValue24: String? = nil, attrValue25: String? = nil, attrValue26: String? = nil, attrValue27: String? = nil, attrValue28: String? = nil, attrValue29: String? = nil, attrValue30: String? = nil, attrValue31: String? = nil, attrValue32: String? = nil, attrValue33: String? = nil, attrValue34: String? = nil) {
        self.bookType = bookType
        self.tjrq = tjrq
        self.attrValue0 = attrValue0
        self.attrValue1 = attrValue1
        self.attrValue2 = attrValue2
        self.attrValue3 = attrValue3
        self.attrValue4 = attrValue4
        self.attrValue5 = attrValue5
        self.attrValue6 = attrValue6
        self.attrValue7 = attrValue7
        self.attrValue8 = attrValue8
        self.attrValue9 = attrValue9
        self.attrValue10 = attrValue10
        self.attrValue11 = attrValue11
        self.attrValue12 = attrValue12
        self.attrValue13 = attrValue13
        self.attrValue14 = attrValue14
        self.attrValue15 = attrValue15
        self.attrValue16 = attrValue16
        self.attrValue17 = attrValue17
        self.attrValue18 = attrValue18
        self.attrValue19 = attrValue19
        self.attrValue20 = attrValue20
        self.attrValue21 = attrValue21
        self.attrValue22 = attrValue22
        self.attrValue23 = attrValue23
        self.attrValue24 = attrValue24
        self.attrValue25 = attrValue25
        self.attrValue26 = attrValue26
        self.attrValue27 = attrValue27
        self.attrValue28 = attrValue28
        self.attrValue29 = attrValue29
        self.attrValue30 = attrValue30
        self.attrValue31 = attrValue31
        self.attrValue32 = attrValue32
        self.attrValue33 = attrValue33
        self.attrValue34 = attrValue34
    }
}

// MARK: - API
extension API {
    /// 获取详细信息
    class func getStandingBookDetail(withId id: Int, block: ResponseBlock<StandingBookModal>?) {
        NetManager.request(url: "\(URLStandingBookDetail)\(id)", method: .get, modelType: StandingBookModal.self, resultBlock: block)
    }
    
    /// 台账历史记录列表
    class func getStandingBookList(withParam param: StandingBookParam, block: ResponseBlock<StandingBookModal>?) {
        NetManager.request(url: URLStandingBookList, method: .get, parameters: param, modelType: StandingBookModal.self, resultBlock: block)
    }
    
    /// 电子台账提交
    class func postStandingBookSave(withJson param: StandingBookJsonParam, block: ResponseBlock<RespModal>?) {
        NetManager.request(url: URLStandingBookSave, parameters: param, modelType: RespModal.self, resultBlock: block)
    }
    
    /// 签到离场
    class func postStandingBookSignout(withParam param: StandingBookParam, block: ResponseBlock<StandingBookModal>?) {
        NetManager.request(url: URLStandingBookSignout, parameters: param, modelType: StandingBookModal.self, resultBlock: block)
    }

    /// 统计
    class func getStandingBookStatistics(withParam param: StandingBookParam, block: ResponseBlock<StandingBookStatisticsModal>?) {
        NetManager.request(url: URLStandingBookStatistics, method: .get, parameters: param, modelType: StandingBookStatisticsModal.self, resultBlock: block)
    }
    
    /// 获取台账类型
    class func getStandingBookTypelist(witBlock block: ResponseBlock<StandingBookTypeModal>?) {
        NetManager.request(url: URLStandingBookTypelist, method: .get, modelType: StandingBookTypeModal.self, resultBlock: block)
    }
    
    /// 上传图片
    class func postStandingBookUpload(withImage imagePath: String, block: ResponseBlock<ImageModal>?) {
        NetManager.upload(url: URLStandingBookUpload, imagePath: imagePath, modelType: ImageModal.self, resultBlock: block)
    }
    
    /// 访客登记
    class func getStandingBookVisitor(withParam param: StandingBookParam, block: ResponseBlock<StandingBookModal>?) {
        NetManager.request(url: URLStandingBookVisitor, method: .get, parameters: param, modelType: StandingBookModal.self, resultBlock: block)
    }
    
    /// 根据部门查询电子台账完成率
    class func getDztzScaleByDept(withParam param: StandingBookStaticParam, block: ResponseBlock<CommonScaleByDeptModal>?) {
        NetManager.request(url: URLYjwxDztzSelectScaleByDept, method: .get, parameters: param, modelType: CommonScaleByDeptModal.self, resultBlock: block)
    }
}

// MARK: - Modals
struct StandingBookModal: HandyJSON {
    var bookId: Int64?
    var bookType: String?
    var tjrq: String?
    var status: String?
    var attrValue0: String?
    var attrValue1: String?
    var attrValue2: String?
    var attrValue3: String?
    var attrValue4: String?
    var attrValue5: String?
    var attrValue6: String?
    var attrValue7: String?
    var attrValue8: String?
    var attrValue9: String?
    var attrValue10: String?
    var attrValue11: String?
    var attrValue12: String?
    var attrValue13: String?
    var attrValue14: String?
    var attrValue15: String?
    var attrValue16: String?
    var attrValue17: String?
    var attrValue18: String?
    var attrValue19: String?
    var attrValue20: String?
    var attrValue21: String?
    var attrValue22: String?
    var attrValue23: String?
    var attrValue24: String?
    var attrValue25: String?
    var attrValue26: String?
    var attrValue27: String?
    var attrValue28: String?
    var attrValue29: String?
    var attrValue30: String?
    var attrValue31: String?
    var attrValue32: String?
    var attrValue33: String?
    var attrValue34: String?
    var deptName: String?
}

// 统计
struct StandingBookStatisticsModal: HandyJSON {
    var bdTotal: Int64?
    var percent: String?
    var unregTotal: Int64?
    var total: Int64?
    var complete: Int64?
}

// 获取台账类型
struct StandingBookTypeModal: HandyJSON {
    var typeLabel: String?
    var djbs: String?
//    var typeCode: Int64?
//    var typeSort: Int64?
    var typeValue: String?
    var remark: String?
    var status: String?
    var fpfs: String?
}
