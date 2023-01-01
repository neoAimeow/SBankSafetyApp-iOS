//
//  SecurityPanelViewEx.swift
//  SBSafetyApp
//
//  Created by Aimeow on 2022/11/16.
//

import RxSwift
#if !RX_NO_MODULE
    import RxSwift
    import RxCocoa
#endif



public typealias RxSecurityPanelTapDelegate = DelegateProxy<SecurityPanelView, SecurityPanelTapDelegate>

open class RxSecurityPanelTapDelegateProxy: RxSecurityPanelTapDelegate, DelegateProxyType, SecurityPanelTapDelegate {
    
    /// Type of parent object
    public weak private(set) var securityPanelView: SecurityPanelView?
    
    /// Init with ParentObject
    public init(parentObject: ParentObject) {
        securityPanelView = parentObject
        super.init(parentObject: parentObject, delegateProxy: RxSecurityPanelTapDelegateProxy.self)
    }
    
    /// Register self to known implementations
    public static func registerKnownImplementations() {
        self.register { parent -> RxSecurityPanelTapDelegateProxy in
            RxSecurityPanelTapDelegateProxy(parentObject: parent)
        }
    }
    
    /// Gets the current `WKNavigationDelegate` on `WKWebView`
    open class func currentDelegate(for object: ParentObject) -> SecurityPanelTapDelegate? {
        return object.navigationDelegate
    }
    
    /// Set the navigationDelegate for `WKWebView`
    open class func setCurrentDelegate(_ delegate: SecurityPanelTapDelegate?, to object: ParentObject) {
        object.navigationDelegate = delegate
    }
}
