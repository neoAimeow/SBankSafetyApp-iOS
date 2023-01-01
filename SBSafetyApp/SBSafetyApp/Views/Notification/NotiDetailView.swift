//
//  NotiDetailView.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/12/5.
//

import Foundation
import UIKit

class NotiDetailView: UIScrollView {
    let avaterIV = UIImageView()
    let nameL = UILabel()
    let dateL = UILabel()
    let titleL = UILabel()
    let contentL = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        showsVerticalScrollIndicator = false
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reloadData(withModal modal: Any) {
        avaterIV.image = UIImage(named: "ic_default_av")
        nameL.text = "韩冬梅"
        dateL.text = "2022-09-28 15:12:37"
        titleL.text = "平台移动端升级通知"
        let txt = "网络安全，通常指计算机网络的安全，实际上也可以指计算机通信网络的安全。计算机通信网络是将若干台具有独立功能的计算机通过通信设备及传输媒体互连起来，在通信软件的支持下，实现计算机间的信息传输与交换的系统。而计算机网络是指以共享资源为目的，利用通信手段把地域上相对分散的若干独立的计算机系统、终端设备和数据设备连接起来，并在协议的控制下进行数据交换的系统。计算机网络的根本目的在于资源共享，通信网络是实现网络资源共享的途径，因此，计算机网络是安全的，相应的计算机通信网络也必须是安全的，应该能为网络用户实现信息交换与资源共享。下文中，网络安全既指计算机网络安全，又指计算机通信网络安全。网络安全，通常指计算机网络的安全，实际上也可以指计算机通信网络的安全。计算机通信网络是将若干台具有独立功能的计算机通过通信设备及传输媒体互连起来，在通信软件的支持下，实现计算机间的信息传输与交换的系统。而计算机网络是指以共享资源为目的，利用通信手段把地域上相对分散的若干独立的计算机系统、终端设备和数据设备连接起来，并在协议的控制下进行数据交换的系统。计算机网络的根本目的在于资源共享，通信网络是实现网络资源共享的途径，因此，计算机网络是安全的，相应的计算机通信网络也必须是安全的，应该能为网络用户实现信息交换与资源共享。下文中，网络安全既指计算机网络安全，又指计算机通信网络安全。网络安全，通常指计算机网络的安全，实际上也可以指计算机通信网络的安全。计算机通信网络是将若干台具有独立功能的计算机通过通信设备及传输媒体互连起来，在通信软件的支持下，实现计算机间的信息传输与交换的系统。而计算机网络是指以共享资源为目的，利用通信手段把地域上相对分散的若干独立的计算机系统、终端设备和数据设备连接起来，并在协议的控制下进行数据交换的系统。计算机网络的根本目的在于资源共享，通信网络是实现网络资源共享的途径，因此，计算机网络是安全的，相应的计算机通信网络也必须是安全的，应该能为网络用户实现信息交换与资源共享。下文中，网络安全既指计算机网络安全，又指计算机通信网络安全。网络安全，通常指计算机网络的安全，实际上也可以指计算机通信网络的安全。计算机通信网络是将若干台具有独立功能的计算机通过通信设备及传输媒体互连起来，在通信软件的支持下，实现计算机间的信息传输与交换的系统。而计算机网络是指以共享资源为目的，利用通信手段把地域上相对分散的若干独立的计算机系统、终端设备和数据设备连接起来，并在协议的控制下进行数据交换的系统。计算机网络的根本目的在于资源共享，通信网络是实现网络资源共享的途径，因此，计算机网络是安全的，相应的计算机通信网络也必须是安全的，应该能为网络用户实现信息交换与资源共享。下文中，网络安全既指计算机网络安全，又指计算机通信网络安全。"
        let pstyle = NSMutableParagraphStyle()
        pstyle.lineSpacing = 6
        contentL.attributedText = NSAttributedString(string: txt, attributes: [.paragraphStyle : pstyle])
    }
    
    func setupUI() {
        avaterIV.contentMode = .scaleAspectFill
        avaterIV.layer.masksToBounds = true
        avaterIV.layer.cornerRadius = 20
        addSubview(avaterIV)
        avaterIV.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(17)
            make.left.equalTo(self.snp.left).offset(20)
            make.width.height.equalTo(40)
        }
        
        nameL.textColor = .hex("#333333")
        nameL.font = .systemFont(ofSize: 17)
        addSubview(nameL)
        nameL.snp.makeConstraints { make in
            make.top.equalTo(avaterIV.snp.top)
            make.left.equalTo(avaterIV.snp.right).offset(12)
        }
        
        dateL.textColor = .hex("#C8C8C8")
        dateL.font = .systemFont(ofSize: 12)
        addSubview(dateL)
        dateL.snp.makeConstraints { make in
            make.bottom.equalTo(avaterIV.snp.bottom).offset(-2)
            make.left.equalTo(nameL.snp.left)
        }
        
        titleL.font = .systemFont(ofSize: 17)
        addSubview(titleL)
        titleL.snp.makeConstraints { make in
            make.top.equalTo(avaterIV.snp.bottom).offset(27)
            make.left.equalTo(avaterIV.snp.left)
            make.right.equalTo(self.snp.right).offset(-20)
            make.width.equalTo(ScreenWidth - 40)
        }
        
        contentL.textColor = .hex("#444444")
        contentL.font = .systemFont(ofSize: 15)
        contentL.numberOfLines = 0
        addSubview(contentL)
        contentL.snp.makeConstraints { make in
            make.top.equalTo(titleL.snp.bottom).offset(22)
            make.left.equalTo(avaterIV.snp.left)
            make.right.equalTo(titleL.snp.right)
            make.width.equalTo(ScreenWidth - 40)
        }
        
        let fjV = NotiFJView()
        addSubview(fjV)
        fjV.snp.makeConstraints { make in
            make.top.equalTo(contentL.snp.bottom).offset(35)
            make.left.equalTo(contentL.snp.left)
            make.right.equalTo(contentL.snp.right)
            make.width.equalTo(ScreenWidth - 40)
            make.height.equalTo(80)
            make.bottom.equalTo(self.snp.bottom).offset(-20)
        }
    }
}


class NotiFJView: UIView {
    let iv = UIImageView()
    let keyL = UILabel()
    let valL = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .bg
        layer.cornerRadius = 10
        layer.masksToBounds = true
        
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        iv.image = UIImage(named: "ic_fj")
        iv.contentMode = .scaleAspectFit
        addSubview(iv)
        iv.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(19)
            make.left.equalTo(self.snp.left).offset(20)
            make.width.equalTo(12)
            make.height.equalTo(14)
        }
        
        keyL.text = "附件"
        keyL.textColor = .hex("#333333")
        keyL.font = .systemFont(ofSize: 16)
        addSubview(keyL)
        keyL.snp.makeConstraints { make in
            make.centerY.equalTo(iv.snp.centerY)
            make.left.equalTo(iv.snp.right).offset(8)
        }
        
        valL.text = "暂无附件"
        valL.textColor = .hex("#C8C8C8")
        valL.font = .systemFont(ofSize: 15)
        addSubview(valL)
        valL.snp.makeConstraints { make in
            make.top.equalTo(keyL.snp.bottom).offset(12)
            make.left.equalTo(keyL.snp.left)
        }
    }
}
