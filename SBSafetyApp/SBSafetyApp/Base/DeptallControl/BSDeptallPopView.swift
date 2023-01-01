//
//  BSDeptallPopView.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/12/7.
//

import Foundation
import UIKit
import JFPopup

protocol BSDeptallPopViewDelegate: AnyObject {
    func handleSelected(_ dept: DeptModal?)
}

class BSDeptallPopView: UIView {
    let headerV = BSSearchButton(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 60))
    let tableView = TreeTableView(frame: .zero, style: .grouped)

    let resultV = BSDeptallResultView()

    weak var delegate: BSDeptallPopViewDelegate?

    var datas: [DeptModal?] = []
        
    var sortDatas: [DeptModal] = []

    private var nodes: [Node] = []
    
    var selectDept: DeptModal?

    init(withDeptName deptName: String) {
        super.init(frame: .zero)
        setupUI()
        reloadData(withDeptName: deptName)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reloadData(withDeptName deptName: String) {
        showToastActivity()
        API.getHomeDeptall(withParam: HomeParam(deptName: deptName), block: { responseModel in
            DispatchQueue.main.async {
                self.datas = responseModel.models ?? []
                self.sortDatas = self.sortDepts()
                self.hideToastActivity()
                self.tableView.tableShowEmpty(withDataCount: self.datas.count)
                self.tableView.treeDataSource = self
                self.tableView.treeDelegate = self
                self.tableView.reloadData()
            }
        })
    }
    
    func sortDepts() -> [DeptModal] {
        var dts: [DeptModal] = []
        var topDept = datas[0]
        if topDept != nil {
            let childs: [DeptModal] = addChilds(parentDept: topDept!)
            topDept!.children = childs
            dts.append(topDept!)
            return [topDept!]
        }
        return []
    }
    
    func addChilds(parentDept: DeptModal) -> [DeptModal] {
        let childs = datas.filter({ $0?.parentId == parentDept.deptId })
        var newChilds: [DeptModal] = []
        for child in childs {
            var newChild = child
            let sub_childs: [DeptModal] = addChilds(parentDept: child!)
            newChild?.children = sub_childs
            newChilds.append(newChild!)
        }
        return newChilds
    }
    
    @objc func showSearchTapped() {
        if resultV.superview == nil {
            resultV.delegate = self
            addSubview(resultV)
            resultV.snp.makeConstraints { make in
                make.top.left.right.bottom.equalToSuperview()
            }
            resultV.resetUI()
        }
    }
    
    @objc func cencelTFTapped() {
        if resultV.superview != nil {
            resultV.delegate = nil
            resultV.removeFromSuperview()
        }
    }
    
    @objc func clearTapped() {
        getFirstViewController()?.popup.dismissPopup()
    }
    
    @objc func saveTapped() {
        if selectDept != nil {
            delegate?.handleSelected(selectDept)
        }
    }
    
    func setupUI() {
        headerV.titleL.text = "搜索网点"
        headerV.padding = 25
        headerV.ctl.addTarget(self, action: #selector(showSearchTapped), for: .touchUpInside)
        addSubview(headerV)
        headerV.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().offset(10)
            make.height.equalTo(40)
        }
        
        let clearBtn = UIButton.createDefaultLarge("取消")
        clearBtn.addTarget(self, action: #selector(clearTapped), for: .touchUpInside)
        addSubview(clearBtn)
        clearBtn.snp.makeConstraints { make in
            make.left.equalTo(self.snp.left).offset(16)
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-8)
            make.width.equalTo((ScreenWidth - 48) / 2)
            make.height.equalTo(50)
        }
        
        let saveBtn = UIButton.createPrimaryLarge("确认")
        saveBtn.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
        addSubview(saveBtn)
        saveBtn.snp.makeConstraints { make in
            make.left.equalTo(clearBtn.snp.right).offset(16)
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-8)
            make.right.equalTo(self.snp.right).offset(-16)
            make.height.equalTo(50)
        }
        
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .white
        addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(headerV.snp.bottom).offset(16)
            make.bottom.equalTo(saveBtn.snp.top)
        }
        
        resultV.headerV.cancelBtn.addTarget(self, action: #selector(cencelTFTapped), for: .touchUpInside)
    }
    
    private func addNode(from dept: DeptModal) {
        let node = Node(id: dept.deptId!, name: dept.deptName!)
        nodes.append(node)
        dept.children?.forEach {
            addSubnodes(from: $0!, to: node)
        }
    }

    private func addSubnodes(from dept: DeptModal, to parentNode: Node) {
        let node = Node(id: dept.deptId!, name: dept.deptName!)
        node.parentNode = parentNode
        nodes.append(node)
            dept.children?.forEach {
            addSubnodes(from: $0!, to: node)
        }
    }
}

//MARK: - TreeTableViewDataSource implementationn
extension BSDeptallPopView: TreeTableViewDataSource {
    func configureNodes() -> [Node] {
        sortDatas.forEach {
            addNode(from: $0)
        }
      return nodes
    }
}

//MARK: - TreeTableViewDelegate implementationn
extension BSDeptallPopView: TreeTableViewDelegate {
    func treeTableView(_ treeTableView: TreeTableView, cellForRowAt indexPath: IndexPath, node: Node) -> UITableViewCell {
        let ID : String = "BSDeptallPopCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: ID)
        if cell == nil { cell = BSDeptallPopCell(style: .default, reuseIdentifier: ID) }
        
        (cell as! BSDeptallPopCell).reload(withModal: node, curId: selectDept?.deptId)
//        cell?.textLabel?.text = node.name
//        if node.id == selectDept?.deptId {
//            cell?.imageView?.image = UIImage(systemName: "checkmark.circle.fill")
//            cell?.imageView?.tintColor = .primary
//        } else {
//            cell?.imageView?.image = UIImage(systemName: "circle")
//            cell?.imageView?.tintColor = .hex("#EEEEEE")
//        }
//        let inset = 25 * node.depth
//        cell?.layoutMargins = UIEdgeInsets(top: 0, left: CGFloat(inset), bottom: 0, right: 0)
        return cell!
    }
    
    func treeTableView(_ treeTableView: TreeTableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }

    func treeTableView(_ treeTableView: TreeTableView, didExpandRowAt indexPath: IndexPath, node: Node) {
        treeTableView.deselectRow(at: indexPath, animated: true)
        print("Did expand node '\(node.name)' at indexPath \(indexPath)")
        let depts = datas.filter({ $0?.deptId == node.id })
        selectDept = depts[0]
        treeTableView.reloadData()
    }

    func treeTableView(_ treeTableView: TreeTableView, didCollapseRowAt indexPath: IndexPath, node: Node) {
        treeTableView.deselectRow(at: indexPath, animated: true)
        print("Did collapse node '\(node.name)' at indexPath \(indexPath)")
        let depts = datas.filter({ $0?.deptId == node.id })
        selectDept = depts[0]
        treeTableView.reloadData()
    }

    func treeTableView(_ treeTableView: TreeTableView, didSelectRowAt indexPath: IndexPath, node: Node) {
        treeTableView.deselectRow(at: indexPath, animated: true)
        print("Did select node '\(node.name)' at indexPath \(indexPath)")
        let depts = datas.filter({ $0?.deptId == node.id })
        selectDept = depts[0]
        treeTableView.reloadData()
    }
}

extension BSDeptallPopView: BSDeptallResultViewDelegate {
    func handleDeptSearchDidSelected(_ modal: DeptModal) {
        delegate?.handleSelected(modal)
    }
}
