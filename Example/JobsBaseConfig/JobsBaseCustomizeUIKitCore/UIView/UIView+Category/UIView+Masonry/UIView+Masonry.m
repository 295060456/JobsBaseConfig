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
/// 卸载当前view上的全部约束
-(void)uninstallAllLayoutAttribute{
    for (MASViewConstraint *constraint in [MASViewConstraint installedConstraintsForView:self]) {
        [constraint uninstall];
    }
}

@end
