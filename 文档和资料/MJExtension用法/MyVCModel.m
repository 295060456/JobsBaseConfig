//
//  MyVCModel.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/7/22.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "MyVCModel.h"

@implementation VideoListModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    /* 返回的字典，key为模型属性名，value为转化的字典的多级key */
    return @{
             @"ID" : @"id"
             };
}

@end

@implementation MyVCModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{
             @"videoListModel" : @"VideoListModel"
             };
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    /* 返回的字典，key为模型属性名，value为转化的字典的多级key */
    return @{
             @"ID" : @"id",
             @"Delete" : @"delete"
             };
}


@end
