//
//  UIWebViewTesterViewController.swift
//  SnapshotKit_Example
//
//  Created by York on 2018/9/9.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import UIKit
import SnapshotKit
import SVProgressHUD

class UIWebViewTesterViewController: UIViewController {

    private let tableView = UITableView()
    private let cellReuseIdentifier = "CellReuseIdentifier"
    private let configDatas: [String] = [
        "截图可视区域",
        "同步截图全部区域",
        "异步截图全部区域_分页截图方式",
        "异步截图全部区域_打印PDF方式"
    ]

    private let webView = UIWebView()

    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

        let webView_Y: CGFloat = tableView.frame.origin.y +  tableView.frame.size.height + 20
        webView.frame = CGRect.init(x: 0, y: webView_Y, width: self.view.frame.size.width, height: self.view.frame.size.height - webView_Y)
        webView.backgroundColor = UIColor.lightGray
        self.view.addSubview(webView)

        /// 网页内容比较少；此时full-content-image比较小，在预览界面可以加载出来
        let urlStr = "https://www.jianshu.com/u/1e4e723ece8c"
        /// 网页内容比较多；此时full-content-image比较大，在预览界面可能无法加载出来
        //let urlStr = "https://www.jianshu.com/p/d238a844a1e6"

        webView.loadRequest(URLRequest(url: URL(string: urlStr)!))
    }

    private func takeSnapshotOfVisibleContent() {
        let image = self.webView.takeSnapshotOfVisibleContent()
        ShotImagePreviewInterface.previewShotImage(image)
    }

    private func sync_takeSnapshotOfFullContent() {
        let image = self.webView.takeSnapshotOfFullContent()
        ShotImagePreviewInterface.previewShotImage(image)
    }

    private func async_takeSnapshotOfFullContent_bySpliter() {
        SVProgressHUD.show()
        self.webView.scrollView.takeScreenshotOfFullContent { (image) in
            SVProgressHUD.dismiss()
            ShotImagePreviewInterface.previewShotImage(image)
        }
    }

    private func async_takeSnapshotOfFullContent_byPrinter() {
        SVProgressHUD.show()
        self.webView.takeScreenshotOfFullContent { (image) in
            SVProgressHUD.dismiss()
            ShotImagePreviewInterface.previewShotImage(image)
        }
    }

}

// MARK: - UITableViewDataSource & UITableViewDelegate
extension UIWebViewTesterViewController: UITableViewDataSource, UITableViewDelegate {

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
            async_takeSnapshotOfFullContent_bySpliter()
        case 3:
            async_takeSnapshotOfFullContent_byPrinter()
        default:
            break
        }
    }
}
