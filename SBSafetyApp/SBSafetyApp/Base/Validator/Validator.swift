//
//  Validator.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/16.
//

import Foundation
import UIKit

public protocol ValidationDelegate {
    func validationSuccessful()
    func validationFailed(_ errors: [(Validatable, ValidationError)])
}

public class ValidationError: NSObject {
    public let field: ValidatableField
    public let errorMessage: String
    
    public init(field: ValidatableField, error: String){
        self.field = field
        self.errorMessage = error
    }
}

public class Validator {
    public var validations = ValidatorDictionary<ValidationRule>()
    public var errors = ValidatorDictionary<ValidationError>()
    private var fields = ValidatorDictionary<Validatable>()
    private var successStyleTransform:((_ validationRule:ValidationRule)->Void)?
    private var errorStyleTransform:((_ validationError:ValidationError)->Void)?
    public init(){}
    
    // MARK: - Private functions
    private func validateAllFields() {
        
        errors = ValidatorDictionary<ValidationError>()
        
        for (_, rule) in validations {
            if let error = rule.validateField() {
                errors[rule.field] = error
                
                // let the user transform the field if they want
                if let transform = self.errorStyleTransform {
                    transform(error)
                }
            } else {
                // No error
                // let the user transform the field if they want
                if let transform = self.successStyleTransform {
                    transform(rule)
                }
            }
        }
    }
    
    // MARK: - Public functions
    public func validateField(_ field: ValidatableField, callback: (_ error:ValidationError?) -> Void){
        if let fieldRule = validations[field] {
            if let error = fieldRule.validateField() {
                errors[field] = error
                if let transform = self.errorStyleTransform {
                    transform(error)
                }
                callback(error)
            } else {
                if let transform = self.successStyleTransform {
                    transform(fieldRule)
                }
                callback(nil)
            }
        } else {
            callback(nil)
        }
    }
    
    // MARK: - Using Keys
    public func styleTransformers(success:((_ validationRule:ValidationRule)->Void)?, error:((_ validationError:ValidationError)->Void)?) {
        self.successStyleTransform = success
        self.errorStyleTransform = error
    }

    public func registerField(_ field: ValidatableField, rules: [Rule]) {
        validations[field] = ValidationRule(field: field, rules: rules)
        fields[field] = field
    }
    
    public func unregisterField(_ field: ValidatableField) {
        validations.removeValueForKey(field)
        errors.removeValueForKey(field)
    }
    
    public func unregisterAllField() {
        for (_, rule) in validations {
            validations.removeValueForKey(rule.field)
            errors.removeValueForKey(rule.field)
        }
    }

    public func validate(_ delegate: ValidationDelegate) {
        
        self.validateAllFields()
        
        if errors.isEmpty {
            delegate.validationSuccessful()
        } else {
            delegate.validationFailed(errors.map { (fields[$1.field]!, $1) })
        }
        
    }

    public func validate(_ callback:(_ errors:[(Validatable, ValidationError)])->Void) -> Void {
        
        self.validateAllFields()
        
        callback(errors.map { (fields[$1.field]!, $1) } )
    }
}
