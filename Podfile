# Uncomment the next line to define a global platform for your project
# platform :ios, '13.0'

target 'ApiGitHubApp' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  pod 'Alamofire'

  # Pods for ApiGitHubApp

  target 'ApiGitHubAppTests' do
    inherit! :search_paths
    pod 'OHHTTPStubs'
    # Pods for testing
  end

  target 'ApiGitHubAppUITests' do
    # Pods for testing
  end

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.resources_build_phase.files.each do |file|
      if file.file_ref && file.file_ref.path.include?("Alamofire.bundle")
        target.resources_build_phase.remove_build_file(file)
      end
    end
  end
end