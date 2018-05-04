# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Example' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Example
  pod 'FoldingCell', '3.0.3'
  pod 'EasyPeasy', '1.6.0'
  pod 'Siesta', '~> 1.0'
  pod 'Iconic', :git => 'https://github.com/dzenbot/Iconic.git', :tag => '1.3'
  
  post_install do |installer|
      installer.pods_project.targets.each do |target|
          if ['Iconic'].include? target.name
              target.build_configurations.each do |config|
                  config.build_settings['SWIFT_VERSION'] = '3.2'
              end
          end
      end
  end
  target 'ExampleTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'ExampleUITests' do
    inherit! :search_paths
    # Pods for testing
  end
  

end
