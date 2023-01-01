//
//  API.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/18.
//

import Foundation
import HandyJSON

class API { }

// MARK: - 入口-登录
let URLLogin = "/login"      /// 用户登录
let URLUserInfo = "/getInfo" /// 获取用户信息

class LoginParam: Encodable {
    var code: String?
    var password: String?
    var username: String?
    var uuid: String?
}

extension API {
    /// 获取用户信息✅已对接
    class func getInfo(withBlock block: ResponseBlock<RespModal>?) {
        NetManager.request(url: URLUserInfo, method: .get, modelType: RespModal.self, resultBlock: block)
    }
    
    /// 用户登录✅已对接
    class func login(withParam param: LoginParam, block: ResponseBlock<LoginRespModal>?) {
        NetManager.request(url: URLLogin, parameters: param, modelType: LoginRespModal.self, resultBlock: block)
    }
}

// MARK: - 系统通用
let URLCaptchaImage = "/common/captchaImage"
let URLConvert = "/common/coordinate/convert"
let URLSetting = "/common/setting"

class SettingParam: Encodable {
    var lngLat: String?
}

extension API {
    /// 图形验证码
    class func getCaptchaImage(withBlock block: ResponseBlock<RespModal>?) {
        NetManager.request(url: URLCaptchaImage, method: .get, modelType: RespModal.self, resultBlock: block)
    }
    
    /// 坐标转换
    class func getConvert(withParam param: EngineerParam, block: ResponseBlock<RespModal>?) {
        NetManager.request(url: URLConvert, method: .get, modelType: RespModal.self, resultBlock: block)
    }
    
    /// 系统配置
    class func getSetting(withBlock block: ResponseBlock<ResponseDefault>?) {
        NetManager.request(url: URLSetting, method: .get, resultBlock: block)
    }
}

// MARK: - 获取部门
let URLDeptList = "/dept/list" // 部门列表

class DeptParam: Encodable {
    var deptname: String?
    
    init(deptname: String? = nil) {
        self.deptname = deptname
    }
}

extension API {
    // 部门列表✅已对接
    class func getDeptList(withParam param: DeptParam? = DeptParam(), block: ResponseBlock<DeptModal>?) {
        NetManager.request(url: URLDeptList, method: .get, parameters: param, modelType: DeptModal.self, resultBlock: block)
    }
}

// MARK: - 入口-找回密码
let URLRetrievepwdPtsm = "/retrievepwd/ptsm"   /// 平台个人信息保护声名
let URLRetrievepwdReset = "/retrievepwd/reset" /// 重置密码
let URLRetrievepwdSend = "/retrievepwd/send"   /// 发送验证码
///

class RetrievepwdSendParam: Encodable {
    var code: String?
    var username: String?
    var uuid: String?
}

extension API {
    /// 平台个人信息保护声名✅已对接
    class func getRetrievepwdPtsm(withBlock block: ResponseBlock<MarkdownModal>?) {
        NetManager.request(url: URLRetrievepwdPtsm, method: .get, modelType: MarkdownModal.self, resultBlock: block)
    }
    
    /// 重置密码
    class func postRetrievepwdReset(withParam param: LoginParam, block: ResponseBlock<LoginRespModal>?) {
        NetManager.request(url: URLRetrievepwdReset, modelType: LoginRespModal.self, resultBlock: block)
    }
    
    /// 发送验证码
    class func postRetrievepwdSend(withParam param: RetrievepwdSendParam, block: ResponseBlock<LoginRespModal>?) {
        NetManager.request(url: URLRetrievepwdReset, modelType: LoginRespModal.self, resultBlock: block)
    }
}

// MARK: - 个人信息
// /bosc-ydaf/jsonapi/profile/initedit
// /bosc-ydaf​/jsonapi​/profile​/updatePwd

let URLProfileInitedit = "/profile/initedit"   /// 修改初始数据
let URLProfileUpdatePwd = "/profile/updatePwd" /// 修改密码

class ProfileParam: Encodable {
    var deptId: String?
    var newPassword: String?
    var nickname: String?
    
    var oldPassword: String?
}

extension API {
    /// 修改初始数据
    class func postProfileInitedit(withParam param: ProfileParam, block: ResponseBlock<RespModal>?) {
        NetManager.request(url: URLProfileInitedit, modelType: RespModal.self, resultBlock: block)
    }
    
    /// 修改密码
    class func postProfileUpdatePwd(withParam param: ProfileParam, block: ResponseBlock<RespModal>?) {
        NetManager.request(url: URLProfileUpdatePwd, method: .put, modelType: RespModal.self, resultBlock: block)
    }
}


