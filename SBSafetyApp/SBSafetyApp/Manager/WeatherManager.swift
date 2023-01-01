//
//  WeatherManager.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/12/13.
//

import Foundation
import HandyJSON
import Alamofire

//省份、城市、天气和温度
struct Live: HandyJSON {
    var adcode: String?
    var humidity: String?
    var windpower: String?
    var province: String?
    var city: String?
    var weather: String?
    var temperature: String?
    var winddirection: String?
    var reporttime: String?
}

class WeatherManager: NSObject {
    static let shared = WeatherManager()

    var lives: [Live?]? = []

    //天气api的URL
    private static var gaodeURL = "https://restapi.amap.com/v3/weather/weatherInfo?city=310000&extensions=base&key=c6468d441a85bf34c2352ea1707ee2c5"
    
    //下载json
    func getWeatherJSON(withBlock block: WeatherRespBlock?) {
        guard let gaodeUrl = URL(string: Self.gaodeURL) else { return }
        AF.request(gaodeUrl, method: .get).responseString { string in
            if let error = string.error {
                print(error.errorDescription as Any)
                return
            }
            self.response(string.value, block)
        }
    }
    
    fileprivate func response(_ responseData: String?, _ resultBlock: WeatherRespBlock?) {
        guard let resultBlock = resultBlock else { return }
        let jsonData = responseData?.data(using: String.Encoding.utf8, allowLossyConversion: false)
        guard let data = try? JSONSerialization.jsonObject(with: jsonData ?? Data(), options: .mutableContainers) else { return }
        let dataArray = (data as? [String : Any])?["lives"] as? [Any]
        let models = [Live].deserialize(from: dataArray)
        return resultBlock(models)
    }
}

typealias WeatherRespBlock = (_ lives: [Live?]?) -> ()

 
