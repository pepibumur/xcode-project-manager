platform :osx, '10.12'

target 'XcodePM' do

  use_frameworks!

  pod "xcproj", "~> 1.2"
  pod 'RxSwift',    '~> 4.0'
  pod 'RxCocoa',    '~> 4.0'
  pod 'Sparkle'
  pod 'macOSThemeKit', '~> 1.1.0'

  target "XcodePMTests" do
    inherit! :search_paths
    pod 'Sparkle'
  end

end
