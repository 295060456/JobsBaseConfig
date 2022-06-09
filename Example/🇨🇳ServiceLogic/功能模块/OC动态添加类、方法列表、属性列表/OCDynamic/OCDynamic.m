//
//  OCDynamic.m
//  JobsBaseConfig
//
//  Created by Jobs on 2022/6/9.
//

#import "OCDynamic.h"

@implementation OCDynamic

- (void)dealloc{
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
    //    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)init{
    if (self = [super init]) {
        NSLog(@"");
    }return self;
}

+(BOOL)resolveInstanceMethod:(SEL)sel{
    if (sel == @selector(test)) {
        Method method = class_getInstanceMethod(self, @selector(instanceMethod));
        class_addMethod(self,
                        sel,
                        method_getImplementation(method),
                        method_getTypeEncoding(method));
        return YES;
    }return [super resolveInstanceMethod:sel];
}


+ (BOOL)resolveClassMethod:(SEL)sel{
    if (sel == @selector(Test)) {
        Method method = class_getClassMethod(object_getClass(self.class), @selector(classMethod));
        class_addMethod(object_getClass(self.class),
                        sel,
                        method_getImplementation(method),
                        method_getTypeEncoding(method));
        return YES;
    }return [super resolveClassMethod:sel];
}

-(void)instanceMethod{
    NSLog(@"");
}

+(void)classMethod{
    NSLog(@"");
}

@end
