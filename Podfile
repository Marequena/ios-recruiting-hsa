# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.0'
target 'MiguelRequena' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for
  pod 'Alamofire'
  pod 'CodableAlamofire'
end

# Workaround for Cocoapods issue #7606
post_install do |installer|
   installer.pods_project.build_configurations.each do |config|
       config.build_settings.delete(‘CODE_SIGNING_ALLOWED’)
       config.build_settings.delete(‘CODE_SIGNING_REQUIRED’)
   end
end
