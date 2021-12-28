//
//  NSObject+DynamicInvoke.m
//  Casino
//
//  Created by Jobs on 2021/12/28.
//

#import "NSObject+DynamicInvoke.h"

@implementation NSObject (DynamicInvoke)

#pragma mark —— 参数 和 相关调用
/// 如果某个实例对象存在某个【不带参数的方法】，则对其调用执行
/// @param targetObj 靶点，方法在哪里
/// @param methodName 不带参数的方法名
+(void)targetObj:(nonnull NSObject *)targetObj
callingMethodWithName:(nullable NSString *)methodName{
    if ([NSObject judgementObj:targetObj existMethodWithName:methodName]) {
        SuppressWarcPerformSelectorLeaksWarning([targetObj performSelector:NSSelectorFromString(methodName)]);
    }else{
        NSLog(@"目标类：%@,不存在此方法：%@,请检查",targetObj.class,methodName);
    }
}
/// 如果某个实例对象存在某个【不带参数的方法】，则对其调用执行
/// @param methodName 不带参数的方法名
-(void)callingMethodWithName:(nullable NSString *)methodName{
    if ([NSObject judgementObj:self existMethodWithName:methodName]) {
        SuppressWarcPerformSelectorLeaksWarning([self performSelector:NSSelectorFromString(methodName)]);
    }else{
        NSLog(@"目标类：%@,不存在此方法：%@,请检查",self.class,methodName);
    }
}
/// 使用 dispatch_once 来执行只需运行一次的线程安全代码
/// @param methodName 需要执行的方法的方法名（不带参数）
-(void)dispatchOnceInvokingWithMethodName:(nullable NSString *)methodName{
    static dispatch_once_t NSObjectDispatchOnce;
    @jobs_weakify(self)
    dispatch_once(&NSObjectDispatchOnce, ^{
        [weak_self callingMethodWithName:methodName];
    });
}
/// NSInvocation的使用，方法多参数传递
/// @param methodName 方法名
/// @param targetObj 靶点，方法在哪里
/// @param paramarrays 参数数组
+(void)methodName:(NSString *_Nonnull)methodName
        targetObj:(id _Nonnull)targetObj
      paramarrays:(NSArray *_Nullable)paramarrays{
    SEL selector = NSSelectorFromString(methodName);
    /*
     NSMethodSignature有两个常用的只读属性
     a. numberOfArguments:方法参数的个数
     b. methodReturnLength:方法返回值类型的长度，大于0表示有返回值
     **/
    NSMethodSignature *signature = [targetObj methodSignatureForSelector:selector];
    //或使用下面这种方式
    //NSMethodSignature *signature = [[target class] instanceMethodSignatureForSelector:selector];
    
    if (!signature) {
        // 处理方式一：
        {
            [WHToast toastErrMsg:@"方法不存在,请检查参数"];
            return;
        }
        // 处理方式二：【经常崩溃损伤硬件】
//        {
//            //传入的方法不存在 就抛异常
//            NSString *info = [NSString stringWithFormat:@"-[%@ %@]:unrecognized selector sent to instance",[self class],NSStringFromSelector(selector)];
//            @throw [[NSException alloc] initWithName:@"方法不存在"
//                                              reason:info
//                                            userInfo:nil];
//        }
    }
    
    //只能使用该方法来创建，不能使用alloc init
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    invocation.target = targetObj;
    invocation.selector = selector;
    /*
     注意:
     1、下标从2开始，因为0、1已经被target与selector占用
     2、设置参数，必须传递参数的地址，不能直接传值
     **/
    for (int i = 2; i < paramarrays.count + 2; i++) {
        NSLog(@"i = %d",i);
        id d = paramarrays[i - 2];
        [invocation setArgument:&d atIndex:i];
    }
    // 执行方法
    [invocation invoke];
    //可以在invoke方法前添加，也可以在invoke方法后添加
    //通过方法签名的methodReturnLength判断是否有返回值
    if (signature.methodReturnLength > 0) {
        NSString *result = nil;
        [invocation getReturnValue:&result];
        NSLog(@"result = %@",result);
    }
}
/// 判断本程序是否存在某个类
+(BOOL)judgementAppExistClassWithName:(nullable NSString *)className{
    return NSClassFromString(className);
}
/// 判断某个实例对象是否存在某个【不带参数的方法】
+(BOOL)judgementObj:(nonnull NSObject *)obj
existMethodWithName:(nullable NSString *)methodName{
    if (!obj || [NSString isNullString:methodName]) {
        return NO;
    }else{
        SEL sel = NSSelectorFromString(methodName);
        return [obj respondsToSelector:sel];
    }
}
/// 用block来代替selector
SEL _Nullable selectorBlocks(void (^_Nullable block)(id _Nullable weakSelf, id _Nullable arg),
                             id _Nullable target){
    if (!block) {
        [NSException raise:@"block can not be nil"
                    format:@"%@ selectorBlock error", target];
    }
    NSString *selName = [NSString stringWithFormat:@"selector_%p:", block];
    SEL sel = NSSelectorFromString(selName);
    class_addMethod([target class],
                    sel,
                    (IMP)selectorImp,
                    "v@:@");
    objc_setAssociatedObject(target,
                             sel,
                             block,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
    return sel;
}

static void selectorImp(id self,
                        SEL _cmd,
                        id arg) {
    callback block = objc_getAssociatedObject(self, _cmd);
    __weak typeof(self) weakSelf = self;
    if (block) {
        block(weakSelf, arg);
    }
}

@end
