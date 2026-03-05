Pod::Spec.new do |s|
  s.name             = 'EAHisCompress'
  s.version          = '1.0.3'
  s.summary          = 'A short description of EAHisCompress.'

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/EastApex/EAHisCompressLib'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Aye' => 'aye.zhang@qq.com' }
  s.source           = { :git => 'https://github.com/EastApex/EAHisCompressLib.git', :tag => s.version.to_s }

  s.ios.deployment_target = '13.0'
  s.swift_version = '5.9'  # 改为单数形式
  s.frameworks = 'UIKit', 'Foundation', 'CoreGraphics'
  s.source_files = '*.swift'

  # 添加编译标志来解决C99兼容性问题
  s.pod_target_xcconfig = {
    'CLANG_CXX_LANGUAGE_STANDARD' => 'c++17',
    'CLANG_CXX_LIBRARY' => 'libc++',
    'GCC_C_LANGUAGE_STANDARD' => 'c99',
    'OTHER_SWIFT_FLAGS' => '-DSWIFT_PACKAGE'
  }

  s.ios.vendored_frameworks = [
    'SCompressLib.framework',
    'WatchConnectKit.framework'
  ]
end
