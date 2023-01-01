//
//  BSCommon.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/12/13.
//

import Foundation

// MARK: - Class Func
extension BSCommon {
    class func insetToday(withLive live: Live) -> BSCommon {
        let localId = Date.todayDate()
        let common = BSCommon(context: Utils.context)
        common.id = localId
        common.adcode = live.adcode
        common.humidity = live.humidity
        common.windpower = live.windpower
        common.province = live.province
        common.city = live.city
        common.weather = live.weather
        common.temperature = live.temperature
        common.winddirection = live.winddirection
        common.reporttime = live.reporttime
        do {
            try Utils.context.save()
        } catch {
            print("insetUser 不能保存：\(error)")
        }
        
        return common
    }
    
    static var today: BSCommon? {
        let _id = Date.todayDate()
        let request = BSCommon.fetchRequest()
        let predicate = NSPredicate(format: "id= '\(_id)'", "")
        request.predicate = predicate
        do {
            let fetchedObjects = try Utils.context.fetch(request)
            if fetchedObjects.count > 0 {
                let common = fetchedObjects[0]
                return common
            }
        } catch {
            fatalError("currentUser 不能获取：\(error)")
        }
        return nil
    }
}
