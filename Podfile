platform :osx, '10.12'

target 'XcodePM' do

  use_frameworks!

  pod "xcproj", "~> 1.2"
  pod 'RxSwift',    '~> 4.0'
  pod 'RxCocoa',    '~> 4.0'
  pod 'Sparkle'

  target "XcodePMTests" do
    inherit! :search_paths
    pod 'Sparkle'
  end

end
