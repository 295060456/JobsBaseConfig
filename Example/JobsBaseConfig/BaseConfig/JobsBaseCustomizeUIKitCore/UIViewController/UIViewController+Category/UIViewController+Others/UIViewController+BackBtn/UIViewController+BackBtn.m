//
//  UIViewController+BackBtn.m
//  UBallLive
//
//  Created by Jobs on 2020/10/12.
//

#import "UIViewController+BackBtn.h"

@implementation UIViewController (BackBtn)
/// GKNavigationBar 返回按钮点击方法
-(void)backItemClick:(id)sender{
    [self backBtnClickEvent:sender];
}
/// 【创建返回键】没有配置按钮的normalImage属性，也没有配置点击事件
-(UIButton *)makeBackBtn:(UIViewModel *)viewModel{
    UIButton *backBtnCategory = UIButton.new;
    backBtnCategory.titleFont = viewModel.backBtnTitleModel.font;
    backBtnCategory.normalTitle = viewModel.backBtnTitleModel.text;
    backBtnCategory.normalTitleColor = viewModel.backBtnTitleModel.textCor ? : UIColor.blackColor;
    [backBtnCategory layoutButtonWithEdgeInsetsStyle:GLButtonEdgeInsetsStyleLeft
                                     imageTitleSpace:JobsWidth(8)];
    [backBtnCategory makeBtnLabelByShowingType:UILabelShowingType_03];
    return backBtnCategory;
}
/// 配置返回键图片
-(UIImage *)makeBackBtnImage{
    return self.viewModel.backBtnIMG ? : JobsBuddleIMG(nil,@"Frameworks/GKNavigationBar.framework/GKNavigationBar",nil,self.gk_backStyle == GKNavigationBarBackStyleBlack ? @"btn_back_black" : @"btn_back_white");
}
///【子类需要覆写 】创建返回键的点击事件
-(void)backBtnClickEvent:(UIButton *_Nullable)sender{
    switch (self.pushOrPresent) {
        case ComingStyle_PRESENT:{
            [self dismissViewControllerAnimated:YES completion:nil];
        }break;
        case ComingStyle_PUSH:{
            self.navigationController ? [self.navigationController popViewControllerAnimated:YES] : [self dismissViewControllerAnimated:YES completion:nil];
        }break;
            
        default:
            break;
    }
}
static char *BaseVC_BackBtn_backBtnCategory = "BaseVC_BackBtn_backBtnCategory";
@dynamic backBtnCategory;
#pragma mark —— @property(nonatomic,strong)BackBtn *backBtnCategory;
-(UIButton *)backBtnCategory{
    UIButton *BackBtnCategory = objc_getAssociatedObject(self, BaseVC_BackBtn_backBtnCategory);
    if (!BackBtnCategory) {
        BackBtnCategory = [self makeBackBtn:self.viewModel];
        @jobs_weakify(self)
        [BackBtnCategory btnClickEventBlock:^(UIButton *x) {
            @jobs_strongify(self)
            [self backBtnClickEvent:x];
        }];
        BackBtnCategory.normalImage = self.makeBackBtnImage;
        [self setBackBtnCategory:BackBtnCategory];
    }return BackBtnCategory;
}

-(void)setBackBtnCategory:(UIButton *)backBtnCategory{
    objc_setAssociatedObject(self,
                             BaseVC_BackBtn_backBtnCategory,
                             backBtnCategory,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
static char *BaseVC_BackBtn_backBtnCategoryItem = "BaseVC_BackBtn_backBtnCategoryItem";
@dynamic backBtnCategoryItem;
#pragma mark —— @property(nonatomic,strong)UIBarButtonItem *backBtnCategoryItem;
-(UIBarButtonItem *)backBtnCategoryItem{
    UIBarButtonItem *BackBtnCategoryItem = objc_getAssociatedObject(self, BaseVC_BackBtn_backBtnCategoryItem);
    if (!BackBtnCategoryItem) {
        BackBtnCategoryItem = [UIBarButtonItem.alloc initWithCustomView:self.backBtnCategory];
        [self setBackBtnCategoryItem:BackBtnCategoryItem];
    }return BackBtnCategoryItem;
}

-(void)setBackBtnCategoryItem:(UIBarButtonItem *)backBtnCategoryItem{
    objc_setAssociatedObject(self,
                             BaseVC_BackBtn_backBtnCategoryItem,
                             backBtnCategoryItem,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
