//
//  UIScrollView+XSAnimationKit.m
//  Casino
//
//  Created by Jobs on 2022/1/7.
//

#import "UIScrollView+XSAnimationKit.h"

@implementation UIScrollView (XSAnimationKit)

-(void)xs_showScrollViewAnimationWithType:(XSScrollViewAnimationType)animationType{
    [UIScrollViewAnimationKit showWithAnimationType:animationType scrollView:self];
}

@end
