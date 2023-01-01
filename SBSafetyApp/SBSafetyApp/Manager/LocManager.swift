//
//  LocManager.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/12/8.
//

import Foundation
 
// 定位
import CoreLocation
 
/// App 定位类
class LocManager: NSObject {
    
    static let shared = LocManager()
    
    /// 获取最新定位信息
    open var didSelectLocWith:((_ longitude: String, _ latitude: String) -> ())?

    //初始化
    override init() {
        super.init()
        self.setup()
    }
    
    deinit {
        self.lm?.stopUpdatingLocation()
        self.lm?.delegate = nil
        self.lm = nil
    }
    
    // MARK: - lazy load
    /// 定位对象
    private lazy var lm: CLLocationManager? = nil
}
 
 
// MARK: -
extension LocManager {
    
    /// 定位初始化
    private func setup(){
        // 定位对象
        self.lm = CLLocationManager.init()
        weak var weakSelf = self
        self.lm?.delegate = weakSelf
        self.lm?.desiredAccuracy = kCLLocationAccuracyBest
        self.lm?.distanceFilter = 200.0
    }
    
    /// 权限检测
    private func locationPermissionsCheck() {
        if CLLocationManager.locationServicesEnabled() == false {
            print("请确认已开启定位服务")
            return
        }
        
        // 请求用户授权
        if self.lm?.authorizationStatus == .notDetermined {
            self.lm?.requestWhenInUseAuthorization()
        }
    }

    /// 开启定位
    func startLoaction() {
        // 已开启定位服务
        if CLLocationManager.locationServicesEnabled() {
            // 是否有授权本App获取定位
            let _auth: CLAuthorizationStatus? = self.lm?.authorizationStatus
            
            if _auth == nil || _auth == .denied || _auth == .restricted {
                print("请确认已开启定位服务")
                return
            }
            
            //可以定位
            self.lm?.startUpdatingLocation()
        }
        else{
            self.locationPermissionsCheck()
        }
    }
    
}
 
 
//MARK: - CLLocationManagerDelegate
extension LocManager : CLLocationManagerDelegate {
    
    /// 定位失败
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("定位失败：\(error.localizedDescription)")
    }
    
    /// 定位成功
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("定位成功")
        
        /**
         * CLLocation 定位信息
         *
         * 经度：currLocation.coordinate.longitude
         * 纬度：currLocation.coordinate.latitude
         * 海拔：currLocation.altitude
         * 方向：currLocation.course
         * 速度：currLocation.speed
         *  ……
         */
        if let _location = locations.last {
            print("_location", _location.coordinate.latitude, _location.coordinate.longitude)
            // 关闭定位
            didSelectLocWith?("\(_location.coordinate.longitude)", "\(_location.coordinate.latitude)")
            self.lm?.stopUpdatingLocation()
        } else{
            print("请稍后重试")
        }
    }
}
