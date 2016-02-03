Pod::Spec.new do |s|
  s.name             = "AITableView"
  s.version          = "0.1.1"
  s.summary          = "An amazing tableview."
  s.description      = <<-DESC
                       It is a tableview used on iOS, which implement by Objective-C.
                       DESC
  s.homepage         = "https://github.com/chentoo/AITableView"
  # s.screenshots      = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "chentoo" => "chentoo@gmail.com" }
  s.source           = { :git => "https://github.com/chentoo/AITableView.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://weibo.com/chentoo'

  s.platform     = :ios, '7.0'
  # s.ios.deployment_target = '6.0'
  # s.osx.deployment_target = '10.7'
  s.requires_arc = true

  s.source_files = 'AITableView/*'
  # s.resources = 'Assets'

  # s.ios.exclude_files = 'Classes/osx'
  # s.osx.exclude_files = 'Classes/ios'
  # s.public_header_files = 'Classes/**/*.h'
  s.frameworks = 'Foundation', 'UIKit'

end