//
//  SignView.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/16.
//

import Foundation
import UIKit
import MaLiang

class SignView: UIView {
    
    let canvas = Canvas(frame: CGRect(x: 0, y: 0, width: ScreenHeight, height: ScreenWidth - 80))
    let saveBtn = UIButton.createPrimaryLarge("完成签名")
    let clearBtn = UIButton.createDefaultLarge("清除签名")

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        canvas.data.addObserver(self)
        addSubview(canvas)
        
        addSubview(clearBtn)
        clearBtn.snp.makeConstraints { make in
            make.left.equalTo(self.snp.left).offset(16)
            make.bottom.equalTo(self.snp.bottom)
            make.width.equalTo(ScreenWidth - 48)
            make.height.equalTo(50)
        }
        
        addSubview(saveBtn)
        saveBtn.snp.makeConstraints { make in
            make.left.equalTo(clearBtn.snp.right).offset(16)
            make.bottom.equalTo(self.snp.bottom)
            make.right.equalTo(self.snp.right).offset(-16)
            make.height.equalTo(50)
        }
    }
}

extension SignView: DataObserver {

    public func lineStrip(_ strip: LineStrip, didBeginOn data: CanvasData) {}
    
    /// called when a element is finished
    public func element(_ element: CanvasElement, didFinishOn data: CanvasData) {}
    
    /// callen when clear the canvas
    public func dataDidClear(_ data: CanvasData) {}
    
    /// callen when undo
    public func dataDidUndo(_ data: CanvasData) {}
    
    /// callen when redo
    public func dataDidRedo(_ data: CanvasData) {}
}

