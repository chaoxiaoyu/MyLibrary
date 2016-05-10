#
# Be sure to run `pod lib lint MyLibrary.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "MyLibrary"
  s.version          = "0.1.0"
  s.summary          = "A short description of MyLibrary."

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
a custom webView with JS
                       DESC

  s.homepage         = "https://github.com/<GITHUB_USERNAME>/MyLibrary"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "cxy" => "2445879918@qq.com" }
  s.source           = { :git => "/Users/abc/Desktop/XTWebViewLibrary/MyLibrary", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*.{h,m}'
  
  s.resource_bundles = {
     'MyLibrary' => ['Pod/Assets/*.png']
   }

  s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit', 'AVFoundation', 'SystemConfiguration', 'JavaScriptCore'
# s.libraries = 'libc++.tbd', 'libsqlite3.0.tbd', 'libz.tbd'
  s.dependency 'iOS-AlipaySDK', '3.0.2'
  s.dependency 'MBProgressHUD', '0.9.2'
  s.dependency 'TencentOpenApiSDK', '2.9.5'
  s.dependency 'Weixin', '1.6.2'
end
