//
//  BSImagePickerView.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/17.
//

import Foundation
import UIKit
import Photos

class BSImagePickerView: UIView {
    var isRequired: Bool = false {
        didSet {
            updateEntry()
        }
    }
    
    var key: String = "现场拍照上传" {
        didSet {
            updateEntry()
        }
    }
    
    var maxCount: Int = 6 {
        didSet {
            updateEntry()
        }
    }
    
    var rowCount: Int = 3 {
        didSet {
            updateEntry()
        }
    }
    
    var itemHeight: CGFloat = (ScreenWidth - 40 - 3 * 5) / 3.0
    
    var images: [UIImage] = [] {
        didSet {
            let count = CGFloat(images.count / rowCount + 1)
            collectionView.snp.updateConstraints { (make) in
                make.height.equalTo((itemHeight + 20) * count)
            }
        }
    }
    
    let titleL = UILabel()
    let subTitleL = UILabel()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateEntry() {
        if key == "" {
            titleL.text = ""
            subTitleL.text = ""
            titleL.snp.remakeConstraints { make in
                make.height.equalTo(0)
                make.top.equalTo(self.snp.top).offset(16)
                make.left.equalTo(self.snp.left).offset(12)
            }
        } else {
            titleL.text = key
            subTitleL.text = "（\(isRequired ? "" : "非必选，")最多可上传\(maxCount)张图片）"
            titleL.snp.remakeConstraints { make in
                make.top.equalTo(self.snp.top).offset(6)
                make.left.equalTo(self.snp.left).offset(12)
            }
        }
        
        let count = CGFloat(images.count / rowCount + 1)

        collectionView.snp.updateConstraints { make in
            make.height.equalTo((itemHeight + 20) * count)
        }
    }

    func setupUI() {
        titleL.text = key
        titleL.font = UIFont.systemFont(ofSize: 16)
        titleL.textColor = .hex("#333333")
        addSubview(titleL)
        titleL.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(6)
            make.left.equalTo(self.snp.left).offset(12)
        }
        
        subTitleL.text = "（\(isRequired ? "" : "非必选，")最多可上传\(maxCount)张图片）"
        subTitleL.font = UIFont.systemFont(ofSize: 14)
        subTitleL.textColor = .hex("#BFBFBF")
        addSubview(subTitleL)
        subTitleL.snp.makeConstraints { make in
            make.centerY.equalTo(titleL.snp.centerY)
            make.left.equalTo(titleL.snp.right)
        }
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.register(BSImageCell.self, forCellWithReuseIdentifier: "BSImageCell")
        addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.centerX.left.right.bottom.equalToSuperview()
            make.top.equalTo(titleL.snp.bottom).offset(5)
            make.height.equalTo(itemHeight + 20)
        }
    }
}

extension BSImagePickerView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return min(maxCount, images.count + 1)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let w = (Int(collectionView.frame.width) - 20) / rowCount
        return CGSize(width: itemHeight, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BSImageCell", for: indexPath) as! BSImageCell
        
        if indexPath.row < images.count {
            cell.imageView.image = images[indexPath.row]
            cell.addView.isHidden = true
            cell.delBtn.isHidden = false
        } else {
            cell.addView.isHidden = false
            cell.delBtn.isHidden = true
        }
        
        cell.delBtn.tag = indexPath.item
        cell.delBtn.addTarget(self, action: #selector(deleteTapped), for: .touchUpInside)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == images.count {
//            selectPhotos()
            self.showImagePickerController(sourceType: .photoLibrary)

        } else {
            
        }
    }
    
    @objc func deleteTapped(_ sender: UIButton) {
        images.remove(at: sender.tag)
        collectionView.reloadData()
    }
}

extension BSImagePickerView: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//    func showChooseSourceTypeAlertController() {
//        let photoLibraryAction = UIAlertAction(title: "Choose a Photo", style: .default) { (action) in
//            self.showImagePickerController(sourceType: .photoLibrary)
//        }
//        let cameraAction = UIAlertAction(title: "Take a New Photo", style: .default) { (action) in
//            self.showImagePickerController(sourceType: .camera)
//        }
//        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
//        AlertService.showAlert(style: .actionSheet, title: nil, message: nil, actions: [photoLibraryAction, cameraAction, cancelAction], completion: nil)
//    }
    
    func showImagePickerController(sourceType: UIImagePickerController.SourceType) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
//        imagePickerController.allowsEditing = true
        imagePickerController.sourceType = sourceType
        getFirstViewController()?.present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            let image = editedImage.withRenderingMode(.alwaysOriginal)
            images.append(image)
            collectionView.reloadData()
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            let image = originalImage.withRenderingMode(.alwaysOriginal)
            images.append(image)
            collectionView.reloadData()
        }
        getFirstViewController()?.dismiss(animated: true, completion: nil)
    }
}


class BSImageCell: UICollectionViewCell {
    
    var imageView: UIImageView!
    
    let delBtn = UIButton()
    
    let addView = AddView()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.backgroundColor = .bg
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.contentView)
        }
        
        contentView.addSubview(addView)
        addView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.contentView)
        }
        
        delBtn.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        delBtn.tintColor = .white
        contentView.addSubview(delBtn)
        delBtn.snp.makeConstraints { make in
            make.width.height.equalTo(20)
            make.right.equalToSuperview().offset(-2)
            make.top.equalToSuperview().offset(2)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class AddView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .bg
        layer.cornerRadius = 8
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() {
        let iv = UIImageView()
        iv.image = UIImage(named: "ic_photo")
        iv.contentMode = .scaleAspectFit
        addSubview(iv)
        iv.snp.makeConstraints { make in
            make.width.equalTo(34)
            make.height.equalTo(27)
            make.centerY.equalTo(self.snp.centerY).offset(-8)
            make.centerX.equalTo(self.snp.centerX)
        }
        
        let titleL = UILabel()
        titleL.textColor = .hex("#BFBFBF")
        titleL.font = UIFont.systemFont(ofSize: 12)
        titleL.text = "拍照上传"
        addSubview(titleL)
        titleL.snp.makeConstraints { make in
            make.top.equalTo(iv.snp.bottom).offset(10)
            make.centerX.equalTo(self.snp.centerX)
        }
    }
}

//class AlertService {
//    static func showAlert(style: UIAlertController.Style, title: String?, message: String?, actions: [UIAlertAction] = [UIAlertAction(title: "Ok", style: .cancel, handler: nil)], completion: (() -> Swift.Void)? = nil) {
//        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
//        for action in actions {
//            alert.addAction(action)
//        }
//        if let topVC = UIApplication.getTopMostViewController() {
//            alert.popoverPresentationController?.sourceView = topVC.view
//            alert.popoverPresentationController?.sourceRect = CGRect(x: topVC.view.bounds.midX, y: topVC.view.bounds.midY, width: 0, height: 0)
//            alert.popoverPresentationController?.permittedArrowDirections = []
//            topVC.present(alert, animated: true, completion: completion)
//        }
//    }
//}
//
//extension UIApplication {
//    class func getTopMostViewController(base: UIViewController? = Utils.app.window?.rootViewController) -> UIViewController? {
//        if let nav = base as? UINavigationController {
//            return getTopMostViewController(base: nav.visibleViewController)
//        }
//        if let tab = base as? UITabBarController {
//            if let selected = tab.selectedViewController {
//                return getTopMostViewController(base: selected)
//            }
//        }
//        if let presented = base?.presentedViewController {
//            return getTopMostViewController(base: presented)
//        }
//        return base
//    }
//}
