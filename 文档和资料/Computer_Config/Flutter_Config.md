#  Flutter_Config

*配置Flutter
git clone -b master https://github.com/flutter/flutter.git
./flutter/bin/flutter --version
安装Flutter SDK，配置环境变量，Windows系统直接运行批处理，Mac系统需要自己配；直到运行Flutter doctor 命令成功为止
必须安装Android Studio
官网下载Flutter的SDK集成进Android Studio
open -a Stimulator 自动关联Xcode模拟器
------直到程序首页出现 Start a new Fltter project 为止
preferance --> plugins --> Dart/flutter/...

直接拖动项目到欢迎页也可以打开

安装到iOS设备
要将您的Flutter应用安装到iOS真机设备，您需要一些额外的工具和一个Apple帐户，您还需要在Xcode中进行设置。
安装 homebrew （如果已经安装了brew,跳过此步骤）.
打开终端并运行这些命令来安装用于将Flutter应用安装到iOS设备的工具
brew update
brew install --HEAD libimobiledevice
brew install ideviceinstaller ios-deploy cocoapods
pod setup
如果这些命令中的任何一个失败并出现错误，请运行brew doctor并按照说明解决问题.
