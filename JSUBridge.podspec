Pod::Spec.new do |s|
  s.name             = 'JSUBridge'
  s.version          = '1.0.0'
  s.summary          = 'Universal framework for JavaScript & Objective-C Invoking.'

  s.description      = <<-DESC
An universal framework to help JavaScript programmer to develop apps without 
    checking whether the running OS is iOS/macOS nor Android anymore!
                       DESC

  s.homepage         = 'https://github.com/siriuscn/JSUBridge'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'sirius' => '331862034@qq.com' }
  s.source           = { :git => 'https://github.com/siriuscn/JSUBridge.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.10'

  s.source_files = 'JSUBridge/Classes/**/*'

  s.frameworks = 'WebKit'
end
