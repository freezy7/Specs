# Copyright (c) Meta Platforms, Inc. and affiliates.
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.

version = '0.74.5'
folly_version = '2024.01.01.00'
folly_compiler_flags = '-DFOLLY_NO_CONFIG -DFOLLY_MOBILE=1 -DFOLLY_USE_LIBCPP=1 -DFOLLY_CFG_NO_COROUTINES=1 -DFOLLY_HAVE_CLOCK_GETTIME=1 -Wno-comma -Wno-shorten-64-to-32'

source_path = 'node_modules/react-native/ReactCommon/jsinspector-modern'

header_dir = 'jsinspector-modern'
module_name = "jsinspector_modern"

Pod::Spec.new do |s|
  s.name                   = "React-jsinspector"
  s.version                = version
  s.summary                = "-"  # TODO
  s.homepage               = "https://reactnative.dev/"
  s.license                = "MIT"
  s.author                 = "Meta Platforms, Inc. and its affiliates"
  s.platforms              = { :ios => '13.4' }
  s.source                 = { :http => "https://github.com/freezy7/react-native-sdk/releases/download/v#{s.version}/React-jsinspector.zip" }
  s.source_files           = "#{source_path}/*.{cpp,h}"
  s.header_dir             = 'jsinspector-modern'
  s.compiler_flags         = folly_compiler_flags
  s.pod_target_xcconfig    = {
                               "HEADER_SEARCH_PATHS" => "\"$(PODS_ROOT)/..\" \"$(PODS_ROOT)/boost\" \"$(PODS_ROOT)/RCT-Folly\" \"$(PODS_ROOT)/DoubleConversion\" \"$(PODS_ROOT)/fmt/include\"",
                               "CLANG_CXX_LANGUAGE_STANDARD" => "c++20"
  }

  s.dependency "glog"
  s.dependency "RCT-Folly", folly_version
  s.dependency "React-featureflags"
  s.dependency "DoubleConversion"
  s.dependency "React-runtimeexecutor", version
  s.dependency "React-jsi"
  s.dependency "hermes-engine"

end
