//
// Created by Aimeow on 2022/12/6.
//

import Foundation
import RxSwift


let selectLzglWclUrl = "/lzgl/selectLzglWcl"
let selectLzglWclByDeptUrl = "/lzgl/selectLzglWclByDept" // 根据部门查询部门及以下完成率
let selectLzglWdwcqkUrl = "/lzgl/selectLzglWdwcqk" // 网点完成情况
let rwwcqkUrl = "/lzgl/rwwcqk" // 各任务完成情况
let taskCompleteViewUrl = "/lzgl/taskCompleteView" // 今日/本月/本季/本年 任务
let rwwcjdUrl = "/lzgl/rwwcjd" // 任务完成进度
let calendarByStateUrl = "/lzgl/bystate" // 日历营业状态
let yywdUrl = "/lzgl/yywd"
let rweditUrl = "/lzgl/rwedit" // 任务详情
let wdwcqkUrl = "/lzgl/wdwcqk" // 网点完成情况
let yyxgjlUrl = "/lzgl/yyxgjl" // 部门营业修改历史
let xgyyztUrl = "/lzgl/xgyyzt" // 营业修改记录
let lzglUploadUrl = "/lzgl/upload" /// 履职管理-上传图片
let updateRemarkUrl = "/lzgl/updatelzglRemark" // 补充说明


enum DateType: Int {
    case day = 1
    case month = 2
    case season = 3
    case year = 4
}

class LzglBaseParam: Encodable {
    var dateType: DateType.RawValue
    var deptId: Int64
    var date: String

    init(deptId: Int64, dateType: DateType.RawValue, date: String) {
        self.deptId = deptId
        self.dateType = dateType
        self.date = date
    }
}

class RwwcjdParam: Encodable {
    var rwid: Int64?
    var date: String?
    var dateType: DateType.RawValue?

    init(rwid: Int64, date: String, dateType: DateType.RawValue) {
        self.rwid = rwid
        self.dateType = dateType
        self.date = date
    }
}

class CalendarByStateParam: Encodable {
    var deptId: Int64
    var workDate: String

    init(deptId: Int64, workDate: String) {
        self.deptId = deptId
        self.workDate = workDate
    }
}

class YywdParam: Encodable {
    var workDate: String
    var status: Int

    init(status: Int, workDate: String) {
        self.workDate = workDate
        self.status = status
    }
}

class RWEditParam: Encodable {
    var id: Int64

    init(withId id: Int64) {
        self.id = id
    }
}

class WdwcqkParam: Encodable {
    var dateType: DateType.RawValue
    var deptId: Int64
    var date: String
    var rwzq: Int?

    init(deptId: Int64, dateType: DateType.RawValue, date: String, rwzq: Int?) {
        self.deptId = deptId
        self.dateType = dateType
        self.date = date
        self.rwzq = rwzq
    }
}

class YyxgjlParam: Encodable {
    var deptId: Int64
    var workDate: String
    var pageNum: Int
    var pageSize: Int
    
    init(deptId: Int64, workDate: String, pageNum: Int, pageSize: Int) {
        self.deptId = deptId
        self.workDate = workDate
        self.pageNum = pageNum
        self.pageSize = pageSize
    }
}

class XgyyztParam: Encodable {
    var deptId: Int64
    var month: String?
    var remark: String
    var status: String
    var type: String
    var workDates: String
    var year: String?
    
    init(deptId: Int64, month: String?, remark: String, status: String, type: String, workDates: String, year: String?) {
        self.deptId = deptId
        self.month = month
        self.remark = remark
        self.status = status
        self.type = type
        self.workDates = workDates
        self.year = year
    }
}

class UpdateRemarkParam: Encodable {
    var jsonStr:String
    
    init(jsonStr: String) {
        self.jsonStr = jsonStr
    }
}

extension API {
    
    class func selectLzglWcl(withParam param: LzglBaseParam) -> Observable<ResponseModel<TaskDeptRateModal>> {
        Observable.create({ observer -> Disposable in
            NetManager.request(url: selectLzglWclUrl, method: .get, parameters: param, modelType: TaskDeptRateModal.self) { responseModel in
                observer.onNext(responseModel)
                observer.onCompleted()
            }
            return Disposables.create()
        })
    }
    
    class func selectLzglWclByDept(withParam param: LzglBaseParam) -> Observable<ResponseModel<SelectLzglWclByDeptModel>> {
        Observable.create({ observer -> Disposable in
            NetManager.request(url: selectLzglWclByDeptUrl, method: .get, parameters: param, modelType: SelectLzglWclByDeptModel.self) { responseModel in
                observer.onNext(responseModel)
                observer.onCompleted()
            }
            return Disposables.create()
        })
    }
    
    class func selectLzglWdwcqk(withParam param: LzglBaseParam) -> Observable<ResponseModel<WdwcqkModel>> {
        Observable.create({ observer -> Disposable in
            NetManager.request(url: selectLzglWdwcqkUrl, method: .get, parameters: param, modelType: WdwcqkModel.self) { responseModel in
                observer.onNext(responseModel)
                observer.onCompleted()
            }
            return Disposables.create()
        })
    }
    
    class func rwwcqk(withParam param: LzglBaseParam) -> Observable<ResponseModel<RwwcqkModel>> {
        Observable.create({ observer -> Disposable in
            NetManager.request(url: rwwcqkUrl, method: .get, parameters: param, modelType: RwwcqkModel.self) { responseModel in
                observer.onNext(responseModel)
                observer.onCompleted()
            }
            return Disposables.create()
        })
    }
    
    class func taskCompleteView(withParam param: LzglBaseParam) -> Observable<ResponseModel<TaskCompleteModel>> {
        Observable.create({ observer -> Disposable in
            NetManager.request(url: taskCompleteViewUrl, method: .get, parameters: param, modelType: TaskCompleteModel.self) { responseModel in
                observer.onNext(responseModel)
                observer.onCompleted()
            }
            return Disposables.create()
        })
    }
    
    class func rwwcjd(withParam param: RwwcjdParam) -> Observable<ResponseModel<RwwcjdModel>> {
        Observable.create({ observer -> Disposable in
            NetManager.request(url: rwwcjdUrl, method: .get, parameters: param, modelType: RwwcjdModel.self) { responseModel in
                if let data = responseModel.resultData as? [String: Any] {
                    let model = RwwcjdModel.deserialize(from: data)
                    observer.onNext(ResponseModel(model: model))
                    observer.onCompleted()
                }
            }
            return Disposables.create()
        })
    }
    
    class func calendarByState(withParam param: CalendarByStateParam) -> Observable<ResponseModel<CalendarByStateModel>> {
        Observable.create({ observer -> Disposable in
            NetManager.request(url: calendarByStateUrl, method: .get, parameters: param, modelType: CalendarByStateModel.self) { responseModel in
                if let data = responseModel.resultData as? [String: Any] {
                    let model = CalendarByStateModel.deserialize(from: data)
                    observer.onNext(ResponseModel(model: model))
                    observer.onCompleted()
                }
            }
            return Disposables.create()
        })
    }
    
    
    class func yywd(withParam param: YywdParam) -> Observable<ResponseModel<YywdModel>> {
        Observable.create({ observer -> Disposable in
            NetManager.request(url: yywdUrl, method: .get, parameters: param, modelType: YywdModel.self) { responseModel in
                observer.onNext(responseModel)
                observer.onCompleted()
            }
            return Disposables.create()
        })
    }
    
    
    class func rwedit(withParam param: RWEditParam) -> Observable<ResponseModel<TaskCompleteModel>> {
        Observable.create({ observer -> Disposable in
            NetManager.request(url: rweditUrl, method: .get, parameters: param, modelType: TaskCompleteModel.self) { responseModel in
                observer.onNext(responseModel)
                observer.onCompleted()
            }
            return Disposables.create()
        })
    }
    
    class func wdwcqk(withParam param: WdwcqkParam) -> Observable<ResponseModel<WdwcqkPercentModel>> {
        Observable.create({ observer -> Disposable in
            NetManager.request(url: wdwcqkUrl, method: .get, parameters: param, modelType: WdwcqkPercentModel.self) { responseModel in
                observer.onNext(responseModel)
                observer.onCompleted()
            }
            return Disposables.create()
        })
    }
    
    class func yyxgjl(withParam param: YyxgjlParam) -> Observable<ResponseModel<YyxgjlModel>> {
        Observable.create({ observer -> Disposable in
            NetManager.request(url: yyxgjlUrl, method: .get, parameters: param, modelType: YyxgjlModel.self) { responseModel in
                observer.onNext(responseModel)
                observer.onCompleted()
            }
            return Disposables.create()
        })
    }
    
    
    class func xgyyzt(withParam param: XgyyztParam, block: ResponseBlock<LzglModel>?) {
        NetManager.request(url: xgyyztUrl, method: .post, parameters: param, modelType: LzglModel.self, resultBlock: block)
    }
    
    /// 上传图片
    class func lzglUpload(withImage imagePath: String, block: ResponseBlock<ImageModal>?) {
        NetManager.upload(url: lzglUploadUrl, imagePath: imagePath, modelType: ImageModal.self, resultBlock: block)
    }
    
    class func updateRemark(withParam param: UpdateRemarkParam, block: ResponseBlock<LzglModel>?) {
        NetManager.request(url: updateRemarkUrl, method: .post, parameters: param, modelType: LzglModel.self, resultBlock: block)
    }
    
}
