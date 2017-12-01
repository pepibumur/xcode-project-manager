platform :osx, '10.12'

target 'XcodePM' do

  use_frameworks!

  pod "xcproj", "~> 1.2"
  pod 'RxCocoa',    '~> 4.0'
  pod 'macOSThemeKit', '~> 1.1.0'
  pod 'RxSwift',    '~> 4.0'
  pod 'Sentry', :git => 'https://github.com/getsentry/sentry-cocoa.git', :tag => '3.9.1'
  pod 'Toml', :git => 'https://github.com/pepibumur/swift-toml.git'

  target "XcodePMTests" do
    inherit! :search_paths
  end

end
