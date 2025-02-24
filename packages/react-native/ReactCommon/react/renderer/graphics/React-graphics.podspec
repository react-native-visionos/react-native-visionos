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

folly_compiler_flags = '-DFOLLY_NO_CONFIG -DFOLLY_MOBILE=1 -DFOLLY_USE_LIBCPP=1 -DFOLLY_CFG_NO_COROUTINES=1 -Wno-comma -Wno-shorten-64-to-32'
folly_version = '2022.05.16.00'
boost_compiler_flags = '-Wno-documentation'

Pod::Spec.new do |s|
  source_files = "**/*.{m,mm,cpp,h}"
  header_search_paths = [
    "\"$(PODS_ROOT)/boost\"",
    "\"$(PODS_TARGET_SRCROOT)/../../../\"",
    "\"$(PODS_ROOT)/RCT-Folly\"",
  ]

  s.name                   = "React-graphics"
  s.version                = version
  s.summary                = "Fabric for React Native."
  s.homepage               = "https://reactnative.dev/"
  s.license                = package["license"]
  s.author                 = "Meta Platforms, Inc. and its affiliates"
  s.platforms              = { :ios => min_ios_version_supported }
  s.source                 = source
  s.compiler_flags         = folly_compiler_flags + ' ' + boost_compiler_flags
  s.source_files           = source_files
  s.exclude_files          = "tests",
                             "platform/android",
                             "platform/cxx"
  s.header_dir             = "react/renderer/graphics"

  if ENV['USE_FRAMEWORKS']
    s.module_name            = "React_graphics"
    s.header_mappings_dir  = "../../.."
    header_search_paths = header_search_paths + ["\"$(PODS_TARGET_SRCROOT)/platform/ios\""]
  end

  s.pod_target_xcconfig  = { "USE_HEADERMAP" => "NO",
                             "HEADER_SEARCH_PATHS" => header_search_paths.join(" "),
                             "DEFINES_MODULE" => "YES",
                             "CLANG_CXX_LANGUAGE_STANDARD" => "c++20" }

  s.dependency "glog"
  s.dependency "RCT-Folly/Fabric", folly_version
  s.dependency "React-Core/Default", version
  s.dependency "React-utils"
end
