//
//  NetManager.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/18.
//

import Foundation
import Alamofire
import HandyJSON

// 错误信息
enum ResponseError: Int {
    case Unkown = 0
    case Success = 200
    case Created = 201
    case Unauthorized  = 401
    case Forbidden = 403
    case NotFound = 404
    case Failure = 500
}

struct ResponseModel<T: HandyJSON> {
    var errorCode: ResponseError = .Unkown
    var errorMessage : String = "未知错误"
    var model: T?
    var models: [T?]?
    var resultData: Any?
}

struct RequestHeaders: HandyJSON {
    var Authorization: String?
}

struct ResponseDefault: HandyJSON {}

struct ResponseData: HandyJSON {
    var code: Int?
    var msg: String?
    var data: Any?
}

typealias ResponseBlock<T: HandyJSON> = (_ responseModel: ResponseModel<T>) -> ()

class NetManager {
    public class var share: NetManager {
        struct Static {
            static let instance: NetManager = NetManager()
        }
        return Static.instance
    }
    
    /// 请求头
    var BSHeaders : HTTPHeaders {
        get {
            var headers = RequestHeaders()
            let token = UserDefaults.standard.string(forKey: SafetyToken)
            headers.Authorization = token ?? ""
            guard let jsonHeader = headers.toJSON() , let jsonHeader = jsonHeader as? [String:String] else {
                return []
            }
            return HTTPHeaders.init(jsonHeader)
        }
    }
    
    /// 接口地址
    let BaseURL : String = "https://www.zhxqgl.top/bosc-ydaf/jsonapi"

    /// 参数编码方式
    let BSParameterEncoder : ParameterEncoder = URLEncodedFormParameterEncoder.default
}

extension NetManager {
        
    ///可无参数，无模型数据返回
    class func request(url: String, method: HTTPMethod = .post, parametersDic: [String:String]? = [:], resultBlock: ResponseBlock<ResponseDefault>?) {
        request(url: url, method: method, parametersDic: parametersDic, modelType: ResponseDefault.self, resultBlock: resultBlock)
    }
    
    /// 可无参数
    class func request<T:HandyJSON>(url: String, method: HTTPMethod = .post, parametersDic: [String:String]? = [:], modelType: T.Type, resultBlock:ResponseBlock<T>?) {
        request(url: url, method: method, parameters: parametersDic, modelType: modelType, resultBlock: resultBlock)
    }
    
    /// 无模型数据返回
    class func request<Parameters: Encodable>(url: String,
                                              method: HTTPMethod = .post,
                                              parameters: Parameters,
                                              resultBlock: ResponseBlock<ResponseDefault>?) {
        request(url: url, method: method, parameters: parameters, modelType: ResponseDefault.self, resultBlock: resultBlock)
    }

    /// 数据模型返回
    class func request<T: HandyJSON,Parameters: Encodable>(url: String,
                                                          method: HTTPMethod = .post,
                                                          parameters: Parameters,
                                                          modelType: T.Type,
                                                          resultBlock: ResponseBlock<T>?) {
        NetManager.InitRequest(url: url, method: method, parameters: parameters).responseString { string in
            if let error = string.error {
                print(error.errorDescription as Any)
                Utils.app.window?.showToast(witMsg: error.errorDescription)
                return
            }
            let c = string.value!.cString(using: String.Encoding.isoLatin1)
            
            if c != nil {
                let utf8Text = String(cString: c!, encoding: String.Encoding.utf8)
                self.response(url, modelType, utf8Text, resultBlock)
            } else {
                self.response(url, modelType, string.value, resultBlock)
            }
        }
    }
    
    class func upload<T: HandyJSON>(url: String, imagePath: String, modelType: T.Type, resultBlock: ResponseBlock<T>?) {
        let imgUrl = URL(fileURLWithPath: imagePath)
        NetManager.InitUpload(url: url, multipartFormData: { multiPart in
            multiPart.append(imgUrl, withName: "file")
        }).responseString { string in
            if let error = string.error {
                print(error.errorDescription as Any)
                Utils.app.window?.showToast(witMsg: error.errorDescription)
                return
            }
            let c = string.value!.cString(using: String.Encoding.isoLatin1)
            
            if c != nil {
                let utf8Text = String(cString: c!, encoding: String.Encoding.utf8)
                self.response(url, modelType, utf8Text, resultBlock)
            } else {
                self.response(url, modelType, string.value, resultBlock)
            }
        }
    }
}

extension NetManager {
    fileprivate class func InitUpload(url: String, multipartFormData: @escaping (MultipartFormData) -> Void)  -> DataRequest {
        let headers: HTTPHeaders = NetManager.share.BSHeaders
        let requestUrl = url.joinHost.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let request : DataRequest = AF.upload(multipartFormData: multipartFormData, to: requestUrl, headers: headers)
        return request
    }
    
    fileprivate class func InitRequest<Parameters: Encodable>(url: String, method: HTTPMethod = .post, parameters: Parameters? = nil) -> DataRequest {
        let headers: HTTPHeaders = NetManager.share.BSHeaders
        let encoder: ParameterEncoder = NetManager.share.BSParameterEncoder
        let requestUrl = url.joinHost.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let request : DataRequest = AF.request(requestUrl, method: method, parameters: parameters, encoder: encoder, headers: headers, interceptor: nil, requestModifier: nil)
        return request
    }
    
    /// 解析服务器返回的数据转化为model
    fileprivate class func response<T: HandyJSON>(_ url: String, _ modelType: T.Type, _ responseData: String?, _ resultBlock: ResponseBlock<T>?) {
        guard let resultBlock = resultBlock else { return }
//        guard modelType != ResponseDefault.self else {
//            return
//        }
        var responseModel = ResponseModel<T>()
        let baseModel = ResponseData.deserialize(from: responseData)
        
        guard let baseModel = baseModel else {
            return resultBlock(responseModel)
        }
        responseModel.errorCode = ResponseError(rawValue: baseModel.code ?? 0) ?? .Unkown
        if let _ = baseModel.msg { responseModel.errorMessage = baseModel.msg! }
        responseModel.resultData = baseModel.data
        
        if responseModel.errorCode == .Unauthorized {
            Utils.exitApp(msg: responseModel.errorMessage)
            return resultBlock(responseModel)
        }

//        // 当被转模型数据不存在, 停止转模型.
//        guard let data = baseModel.data else {
//            return resultBlock(responseModel)
//        }
        
        let jsonData = responseData?.data(using: String.Encoding.utf8, allowLossyConversion: false)
        guard let data = try? JSONSerialization.jsonObject(with: jsonData ?? Data(), options: .mutableContainers) else {
             return}
        
        responseModel.resultData = data

        if responseModel.errorCode != .Success {
            let delData = data as? [String : Any]
            let resData = responseModel.resultData as? [String : Any]
            var msg = (resData?["msg"] as? String) ?? responseModel.errorMessage
            if responseModel.errorCode == .NotFound {
                msg = "\(delData?["status"] ?? "")\n\(delData?["path"] ?? "")\n\(delData?["error"] ?? "")"
            }
            print("error url: ", url)
            print("error data: ", data)

            Utils.app.window?.showToast(witMsg: msg)
            return resultBlock(responseModel)
        }
        
        var deserializeData = (data as? [String : Any])?["data"]
        
        if deserializeData == nil  {
            deserializeData = (data as? [String : Any])?["rows"]
        }
        
        if deserializeData == nil  {
            deserializeData = (data as? [String : Any])?["BankName"]
        }
        
        if deserializeData == nil  {
            deserializeData = (data as? [String : Any])?["templList"]
        }
        
        if deserializeData == nil  {
            deserializeData = (data as? [String : Any])?["detail"]
        }
        
        if deserializeData == nil {
            deserializeData = data
        }
        
        if let dataArray = deserializeData as? [Any] {          // 解析数组
            responseModel.models = [T].deserialize(from: dataArray)
            return resultBlock(responseModel)
        } else if let data = deserializeData as? [String : Any] {     //解析字典
            responseModel.model = T.deserialize(from: data)
            return resultBlock(responseModel)
        }  else{   // 原样返回Data数据
            return resultBlock(responseModel)
        }
    }
}

extension String {
    var joinHost: String {
        let host = NetManager.share.BaseURL
        guard !self.isEmpty else {
            return host
        }
        guard !self.contains("http") else {
            return self
        }
        return host + self
    }
}
