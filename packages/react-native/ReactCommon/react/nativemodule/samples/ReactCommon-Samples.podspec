# Copyright (c) Meta Platforms, Inc. and affiliates.
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.

require "json"

package = JSON.parse(File.read(File.join(__dir__, "..", "..", "..", "..", "package.json")))
version = package['version']

source = { :git => 'https://github.com/facebook/react-native.git' }
if version == '1000.0.0'
  # This is an unpublished version, use the latest commit hash of the react-native repo, which we’re presumably in.
  source[:commit] = `git rev-parse HEAD`.strip if system("git rev-parse --git-dir > /dev/null 2>&1")
else
  source[:tag] = "v#{version}"
end

folly_compiler_flags = '-DFOLLY_NO_CONFIG -DFOLLY_MOBILE=1 -DFOLLY_USE_LIBCPP=1 -DFOLLY_CFG_NO_COROUTINES=1 -Wno-comma -Wno-shorten-64-to-32 -Wno-gnu-zero-variadic-macro-arguments'
folly_version = '2022.05.16.00'
boost_compiler_flags = '-Wno-documentation'
using_hermes = ENV['USE_HERMES'] == nil || ENV['USE_HERMES'] == "1"
Pod::Spec.new do |s|
  s.name                   = "ReactCommon-Samples"
  s.module_name            = "ReactCommon_Samples"
  s.header_dir             = "ReactCommon"
  s.version                = version
  s.summary                = "-"  # TODO
  s.homepage               = "https://reactnative.dev/"
  s.license                = package["license"]
  s.author                 = "Meta Platforms, Inc. and its affiliates"
  s.platforms              = { :ios => min_ios_version_supported }
  s.source                 = source
  s.compiler_flags         = folly_compiler_flags + ' ' + boost_compiler_flags
  s.pod_target_xcconfig    = { "HEADER_SEARCH_PATHS" => "\"$(PODS_ROOT)/boost\" \"$(PODS_ROOT)/RCT-Folly\" \"$(PODS_ROOT)/DoubleConversion\" \"$(PODS_ROOT)/fmt/include\" \"$(PODS_ROOT)/Headers/Private/React-Core\" \"${PODS_CONFIGURATION_BUILD_DIR}/ReactCommon-Samples/ReactCommon_Samples.framework/Headers\"",
                               "USE_HEADERMAP" => "YES",
                               "CLANG_CXX_LANGUAGE_STANDARD" => "c++20",
                               "GCC_WARN_PEDANTIC" => "YES" }
  if ENV['USE_FRAMEWORKS']
    s.header_mappings_dir     = './'
  end



  s.source_files = "ReactCommon/**/*.{cpp,h}",
        "platform/ios/**/*.{mm,cpp,h}"

  s.dependency "RCT-Folly"
  s.dependency "DoubleConversion"
  s.dependency 'fmt' , '~> 6.2.1'
  s.dependency "ReactCommon/turbomodule/core"
  s.dependency "React-NativeModulesApple"
  s.dependency "React-Core"
  s.dependency "React-cxxreact"
  s.dependency "React-Codegen"

  if using_hermes
    s.dependency "hermes-engine"
  else
    s.dependency "React-jsi"
  end
end
