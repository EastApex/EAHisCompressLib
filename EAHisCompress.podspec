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
  s.swift_version = '5.9'
  s.frameworks = 'UIKit', 'Foundation', 'CoreGraphics'
  s.source_files = '*.swift'

  # 详细配置编译选项来解决模块冲突
  s.pod_target_xcconfig = {
    'DEFINES_MODULE' => 'YES',
    'SWIFT_COMPILATION_MODE' => 'wholemodule',
    'ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES' => 'NO',
    'BUILD_LIBRARY_FOR_DISTRIBUTION' => 'NO',
    'ENABLE_BITCODE' => 'NO', # 如果不需要bitcode可以关闭
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64', # 针对模拟器架构
    'OTHER_SWIFT_FLAGS' => '-Xfrontend -disable-implicit-swift-modules'
  }

  s.user_target_xcconfig = {
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64'
  }

  s.ios.vendored_frameworks = [
    'SCompressLib.framework',
    'WatchConnectKit.framework'
  ]
end
