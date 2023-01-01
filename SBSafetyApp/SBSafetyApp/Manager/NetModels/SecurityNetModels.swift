//
// Created by Aimeow on 2022/12/1.
//

import Foundation
import HandyJSON

struct SecurityStaticsModel: HandyJSON {
    var record: [String]?
    var statics: [StaticsItemModel]?
}

struct StaticsItemModel: HandyJSON {
    var date: String?
    var statusDesc: String?
    var status: Int?
}

struct SecurityTaskListModel: HandyJSON {
    var data: Any?
}

struct ClockInModel: HandyJSON {
    var data: Any?
}

struct SignVerifyModel: HandyJSON {

}

struct TaskSaveModel: HandyJSON {

}

struct SecurityFormModel: HandyJSON {

}

struct SecurityUploadModel: HandyJSON {

}
