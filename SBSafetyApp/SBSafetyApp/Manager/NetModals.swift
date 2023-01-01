//
//  NetModals.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/30.
//

import Foundation
import HandyJSON

enum UserRole: String {
    // 工程师
    case Engineer = "gongRole"
//    // 超级管理员
//    case Admin = "admin"
//    // 普通用户角色
//    case Normal = "common"
    // 总行
    case HeadOffice = "zongRole"
    // 分行
    case BranchOffice = "fenRole"
    // 支行
    case SubBranchOffice = "zhiRole"
    // 网点
    case Lattice = "wangRole"
    // 保安
    case SecurityGuard = "baoRole"
}

struct LoginRespModal: HandyJSON {
    var token: String?
    var role: String?
    var user: UserModal?
}

struct RespModal: HandyJSON {
    var user: UserModal?
    var data: Any?
    var uuid: String?
    var img: String?
    var roles: [String]?
}

//struct BaseModal<T>: HandyJSON {

//    var code:
//}

// MARK: - 入口-登录

// 用户信息
struct UserModal: HandyJSON {
    var nickName: String?
    var sex: String?
    var deptId: Int64?
    var userName: String?
    var userId: Int64?
    var avatar: String?
    var dept: DeptModal?
}

// MARK: - 获取部门

struct DeptModal: HandyJSON {
    var deptId: Int64?
    var deptName: String?
    var orderNum: Int64?
    var phone: String?
    var leader: String?
    var email: String?
    var deptPosition: String?
    var parentName: String?
    var parentId: Int64?
    var indexNum: Int64 = 0
    var children: [DeptModal?]?
    var expanded: Bool = true
    var isVisibility: Bool = true
}

// MARK: -

struct MarkdownModal: HandyJSON {
    var name: String?
    var nr: String?
}
