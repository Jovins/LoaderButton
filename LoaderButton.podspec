Pod::Spec.new do |s|
  s.name             = 'LoaderButton'
  s.version          = '1.0.0'
  s.summary          = 'LoaderButton is a very interesting animation loading button'
  s.homepage         = 'https://github.com/Jovins/LoaderButton'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Jovins' => 'jovinscoder@163.com' }
  s.source           = { :git => 'https://github.com/Jovins/LoaderButton.git', :tag => s.version.to_s }
  s.ios.deployment_target = '9.0'
  s.source_files = 'LoaderButton/**/*'
  
  # s.resource_bundles = {
  #   'LoaderButton' => ['LoaderButton/Assets/*.png']
  # }
  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
