Pod::Spec.new do |spec|
  spec.name         = "SelectViewController"
  spec.version      = "1.0.0"
  spec.summary      = "Simple items selection control"
  spec.description  = <<-DESC
  Simple items selection control
                   DESC

  spec.homepage = "https://github.com/alon22/SelectViewController"
  spec.license = "MIT"
  spec.author = { "ruben" => "ralonso022@gmail.com" }
  spec.source = { :git => "https://github.com/alon22/SelectViewController.git", :tag => "#{spec.version}" }
  spec.source_files = "Sources", "Sources/**/*.{h,m,swift}"

  spec.ios.deployment_target = '11.0'

  spec.swift_versions = ['5.1', '5.2', '5.3']
end
