# Copyright (c) Meta Platforms, Inc. and affiliates.
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.

version = '0.74.5'
folly_version = '2024.01.01.00'
folly_compiler_flags = '-DFOLLY_NO_CONFIG -DFOLLY_MOBILE=1 -DFOLLY_USE_LIBCPP=1 -DFOLLY_CFG_NO_COROUTINES=1 -DFOLLY_HAVE_CLOCK_GETTIME=1 -Wno-comma -Wno-shorten-64-to-32'
boost_compiler_flags = '-Wno-documentation'

folly_dep_name = 'RCT-Folly/Fabric'
source_path = 'node_modules/react-native/ReactCommon'

# react_native_path = ".."

Pod::Spec.new do |s|
  s.name                   = "React-Fabric"
  s.version                = version
  s.summary                = "Fabric for React Native."
  s.homepage               = "https://reactnative.dev/"
  s.license                = 'MIT'
  s.author                 = "Meta Platforms, Inc. and its affiliates"
  s.platforms              = { :ios => '13.4' }
  s.source                 = { :http => "https://github.com/freezy7/react-native-sdk/releases/download/v#{s.version}/React-Fabric.zip" }
  s.source_files           = "#{source_path}/dummyFile.cpp"
  s.pod_target_xcconfig = { "USE_HEADERMAP" => "YES",
                            "HEADER_SEARCH_PATHS" => "\"${PODS_CONFIGURATION_BUILD_DIR}/React-rendererdebug/React_rendererdebug.framework/Headers\" \"${PODS_CONFIGURATION_BUILD_DIR}/React-graphics/React_graphics.framework/Headers\" \"${PODS_CONFIGURATION_BUILD_DIR}/React-graphics/React_graphics.framework/Headers/react/renderer/graphics/platform/ios\"",
                            "CLANG_CXX_LANGUAGE_STANDARD" => "c++20"
                          }

  s.dependency folly_dep_name, folly_version

  s.dependency "React-jsiexecutor"
  s.dependency "RCTRequired"
  s.dependency "RCTTypeSafety"
  s.dependency "ReactCommon/turbomodule/core"
  s.dependency "React-jsi"
  s.dependency "React-logger"
  s.dependency "glog"
  s.dependency "DoubleConversion"
  s.dependency "fmt", "9.1.0"
  s.dependency "React-Core"
  s.dependency "React-debug"
  s.dependency "React-utils"
  s.dependency "React-runtimescheduler"
  s.dependency "React-cxxreact"
  s.dependency "React-rendererdebug"
  s.dependency "React-graphics"
  s.dependency "hermes-engine"

  s.subspec "core" do |ss|
    header_search_path = [
      "\"$(PODS_ROOT)/boost\"",
      "\"$(PODS_ROOT)/ReactCommon\"",
      "\"$(PODS_ROOT)/RCT-Folly\"",
      "\"$(PODS_ROOT)/Headers/Private/Yoga\"",
      "\"$(PODS_ROOT)\"",
      "\"$(PODS_ROOT)/DoubleConversion\"",
      "\"$(PODS_ROOT)/fmt/include\"",
    ]

    ss.dependency             folly_dep_name, folly_version
    ss.compiler_flags       = folly_compiler_flags + ' ' + boost_compiler_flags
    ss.source_files         = "#{source_path}/react/renderer/core/**/*.{m,mm,cpp,h}"
    ss.exclude_files        = "#{source_path}/react/renderer/core/tests"
    ss.header_dir           = "react/renderer/core"
    ss.pod_target_xcconfig  = {
      "HEADER_SEARCH_PATHS" => header_search_path.join(" ")
    }
  end

  s.subspec "telemetry" do |ss|
    ss.dependency             folly_dep_name, folly_version
    ss.compiler_flags       = folly_compiler_flags
    ss.source_files         = "#{source_path}/react/renderer/telemetry/**/*.{m,mm,cpp,h}"
    ss.exclude_files        = "#{source_path}/react/renderer/telemetry/tests"
    ss.header_dir           = "react/renderer/telemetry"
  end

  s.subspec "leakchecker" do |ss|
    ss.dependency             "React-Fabric/core"
    ss.compiler_flags       = folly_compiler_flags
    ss.source_files         = "#{source_path}/react/renderer/leakchecker/**/*.{cpp,h}"
    ss.exclude_files        = "#{source_path}/react/renderer/leakchecker/tests"
    ss.header_dir           = "react/renderer/leakchecker"
    ss.pod_target_xcconfig  = { "GCC_WARN_PEDANTIC" => "YES" }
  end

  s.subspec "componentregistrynative" do |ss|
    ss.dependency             "React-Fabric/core"
    ss.compiler_flags       = folly_compiler_flags
    ss.source_files         = "#{source_path}/react/renderer/componentregistry/native/**/*.{m,mm,cpp,h}"
    ss.header_dir           = "react/renderer/componentregistry/native"
  end

  s.subspec "imagemanager" do |ss|
    ss.dependency             "React-Fabric/core"
    ss.compiler_flags       = folly_compiler_flags
    ss.source_files         = "#{source_path}/react/renderer/imagemanager/*.{m,mm,cpp,h}"
    ss.header_dir           = "react/renderer/imagemanager"
  end

  s.subspec "attributedstring" do |ss|
    ss.dependency             "React-Fabric/mounting"
    ss.compiler_flags       = folly_compiler_flags
    ss.source_files         = "#{source_path}/react/renderer/attributedstring/**/*.{m,mm,cpp,h}"
    ss.exclude_files        = "#{source_path}/react/renderer/attributedstring/tests"
    ss.header_dir           = "react/renderer/attributedstring"
  end

  s.subspec "componentregistry" do |ss|
    ss.dependency             "React-Fabric/components/legacyviewmanagerinterop"
    ss.compiler_flags       = folly_compiler_flags
    ss.source_files         = "#{source_path}/react/renderer/componentregistry/*.{m,mm,cpp,h}"
    ss.header_dir           = "react/renderer/componentregistry"
  end

  s.subspec "components" do |ss|

    ss.subspec "view" do |sss|
      sss.dependency             "React-Fabric/core"
      sss.dependency             "Yoga"
      sss.dependency             "React-nativeconfig"
      sss.compiler_flags       = folly_compiler_flags
      sss.source_files         = "#{source_path}/react/renderer/components/view/**/*.{m,mm,cpp,h}"
      sss.exclude_files        = "#{source_path}/react/renderer/components/view/tests", "react/renderer/components/view/platform/android"
      sss.header_dir           = "react/renderer/components/view"
      sss.pod_target_xcconfig  = { "HEADER_SEARCH_PATHS" => "\"$(PODS_ROOT)/Headers/Private/Yoga\"" }
    end

    ss.subspec "legacyviewmanagerinterop" do |sss|
      sss.dependency             "React-Fabric/components/view"
      sss.compiler_flags       = folly_compiler_flags
      sss.source_files         = "#{source_path}/react/renderer/components/legacyviewmanagerinterop/**/*.{m,mm,cpp,h}"
      sss.exclude_files        = "#{source_path}/react/renderer/components/legacyviewmanagerinterop/tests"
      sss.header_dir           = "react/renderer/components/legacyviewmanagerinterop"
      sss.pod_target_xcconfig  = { "HEADER_SEARCH_PATHS" => "\"$(PODS_ROOT)/Headers/Private/React-Core\"" }
    end

    ss.subspec "rncore" do |sss|
      sss.dependency             "React-Fabric/componentregistry"
      sss.dependency             "React-Fabric/components/legacyviewmanagerinterop"
      sss.compiler_flags       = folly_compiler_flags
      sss.source_files         = "#{source_path}/react/renderer/components/rncore/**/*.{m,mm,cpp,h}"
      sss.header_dir           = "react/renderer/components/rncore"
    end

    ss.subspec "modal" do |sss|
      sss.dependency             "React-Fabric/components/rncore"
      sss.compiler_flags       = folly_compiler_flags
      sss.source_files         = "#{source_path}/react/renderer/components/modal/**/*.{m,mm,cpp,h}"
      sss.exclude_files        = "#{source_path}/react/renderer/components/modal/tests"
      sss.header_dir           = "react/renderer/components/modal"
    end

    ss.subspec "inputaccessory" do |sss|
      sss.dependency             "React-Fabric/components/rncore"
      sss.compiler_flags       = folly_compiler_flags
      sss.source_files         = "#{source_path}/react/renderer/components/inputaccessory/**/*.{m,mm,cpp,h}"
      sss.exclude_files        = "#{source_path}/react/renderer/components/inputaccessory/tests"
      sss.header_dir           = "react/renderer/components/inputaccessory"
    end

    ss.subspec "root" do |sss|
      sss.dependency             "React-Fabric/components/view"
      sss.compiler_flags       = folly_compiler_flags
      sss.source_files         = "#{source_path}/react/renderer/components/root/**/*.{m,mm,cpp,h}"
      sss.exclude_files        = "#{source_path}/react/renderer/components/root/tests"
      sss.header_dir           = "react/renderer/components/root"
    end

    ss.subspec "safeareaview" do |sss|
      sss.dependency             "React-Fabric/components/rncore"
      sss.compiler_flags       = folly_compiler_flags
      sss.source_files         = "#{source_path}/react/renderer/components/safeareaview/**/*.{m,mm,cpp,h}"
      sss.exclude_files        = "#{source_path}/react/renderer/components/safeareaview/tests"
      sss.header_dir           = "react/renderer/components/safeareaview"

    end

    ss.subspec "scrollview" do |sss|
      sss.dependency             "React-Fabric/components/view"
      sss.compiler_flags       = folly_compiler_flags
      sss.source_files         = "#{source_path}/react/renderer/components/scrollview/**/*.{m,mm,cpp,h}"
      sss.exclude_files        = "#{source_path}/react/renderer/components/scrollview/tests"
      sss.header_dir           = "react/renderer/components/scrollview"

    end

    ss.subspec "text" do |sss|
      sss.dependency             "React-Fabric/textlayoutmanager"
      sss.compiler_flags       = folly_compiler_flags
      sss.source_files         = "#{source_path}/react/renderer/components/text/**/*.{m,mm,cpp,h}"
      sss.exclude_files        = "#{source_path}/react/renderer/components/text/tests"
      sss.header_dir           = "react/renderer/components/text"

    end

    ss.subspec "textinput" do |sss|
      sss.dependency             "React-Fabric/imagemanager"
      sss.dependency             "React-Fabric/components/text"
      sss.compiler_flags       = folly_compiler_flags
      sss.source_files         = "#{source_path}/react/renderer/components/textinput/platform/ios/**/*.{m,mm,cpp,h}"
      sss.header_dir           = "react/renderer/components/iostextinput"

    end

    ss.subspec "unimplementedview" do |sss|
      sss.dependency             "React-Fabric/components/view"
      sss.compiler_flags       = folly_compiler_flags
      sss.source_files         = "#{source_path}/react/renderer/components/unimplementedview/**/*.{m,mm,cpp,h}"
      sss.exclude_files        = "#{source_path}/react/renderer/components/unimplementedview/tests"
      sss.header_dir           = "react/renderer/components/unimplementedview"

    end
  end

  s.subspec "mounting" do |ss|
    ss.dependency             "React-Fabric/components/root"
    ss.dependency             "React-Fabric/telemetry"
    ss.compiler_flags       = folly_compiler_flags
    ss.source_files         = "#{source_path}/react/renderer/mounting/**/*.{m,mm,cpp,h}"
    ss.exclude_files        = "#{source_path}/react/renderer/mounting/tests"
    ss.header_dir           = "react/renderer/mounting"
  end

  s.subspec "uimanager" do |ss|
    ss.dependency             "React-Fabric/leakchecker"
    ss.dependency             "React-Fabric/mounting"
    ss.dependency             "React-Fabric/componentregistry"
    ss.dependency             "React-Fabric/components/text"
    ss.dependency             "React-Fabric/components/root"
    
    ss.compiler_flags       = folly_compiler_flags
    ss.source_files         = "#{source_path}/react/renderer/uimanager/**/*.{m,mm,cpp,h}"
    ss.exclude_files        = "#{source_path}/react/renderer/uimanager/tests"
    ss.header_dir           = "react/renderer/uimanager"
  end

  s.subspec "textlayoutmanager" do |ss|
    ss.dependency             "React-Fabric/telemetry"
    ss.dependency             "React-Fabric/attributedstring"
    ss.dependency             "React-RCTText"

    ss.compiler_flags       = folly_compiler_flags
    ss.source_files         = "#{source_path}/react/renderer/textlayoutmanager/platform/ios/**/*.{m,mm,cpp,h}",
                              "#{source_path}/react/renderer/textlayoutmanager/*.{m,mm,cpp,h}"
    ss.exclude_files        = "#{source_path}/react/renderer/textlayoutmanager/tests",
                              "#{source_path}/react/renderer/textlayoutmanager/platform/android",
                              "#{source_path}/react/renderer/textlayoutmanager/platform/cxx"
    ss.header_dir           = "react/renderer/textlayoutmanager"
  end

  s.subspec "animations" do |ss|
    ss.dependency             "React-Fabric/uimanager"

    ss.compiler_flags       = folly_compiler_flags
    ss.source_files         = "#{source_path}/react/renderer/animations/**/*.{m,mm,cpp,h}", "#{source_path}/react/renderer/components/image/ImageProps.h"
    ss.public_header_files  = "#{source_path}/react/renderer/animations/**/*.h"
    ss.private_header_files = "#{source_path}/react/renderer/components/image/ImageProps.h"
    ss.exclude_files        = "#{source_path}/react/renderer/animations/tests"
    ss.header_dir           = "react/renderer/animations"

    ss.pod_target_xcconfig = { "HEADER_SEARCH_PATHS" => "\"$(PODS_ROOT)/React-Fabric/#{source_path}\" \"$(PODS_ROOT)/Headers/Public/React-Fabric\"" }
  end

  s.subspec "scheduler" do |ss|
    ss.dependency             "React-Fabric/uimanager"
    ss.compiler_flags       = folly_compiler_flags
    ss.source_files         = "#{source_path}/react/renderer/scheduler/**/*.{m,mm,cpp,h}"
    ss.header_dir           = "react/renderer/scheduler"
  end

  # s.subspec "templateprocessor" do |ss|
  #   ss.dependency             folly_dep_name, folly_version
  #   ss.compiler_flags       = folly_compiler_flags
  #   ss.source_files         = "#{source_path}/react/renderer/templateprocessor/**/*.{m,mm,cpp,h}"
  #   ss.exclude_files        = "#{source_path}/react/renderer/templateprocessor/tests"
  #   ss.header_dir           = "react/renderer/templateprocessor"
  # end


#   s.script_phases = [
#     {
#       :name => '[RN]Check rncore',
#       :execution_position => :before_compile,
#       :script => <<-EOS
# echo "Checking whether Codegen has run..."
# rncorePath="$REACT_NATIVE_PATH/ReactCommon/react/renderer/components/rncore"

# if [[ ! -d "$rncorePath" ]]; then
#   echo 'error: Codegen did not run properly in your project. Please reinstall cocoapods with `bundle exec pod install`.'
#   exit 1
# fi
#       EOS
#     }
#   ]
end
