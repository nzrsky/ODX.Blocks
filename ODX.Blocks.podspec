Pod::Spec.new do |s|
  s.name         = "ODX.Blocks"
  s.version      = "1.5.1"
  s.summary      = "Utility classes for working with Objective-C blocks."
  s.homepage     = "https://github.com/Rogaven/ODX.Blocks"
  s.license      = { :type => 'MIT', :file => 'LICENSE.txt' }
  s.author       = { "Alexey Nazaroff" => "alexx.nazaroff@gmail.com" }
  s.source       = { :git => "https://github.com/Rogaven/ODX.Blocks.git", :tag => s.version.to_s }
  s.ios.deployment_target = '5.0'
  s.osx.deployment_target = '10.6'
  s.watchos.deployment_target = '1.0'
  s.source_files = 'src/**/*'
  s.requires_arc = true
  s.dependency 'ODX.Core', '~> 1.5'
end
