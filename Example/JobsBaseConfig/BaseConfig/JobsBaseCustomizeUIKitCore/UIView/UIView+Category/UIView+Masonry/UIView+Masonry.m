//
//  UIView+Masonry.m
//  JobsBaseConfig
//
//  Created by Jobs on 2022/1/18.
//

#import "UIView+Masonry.h"

@implementation UIView (Masonry)
/// 卸载当前view上的某个方向的约束
-(void)uninstall:(NSLayoutAttribute)layoutAttribute{
    for (MASViewConstraint *constraint in [MASViewConstraint installedConstraintsForView:self]) {
        if (constraint.firstViewAttribute.layoutAttribute == layoutAttribute) {
            [constraint uninstall];
        }
    }
}
/// 自动卸载当前view上的全部约束
-(void)uninstallAllLayoutAttribute{
    for (MASViewConstraint *constraint in [MASViewConstraint installedConstraintsForView:self]) {
        [constraint uninstall];
    }
}
/// 通过外界传入的约束包卸载当前view上的约束
-(void)unstallViewConstraint:(NSMutableArray <MASConstraint *>*)constraintMutArr{
    for (MASConstraint *constraint in constraintMutArr) {
        [constraint uninstall];
    }
}
/// 记录该View的Masonry约束情况
static char *UIView_Masonry_constraintMutArr = "UIView_Masonry_constraintMutArr";
@dynamic constraintMutArr;
#pragma mark —— @property(nonatomic,strong)NSMutableArray <MASConstraint *>*constraintMutArr
-(NSMutableArray<MASConstraint *> *)constraintMutArr{
    NSMutableArray *ConstraintMutArr = objc_getAssociatedObject(self, UIView_Masonry_constraintMutArr);
    if (!ConstraintMutArr) {
        ConstraintMutArr = NSMutableArray.array;
        [self setConstraintMutArr:ConstraintMutArr];
    }return ConstraintMutArr;
}

-(void)setConstraintMutArr:(NSMutableArray<MASConstraint *> *)constraintMutArr{
    objc_setAssociatedObject(self,
                             UIView_Masonry_constraintMutArr,
                             constraintMutArr,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
