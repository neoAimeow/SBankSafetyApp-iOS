//
//  HomeCarouselView.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/21.
//

import Foundation
import UIKit

class HomeCarouselView: UIView {
    fileprivate var carousel: CarouselView!
    
    let datas: [String] = ["banner_1", "banner_2", "banner_3"]

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        let frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: 130)
        carousel = CarouselView(withFrame: frame, andInset: 25)
        carousel.scrollDirection = .horizontal
        carousel.dataSource = self
        carousel.delegate = self
        carousel.backgroundColor = .clear
        carousel.register(HomeCarouselCell.self, forCellWithReuseIdentifier: "HomeCarouselCell")
        addSubview(carousel)
        carousel.snp.makeConstraints { make in
            make.centerX.top.left.right.equalToSuperview()
            make.height.equalTo(130)
        }
    }
}

extension HomeCarouselView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCarouselCell", for: indexPath)
        let data = datas[indexPath.item]
        (cell as! HomeCarouselCell).mainIV.image = UIImage(named: data)
        DispatchQueue.main.async {
            cell.setNeedsLayout()
            cell.layoutIfNeeded()
        }

        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        carousel.didScroll()
    }
}

class HomeCarouselCell: CarouselCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        mainIV = UIImageView()
        mainIV.contentMode = .scaleAspectFill
        contentView.addSubview(mainIV)
        mainIV.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
