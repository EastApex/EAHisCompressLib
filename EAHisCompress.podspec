#
# Be sure to run `pod lib lint EAModularity.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'EAHisCompress'
  s.version          = '1.0.3'
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

  s.ios.deployment_target = '13.0'
  
  s.swift_versions = "5.9"
  
  s.frameworks   = "UIKit", "Foundation","CoreGraphics"
  
  s.source_files = "*.{swift}"


  s.ios.vendored_frameworks = [
        'SCompressLib.framework',
        'WatchConnectKit.framework'
    ]
  # ========== 新增：强制开启C99编译标准 ==========
  s.pod_target_xcconfig = {
    # 统一C语言标准为C99
    'CLANG_C_LANGUAGE_STANDARD' => 'c99',
    'CLANG_CXX_LANGUAGE_STANDARD' => 'gnu99',
    # 关闭严格的未定义变量检查（避免脚本报错）
    'GCC_NO_COMMON_BLOCKS' => 'YES',
    'ENABLE_STRICT_OBJC_MSGSEND' => 'NO'
  }

  # ========== 新增：让主项目继承该配置 ==========
  s.user_target_xcconfig = {
    'CLANG_C_LANGUAGE_STANDARD' => 'c99',
    'CLANG_CXX_LANGUAGE_STANDARD' => 'gnu99'
  }


  
end

