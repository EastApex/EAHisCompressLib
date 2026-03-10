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

  # 修复编译选项，解决C99和SwiftShims模块问题
  s.pod_target_xcconfig = {
    # 启用模块定义（必须）
    'DEFINES_MODULE' => 'YES',
    # 统一C语言编译标准为C99，解决PCH与当前编译的标准冲突
    'CLANG_C_LANGUAGE_STANDARD' => 'c99',
    'CLANG_CXX_LANGUAGE_STANDARD' => 'gnu++17',
    # 启用分布式构建（解决显式模块编译问题）
    'BUILD_LIBRARY_FOR_DISTRIBUTION' => 'YES',
    # 关闭bitcode（根据实际需求，建议关闭以减少冲突）
    'ENABLE_BITCODE' => 'NO',
    # 排除模拟器arm64架构（解决架构冲突）
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64',
    # 启用Swift模块验证（但关闭严格检查）
    'ENABLE_MODULE_VERIFICATION' => 'NO',
    # 移除禁用隐式Swift模块的配置（这是SwiftShims加载失败的关键）
    # 注释掉这行：'OTHER_SWIFT_FLAGS' => '-Xfrontend -disable-implicit-swift-modules'
    # 统一Swift编译模式
    'SWIFT_COMPILATION_MODE' => 'wholemodule',
    # 确保C模块启用
    'CLANG_ENABLE_MODULES' => 'YES',
    # 关闭PCH验证（临时解决PCH冲突）
    'VALIDATE_PCH_FILES' => 'NO'
  }

  s.user_target_xcconfig = {
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64',
    # 让主工程也使用统一的C99标准
    'CLANG_C_LANGUAGE_STANDARD' => 'c99'
  }

  s.ios.vendored_frameworks = [
    'SCompressLib.framework',
    'WatchConnectKit.framework'
  ]
end
