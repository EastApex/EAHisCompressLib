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

  # ========== 修复：统一C/C++编译标准，解决C99配置不匹配问题 ==========
  s.pod_target_xcconfig = {
    # C语言标准统一为C99（修复核心问题）
    'CLANG_C_LANGUAGE_STANDARD' => 'c99',
    # C++语言标准单独配置（之前错误地用了gnu99，C++应对应gnu++98/gnu++11）
    'CLANG_CXX_LANGUAGE_STANDARD' => 'gnu++11',
    # 禁用模块缓存的严格检查（解决SwiftShims加载问题）
    'SWIFT_COMPILATION_MODE' => 'wholemodule',
    'ENABLE_MODULE_VERIFICATION' => 'NO',
    # 兼容旧版C代码的编译选项
    'GCC_NO_COMMON_BLOCKS' => 'YES',
    'ENABLE_STRICT_OBJC_MSGSEND' => 'NO'
  }

  # ========== 优化：仅让主项目继承必要的C标准配置，避免过度侵入 ==========
  s.user_target_xcconfig = {
    'CLANG_C_LANGUAGE_STANDARD' => 'c99',
    # 移除C++标准的强制继承（避免影响主项目其他依赖）
    'SWIFT_INCLUDE_PATHS' => '$(inherited)',
    'MODULEMAP_PRIVATE_HEADERS' => '$(inherited)'
  }

  # ========== 新增：排除Swift模块缓存冲突的配置 ==========
  s.preserve_paths = '*.framework'
  s.xcconfig = {
    'LD_RUNPATH_SEARCH_PATHS' => '@executable_path/Frameworks @loader_path/Frameworks',
    'MODULE_CACHE_DIR' => '$(DERIVED_FILE_DIR)/ModuleCache.noindex'
  }
end
