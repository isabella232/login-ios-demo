platform :ios, '11.4'
use_frameworks!
inhibit_all_warnings!

target 'XsollaLoginDemo' do

  pod 'XsollaSDKLoginKit'

  pod 'SwiftLint'
  pod 'SwiftGen'

  pod 'MaterialComponents/Tabs+TabBarView'
  pod 'MaterialComponents/Tabs+TabBarViewTheming'

  pod 'MaterialComponents/TextFields'

  pod 'MaterialComponents/Buttons'
  pod 'MaterialComponents/Buttons+Theming'

  pod 'MaterialComponents/BottomSheet'

  pod 'PromisesSwift'
  pod 'SDWebImage'
  pod 'IQKeyboardManager'

end

post_install do |pi|
    pi.pods_project.targets.each do |t|
      t.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '11.4'
      end
    end
end
