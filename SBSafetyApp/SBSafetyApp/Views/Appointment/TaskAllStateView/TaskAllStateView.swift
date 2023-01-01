//
//  TaskOutletStatusView.swift
//  SBSafetyApp
//
//  Created by Aimeow on 2022/11/21.
//
// https://yzf.qq.com/fsna/kf-file/kf_pic/20221121/KFPIC_kfh5221fa29cfc019f_h5cded9881fc7d6fdfece5fb364b_WXIMAGE_ebbe4f64cf434f88b79ebc40987a46a7.png

import Foundation
import UIKit
#if !RX_NO_MODULE
import RxSwift
import RxCocoa
#endif

protocol TaskAllStatusViewDelegate: AnyObject {
    func goToTaskList()
}

class TaskAllStatusView: UIView {
    var disposeBag = DisposeBag()
    weak var delegate: TaskAllStatusViewDelegate?

    lazy var titleView: SectionTitleView = {
        let view = SectionTitleView(withStyle: SectionTitleStyleEnum.Style2, title: "各任务完成情况")
        return view
    }()

    lazy var loadMoreButton: LoadMoreButton = {
        let button = LoadMoreButton()

        button.rx.tapGesture().when(.recognized)
                .subscribe(onNext: { _ in
                    self.goTaskVC()
                })
                .disposed(by: disposeBag)

        return button
    }()

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (ScreenWidth - 60) / 3, height: 140)
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = false
        collectionView.register(TaskAllStateCell.self, forCellWithReuseIdentifier: "TaskAllStateCell")
        return collectionView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .bg
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var rwwcqkList: [RwwcqkModel] = []

    func buildData(rwwcqk: [RwwcqkModel]) {
        print(rwwcqk)
        rwwcqkList = rwwcqk
        collectionView.reloadData()
    }

    func setupUI() {
        addSubview(titleView)
        addSubview(loadMoreButton)
        addSubview(collectionView)
        titleView.snp.makeConstraints { make in
            make.left.top.equalTo(self).offset(10)
//            make.right.equalTo(self).offset(-10)
            make.height.equalTo(18)
        }

        loadMoreButton.snp.makeConstraints { make in
            make.right.equalTo(self).offset(-10)
            make.left.equalTo(titleView.snp.right)
            make.centerY.equalTo(titleView)
            make.width.equalTo(80)
        }
        collectionView.snp.makeConstraints { make in
            make.left.equalTo(self).offset(10)
            make.right.equalTo(self).offset(-10)
            make.top.equalTo(titleView.snp.bottom).offset(20)
            make.height.equalTo(140)
            make.bottom.equalTo(self)
        }
    }

    func goTaskVC() {
        delegate?.goToTaskList()
    }
}


extension TaskAllStatusView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = rwwcqkList.count
        if (count > 3) {
            return 3
        } else {
            return count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TaskAllStateCell", for: indexPath) as! TaskAllStateCell
        cell.buildData(rwwcqk: rwwcqkList[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        goTaskVC()
    }

}

