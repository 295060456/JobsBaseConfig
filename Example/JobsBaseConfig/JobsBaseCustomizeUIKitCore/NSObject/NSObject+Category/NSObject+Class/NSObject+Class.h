//
//  NSObject+Class.h
//  Casino
//
//  Created by Jobs on 2021/12/3.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

#if __has_include(<MJExtension/MJExtension.h>)
#import <MJExtension/MJExtension.h>
#else
#import "MJExtension.h"
#endif

NS_ASSUME_NONNULL_BEGIN
/// 返回并打印成员变量列表
static inline NSMutableArray <NSString *>* printIvarList(id instanceObj){
    unsigned int count;
    NSMutableArray *tempDataMutArr = NSMutableArray.array;
    Ivar *ivarList = class_copyIvarList([instanceObj class], &count);
    for (unsigned int i = 0; i < count; i++) {
        Ivar myIvar = ivarList[i];
        const char *ivarName = ivar_getName(myIvar);
        NSLog(@"ivar(%d) : %@", i, [NSString stringWithUTF8String:ivarName]);
        [tempDataMutArr addObject:[NSString stringWithUTF8String:ivarName]];
    }free(ivarList);
    return tempDataMutArr;
}
/// 返回并打印属性列表
static inline NSMutableArray <NSString *>* printPropertyList(id instanceObj){
    unsigned int count;
    NSMutableArray *tempDataMutArr = NSMutableArray.array;
    objc_property_t *propertyList = class_copyPropertyList([instanceObj class], &count);
    for (unsigned int i = 0; i < count; i++) {
        const char *propertyName = property_getName(propertyList[i]);
        NSLog(@"propertyName(%d) : %@", i, [NSString stringWithUTF8String:propertyName]);
        [tempDataMutArr addObject:[NSString stringWithUTF8String:propertyName]];
    }free(propertyList);
    return tempDataMutArr;
}
/// 返回并打印方法列表
static inline NSMutableArray <NSString *>* printMethodList(id instanceObj){
    unsigned int count;
    NSMutableArray *tempDataMutArr = NSMutableArray.array;
    Method *methodList = class_copyMethodList([instanceObj class], &count);
    for (unsigned int i = 0; i < count; i++) {
        Method method = methodList[i];
        NSLog(@"method(%d) : %@", i, NSStringFromSelector(method_getName(method)));
        [tempDataMutArr addObject:NSStringFromSelector(method_getName(method))];
    }free(methodList);
    return tempDataMutArr;
}
/// 返回并打印协议列表
static inline NSMutableArray <NSString *>* printProtocolList(id instanceObj){
    unsigned int count;
    NSMutableArray *tempDataMutArr = NSMutableArray.array;
    __unsafe_unretained Protocol **protocolList = class_copyProtocolList([instanceObj class], &count);
    for (unsigned int i = 0; i < count; i++) {
        Protocol *myProtocal = protocolList[i];
        const char *protocolName = protocol_getName(myProtocal);
        NSLog(@"protocol(%d) : %@", i, [NSString stringWithUTF8String:protocolName]);
        [tempDataMutArr addObject:[NSString stringWithUTF8String:protocolName]];
    }free(protocolList);
    return tempDataMutArr;
}

@interface NSObject (Class)
/// 返回并打印成员变量列表
-(NSMutableArray <NSString *>*)printIvarList;
/// 返回并打印属性列表
-(NSMutableArray <NSString *>*)printPropertyList;
/// 返回并打印方法列表
-(NSMutableArray <NSString *>*)printMethodList;
/// 返回并打印协议列表
-(NSMutableArray <NSString *>*)printProtocolList;
/**
    1、字典是hash映射，是无序的，如果需要有序则需要避开字典，所以对模型进行操作是大前提
    2、字典和模型的差距在于序列化
    3、字典化的模型里面，依据有序的（从上至下）属性名字排列，去取值，映射到数组里面
 */
-(NSMutableArray *)readModelPropertyValueByOrder;

@end

NS_ASSUME_NONNULL_END
