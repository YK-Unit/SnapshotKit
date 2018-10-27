//
//  UIViewTesterViewController.swift
//  SnapshotKit_Example
//
//  Created by York on 2018/10/27.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import SnapshotKit

class RoundedViewTesterViewController: UIViewController {

    private let tableView = UITableView()
    private let cellReuseIdentifier = "CellReuseIdentifier"
    private let configDatas: [String] = [
        "截图可视区域",
        "同步截图全部区域",
        "异步截图全部区域"
    ]

    let roundedView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
    }

    private func initView() {
        self.title = "UIWebView 测试"

        self.view.backgroundColor = UIColor.white

        let tableViewHeight: CGFloat = CGFloat(configDatas.count * 30)
        tableView.frame = CGRect.init(x: 0, y: 100, width: self.view.bounds.width, height: tableViewHeight)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        self.view.addSubview(tableView)

        let roundedView_W: CGFloat = 200
        let roundedView_H: CGFloat = 200
        let roundedView_X = (self.view.frame.width - 200)/2
        let roundedView_Y: CGFloat = tableView.frame.origin.y +  tableView.frame.size.height + 20
        roundedView.frame = CGRect.init(x: roundedView_X, y: roundedView_Y, width: roundedView_W, height: roundedView_H)
        roundedView.backgroundColor = UIColor.orange
        self.view.addSubview(roundedView)

        roundedView.backgroundColor = UIColor.orange
        roundedView.layer.cornerRadius = 30
        roundedView.layer.borderWidth = 1.0
        roundedView.layer.borderColor = UIColor.red.cgColor
//        roundedView.layer.masksToBounds = true
    }

    private func takeSnapshotOfVisibleContent() {
        let image = self.roundedView.takeSnapshotOfVisibleContent()
        ShotImagePreviewInterface.previewShotImage(image)
    }

    private func sync_takeSnapshotOfFullContent() {
        let image = self.roundedView.takeSnapshotOfFullContent()
        ShotImagePreviewInterface.previewShotImage(image)
    }

    private func async_takeSnapshotOfFullContent() {

    }

}

// MARK: - UITableViewDataSource & UITableViewDelegate
extension RoundedViewTesterViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let num = configDatas.count

        return num
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)

        let row = indexPath.row
        let cellName = configDatas[row]
        cell.textLabel?.text = cellName

        return cell
    }


    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row

        switch row {
        case 0:
            takeSnapshotOfVisibleContent()
        case 1:
            sync_takeSnapshotOfFullContent()
        case 2:
            async_takeSnapshotOfFullContent()
        default:
            break
        }
    }
}
