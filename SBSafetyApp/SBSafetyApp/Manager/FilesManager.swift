//
//  FilesManager.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/12/8.
//

import Foundation
import CoreData
import UIKit

class FilesManager {
    static let shared = FilesManager()
    
    func currentDir() -> (String)  {
        // 获取本地存储的地址
        let cacheDir = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).last! as NSString
        let fm = FileManager.default
        let composeDir =  cacheDir.appendingPathComponent("COMPOSE")
        if fm.fileExists(atPath: composeDir) == false {
            do {
                try fm.createDirectory(atPath: composeDir, withIntermediateDirectories: true, attributes: nil)
            } catch {}
        }
        return composeDir
    }
    
    func saveImage(img: UIImage) -> String? {
        let pngImageData = img.pngData()
        let path = currentDir() + "\(Date().timeIntervalSince1970).png"
        
        do {
            try pngImageData?.write(to: URL(fileURLWithPath: path))
            return path
        } catch  {
            return nil
        }

    }
    
    func deleteFile(_ url: URL) {
        do {
            try FileManager.default.removeItem(at: url)
        } catch {}
    }
    
    func clearCaches() {
        let cacheDir = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).last! as NSString
        let composeDir = cacheDir.appendingPathComponent("COMPOSE")
        do {
            try FileManager.default.removeItem(atPath: composeDir)
        } catch {}
    }
}
