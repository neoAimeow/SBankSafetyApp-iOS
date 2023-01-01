//
// Created by Aimeow on 2022/12/8.
//

import Foundation
import Foundation
import UIKit


protocol AppointmentManagerPanelDelegate: AnyObject {
    func didSelected(year: Int, quarter: Int?, month: Int?, day: Int?, dateEnum: CustomDateEnum)
    func didTapDetailButton()
}

class AppointmentManagerPanel: UIView {
    weak var delegate: AppointmentManagerPanelDelegate?

    lazy var titleView: SectionTitleView = {
        let view = SectionTitleView(withStyle: SectionTitleStyleEnum.Style2, title: "履职管理")
        return view
    }()

    lazy var dateView: BSCustomDateView = {
        let view = BSCustomDateView()
        view.delegate = self
        return view
    }()

    lazy var completeRateView: TaskOutletStatusMainView = {
        let view = TaskOutletStatusMainView()
        return view
    }()

    lazy var detailView: UIView = {
        let view = UIView()
        view.backgroundColor = .hex("#F8F8F8")
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        view.addSubview(bankScrollView)
        view.addSubview(moreDetailButton)

        bankScrollView.snp.makeConstraints { make in
            make.left.equalTo(view).offset(15)
            make.top.bottom.equalTo(view)
        }

        moreDetailButton.snp.makeConstraints { make in
            make.left.equalTo(bankScrollView.snp.right)
            make.height.equalTo(30)
            make.width.equalTo(75)
            make.centerY.equalTo(view)
            make.right.equalTo(view.snp.right).offset(-15)
        }

        return view
    }()

    lazy var bankScrollView: UIScrollView = {
        let view = UIScrollView()
        return view
    }()

    lazy var moreDetailButton: UIButton = {
        let button = UIButton()
        button.setBGColor(.hex("#EB7D4A"), for: .normal)
        button.setTitle("查看详情", for: .normal)
        button.setTitleColor(.hex("#FFFFFF"), for: .normal)
        button.layer.masksToBounds = true
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        button.layer.cornerRadius = 2
        button.addTarget(self, action: #selector(didTapDetailButton(sender:)), for: .touchUpInside)
        return button
    }()

    init() {
        super.init(frame: .zero)
        backgroundColor = UIColor.white
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func buildData(_ completeRate: Double) {
        completeRateView.buildData(value: String(completeRate), title: "完成率")
    }

    func setupUI() {
        layer.cornerRadius = 8
        layer.masksToBounds = true
        backgroundColor = .white

        addSubview(titleView)
        addSubview(dateView)
        addSubview(completeRateView)
        addSubview(detailView)

        titleView.snp.makeConstraints { make in
            make.left.equalTo(self).offset(10)
            make.right.equalTo(self).offset(-10)
            make.top.equalTo(self).offset(20)
            make.height.equalTo(18)
        }

        dateView.snp.makeConstraints { make in
            make.left.right.equalTo(titleView)
            make.top.equalTo(titleView.snp.bottom).offset(12)
            make.height.equalTo(35)
        }

        completeRateView.snp.makeConstraints { make in
            make.top.equalTo(dateView.snp.bottom).offset(20)
            make.left.equalTo(self).offset(10)
            make.width.height.equalTo(90)
        }

        detailView.snp.makeConstraints { make in
            make.left.equalTo(completeRateView.snp.right).offset(10)
            make.top.equalTo(completeRateView)
            make.right.equalTo(self).offset(-10)
            make.height.equalTo(completeRateView)
            make.bottom.equalTo(self).offset(-20)
        }

    }

    @objc func didTapDetailButton(sender: UIButton) {
        delegate?.didTapDetailButton()
    }
}

extension AppointmentManagerPanel: BSCustomDateViewDelegate {
    func didSelected(year: Int, quarter: Int?, month: Int?, day: Int?, dateEnum: CustomDateEnum) {
        delegate?.didSelected(year: year, quarter: quarter, month: month, day: day, dateEnum: dateEnum);
    }
}
