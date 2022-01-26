//
//  NSObject+Popup.m
//  Casino
//
//  Created by Jobs on 2021/12/15.
//

#import "NSObject+Popup.h"

@implementation NSObject (Popup)

static char *NSObject_Popup_popupView = "NSObject_Popup_popupView";
@dynamic popupView;

static char *NSObject_Popup_popupParameter = "NSObject_Popup_popupParameter";
@dynamic popupParameter;
/// 没有自定义 popupParam
-(void)popupWithView:(UIView *_Nullable)view{
    if (!view) {
        view = self.popupView;
    }

    if ([self isKindOfClass:UIViewController.class]) {
        UIViewController *vc = (UIViewController *)self;
        [view tf_showScale:vc.view offset:CGPointZero popupParam:self.popupParameter];
    }else if ([self isKindOfClass:UIView.class]){
        UIView *v = (UIView *)self;
        [view tf_showScale:v offset:CGPointZero popupParam:self.popupParameter];
    }else{
        [view tf_showNormal:getMainWindow() animated:YES];
    }
}
/// 有自定义popupParam
-(void)popupWithView:(UIView *_Nullable)view
          popupParam:(TFPopupParam *_Nullable)popupParam{
    if (popupParam) {
        [view tf_showNormal:getMainWindow() popupParam:popupParam];
    }else{
        [self popupWithView:view];
    }
}
#pragma mark —— @property(nonatomic,strong)TFPopupParam *popupParameter;
-(TFPopupParam *)popupParameter{
    TFPopupParam *PopupParameter = objc_getAssociatedObject(self, NSObject_Popup_popupParameter);
    if (!PopupParameter) {
        PopupParameter = TFPopupParam.new;
        PopupParameter.duration = 0.3;
        PopupParameter.showAnimationDelay = 0;
        PopupParameter.hideAnimationDelay = 0;
        PopupParameter.autoDissmissDuration = 0;
        PopupParameter.dragEnable = NO;
        PopupParameter.disuseBackgroundTouchHide = YES;
        objc_setAssociatedObject(self,
                                 NSObject_Popup_popupParameter,
                                 PopupParameter,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return PopupParameter;
}

-(void)setPopupParameter:(TFPopupParam *)popupParameter{
    objc_setAssociatedObject(self,
                             NSObject_Popup_popupParameter,
                             popupParameter,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,strong)NoticePopupView *popupView;
-(JobsNoticePopupView *)popupView{
    JobsNoticePopupView *PopupView = objc_getAssociatedObject(self, NSObject_Popup_popupView);
    if (!PopupView) {
        PopupView = JobsNoticePopupView.new;
        PopupView.mj_h = JobsMainScreen_HEIGHT() * 2 / 3;
        PopupView.mj_w = JobsMainScreen_WIDTH() - 12 * 2;
        [PopupView richElementsInViewWithModel:UIViewModel.new];
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
