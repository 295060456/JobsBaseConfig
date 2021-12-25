//
//  NSObject+AppTools.m
//  DouYin
//
//  Created by Jobs on 2021/4/6.
//

#import "NSObject+AppTools.h"

@implementation NSObject (AppTools)

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
        
        if (ad.tabBarTitleMutArr.count) {
            [ad.tabBarTitleMutArr removeAllObjects];
            ad.tabBarTitleMutArr = nil;
        }

        for (int i = 0; i < ad.configMutArr.count; i++) {
            JobsTabBarControllerConfig *config = (JobsTabBarControllerConfig *)ad.configMutArr[i];
            config.vc.tabBarItem.title = ad.tabBarTitleMutArr[i];
        }
    }
}
/// 接收通知并相应的方法【在分类或者基类中实现会屏蔽具体子类的相关实现】
//-(void)languageSwitchNotification:(nonnull NSNotification *)notification{
//    NSLog(@"通知传递过来的 = %@",notification.object);
//}
#pragma mark —— AppToolsProtocol
-(void)toLogin{
//    AppDelegate *appDelegate = getSysAppDelegate();
//    [UIViewController comingFromVC:appDelegate.tabBarVC
//                              toVC:JobsAppDoorVC.new
//                       comingStyle:ComingStyle_PRESENT
//                 presentationStyle:UIModalPresentationFullScreen//[UIDevice currentDevice].systemVersion.doubleValue >= 13.0 ? UIModalPresentationAutomatic : UIModalPresentationFullScreen
//                     requestParams:@(JobsAppDoorBgType_video)
//          hidesBottomBarWhenPushed:YES
//                          animated:YES
//                           success:^(id data) {}];
}

-(void)forcedLogin{
    if (!self.isLogin) {
        [self toLogin];
    }
}

-(UIImage *)defaultHeaderImage{
    if (self.isLogin) {
        return KIMG(@"default_avatar_white");
    }else{
        return KIMG(@"未登录默认头像（灰）");
    }
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

@end

