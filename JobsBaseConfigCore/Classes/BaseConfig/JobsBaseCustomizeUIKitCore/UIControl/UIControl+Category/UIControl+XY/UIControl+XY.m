//
//  UIControl+XY.m
//  JinXian Finance
//
//  Created by 刘赓 on 2017/7/17.
//  Copyright © 2017年 刘赓. All rights reserved.
//

#import "UIControl+XY.h"

@implementation UIControl (XY)

static const char *UIControl_acceptEventInterval = "UIControl_acceptEventInterval";
static const char *UIControl_ignoreEvent = "UIControl_ignoreEvent";

+(void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        MethodSwizzle(self, @selector(sendAction:to:forEvent:), @selector(__uxy_sendAction:to:forEvent:));
    });
}
/// 点击后会先进入这里
- (void)__uxy_sendAction:(SEL)action
                      to:(id)target
                forEvent:(UIEvent *)event{
    if (self.uxy_ignoreEvent) return;//根据状态判断是否继续执行
    if (self.uxy_acceptEventInterval > 0){
        self.uxy_ignoreEvent = YES;
        //周期性清空标志位
        [self performSelector:@selector(setUxy_ignoreEvent:)
                   withObject:@(NO)
                   afterDelay:self.uxy_acceptEventInterval];
    }
    //这里其实是系统的原来的sendAction to方法。
    [self __uxy_sendAction:action
                        to:target
                  forEvent:event];
}
#pragma mark —— @property(nonatomic,assign)NSTimeInterval uxy_acceptEventInterval;//可以用这个给重复点击加间隔
- (NSTimeInterval)uxy_acceptEventInterval{
    return [objc_getAssociatedObject(self, UIControl_acceptEventInterval) doubleValue];
}

- (void)setUxy_acceptEventInterval:(NSTimeInterval)uxy_acceptEventInterval{
    objc_setAssociatedObject(self,
                             UIControl_acceptEventInterval,
                             @(uxy_acceptEventInterval),
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(BOOL)uxy_ignoreEvent{
    return [objc_getAssociatedObject(self, UIControl_ignoreEvent) boolValue];
}

-(void)setUxy_ignoreEvent:(BOOL)uxy_ignoreEvent{
    objc_setAssociatedObject(self,
                             UIControl_ignoreEvent,
                             @(uxy_ignoreEvent),
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

