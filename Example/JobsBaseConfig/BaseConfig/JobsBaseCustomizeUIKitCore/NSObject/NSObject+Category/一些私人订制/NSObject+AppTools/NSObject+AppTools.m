//
//  NSObject+AppTools.m
//  DouYin
//
//  Created by Jobs on 2021/4/6.
//

#import "NSObject+AppTools.h"

@implementation NSObject (AppTools)

static char *NSObject_AppTools_customerContactModel = "NSObject_AppTools_customerContactModel";
@dynamic customerContactModel;

static char *NSObject_AppTools_hotLabelDataMutArr = "NSObject_AppTools_hotLabelDataMutArr";
@dynamic hotLabelDataMutArr;

#pragma mark —— 一些私有化方法
/// noNeedLoginArr
-(NSArray <Class>*_Nullable)makeDataArr{
    extern AppDelegate *appDelegate;
    NSMutableArray <Class>*tempDataArr = NSMutableArray.array;
    
    for (UIViewController *viewController in appDelegate.tabBarVC.childVCMutArr) {
        NSUInteger index = [appDelegate.tabBarVC.childVCMutArr indexOfObject:viewController];
        
        if ([appDelegate.tabBarVC.noNeedLoginArr containsObject:@(index)]) {
            Class cls = viewController.class;
            [tempDataArr addObject:cls];
        }
    }
    [tempDataArr addObject:appDelegate.tabBarVC.class];
    return (NSArray *)tempDataArr;
}
#pragma mark —— BaseProtocol
/// 【通知监听】国际化语言修改UI
/// @param targetView 需要铆定的UI
/// @param aSelector 相关逻辑
+(void)targetView:(UIView *)targetView
languageSwitchNotificationWithSelector:(SEL)aSelector{
    NotificationAdd(targetView, aSelector, LanguageSwitchNotification, nil);
}
/// 【App语言国际化】更改UITabBarItem的标题
-(void)changeTabBarItemTitle:(NSIndexPath *)indexPath{
    id appDelegate = getSysAppDelegate();
    if (!appDelegate) {
        extern AppDelegate *appDelegate;
    }
    if ([appDelegate isKindOfClass:AppDelegate.class]) {
        AppDelegate *ad = (AppDelegate *)appDelegate;
        [ad refreshTabBarTitle];
    }
}
/// 接收通知并相应的方法【在分类或者基类中实现会屏蔽具体子类的相关实现】
//-(void)languageSwitchNotification:(nonnull NSNotification *)notification{
//    NSLog(@"通知传递过来的 = %@",notification.object);
//}
#pragma mark —— <AppToolsProtocol> 关于注册登录
/// 去登录？去注册？
-(void)toLoginOrRegister:(CurrentPage)appDoorContentType{
    
    // 登录页 不推出 登录页
    UIViewController *viewController = self.getCurrentViewController;
    if ([viewController isKindOfClass:JobsAppDoorVC.class]) return;
    
    // 首页没有展现的时候，不推出登录页
//    extern BOOL CasinoHomeVC_viewDidAppear;
//    if(!CasinoHomeVC_viewDidAppear) return;
    
    UIViewModel *viewModel = UIViewModel.new;
    viewModel.requestParams = @(JobsAppDoorBgType_video);
    [viewController comingToPresentVC:JobsAppDoorVC.new
                        requestParams:viewModel];
}
/// 强制登录：没登录（本地用户数据为空）就去登录
-(void)forcedLogin{
    if (!self.isLogin) {
        [self toLogin];
    }
}
/// 去登录：有限制makeDataArr
-(void)toLogin{
    [self toLoginOrRegisterWithRestricted:self.makeDataArr
                       appDoorContentType:CurrentPage_login];
}
/// 限制条件：在某些页面（noNeedLoginArr）不调取登录页
-(void)toLoginOrRegisterWithRestricted:(NSArray <Class>*_Nullable)dataArr
                    appDoorContentType:(CurrentPage)appDoorContentType{
    if ([dataArr containsObject:self.class]) return;/// 包含则不触发AppDoor的页面
    [self toLoginOrRegister:appDoorContentType];
}
/// 触发退出登录模块之前，弹窗提示二次确认，确认以后再删除本地用户数据
-(void)popUpViewToLogout{
    [self popupWithView:self.logOutPopupView popupParam:self.popupParameter];
}
#pragma mark —— <AppToolsProtocol> 关于 TabBar
/// 跳到首页
-(void)jumpToHome{
    extern AppDelegate *appDelegate;
    appDelegate.tabBarVC.selectedIndex = 0;
}
/// JobsTabbarVC 关闭手势
-(void)tabBarClosePan{
    AppDelegate *appDelegate = getSysAppDelegate();
    [appDelegate.tabBarVC closePan];
}
/// JobsTabbarVC 打开手势
-(void)tabBarOpenPan{
    AppDelegate *appDelegate = getSysAppDelegate();
    [appDelegate.tabBarVC openPan];
}
/// 获取Tabbar管理的，不含导航的根控制器
-(NSMutableArray <UIViewController *>*)appRootVC{
    AppDelegate *appDelegate = getSysAppDelegate();
    return appDelegate.getAppRootVC;
}
/// 当前对象是否是 Tabbar管理的，不含导航的根控制器
-(BOOL)isRootVC{
    if ([self isKindOfClass:UIViewController.class]) {
        return [self.appRootVC containsObject:(UIViewController *)self];
    }else return NO;
}
/// TabBar
-(UITabBar *)getTabBar{
    extern AppDelegate *appDelegate;
    return appDelegate.tabBarVC.tabBar;
}
#pragma mark —— <AppToolsProtocol> 其他
-(UIViewModel *)configViewModelWithTitle:(NSString *_Nullable)title
                                subTitle:(NSString *_Nullable)subTitle{
    UIViewModel *viewModel = UIViewModel.new;
    
    {
        UITextModel *textModel = UITextModel.new;
        textModel.text = Internationalization(title);
        viewModel.textModel = textModel;
        
        UITextModel *subTextModel = UITextModel.new;
        subTextModel.text = Internationalization([NSString isNullString:subTitle] ? @"点击查看" : subTitle);
        viewModel.subTextModel = subTextModel;
        
        UITextModel *backBtnTitleModel = UITextModel.new;
        backBtnTitleModel.text = Internationalization(@"返回首页");
        viewModel.backBtnTitleModel = backBtnTitleModel;
    }return viewModel;
}

-(UIImage *)defaultHeaderImage{
    return self.isLogin ? KIMG(@"default_avatar_white") : KIMG(@"未登录默认头像（灰）");
}

-(NSString *)currentLanguage{
    if ([NSBundle.currentLanguage containsString:@"zh-Hans"]) {
        return @"简体中文";
    }else if ([NSBundle.currentLanguage containsString:@"en"]){
        return @"English";
    }else{
        NSLog(@"%@",NSBundle.currentLanguage);
        return @"其他语言";
    }
}

-(HTTPRequestHeaderLanguageType)currentLanguageType{
    if ([NSBundle.currentLanguage containsString:@"zh-Hans"]) {
        return HTTPRequestHeaderLanguageCN;
    }else if ([NSBundle.currentLanguage containsString:@"en"]){
        return HTTPRequestHeaderLanguageEn;
    }else{
        NSLog(@"%@",NSBundle.currentLanguage);
        return HTTPRequestHeaderLanguageOther;
    }
}
#pragma mark —— 弹出框。为了防止业务层的变化，弹出框定义在NSObject层
/// Debug模式下的弹出框 及其相关的数据封装
-(UIViewModel *)testPopViewData{
    UIViewModel *viewModel = UIViewModel.new;
    
    {
        UITextModel *textModel = UITextModel.new;
        textModel.text = Internationalization(@"主标题");
        viewModel.textModel = textModel;
    }
    
    {
        UITextModel *textModel = UITextModel.new;
        textModel.text = Internationalization(@"副标题");
        viewModel.subTextModel = textModel;
    }
    return viewModel;
}
/// Debug模式下的弹出框 及其相关的数据封装
-(void)jobsTestPopView:(UIViewModel *_Nullable)viewModel{
    
#ifdef DEBUG
    JobsBaseConfigTestPopupView *testPopupView = JobsBaseConfigTestPopupView.sharedInstance;
    testPopupView.size = [CasinoUpgradePopupView viewSizeWithModel:nil];
    [testPopupView richElementsInViewWithModel:viewModel ? : self.testPopViewData];
    
    [testPopupView actionObjectBlock:^(UIButton *data) {
        if ([[data titleForNormalState] isEqualToString:Internationalization(@"Cancel")]) {
            
        }else if ([[data titleForNormalState] isEqualToString:Internationalization(@"Sure")]){
            
        }else{}
        [testPopupView tf_hide];
        [JobsBaseConfigTestPopupView destroySingleton];
    }];
    
    [self popupWithView:testPopupView];
#endif
}
/// 测试和业务密切相关的弹窗
/// @param popViewClass 被测试的弹窗视图
/// @param viewModel 此视图所绑定的数据。传nil则使用testPopViewData的数据、传UIViewModel.new则使用popViewClass预埋的数据
-(void)jobsPopView:(Class<BaseViewProtocol> _Nullable)popViewClass
         viewModel:(UIViewModel *_Nullable)viewModel{
    // 将方法内的变量进行单利化,避免重复创建
    UIView<BaseViewProtocol> *popupView = popViewClass.class.sharedInstance;
    popupView.size = [popViewClass viewSizeWithModel:nil];
    [popupView richElementsInViewWithModel:viewModel ? : self.testPopViewData];
    
    [popupView actionObjectBlock:^(UIButton *data) {
        if ([[data titleForNormalState] isEqualToString:Internationalization(@"Cancel")]) {
            
        }else if ([[data titleForNormalState] isEqualToString:Internationalization(@"Sure")]){
            
        }else{}
        [popupView tf_hide];
        [popViewClass.class destroySingleton];
    }];
    
    [self popupWithView:popupView];
}
/// App 升级弹窗：在根控制器下实现，做到覆盖全局的统一
-(void)appUpdateWithData:(CasinoGetiOSNewestVersionModel *_Nonnull)updateData
               sureBlock:(jobsByIDBlock _Nullable)sureBlock
             cancelBlock:(jobsByIDBlock _Nullable)cancelBlock{
    CasinoUpgradePopupView *upgradePopupView = CasinoUpgradePopupView.new;
    upgradePopupView.size = [CasinoUpgradePopupView viewSizeWithModel:nil];
    [upgradePopupView richElementsInViewWithModel:updateData];
    
    [upgradePopupView actionObjectBlock:^(UIButton *data) {
        if ([[data titleForNormalState] isEqualToString:Internationalization(@"Cancel")]) {
            if (cancelBlock) cancelBlock(@1);
        }else if ([[data titleForNormalState] isEqualToString:Internationalization(@"Sure")]){
            if (sureBlock) sureBlock(@1);
        }else{}
        [upgradePopupView tf_hide];
    }];
    
    [self popupWithView:upgradePopupView];
}

-(void)actionForHotLabel:(JobsHotLabelWithSingleLine *)hl{
//    @jobs_weakify(self)
    [hl actionObjectBlock:^(UIButton *btn) {
//        @jobs_strongify(self)
        if([btn.objBindingParams isKindOfClass:CasinoCustomerContactElementModel.class]){
            CasinoCustomerContactElementModel *customerContactElementModel = (CasinoCustomerContactElementModel *)btn.objBindingParams;

            switch (customerContactElementModel.customerMark) {
                case CustomerContactStyle_QQ:{
                    [NSObject openURL:[NSString stringWithFormat:@"mqq://im/chat?chat_type=wpa&uin=%@&version=1&src_type=web",customerContactElementModel.customer]];
                }break;
                case CustomerContactStyle_Skype:{
                    [NSObject openURL:[NSString stringWithFormat:@"skype://%@?chat",customerContactElementModel.customer]];
                }break;
                case CustomerContactStyle_Telegram:{
                    [NSObject openURL:[NSString stringWithFormat:@"https://t.me/%@",customerContactElementModel.customer]];
                }break;
                case CustomerContactStyle_whatsApp:{
//                            [NSObject openURL:@""];
                    [WHToast toastMsg:@"打开whatsApp未配置"];
                }break;
                case CustomerContactStyle_手机号码:{
//                            [NSObject openURL:@""];
                    [WHToast toastMsg:@"打开手机号码未配置"];
                }break;
                case CustomerContactStyle_onlineURL:{
//                            [NSObject openURL:@""];
                    [WHToast toastMsg:@"打开onlineURL未配置"];
                }break;

                default:
                    break;
            }
        }
    }];
}
#pragma mark —— @property(nonatomic,strong)CasinoCustomerContactModel *customerContactModel;
-(CasinoCustomerContactModel *)customerContactModel{
    return objc_getAssociatedObject(self, NSObject_AppTools_customerContactModel);
}

-(void)setCustomerContactModel:(CasinoCustomerContactModel *)customerContactModel{
    objc_setAssociatedObject(self,
                             NSObject_AppTools_customerContactModel,
                             customerContactModel,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,strong)NSMutableArray<UIViewModel *> *hotLabelDataMutArr;
-(NSMutableArray<UIViewModel *> *)hotLabelDataMutArr{
    NSMutableArray<UIViewModel *> *HotLabelDataMutArr = objc_getAssociatedObject(self, NSObject_AppTools_hotLabelDataMutArr);
    if (!HotLabelDataMutArr) {
        HotLabelDataMutArr = NSMutableArray.array;
        
        for (CasinoCustomerContactElementModel *element in self.customerContactModel.customerList) {
            UIViewModel *vm = UIViewModel.new;

            vm.objBindingParams = element;
            vm.bgImageURLString = @"";//[NSObject.BaseUrl stringByAppendingString:element.appIconUrl];
            vm.textModel.text = @"";
            vm.jobsSize = CGSizeMake(JobsWidth(46), JobsWidth(46));
            vm.offsetXForEach = JobsWidth(46);
            vm.offsetYForEach = JobsWidth(46);
            [HotLabelDataMutArr addObject:vm];
        }
        
        objc_setAssociatedObject(self,
                                 NSObject_AppTools_hotLabelDataMutArr,
                                 HotLabelDataMutArr,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return HotLabelDataMutArr;
}

-(void)setHotLabelDataMutArr:(NSMutableArray<UIViewModel *> *)hotLabelDataMutArr{
    objc_setAssociatedObject(self,
                             NSObject_AppTools_hotLabelDataMutArr,
                             hotLabelDataMutArr,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
static char *NSObject_AppTools_titleLab = "NSObject_AppTools_titleLab";
@dynamic titleLab;
#pragma mark —— @property(nonatomic,strong)JobsUpDownLab *titleLab;
-(JobsUpDownLab *)titleLab{
    JobsUpDownLab *TitleLab = objc_getAssociatedObject(self, NSObject_AppTools_titleLab);
    if ([self isKindOfClass:UIViewController.class] && !TitleLab) {
        TitleLab = JobsUpDownLab.new;
        
        UIViewController *viewController = (UIViewController *)self;
        [viewController.view addSubview:TitleLab];
        [TitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(viewController.view).offset(JobsWidth(120));
            make.left.equalTo(viewController.view).offset(JobsWidth(16));
        }];
        
        {
            JobsUpDownLabModel *model = JobsUpDownLabModel.new;
            model.upLabText = Internationalization(@"登入獲得更多精彩");
            model.upLabFont = [UIFont systemFontOfSize:JobsWidth(24)
                                                weight:UIFontWeightBold];
            model.upLabTextCor = UIColor.blackColor;
            model.upLabBgCor = UIColor.clearColor;
            model.upLabTextAlignment = NSTextAlignmentLeft;
            
            model.downLabText = Internationalization(@"在這裡，體驗專業平台");
            model.downLabFont = [UIFont systemFontOfSize:JobsWidth(16)
                                                  weight:UIFontWeightRegular];
            model.downLabTextCor = HEXCOLOR(0xB0B0B0);
            model.downLabBgCor = UIColor.clearColor;
            model.downLabTextAlignment = NSTextAlignmentLeft;
            
            model.space = JobsWidth(12);
            
            [TitleLab richElementsInViewWithModel:model];
        }
        
        objc_setAssociatedObject(self,
                                 NSObject_AppTools_titleLab,
                                 TitleLab,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return TitleLab;
}

-(void)setTitleLab:(JobsUpDownLab *)titleLab{
    objc_setAssociatedObject(self,
                             NSObject_AppTools_titleLab,
                             titleLab,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
static char *NSObject_AppTools_separateLab = "NSObject_AppTools_separateLab";
@dynamic separateLab;
#pragma mark —— @property(nonatomic,strong)UILabel *separateLab;/// 分割线
-(UILabel *)separateLab{
    UILabel *SeparateLab = objc_getAssociatedObject(self, NSObject_AppTools_separateLab);
    if ([self isKindOfClass:UIViewController.class] && !SeparateLab) {
        SeparateLab = UILabel.new;
        SeparateLab.backgroundColor = HEXCOLOR(0xC4C4C4);
        UIViewController *viewController = (UIViewController *)self;
        [viewController.bgImageView addSubview:SeparateLab];
        [SeparateLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(JobsWidth(2), JobsWidth(14)));
            make.centerX.equalTo(viewController.view);
            make.bottom.equalTo(viewController.view).offset(JobsWidth(-64));
        }];
        objc_setAssociatedObject(self,
                                 NSObject_AppTools_separateLab,
                                 SeparateLab,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return SeparateLab;
}


-(void)setSeparateLab:(UILabel *)separateLab{
    objc_setAssociatedObject(self,
                             NSObject_AppTools_separateLab,
                             separateLab,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
static char *NSObject_AppTools_立即注册 = "NSObject_AppTools_立即注册";
@dynamic 立即注册;
#pragma mark —— @property(nonatomic,strong)UIButton *立即注册;
-(UIButton *)立即注册{
    UIButton *_立即注册 = objc_getAssociatedObject(self, NSObject_AppTools_立即注册);
    if ([self isKindOfClass:UIViewController.class] && !_立即注册 ) {
        _立即注册 = UIButton.new;
        [_立即注册 handelAdjustsImageWhenHighlighted];
        _立即注册.normalTitle = Internationalization(@"立即注册");
        _立即注册.normalTitleColor = HEXCOLOR(0x757575);
        _立即注册.titleFont = [UIFont systemFontOfSize:JobsWidth(14) weight:UIFontWeightRegular];
        UIViewController *viewController = (UIViewController *)self;
        [viewController.bgImageView addSubview:_立即注册];
        [_立即注册 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(JobsWidth(14));
            make.bottom.equalTo(viewController.view).offset(JobsWidth(-64));
            make.left.equalTo(self.separateLab.mas_right).offset(JobsWidth(24));
        }];
        BtnClickEvent(_立即注册,
                      {
            NSLog(@"立即注册")
            [self jobsTestPopView:nil];
        });
        
        [_立即注册 makeBtnLabelByShowingType:UILabelShowingType_03];
        
        objc_setAssociatedObject(self,
                                 NSObject_AppTools_立即注册,
                                 _立即注册,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return _立即注册;
}

-(void)set立即注册:(UIButton *)立即注册{
    objc_setAssociatedObject(self,
                             NSObject_AppTools_立即注册,
                             立即注册,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
static char *NSObject_AppTools_联系客服 = "NSObject_AppTools_联系客服";
@dynamic 联系客服;
#pragma mark —— @property(nonatomic,strong)UIButton *联系客服;
-(UIButton *)联系客服{
    UIButton *_联系客服 = objc_getAssociatedObject(self, NSObject_AppTools_联系客服);
    if ([self isKindOfClass:UIViewController.class] && !_联系客服) {
        _联系客服 = UIButton.new;
        [_联系客服 handelAdjustsImageWhenHighlighted];
        _联系客服.normalTitle = Internationalization(@"联系客服");
        _联系客服.normalTitleColor = HEXCOLOR(0x757575);
        _联系客服.titleFont = [UIFont systemFontOfSize:JobsWidth(14) weight:UIFontWeightRegular];
        
        UIViewController *viewController = (UIViewController *)self;
        [viewController.bgImageView addSubview:_联系客服];
        [_联系客服 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(JobsWidth(14));
            make.bottom.equalTo(viewController.view).offset(JobsWidth(-64));
            make.right.equalTo(viewController.separateLab.mas_left).offset(JobsWidth(-24));
        }];
        BtnClickEvent(_联系客服, {
            NSLog(@"联系客服");
            [self jobsTestPopView:nil];
        });
        
        [_联系客服 makeBtnLabelByShowingType:UILabelShowingType_03];
        
        objc_setAssociatedObject(self,
                                 NSObject_AppTools_联系客服,
                                 _联系客服,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return _联系客服;
}

-(void)set联系客服:(UIButton *)联系客服{
    objc_setAssociatedObject(self,
                             NSObject_AppTools_联系客服,
                             联系客服,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

