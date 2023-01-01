//
//  CarouselView.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/21.
//

import Foundation
import UIKit

class CarouselView: UICollectionView {
    private var lastCellIndex: IndexPath?
    var scrollDirection: UICollectionView.ScrollDirection = .horizontal
    
    var inset: CGFloat = 0.0 {
        didSet {
            configureLayout()
        }
    }
    
    var currentCenterCell: UICollectionViewCell? {
        let lowerBound = inset - 20
        let upperBound = inset + 20
        
        for cell in visibleCells {
            let cellRect = convert(cell.frame, to: nil)
            if scrollDirection == .horizontal && cellRect.origin.x > lowerBound && cellRect.origin.x < upperBound  {
                return cell
            } else if scrollDirection == .vertical && cellRect.origin.y > lowerBound && cellRect.origin.y < upperBound {
                return cell
            }
        }
        
        return nil
    }
    
    var currentCellIndex: IndexPath? {
        guard let currentCenterCell = self.currentCenterCell else { return nil }
        
        return indexPath(for: currentCenterCell)
    }
    
    override var contentSize: CGSize {
        didSet {
            guard let dataSource = dataSource, let invisibleScroll = invisibleScroll else { return }
            let numberSections = dataSource.numberOfSections?(in: self) ?? 1
            var numberItems = 0
            for i in 0..<numberSections {
                let numberSectionItems = dataSource.collectionView(self, numberOfItemsInSection: i)
                numberItems += numberSectionItems
            }
            
            if scrollDirection == .horizontal {
                let contentWidth = invisibleScroll.frame.width * CGFloat(numberItems)
                invisibleScroll.contentSize = CGSize(width: contentWidth, height: invisibleScroll.frame.height)
            } else {
                let contentHeight = invisibleScroll.frame.height * CGFloat(numberItems)
                invisibleScroll.contentSize = CGSize(width: invisibleScroll.frame.width, height: contentHeight)
            }
        }
    }
    
    fileprivate var invisibleScroll: UIScrollView!
        
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    convenience init(withFrame frame: CGRect, andInset inset: CGFloat) {
        self.init(frame: frame, collectionViewLayout: CarouselLayout(withCarouselInset: inset))
        
        self.inset = inset
    }
        
    override func scrollRectToVisible(_ rect: CGRect, animated: Bool) {
        invisibleScroll.setContentOffset(rect.origin, animated: animated)
    }
    
    override func scrollToItem(at indexPath: IndexPath, at scrollPosition: UICollectionView.ScrollPosition, animated: Bool) {
        super.scrollToItem(at: indexPath, at: scrollPosition, animated: animated)
        var origin = (CGFloat(indexPath.item) * (frame.size.width - (inset * 2)))
        var rect = CGRect(x: origin, y: 0, width: frame.size.width - (inset * 2), height: frame.height)
        if scrollDirection == .vertical {
            origin = (CGFloat(indexPath.item) * (frame.size.height - (inset * 2)))
            rect = CGRect(x: 0, y: origin, width: frame.width, height: frame.size.height - (inset * 2))
        }
        scrollRectToVisible(rect, animated: animated)
        lastCellIndex = indexPath
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        addinvisibleScroll(to: superview)
    }
    
    func didScroll() {
        scrollViewDidScroll(self)
    }

    func deviceRotated() {
        guard let lastCellIndex = currentCellIndex ?? lastCellIndex else { return }
        DispatchQueue.main.async {
            self.reloadData()
            var position: UICollectionView.ScrollPosition = .centeredHorizontally
            if self.scrollDirection == .vertical {
                position = .centeredVertically
            }
            self.scrollToItem(at: lastCellIndex, at: position, animated: false)
            self.didScroll()
        }
    }
}

private typealias PrivateAPI = CarouselView
fileprivate extension PrivateAPI {
    
    func addinvisibleScroll(to superview: UIView?) {
        guard let superview = superview else { return }
        invisibleScroll = UIScrollView(frame: bounds)
        invisibleScroll.translatesAutoresizingMaskIntoConstraints = false
        invisibleScroll.isPagingEnabled = true
        invisibleScroll.showsHorizontalScrollIndicator = false
        invisibleScroll.showsVerticalScrollIndicator = false
        invisibleScroll.isUserInteractionEnabled = false
        invisibleScroll.delegate = self
        addGestureRecognizer(invisibleScroll.panGestureRecognizer)
        superview.addSubview(invisibleScroll)
        if scrollDirection == .horizontal {
            invisibleScroll.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
            invisibleScroll.topAnchor.constraint(equalTo: topAnchor).isActive = true
        } else {
            invisibleScroll.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
            invisibleScroll.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        }
        configureLayout()
    }
    
    func configureLayout() {
        collectionViewLayout = CarouselLayout(withCarouselInset: inset)
        guard let invisibleScroll = invisibleScroll else { return }
        if scrollDirection == .horizontal {
            invisibleScroll.snp.makeConstraints { make in
                make.width.equalTo(self.snp.width).offset(-(2 * inset))
                make.left.equalTo(self.snp.left).offset(inset)
            }
        } else  {
            invisibleScroll.snp.makeConstraints { make in
                make.height.equalTo(self.snp.height).offset(-(2 * inset))
                make.top.equalTo(self.snp.top).offset(inset)
            }
        }
        isPagingEnabled = true
        isScrollEnabled = false
    }
}

private typealias InvisibleScrollDelegate = CarouselView
extension InvisibleScrollDelegate: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateOffSet()
        for cell in visibleCells {
            if let infoCardCell = cell as? CarouselCell {
                infoCardCell.scale(withCarouselInset: inset)
            }
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        delegate?.scrollViewDidEndDecelerating?(scrollView)
        guard let indexPath = currentCellIndex else { return }
        lastCellIndex = indexPath
    }
    
    private func updateOffSet() {
        contentOffset = invisibleScroll.contentOffset
    }
}

class CarouselLayout: UICollectionViewFlowLayout {
    var inset: CGFloat = 0.0
    
    convenience init(withCarouselInset inset: CGFloat = 0.0) {
        self.init()
        self.inset = inset
    }
    
    override func prepare() {
        guard let collectionViewSize = collectionView?.frame.size else { return }
        itemSize = collectionViewSize
        
        var direction: UICollectionView.ScrollDirection = .horizontal
        if let collectionView = collectionView as? CarouselView {
            direction = collectionView.scrollDirection
        }
        scrollDirection = direction
        if scrollDirection == .vertical {
            itemSize.height = itemSize.height - (inset * 2)
            sectionInset = UIEdgeInsets(top: inset, left: 0.0, bottom: inset, right: 0.0)

        } else {
            itemSize.width = itemSize.width - (inset * 2)
            sectionInset = UIEdgeInsets(top: 0.0, left: inset, bottom: 0.0, right: inset)
        }
        collectionView?.isPagingEnabled = true
        minimumLineSpacing = 0.0
        minimumInteritemSpacing = 0.0
        footerReferenceSize = CGSize.zero
        headerReferenceSize = CGSize.zero
    }
}

class CarouselCell: UICollectionViewCell {
    var scaleMinimum: CGFloat = 0.9
    var scaleDivisor: CGFloat = 10.0
    var alphaMinimum: CGFloat = 0.85
    var cornerRadius: CGFloat = 10.0
    
    public var mainIV: UIImageView!
    
    // MARK: - Overrides
    
    override func layoutSubviews() {
        super.layoutSubviews()
        guard let carouselView = superview as? CarouselView else { return }
        scale(withCarouselInset: carouselView.inset)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        mainIV.transform = CGAffineTransform.identity
        mainIV.alpha = 1.0
    }
    
    func scale(withCarouselInset carouselInset: CGFloat) {
        guard let superview = superview, let mainIV = mainIV else { return }
        
        var origin = superview.convert(frame, to: superview.superview).origin.x
        var contentWidthOrHeight = frame.size.width
        if let collectionView = superview as? CarouselView, collectionView.scrollDirection == .vertical {
            origin = superview.convert(frame, to: superview.superview).origin.y
            contentWidthOrHeight = frame.size.height
        }
        
        let originActual = origin - carouselInset
        
        let scaleCalculator = abs(contentWidthOrHeight - abs(originActual))
        let percentageScale = (scaleCalculator/contentWidthOrHeight)
        let scaleValue = scaleMinimum + (percentageScale/scaleDivisor)
        let alphaValue = alphaMinimum + (percentageScale/scaleDivisor)
        
        let affineIdentity = CGAffineTransform.identity
        mainIV.transform = affineIdentity.scaledBy(x: scaleValue, y: scaleValue)
        mainIV.alpha = alphaValue
        mainIV.layer.cornerRadius = cornerRadius
        mainIV.layer.masksToBounds = true
    }
}
