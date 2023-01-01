//
// Created by Aimeow on 2022/12/12.
//

import Foundation
import UIKit
#if !RX_NO_MODULE
import RxSwift
import RxCocoa
#endif

protocol SimpleListViewDelegate: AnyObject {
    func numberOfListCell() -> Int;
    func listView(_ listView: SimpleListView, didSelectAt index: Int) -> Void;
    func listView(_ listView: SimpleListView, cellAt index: Int) -> UIView;
    func heightOfCell() -> Double;

}

class SimpleListView: UIView {
    weak var delegate: SimpleListViewDelegate?
    var disposeBag = DisposeBag()

    lazy var contentView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        return stackView
    }()

    lazy var emptyView: UIView = {
        let view = UIView()

        let imageView = UIImageView(image: UIImage(named: "ic_empty"))
        imageView.contentMode = UIView.ContentMode.scaleAspectFit

        let label = UILabel()
        label.text = "您的帐号无任务"
        label.textColor = .hex("#D5D9E2")
        label.font = UIFont.systemFont(ofSize: 17)

        view.addSubview(imageView)
        view.addSubview(label)

        imageView.snp.makeConstraints { make in
            make.height.width.equalTo(100)
            make.centerX.equalTo(view)
            make.top.equalTo(66)
        }

        label.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(imageView.snp.bottom).offset(30)
        }
        return view
    }()


    init() {
        super.init(frame: .zero)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    func setupUI() {
        addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalTo(self)
        }
    }

    public func reloadData() {
        contentView.removeAllSubViews()
        let count = delegate?.numberOfListCell() ?? 0

        if (count == 0) {
            contentView.addArrangedSubview(emptyView)
            emptyView.snp.makeConstraints { make in
                make.left.right.equalTo(contentView)
                make.height.equalTo(276)
            }
        } else {
            for i in (0..<count) {
                if let cell = delegate?.listView(self, cellAt: i) {
                    cell.rx.tapGesture().when(.recognized)
                            .subscribe(onNext: { [self] _ in
                                delegate?.listView(self, didSelectAt: i);
                            })
                            .disposed(by: disposeBag)

                    contentView.addArrangedSubview(cell)

                    if let height = delegate?.heightOfCell() {
                        cell.snp.makeConstraints { make in
                            make.left.equalTo(contentView)
                            make.right.equalTo(contentView)
                            make.height.equalTo(height)
                        }
                    }

                }
            }
        }

    }
}
