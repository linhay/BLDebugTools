Pod::Spec.new do |s|
s.name             = 'BLDebugTools'
s.version          = '0.1.0'
s.summary          = 'DebugTools for app'

s.homepage = 'https://github.com/bigL055/BLDebugTools'
s.license  = { :type => 'Apache License 2.0', :file => 'LICENSE' }
s.author   = { 'linger' => 'linhan.bigl055@outlook.com' }
s.source   = { :git => 'https://github.com/bigL055/BLDebugTools', :tag => s.version.to_s }

s.ios.deployment_target = '8.0'

s.source_files = ['Sources/*/**','Sources/**']
s.public_header_files = 'Sources/BLDebugTools.h'
s.dependency 'SnapKit'

s.subspec 'FPS' do |ss|
ss.source_files = 'Sources/FPS/**'
end

s.subspec 'Sandbox' do |ss|
ss.source_files = 'Sources/Sandbox/**'
end


end
