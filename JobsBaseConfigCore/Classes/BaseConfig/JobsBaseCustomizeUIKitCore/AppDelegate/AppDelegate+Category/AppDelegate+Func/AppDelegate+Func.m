//
//  AppDelegate+Func.m
//  UBallLive
//
//  Created by Jobs on 2020/10/11.
//

#import "AppDelegate+Func.h"

@implementation AppDelegate (Func)

-(void)reachabilityChanged:(NSNotification *)notify{}

#pragma mark —— 启动调用功能
+(void)launchFunc1{
    XHLaunchAd *ad = [XHLaunchAd setWaitDataDuration:10];
    SceneDelegate *sceneDelegate = getSysSceneDelegate();
    [ad scene:sceneDelegate.windowScene];
    
//    AppDelegate *appDelegate = getSysAppDelegate();
//    [appDelegate guide];// 未完成
}

-(void)launchFunc2{
    [UIApplication.sharedApplication setIdleTimerDisabled:NO];//保持屏幕常亮
    /*
     * 禁止App系统文件夹document同步
     * 苹果要求：可重复产生的数据不得进行同步,什么叫做可重复数据？这里最好禁止，否则会影响上架，被拒！
     */
    [FileFolderHandleTool banSysDocSynchronization];
#ifdef DEBUG
    [UIFont getAvailableFont];//打印全员字体
#endif
    [self makeTABAnimatedConfigure];
    [self makeIQKeyboardManagerConfigure];
    [self makeGKNavigationBarConfigure];//自定义导航栏
    [self makeXHLaunchAdConfigure];//开屏广告
    [self makeReachabilityConfigure];//网络环境监测
}
#pragma mark —— 欢迎引导页面
-(void)guide{
    if (self.isAppFirstLaunch) {
        self.window.rootViewController = JobsWelcomeVC.new;
    }else{
        self.window.rootViewController = self.tabBarVC;
    }
}
#pragma mark —— 存取用户信息Demo
-(void)saveAndReadUserInfoDemo{
    DDUserModel *userModel = DDUserModel.new;
    userModel.token = @"12345";
    userModel.uid = @"54321";
    
    [self saveUserInfo:userModel];
    NSLog(@"");
    DDUserModel *f = [self readUserInfo];
    NSLog(@"");
}
#pragma mark —— 读取Plist配置文件
-(void)readPlistConfig{
    static dispatch_once_t readPlistConfigDispatchOnce;
    dispatch_once(&readPlistConfigDispatchOnce, ^{
        id plistConfig = [self readLocalPlistWithFileName:@"MetaData"];
        NSLog(@"plistConfig = %@",plistConfig);
    });
}
#pragma mark —— 全局配置 TABAnimated
-(void)makeTABAnimatedConfigure{
    [TABAnimated.sharedAnimated initWithOnlySkeleton];
    TABAnimated.sharedAnimated.openLog = YES;
}
#pragma mark —— 全局配置键盘
-(void)makeIQKeyboardManagerConfigure{
    IQKeyboardManager *keyboardManager = IQKeyboardManager.sharedManager; // 获取类库的单例变量
    keyboardManager.enable = YES; // 控制整个功能是否启用
    keyboardManager.shouldResignOnTouchOutside = YES; // 启用手势触摸:控制点击背景是否收起键盘
    keyboardManager.shouldToolbarUsesTextFieldTintColor = YES; // 控制键盘上的工具条文字颜色是否用户自定义,(使用TextField的tintColor属性IQToolbar，否则色调的颜色是黑色 )
    keyboardManager.toolbarManageBehaviour = IQAutoToolbarBySubviews; // 有多个输入框时，可以通过点击Toolbar 上的“前一个”“后一个”按钮来实现移动到不同的输入框
    keyboardManager.enableAutoToolbar = NO; // 控制是否显示键盘上的工具条,当需要支持内联编辑(Inline Editing), 这就需要隐藏键盘上的工具条(默认打开)
    keyboardManager.shouldShowToolbarPlaceholder = YES; // 是否显示占位文字
    keyboardManager.placeholderFont = [UIFont boldSystemFontOfSize:17]; // 设置占位文字的字体
    keyboardManager.keyboardDistanceFromTextField = 10.0f; // 输入框距离键盘的距离
}
#pragma mark —— 全局配置GKNavigationBar
-(void)makeGKNavigationBarConfigure{
    [GKConfigure setupCustomConfigure:^(GKNavigationBarConfigure * _Nonnull configure) {
        // 导航栏背景色
        configure.backgroundColor = kClearColor;
        // 导航栏标题颜色
        configure.titleColor = kWhiteColor;
        // 导航栏标题字体
        configure.titleFont = [UIFont systemFontOfSize:JobsWidth(16.0f) weight:UIFontWeightRegular];
        // 导航栏返回按钮样式
        configure.backStyle = GKNavigationBarBackStyleBlack;
        // 导航栏左右item间距
        configure.gk_navItemLeftSpace = 12.0f;
        configure.gk_navItemRightSpace = 12.0f;
        
        configure.shiledItemSpaceVCs = @[@"PUPhotoPickerHostViewController"];
    }];
}
#pragma mark —— 网络环境监测
-(void)makeReachabilityConfigure{
    // Allocate a reachability object
    Reachability *reach = [Reachability reachabilityWithHostname:@"www.google.com"];
    // Tell the reachability that we DON'T want to be reachable on 3G/EDGE/CDMA
    reach.reachableOnWWAN = NO;
    // Here we set up a NSNotification observer. The Reachability that caused the notification
    // is passed in the object parameter
    [NSNotificationCenter.defaultCenter addObserver:self
                                           selector:@selector(reachabilityChanged:)
                                               name:kReachabilityChangedNotification
                                             object:nil];
    [reach startNotifier];
    dispatch_async(dispatch_get_main_queue(), ^{
         [NSNotificationCenter.defaultCenter postNotificationName:kReachabilityChangedNotification
                                                           object:self];
     });
}
#pragma mark —— 开屏广告
-(void)makeXHLaunchAdConfigure{
    
//    [self launchAd_localPic_default];//图 - 本地 - 默认
//    [self launchAd_localPic_custom];//图 - 本地 - 自定义
//    [self launchAd_networkDataPic_default];//图 - 网络 - 默认
//    [self launchAd_networkDataPic_custom];//图 - 网络 - 自定义
//    [self launchAd_localVedio_default];//视频 - 本地 - 默认
    [self launchAd_localVedio_custom];//视频 - 本地 - 自定义
//    [self launchAd_networkVedio_default];//视频 - 网络 - 默认
//    [self launchAd_networkVedio_custom];//视频 - 网络 - 自定义
}
#pragma mark —— 配置开屏广告
//图 - 本地 - 默认
-(void)launchAd_localPic_default{
    //1.使用默认配置初始化
    //设置你工程的启动页使用的是:LaunchImage 还是 LaunchScreen.storyboard(不设置默认:LaunchImage)
    [XHLaunchAd setLaunchSourceType:SourceTypeLaunchScreen];

    //配置广告数据
    XHLaunchImageAdConfiguration *imageAdconfiguration = [XHLaunchImageAdConfiguration defaultConfiguration];
    //广告图片URLString/或本地图片名(.jpg/.gif/.png请带上后缀)
    imageAdconfiguration.imageNameOrURLString = @"启动页SLOGAN.png";
     //广告点击打开页面参数(openModel可为NSString,模型,字典等任意类型)
    imageAdconfiguration.openModel = @"http://www.it7090.com";
    //显示图片开屏广告
    [XHLaunchAd imageAdWithImageAdConfiguration:imageAdconfiguration delegate:self];
}
//图 - 本地 - 自定义
-(void)launchAd_localPic_custom{
    //2.自定义配置初始化
    //设置你工程的启动页使用的是:LaunchImage 还是 LaunchScreen.storyboard(不设置默认:LaunchImage)
    [XHLaunchAd setLaunchSourceType:SourceTypeLaunchImage];
    //配置广告数据
    XHLaunchImageAdConfiguration *imageAdconfiguration = [XHLaunchImageAdConfiguration new];
    //广告停留时间
    imageAdconfiguration.duration = 5;
    //广告frame
    imageAdconfiguration.frame = CGRectMake(0,
                                            0,
                                            [UIScreen mainScreen].bounds.size.width,
                                            [UIScreen mainScreen].bounds.size.height - 150);
    //广告图片URLString/或本地图片名(.jpg/.gif请带上后缀)
    imageAdconfiguration.imageNameOrURLString = @"启动页SLOGAN.png";
    //设置GIF动图是否只循环播放一次(仅对动图设置有效)
    imageAdconfiguration.GIFImageCycleOnce = NO;
    //网络图片缓存机制(只对网络图片有效)
    imageAdconfiguration.imageOption = XHLaunchAdImageRefreshCached;
    //图片填充模式
    imageAdconfiguration.contentMode = UIViewContentModeScaleToFill;
     //广告点击打开页面参数(openModel可为NSString,模型,字典等任意类型)
    imageAdconfiguration.openModel = @"http://www.it7090.com";
    //广告显示完成动画
    imageAdconfiguration.showFinishAnimate =ShowFinishAnimateFadein;
    //广告显示完成动画时间
    imageAdconfiguration.showFinishAnimateTime = 0.8;
    //跳过按钮类型
    imageAdconfiguration.skipButtonType = SkipTypeTimeText;
    //后台返回时,是否显示广告
    imageAdconfiguration.showEnterForeground = NO;
     //设置要添加的子视图(可选)
    //imageAdconfiguration.subViews = ...
    //显示图片开屏广告
    [XHLaunchAd imageAdWithImageAdConfiguration:imageAdconfiguration delegate:self];
}
//图 - 网络 - 默认
-(void)launchAd_networkDataPic_default{
    //设置你工程的启动页使用的是:LaunchImage 还是 LaunchScreen.storyboard(不设置默认:LaunchImage)
    [XHLaunchAd setLaunchSourceType:SourceTypeLaunchImage];

    //1.因为数据请求是异步的,请在数据请求前,调用下面方法配置数据等待时间.
    //2.设为2即表示:启动页将停留2s等待服务器返回广告数据,2s内等到广告数据,将正常显示广告,否则将不显示
    //3.数据获取成功,配置广告数据后,自动结束等待,显示广告
    //注意:请求广告数据前,必须设置此属性,否则会先进入window的的根控制器
    [XHLaunchAd setWaitDataDuration:2];

//    //广告数据请求
//    [Network getLaunchAdImageDataSuccess:^(NSDictionary * response) {
//
//        NSLog(@"广告数据 = %@",response);
//
//        //广告数据转模型
//        LaunchAdModel *model = [[LaunchAdModel alloc] initWithDict:response[@"data"]];
//        //配置广告数据
//        XHLaunchImageAdConfiguration *imageAdconfiguration = [XHLaunchImageAdConfiguration defaultConfiguration];
//        //广告图片URLString/或本地图片名(.jpg/.gif请带上后缀)
//        imageAdconfiguration.imageNameOrURLString = model.content;
//         //广告点击打开页面参数(openModel可为NSString,模型,字典等任意类型)
//        imageAdconfiguration.openModel = model.openUrl;
//        //显示开屏广告
//        [XHLaunchAd imageAdWithImageAdConfiguration:imageAdconfiguration delegate:self];
//
//    } failure:^(NSError *error) {
//
//    }];
}
//图 - 网络 - 自定义
-(void)launchAd_networkDataPic_custom{
    //设置你工程的启动页使用的是:LaunchImage 还是 LaunchScreen.storyboard(不设置默认:LaunchImage)
    [XHLaunchAd setLaunchSourceType:SourceTypeLaunchImage];
    //1.因为数据请求是异步的,请在数据请求前,调用下面方法配置数据等待时间.
    //2.设为2即表示:启动页将停留2s等待服务器返回广告数据,2s内等到广告数据,将正常显示广告,否则将不显示
    //3.数据获取成功,配置广告数据后,自动结束等待,显示广告
    //注意:请求广告数据前,必须设置此属性,否则会先进入window的的根控制器
    [XHLaunchAd setWaitDataDuration:2];
    //广告数据请求
//    [Network getLaunchAdImageDataSuccess:^(NSDictionary * response) {
//        NSLog(@"广告数据 = %@",response);
//        //广告数据转模型
//        LaunchAdModel *model = [[LaunchAdModel alloc] initWithDict:response[@"data"]];
//        //配置广告数据
//        XHLaunchImageAdConfiguration *imageAdconfiguration = [XHLaunchImageAdConfiguration new];
//        //广告停留时间
//        imageAdconfiguration.duration = model.duration;
//        //广告frame
//        imageAdconfiguration.frame = CGRectMake(0,
//                                                0,
//                                                [UIScreen mainScreen].bounds.size.width,
//                                                [UIScreen mainScreen].bounds.size.width/model.width*model.height);
//        //广告图片URLString/或本地图片名(.jpg/.gif请带上后缀)
//        imageAdconfiguration.imageNameOrURLString = model.content;
//        //设置GIF动图是否只循环播放一次(仅对动图设置有效)
//        imageAdconfiguration.GIFImageCycleOnce = NO;
//        //缓存机制(仅对网络图片有效)
//        //为告展示效果更好,可设置为XHLaunchAdImageCacheInBackground,先缓存,下次显示
//        imageAdconfiguration.imageOption = XHLaunchAdImageDefault;
//        //图片填充模式
//        imageAdconfiguration.contentMode = UIViewContentModeScaleToFill;
//        //广告点击打开页面参数(openModel可为NSString,模型,字典等任意类型)
//        imageAdconfiguration.openModel = model.openUrl;
//        //广告显示完成动画
//        imageAdconfiguration.showFinishAnimate =ShowFinishAnimateLite;
//        //广告显示完成动画时间
//        imageAdconfiguration.showFinishAnimateTime = 0.8;
//        //跳过按钮类型
//        imageAdconfiguration.skipButtonType = SkipTypeTimeText;
//        //后台返回时,是否显示广告
//        imageAdconfiguration.showEnterForeground = NO;
//        //设置要添加的自定义视图(可选)
//        //imageAdconfiguration.subViews = ...
//        //显示开屏广告
//        [XHLaunchAd imageAdWithImageAdConfiguration:imageAdconfiguration delegate:self];
//    } failure:^(NSError *error) {
//
//    }];
}
//视频 - 本地 - 默认
-(void)launchAd_localVedio_default{
    //设置你工程的启动页使用的是:LaunchImage 还是 LaunchScreen.storyboard(不设置默认:LaunchImage)
    [XHLaunchAd setLaunchSourceType:SourceTypeLaunchImage];

    //1.使用默认配置初始化
    XHLaunchVideoAdConfiguration *videoAdconfiguration = [XHLaunchVideoAdConfiguration defaultConfiguration];
    //广告视频URLString/或本地视频名(请带上后缀)
    videoAdconfiguration.videoNameOrURLString = @"video0.mp4";
     //广告点击打开页面参数(openModel可为NSString,模型,字典等任意类型)
    videoAdconfiguration.openModel = @"http://www.it7090.com";
    //显示视频开屏广告
    [XHLaunchAd videoAdWithVideoAdConfiguration:videoAdconfiguration delegate:self];
}
//视频 - 本地 - 自定义
-(void)launchAd_localVedio_custom{
    //设置你工程的启动页使用的是:LaunchImage 还是 LaunchScreen.storyboard(不设置默认:LaunchImage)
    [XHLaunchAd setLaunchSourceType:SourceTypeLaunchImage];
    //2.自定义配置
    XHLaunchVideoAdConfiguration *videoAdconfiguration = [XHLaunchVideoAdConfiguration new];
    //广告停留时间
    videoAdconfiguration.duration = 5;
    //广告frame
    videoAdconfiguration.frame = CGRectMake(0,
                                            0,
                                            [UIScreen mainScreen].bounds.size.width,
                                            [UIScreen mainScreen].bounds.size.height);
    //广告视频URLString/或本地视频名(请带上后缀)
    videoAdconfiguration.videoNameOrURLString = @"iph_X.mp4";
    //是否关闭音频
    videoAdconfiguration.muted = NO;
    //视频填充模式
    videoAdconfiguration.videoGravity = AVLayerVideoGravityResizeAspectFill;
    //是否只循环播放一次
    videoAdconfiguration.videoCycleOnce = NO;
     //广告点击打开页面参数(openModel可为NSString,模型,字典等任意类型)
    videoAdconfiguration.openModel =  @"http://www.it7090.com";
    //广告显示完成动画
    videoAdconfiguration.showFinishAnimate =ShowFinishAnimateFadein;
    //广告显示完成动画时间
    videoAdconfiguration.showFinishAnimateTime = 0.8;
    //跳过按钮类型
    videoAdconfiguration.skipButtonType = SkipTypeTimeText;
    //后台返回时,是否显示广告
    videoAdconfiguration.showEnterForeground = NO;
    //设置要添加的子视图(可选)
    //videoAdconfiguration.subViews = ...
    //显示视频开屏广告
    [XHLaunchAd videoAdWithVideoAdConfiguration:videoAdconfiguration delegate:self];
}
//视频 - 网络 - 默认
-(void)launchAd_networkVedio_default{
    //设置你工程的启动页使用的是:LaunchImage 还是 LaunchScreen.storyboard(不设置默认:LaunchImage)
    [XHLaunchAd setLaunchSourceType:SourceTypeLaunchImage];
    //1.因为数据请求是异步的,请在数据请求前,调用下面方法配置数据等待时间.
    //2.设为2即表示:启动页将停留2s等待服务器返回广告数据,2s内等到广告数据,将正常显示广告,否则将不显示
    //3.数据获取成功,配置广告数据后,自动结束等待,显示广告
    //注意:请求广告数据前,必须设置此属性,否则会先进入window的的根控制器
    [XHLaunchAd setWaitDataDuration:2];
    //广告数据请求
//    [Network getLaunchAdVideoDataSuccess:^(NSDictionary * response) {
//        NSLog(@"广告数据 = %@",response);
//        //广告数据转模型
//        LaunchAdModel *model = [[LaunchAdModel alloc] initWithDict:response[@"data"]];
//        //配置广告数据
//        XHLaunchVideoAdConfiguration *videoAdconfiguration = [XHLaunchVideoAdConfiguration defaultConfiguration];
//        //注意:视频广告只支持先缓存,下次显示(看效果请二次运行)
//        videoAdconfiguration.videoNameOrURLString = model.content;
//        //广告点击打开页面参数(openModel可为NSString,模型,字典等任意类型)
//        videoAdconfiguration.openModel = model.openUrl;
//        [XHLaunchAd videoAdWithVideoAdConfiguration:videoAdconfiguration delegate:self];
//    } failure:^(NSError *error) {
//
//    }];
}
//视频 - 网络 - 自定义
-(void)launchAd_networkVedio_custom{
    //设置你工程的启动页使用的是:LaunchImage 还是 LaunchScreen.storyboard(不设置默认:LaunchImage)
    [XHLaunchAd setLaunchSourceType:SourceTypeLaunchImage];
    //1.因为数据请求是异步的,请在数据请求前,调用下面方法配置数据等待时间.
    //2.设为2即表示:启动页将停留2s等待服务器返回广告数据,2s内等到广告数据,将正常显示广告,否则将不显示
    //3.数据获取成功,配置广告数据后,自动结束等待,显示广告
    //注意:请求广告数据前,必须设置此属性,否则会先进入window的的根控制器
    [XHLaunchAd setWaitDataDuration:2];
    //广告数据请求
//    [Network getLaunchAdVideoDataSuccess:^(NSDictionary * response) {
//        NSLog(@"广告数据 = %@",response);
//        //广告数据转模型
//        LaunchAdModel *model = [[LaunchAdModel alloc] initWithDict:response[@"data"]];
//        //配置广告数据
//        XHLaunchVideoAdConfiguration *videoAdconfiguration = [XHLaunchVideoAdConfiguration new];
//        //广告停留时间
//        videoAdconfiguration.duration = model.duration;
//        //广告frame
//        videoAdconfiguration.frame = CGRectMake(0,
//                                                0,
//                                                [UIScreen mainScreen].bounds.size.width,
//                                                [UIScreen mainScreen].bounds.size.width/model.width*model.height);
//        //广告视频URLString/或本地视频名(请带上后缀)
//        //注意:视频广告只支持先缓存,下次显示(看效果请二次运行)
//        videoAdconfiguration.videoNameOrURLString = model.content;
//        //是否关闭音频
//        videoAdconfiguration.muted = NO;
//        //视频填充模式
//        videoAdconfiguration.videoGravity = AVLayerVideoGravityResizeAspectFill;
//        //是否只循环播放一次
//        videoAdconfiguration.videoCycleOnce = NO;
//        //广告点击打开页面参数(openModel可为NSString,模型,字典等任意类型)
//        videoAdconfiguration.openModel = model.openUrl;
//        //广告显示完成动画
//        videoAdconfiguration.showFinishAnimate =ShowFinishAnimateFadein;
//        //广告显示完成动画时间
//        videoAdconfiguration.showFinishAnimateTime = 0.8;
//        //后台返回时,是否显示广告
//        videoAdconfiguration.showEnterForeground = NO;
//        //跳过按钮类型
//        videoAdconfiguration.skipButtonType = SkipTypeTimeText;
//        //设置要添加的自定义视图(可选)
//        //videoAdconfiguration.subViews = ...
//        [XHLaunchAd videoAdWithVideoAdConfiguration:videoAdconfiguration delegate:self];
//    } failure:^(NSError *error) {
//
//    }];
}

@end
