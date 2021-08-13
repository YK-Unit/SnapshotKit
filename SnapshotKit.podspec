#
# Be sure to run `pod lib lint SnapshotKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SnapshotKit'
  s.version          = '0.3.2'
  s.summary          = 'UIView/UIWindow/UIScrollView/UITableView/WKWebView Extension to easily take snapshot image of visible or full content.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
                        A Kit that can make UIView/UIWindow/UIScrollView/UITableView/WKWebView to easily take snapshot image of visible or full content.
                       DESC

  s.homepage         = 'https://github.com/YK-Unit/SnapshotKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'York' => 'yorkzhang520@gmail.com' }
  s.source           = { :git => 'https://github.com/YK-Unit/SnapshotKit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'SnapshotKit/Classes/**/*'
  
  # s.resource_bundles = {
  #   'SnapshotKit' => ['SnapshotKit/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
