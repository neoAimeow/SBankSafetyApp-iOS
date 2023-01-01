//
// Created by Aimeow on 2022/12/8.
//

import Foundation
import HandyJSON

struct TaskCompleteModel: HandyJSON {
    var searchValue: Any?
    var createBy: Any?
    var createTime: String?
    var updateBy: Any?
    var updateTime: Any?
    var remark: Any?
    var params: Any?
    var id: Int64?
    var rwid: Int64?
    var rwmbid: Any?
    var lzrid: Any?
    var lzrmc: String?
    var wddm: Int?
    var wdmc: String?
    var lzrhm: Any?
    var rwlxdm: String?
    var rwlxmc: String?
    var rwmc: String?
    var rwzq: String?
    var rwzxkssj: String?
    var rwzxssj: String?
    var lng: Any?
    var lat: Any?
    var rwqm: Any?
    var rwzt: String?
    var yczt: Any?
    var status: Any?
    var rwrq: String?
    var tjsj: String?
    var rwkssj: String?
    var rwjssj: String?
    var StartTime: Any?
    var EndTime: Any?
    var startDate: Any?
    var endDate: Any?
    var location: Any?
    var czrId: Any?
    var batched: Bool?
    var rwmbList: Any?
    var rwjlMbList: [RwjlMbModel]?
    var rwjlMbDqList: [RwjlMbDqModel]?
    var startTime: Any?
    var endTime: Any?
}

struct RwjlMbDqModel: HandyJSON {
    var dqmc: String?
    var id: Int64?
    var boscLzglRwjlMbs: [BoscLzglRwjlMbModel]?
}

struct BoscLzglRwjlMbModel: HandyJSON {
    var id: Int64?
    var rwid: Int64?
    var rwlxdm: Int?
    var rwlxmc: String?
    var rwmc: String?
    var xxlxdm: String?
    var xxlxdmc: String?
    var rwzt: String?
    var remark: String?
}

struct RwwcqkModel: HandyJSON {
    var deptId: Int64?
    var parentId: Int64?
    var deptName: String?
    var wdlxr: Any?
    var wdlxrhm: Any?
    var yyFlag: Any?
    var wcFlag: Bool?
    var wcTotal: Int?
    var wwcFlag: Bool?
    var wwcTotal: Int?
    var nextFlag: Bool?
    var total: Int?
    var completeTotal: Int?
    var errorTotal: Int?
    var percent: Float?
    var taskId: Int64?
    var taskName: String?
    var taskDate: Any?
    var startTime: String?
    var endTime: String?
    var status: String?
    var childrenList: [RwwcqkModel]?
}

struct WdwcqkModel: HandyJSON {
    var zwd: Int?
    var wczs: Int?
    var wwczs: Int?
    var zwcl: String?
}

struct SelectLzglWclByDeptModel: HandyJSON {
    var wdList: [TaskDeptRateModal]?
    var zxList: [TaskRateModal]?
    var zwcl: Double?
    var title: String?
}

struct RwjlMbModel: HandyJSON {
    var searchValue: Any?
    var createBy: Any?
    var createTime: String?
    var updateBy: Any?
    var updateTime: Any?
    var remark: Any?
    var params: Any?
    var id: Any?
    var rwjlid: Any?
    var rwmbid: Any?
    var rwid: Int64?
    var rwlxdm: Int?
    var rwlxmc: String?
    var dqdm: Any?
    var rwmc: String?
    var dqmc: Any?
    var nfcwz: Any?
    var xxlxdm: Any?
    var xxlxdmc: Any?
    var rwzt: String?
    var tjsj: Any?
    var startDate: Any?
    var endDate: Any?
    var sfzg: Any?
    var wddm: Any?
    var answers: Any?
    var optionLable: Any?
    var optionValue: Any?
    var images: Any?
    var rwmbBqzzbList: Any?
}

struct RwwcjdModel: HandyJSON {
    var wcs: Int?
    var wwcs: Int?
    var wwcList: [RwwcqkModel]?
    var wcList: [RwwcqkModel]?
}

struct CalendarByStateModel: HandyJSON {
    var workTotal: Int?
    var unWorkTotal: Int?
    var yywd: [YywdModel]?
}

struct YywdModel: HandyJSON {
    var id: Int64?
    var bmdm: Int?
    var bmmc: String?
    var yyrq: String?
    var yyrqStr: String?
    var yyzt: String?
}

struct WdwcqkPercentModel: HandyJSON {
    var taskName: String?
    var startTime: String?
    var endTime: String?
    var status: String?
    var taskId: Int64?
    var percent: Double?
    var errorTotal: Int?
    var completeTotal: Int?
    var total: Int?
    var wwcTotal: Int?
    var wcTotal: Int?
}

struct YyxgjlModel: HandyJSON {
    var remark: String?
    var id: Int64?
    var yywdid: Int64?
    var yywdmc:String?
    var xgrq: String?
    var xgrmc: String?
    var xgrbmdm: Int?
    var xgrbmmc: String?
    var yyzt: String?
}

struct LzglModel: HandyJSON {
    
}
