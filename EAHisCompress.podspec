#
# Be sure to run `pod lib lint EAModularity.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'EAHisCompress'
  s.version          = '1.0.1.3'
  s.summary          = 'A short description of EAHisCompress.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
DESC

  s.homepage         = 'https://github.com/EastApex/EAHisCompressLib'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Aye' => 'aye.zhang@qq.com' }
  s.source           = { :git => 'https://github.com/EastApex/EAHisCompressLib.git', :tag => s.version.to_s }

  s.ios.deployment_target = '14.0'
  
  s.frameworks   = "UIKit", "Foundation","CoreGraphics"
  
  s.source_files = [
    'SCompressLib/**/*',
    'Classes/**/*.{h,m,swift}'
    ]


    s.ios.vendored_frameworks = [
        'SCompressLib.framework'
    ]



  
end

