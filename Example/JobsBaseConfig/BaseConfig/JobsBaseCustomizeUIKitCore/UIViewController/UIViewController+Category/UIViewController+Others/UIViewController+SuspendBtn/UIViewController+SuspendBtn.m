//
//  UIViewController+SuspendBtn.m
//  Casino
//
//  Created by Jobs on 2021/12/15.
//

#import "UIViewController+SuspendBtn.h"

@implementation UIViewController (SuspendBtn)

static char *UIViewController_SuspendBtn_suspendBtn = "UIViewController_SuspendBtn_suspendBtn";
@dynamic suspendBtn;
#pragma mark —— @property(nonatomic,strong)JobsSuspendBtn *suspendBtn;
-(JobsSuspendBtn *)suspendBtn{
    JobsSuspendBtn *SuspendBtn = objc_getAssociatedObject(self, UIViewController_SuspendBtn_suspendBtn);
    if (!SuspendBtn) {
        SuspendBtn = JobsSuspendBtn.new;
        SuspendBtn.normalImage = JobsIMG(@"旋转");
        SuspendBtn.isAllowDrag = YES;//悬浮效果必须要的参数
        @jobs_weakify(self)
        [SuspendBtn jobsBtnClickEventBlock:^(UIButton *x) {
            @jobs_strongify(self)
            x.selected = !x.selected;
            NSLog(@"%@",x.selected ? Internationalization(@"开始旋转") : Internationalization(@"停止旋转"));
//            [x rotateAnimation:x.selected];
            if (self.objectBlock) self.objectBlock(x);
        }];
        self.view.vc = weak_self;
        [self.view addSubview:SuspendBtn];

        SuspendBtn.frame = CGRectMake(JobsMainScreen_WIDTH() - JobsWidth(50) - JobsWidth(5),
                                      JobsMainScreen_HEIGHT() - JobsTabBarHeightByBottomSafeArea(nil) - JobsWidth(100),
                                      JobsWidth(50),
                                      JobsWidth(50));
        [SuspendBtn cornerCutToCircleWithCornerRadius:SuspendBtn.width / 2];
        [self setSuspendBtn:SuspendBtn];
    }return SuspendBtn;
}

-(void)setSuspendBtn:(JobsSuspendBtn *)suspendBtn{
    objc_setAssociatedObject(self,
                             UIViewController_SuspendBtn_suspendBtn,
                             suspendBtn,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
