Pod::Spec.new do |s|
  s.name						= "VinXML"
  s.version						= "0.0.4"
  s.summary						= "Swift bindings for libxml2"
  s.homepage					= "https://github.com/vincode-io/VinXML"
  s.license						= "MIT"
  s.author						= "Maurice C. Parker"
  s.osx.deployment_target		= "10.10"
  s.ios.deployment_target		= "9.0"
  s.source						= { :git => "https://github.com/vincode-io/VinXML.git",
									:tag => "v" + s.version.to_s }
  s.source_files				= "Sources/**/*.swift"
  s.requires_arc				= true
  s.module_name					= "VinXML"
  s.libraries 					= ['xml2.2']
  s.xcconfig      = {
                      'HEADER_SEARCH_PATHS' => '$(SDKROOT)/usr/include/libxml2'
                    }

end
