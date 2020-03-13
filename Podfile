# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

# Comment the next line if you don't want to use dynamic frameworks
use_frameworks!

def common_pods
  pod 'Firebase/Auth'
  pod 'Firebase/Firestore'
  pod 'Firebase/Storage'
  pod 'Firebase/Analytics'
  pod 'GoogleSignIn', '~> 5.0'
  pod 'MongoSwift', '~>0.1.0'
  pod 'FBSDKCoreKit'
  pod 'FBSDKShareKit'
  pod 'FBSDKLoginKit'
  pod 'Quick'
  pod 'Nimble'
  pod 'Nimble-Snapshots'
end

target 'Feather' do
  common_pods
end
  
target 'FeatherTests' do
    inherit! :search_paths
    # Pods for testing
    common_pods
    pod 'Cucumberish'
end

