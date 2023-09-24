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
    return objc_getAssociatedObject(self, @selector(jobsNotificationBlock));
}

-(void)setJobsNotificationBlock:(void (^)(NSNotification *))jobsNotificationBlock {
    objc_setAssociatedObject(self,
                             @selector(jobsNotificationBlock),
                             jobsNotificationBlock,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end
