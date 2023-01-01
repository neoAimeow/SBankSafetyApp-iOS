//
// Created by Aimeow on 2022/12/2.
//

import Foundation
import HandyJSON

let getDeptListUrl = "/dept/list" // 未营业/营业网点列表


extension API {

    // 获取部门列表
    class func getDeptList(withDeptName deptName: String, block: ResponseBlock<Dept>?) {
        NetManager.request(url: getDeptListUrl, method: .get, modelType: Dept.self, resultBlock: block)
    }

}

struct Dept: HandyJSON {
    var searchValue: Any?
    var createBy: String?
    var createTime: String?
    var updateBy: String?
    var updateTime: String?
    var remark: Any?
    var params: Any?
    var deptId: Int?
    var parentId: Int?
    var ancestors: String?
    var deptName: String?
    var orderNum: Int?
    var leader: String?
    var phone: String?
    var email: String?
    var status: String?
    var delFlag: String?
    var parentName: String?
    var wdFlag: String?
    var deptPosition: String?
    var children: [Any]?

}
