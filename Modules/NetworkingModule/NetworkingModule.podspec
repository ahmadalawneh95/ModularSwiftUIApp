Pod::Spec.new do |s|
  s.name         = 'NetworkingModule'
  s.version      = '1.0.0'
  s.summary      = 'A modular networking layer using URLSession'
  s.description  = 'Custom network layer with RxSwift support'
  s.homepage     = 'https://github.com/ahmadalawneh95/NetworkingModule'
  s.author       = { 'Ahmad Alawneh' => 'ahmad.cras79@gmail.com' }
  s.ios.deployment_target = '15.0'
  s.source       = { :path => '.' }
  s.source_files = 'Sources/**/*.{h,m,swift}'
  s.frameworks   = 'Foundation'
  s.dependency 'RxSwift'
  s.license      = { :type => "MIT", :file => "LICENSE" }
end

