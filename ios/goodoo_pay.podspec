Pod::Spec.new do |s|
  s.name             = 'goodoo_pay'
  s.version          = '1.0.0'
  s.summary          = 'GoodooPay Flutter SDK for payment integration'
  s.description      = <<-DESC
Native iOS bridge for launching the embedded GoodooPay Flutter payment flow
from UIKit applications and receiving structured payment results.
                       DESC
  s.homepage         = 'https://github.com/GoodooLLC/goodoopay-ios-sdk'
  s.license          = { :type => 'MIT' }
  s.author           = { 'GoodooPay' => 'support@goodoo.kg' }
  s.source           = { :git => 'https://github.com/GoodooLLC/goodoopay-ios-sdk.git', :tag => "v#{s.version}" }
  # Support validation contexts where paths are resolved from podspec dir or repo root.
  s.source_files     = '{Classes,ios/Classes}/**/*'
  s.vendored_frameworks = '{Frameworks,ios/Frameworks}/**/*.xcframework'
  s.preserve_paths   = '{Frameworks,ios/Frameworks}/**/*.xcframework'
  s.platform         = :ios, '13.0'
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version    = '5.0'
end
