
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

end
