//
//  UITableView+Snapshot.swift
//  SnapshotKit
//
//  Created by York on 2018/9/9.
//

import UIKit

extension UITableView {
    private func takeSnapshotOfTableHeaderView() -> UIImage? {
        if let rect = self.tableHeaderView?.frame, rect.width > 0 && rect.height > 0 {
            self.scrollRectToVisible(rect, animated: false)
            let image = self.takeSnapshotOfFullContent(for: rect)
            return image
        }
        return nil
    }

    private func takeSnapshotOfTableFooterView() -> UIImage? {
        if let rect = self.tableFooterView?.frame, rect.width > 0 && rect.height > 0 {
            self.scrollRectToVisible(rect, animated: false)
            let image = self.takeSnapshotOfFullContent(for: rect)
            return image
        }
        return nil
    }

    private func takeSnapshotOfSectionHeaderView(at section: Int) -> UIImage? {
        let rect = self.rectForHeader(inSection: section)
        if rect.width > 0 && rect.height > 0 {
            self.scrollRectToVisible(rect, animated: false)
            let image = self.takeSnapshotOfFullContent(for: rect)
            return image
        }
        return nil
    }

    private func takeSnapshotOfSectionFooterView(at section: Int) -> UIImage? {
        let rect = self.rectForFooter(inSection: section)
        if  rect.width > 0 && rect.height > 0 {
            self.scrollRectToVisible(rect, animated: false)
            let image = self.takeSnapshotOfFullContent(for: rect)
            return image
        }
        return nil
    }

    private func takeSnapshotOfCell(at indexPath: IndexPath) -> UIImage? {
        if self.indexPathsForVisibleRows?.contains(indexPath) == false {
            self.scrollToRow(at: indexPath, at: .top, animated: false)
        }
        let cell = self.cellForRow(at: indexPath)
        let image = cell?.takeSnapshotOfFullContent()
        return image
    }

    private func internalTakeSnapshotOfFullContent()-> UIImage? {
        var shotImages: [UIImage] = []

        if let image = takeSnapshotOfTableHeaderView() {
            shotImages.append(image)
        }

        for section in (0..<self.numberOfSections) {
            if let image = takeSnapshotOfSectionHeaderView(at: section) {
                shotImages.append(image)
            }

            let num = self.numberOfRows(inSection: section)
            for row in (0..<num) {
                let indexPath = IndexPath.init(row: row, section: section)
                if let image = takeSnapshotOfCell(at: indexPath) {
                    shotImages.append(image)
                }
            }

            if let image = takeSnapshotOfSectionFooterView(at: section) {
                shotImages.append(image)
            }
        }

        if let image = takeSnapshotOfTableFooterView() {
            shotImages.append(image)
        }

        guard shotImages.count > 0 else {
            return nil
        }

        // 合成图片：计算总大小，然后拼接图片
        var totalSize = CGSize.init(width: self.bounds.width, height: 0)
        for image in shotImages {
            totalSize.height += image.size.height
        }

        let backgroundColor = self.backgroundColor ?? UIColor.white
        var resultImage: UIImage? = nil

        UIGraphicsBeginImageContextWithOptions(totalSize,true, 0)

        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        context.setFillColor(backgroundColor.cgColor)
        context.setStrokeColor(backgroundColor.cgColor)

        var imageOffsetFactor: CGFloat = 0
        for image in shotImages {
            image.draw(at: CGPoint(x: 0, y: imageOffsetFactor))
            imageOffsetFactor += image.size.height
        }
        resultImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return resultImage
    }

    override
    public func takeSnapshotOfVisibleContent() -> UIImage? {
        // 获取当前可视区域的rect
        var visibleRect = self.bounds
        visibleRect.origin = self.contentOffset

        return self.takeSnapshotOfFullContent(for: visibleRect)
    }

    override
    public func takeSnapshotOfFullContent() -> UIImage? {
        let originalOffset = self.contentOffset
        let image = self.internalTakeSnapshotOfFullContent()
        self.setContentOffset(originalOffset, animated: false)
        return image
    }

    override
    public func asyncTakeSnapshotOfFullContent(_ completion: @escaping ((UIImage?) -> Void)) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
            let image = self.takeSnapshotOfFullContent()
            completion(image)
        }
    }
}
