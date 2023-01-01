//
//  BSUser.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/28.
//

import Foundation
import CoreData
import UIKit
import Hash

// MARK: - Class Func
extension BSUser {
    class func insetUser() -> BSUser {
        let localId = Hash(message: "CurrentUser", algorithm: .md2)!.description as String
        let user = BSUser(context: Utils.context)
        user.localId = localId
//        user.uuid = UUID().uuidString
        do {
            try Utils.context.save()
        } catch {
            print("insetUser 不能保存：\(error)")
        }
        
        return user
    }
    
    static var currentUser: BSUser {
        let _id = Hash(message: "CurrentUser", algorithm: .md2)!.description as String
        let request = BSUser.fetchRequest()
        let predicate = NSPredicate(format: "localId= '\(_id)'", "")
        request.predicate = predicate
        do {
            let fetchedObjects = try Utils.context.fetch(request)
            if fetchedObjects.count > 0 {
                let user = fetchedObjects[0]
                return user
            }
        } catch {
            fatalError("currentUser 不能获取：\(error)")
        }
        return BSUser.insetUser()
    }
}

// MARK: - Func
extension BSUser {
    func modifyUser(_phone: String? = nil, _password: String? = nil) {
        if _phone != nil { self.phone = _phone }
        if _password != nil { self.password = _password }
        do {
            try Utils.context.save()
        } catch {
            print("modifyUser 不能保存：\(error)")
        }
    }
    
    func modifyUser(_isRemember: Bool) {
        self.isRemember = _isRemember
        do {
            try Utils.context.save()
        } catch {
            print("modifyUser 不能保存：\(error)")
        }
    }
    
    func modifyUser(withModal modal: UserModal?) {
        self.nickName = modal?.nickName
        self.deptId = modal?.deptId ?? 0
        self.deptName = modal?.dept?.deptName!
        self.userName = modal?.userName
        self.userId = modal?.userId ?? 0
        self.avatar = modal?.avatar
        do {
            try Utils.context.save()
        } catch {
            print("modifyUser 不能保存：\(error)")
        }
    }
}
