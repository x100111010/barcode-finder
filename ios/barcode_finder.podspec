#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint barcode_finder.podspec' to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'barcode_finder'
  s.version          = '0.0.2'
  s.summary          = 'Barcode Finder is a plugin for reading barcodes and QRCodes from pdf files and images using ML kit for Android and iOS.'
  s.description      = <<-DESC
A new flutter plugin project.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '12.0'
  s.static_framework = true
  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
  s.dependency 'GoogleMLKit/BarcodeScanning', '~> 6.0.0'
  s.dependency 'ATBarSDK', '~> 1.4.1'
  s.dependency 'ZXingObjC', '~> 3.6.9'
end
