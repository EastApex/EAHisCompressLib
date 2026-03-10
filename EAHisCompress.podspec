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

  s.ios.deployment_target = '13.0' # 强制统一为 iOS 13.0，删除 12.0 配置
  s.swift_version = '5.9'
  s.frameworks = 'UIKit', 'Foundation', 'CoreGraphics'
  s.source_files = '*.swift'

  # 核心修复：移除所有禁用隐式模块的配置，统一编译标准
  s.pod_target_xcconfig = {
    'DEFINES_MODULE' => 'YES',
    # 强制统一 C99 标准（解决 PCH 冲突）
    'CLANG_C_LANGUAGE_STANDARD' => 'c99',
    'CLANG_CXX_LANGUAGE_STANDARD' => 'gnu++17',
    # 启用分布式构建（显式模块编译必需）
    'BUILD_LIBRARY_FOR_DISTRIBUTION' => 'YES',
    'ENABLE_BITCODE' => 'NO',
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64',
    'ENABLE_MODULE_VERIFICATION' => 'NO',
    'SWIFT_COMPILATION_MODE' => 'wholemodule',
    'CLANG_ENABLE_MODULES' => 'YES',
    'VALIDATE_PCH_FILES' => 'NO',
    # 关键：删除所有 -disable-implicit-swift-modules 相关配置
    # 绝对不要出现 ANY 禁用隐式模块的参数
    'OTHER_SWIFT_FLAGS' => '', # 清空该配置，避免残留禁用参数
    'CLANG_ENABLE_IMPLICIT_MODULES' => 'YES', # 显式启用隐式模块
    'CLANG_ENABLE_IMPLICIT_MODULE_MAPS' => 'YES' # 启用模块映射
  }

  s.user_target_xcconfig = {
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64',
    'CLANG_C_LANGUAGE_STANDARD' => 'c99',
    'CLANG_ENABLE_IMPLICIT_MODULES' => 'YES',
    'CLANG_ENABLE_IMPLICIT_MODULE_MAPS' => 'YES'
  }

  s.ios.vendored_frameworks = [
    'SCompressLib.framework',
    'WatchConnectKit.framework'
  ]
end
