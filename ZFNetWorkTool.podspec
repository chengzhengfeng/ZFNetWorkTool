#
# Be sure to run `pod lib lint ZFNetWorkTool.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ZFNetWorkTool'
  s.version          = '0.1.0'
  s.summary          = '初始化'

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/chengzhengfeng/ZFNetWorkTool'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '631781190@qq.com' => '631781190@qq.com' }
  s.source           = { :git => 'https://github.com/chengzhengfeng/ZFNetWorkTool.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'
s.dependency 'AFNetworking', '~> 3.1.0'
s.dependency 'MBProgressHUD', '~> 1.0.0'
s.dependency 'MJExtension', '~> 3.0.13'
s.user_target_xcconfig = { 'CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES' => 'YES' }

  s.source_files = 'ZFNetWorkTool/Classes/**/*'

end
