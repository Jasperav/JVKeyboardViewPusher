Pod::Spec.new do |s|
  s.name             = 'JVKeyboardViewPusher'
  s.version          = '0.1.1'
  s.summary          = 'Pushes views above the keyboard. This views mostly are/contain text fields/views.'
  s.homepage         = 'https://github.com/Jasperav/JVKeyboardViewPusher'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Jasperav' => 'Jasperav@hotmail.com' }
  s.source           = { :git => 'https://github.com/Jasperav/JVKeyboardViewPusher.git', :tag => s.version.to_s }

  s.ios.deployment_target = '12.0'

  s.source_files = 'JVKeyboardViewPusher/Classes/**/*'
end
