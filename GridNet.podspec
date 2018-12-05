Pod::Spec.new do |s|
  s.name         = 'GridNet'
  s.module_name  = 'Grid'
  s.version      = '0.1.12'
  s.summary      = 'A simple and clean Swift network wrapper'

  s.description      = <<-DESC
  TODO: Add long description of the pod here.
                       DESC
  s.homepage     = 'https://github.com/rcarvalhosilva/Grid'
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author        = { 'Rodrigo Carvalho' => 'rcdasilva94@gmail.com' }
  s.platform     = :ios
  s.ios.deployment_target = '9.0'
  s.source       = { :git => 'https://github.com/rcarvalhosilva/Grid.git', :tag => s.version }
  s.swift_version = '4.2'

  s.subspec 'Core' do |ss|
    ss.source_files = 'Grid/Sources/**/*'
  end

  s.subspec 'URLSession' do |ss|
    ss.dependency 'GridNet/Core'
    ss.source_files = 'Grid/URLSession/**/*'
  end
end
