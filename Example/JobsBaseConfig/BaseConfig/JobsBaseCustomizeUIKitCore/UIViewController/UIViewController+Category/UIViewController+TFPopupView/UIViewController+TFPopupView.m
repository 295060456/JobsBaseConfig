//
//  UIViewController+TFPopupView.m
//  BaiShaEntertainmentProj
//
//  Created by Jobs on 2022/5/29.
//

#import "UIViewController+TFPopupView.h"

@implementation UIViewController (TFPopupView)

//#pragma mark —— TFPopupDelegate
///// 在 tf_hide 之后执行
//- (BOOL)tf_popupViewWillHide:(UIView *)popup{
//    if (self.filterBtn.selected) {
//        [self.filterBtn changeAction: 0];
//        self.filterBtn.selected = !self.filterBtn.selected;
//    }return YES;
//}
//
//- (BOOL)tf_popupViewWillShow:(UIView *)popup{
//    [self.popUpFiltrationView showDefaultBackground];
//    return YES;
//}

/// 弹出筛选视图
-(UIView *)popUpFiltrationView{
    self.popupParameter.disuseBackgroundTouchHide = NO;
    CGRect targetFrame = CGRectMake(0,
                                    0,
                                    [BaiShaETProjFiltrationView viewSizeWithModel:nil].width,
                                    [BaiShaETProjFiltrationView viewSizeWithModel:nil].height);
    if ([self isKindOfClass:UIViewController.class]) {
        [self.filtrationView tf_showFold:self.view
                             targetFrame:targetFrame
                               direction:PopupDirectionTop
                              popupParam:self.popupParameter];
    }return self.filtrationView;
}
/// 弹出自定义视图
-(UIView *)popUpCustomView{
    self.popupParameter.disuseBackgroundTouchHide = NO;
    CGRect targetFrame = CGRectMake(0,
                                    0,
                                    [BaiShaETProjCustomView viewSizeWithModel:nil].width,
                                    [BaiShaETProjCustomView viewSizeWithModel:nil].height);
    if ([self isKindOfClass:UIViewController.class]) {
        [self.customView tf_showFold:self.view
                         targetFrame:targetFrame
                           direction:PopupDirectionTop
                          popupParam:self.popupParameter];
    }return self.customView;
}
/// 关闭弹出的视图
-(void)hidePopupView:(UIView *)popupView{
    [popupView tf_hide];
}
static char *UIViewController_TFPopupView_filtrationView = "UIViewController_TFPopupView_filtrationView";
@dynamic filtrationView;
#pragma mark —— @property(nonatomic,strong)BaiShaETProjFiltrationView *filtrationView;/// 过滤
-(BaiShaETProjFiltrationView *)filtrationView{
    BaiShaETProjFiltrationView *FiltrationView = objc_getAssociatedObject(self, UIViewController_TFPopupView_filtrationView);
    if (!FiltrationView) {
        FiltrationView = BaiShaETProjFiltrationView.new;
        FiltrationView.size = [BaiShaETProjFiltrationView viewSizeWithModel:nil];
        [FiltrationView richElementsInViewWithModel:nil];
        
        objc_setAssociatedObject(self,
                                 UIViewController_TFPopupView_filtrationView,
                                 FiltrationView,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return FiltrationView;
}

-(void)setFiltrationView:(BaiShaETProjFiltrationView *)filtrationView{
    objc_setAssociatedObject(self,
                             UIViewController_TFPopupView_filtrationView,
                             filtrationView,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
static char *UIViewController_TFPopupView_customView = "UIViewController_TFPopupView_customView";
@dynamic customView;
#pragma mark —— @property(nonatomic,strong)BaiShaETProjCustomView *customView;/// 自定义
-(BaiShaETProjCustomView *)customView{
    BaiShaETProjCustomView *CustomView = objc_getAssociatedObject(self, UIViewController_TFPopupView_customView);
    if (!CustomView) {
        CustomView = BaiShaETProjCustomView.new;
        CustomView.size = [BaiShaETProjFiltrationView viewSizeWithModel:nil];
        [CustomView richElementsInViewWithModel:nil];
        
        objc_setAssociatedObject(self,
                                 UIViewController_TFPopupView_customView,
                                 CustomView,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
    }return CustomView;
}

-(void)setCustomView:(BaiShaETProjCustomView *)customView{
    objc_setAssociatedObject(self,
                             UIViewController_TFPopupView_customView,
                             customView,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


@end
