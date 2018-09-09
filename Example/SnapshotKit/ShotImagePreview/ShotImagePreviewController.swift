//
//  ShotImagePreviewController.swift
//  SnapshotKit_Example
//
//  Created by York on 2018/9/9.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import UIKit

class ShotImagePreviewController: UIViewController {

    private var shotImage: UIImage?

    private let scrollView = UIScrollView()

    required init(shotImage: UIImage?) {
        super.init(nibName: nil, bundle: nil)
        self.shotImage = shotImage
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func initView() {
        self.title = "图片预览"

        self.view.backgroundColor = UIColor.blue

        scrollView.backgroundColor = UIColor.lightGray
        scrollView.frame = CGRect.init(x: 0, y: 100, width: self.view.frame.width, height: self.view.frame.height - 300)
        self.view.addSubview(scrollView)

        let imageView = UIImageView.init(image: shotImage)
        imageView.backgroundColor = UIColor.green
        scrollView.addSubview(imageView)
        scrollView.contentSize = imageView.bounds.size
    }
}
