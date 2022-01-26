#  Cocoapods_Config

升级Ruby环境，首先需要安装rvm
curl -L get.rvm.io | bash -s stable
source ~/.bashrc
source ~/.bash_profile
rvm -v
rvm list known
rvm install 2.6.3
rvm docs generate-ri

开始安装CocoaPods
sudo gem install -n /usr/local/bin cocoapods
安装本地库
pod setup


*/


brew install httpd
brew services start httpd

brew install homebrew/portable-ruby/portable-ruby
brew install ruby

ruby -v
curl -L get.rvm.io | bash -s stable
curl -sSL https://rvm.io/pkuczynski.asc | gpg --import -
rvm list known
//例子
[ruby-]1.8.6[-p420]
[ruby-]1.8.7[-head] # security released on head
[ruby-]1.9.1[-p431]
[ruby-]1.9.2[-p330]
[ruby-]1.9.3[-p551]
[ruby-]2.0.0[-p648]
[ruby-]2.1[.10]
[ruby-]2.2[.10]
[ruby-]2.3[.7]
[ruby-]2.4[.4]
[ruby-]2.5[.1]
.....
[ruby-]2.6[.3]  // 重点在这里 重点在这里 重点在这里
[ruby-]2.7[.0-preview1]   // 测试版
ruby-head
.....

rvm install 2.6.3 —default
rvm docs generate-ri

sudo gem update --system
//在国内需要更换源
gem sources --remove https://rubygems.org/
gem sources --add https://gems.ruby-china.com/

sudo gem install -n /usr/local/bin cocoapods       //开始安装CocoaPods
sudo gem install cocoapods --pre                         //安装最新版cocoapods 升级也用这个

//如果安装了多个Xcode使用下面的命令选择（一般需要选择最近的Xcode版本）
sudo xcode-select -switch /Applications/Xcode.app/Contents/Developer

//安装本地库
pod setup

git clone https://github.com/CocoaPods/Specs.git ~/.cocoapods/repos/trunk



Mac下升级ruby至最新版本

Mac自身的ruby 版本 2.x，通过ruby -v可以查看版本号。
为更新到ruby的最新版本，可通过以下命令解决：
brew update
brew install ruby
执行完命令后，ruby -v后其实还是原来的版本👌，这是因为环境变量没有配置。因此，还有一个步骤就是配置环境变量。

echo 'export PATH="/usr/local/opt/ruby/bin:$PATH"' >> ~/.bash_profile
source ~/.bash_profile
执行后，查看版本后，会判断已更新到最新版本。
