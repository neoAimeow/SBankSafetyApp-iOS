//
// Created by Aimeow on 2022/12/1.
//

import Foundation


let securityFormUrl = "/security"
let checkSignUrl = "/security/check_sign"
let clockInUrl = "/security/clock_in"
let securityStaticsUrl = "/security/statics"
let securityTaskList = "/security/tasklist"
let securityTaskSaveUrl = "/security/tasksave"
let securityUploadImageUrl = "/security/upload"

class ClockInParam: Encodable {
    var imgStr: String
    var jsonStr: String
    var lngLat: String
    var location: String
    var signDeptId: String

    init(imgStr: String, jsonStr: String, lngLat: String, location: String, signDeptId: String) {
        self.imgStr = imgStr
        self.jsonStr = jsonStr
        self.lngLat = lngLat
        self.location = location
        self.signDeptId = signDeptId
    }
}

class SecurityStaticsParam: Encodable {
    var day: Int32
    var month: Int32
    var year: Int32

    init(day: Int32, month: Int32, year: Int32) {
        self.day = day
        self.month = month
        self.year = year
    }
}

// 保安管理

extension API {

    // 去巡检表单
    class func getSecurityForm(withId id: String, block: ResponseBlock<SecurityFormModel>?) {
        NetManager.request(url: securityFormUrl, method: .get, modelType: SecurityFormModel.self, resultBlock: block)
    }

    // 签到验证

    class func checkSignVerify(block: ResponseBlock<SignVerifyModel>?) {
        NetManager.request(url: checkSignUrl, method: .get, modelType: SignVerifyModel.self, resultBlock: block)
    }

    // 签到签退

    class func clockIn(withParam param: ClockInParam, block: ResponseBlock<ClockInModel>?) {
        NetManager.request(url: clockInUrl, method: .post, parameters: param, modelType: ClockInModel.self, resultBlock: block)
    }

    // 考勤统计

    class func securityStatics(withParam param: SecurityStaticsParam, block: ResponseBlock<SecurityStaticsModel>?) {
        NetManager.request(url: securityStaticsUrl, method: .get, parameters: param, modelType: SecurityStaticsModel.self, resultBlock: block)
    }

    // 任务列表

    class func getSecurityTaskList(block: ResponseBlock<SecurityTaskListModel>?) {
        NetManager.request(url: securityStaticsUrl, method: .get, modelType: SecurityTaskListModel.self, resultBlock: block)
    }

    // 履职任务巡检

    class func getSecurityTaskSave(jsonStr: String, block: ResponseBlock<TaskSaveModel>?) {
        NetManager.request(url: securityStaticsUrl, method: .post, parameters: jsonStr, modelType: TaskSaveModel.self, resultBlock: block)
    }

    class func getSecurityUpload(block: ResponseBlock<SecurityUploadModel>?) {
        NetManager.request(url: securityUploadImageUrl, method: .post, modelType: SecurityUploadModel.self, resultBlock: block);
    }
}
