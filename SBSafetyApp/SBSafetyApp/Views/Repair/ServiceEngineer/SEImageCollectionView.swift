//
//  SEImageCollectionView.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/29.
//

import Foundation
import UIKit
import Kingfisher

class SEImageCollectionView: UIView {
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

    var maxCount = 5 {
        didSet {
            updateEntry()
        }
    }
    
    var imgs: [String] = [] {
        didSet {
            updateEntry()
        }
    }
    
    var itemHeight = (ScreenWidth - 100) / 5 {
        didSet {
            updateEntry()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateEntry() {
        collectionView.reloadData()
        
        let count = CGFloat(imgs.count / maxCount + 1)
        collectionView.snp.updateConstraints { make in
            make.height.equalTo((itemHeight + 10) * count)
        }
    }
    
    // MARK: - Setup
    
    func setupUI() {
        let count = CGFloat(imgs.count / maxCount + 1)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.register(BSImageCell.self, forCellWithReuseIdentifier: "BSImageCell")
        addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.top.bottom.right.left.equalToSuperview()
            make.height.equalTo((itemHeight + 10) * count)
        }
    }
}

extension SEImageCollectionView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: itemHeight, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BSImageCell", for: indexPath) as! BSImageCell
        let imgStr = imgs[indexPath.row]
        let urlStr = "https://www.zhxqgl.top/bosc-ydaf" + imgStr
        cell.imageView.kf.setImage(with: URL(string: urlStr))
        cell.addView.isHidden = true
        cell.delBtn.isHidden = true
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let imgV = ImageVC()
        let imgStr = imgs[indexPath.row]
        imgV.urlStr = "https://www.zhxqgl.top/bosc-ydaf" + imgStr
        getFirstViewController()?.navigationController?.pushViewController(imgV, animated: true)
    }
}
