Pod::Spec.new do |spec|
  spec.name         = "CoreModule"
  spec.version      = "1.0.0"
  spec.summary      = "Core module for the project."
  spec.description  = "This is the core module that provides essential functionality for the app."
  spec.homepage     = "https://github.com/yourusername/CoreModule"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = { "Your Name" => "your.email@example.com" }
  spec.platform     = :ios, "14.0"
  spec.swift_version = "5.0"
  
  # Local source path to your directory
  spec.source       = { :path => '.' }  # Points to the current directory

  # Source files path
  spec.source_files = 'Modules/CoreModule/**/*.{h,m,swift}'

  # Optional: If you have resources like images or XIBs
  spec.resources    = 'Modules/CoreModule/Resources/**/*'

  # Dependencies
  spec.dependency "RxSwift", "~> 6.5"
  spec.dependency "RxCocoa", "~> 6.5"
end
