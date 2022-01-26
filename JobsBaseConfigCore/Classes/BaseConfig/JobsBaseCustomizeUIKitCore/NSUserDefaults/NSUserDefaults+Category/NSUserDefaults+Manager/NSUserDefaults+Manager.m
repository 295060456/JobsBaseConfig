//
//  NSUserDefaults+Manager.m
//  Casino
//
//  Created by Jobs on 2021/12/1.
//

#import "NSUserDefaults+Manager.h"

@implementation NSUserDefaults (Manager)

/// CRUD（create, read, update, delete）

/// 存数据
+(void)updateWithModel:(UserDefaultModel *)userDefaultModel{
    if (![NSString isNullString:userDefaultModel.key]) {
        if (userDefaultModel.obj && ![userDefaultModel.obj isKindOfClass:NSNull.class]) {
            /// 例如：自定义的Model，因为没有被序列化所以直接存不进去，会报错误❌attempt to insert non-property list object❌
            /// 所以需要mj_JSONString，对象Json序列化后存入
            [NSUserDefaults.standardUserDefaults setObject:userDefaultModel.obj.mj_JSONString
                                                    forKey:userDefaultModel.key];
            [NSUserDefaults.standardUserDefaults synchronize];
            NSLog(@"%@",NSString.userDefaultsDir);
            return;
        }
        
        if (userDefaultModel.booLValue) {
            [NSUserDefaults.standardUserDefaults setBool:userDefaultModel.booLValue
                                                  forKey:userDefaultModel.key];
            [NSUserDefaults.standardUserDefaults synchronize];
            NSLog(@"%@",NSString.userDefaultsDir);
            return;
        }
    }
}
/// 读取数据
+(NSObject *_Nullable)readWithKey:(NSString *)key{
    NSObject *data = nil;
    if (![NSString isNullString:key]){
        data = [NSUserDefaults.standardUserDefaults valueForKey:key];
        data = data.mj_JSONObject;
    }return data;
}
/// 删除数据
+(void)deleteWithKey:(NSString *)key{
    if (![NSString isNullString:key]){
        [NSUserDefaults.standardUserDefaults removeObjectForKey:key];
        [NSUserDefaults.standardUserDefaults synchronize];
    }
}

@end
