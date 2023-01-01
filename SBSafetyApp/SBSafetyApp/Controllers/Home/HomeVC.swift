//
//  HomeVC.swift
//  SBSafetyApp
//
//  Created by Lina on 2022/11/14.
//
//  【首页】首页

import Foundation
import UIKit

class HomeVC: TopViewController {
    let wV = WeatherView()
    let homeV = HomeView()

    var date: Date = Date().yesterday()
    var deptId: Int64 = -1
    var deptName: String? = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .bg
        setupNavItems()
        setupUI()

        getWeather()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        parent?.tabBarController?.tabBar.changeTabBar(hidden: false, animated: true)
        navigationController?.navBarStyle(.clear)
        reloadData()
    }

    func reloadData() {
        API.getInfo { responseModel in
            BSUser.currentUser.modifyUser(withModal: responseModel.model?.user)
            if self.deptId == -1 {
                self.deptId = BSUser.currentUser.deptId
                self.deptName = BSUser.currentUser.deptName
            }
            self.homeV.situationV.deptallBtn.deptName = self.deptName
        }

        getStastic()
    }

    func getWeather() {
        let common = BSCommon.today
        if common == nil {
            WeatherManager.shared.getWeatherJSON { responseModel in
                if responseModel?[0] != nil {
                    let today = BSCommon.insetToday(withLive: (responseModel?[0])!)
                    DispatchQueue.main.async {
                        self.wV.update(withLive: today)
                    }
                }
            }
        } else {
            self.wV.update(withLive: common!)
        }
    }

    func getStastic() {
        if deptId == -1 {
            deptId = BSUser.currentUser.deptId
            deptName = BSUser.currentUser.deptName
            homeV.situationV.deptallBtn.deptName = deptName
        }
        /// 报警、撤布妨统计
        API.getHomeStastic(withParam: HomeParam(deptId: deptId, dateType: 0)) { responseModel in
            DispatchQueue.main.async {
                self.homeV.todayV.reloadData(withModal: responseModel.model)
            }
        }

        /// 全行态势
        API.getHomeStateall(withParam: HomeParam(deptId: deptId, date: date.elTodayDate())) { responseModel in
            DispatchQueue.main.async {
                self.homeV.situationV.reloadData(withModal: responseModel.model)
            }
        }
    }

    @objc func dailyBriefTapped() {

    } // 每日简报

    @objc func orderTapped() {
        navigationController?.pushViewController(OrderFeedbackVC(), animated: true)
    } // 工单及反馈

    @objc func notiTapped() {
        navigationController?.pushViewController(NotificationVC(), animated: true)
    } // 通知

    @objc func collectTapped() {

    } // 我的收藏

    // MARK: - Setup

    func setupUI() {
        homeV.hDelegate = self
        homeV.situationV.dateSegV.date = date
        homeV.situationV.dateSegV.didSelectDateWith = { (date) -> () in
            self.date = date
            self.getStastic()
        }
        homeV.situationV.deptallBtn.delegate = self
//        homeV.briefV.addTarget(self, action: #selector(dailyBriefTapped), for: .touchUpInside)
//        homeV.orderV.addTarget(self, action: #selector(orderTapped), for: .touchUpInside)
//        homeV.notiV.addTarget(self, action: #selector(notiTapped), for: .touchUpInside)
//        homeV.collectV.addTarget(self, action: #selector(collectTapped), for: .touchUpInside)
        homeV.todayV.repairV.addTarget(self, action: #selector(repairTapped), for: .touchUpInside)
        view.addSubview(homeV)
        homeV.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-50)
            make.left.right.equalToSuperview()
        }

        homeV.contentSize = CGSize(width: ScreenWidth, height: 1320)
    }

    func setupNavItems() {
        let logoIV = UIImageView(image: UIImage(named: "home_logo"))
        let logoBar = UIBarButtonItem(customView: logoIV)
        navigationItem.leftBarButtonItems = [logoBar]

        let wBar = UIBarButtonItem(customView: wV)
        navigationItem.rightBarButtonItems = [wBar]
    }
}

extension HomeVC: HomeViewDelegate {
    func handleTypeSelected(_ type: IFType) {
        switch type {
        case .IFAlarm: alarmTapped(); break
        case .IFDuty: dutyTapped(); break
        case .IFRepair: repairTapped(); break
        case .IFWisdomInsider: wisdomInsiderTapped(); break
        case .IFSmartSecurity: smartSecurityTapped(); break
        case .IFSupervision: supervisionTapped(); break
        case .IFMaintenance: maintenanceTapped(); break
        case .IFElecLedger: elecLedgerTapped(); break
        }
    }

    func alarmTapped() {
        navigationController?.pushViewController(ViewController(), animated: true)
    } // 报警处置

    func dutyTapped() {
        navigationController?.pushViewController(AppointmentManagerHomeVC(), animated: true)
//        let vc = AppointmentManagerVC(withDeptId: self.deptId, deptName: deptName)
//        let vc = WeekBizDateEditVC(withDeptId: deptId, deptName: deptName)
//        let vc  = UpdateBusinessDateVC()
        
//        navigationController?.pushViewController(vc, animated: true)
    } // 履职管理

    @objc func repairTapped() {
        let role = UserDefaults.standard.string(forKey: SafetyUserRole)
        if (role == UserRole.HeadOffice.rawValue || role == UserRole.BranchOffice.rawValue || role == UserRole.SubBranchOffice.rawValue) {
            navigationController?.pushViewController(RepairStatisticsVC(), animated: true)
        } else if (role == UserRole.Lattice.rawValue) {
            navigationController?.pushViewController(RepairHomeVC(), animated: true)
        } else {
        }
    } // 一键维修

    func wisdomInsiderTapped() {
        navigationController?.pushViewController(ViewController(), animated: true)
    } // 安全评估

    func smartSecurityTapped() {
//                self.navigationController?.pushViewController(TaskFinishStateVC(), animated: true)
        self.navigationController?.pushViewController(SecurityHomeVC(), animated: true)
//        self.navigationController?.pushViewController(UpdateBusinessDateVC(), animated: true)
//        self.navigationController?.pushViewController(CheckInSuccessVC(), animated: true)
//        self.navigationController?.pushViewController(CheckInFailedVC(), animated: true)
    } // 保安管理

    func supervisionTapped() {
        self.navigationController?.pushViewController(SuperviseHomeVC(), animated: true)
    } // 检查监督

    func maintenanceTapped() {
        let role = UserDefaults.standard.string(forKey: SafetyUserRole)
        if (role == UserRole.HeadOffice.rawValue || role == UserRole.BranchOffice.rawValue || role == UserRole.SubBranchOffice.rawValue) {
            navigationController?.pushViewController(InspServiceStatisticsVC(), animated: true)
        } else if (role == UserRole.Lattice.rawValue) {
            navigationController?.pushViewController(InspHomeVC(), animated: true)
        } else {
        }
    } // 维保服务

    func elecLedgerTapped() {
        let role = UserDefaults.standard.string(forKey: SafetyUserRole)
        if (role == UserRole.HeadOffice.rawValue || role == UserRole.BranchOffice.rawValue || role == UserRole.SubBranchOffice.rawValue) {
            navigationController?.pushViewController(ElecLedgerStatisticsVC(), animated: true)
        } else if (role == UserRole.Lattice.rawValue) {
            navigationController?.pushViewController(ElecLedgerHomeVC(), animated: true)
        } else {
        }
    } // 台账管理
}

extension HomeVC: BSDeptallControlDelegate {
    func handleSelected(_ dept: DeptModal?) {
        deptId = Int64(dept?.deptId ?? -1)
        getStastic()
    }
}
