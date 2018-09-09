//
//  UIScrollView+Snapshot.swift
//  SnapshotKit
//
//  Created by York on 2018/9/9.
//

import UIKit

extension UIScrollView {

    override
    public func takeSnapshotOfVisibleContent() -> UIImage? {
        // 获取当前可视区域的rect
        var visibleRect = self.bounds
        visibleRect.origin = self.contentOffset

        return self.takeSnapshotOfFullContent(for: visibleRect)
    }

    override
    public func takeSnapshotOfFullContent() -> UIImage? {
        let originalFrame = self.frame
        let originalOffset = self.contentOffset

        self.frame = CGRect.init(origin: originalFrame.origin, size: self.contentSize)
        self.contentOffset = .zero

        let backgroundColor = self.backgroundColor ?? UIColor.white

        UIGraphicsBeginImageContextWithOptions(self.bounds.size, true, 0)

        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        context.setFillColor(backgroundColor.cgColor)
        context.setStrokeColor(backgroundColor.cgColor)

        self.drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        self.frame = originalFrame
        self.contentOffset = originalOffset

        return image
    }

    override
    public func takeScreenshotOfFullContent(_ completion: @escaping ((UIImage?) -> Void)) {
        // 分页绘制内容到ImageContext
        let originalOffset = self.contentOffset

        // 当contentSize.height<bounds.height时，保证至少有1页的内容绘制
        var pageNum = 1
        if self.contentSize.height > self.bounds.height {
            pageNum = Int(floorf(Float(self.contentSize.height / self.bounds.height)))
        }

        let backgroundColor = self.backgroundColor ?? UIColor.white

        UIGraphicsBeginImageContextWithOptions(self.contentSize, true, 0)

        guard let context = UIGraphicsGetCurrentContext() else {
            completion(nil)
            return
        }
        context.setFillColor(backgroundColor.cgColor)
        context.setStrokeColor(backgroundColor.cgColor)

        for index in 0...pageNum {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
                if index < pageNum {
                    self.contentOffset = CGPoint.init(x: 0, y: self.bounds.height *  CGFloat(index))
                    let pageFrame = CGRect(x: 0, y: self.frame.size.height *  CGFloat(index), width: self.bounds.size.width, height: self.bounds.size.height)
                    self.drawHierarchy(in: pageFrame, afterScreenUpdates: true)
                } else {
                    let image = UIGraphicsGetImageFromCurrentImageContext()
                    UIGraphicsEndImageContext()
                    self.contentOffset = originalOffset
                    completion(image)
                }
            }
        }
    }

}
