# SnapshotKit

[![Version](https://img.shields.io/cocoapods/v/SnapshotKit.svg?style=flat)](https://cocoapods.org/pods/SnapshotKit)
[![License](https://img.shields.io/cocoapods/l/SnapshotKit.svg?style=flat)](https://cocoapods.org/pods/SnapshotKit)
[![Platform](https://img.shields.io/cocoapods/p/SnapshotKit.svg?style=flat)](https://cocoapods.org/pods/SnapshotKit)

A Kit that can make UIView/UIWindow/UIScrollView/UITableView/UIWebView/WKWebView to easily take snapshot image of visible or full content.

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

### UIView Example
```swift
func uiView_takeSnapshotOfVisibleContent() {
    let image = self.view.takeSnapshotOfVisibleContent()
    // edit image 
}

func uiView_sync_takeSnapshotOfFullContent() {
    let image = self.view.takeSnapshotOfFullContent()
    // edit image 
}

func uiView_async_takeSnapshotOfFullContent() {
    self.view.asyncTakeSnapshotOfFullContent { (image) in
      // edit image 
    }
}
```

### UIScrollView Example
```swift
private func takeSnapshotOfVisibleContent() {
    let image = self.scrollView.takeSnapshotOfVisibleContent()
    // edit image
}

private func sync_takeSnapshotOfFullContent() {
    let image = self.scrollView.takeSnapshotOfFullContent()
    // edit image
}

private func async_takeSnapshotOfFullContent() {
    self.scrollView.asyncTakeSnapshotOfFullContent { (image) in
      // edit image
    }
}
```

### UITableView Example
```swift
func uiTableView_takeSnapshotOfVisibleContent() {
    let image = self.tableView.takeSnapshotOfVisibleContent()
    // edit image
}

func uiTableView_sync_takeSnapshotOfFullContent() {
    let image = self.tableView.takeSnapshotOfFullContent()
    // edit image
}

func uiTableView_async_takeSnapshotOfFullContent() {
    self.tableView.asyncTakeSnapshotOfFullContent { (image) in
      // edit image
    }
}
```

### WKWebView Example
```swift
private func takeSnapshotOfVisibleContent() {
    let image = self.webView.takeSnapshotOfVisibleContent()
    // edit image
}

private func sync_takeSnapshotOfFullContent() {
    let image = self.webView.takeSnapshotOfFullContent()
    // edit image
}

private func async_takeSnapshotOfFullContent_bySpliter() {
    self.webView.scrollView.asyncTakeSnapshotOfFullContent { (image) in
      // edit image
    }
}

private func async_takeSnapshotOfFullContent_byPrinter() {
    self.webView.asyncTakeSnapshotOfFullContent { (image) in
      // edit image
    }
}
```


## Installation

SnapshotKit is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'SnapshotKit'
```

## License

SnapshotKit is available under the MIT license. See the LICENSE file for more info.
