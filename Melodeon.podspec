#
# Be sure to run `pod lib lint Melodeon.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Melodeon'
  s.version          = '0.1.0'
  s.summary          = 'A table view which behaves like a melodeon.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'A subclassable of table view controller which behaves like a melodeon, subclassed from UITableViewController.'

  s.homepage         = 'https://github.com/chaddgrimm/Melodeon'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'chaddgrimm' => 'chaddgrimm@gmail.com' }
  s.source           = { :git => 'https://github.com/chaddgrimm/Melodeon.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/chaddgrimm'

  s.ios.deployment_target = '9.0'

  s.source_files = 'Melodeon/Classes/**/*'
  
  # s.resource_bundles = {
  #   'Melodeon' => ['Melodeon/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
