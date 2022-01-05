//
//  UIView+UIBackgroundConfig.m
//  Casino
//
//  Created by Jobs on 2021/12/25.
//

#import "UIView+UIBackgroundConfig.h"

@implementation UIView (UIBackgroundConfig)

static char *UIView_UIBackgroundConfig_backgroundConfig = "UIView_UIBackgroundConfig_backgroundConfig";
@dynamic backgroundConfig;

#pragma mark —— @property(nonatomic,strong)UIBackgroundConfiguration *backgroundConfig;
-(UIBackgroundConfiguration *)backgroundConfig{
    UIBackgroundConfiguration *BackgroundConfig = objc_getAssociatedObject(self,
                                                                           UIView_UIBackgroundConfig_backgroundConfig);
    if (!BackgroundConfig) {
        BackgroundConfig = UIBackgroundConfiguration.listPlainHeaderFooterConfiguration;
        BackgroundConfig.image = KIMG(@"设置_背景1");
        BackgroundConfig.backgroundInsets = NSDirectionalEdgeInsetsMake(JobsWidth(3),
                                                                        JobsWidth(15),
                                                                        JobsWidth(3),
                                                                        JobsWidth(15));
        objc_setAssociatedObject(self,
                                 UIView_UIBackgroundConfig_backgroundConfig,
                                 BackgroundConfig,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return BackgroundConfig;
}

-(void)setBackgroundConfig:(UIBackgroundConfiguration *)backgroundConfig{
    objc_setAssociatedObject(self,
                             UIView_UIBackgroundConfig_backgroundConfig,
                             backgroundConfig,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}



@end

