//
//  NSNotificationCenter+JobsBlock.m
//  JobsBaseConfig
//
//  Created by Jobs Hi on 9/24/23.
//

#import "NSNotificationCenter+JobsBlock.h"
#import <objc/runtime.h>

@implementation NSNotificationCenter (JobsBlock)

-(void (^)(NSNotification *))jobsNotificationBlock {
    return objc_getAssociatedObject(self, _cmd);
}

-(void)setJobsNotificationBlock:(void (^)(NSNotification *))jobsNotificationBlock {
    objc_setAssociatedObject(self,
                             _cmd,
                             jobsNotificationBlock,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end
