//
//  NSObject+Popup.m
//  Casino
//
//  Created by Jobs on 2021/12/15.
//

#import "NSObject+Popup.h"

@implementation NSObject (Popup)
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
        [view tf_showNormal:jobsGetMainWindow() animated:YES];
    }
}
/// 有自定义popupParam
-(void)popupWithView:(UIView *_Nullable)view
          popupParam:(TFPopupParam *_Nullable)popupParam{
    if (popupParam) {
        [view tf_showNormal:jobsGetMainWindow() popupParam:popupParam];
    }else{
        [self popupWithView:view];
    }
}
#pragma mark —— @property(nonatomic,strong)TFPopupParam *popupParameter;
JobsKey(_popupParameter)
@dynamic popupParameter;
-(TFPopupParam *)popupParameter{
    TFPopupParam *PopupParameter = Jobs_getAssociatedObject(_popupParameter);
    if (!PopupParameter) {
        PopupParameter = TFPopupParam.new;
        PopupParameter.duration = 0.3;
        PopupParameter.showAnimationDelay = 0;
        PopupParameter.hideAnimationDelay = 0;
        PopupParameter.autoDissmissDuration = 0;
        PopupParameter.dragEnable = NO;
        PopupParameter.disuseBackgroundTouchHide = YES;
        Jobs_setAssociatedRETAIN_NONATOMIC(_popupParameter, PopupParameter)
    }return PopupParameter;
}

-(void)setPopupParameter:(TFPopupParam *)popupParameter{
    Jobs_setAssociatedRETAIN_NONATOMIC(_popupParameter, popupParameter)
}
#pragma mark —— @property(nonatomic,strong)NoticePopupView *popupView;
JobsKey(_popupView)
@dynamic popupView;
-(JobsNoticePopupView *)popupView{
    JobsNoticePopupView *PopupView = Jobs_getAssociatedObject(_popupView);
    if (!PopupView) {
        PopupView = JobsNoticePopupView.new;
        PopupView.mj_h = JobsMainScreen_HEIGHT() * 2 / 3;
        PopupView.mj_w = JobsMainScreen_WIDTH() - 12 * 2;
        [PopupView richElementsInViewWithModel:UIViewModel.new];
        [self setPopupView:PopupView];
        Jobs_setAssociatedRETAIN_NONATOMIC(_popupView, PopupView)
    }return PopupView;
}

-(void)setPopupView:(JobsNoticePopupView *)popupView{
    Jobs_setAssociatedRETAIN_NONATOMIC(_popupView, popupView)
}

@end
