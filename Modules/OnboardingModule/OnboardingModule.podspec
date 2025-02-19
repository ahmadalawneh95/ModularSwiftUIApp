Pod::Spec.new do |s|
  s.name         = 'OnboardingModule'
  s.version      = '1.0.0'
  s.summary      = 'A modular onboarding screen'
  s.description  = 'Onboarding screen module for ModularSwiftUIApp'
  s.homepage     = 'https://github.com/ahmadalawneh95/OnboardingModule'
  s.author       = { 'Ahmad Alawneh' => 'ahmad.cras79@gmail.com' }
  s.ios.deployment_target = '15.0'
  s.source       = { :path => '.' }
  s.source_files = 'Sources/**/*.{swift}'
  s.frameworks   = 'SwiftUI'
  s.license      = { :type => "MIT", :file => "LICENSE" }
end
