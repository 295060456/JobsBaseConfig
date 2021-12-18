//
//  NSObject+Association.m
//  Casino
//
//  Created by Jobs on 2021/12/17.
//

#import "NSObject+Association.h"

@implementation NSObject (Association)
/**
 参考资料：https://juejin.cn/post/6869670856705081358
 */
+ (void)loader{//用的时候改为load
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class aClass = [self class];
        
        SEL originalSelector = @selector(method_original:);
        SEL swizzledSelector = @selector(method_swizzle:);
        
        Method originalMethod = class_getInstanceMethod(aClass, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(aClass, swizzledSelector);
        
        /**
         * 通过class_addMethod：判断该类实现了原始方法还是父类实现了原始方法
         * aClass，当前类
         * originalSelector ，如果class_addMethod返回YES，originalSelector就是指向父类的方法；如果返回NO，originalSelector就是指向当前类的方法；
         * method_getImplementation(swizzledMethod) ，自定义方法的IMP
         * method_getTypeEncoding(swizzledMethod)，自定义方法的类型
         */
       
        BOOL didAddMethod = class_addMethod(aClass,
                                            originalSelector,
                                            method_getImplementation(swizzledMethod),
                                            method_getTypeEncoding(swizzledMethod));
        
        if (didAddMethod) {
            /**
             * 如果添加成功，证明这个类没有实现要替换的方法，而是继承了父类的实现；
             * 接下来要做的是--使用class_replaceMethod交换IMP，
             * 下面就是将（swizzledSelector）与（method_getImplementation(originalMethod)）的IMP交换；
             */
            class_replaceMethod(aClass,
                               swizzledSelector,
                               method_getImplementation(originalMethod),
                               method_getTypeEncoding(originalMethod)
                               );
        } else {
            // 【如果添加失败，证明这个类实现了原始方法；交换IMP，originalMethod—swizzledMethod】write by erliucxy
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}
/**
 * 对应系统的 objc_setAssociatedObject方法，在此基础上动态创建类，以及加dealloc方法
 * ⚠️关于dealloc方法，此前的验证是没有被释放需要手动添加，但是后来验证又不需要，这里需要反复多次验证
 */
void objc_setAssociatedObject_weak(id _Nonnull object,
                                   const void * _Nonnull key,
                                   id _Nullable value,
                                   objc_AssociationPolicy associationPolicy) {
    /// 子类的名字
    NSString *name = [NSString stringWithFormat:@"AssociationWeak_%@", NSStringFromClass([value class])];
    Class class = objc_getClass(name.UTF8String);
    /// 如果子类不存在，动态创建子类
    if (!class) {
        class = objc_allocateClassPair([value class], name.UTF8String, 0);
        objc_registerClassPair(class);
    }
    
    SEL deallocSEL = NSSelectorFromString(@"dealloc");
    Method deallocMethod = class_getInstanceMethod([value class], deallocSEL);
    const char *types = method_getTypeEncoding(deallocMethod);
    /// 在子类dealloc方法中将object的指针置为nil
    IMP imp = imp_implementationWithBlock(^(id _s, int k) {
        objc_setAssociatedObject(object,
                                 key,
                                 nil,
                                 associationPolicy);
    });
    /// 添加子类的dealloc方法
    class_addMethod(class,
                    deallocSEL,
                    imp,
                    types);
    /// 将value的isa指向动态创建的子类
    object_setClass(value,
                    class);
    
    objc_setAssociatedObject(object,
                             key,
                             value,
                             associationPolicy);
}


@end
