//
//  AppDelegate+Extra.m
//  Casino
//
//  Created by Jobs on 2021/12/11.
//

#import "AppDelegate+Extra.h"

@implementation AppDelegate (Extra)

static char *AppDelegate_Extra_tabBarVC = "AppDelegate_Extra_tabBarVC";
@dynamic tabBarVC;

static char *AppDelegate_Extra_configMutArr = "AppDelegate_Extra_configMutArr";
@dynamic configMutArr;

static char *AppDelegate_Extra_tabBarTitleMutArr = "AppDelegate_Extra_tabBarTitleMutArr";
@dynamic tabBarTitleMutArr;

#pragma mark —— @property(nonatomic,strong)JobsTabbarVC *tabBarVC;
-(JobsTabbarVC *)tabBarVC{
    JobsTabbarVC *TabBarVC = objc_getAssociatedObject(self, AppDelegate_Extra_tabBarVC);
    if (!TabBarVC) {
        TabBarVC = JobsTabbarVC.new;
        TabBarVC.isAnimationAlert = YES;//OK
        TabBarVC.isPlaySound = YES;
        TabBarVC.isFeedbackGenerator = YES;
//        TabBarVC.isShakerAnimation = YES;
//        TabBarVC.isOpenScrollTabbar = NO;

        for (JobsTabBarControllerConfig *config in self.configMutArr) {
            [TabBarVC.tabBarControllerConfigMutArr addObject:config];
            [TabBarVC.childMutArr addObject:config.vc];
        }
        objc_setAssociatedObject(self,
                                 AppDelegate_Extra_tabBarVC,
                                 TabBarVC,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return TabBarVC;
}

-(void)setTabBarVC:(JobsTabbarVC *)tabBarVC{
    objc_setAssociatedObject(self,
                             AppDelegate_Extra_tabBarVC,
                             tabBarVC,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,strong)NSMutableArray <JobsTabBarControllerConfig *>*configMutArr;
-(NSMutableArray<JobsTabBarControllerConfig *> *)configMutArr{
    NSMutableArray *ConfigMutArr = objc_getAssociatedObject(self, AppDelegate_Extra_configMutArr);
    if (!ConfigMutArr) {
        ConfigMutArr = NSMutableArray.array;
        {
            JobsTabBarControllerConfig *config = JobsTabBarControllerConfig.new;
            config.vc = UIViewController.new;
            config.title = Internationalization(@"Home");
            config.imageSelected = KIMG(@"tabbbar_home_seleteds");
            config.imageUnselected = KIMG(@"tabbbar_home_normal");
            config.humpOffsetY = 0;
            config.lottieName = nil;
            config.tag = 1;
            [ConfigMutArr addObject:config];
        }
        
        {
            JobsTabBarControllerConfig *config = JobsTabBarControllerConfig.new;
            config.vc = UIViewController.new;
            config.title = Internationalization(@"XiMa");
            config.imageSelected = KIMG(@"tabbbar_weights_seleteds");
            config.imageUnselected = KIMG(@"tabbbar_weights_normal");
            config.humpOffsetY = 0;
            config.lottieName = nil;
            config.tag = 2;
            [ConfigMutArr addObject:config];
        }
        
        {
            JobsTabBarControllerConfig *config = JobsTabBarControllerConfig.new;
            config.vc = UIViewController.new;
            config.title = Internationalization(@"Recharge");
            config.imageSelected = KIMG(@"tabbbar_pay_seleteds");
            config.imageUnselected = KIMG(@"tabbbar_pay_normal");
            config.humpOffsetY = 0;
            config.lottieName = nil;
            config.tag = 2;
            [ConfigMutArr addObject:config];
        }
        
        {
            JobsTabBarControllerConfig *config = JobsTabBarControllerConfig.new;
            config.vc = UIViewController.new;
            config.title = Internationalization(@"CustomerService");
            config.imageSelected = KIMG(@"tabbbar_service_seleteds");
            config.imageUnselected = KIMG(@"tabbbar_service_normal");
            config.humpOffsetY = 0;
            config.lottieName = nil;
            config.tag = 3;
            [ConfigMutArr addObject:config];
        }
        
        {
            JobsTabBarControllerConfig *config = JobsTabBarControllerConfig.new;
            config.vc = UIViewController.new;
            config.title = Internationalization(@"MemberCenter");
            config.imageSelected = KIMG(@"tabbar_VIP_seleteds");
            config.imageUnselected = KIMG(@"tabbar_VIP_normal");
            config.humpOffsetY = 0;
            config.lottieName = nil;
            config.tag = 4;
            [ConfigMutArr addObject:config];
        }
        
        objc_setAssociatedObject(self,
                                 AppDelegate_Extra_configMutArr,
                                 ConfigMutArr,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return ConfigMutArr;
}

-(void)setConfigMutArr:(NSMutableArray<JobsTabBarControllerConfig *> *)configMutArr{
    objc_setAssociatedObject(self,
                             AppDelegate_Extra_configMutArr,
                             configMutArr,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— #pragma mark —— @property(nonatomic,strong)NSMutableArray <NSString *>*tabBarTitleMutArr;


-(NSMutableArray<NSString *> *)tabBarTitleMutArr{
    NSMutableArray *TabBarTitleMutArr = objc_getAssociatedObject(self, AppDelegate_Extra_tabBarTitleMutArr);
    if (!TabBarTitleMutArr) {
        TabBarTitleMutArr = NSMutableArray.array;
        
        [TabBarTitleMutArr addObject:Internationalization(@"Home")];
        [TabBarTitleMutArr addObject:Internationalization(@"XiMa")];
        [TabBarTitleMutArr addObject:Internationalization(@"Recharge")];
        [TabBarTitleMutArr addObject:Internationalization(@"CustomerService")];
        [TabBarTitleMutArr addObject:Internationalization(@"MemberCenter")];
        
        objc_setAssociatedObject(self,
                                 AppDelegate_Extra_tabBarTitleMutArr,
                                 TabBarTitleMutArr,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return TabBarTitleMutArr;
}

-(void)setTabBarTitleMutArr:(NSMutableArray<NSString *> *)tabBarTitleMutArr{
    objc_setAssociatedObject(self,
                             AppDelegate_Extra_configMutArr,
                             tabBarTitleMutArr,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
