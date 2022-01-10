//
//  UIWindow+Extra.m
//  JobsBaseConfig
//
//  Created by Jobs on 2022/1/10.
//

#import "UIWindow+Extra.h"

@implementation UIWindow (Extra)

-(void)touchesBegan:(NSSet<UITouch *> *)touches
          withEvent:(UIEvent *)event{
    if (self.viewBlock) self.viewBlock(@1);
}

@end
