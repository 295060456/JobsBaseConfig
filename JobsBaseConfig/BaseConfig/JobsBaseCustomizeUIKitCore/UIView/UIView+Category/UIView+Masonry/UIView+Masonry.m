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
    NSMutableArray *mutArr = [NSMutableArray arrayWithArray:[MASViewConstraint installedConstraintsForView:self]];
    for (MASViewConstraint *constraint in mutArr) {
        if (constraint.firstViewAttribute.layoutAttribute == layoutAttribute) {
            [constraint uninstall];
        }
    }
}

@end
