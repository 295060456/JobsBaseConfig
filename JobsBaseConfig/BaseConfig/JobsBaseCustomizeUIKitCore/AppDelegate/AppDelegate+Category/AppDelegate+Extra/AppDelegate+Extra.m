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
/// 仅仅对数值tabBarTitleMutArr做简单的添加元素并赋值
-(void)addElementByTabBarTitleMutArr:(NSMutableArray *)tabBarTitleMutArr{
    if (tabBarTitleMutArr) {
        [tabBarTitleMutArr addObject:Internationalization(@"Home")];
        [tabBarTitleMutArr addObject:Internationalization(@"XiMa")];
        [tabBarTitleMutArr addObject:Internationalization(@"Recharge")];
        [tabBarTitleMutArr addObject:Internationalization(@"CustomerService")];
        [tabBarTitleMutArr addObject:Internationalization(@"MemberCenter")];
        objc_setAssociatedObject(self,
                                 AppDelegate_Extra_tabBarTitleMutArr,
                                 tabBarTitleMutArr,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}
/// 刷新 TabBarTitle
-(void)refreshTabBarTitle{
    
    NSMutableArray *TabBarTitleMutArr = objc_getAssociatedObject(self, AppDelegate_Extra_tabBarTitleMutArr);
    
    if (TabBarTitleMutArr.count) {
        [TabBarTitleMutArr removeAllObjects];
        [self addElementByTabBarTitleMutArr:TabBarTitleMutArr];
    }
    
    for (JobsTabBarControllerConfig *config in self.configMutArr) {
        NSInteger index = [self.configMutArr indexOfObject:config];
        config.vc.tabBarItem.title = TabBarTitleMutArr[index];
    }
}

-(TFPopupParam *)appDelegatePopupParameter{
    TFPopupParam *PopupParameter = TFPopupParam.new;
    PopupParameter.duration = 0.3f;
    PopupParameter.showAnimationDelay = 0.1f;
    PopupParameter.hideAnimationDelay = 0.1f;
    PopupParameter.dragEnable = YES;
    PopupParameter.offset = CGPointMake(0,-TabBarHeightByBottomSafeArea(self.tabBarVC));
    PopupParameter.disuseBackgroundTouchHide = YES;
    PopupParameter.popupSize = [CasinoCustomerServiceView viewSizeWithModel:nil];
    return PopupParameter;
}
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
            [self.tabBarTitleMutArr addObject:config.title];
        }
        
        [TabBarVC setReturnViewControllerBlock:^id(id data) {
            if ([data isKindOfClass:NSNumber.class]) {
                NSNumber *num = (NSNumber *)data;
                BOOL ok = num.integerValue != 3;
                if (!ok) {
                    if (self.customerContactModel.customerList.count) {
                        CasinoCustomerServiceView *customerServiceView = CasinoCustomerServiceView.new;
                        [customerServiceView actionViewBlock:^(id data) {
                            [customerServiceView tf_hide];
                        }];
                        customerServiceView.size = [CasinoCustomerServiceView viewSizeWithModel:self.hotLabelDataMutArr];
                        [customerServiceView richElementsInViewWithModel:self.hotLabelDataMutArr];
                        [customerServiceView tf_showSlide:getMainWindow()
                                                direction:PopupDirectionBottom
                                               popupParam:self.appDelegatePopupParameter];
                    }
                }return @(ok);
            }return @(YES);
        }];
        
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
            config.title = self.tabBarTitleMutArr[ConfigMutArr.count];
            config.imageSelected = KIMG(@"tabbbar_home_seleteds");
            config.imageUnselected = KIMG(@"tabbbar_home_normal");
            config.humpOffsetY = 0;
            config.lottieName = nil;
            config.tag = ConfigMutArr.count + 1;
            [ConfigMutArr addObject:config];
        }
        
        {
            JobsTabBarControllerConfig *config = JobsTabBarControllerConfig.new;
            config.vc = UIViewController.new;
            config.title = self.tabBarTitleMutArr[ConfigMutArr.count];
            config.imageSelected = KIMG(@"tabbbar_weights_seleteds");
            config.imageUnselected = KIMG(@"tabbbar_weights_normal");
            config.humpOffsetY = 0;
            config.lottieName = nil;
            config.tag = ConfigMutArr.count + 1;
            [ConfigMutArr addObject:config];
        }
        
        {
            JobsTabBarControllerConfig *config = JobsTabBarControllerConfig.new;
            config.vc = UIViewController.new;
            config.title = self.tabBarTitleMutArr[ConfigMutArr.count];
            config.imageSelected = KIMG(@"tabbbar_pay_seleteds");
            config.imageUnselected = KIMG(@"tabbbar_pay_normal");
            config.humpOffsetY = 0;
            config.lottieName = nil;
            config.tag = ConfigMutArr.count + 1;
            [ConfigMutArr addObject:config];
        }
        
        {
            JobsTabBarControllerConfig *config = JobsTabBarControllerConfig.new;
            config.vc = UIViewController.new;
            config.title = self.tabBarTitleMutArr[ConfigMutArr.count];
            config.imageSelected = KIMG(@"tabbbar_service_seleteds");
            config.imageUnselected = KIMG(@"tabbbar_service_normal");
            config.humpOffsetY = 0;
            config.lottieName = nil;
            config.tag = ConfigMutArr.count + 1;
            [ConfigMutArr addObject:config];
        }
        
        {
            JobsTabBarControllerConfig *config = JobsTabBarControllerConfig.new;
            config.vc = UIViewController.new;
            config.title = self.tabBarTitleMutArr[ConfigMutArr.count];
            config.imageSelected = KIMG(@"tabbar_VIP_seleteds");
            config.imageUnselected = KIMG(@"tabbar_VIP_normal");
            config.humpOffsetY = 0;
            config.lottieName = nil;
            config.tag = ConfigMutArr.count + 1;
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
        [self addElementByTabBarTitleMutArr:TabBarTitleMutArr];
    }return TabBarTitleMutArr;
}

-(void)setTabBarTitleMutArr:(NSMutableArray<NSString *> *)tabBarTitleMutArr{
    objc_setAssociatedObject(self,
                             AppDelegate_Extra_tabBarTitleMutArr,
                             tabBarTitleMutArr,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
