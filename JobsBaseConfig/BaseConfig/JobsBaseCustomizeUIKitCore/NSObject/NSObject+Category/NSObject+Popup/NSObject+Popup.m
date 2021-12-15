//
//  NSObject+Popup.m
//  Casino
//
//  Created by Jobs on 2021/12/15.
//

#import "NSObject+Popup.h"

@implementation NSObject (Popup)

static char *NSObject_Popup_popupParam = "NSObject_Popup_popupParam";
@dynamic popupParam;

static char *NSObject_Popup_popupView = "NSObject_Popup_popupView";
@dynamic popupView;

-(void)popupWithView:(UIView *_Nullable)view{
    if (!view) {
        view = self.popupView;
    }

    if ([self isKindOfClass:UIViewController.class]) {
        UIViewController *vc = (UIViewController *)self;
        [view tf_showScale:vc.view offset:CGPointZero popupParam:self.popupParam];
    }else if ([self isKindOfClass:UIView.class]){
        UIView *v = (UIView *)self;
        [view tf_showScale:v offset:CGPointZero popupParam:self.popupParam];
    }else{
        [view tf_showNormal:getMainWindow() animated:YES];
    }
}
#pragma mark —— @property(nonatomic,strong)TFPopupParam *popupParam;
-(TFPopupParam *)popupParam{
    TFPopupParam *PopupParam = objc_getAssociatedObject(self, NSObject_Popup_popupParam);
    if (!PopupParam) {
        PopupParam = TFPopupParam.new;
        PopupParam.duration = 0.3;
        PopupParam.showAnimationDelay = 0;
        PopupParam.hideAnimationDelay = 0;
        PopupParam.autoDissmissDuration = 0;
        PopupParam.dragEnable = NO;
        
        objc_setAssociatedObject(self,
                                 NSObject_Popup_popupParam,
                                 PopupParam,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return PopupParam;
}

-(void)setPopupParam:(TFPopupParam *)popupParam{
    objc_setAssociatedObject(self,
                             NSObject_Popup_popupParam,
                             popupParam,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,strong)NoticePopupView *popupView;
-(JobsNoticePopupView *)popupView{
    JobsNoticePopupView *PopupView = objc_getAssociatedObject(self, NSObject_Popup_popupView);
    if (!PopupView) {
        PopupView = JobsNoticePopupView.new;
        PopupView.mj_h = SCREEN_HEIGHT * 2 / 3;
        PopupView.mj_w = SCREEN_WIDTH - 12 * 2;
        [PopupView richElementsInViewWithModel:nil];
        objc_setAssociatedObject(self,
                                 NSObject_Popup_popupView,
                                 PopupView,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return PopupView;
}

-(void)setPopupView:(JobsNoticePopupView *)popupView{
    objc_setAssociatedObject(self,
                             NSObject_Popup_popupView,
                             popupView,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
