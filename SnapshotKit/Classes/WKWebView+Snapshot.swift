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
    public func asyncTakeSnapshotOfFullContent(_ completion: @escaping ((UIImage?) -> Void)) {
        let originalOffset = self.scrollView.contentOffset

        // 当contentSize.height<bounds.height时，保证至少有1页的内容绘制
        var pageNum = 1
        if self.scrollView.contentSize.height > self.scrollView.bounds.height {
            pageNum = Int(floorf(Float(self.scrollView.contentSize.height / self.scrollView.bounds.height)))
        }

        self.loadPageContent(0, maxIndex: pageNum, completion: {
            self.scrollView.contentOffset = CGPoint.zero
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                let renderer = WebViewPrintPageRenderer.init(formatter: self.viewPrintFormatter(), contentSize: self.scrollView.contentSize)
                let image = renderer.printContentToImage()
                self.scrollView.contentOffset = originalOffset
                completion(image)
            }
        })
    }

    fileprivate func loadPageContent(_ index: Int, maxIndex: Int, completion: @escaping () -> Void) {
        self.scrollView.setContentOffset(CGPoint(x: 0, y: CGFloat(index) * self.scrollView.frame.size.height), animated: false)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            if index < maxIndex {
                self.loadPageContent(index + 1, maxIndex: maxIndex, completion: completion)
            }else{
                completion()
            }
        }
    }
}
