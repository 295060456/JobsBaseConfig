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
/// 返回YES：不触发AppDoor的页面
-(BOOL)unrestrictedLogin:(NSArray <Class>*)dataArr{
    BOOL ok = NO;
    for (Class cls in dataArr) {
        if ([self.class isKindOfClass:cls]) {
            ok = YES;
            break;
        }
    }return ok;
}
#pragma mark —— AppToolsProtocol
/// 去登录？去注册？
-(void)toLoginOrRegister:(CurrentPage)appDoorContentType{
    
    // 登录页 不推出 登录页
    UIViewController *viewController = self.getCurrentViewController;
    if ([viewController isKindOfClass:JobsAppDoorVC.class]) return;
    
    // 首页没有展现的时候，不推出登录页
//    extern BOOL CasinoHomeVC_viewDidAppear;
//    if(!CasinoHomeVC_viewDidAppear) return;
    
    JobsAppDoorVC *appDoorVC = JobsAppDoorVC.new;
    appDoorVC.objBindingParams = @(appDoorContentType);
    [UIViewController comingFromVC:viewController
                              toVC:appDoorVC
                       comingStyle:ComingStyle_PRESENT
                 presentationStyle:UIModalPresentationFullScreen//[UIDevice currentDevice].systemVersion.doubleValue >= 13.0 ? UIModalPresentationAutomatic : UIModalPresentationFullScreen
                     requestParams:@(JobsAppDoorBgType_video)
          hidesBottomBarWhenPushed:YES
                          animated:YES
                           success:^(id data) {}];
}
/// 在某些页面不调取登录页
-(void)toLoginOrRegisterWithRestricted:(NSArray <Class>*_Nullable)dataArr
                    appDoorContentType:(CurrentPage)appDoorContentType{
//    if (!dataArr) dataArr = @[TESTVC.class];
    if (![self unrestrictedLogin:dataArr]) return;
    [self toLoginOrRegister:appDoorContentType];
}

-(void)toLogin{
    [self toLoginOrRegisterWithRestricted:nil
                       appDoorContentType:CurrentPage_login];
}
-(void)forcedLogin{
    if (!self.isLogin) {
        [self toLogin];
    }
}
/// 触发退出登录模块之前，弹窗提示二次确认，确认以后再删除本地用户数据
-(void)popUpViewToLogout{
    [self popupWithView:self.logOutPopupView popupParam:self.popupParameter];
}
/// 跳到首页
-(void)jumpToHome{
    extern AppDelegate *appDelegate;
    appDelegate.tabBarVC.selectedIndex = 0;
}

-(UIImage *)defaultHeaderImage{
    if (self.isLogin) {
        return KIMG(@"default_avatar_white");
    }else{
        return KIMG(@"未登录默认头像（灰）");
    }
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
/// App 升级弹窗：在根控制器下实现，做到覆盖全局的统一
-(void)appUpdateWithSureBlock:(MKDataBlock _Nullable)sureBlock
                  cancelBlock:(MKDataBlock _Nullable)cancelBlock{
    CasinoUpgradePopupView *upgradePopupView = CasinoUpgradePopupView.new;
    upgradePopupView.size = [CasinoUpgradePopupView viewSizeWithModel:nil];
    [upgradePopupView richElementsInViewWithModel:nil];
    
    [upgradePopupView actionViewBlock:^(UIButton *data) {
        if ([[data titleForNormalState] isEqualToString:Internationalization(@"Cancel")]) {
            if (cancelBlock) cancelBlock(@1);
        }else if ([[data titleForNormalState] isEqualToString:Internationalization(@"Sure")]){
            if (sureBlock) sureBlock(@1);
        }else{}
        [upgradePopupView tf_hide];
    }];
    
    [self popupWithView:upgradePopupView];
}

-(void)actionForHotLabel:(JobsHotLabel *)hl{
    @jobs_weakify(self)
    [hl actionViewBlock:^(UIButton *btn) {
        @jobs_strongify(self)
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
            vm.text = @"";
            vm.size = CGSizeMake(JobsWidth(46), JobsWidth(46));
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
@end

