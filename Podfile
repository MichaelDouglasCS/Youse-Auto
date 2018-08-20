platform :ios, '9.0'
use_frameworks!
inhibit_all_warnings!

# Project Pods
def project_pods
    pod 'SwiftLint'
    pod 'SwiftyJSON', '~> 4.0'
    pod 'Alamofire', '~> 4.7'
    pod 'AlamofireImage', '~> 3.3'
end

# Test Pods
def test_pods
  pod 'OHHTTPStubs/Swift'
end

# Targets
target 'Youse-Auto' do
  project_pods
  test_pods

  target 'Youse-AutoTests' do
    inherit! :search_paths
  end

  target 'Youse-AutoUITests' do
    inherit! :search_paths
  end
  
end
