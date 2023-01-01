//
//  ScrollableSegmentedControl.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/21.
//

import Foundation
import UIKit

@IBDesignable
@objc public class ScrollableSegmentedControl: UIControl {
    fileprivate let flowLayout = UICollectionViewFlowLayout()
    fileprivate var collectionView: UICollectionView?
    private var collectionViewController: CollectionViewController?
    private var segmentsData = [SegmentData]()
    private var longestTextWidth: CGFloat = 10

    var isClick: Bool = false

    public var fixedSegmentWidth: Bool = true {
        didSet {
            if oldValue != fixedSegmentWidth {
                setNeedsLayout()
            }
        }
    }

    override public var tintColor: UIColor! {
        didSet {
            collectionView?.tintColor = tintColor
            reloadSegments()
        }
    }

    fileprivate var _segmentContentColor: UIColor?
    @objc public dynamic var segmentContentColor: UIColor? {
        get {
            return _segmentContentColor
        }
        set {
            _segmentContentColor = newValue
            reloadSegments()
        }
    }

    fileprivate var _selectedSegmentContentColor: UIColor?
    @objc public dynamic var selectedSegmentContentColor: UIColor? {
        get {
            return _selectedSegmentContentColor
        }
        set {
            _selectedSegmentContentColor = newValue
            reloadSegments()
        }
    }


    override public init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }

    fileprivate var normalAttributes: [NSAttributedString.Key: Any]?
    fileprivate var highlightedAttributes: [NSAttributedString.Key: Any]?
    fileprivate var selectedAttributes: [NSAttributedString.Key: Any]?
    fileprivate var _titleAttributes: [UInt: [NSAttributedString.Key: Any]] = [UInt: [NSAttributedString.Key: Any]]()

    @objc public func setTitleTextAttributes(_ attributes: [NSAttributedString.Key: Any]?, for state: UIControl.State) {
        _titleAttributes[state.rawValue] = attributes

        normalAttributes = _titleAttributes[UIControl.State.normal.rawValue]
        highlightedAttributes = _titleAttributes[UIControl.State.highlighted.rawValue]
        selectedAttributes = _titleAttributes[UIControl.State.selected.rawValue]

        for segment in segmentsData {
            configureAttributedTitlesForSegment(segment)

            if let title = segment.title {
                calculateLongestTextWidth(text: title)
            }
        }

        flowLayout.invalidateLayout()
        reloadSegments()
    }

    private func configureAttributedTitlesForSegment(_ segment: SegmentData) {
        segment.normalAttributedTitle = nil
        segment.highlightedAttributedTitle = nil
        segment.selectedAttributedTitle = nil

        if let title = segment.title {
            if normalAttributes != nil {
                segment.normalAttributedTitle = NSAttributedString(string: title, attributes: normalAttributes!)
            }

            if highlightedAttributes != nil {
                segment.highlightedAttributedTitle = NSAttributedString(string: title, attributes: highlightedAttributes!)
            } else {
                if selectedAttributes != nil {
                    segment.highlightedAttributedTitle = NSAttributedString(string: title, attributes: selectedAttributes!)
                } else {
                    if normalAttributes != nil {
                        segment.highlightedAttributedTitle = NSAttributedString(string: title, attributes: normalAttributes!)
                    }
                }
            }

            if selectedAttributes != nil {
                segment.selectedAttributedTitle = NSAttributedString(string: title, attributes: selectedAttributes!)
            } else {
                if highlightedAttributes != nil {
                    segment.selectedAttributedTitle = NSAttributedString(string: title, attributes: highlightedAttributes!)
                } else {
                    if normalAttributes != nil {
                        segment.selectedAttributedTitle = NSAttributedString(string: title, attributes: normalAttributes!)
                    }
                }
            }
        }
    }

    @objc public func titleTextAttributes(for state: UIControl.State) -> [NSAttributedString.Key: Any]? {
        return _titleAttributes[state.rawValue]
    }

    // MARK: - Managing Segments

    @objc public func insertSegment(withAttriTitle attriTitle: NSAttributedString, at index: Int) {
        let segment = SegmentData()
        segment.normalAttributedTitle = attriTitle
        segment.highlightedAttributedTitle = attriTitle
        segment.highlightedAttributedTitle = attriTitle
        segmentsData.insert(segment, at: index)
        reloadSegments()
    }

    @objc public func updateSegment(withAttriTitle attriTitle: NSAttributedString, at index: Int) {
        let segment = SegmentData()
        segment.normalAttributedTitle = attriTitle
        segment.highlightedAttributedTitle = attriTitle
        segment.highlightedAttributedTitle = attriTitle
        //        segmentsData.insert(segment, at: index)
        segmentsData.remove(at: index)
        segmentsData.insert(segment, at: index)
        reloadSegments()
    }

    @objc public func insertSegment(withTitle title: String, at index: Int) {
        let segment = SegmentData()
        segment.title = title
        configureAttributedTitlesForSegment(segment)
        segmentsData.insert(segment, at: index)
        calculateLongestTextWidth(text: title)
        reloadSegments()
    }


    @objc public func updateSegment(withTitle title: String, at index: Int) {
        let segment = SegmentData()
        segment.title = title
        configureAttributedTitlesForSegment(segment)
        segmentsData.remove(at: index)
        segmentsData.insert(segment, at: index)
        calculateLongestTextWidth(text: title)
        reloadSegments()
    }


    @objc public func removeSegment(at index: Int) {
        segmentsData.remove(at: index)
        if (selectedSegmentIndex == index) {
            selectedSegmentIndex = selectedSegmentIndex - 1
        } else if (selectedSegmentIndex > segmentsData.count) {
            selectedSegmentIndex = -1
        }
        reloadSegments()
    }

    @objc public func removeAll() {
        segmentsData.removeAll()
        selectedSegmentIndex = -1
        reloadSegments()
    }

    @objc public var numberOfSegments: Int {
        return segmentsData.count
    }

    @objc public func titleForSegment(at segment: Int) -> String? {
        if segmentsData.count == 0 {
            return nil
        }

        return safeSegmentData(forIndex: segment).title
    }

    @objc public var selectedSegmentIndex: Int = -1 {
        didSet {
            if selectedSegmentIndex < -1 {
                selectedSegmentIndex = -1
            } else if selectedSegmentIndex > segmentsData.count - 1 {
                selectedSegmentIndex = segmentsData.count - 1
            }

            if selectedSegmentIndex >= 0 {
                var scrollPossition: UICollectionView.ScrollPosition = .bottom
                let indexPath = IndexPath(item: selectedSegmentIndex, section: 0)
                if let atribs = collectionView?.layoutAttributesForItem(at: indexPath) {
                    let frame = atribs.frame
                    if frame.origin.x < collectionView!.contentOffset.x {
                        scrollPossition = .left
                    } else if frame.origin.x + frame.size.width > (collectionView!.frame.size.width + collectionView!.contentOffset.x) {
                        scrollPossition = .right
                    }
                }

                collectionView?.selectItem(at: indexPath, animated: true, scrollPosition: scrollPossition)
            } else {
                if let indexPath = collectionView?.indexPathsForSelectedItems?.first {
                    collectionView?.deselectItem(at: indexPath, animated: true)
                }
            }

            if isClick && oldValue != selectedSegmentIndex {
                self.sendActions(for: .valueChanged)
                isClick = false
            }
        }
    }

    /**
     Configure if the selected segment should have underline. Default value is false.
     */
    @IBInspectable
    @objc public var underlineSelected: Bool = false

    @objc public var isSmallLine: Bool = false

    @objc public var isFullLine: Bool = false

    // MARK: - Layout management

    override public func layoutSubviews() {
        super.layoutSubviews()

        guard let collectionView_ = collectionView else {
            return
        }

        collectionView_.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
        collectionView_.contentOffset = CGPoint(x: 0, y: 0)
        collectionView_.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

        flowLayout.invalidateLayout()
        configureSegmentSize()
        reloadSegments()
    }

    // MARK: - Private

    fileprivate func configure() {
        clipsToBounds = true

        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0

        collectionView = UICollectionView(frame: frame, collectionViewLayout: flowLayout)
        collectionView!.tag = 1
        collectionView!.tintColor = tintColor
        collectionView!.register(TextOnlySegmentCollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewController.textOnlyCellIdentifier)
        collectionViewController = CollectionViewController(segmentedControl: self)
        collectionView!.dataSource = collectionViewController
        collectionView!.delegate = collectionViewController
        collectionView!.backgroundColor = UIColor.clear
        collectionView!.showsHorizontalScrollIndicator = false
        addSubview(collectionView!)
    }

    fileprivate func configureSegmentSize() {
        let width: CGFloat

        if fixedSegmentWidth == true {
            if collectionView!.frame.size.width > longestTextWidth * CGFloat(segmentsData.count) {
                width = collectionView!.frame.size.width / CGFloat(segmentsData.count)
            } else {
                width = longestTextWidth
            }

            flowLayout.estimatedItemSize = CGSize()
            flowLayout.itemSize = CGSize(width: width, height: frame.size.height)
        } else {
            width = 1.0
            flowLayout.itemSize = CGSize(width: width, height: frame.size.height)
            flowLayout.estimatedItemSize = CGSize(width: width, height: frame.size.height)
        }
    }

    fileprivate func calculateLongestTextWidth(text: String) {
        let fontAttributes: [NSAttributedString.Key: Any]
        if normalAttributes != nil {
            fontAttributes = normalAttributes!
        } else if highlightedAttributes != nil {
            fontAttributes = highlightedAttributes!
        } else if selectedAttributes != nil {
            fontAttributes = selectedAttributes!
        } else {
            fontAttributes = [NSAttributedString.Key.font: BaseSegmentCollectionViewCell.defaultFont]
        }

        let size = (text as NSString).size(withAttributes: fontAttributes)
        let newLongestTextWidth = 2.0 + size.width + BaseSegmentCollectionViewCell.textPadding * 2
        if newLongestTextWidth > longestTextWidth {
            longestTextWidth = newLongestTextWidth
            configureSegmentSize()
        }
    }

    private func safeSegmentData(forIndex index: Int) -> SegmentData {
        let segmentData: SegmentData

        if index <= 0 {
            segmentData = segmentsData[0]
        } else if index >= segmentsData.count {
            segmentData = segmentsData[segmentsData.count - 1]
        } else {
            segmentData = segmentsData[index]
        }

        return segmentData
    }

    fileprivate func reloadSegments() {
        if let collectionView_ = collectionView {
            collectionView_.reloadData()
            if selectedSegmentIndex >= 0 {
                let indexPath = IndexPath(item: selectedSegmentIndex, section: 0)
                collectionView_.selectItem(at: indexPath, animated: true, scrollPosition: .bottom)
            }
        }
    }

    /*
     Private internal classes to be used only by this class.
     */

    // MARK: - SegmentData

    final private class SegmentData {
        var title: String?
        var normalAttributedTitle: NSAttributedString?
        var highlightedAttributedTitle: NSAttributedString?
        var selectedAttributedTitle: NSAttributedString?
    }

    // MARK: - CollectionViewController

    /**
     A CollectionViewController is private inner class with main purpose to hide UICollectionView protocol conformances.
     */
    final private class CollectionViewController: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
        static let textOnlyCellIdentifier = "textOnlyCellIdentifier"

        private weak var segmentedControl: ScrollableSegmentedControl!

        init(segmentedControl: ScrollableSegmentedControl) {
            self.segmentedControl = segmentedControl
        }

        // UICollectionViewDataSource

        fileprivate func numberOfSections(in collectionView: UICollectionView) -> Int {
            return 1
        }


        fileprivate func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return segmentedControl.numberOfSegments
        }

        fileprivate func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let data = segmentedControl.segmentsData[indexPath.item]

            let segmentCell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewController.textOnlyCellIdentifier, for: indexPath) as! TextOnlySegmentCollectionViewCell
            segmentCell.titleLabel.text = data.title

            segmentCell.isSmallLine = segmentedControl.isSmallLine
            segmentCell.isFullLine = segmentedControl.isFullLine
            segmentCell.showUnderline = segmentedControl.underlineSelected
            if segmentedControl.underlineSelected {
                segmentCell.tintColor = segmentedControl.tintColor
            }

            segmentCell.contentColor = segmentedControl.segmentContentColor
            segmentCell.selectedContentColor = segmentedControl.selectedSegmentContentColor

            segmentCell.normalAttributedTitle = data.normalAttributedTitle
            segmentCell.highlightedAttributedTitle = data.highlightedAttributedTitle
            segmentCell.selectedAttributedTitle = data.selectedAttributedTitle

            return segmentCell
        }

        // MARK: - UICollectionViewDelegate

        fileprivate func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            segmentedControl.isClick = true
            segmentedControl.selectedSegmentIndex = indexPath.item
        }

        fileprivate func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
            var label: UILabel?
            if let _cell = cell as? TextOnlySegmentCollectionViewCell {
                label = _cell.titleLabel
            }

            if let titleLabel = label {
                let data = segmentedControl.segmentsData[indexPath.item]

                if cell.isHighlighted && data.highlightedAttributedTitle != nil {
                    titleLabel.attributedText = data.highlightedAttributedTitle!
                } else if cell.isSelected && data.selectedAttributedTitle != nil {
                    titleLabel.attributedText = data.selectedAttributedTitle!
                } else {
                    if data.normalAttributedTitle != nil {
                        titleLabel.attributedText = data.normalAttributedTitle!
                    }
                }
            }
        }
    }


    // MARK: - SegmentCollectionViewCell

    private class BaseSegmentCollectionViewCell: UICollectionViewCell {
        static let textPadding: CGFloat = 0.0
        static let defaultFont = UIFont.systemFont(ofSize: 16)
        static let defaultTextColor = UIColor.darkGray

        var underlineView: UIView?
        public var contentColor: UIColor?
        public var selectedContentColor: UIColor?

        var normalAttributedTitle: NSAttributedString?
        var highlightedAttributedTitle: NSAttributedString?
        var selectedAttributedTitle: NSAttributedString?
        var variableConstraints = [NSLayoutConstraint]()

        var isSmallLine: Bool = false
        var isFullLine: Bool = false

        var showUnderline: Bool = false {
            didSet {
                if oldValue != showUnderline {
                    if oldValue == false && underlineView != nil {
                        underlineView?.removeFromSuperview()
                    } else {
                        underlineView = UIView()
                        underlineView!.tag = 999
                        underlineView!.backgroundColor = tintColor
                        underlineView!.isHidden = !isSelected
                        if isSmallLine {
                            underlineView!.layer.cornerRadius = 2
                        }
                        underlineView!.layer.masksToBounds = true
                        contentView.insertSubview(underlineView!, at: contentView.subviews.count)
                    }

                    configureConstraints()
                }
            }
        }

        override var tintColor: UIColor! {
            didSet {
                underlineView?.backgroundColor = tintColor
            }
        }

        override init(frame: CGRect) {
            super.init(frame: frame)
            configure()
        }

        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            configure()
        }

        func configure() {
            configureConstraints()
        }

        private func configureConstraints() {
            if let underline = underlineView {
                underline.translatesAutoresizingMaskIntoConstraints = false
                if isSmallLine {
                    underline.heightAnchor.constraint(equalToConstant: 4.0).isActive = true
                    underline.widthAnchor.constraint(equalToConstant: 15.0).isActive = true
                    underline.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
                    underline.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
                } else {
                    if isFullLine {
                        underline.heightAnchor.constraint(equalToConstant: 3.0).isActive = true
                        underline.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
                        underline.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
                        underline.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
                    } else {
                        underline.heightAnchor.constraint(equalToConstant: 3.0).isActive = true
                        underline.widthAnchor.constraint(equalToConstant: 58.0).isActive = true
                        underline.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
                        underline.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
                    }
                }
            }
        }

        override func setNeedsUpdateConstraints() {
            super.setNeedsUpdateConstraints()
            NSLayoutConstraint.deactivate(variableConstraints)
            variableConstraints.removeAll()
        }

        override var isHighlighted: Bool {
            didSet {
                underlineView?.isHidden = !isHighlighted && !isSelected
            }
        }

        override var isSelected: Bool {
            didSet {
                underlineView?.isHidden = !isSelected
            }
        }
    }

    private class TextOnlySegmentCollectionViewCell: BaseSegmentCollectionViewCell {
        let titleLabel = UILabel()

        override var contentColor: UIColor? {
            didSet {
                titleLabel.textColor = (contentColor == nil) ? BaseSegmentCollectionViewCell.defaultTextColor : contentColor!
            }
        }

        override var selectedContentColor: UIColor? {
            didSet {
                titleLabel.highlightedTextColor = (selectedContentColor == nil) ? UIColor.black : selectedContentColor!
            }
        }

        override var isHighlighted: Bool {
            didSet {
                if let title = (isHighlighted) ? super.highlightedAttributedTitle : super.normalAttributedTitle {
                    titleLabel.attributedText = title
                } else {
                    titleLabel.isHighlighted = isHighlighted
                }
            }
        }

        override var isSelected: Bool {
            didSet {
                if isSelected {
                    if let title = super.selectedAttributedTitle {
                        titleLabel.attributedText = title
                    } else {
                        titleLabel.textColor = (selectedContentColor == nil) ? UIColor.black : selectedContentColor!
                    }
                } else {
                    if let title = super.normalAttributedTitle {
                        titleLabel.attributedText = title
                    } else {
                        titleLabel.textColor = (contentColor == nil) ? BaseSegmentCollectionViewCell.defaultTextColor : contentColor!
                    }
                }
            }
        }

        override func configure() {
            super.configure()
            contentView.addSubview(titleLabel)
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            titleLabel.textColor = BaseSegmentCollectionViewCell.defaultTextColor
            titleLabel.font = BaseSegmentCollectionViewCell.defaultFont
            titleLabel.textAlignment = .center
        }

        override func updateConstraints() {
            super.updateConstraints()
            NSLayoutConstraint.deactivate(variableConstraints)
            variableConstraints.removeAll()

            variableConstraints.append(titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor))
            variableConstraints.append(titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor))
            variableConstraints.append(titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: BaseSegmentCollectionViewCell.textPadding))
            variableConstraints.append(titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -BaseSegmentCollectionViewCell.textPadding))

            NSLayoutConstraint.activate(variableConstraints)
        }
    }
}
