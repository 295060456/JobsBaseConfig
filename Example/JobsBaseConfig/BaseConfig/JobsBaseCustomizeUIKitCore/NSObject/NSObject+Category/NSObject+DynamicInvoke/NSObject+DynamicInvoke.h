//
//  NSObject+DynamicInvoke.h
//  Casino
//
//  Created by Jobs on 2021/12/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (DynamicInvoke)

#pragma mark —— 参数 和 相关调用
/// 如果某个实例对象存在某个【不带参数的方法】，则对其调用执行
/// @param targetObj 靶点，方法在哪里
/// @param methodName 不带参数的方法名
+(void)targetObj:(nonnull NSObject *)targetObj
callingMethodWithName:(nullable NSString *)methodName;
/// 如果某个实例对象存在某个【不带参数的方法】，则对其调用执行
/// @param methodName 不带参数的方法名
-(void)callingMethodWithName:(nullable NSString *)methodName;
/// 使用 dispatch_once 来执行只需运行一次的线程安全代码
/// @param methodName 需要执行的方法的方法名（不带参数）
-(void)dispatchOnceInvokingWithMethodName:(nullable NSString *)methodName;
/// NSInvocation的使用，方法多参数传递
/// @param methodName 方法名
/// @param targetObj 靶点，方法在哪里
/// @param paramarrays 参数数组
+(id)methodName:(NSString *_Nonnull)methodName
      targetObj:(id _Nonnull)targetObj
    paramarrays:(NSArray *_Nullable)paramarrays;
/// 获取方法返回值
/// @param inv inv
/// @param sig 方法签名
+(id)getMethodReturnValueWithInv:(NSInvocation *)inv
                             sig:(NSMethodSignature *)sig;
/// 判断本程序是否存在某个类
+(BOOL)judgementAppExistClassWithName:(nullable NSString *)className;
/// 判断某个实例对象是否存在某个【不带参数的方法】
+(BOOL)judgementObj:(nonnull NSObject *)obj
existMethodWithName:(nullable NSString *)methodName;
/// 用block来代替selector
SEL _Nullable selectorBlocks(void (^_Nullable block)(id _Nullable weakSelf, id _Nullable arg),
                             id _Nullable target);


@end

NS_ASSUME_NONNULL_END
