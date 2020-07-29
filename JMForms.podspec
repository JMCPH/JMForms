#
# Be sure to run `pod lib lint JMForms.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'JMForms'
  s.version          = '0.1.3'
  s.summary          = 'A simple form-builder written in Swift 5.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  JMForms is a simple form-builder that makes it easy and fast to add a form within your app.
                       DESC

  s.homepage         = 'https://github.com/JMCPH/JMForms'
  # s.screenshots     = 'https://github.com/JMCPH/JMForms/blob/master/Screenshots/screenshot1.png'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Jakob Mikkelsen' => 'jpm@codement.dk' }
  s.source           = { :git => 'https://github.com/JMCPH/JMForms.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '12.0'
  s.swift_version = ['5.0', '5.1', '5.2']
  s.platform = :ios

  s.source_files = 'JMForms/Classes/**/*'
  
  # s.resource_bundles = {
  #   'JMForms' => ['JMForms/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
