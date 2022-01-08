#  <#Title#>

#文档来源链接：


#卸载Cocoapods
彻底删除cocoapods{

    // 移除本地master
    sudo rm -fr ~/.cocoapods/repos/master
    // 移除本地缓存
    sudo rm -fr ~/Library/Caches/CocoaPods/
    // 重新setup，如果很慢可使用问题1的解决方法（git clone）
    pod setup --verbose
    // 移除trunk
    pod repo remove trunk

    //彻底删除cocoapods
    /*
    完整的三步操作实例如下
    #罗列依赖库
    $ gem list --local | grep cocoapods
    cocoapods (1.0.1)
    cocoapods-core (1.0.1, 0.39.0)
    cocoapods-deintegrate (1.0.0)
    cocoapods-downloader (1.0.0, 0.9.3)
    cocoapods-plugins (1.0.0, 0.4.2)
    cocoapods-search (1.0.0, 0.1.0)
    cocoapods-stats (1.0.0, 0.6.2)
    cocoapods-trunk (1.0.0, 0.6.4)
    cocoapods-try (1.0.0, 0.5.1)

    #遍历删除依赖库
    $ for i in $( gem list --local --no-version | grep cocoapods );
    do
       sudo   gem uninstall $i;
    done

    Password:
    Remove executables:
    pod, sandbox-pod

    in addition to the gem? [Yn]  y

    等等

    #进一步彻底删除文件夹
    $ rm -rf ~/.cocoapods/
}

#安装Cocoapods
——————  rvm是一个命令行工具，它允许您轻松地安装，管理和使用从解释器到多组宝石的多个ruby环境   ——————
安装rvm{

    brew install gnupg   // Mac OS X不附带gpg，因此在安装公钥之前，您需要安装gpg
    gpg --keyserver hkp://pgp.mit.edu --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB  // 安装完gpg之后，你可以安装mpapis公钥：//!!!

    // 安装最新版本的Ruby的RVM
    curl -L get.rvm.io | bash -s stable 或者 curl -sSL https://get.rvm.io | bash -s stable --ruby
    source ~/.bashrc
    source ~/.bash_profile
    rvm -v
    rvm list known //列出可供RVM使用的ruby版本
    rvm install 2.7.0(浮动值)
    rvm docs generate-ri
    
    ### 使用 rvm & ruby
    source /Users/sino/.rvm/scripts/rvm   //切换rvm
}

卸载 rvm{
    卸载 rvm_Ruby 方式：终端键入 $ rvm implode
    为了保险起见还需要执行(自己的Users目录中删除)下面的命令
    $ cd ~ ; sudo rm -rf .rvm .rvmrc/etc/rvmrc;gem uninstall rvm
    (同样在自己的Users目录中删除)
    最后不要忘记了注释.bashrc 或者.bash_profile 或者 .profile 中的相关语句
    #[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM function
    到此成功删除了rvm
}

——————  升级ruby环境，首先需要安装RVM  ——————
使用ruby原因{
    虽然 macOS 自带了一个 ruby 环境，但是是系统自己使用的，所以权限很小，只有 system。而/Library 目录是 root 权限,所以很多会提示无权限。
    使用自带ruby更新,管理不方便
    一系列无原因的报错
}

安装ruby{
    Mac安装ruby版本管理器RVM
    https://vic.kim/2019/05/21/Mac%E5%AE%89%E8%A3%85Ruby%E7%89%88%E6%9C%AC%E7%AE%A1%E7%90%86%E5%99%A8RVM/
}

升级ruby{
    Mac下升级ruby至最新版本
    Mac上更新ruby https://juejin.im/post/6844903535130198024
    
    Mac自身的ruby 版本 2.x，
    通过ruby -v可以查看版本号。
    为了更新到ruby的最新版本，可通过以下命令解决：
    brew update
    brew install ruby
    执行完命令后 ruby -v 后其实还是原来的版本，这是因为环境变量没有配置。因此，还有一个步骤就是配置环境变量。
    echo 'export PATH="/usr/local/opt/ruby/bin:$PATH"' >> ~/.bash_profile
    source ~/.bash_profile
    执行后，查看版本后，会判断已更新到最新版本。
}

安装CocoaPods{
    // 开始安装CocoaPods
    sudo gem install -n /usr/local/bin cocoapods
    // 安装最新版cocoapods
    sudo gem install cocoapods --pre  <——————这句升级 可以不用--pre
    // 安装本地库
    pod setup
    //如果安装了多个Xcode使用下面的命令选择（一般需要选择最近的Xcode版本）
    sudo xcode-select -switch /Applications/Xcode.app/Contents/Developer
}

gem{
    sudo gem update --system
    //在国内需要更换源
    gem sources --remove https://rubygems.org/
    gem sources --add https://gems.ruby-china.com/
}

Cocoapods-Pod仓库dependency反向依赖查询{ //https://blog.csdn.net/xiaofei125145/article/details/80642945
    安装 gem gem install reversepoddependency
    执行如下命令得到结果
    specbackwarddependency 本地repo路径 pod名称
    //例如：specbackwarddependency ~/.cocoapods/repos/master AFNetworking
}

升级本地cocoapods库{
    pod repo update
}

pod repo update --verbose
pod update   --no-repo-update
