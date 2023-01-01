//
//  Validatable.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/16.
//

import Foundation
import UIKit

public typealias ValidatableField = AnyObject & Validatable

public protocol Validatable {
    
     var validationText: String {
        get
    }
}

extension UITextField: Validatable {
    
    public var validationText: String {
        return text ?? ""
    }
}

extension UITextView: Validatable {
    
    public var validationText: String {
        return text ?? ""
    }
}

extension UILabel: Validatable {
    
    public var validationText: String {
        return text ?? ""
    }
}

extension CheckEffect: Validatable {

    public var validationText: String {
        return isCheck != nil ? "\(isCheck!)" : ""
    }
}

extension SignEffect: Validatable {

    public var validationText: String {
        return img != nil ? "img" : ""
    }
}


