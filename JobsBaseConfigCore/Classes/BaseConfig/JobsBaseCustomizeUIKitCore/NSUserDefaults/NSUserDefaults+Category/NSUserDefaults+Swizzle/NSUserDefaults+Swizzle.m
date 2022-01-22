//
//  NSUserDefaults+Swizzle.m
//  Casino
//
//  Created by Jobs on 2021/12/11.
//

#import "NSUserDefaults+Swizzle.h"

@implementation NSUserDefaults (Swizzle)

+(void)load{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        /// Object 存
        MethodSwizzle(NSUserDefaults.class,
                      @selector(setObject:forKey:),
                      @selector(swizzleSetObject:forKey:));
        /// Object 取
        MethodSwizzle(NSUserDefaults.class,
                      @selector(objectForKey:),
                      @selector(swizzleObjectForKey:));
        /// Value 存
        MethodSwizzle(NSUserDefaults.class,
                      @selector(setValue:forKey:),
                      @selector(swizzleSetValue:forKey:));
        /// Value 取
        MethodSwizzle(NSUserDefaults.class,
                      @selector(valueForKey:),
                      @selector(swizzleValueForKey:));
        /// Bool 存
        MethodSwizzle(NSUserDefaults.class,
                      @selector(setBool:forKey:),
                      @selector(swizzleSetBool:forKey:));
        /// Bool 取
        MethodSwizzle(NSUserDefaults.class,
                      @selector(boolForKey:),
                      @selector(swizzleBoolForKey:));
        /// Remove
        MethodSwizzle(NSUserDefaults.class,
                      @selector(removeObjectForKey:),
                      @selector(swizzleRemoveObjectForKey:));
    });
}
#pragma mark —— Object
-(void)swizzleSetObject:(id _Nonnull)object
                 forKey:(NSString *_Nonnull)key{
    // TODO 可以接入加解密的模块
    [self swizzleSetObject:object
                    forKey:key];
    [NSUserDefaults.standardUserDefaults synchronize];// 强制让它存了立即写磁盘
}

-(nullable id)swizzleObjectForKey:(NSString *_Nonnull)key{
    // TODO 可以接入加解密的模块
    return [self swizzleObjectForKey:key];
}
#pragma mark —— Value
-(void)swizzleSetValue:(id _Nonnull)value
                forKey:(NSString *_Nonnull)key{
    // TODO 可以接入加解密的模块
    [self swizzleSetValue:value
                   forKey:key];
    [NSUserDefaults.standardUserDefaults synchronize];// 强制让它存了立即写磁盘
}

-(nullable id)swizzleValueForKey:(NSString *_Nonnull)key{
    // TODO 可以接入加解密的模块
    return [self swizzleValueForKey:key];
}
#pragma mark —— Bool
-(void)swizzleSetBool:(BOOL)boolValue
               forKey:(NSString *_Nonnull)key{
    // TODO 可以接入加解密的模块
    [self swizzleSetBool:boolValue
                  forKey:key];
    [NSUserDefaults.standardUserDefaults synchronize];// 强制让它存了立即写磁盘
}

-(BOOL)swizzleBoolForKey:(NSString *_Nonnull)key{
    // TODO 可以接入加解密的模块
    return [self swizzleBoolForKey:key];
}
#pragma mark —— removeObject
-(void)swizzleRemoveObjectForKey:(NSString *_Nonnull)key{
    [self swizzleRemoveObjectForKey:key];
    [NSUserDefaults.standardUserDefaults synchronize];// 强制让它存了立即写磁盘
}

@end
