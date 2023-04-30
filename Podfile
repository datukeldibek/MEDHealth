# Uncomment the next line to define a global platform for your project
# platform :ios, '16.0'

# ignore all warnings from all pods
inhibit_all_warnings!


target 'MEDHealth' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for MEDCheck
pod 'JGProgressHUD'
pod 'ReachabilitySwift'
pod 'NotificationBannerSwift', '~> 3.0.0'

pod 'FirebaseAnalytics'
pod 'FirebaseAuth'
pod 'FirebaseFirestore'
pod 'FirebaseAuth'

pod 'FirebaseDatabase'
pod 'FirebaseStorage'

pod 'Kingfisher'

pod 'MessageKit'

  post_install do |installer|
      installer.generated_projects.each do |project|
          project.targets.each do |target|
              target.build_configurations.each do |config|
                  config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '16.0'
              end
          end
      end
  end

end
