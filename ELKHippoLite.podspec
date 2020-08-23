
Pod::Spec.new do |spec|

  spec.name         = "ELKHippoLite"
  spec.version      = "1.0.0"
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
  
  # 基础控件捷径
  spec.subspec 'ELKMantleShortCut' do |shtspec|
      shtspec.ios.frameworks = 'Foundation', 'UIKit', 'SystemConfiguration'
      shtspec.libraries   = 'c++', 'z'
      
      shtspec.dependency 'Masonry'
      
      shtspec.source_files = 'ELKHippoLite/ELKMantleShortCut/**/*.{h,m}'
      shtspec.public_header_files = 'ELKHippoLite/ELKMantleShortCut/**/*.h'
  end
  
  # 通讯录管理
  spec.subspec 'ELKContactManager' do |ctspec|
      ctspec.ios.frameworks = 'Foundation', 'UIKit', 'Contacts'
      
      ctspec.source_files = 'ELKHippoLite/ELKContactManager/**/*.{h,m}'
      ctspec.public_header_files = 'ELKHippoLite/ELKContactManager/**/*.h'
  end
  
  # 网络请求
#  spec.subspec 'ELKNetworking' do |netspec|
#      netspec.ios.frameworks = 'Foundation', 'UIKit', 'AVKit', 'SystemConfiguration', 'CoreTelephony'
#      netspec.libraries   = 'resolv', 'c++', 'z'
  
#      netspec.dependency 'ELKHippoLite/ELKMacroLite'
#      netspec.dependency 'AFNetworking'
#      netspec.dependency 'GTMBase64'
#      netspec.dependency 'AliyunOSSiOS'
#      netspec.dependency 'SVProgressHUD'
#      netspec.dependency 'MJExtension'
      
#      netspec.source_files = 'ELKHippoLite/ELKNetworking/**/*.{h,m}'
#      netspec.public_header_files = 'ELKHippoLite/ELKNetworking/**/*.h'
#  end
  
  # EasyTimer
  spec.subspec 'ELKEasyTimer' do |ctspec|
      ctspec.ios.frameworks = 'Foundation', 'UIKit'
      
      ctspec.source_files = 'ELKHippoLite/ELKEasyTimer/**/*.{h,m}'
      ctspec.public_header_files = 'ELKHippoLite/ELKEasyTimer/**/*.h'
  end
  
  # tableView数据源
   spec.subspec 'ELKDataSource' do |dtsspec|
       dtsspec.ios.frameworks = 'Foundation', 'UIKit'
       dtsspec.dependency 'MJRefresh'
       dtsspec.source_files = 'ELKHippoLite/ELKDataSource/**/*.{h,m}'
       dtsspec.public_header_files = 'ELKHippoLite/ELKDataSource/**/*.h'
   end
  # 输入框
   spec.subspec 'ELKInputTextField' do |ipttextspec|
       ipttextspec.ios.frameworks = 'Foundation', 'UIKit'
       ipttextspec.dependency 'Masonry'
       ipttextspec.dependency 'ELKHippoLite/ELKMantleShortCut'
       ipttextspec.source_files = 'ELKHippoLite/ELKInputTextField/**/*.{h,m}'
       ipttextspec.public_header_files = 'ELKHippoLite/ELKInputTextField/**/*.h'
   end
   
   # ELKCustomFlowLayout
   spec.subspec 'ELKCustomFlowLayout' do |flayoutspec|
       flayoutspec.ios.frameworks = 'Foundation', 'UIKit'
       flayoutspec.source_files = 'ELKHippoLite/ELKCustomFlowLayout/**/*.{h,m}'
       flayoutspec.public_header_files = 'ELKHippoLite/ELKCustomFlowLayout/**/*.h'
   end
   
   
end
