# Uncomment the next line to define a global platform for your project
platform :ios, '11.0'

use_frameworks!
inhibit_all_warnings!

target 'MyProject' do

    # Networking
    pod 'Moya/RxSwift'  # https://github.com/Moya/Moya

    # Rx Extensions
    pod 'RxDataSources', '~> 4.0'  # https://github.com/RxSwiftCommunity/RxDataSources
    pod 'RxSwiftExt', '~> 5.0'  # https://github.com/RxSwiftCommunity/RxSwiftExt
    pod 'NSObject+Rx', '~> 5.0'  # https://github.com/RxSwiftCommunity/NSObject-Rx
    pod 'RxViewController', '~> 1.0'  # https://github.com/devxoul/RxViewController
    pod 'RxGesture', '~> 3.0'  # https://github.com/RxSwiftCommunity/RxGesture
    pod 'RxOptional', '~> 4.0'  # https://github.com/RxSwiftCommunity/RxOptional
    pod 'RxTheme', '~> 4.0'  # https://github.com/RxSwiftCommunity/RxTheme
 
    # JSON Mapping
    pod 'Moya-ObjectMapper/RxSwift', '~> 2.0'  # https://github.com/ivanbruel/Moya-ObjectMapper

    # Image
    pod 'Kingfisher', '~> 5.0'  # https://github.com/onevcat/Kingfisher

    # Tools
    pod 'R.swift', '~> 5.0'  # https://github.com/mac-cain13/R.swift

    # Keychain
    pod 'KeychainAccess', '~> 4.0'  # https://github.com/kishikawakatsumi/KeychainAccess

    # UI
    pod 'NVActivityIndicatorView', '~> 4.0'  # https://github.com/ninjaprox/NVActivityIndicatorView
    pod 'DZNEmptyDataSet', '~> 1.0'  # https://github.com/dzenbot/DZNEmptyDataSet
    pod 'Hero', :git => 'https://github.com/HeroTransitions/Hero.git', :branch => 'develop'  # https://github.com/lkzhao/Hero
    pod 'Localize-Swift', '~> 3.0'  # https://github.com/marmelroy/Localize-Swift
    pod 'KafkaRefresh', '~> 1.0'  # https://github.com/OpenFeyn/KafkaRefresh
    pod 'Toast-Swift', '~> 5.0'  # https://github.com/scalessec/Toast-Swift
    pod 'FSPagerView'

    # Auto Layout
    pod 'SnapKit', '~> 5.0'  # https://github.com/SnapKit/SnapKit

    # Code Quality
    pod 'SwifterSwift', '~> 5.0'  # https://github.com/SwifterSwift/SwifterSwift
    
    target 'MyProjectTests' do
        inherit! :search_paths
        # Pods for testing
        pod 'Quick', '~> 2.0'  # https://github.com/Quick/Quick
        pod 'Nimble', '~> 8.0'  # https://github.com/Quick/Nimble
        pod 'RxAtomic', :modular_headers => true
        pod 'RxBlocking'  # https://github.com/ReactiveX/RxSwift
    end
end

target 'MyProjectUITests' do
    inherit! :search_paths
    # Pods for testing
end


post_install do |installer|
    # Cocoapods optimization, always clean project after pod updating
    Dir.glob(installer.sandbox.target_support_files_root + "Pods-*/*.sh").each do |script|
        flag_name = File.basename(script, ".sh") + "-Installation-Flag"
        folder = "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
        file = File.join(folder, flag_name)
        content = File.read(script)
        content.gsub!(/set -e/, "set -e\nKG_FILE=\"#{file}\"\nif [ -f \"$KG_FILE\" ]; then exit 0; fi\nmkdir -p \"#{folder}\"\ntouch \"$KG_FILE\"")
        File.write(script, content)
    end
    
    # Enable tracing resources
    installer.pods_project.targets.each do |target|
      if target.name == 'RxSwift'
        target.build_configurations.each do |config|
          if config.name == 'Debug'
            config.build_settings['OTHER_SWIFT_FLAGS'] ||= ['-D', 'TRACE_RESOURCES']
          end
        end
      end
    end
end
