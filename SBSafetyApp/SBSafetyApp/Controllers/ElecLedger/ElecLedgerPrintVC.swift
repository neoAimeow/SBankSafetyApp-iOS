//
//  ElecLedgerPrintVC.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/24.
//

import Foundation
import UIKit

class ElecPrintModal: NSObject {
    var date: String = ""
    var num: Int = 0
    var isSelected: Bool = false
    
    init(date: String, num: Int, isSelected: Bool) {
        self.date = date
        self.num = num
        self.isSelected = isSelected
    }
}

class ElecLedgerPrintVC: SubLevelViewController {
    let headerV = BSSearchButton(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 60))
    let bottomV = ElecPrintBottomView()
    let tableView = UITableView(frame: .zero, style: .plain)
    
    var isCheck: Bool = false

    var datas: [ElecPrintModal] = [
        ElecPrintModal(date: "2022年09月23日", num: 15, isSelected: false),
        ElecPrintModal(date: "2022年09月24日", num: 18, isSelected: false),
        ElecPrintModal(date: "2022年09月25日", num: 22, isSelected: false),
        ElecPrintModal(date: "2022年09月26日", num: 11, isSelected: false),
        ElecPrintModal(date: "2022年09月27日", num: 15, isSelected: false),
        ElecPrintModal(date: "2022年09月28日", num: 8, isSelected: false),
        ElecPrintModal(date: "2022年09月29日", num: 22, isSelected: false),
        ElecPrintModal(date: "2022年09月30日", num: 11, isSelected: false),
        ElecPrintModal(date: "2022年10月01日", num: 18, isSelected: false),
        ElecPrintModal(date: "2022年10月02日", num: 2, isSelected: false),
        ElecPrintModal(date: "2022年10月03日", num: 11, isSelected: false),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "打印"
        view.backgroundColor = .white
        navigationController?.navBarStyle(.white)
        setupUI()
    }
    
    @objc func checkTapped() {
        isCheck = !isCheck
        if isCheck {
            for data in datas {
                data.isSelected = true
            }
        } else {
            for data in datas {
                data.isSelected = false
            }
        }
        updateUI()
    }
    
    @objc func printTapped() {
        
    }
    
    func updateUI() {
        var isSelected = true
        isCheck = true
        for data in datas {
            if data.isSelected == false {
                isSelected = false
                isCheck = false
            }
        }
        
        if isSelected == false {
            bottomV.checkBtn.setTitle("全选", for: .normal)
        } else {
            bottomV.checkBtn.setTitle("全不选", for: .normal)
        }
       
        tableView.reloadData()
    }
    
    func setupUI() {
        bottomV.checkBtn.addTarget(self, action: #selector(checkTapped), for: .touchUpInside)
        bottomV.printBtn.addTarget(self, action: #selector(printTapped), for: .touchUpInside)
        bottomV.backgroundColor = .white
        view.addSubview(bottomV)
        bottomV.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(70 + UIDevice.safeBottom())
        }
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .white
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(bottomV.snp.top)
        }
        
        tableView.tableHeaderView = headerV
    }
}

extension ElecLedgerPrintVC: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = datas[indexPath.row]
        let ID : String = "ElecPrintCell"
            
        var cell = tableView.dequeueReusableCell(withIdentifier: ID)
        if cell == nil {
            cell = ElecPrintCell(style: .subtitle, reuseIdentifier: ID)
        }
        
        (cell as? ElecPrintCell)?.reload(withModal: data)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let modal = datas[indexPath.row]
        modal.isSelected = !modal.isSelected
        updateUI()
    }
}

class ElecPrintBottomView: UIView {
    let checkBtn = UIButton.createPrimaryBorderLarge("全选")
    let printBtn = UIButton.createPrimaryLarge("打印")

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        addSubview(checkBtn)
        checkBtn.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(10)
            make.left.equalTo(self.snp.left).offset(10)
            make.height.equalTo(50)
            make.width.equalTo(105)
        }
        
        addSubview(printBtn)
        printBtn.snp.makeConstraints { make in
            make.top.equalTo(checkBtn.snp.top)
            make.left.equalTo(checkBtn.snp.right).offset(10)
            make.right.equalTo(self.snp.right).offset(-10)
            make.height.equalTo(50)
        }
    }
}
