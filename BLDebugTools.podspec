Pod::Spec.new do |s|
s.name             = 'BLDebugTools'
s.version          = '0.2.0'
s.summary          = 'DebugTools for app'

s.homepage = 'https://github.com/linhay/BLDebugTools'
s.license  = { :type => 'Apache License 2.0', :file => 'LICENSE' }
s.author   = { 'linhey' => 'linhan.linhey@outlook.com' }
s.source   = { :git => 'https://github.com/linhay/BLDebugTools.git', :tag => s.version.to_s }

s.ios.deployment_target = '8.0'

s.source_files = ['Sources/*/**','Sources/**']
s.public_header_files = 'Sources/BLDebugTools.h'
s.dependency 'SnapKit'
s.dependency 'PopGesture'

end
