#
# Be sure to run `pod lib lint inmobi-ios-sdk.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name                  = 'inmobi-ios-sdk'
  s.version               = '8.1.0'
  s.summary               = 'InMobi + AerServ Unified SDK'
  s.description           = 'InMobi + AerServs Unified iOS SDK CocoPods Integration. Copyright 2018-2019 InMobi, all rights reserved.'
  s.homepage              = 'https://bitbucket.org/aerservllc/inmobi-ios-sdk-pod'
  s.license               = { :type => 'MIT', :file => 'LICENSE' }
  s.author                = { 'Albert Zhu' => 'albert.zhu@inmobi.com' }
  s.source                = { :git => 'https://github.com/freezy7/inmobi-ios-sdk-pod.git', :tag => s.version.to_s }

  s.platform              = :ios, '9.0'
  s.ios.deployment_target = '9.0'
  s.ios.framework         = 'WebKit'
  s.xcconfig              = { 'OTHER_LDFLAGS' => '-ObjC' }
  s.source_files          = 'inmobi-ios-sdk/InMobiSDK.framework/Headers/*.{h,m}'
  s.public_header_files   = 'inmobi-ios-sdk/InMobiSDK.framework/Headers/*.h'
  s.vendored_frameworks   = 'inmobi-ios-sdk/InMobiSDK.framework'
end
