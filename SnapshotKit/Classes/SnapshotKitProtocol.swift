//
//  SnapshotKitProtocol.swift
//  SnapshotKit
//
//  Created by York on 2018/9/9.
//

import Foundation
import UIKit

public protocol SnapshotKitProtocol {

    /// Synchronously take a snapshot of the view's visible content
    ///
    /// - Returns: UIImage?
    func takeSnapshotOfVisibleContent() -> UIImage?


    /// Synchronously take a snapshot of the view's full content
    ///
    /// - Important: when the size of the view's full content is small, use this method to take snapshot
    /// - Returns: UIImage?
    func takeSnapshotOfFullContent() -> UIImage?

    /// Asynchronously take a snapshot of the view's full content
    ///
    /// - Important: when the size of the view's full content is large, use this method to take snapshot
    /// - Parameter completion: <#completion description#>
    func asyncTakeSnapshotOfFullContent(_ completion: @escaping ((_ image: UIImage?) -> Void))
}
