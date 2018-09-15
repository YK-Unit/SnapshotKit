//
//  WKWebView+Snapshot.swift
//  SnapshotKit
//
//  Created by York on 2018/9/9.
//

import UIKit
import WebKit

extension WKWebView {
    override
    public func takeSnapshotOfVisibleContent() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, true, 0)

        self.drawHierarchy(in: self.bounds, afterScreenUpdates: true)

        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return image
    }

    override
    public func takeSnapshotOfFullContent() -> UIImage? {
        let renderer = WebViewPrintPageRenderer.init(formatter: self.viewPrintFormatter(), contentSize: self.scrollView.contentSize)
        let image = renderer.printContentToImage()
        return image
    }

    override
    public func takeScreenshotOfFullContent(_ completion: @escaping ((UIImage?) -> Void)) {
        self.scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
            let image = self.takeSnapshotOfFullContent()
            completion(image)
        }
    }
}
