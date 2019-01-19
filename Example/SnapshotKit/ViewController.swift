//
//  ViewController.swift
//  SnapshotKit
//
//  Created by yorkzhang520 on 09/09/2018.
//  Copyright (c) 2018 yorkzhang520. All rights reserved.
//

import UIKit
import SnapshotKit
import SVProgressHUD

class ViewController: UIViewController {

    private let tableView = UITableView()
    private let cellReuseIdentifier = "CellReuseIdentifier"

    typealias ConfigData = (sectionName: String, cellNames: [String])

    private let configDatas: [ConfigData] = [
        (sectionName: "UIView", cellNames: ["截图可视区域", "同步截图全部区域", "异步截图全部区域", "RoundedView截图测试入口"]),
        (sectionName: "UIWindows", cellNames: ["截图可视区域", "同步截图全部区域", "异步截图全部区域"]),
        (sectionName: "UIScrollView", cellNames: ["截图测试入口"]),
        (sectionName: "UITableView", cellNames: ["截图可视区域", "同步截图全部区域", "异步截图全部区域"]),
        (sectionName: "UIWebView", cellNames: ["截图测试入口"]),
        (sectionName: "WKWebView", cellNames: ["截图测试入口"])
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func initView() {
        self.title = "测试Demo"

        self.view.backgroundColor = UIColor.green

        tableView.frame = CGRect.init(x: 0, y: 100, width: self.view.bounds.width, height: self.view.bounds.height - 100)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        self.view.addSubview(tableView)
    }
}

// MARK: - 截图相关的 Methods
extension ViewController {
    // MARK: UIView 测试方法
    func handleUIViewTestCase(at row: Int) {
        switch row {
        case 0:
            self.uiView_takeSnapshotOfVisibleContent()
        case 1:
            self.uiView_sync_takeSnapshotOfFullContent()
        case 2:
            self.uiView_async_takeSnapshotOfFullContent()
        case 3:
            let vc = RoundedViewTesterViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }

    func uiView_takeSnapshotOfVisibleContent() {
        let image = self.view.takeSnapshotOfVisibleContent()
        ShotImagePreviewInterface.previewShotImage(image)
    }

    func uiView_sync_takeSnapshotOfFullContent() {
        let image = self.view.takeSnapshotOfFullContent()
        ShotImagePreviewInterface.previewShotImage(image)
    }

    func uiView_async_takeSnapshotOfFullContent() {
        SVProgressHUD.show()
        self.view.asyncTakeSnapshotOfFullContent { (image) in
            SVProgressHUD.dismiss()
            ShotImagePreviewInterface.previewShotImage(image)
        }
    }

    // MARK: UIWindow 测试方法
    func handleUIWindowTestCase(at row: Int) {
        switch row {
        case 0:
            self.uiWindow_takeSnapshotOfVisibleContent()
        case 1:
            self.uiWindow_sync_takeSnapshotOfFullContent()
        case 2:
            self.uiWindow_async_takeSnapshotOfFullContent()
        default:
            break
        }
    }

    func uiWindow_takeSnapshotOfVisibleContent() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate,
            let curWindow = appDelegate.window else {
            return
        }

        let image = curWindow.takeSnapshotOfVisibleContent()
        ShotImagePreviewInterface.previewShotImage(image)
    }

    func uiWindow_sync_takeSnapshotOfFullContent() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate,
            let curWindow = appDelegate.window else {
                return
        }

        let image = curWindow.takeSnapshotOfFullContent()
        ShotImagePreviewInterface.previewShotImage(image)
    }

    func uiWindow_async_takeSnapshotOfFullContent() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate,
            let curWindow = appDelegate.window else {
                return
        }

        SVProgressHUD.show()
        curWindow.asyncTakeSnapshotOfFullContent { (image) in
            SVProgressHUD.dismiss()
            ShotImagePreviewInterface.previewShotImage(image)
        }
    }

    // MARK: UIScrollView 测试方法
    func handleUIScrollViewTestCase(at row: Int) {
        let vc = UIScrollViewTesterViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }

    // MARK: UITableView 测试方法
    func handleUITableViewTestCase(at row: Int) {
        switch row {
        case 0:
            self.uiTableView_takeSnapshotOfVisibleContent()
        case 1:
            self.uiTableView_sync_takeSnapshotOfFullContent()
        case 2:
            self.uiTableView_async_takeSnapshotOfFullContent()
        default:
            break
        }
    }

    func uiTableView_takeSnapshotOfVisibleContent() {
        let image = self.tableView.takeSnapshotOfVisibleContent()
        ShotImagePreviewInterface.previewShotImage(image)
    }

    func uiTableView_sync_takeSnapshotOfFullContent() {
        let image = self.tableView.takeSnapshotOfFullContent()
        ShotImagePreviewInterface.previewShotImage(image)
    }

    func uiTableView_async_takeSnapshotOfFullContent() {
        SVProgressHUD.show()
        self.tableView.asyncTakeSnapshotOfFullContent { (image) in
            SVProgressHUD.dismiss()
            ShotImagePreviewInterface.previewShotImage(image)
        }
    }

    // MARK: UIWebView 测试方法
    func handleUIWebViewTestCase(at row: Int) {
        let vc = UIWebViewTesterViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }

    // MARK: WKWebView 测试方法
    func handleWKWebViewTestCase(at row: Int) {
        let vc = WKWebViewTesterViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - UITableViewDataSource & UITableViewDelegate
extension ViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return configDatas.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let num = configDatas[section].cellNames.count

        return num
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)

        let section = indexPath.section
        let row = indexPath.row
        let cellNames = configDatas[section].cellNames
        cell.textLabel?.text = "\(configDatas[section].sectionName)-\(cellNames[row])"

        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UILabel()
        headerView.backgroundColor = UIColor.lightGray
        headerView.textColor = UIColor.blue
        headerView.text = "  \(configDatas[section].sectionName) 测试"
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = indexPath.section
        let row = indexPath.row

        switch section {
        case 0:
            self.handleUIViewTestCase(at: row)
        case 1:
            self.handleUIWindowTestCase(at: row)
        case 2:
            self.handleUIScrollViewTestCase(at: row)
        case 3:
            self.handleUITableViewTestCase(at: row)
        case 4:
            self.handleUIWebViewTestCase(at: row)
        case 5:
            self.handleWKWebViewTestCase(at: row)
        default:
            break
        }
    }
}


