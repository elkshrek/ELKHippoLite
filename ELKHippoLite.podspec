
Pod::Spec.new do |spec|

  spec.name         = "ELKHippoLite"
  spec.version      = "2.0.1"
  spec.summary      = "ELKHippoLite"
  spec.description  = <<-DESC
                    ELKHippoLite:基础控件库
                   DESC

  spec.homepage     = "https://github.com/elkshrek/ELKHippoLite"
  spec.license      = "MIT"
  spec.author       = { "Jonathan" => "Jonathan_dk@163.com" }
  spec.platform     = :ios, '9.0'
  spec.requires_arc = true

  spec.source       = { :git => "https://github.com/elkshrek/ELKHippoLite.git", :tag => "#{spec.version}" }
  
  spec.source_files = 'ELKHippoLite/ELKHippoLite.h'
  spec.public_header_files = 'ELKHippoLite/ELKHippoLite.h'
  
  # 基础宏定义
  spec.subspec 'ELKMacroLite' do |mlspec|
      mlspec.source_files = 'ELKHippoLite/ELKMacroLite/**/*.{h,m}'
      mlspec.public_header_files = 'ELKHippoLite/ELKMacroLite/**/*.h'
      
      mlspec.ios.frameworks = 'Foundation', 'UIKit'
  end
  
  # 基础分类|工具
  spec.subspec 'ELKMantleLite' do |mtspec|
      mtspec.ios.frameworks = 'Foundation', 'UIKit', 'SystemConfiguration'
      mtspec.libraries   = 'c++', 'z'
      
      mtspec.dependency 'Masonry'
      
      mtspec.source_files = 'ELKHippoLite/ELKMantleLite/**/*.{h,m}'
      mtspec.public_header_files = 'ELKHippoLite/ELKMantleLite/**/*.h'
  end
  
  # 通讯录管理
  spec.subspec 'ELKContactManager' do |ctspec|
      ctspec.ios.frameworks = 'Foundation', 'UIKit', 'Contacts'
      
      ctspec.source_files = 'ELKHippoLite/ELKContactManager/**/*.{h,m}'
      ctspec.public_header_files = 'ELKHippoLite/ELKContactManager/**/*.h'
  end
  
  # 网络
  spec.subspec 'ELKNetworking' do |netspec|
      netspec.ios.frameworks = 'Foundation', 'UIKit', 'AVKit', 'SystemConfiguration', 'CoreTelephony'
      netspec.libraries   = 'resolv', 'c++', 'z'
  
      netspec.dependency 'ELKHippoLite/ELKMacroLite'
      netspec.dependency 'AFNetworking'
      netspec.dependency 'GTMBase64'
      
      netspec.source_files = 'ELKHippoLite/ELKNetworking/**/*.{h,m}'
      netspec.public_header_files = 'ELKHippoLite/ELKNetworking/**/*.h'
  end
  
  # EasyTimer
  spec.subspec 'ELKEasyTimer' do |ctspec|
      ctspec.ios.frameworks = 'Foundation', 'UIKit'
      
      ctspec.source_files = 'ELKHippoLite/ELKEasyTimer/**/*.{h,m}'
      ctspec.public_header_files = 'ELKHippoLite/ELKEasyTimer/**/*.h'
  end
   
   
end
