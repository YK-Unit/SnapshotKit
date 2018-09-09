//
//  UIWebView+Snapshot.swift
//  SnapshotKit
//
//  Created by York on 2018/9/9.
//

import UIKit

extension UIWebView {
    override
    public func takeSnapshotOfVisibleContent() -> UIImage? {
        return self.scrollView.takeSnapshotOfVisibleContent()
    }

    override
    public func takeSnapshotOfFullContent() -> UIImage? {
        return self.scrollView.takeSnapshotOfFullContent()
    }

    override
    public func takeScreenshotOfFullContent(_ completion: @escaping ((UIImage?) -> Void)) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
            let renderer = WebViewPrintPageRenderer.init(formatter: self.viewPrintFormatter(), contentSize: self.scrollView.contentSize)
            let image = renderer.printContentIntoImage()
            completion(image)
        }
    }
}
