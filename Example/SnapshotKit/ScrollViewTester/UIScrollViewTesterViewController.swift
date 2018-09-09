//
//  UIScrollViewTesterViewController.swift
//  SnapshotKit_Example
//
//  Created by York on 2018/9/9.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import UIKit
import SnapshotKit
import SVProgressHUD

class UIScrollViewTesterViewController: UIViewController {

    let scrollView = UIScrollView()

    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func initView() {
        self.title = "UIScrollView 测试"

        self.view.backgroundColor = UIColor.white

        let items = ["截图可视区域", "同步截图全部区域", "异步截图全部区域"]
        let segmentedControl = UISegmentedControl.init(items: items)
        segmentedControl.isMomentary = true
        segmentedControl.addTarget(self, action: #selector(onSegmentValueChange(_:)), for: .valueChanged)
        segmentedControl.frame = CGRect.init(x: 5, y: 100, width: self.view.bounds.width - 10, height: 40)
        self.view.addSubview(segmentedControl)

        scrollView.frame = CGRect.init(x: 0, y: 200, width: self.view.frame.size.width, height: self.view.frame.size.height - 400)
        scrollView.backgroundColor = UIColor.lightGray
        self.view.addSubview(scrollView)
        initScrollView()
    }

    private func initScrollView() {
        let textLabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: self.scrollView.bounds.width, height: 100))
        textLabel.numberOfLines = 0
        textLabel.textColor = UIColor.blue
        textLabel.font = UIFont.systemFont(ofSize: 16)
        self.scrollView.addSubview(textLabel)

        do {
            let path = Bundle.main.path(forResource:"xiao_yao_you", ofType:"txt")
            let text = try String(contentsOfFile:path!, encoding: String.Encoding.utf8)
            textLabel.text = text
        } catch let error {
            textLabel.text = "\(error.localizedDescription)"
        }
        textLabel.sizeToFit()

        self.scrollView.contentSize = textLabel.bounds.size
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
        let image = self.scrollView.takeSnapshotOfVisibleContent()
        ShotImagePreviewInterface.previewShotImage(image)
    }

    private func sync_takeSnapshotOfFullContent() {
        let image = self.scrollView.takeSnapshotOfFullContent()
        ShotImagePreviewInterface.previewShotImage(image)
    }

    private func async_takeSnapshotOfFullContent() {
        SVProgressHUD.show()
        self.scrollView.takeScreenshotOfFullContent { (image) in
            SVProgressHUD.dismiss()
            ShotImagePreviewInterface.previewShotImage(image)
        }
    }
}
