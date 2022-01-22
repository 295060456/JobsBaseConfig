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
        [SuspendBtn normalImage:KIMG(@"旋转")];
        SuspendBtn.isAllowDrag = YES;//悬浮效果必须要的参数
        BtnClickEvent(SuspendBtn, {
            [x startRotateAnimation];
        });
        self.view.vc = weak_self;
        [self.view addSubview:SuspendBtn];
        SuspendBtn.frame = CGRectMake(JobsWidth(80),
                                       JobsWidth(100),
                                       JobsWidth(50),
                                       JobsWidth(50));
        [SuspendBtn cornerCutToCircleWithCornerRadius:SuspendBtn.width / 2];
        objc_setAssociatedObject(self,
                                 UIViewController_SuspendBtn_suspendBtn,
                                 SuspendBtn,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return SuspendBtn;
}

-(void)setSuspendBtn:(JobsSuspendBtn *)suspendBtn{
    objc_setAssociatedObject(self,
                             UIViewController_SuspendBtn_suspendBtn,
                             suspendBtn,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
