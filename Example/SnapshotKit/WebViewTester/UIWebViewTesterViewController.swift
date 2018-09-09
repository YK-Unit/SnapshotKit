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

        let items = ["截图可视区域", "同步截图全部区域", "异步截图全部区域"]
        let segmentedControl = UISegmentedControl.init(items: items)
        segmentedControl.isMomentary = true
        segmentedControl.addTarget(self, action: #selector(onSegmentValueChange(_:)), for: .valueChanged)
        segmentedControl.frame = CGRect.init(x: 5, y: 100, width: self.view.bounds.width - 10, height: 40)
        self.view.addSubview(segmentedControl)

        webView.frame = CGRect.init(x: 0, y: 200, width: self.view.frame.size.width, height: self.view.frame.size.height - 200)
        webView.backgroundColor = UIColor.lightGray
        self.view.addSubview(webView)

        /// 网页内容比较少；此时full-content-image比较小，在预览界面可以加载出来
        let urlStr = "https://www.jianshu.com/u/1e4e723ece8c"
        /// 网页内容比较多；此时full-content-image比较大，在预览界面可能无法加载出来
        //let urlStr = "https://www.jianshu.com/p/d238a844a1e6"

        webView.loadRequest(URLRequest(url: URL(string: urlStr)!))
    }

    @objc
    private func onSegmentValueChange(_ segmentedControl: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
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

    private func takeSnapshotOfVisibleContent() {
        let image = self.webView.takeSnapshotOfVisibleContent()
        ShotImagePreviewInterface.previewShotImage(image)
    }

    private func sync_takeSnapshotOfFullContent() {
        let image = self.webView.takeSnapshotOfFullContent()
        ShotImagePreviewInterface.previewShotImage(image)
    }

    private func async_takeSnapshotOfFullContent() {
        SVProgressHUD.show()
        self.webView.takeScreenshotOfFullContent { (image) in
            SVProgressHUD.dismiss()
            ShotImagePreviewInterface.previewShotImage(image)
        }
    }
}
