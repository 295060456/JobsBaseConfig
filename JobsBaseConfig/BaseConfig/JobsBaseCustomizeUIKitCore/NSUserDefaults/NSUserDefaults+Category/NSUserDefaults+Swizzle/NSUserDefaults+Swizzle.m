//
//  NSUserDefaults+Swizzle.m
//  Casino
//
//  Created by Jobs on 2021/12/11.
//

#import "NSUserDefaults+Swizzle.h"

@implementation NSUserDefaults (Swizzle)

+ (void)load{
    {// 存
        Method originalMethod = class_getInstanceMethod(NSUserDefaults.class,@selector(setObject:forKey:));
        Method swizzledMethod = class_getInstanceMethod(NSUserDefaults.class,@selector(swizzleSetObject:forKey:));
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
    {// 取
        Method originalMethod = class_getInstanceMethod(NSUserDefaults.class, @selector(objectForKey:));
        Method swizzledMethod = class_getInstanceMethod(NSUserDefaults.class, @selector(swizzleObjectForKey:));
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

-(void)swizzleSetObject:(nullable id)value
                 forKey:(nullable NSString *)defaultName{
    // TODO 可以接入加解密的模块
    [self swizzleSetObject:value
                    forKey:defaultName];
    [NSUserDefaults.standardUserDefaults synchronize];// 强制让它存了立即写磁盘
}

-(nullable id)swizzleObjectForKey:(NSString *)defaultName{
    // TODO 可以接入加解密的模块
    return [self swizzleObjectForKey:defaultName];
}

@end
