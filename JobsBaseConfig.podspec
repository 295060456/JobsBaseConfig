Pod::Spec.new do |spec|
  # 框架名字：框架名字一定要写对，pod search "框架名"就是搜的这个
  spec.name         = "JobsBaseConfig"
  spec.version      = "0.0.1"
  spec.summary      = "基础的配置"
  spec.description  = <<-DESC
          所有的项目根据这个根来进行统一配置和调用
          做到全局的一致和统一 
          千万要保证这个工程的编译通过，以后项目直接进行引用
                   DESC
  spec.homepage     = "https://github.com/295060456/JobsBaseConfig"
  
  # 框架遵守的开源协议
  spec.license      = {:type => 'MIT', :file => 'LICENSE'}
  # 作者信息
  spec.author             = {"Jobs" => "lg295060456@gmail.com"}
  spec.social_media_url   = "https://github.com/295060456"

  spec.ios.deployment_target = "10.0"
  # 框架支持的最低平台版本
  spec.platform     = :ios, '7.0'
  # 框架是否需要支持ARC
  spec.requires_arc = true
  # 框架公开的头文件
  spec.public_header_files = 'yoowei/**/*.h'   

  # 框架的资源路径：路径可以指向远端代码库，也可以指向本地项目，例如：
  ## 1、指向Git远端代码库：spec.source = {:git => "git@git.oschina.net:yoowei/yoowei.git", :tag => "1.0.0"}
  ## 2、指向本地项目：spec.source = {:path => 'yoowei',}
  ## 3、本地文件 spec.source = {:git => '~/Desktop/ChartboostSDK'}    
  ## 4、zip：spec.source = {:http=> 'http://xxx.zip', :tag => "1.0.0"}
  ## 5、svn：spec.source = {:svn=> 'http://path', :tag => "1.0.0"}

  # spec.source       = {:git => "https://github.com/295060456/JobsBaseConfig.git",:tag => "#{spec.version}",:commit => "a3320f5dde48bd21512f3b4410b0c9f5c6f119e2"}
  spec.source = {:path => 'JobsBaseConfig',:tag => "#{spec.version}"}
  spec.source_files  = "Classes", "Classes/**/*.{h,m}"
  spec.exclude_files = "Classes/Exclude"

  spec.user_target_xcconfig = {'CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES' => 'YES'}
  # 框架依赖的framework
  spec.frameworks   = 'UIKit','Foundation'
  # 框架依赖的其他第三方库
  spec.dependency 'SDWebImage' # "~> 1.4"
  spec.dependency 'XYColorOC'
  spec.dependency 'IQKeyboardManager'
  spec.dependency 'Masonry'
  spec.dependency 'AFNetworking'
  spec.dependency 'Reachability'
  spec.dependency 'ReactiveObjC'
  spec.dependency 'MJRefresh'
  spec.dependency 'MJExtension'
  spec.dependency 'YQImageTool'
  spec.dependency 'OpenUDID'
  spec.dependency 'TABAnimated'
  spec.dependency 'GKNavigationBar'
  spec.dependency 'GKPhotoBrowser'
  spec.dependency 'JXCategoryView'
  spec.dependency 'JXPagingView/Pager'
  spec.dependency 'SPAlertController'
  spec.dependency 'TFPopup'
  spec.dependency 'ZMJGanttChart'
  spec.dependency 'LMJDropdownMenu'
  spec.dependency 'WMZBanner'
  spec.dependency 'MGSwipeTableCell'
  spec.dependency 'Shimmer'
  spec.dependency 'RQShineLabel'
  spec.dependency 'SZTextView'
  spec.dependency 'BRPickerView'
  spec.dependency 'LYEmptyView'
  spec.dependency 'FLAnimatedImageView+RGWrapper'
  spec.dependency 'PPBadgeView'
  spec.dependency 'WHToast'
  spec.dependency 'BEMCheckBox'
  spec.dependency 'YYImage'
  spec.dependency 'pop'
  spec.dependency 'ZFPlayer'
  spec.dependency 'ZFPlayer/ControlView'
  spec.dependency 'ZFPlayer/AVPlayer'
  spec.dependency 'ZFPlayer/ijkplayer'
  spec.dependency 'NTESVerifyCode'
  spec.dependency 'TXFileOperation'
  spec.dependency 'HXPhotoPicker'
  spec.dependency 'BMLongPressDragCellCollectionView'
  spec.dependency 'JPImageresizerView'
  spec.dependency 'lottie-ios' "~> 2.5.3"# 这是OC终极版本
  spec.dependency 'AYCheckVersion'
  # spec.dependency 'WCDB'
  # spec.dependency 'FMDB'

  # spec.libraries = "iconv", "xml2"
  # spec.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"
  # spec.resources = "Resources/*.png"
  # spec.preserve_paths = "FilesToSave", "MoreFilesToSave" # 需要保留的文件路径
  # spec.vendored_libraries # 对外提供的.a。在打成.a库时有用

end
