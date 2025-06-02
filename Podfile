platform :ios, '13.0'

target 'FlaschcardsSwiftUI' do
  # Закомментируйте use_frameworks! для статических библиотек
  # use_frameworks!
  
  pod 'AlertToast'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
    end
  end
end
