//
//  InspMaintenanceHeader.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/23.
//

import Foundation
import UIKit

protocol InspMainHeaderDelegate: AnyObject {
    func handleMonthDidSelected(_ month: Int)
}

class InspMaintenanceHeader: UIView {
    var datas = [Int](1...12)
    
    var month = Calendar.current.dateComponents([.month], from: Date()).month ?? 1

    weak var delegate: InspMainHeaderDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    func setupUI() {
        backgroundColor = .bg
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let collectionV = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionV.backgroundColor = .bg
        collectionV.dataSource = self
        collectionV.delegate = self
        collectionV.showsHorizontalScrollIndicator = false
        collectionV.register(InspMtHeaderCell.self, forCellWithReuseIdentifier: "InspMtHeaderCell")
        addSubview(collectionV)
        collectionV.snp.makeConstraints { (make) -> Void in
            make.left.right.top.bottom.equalToSuperview()
        }
        
        collectionV.scrollToItem(at: IndexPath(item: month - 1, section: 0), at: .left, animated: false)
    }
}

extension InspMaintenanceHeader: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 40, height: 40)
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datas.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InspMtHeaderCell", for: indexPath) as! InspMtHeaderCell
        cell.updateUI(withMonth: datas[indexPath.item], cur: month)
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        month = datas[indexPath.item]
        collectionView.reloadData()
        
        delegate?.handleMonthDidSelected(month)
    }
}

class InspMtHeaderCell: UICollectionViewCell {
    let titleL = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateUI(withMonth month: Int, cur: Int) {
        titleL.text = "\(month)月"
        
        if cur == month {
            titleL.backgroundColor = .primary
            titleL.textColor = .white
        } else {
            titleL.backgroundColor = .clear
            titleL.textColor = .hex("#777777")
        }
    }
    
    func setupUI() {
        titleL.textColor = .hex("#777777")
        titleL.textAlignment = .center
        titleL.font = .systemFont(ofSize: 14)
        titleL.layer.cornerRadius = 15
        titleL.layer.masksToBounds = true
        addSubview(titleL)
        titleL.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.height.equalTo(30)
        }
    }
}
