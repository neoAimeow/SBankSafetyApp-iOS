//
//  Rule.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/16.
//

import Foundation

public protocol Rule {
    func validate(_ value: String) -> Bool
    func errorMessage() -> String
}

open class RequiredRule: Rule {
    private var message : String
    
    public init(message : String = "This field is required") {
        self.message = message
    }
    
    open func validate(_ value: String) -> Bool {
        return !value.isEmpty
    }
    
    open func validate(_ value: Bool?) -> Bool {
        return value != nil
    }

    open func errorMessage() -> String {
        return message
    }
}

public class ValidationRule {
    public var field: ValidatableField
    public var rules: [Rule] = []

    public init(field: ValidatableField, rules: [Rule]) {
        self.field = field
        self.rules = rules
    }

    public func validateField() -> ValidationError? {
        return rules.filter {
            return !$0.validate(field.validationText)
            }.map{ rule -> ValidationError in return ValidationError(field: self.field, error: rule.errorMessage()) }.first
    }
}
