//
// Created by Aimeow on 2022/12/12.
//

import Foundation
import UIKit

protocol AppointmentManagerTaskViewDelegate: AnyObject {
    func segment(_ segment: ScrollableSegmentedControl, didSelectSegmentAtIndex index: Int) -> Void;
}

class AppointmentManagerTaskView: UIView {
    weak var delegate: AppointmentManagerTaskViewDelegate?

    lazy var segmentedControl: ScrollableSegmentedControl = {
        let segmented = ScrollableSegmentedControl()
        segmented.tintColor = .primary
        segmented.underlineSelected = true
        segmented.addTarget(self, action: #selector(segmentSelected(sender:)), for: .valueChanged)
        segmented.segmentContentColor = .black
        segmented.selectedSegmentContentColor = .primary

        let normalAttrs = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)]
        let highlightAttrs = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17)]
        let selectAttrs = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17)]
        segmented.setTitleTextAttributes(normalAttrs, for: .normal)
        segmented.setTitleTextAttributes(highlightAttrs, for: .highlighted)
        segmented.setTitleTextAttributes(selectAttrs, for: .selected)

        segmented.insertSegment(withTitle: "今日", at: 0)
        segmented.insertSegment(withTitle: "本月", at: 1)
        segmented.insertSegment(withTitle: "本季", at: 2)
        segmented.insertSegment(withTitle: "本年", at: 3)
        segmented.selectedSegmentIndex = 0

        return segmented
    }()

    lazy var listView: SimpleListView = {
        let view = SimpleListView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 7
        view.backgroundColor = UIColor.white
        view.delegate = self

        return view
    }()


    @objc func segmentSelected(sender: ScrollableSegmentedControl) {
        print("segmentSelected", sender.selectedSegmentIndex)
        segmentedControl.selectedSegmentIndex = sender.selectedSegmentIndex
        delegate?.segment(segmentedControl, didSelectSegmentAtIndex: sender.selectedSegmentIndex)
    }

    var taskListModels: [TaskCompleteModel] = []


    init() {
        super.init(frame: .zero)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func buildModels(models: [TaskCompleteModel]) -> Void {
        taskListModels = models
        print(models)
        listView.reloadData()
    }

    func setupUI() {

        addSubview(segmentedControl)
        addSubview(listView)

        listView.reloadData()

        segmentedControl.snp.makeConstraints { make in
            make.top.left.right.equalTo(self)
            make.height.equalTo(38)
        }

        listView.snp.updateConstraints { make in
            make.left.right.equalTo(self)
            make.top.equalTo(segmentedControl.snp.bottom)
            make.bottom.equalTo(self)
        }
    }
}

extension AppointmentManagerTaskView: SimpleListViewDelegate {
    func numberOfListCell() -> Int {
        print(taskListModels.count)
        return taskListModels.count
    }

    func listView(_ listView: SimpleListView, cellAt index: Int) -> UIView {
        let cell = TaskListCellView()
        cell.buildModels(data: taskListModels[index])
        return cell
    }

    func listView(_ listView: SimpleListView, didSelectAt index: Int) {
        let data = taskListModels[index]

        print(data)
        let vc = SafeCheckTaskVC()
        vc.id = data.id
        getFirstViewController()?.navigationController?.pushViewController(vc, animated: true)

    }

    func heightOfCell() -> Double {
        64.5
    }


}
