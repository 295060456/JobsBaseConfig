#  Oh-my-zsh_Config

#文档来源链接：
    https://segmentfault.com/a/1190000013612471

安装 oh-my-zsh{

    # 1、打开 iTerm2
    # 2、 通过 git 下载：
    git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
    # 3、 复制创建~/.zshrc配置文件：
    cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
    # 4、bash 切换成 zsh ：
    chsh -s /bin/zsh
    # 5、按照提醒输入密码，完全退出iTerm2
    # 6、配置zsh  ~/.zshrc
    加入 source ./.bash_profile 保存环境配置
    # 7、zsh主题 查看 ls ~/.oh-my-zsh/themes   修改zsh主题 编辑~/.zshrc文件，将ZSH_THEME="candy",即将主题修改为candy

}
