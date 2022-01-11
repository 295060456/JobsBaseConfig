//
//  NSObject+PopViewToLogOut.m
//  Casino
//
//  Created by Jobs on 2022/1/1.
//

#import "NSObject+PopViewToLogOut.h"

@implementation NSObject (PopViewToLogOut)

static char *NSObject_PopViewToLogOut_logOutPopupView = "NSObject_PopViewToLogOut_logOutPopupView";
@dynamic logOutPopupView;

static char *NSObject_PopViewToLogOut_logOutPopupVM = "NSObject_PopViewToLogOut_logOutPopupVM";
@dynamic logOutPopupVM;

#pragma mark —— @property(nonatomic,strong)UIViewModel *logOutPopupVM;
-(UIViewModel *)logOutPopupVM{
    UIViewModel *LogOutPopupVM = objc_getAssociatedObject(self, NSObject_PopViewToLogOut_logOutPopupVM);
    if (!LogOutPopupVM) {
        LogOutPopupVM = UIViewModel.new;
        LogOutPopupVM.text = Internationalization(@"Confirm to exit ?");
        LogOutPopupVM.subText = @"";
        LogOutPopupVM.font = [UIFont systemFontOfSize:JobsWidth(14) weight:UIFontWeightRegular];
        LogOutPopupVM.textAlignment = NSTextAlignmentCenter;
        LogOutPopupVM.bgCor = UIColor.whiteColor;
        objc_setAssociatedObject(self,
                                 NSObject_PopViewToLogOut_logOutPopupVM,
                                 LogOutPopupVM,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return LogOutPopupVM;
}

-(void)setLogOutPopupVM:(UIViewModel *)logOutPopupVM{
    objc_setAssociatedObject(self,
                             NSObject_PopViewToLogOut_logOutPopupVM,
                             logOutPopupVM,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,strong)JobsBasePopupView *logOutPopupView;
-(JobsBasePopupView *)logOutPopupView{
    JobsBasePopupView *LogOutPopupView = objc_getAssociatedObject(self, NSObject_PopViewToLogOut_logOutPopupView);
    if (!LogOutPopupView) {
        LogOutPopupView = JobsBasePopupView.new;
        LogOutPopupView.size = [JobsBasePopupView viewSizeWithModel:nil];
        
        [LogOutPopupView richElementsInViewWithModel:self.logOutPopupVM];
        
        @jobs_weakify(self)
        [LogOutPopupView actionViewBlock:^(UIButton *data) {
            @jobs_strongify(self)
            if (data.tag == 666) {// 取消
                NSLog(@"手滑了");
            }else if (data.tag == 999){// 确定退出
                [self logOut];
                [WHToast toastSuccessMsg:Internationalization(@"Logout succeeded")];
                [NSNotificationCenter.defaultCenter postNotificationName:退出登录 object:@(NO)];
                
//                {
//                    @weakify(self)
//                    [NSNotificationCenter.defaultCenter addObserver:self
//                                                           selector:selectorBlocks(^(id  _Nullable weakSelf,
//                                                                                     id  _Nullable arg) {
//                        @jobs_strongify(self)
//                //        NSNotification *notification = (NSNotification *)arg;
//                //        NSNumber *b = notification.object;
//                    }, self)
//                                                               name:退出登录
//                                                             object:nil];
//                }
            }
            [LogOutPopupView tf_hide];
            if (JobsDebug) {
                [self.getCurrentViewController comingToPushVC:JobsShowObjInfoVC.new
                                                requestParams:self.readUserInfo];// 测试专用
            }
        }];
        
        objc_setAssociatedObject(self,
                                 NSObject_PopViewToLogOut_logOutPopupView,
                                 LogOutPopupView,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
    }return LogOutPopupView;
}

-(void)setLogOutPopupView:(JobsBasePopupView *)logOutPopupView{
    objc_setAssociatedObject(self,
                             NSObject_PopViewToLogOut_logOutPopupView,
                             logOutPopupView,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
