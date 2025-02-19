
Pod::Spec.new do |spec|
  spec.name         = "OnboardingModule"
  spec.version      = "1.0.0"
  spec.summary      = "Onboarding feature module."
  spec.description  = "This module provides the onboarding experience for the app, helping users get started with the app's features."
  spec.homepage     = "https://github.com/yourusername/OnboardingModule"
  spec.license      = { :type => "MIT", :file => "LICENSE" }  # Add license type and file location if available
  spec.author       = { "Your Name" => "your.email@example.com" }  # Add author name and email
  spec.platform     = :ios, "14.0"
  spec.swift_version = "5.0"
  
  # Source URL for fetching the pod's code
  spec.source       = { :git => "https://github.com/yourusername/OnboardingModule.git", :tag => "1.0.0" }
  
  # The location of your source files
#  spec.source_files = "Classes/**/*"
  
  # Resources, if any (images, xibs, etc.)
  spec.resources    = "Resources/**/*"  # Optional: Specify resources if they exist
  spec.source_files = 'Modules/CoreModule/**/*.{h,m,swift}'

  # Dependencies, if any (e.g., third-party libraries)
  # spec.dependency 'SomeDependency', '~> 1.0'
  
  # Optional: If you need to support other platforms or additional configurations
  # spec.platforms = { :ios => "14.0", :macos => "10.15" } # Example for multiple platforms
  
end
