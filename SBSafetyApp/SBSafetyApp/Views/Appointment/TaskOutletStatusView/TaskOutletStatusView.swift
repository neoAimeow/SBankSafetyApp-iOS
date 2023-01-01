//
//  TaskOutletStatusView.swift
//  SBSafetyApp
//
//  Created by Aimeow on 2022/11/21.
//
// https://yzf.qq.com/fsna/kf-file/kf_pic/20221121/KFPIC_kfh5221fa29cfc019f_h5cded9881fc7d6fdfece5fb364b_WXIMAGE_d6605b74af5c4693aeec4d3536e33b50.png

import Foundation
import UIKit

class TaskOutletStatusModel: NSObject {

}

class TaskOutletStatusView: UIView {
    lazy var titleView: SectionTitleView = {
        let view = SectionTitleView(withStyle: SectionTitleStyleEnum.Style2, title: "网点完成情况")
        return view
    }()
    lazy var mainView: TaskOutletStatusMainView = {
        let view = TaskOutletStatusMainView()
        view.buildData(value: "0", title: "完成率")
        return view
    }()

    lazy var view1: TaskOutletStatusSubView = {
        let view = TaskOutletStatusSubView()
        view.buildData(value: 0, title: "总网点")
        return view
    }()

    lazy var view2: TaskOutletStatusSubView = {
        let view = TaskOutletStatusSubView()
        view.buildData(value: 0, title: "已完成")

        return view
    }()

    lazy var view3: TaskOutletStatusSubView = {
        let view = TaskOutletStatusSubView()
        view.buildData(value: 0, title: "未完成")
        return view
    }()

    lazy var detailView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 7

        let line1 = UIView.createLine()
        let line2 = UIView.createLine()

        view.addSubview(view1)
        view.addSubview(line1)
        view.addSubview(view2)
        view.addSubview(line2)
        view.addSubview(view3)


        view1.snp.makeConstraints { make in
            make.left.top.bottom.equalTo(view)
            make.height.equalTo(90)
        }

        line1.snp.makeConstraints { make in
            make.height.equalTo(43)
            make.width.equalTo(0.5)
            make.left.equalTo(view1.snp.right)
            make.centerY.equalTo(view1)
        }

        view2.snp.makeConstraints { make in
            make.height.equalTo(view1)
            make.width.equalTo(view1)
            make.left.equalTo(line1.snp.right)
            make.top.bottom.equalTo(view)
        }

        line2.snp.makeConstraints { make in
            make.height.equalTo(43)
            make.width.equalTo(0.5)
            make.centerY.equalTo(view2)
            make.left.equalTo(view2.snp.right)
        }

        view3.snp.makeConstraints { make in
            make.height.equalTo(view1)
            make.width.equalTo(view2)
            make.top.bottom.equalTo(view)
            make.left.equalTo(line2.snp.right)
            make.right.equalTo(view)
        }
        return view
    }()


    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .bg
        setupUI()
//        buildData(model: WdwcqkModel())
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func buildData(model: WdwcqkModel) {
        if let zwd = model.zwd {
            view1.buildData(value: zwd, title: "总网点")
        }

        if let zwcl = model.zwcl {
            mainView.buildData(value: zwcl, title: "完成率")
        }

        if let wczs = model.wczs {
            view2.buildData(value: wczs, title: "已完成")
        }

        if let wwczs = model.wwczs {
            view3.buildData(value: wwczs, title: "未完成")
        }
    }

    func setupUI() {
        addSubview(titleView)
        addSubview(mainView)
        addSubview(detailView)

        titleView.snp.makeConstraints { make in
            make.left.top.equalTo(self).offset(10)
            make.right.equalTo(self).offset(-10)
            make.height.equalTo(18)
        }

        mainView.snp.makeConstraints { make in
            make.top.equalTo(titleView.snp.bottom).offset(10)
            make.left.equalTo(self).offset(10)
            make.width.equalTo(90)
            make.height.equalTo(90)
            make.bottom.equalTo(self)
        }

        detailView.snp.makeConstraints { make in
            make.left.equalTo(mainView.snp.right).offset(10)
            make.top.height.equalTo(mainView)
            make.right.equalTo(self).offset(-10)
        }
    }
}
