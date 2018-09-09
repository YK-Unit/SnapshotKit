//
//  ShotImagePreviewInterface.swift
//  SnapshotKit_Example
//
//  Created by York on 2018/9/9.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import UIKit

final class ShotImagePreviewInterface {

    /// 进入图片预览模块
    ///
    /// - Important: 若图片太大，将会无法加载出来
    ///
    /// - Parameters:
    ///   - image: 要预览的图片
    ///   - navigationController: <#navigationController description#>
    class func previewShotImage(_ image: UIImage?, navigationController: UINavigationController? = nil) {

        let vc = ShotImagePreviewController.init(shotImage: image)
        if let nav = navigationController {
            nav.pushViewController(vc, animated: true)
        } else if let appDelegate = UIApplication.shared.delegate as? AppDelegate, let rootNav = appDelegate.window?.rootViewController as? UINavigationController {
            rootNav.pushViewController(vc, animated: true)
        }
    }
}
