Pod::Spec.new do |spec|
  spec.name         = 'AppleFoundationExtensions'
  spec.version      = '1.0'
  spec.license      = { :type => 'MIT' }
  spec.homepage     = 'https://github.com/yuriisamoienko/AppleFoundationExtensions'
  spec.authors      = { 'Yurii Samoienko' => 'yurii.samoienko@gmail.com' }
  spec.summary      = 'Extensions, utils, base classes etc. which I\'d like to have in Foundation framework by default'
  spec.source       = { :git => 'https://github.com/yuriisamoienko/AppleFoundationExtensions.git' }
  spec.source_files = 'Sources/*'
  spec.framework    = 'FoundationExtensions'

  spec.ios.deployment_target = '10.0'
  spec.swift_version = '5.6'
end