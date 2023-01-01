//
//  YjwxAPI.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/12/3.
//

import Foundation
import HandyJSON

// MARK: - 一键维修

// MARK: - URL

let URLYjwxBranchStaffCancel = "/yjwx/branchStaffCancel" /// 网点人员取消
let URLYjwxBranchStaffConfirm = "/yjwx/branchStaffConfirm" /// 网点工作人员确认
let URLYjwxBranchStaffConfirmDetail = "/yjwx/branchStaffConfirmDetail" /// 网点工作人员确认详情
let URLYjwxEngineerArrive = "/yjwx/engineerArrive" /// 维修工程师到达
let URLYjwxEngineerOrderTaking = "/yjwx/engineerOrderTaking" /// 维修工程师接单
let URLYjwxEngineerRestore = "/yjwx/engineerRestore" /// 维修工程师修复
let URLYjwxEngineerRestoreDetail = "/yjwx/engineerRestoreDetail" /// 维修工程师修复详情
let URLYjwxEngineerRestoreDict = "/yjwx/engineerRestoreDict" /// 维修工程师修复字典
let URLYjwxGetBxdComment = "/yjwx/getBxdComment" /// 查询报修单评论
let URLYjwxGetBxdDetail = "/yjwx/getBxdDetail" /// 查询报修单详情
let URLYjwxGetBxdEvaluate = "/yjwx/getBxdEvaluate" /// 查询报修单评价
let URLYjwxGetDhbxList = "/yjwx/getDhbxList" /// 电话报修
let URLYjwxGetFswzList = "/yjwx/getFswzList" /// 查询发生位置
let URLYjwxGetGzList = "/yjwx/getGzList" /// 查询故障列表
let URLYjwxGetList = "/yjwx/getList" /// 报修单列表
let URLYjwxGetListTotal = "/yjwx/getListTotal" /// 获取报修单完成数
let URLYjwxGetRecordList = "/yjwx/getRecordList" /// 查询报修单记录列表
let URLYjwxInsertBxdComment = "/yjwx/insertBxdComment" /// 新增报修单评论
let URLYjwxInsertBxdEvaluate = "/yjwx/insertBxdEvaluate" /// 新增报修单评价
let URLYjwxInsertRepairOrder = "/yjwx/insertRepairOrder" /// 保存报修单列表
let URLYjwxMoreServices = "/yjwx/moreServices" /// 更多服务
let URLYjwxSelectScaleByDept = "/yjwx/selectScaleByDept" /// 根据部门查询完成率
let URLYjwxUpload = "/yjwx/upload" /// 上传图片-附件

/// Common
class YjwxParam: Encodable {
    var id: Int64?
    var bxqm: String?
    var longitude: String?
    var latitude: String?
    var baseRl: String?
    var deptId: Int64?
    var dateType: Int?
    var date: String?
    var bxdid: String?

    init(id: Int64? = nil, bxqm: String? = nil, longitude: String? = nil, latitude: String? = nil, baseRl: String? = nil, deptId: Int64? = nil, dateType: Int? = nil, date: String? = nil, bxdid: String? = nil) {
        self.id = id
        self.bxqm = bxqm
        self.longitude = longitude
        self.latitude = latitude
        self.baseRl = baseRl
        self.deptId = deptId
        self.dateType = dateType
        self.date = date
        self.bxdid = bxdid
    }
}

/// 报修单列表
class YjwxListParam: Encodable {
    var wddm: Int64?
    var ddzt: Int64? // 0-6
    var bxrid: String? // 选择本人报修传用户id，全部报修则不选择
    var pageSize: Int64?
    var pageNum: Int64?
    var wxgcsid: String?
    var qbsj: Int64?

    init(wddm: Int64? = nil, ddzt: Int64? = nil, bxrid: String? = nil, pageSize: Int64? = nil, pageNum: Int64? = nil, wxgcsid: String? = nil, qbsj: Int64? = nil) {
        self.wddm = wddm
        self.ddzt = ddzt
        self.bxrid = bxrid
        self.pageSize = pageSize
        self.pageNum = pageNum
        self.wxgcsid = wxgcsid
        self.qbsj = qbsj
    }
}

/// 保存报修单列表
class YjwxCreateOrderParam: Encodable {
    var wddm: String? //网点代码
    var wdmc: String? //网点名称
    var wdqc: String? //网点全称 地址（支行名称）
    var bxrmc: String? //报修人名称
    var bxrid: String? //报修人id
    var wdzrr: String? //网点责任人
    var bxgzmc: String? //报修故障名称
    var bxgzdm: String? //报修故障代码
    var fswz: String? //发生位置
    var bxgzms: String? //故障描述
    var enclosureList: [[String: String]]? //报修附件
}

/// 维修工程师修复
class YjwxRestoreParam: Encodable {
    var bxdid: String? //报修单id
    var gcsid: String? //工程师id 用户id
    var gzpp: String? //故障品牌
    var gzlx: String? //故障类型
    var gzsb: String? //故障设备
    var gzxx: String? //故障现象
    var gzyy: String? //故障原因
    var wzxx: String? //位置信息
    var wxms: String? //维修描述
    var xfcg: String? //修复成功（0否 1是）
    var ghsb: String? //更换设备（0否 1是）
    var wxdj: String? //维修单价
    var fwlx: String? //服务类型
    var fwms: String? //服务描述
    var fwdj: String? //服务单价
    var wxbj: String? //维修报价

    init(bxdid: String? = nil, gcsid: String? = nil, gzpp: String? = nil, gzlx: String? = nil, gzsb: String? = nil, gzxx: String? = nil, gzyy: String? = nil, wzxx: String? = nil, wxms: String? = nil, xfcg: String? = nil, ghsb: String? = nil, wxdj: String? = nil, fwlx: String? = nil, fwms: String? = nil, fwdj: String? = nil, wxbj: String? = nil) {
        self.bxdid = bxdid
        self.gcsid = gcsid
        self.gzpp = gzpp
        self.gzlx = gzlx
        self.gzsb = gzsb
        self.gzxx = gzxx
        self.gzyy = gzyy
        self.wzxx = wzxx
        self.wxms = wxms
        self.xfcg = xfcg
        self.ghsb = ghsb
        self.wxdj = wxdj
        self.fwlx = fwlx
        self.fwms = fwms
        self.fwdj = fwdj
        self.wxbj = wxbj
    }
}

/// 新增报修单评价
class YjwxEvaluateParam: Encodable {
    var bxdid: String? //报修单id
    var xfsd: Int? //修复速度（星级）
    var wxxg: Int? //维修效果（星级）
    var fwtd: Int? //服务态度（星级）
    var wxhp: Int? //五星好评（0否 1是）
    var xysdk: Int? //响应速度快（0否 1是）
    var xfjs: Int? //修复及时（0否 1是）
    var fwtdh: Int? //服务态度好（0否 1是）
    var jsjz: Int? //计算精湛（0否 1是）
    var rzds: Int? //人长得帅（0否 1是）
    var pjnr: String? //评价内容

    init(bxdid: String? = nil, xfsd: Int? = nil, wxxg: Int? = nil, fwtd: Int? = nil, wxhp: Int? = nil, xysdk: Int? = nil, xfjs: Int? = nil, fwtdh: Int? = nil, jsjz: Int? = nil, rzds: Int? = nil, pjnr: String? = nil) {
        self.bxdid = bxdid
        self.xfsd = xfsd
        self.wxxg = wxxg
        self.fwtd = fwtd
        self.wxhp = wxhp
        self.xysdk = xysdk
        self.xfjs = xfjs
        self.fwtdh = fwtdh
        self.jsjz = jsjz
        self.rzds = rzds
        self.pjnr = pjnr
    }
}

/// 维修工程师修复 &  新增报修单评价 & 保存报修单列表
class YjwxJsonParam: Encodable {
    var jsonStr: String?
}

/// 新增报修单评论
class YjwxCommentParam: Encodable {
    var bxdid: Int64?
    var plnr: String?

    init(bxdid: Int64? = nil, plnr: String? = nil) {
        self.bxdid = bxdid
        self.plnr = plnr
    }
}

// MARK: - API

extension API {
    /// 网点人员取消✅已对接
    class func postYjwxBranchStaffCancel(withParam param: YjwxParam, block: ResponseBlock<RespModal>?) {
        NetManager.request(url: URLYjwxBranchStaffCancel, parameters: param, modelType: RespModal.self, resultBlock: block)
    }

    /// 网点工作人员确认✅已对接
    class func postYjwxBranchStaffConfirm(withParam param: YjwxParam, block: ResponseBlock<RespModal>?) {
        NetManager.request(url: URLYjwxBranchStaffConfirm, parameters: param, modelType: RespModal.self, resultBlock: block)
    }

    /// 网点工作人员确认详情✅已对接
    class func getYjwxBranchStaffConfirmDetail(withParam param: YjwxParam, block: ResponseBlock<YjwxBStaffConfirmModal>?) {
        NetManager.request(url: URLYjwxBranchStaffConfirmDetail, method: .get, parameters: param, modelType: YjwxBStaffConfirmModal.self, resultBlock: block)
    }

    /// 维修工程师到达✅已对接
    class func postYjwxEngineerArrive(withParam param: YjwxParam, block: ResponseBlock<RespModal>?) {
        NetManager.request(url: URLYjwxEngineerArrive, parameters: param, modelType: RespModal.self, resultBlock: block)
    }

    /// 维修工程师接单✅已对接
    class func postYjwxEngineerOrderTaking(withParam param: YjwxParam, block: ResponseBlock<RespModal>?) {
        NetManager.request(url: URLYjwxEngineerOrderTaking, parameters: param, modelType: RespModal.self, resultBlock: block)
    }

    /// 维修工程师修复✅已对接
    class func postYjwxEngineerRestore(withParam param: YjwxJsonParam, block: ResponseBlock<RespModal>?) {
        NetManager.request(url: URLYjwxEngineerRestore, parameters: param, modelType: RespModal.self, resultBlock: block)
    }

    /// 维修工程师修复详情✅已对接
    class func getYjwxEngineerRestoreDetail(withParam param: YjwxParam, block: ResponseBlock<YjwxRestoreModal>?) {
        NetManager.request(url: URLYjwxEngineerRestoreDetail, method: .get, parameters: param, modelType: YjwxRestoreModal.self, resultBlock: block)
    }

    /// 维修工程师修复字典✅已对接
    class func getYjwxEngineerRestoreDict(withBlock block: ResponseBlock<YjwxRestoreDictModal>?) {
        NetManager.request(url: URLYjwxEngineerRestoreDict, method: .get, modelType: YjwxRestoreDictModal.self, resultBlock: block)
    }

    /// 查询报修单评论✅已对接
    class func getYjwxGetBxdComment(withParam param: YjwxParam, block: ResponseBlock<YjwxCommonModal>?) {
        NetManager.request(url: URLYjwxGetBxdComment, method: .get, parameters: param, modelType: YjwxCommonModal.self, resultBlock: block)
    }

    /// 查询报修单详情✅已对接
    class func getYjwxGetBxdDetail(withParam param: YjwxParam, block: ResponseBlock<YjwxListModal>?) {
        NetManager.request(url: URLYjwxGetBxdDetail, method: .get, parameters: param, modelType: YjwxListModal.self, resultBlock: block)
    }

    /// 查询报修单评价✅已对接
    class func getYjwxGetBxdEvaluate(withParam param: YjwxParam, block: ResponseBlock<YjwxEvaluateModal>?) {
        NetManager.request(url: URLYjwxGetBxdEvaluate, method: .get, parameters: param, modelType: YjwxEvaluateModal.self, resultBlock: block)
    }

    /// 电话报修✅已对接
    class func getYjwxGetDhbxList(withBlock block: ResponseBlock<YjwxDhbxModal>?) {
        NetManager.request(url: URLYjwxGetDhbxList, method: .get, modelType: YjwxDhbxModal.self, resultBlock: block)
    }

    /// 查询发生位置✅已对接
    class func getYjwxGetFswzList(withBlock block: ResponseBlock<YjwxFswzModal>?) {
        NetManager.request(url: URLYjwxGetFswzList, method: .get, modelType: YjwxFswzModal.self, resultBlock: block)
    }

    /// 查询故障列表✅已对接
    class func getYjwxGetGzList(withParam param: YjwxParam, block: ResponseBlock<YjwxGzListModal>?) {
        NetManager.request(url: URLYjwxGetGzList, method: .get, parameters: param, modelType: YjwxGzListModal.self, resultBlock: block)
    }

    /// 报修单列表✅已对接
    class func getYjwxGetList(withParam param: YjwxListParam, block: ResponseBlock<YjwxListModal>?) {
        NetManager.request(url: URLYjwxGetList, method: .get, parameters: param, modelType: YjwxListModal.self, resultBlock: block)
    }

    /// 获取报修单完成数✅已对接
    class func getYjwxGetListTotal(withBlock block: ResponseBlock<YjwxListTotalModal>?) {
        NetManager.request(url: URLYjwxGetListTotal, method: .get, modelType: YjwxListTotalModal.self, resultBlock: block)
    }

    /// 查询报修单记录列表✅已对接
    class func getYjwxGetRecordList(withParam param: YjwxParam, block: ResponseBlock<YjwxRecordModal>?) {
        NetManager.request(url: URLYjwxGetRecordList, method: .get, parameters: param, modelType: YjwxRecordModal.self, resultBlock: block)
    }

    /// 新增报修单评论✅已对接
    class func postYjwxInsertBxdComment(withParam param: YjwxCommentParam, block: ResponseBlock<RespModal>?) {
        NetManager.request(url: URLYjwxInsertBxdComment, parameters: param, modelType: RespModal.self, resultBlock: block)
    }

    /// 新增报修单评价❌已对接，但有问题
    class func postYjwxInsertBxdEvaluate(withParam param: YjwxJsonParam, block: ResponseBlock<RespModal>?) {
        NetManager.request(url: URLYjwxInsertBxdEvaluate, parameters: param, modelType: RespModal.self, resultBlock: block)
    }

    /// 保存报修单列表✅已对接
    class func postYjwxInsertRepairOrder(withParam param: YjwxJsonParam, block: ResponseBlock<RespModal>?) {
        NetManager.request(url: URLYjwxInsertRepairOrder, parameters: param, modelType: RespModal.self, resultBlock: block)
    }

    /// 更多服务✅已对接
    class func getYjwxMoreServices(withBlock block: ResponseBlock<YjwxServicesModal>?) {
        NetManager.request(url: URLYjwxMoreServices, method: .get, modelType: YjwxServicesModal.self, resultBlock: block)
    }

    /// 根据部门查询完成率✅已对接
    class func getYjwxSelectScaleByDept(withParam param: YjwxParam, block: ResponseBlock<CommonScaleByDeptModal>?) {
        NetManager.request(url: URLYjwxSelectScaleByDept, method: .get, parameters: param, modelType: CommonScaleByDeptModal.self, resultBlock: block)
    }

    /// 上传图片-附件✅已对接
    class func postYjwxUpload(withImage imagePath: String, block: ResponseBlock<ImageModal>?) {
        NetManager.upload(url: URLYjwxUpload, imagePath: imagePath, modelType: ImageModal.self, resultBlock: block)
    }
}

//

struct ImageModal: HandyJSON {
    var imgUrl: String?
}

// MARK: - Modals

// 电话报修
struct YjwxDhbxModal: HandyJSON {
    var id: Int64?
    var gcsfzr: String?
    var gcsmc: String?
    var gcsfwfcmc: String?
    var gcsfwfcdm: String?
    var wbfwfcdm: String?
    var gcsfwfcmcarr: [String]?
    var gcsfwfcdmarr: [String]?
    var gcsfzrlxdh: String?
}

/// [总行看数据]根据部门查询完成率
struct CommonScaleByDeptModal: HandyJSON {
    var zwcl: String?
    var wdList: [TaskDeptRateModal]?
    var zxList: [TaskRateModal]?
    var title: String?
}

struct TaskDeptRateModal: HandyJSON {
    var zwcl: String?
    var deptPosition: String?
    var sfczzj: Bool?
    var wddm: Int64?
    var wdlxr: String?
    var wdlxrhm: String?
    var wdmc: String?
    var wxds: Int64?
    var wxwcs: Int64?
    var rwzs: Int?
    var wcs: Int?
    var ycs: Int?
}

struct TaskRateModal: HandyJSON {
    var zwcl: String?
    var week: String?
    var date: String?
}

// 获取报修单完成数

struct YjwxListTotalModal: HandyJSON {
    var wcl: String?
    var wdwx: String?
    var ywc: String?
    var wwc: String?
}

// 报修单列表

struct YjwxListModal: HandyJSON {
    var bxdh: String?
    var bxgzdm: Int64?
    var bxgzmc: String?
    var bxrid: Int64?
    var bxrmc: String?
    var bxsj: String?
    var createTime: String?
    var ddzt: Int?
    var enclosureListStr: [String]?
    var fswzmc: String?
    var id: Int64?
    var sfpj: Int64?
    var wddm: Int64?
    var wdmc: String?
    var wdqc: String?
    var wdzrr: String?
    var updateTime: String?
    var wcxfsj: String?
    var wxgcsid: String?
    var wxgcs: String?
    var wxgcsdm: Int64?
    var wxgcsmc: String?
    var jdsjc: Double?
    var jdsj: String?
    var bxqm: String?
    var bxgzms: String?
}

// 查询发生位置

struct YjwxFswzModal: HandyJSON {
    var id: String?
    var name: String?
    var child: [YjwxFswzModal]?
}

// 故障列表

struct YjwxGzListModal: HandyJSON {
    var tswb: String?
    var data: [YjwxGzModal]?
}

struct YjwxGzModal: HandyJSON {
    var id: Int64?
    var wddm: Int64?
    var fwfcid: Int64?
    var fwfcmc: String?
}

/// 查询报修单记录列表
struct YjwxRecordModal: HandyJSON {
    var bxdid: Int64?
    var bxjlsj: String?
    var bxjlwz: String?
    var bxjlxh: Int64?
    var bxjlztdm: Int?
    var bxjlztmc: String?
    var id: Int64?
}

/// 查询报修单评论
struct YjwxCommonModal: HandyJSON {
    var avatar: String?
    var bxdid: Int64?
    var id: Int64?
    var plnr: String?
    var plsj: String?
    var plyh: String?
    var plyhid: Int64?
}

struct YjwxBStaffConfirmModal: HandyJSON {
    var order: YjwxListModal?
    var restore: YjwxRestoreModal?
}

/// 维修记录
struct YjwxRestoreModal: HandyJSON {
    var bxdid: Int64?
    var fwdj: Int64?
    var fwlx: String?
    var fwms: String?
    var gcsid: Int64?
    var ghsb: String?
    var gzlx: String?
    var gzpp: String?
    var gzsb: String?
    var gzxx: String?
    var gzyy: String?
    var id: Int64?
    var wxbj: Int64?
    var wxdj: Int64?
    var wxms: String?
    var wxsj: String?
    var wzxx: String?
    var xfcg: String?
}

// 更多服务

struct YjwxServicesModal: HandyJSON {
    var jrbx: String?
    var jrqx: String?
    var jrwg: String?
}

// 维修工程师默认字典

struct YjwxRestoreDictModal: HandyJSON {
    var type: String?
    var dictLabel: String?
    var dictValue: String?
}

/// 查看报修单评价
struct YjwxEvaluateModal: HandyJSON {
    var bxdid: Int64?
    var id: Int64?
    var xfsd: Int?
    var wxxg: Int?
    var fwtd: Int?
    var wxhp: Int?
    var xysdk: Int?
    var xfjs: Int?
    var fwtdh: Int?
    var jsjz: Int?
    var rzds: Int?
    var pjnr: String?
}
