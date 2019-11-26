Pod::Spec.new do |s|
  s.name             = 'FloatingTextInput'
  s.version          = '0.2.4'
  s.summary          = 'Floating title for UITextField and UITextView'
  s.description      = <<-DESC
                       Additional view for UITextField and UITextView
                       - floating behavior
                       - title
                       - separator
                       - validation text
                       DESC
  s.homepage         = 'https://github.com/RedMadRobot/floating-text-input'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Alexander-Ignition' => 'ai@redmadrobot.com' }
  s.source           = { :git => 'https://github.com/RedMadRobot/floating-text-input.git', :tag => s.version.to_s }
  s.ios.deployment_target = '10.0'
  s.swift_version = '5'
  s.source_files = 'FloatingTextInput/*.swift'
  s.frameworks = 'UIKit'
end
