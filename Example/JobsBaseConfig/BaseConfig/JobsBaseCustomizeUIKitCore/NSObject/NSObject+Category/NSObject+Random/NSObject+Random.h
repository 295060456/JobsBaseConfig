//
//  NSObject+Random.h
//  Shooting
//
//  Created by Jobs on 2020/8/28.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Random)
/// ❤️获取一个随机整数范围在【0、borderValue）： 包括0、不包括borderValue❤️
-(int)baseRandomNOContainBorderValue:(int)borderValue;
/// ❤️获取一个随机整数范围在【0、borderValue】： 包括0、包括borderValue❤️
-(int)baseRandomContainBorderValue:(int)borderValue;
/// ❤️获取一个随机整数范围在【offsetValue、borderValue）： 包括offsetValue、不包括borderValue❤️
-(int)baseRandomOffsetValue:(int)offsetValue noContainborderValue:(int)borderValue;
/// ❤️获取一个随机整数范围在【offsetValue、borderValue】： 包括offsetValue、包括borderValue❤️
-(int)baseRandomOffsetValue:(int)offsetValue containborderValue:(int)borderValue;
/// ❤️获取一个随机整数，范围在【from、to】：包括from，包括to❤️
-(int)getRandomNumberFrom:(int)from to:(int)to;
/// ❤️用rand()随机生成在[x,y]内的整数。rand()%a的结果最大为a-1❤️
-(int)randomX:(int)x Y:(int)y;
/// 示例：获取一个随机整数范围在【0、100）： 包括0、不包括100
-(int)random0_100;
/// 示例：获取一个随机整数范围在【0、100】： 包括0、包括100
-(int)random0__100;
/// 示例：获取一个随机数范围在：【100、200），包括100，不包括200
-(int)random100_200;
/// 示例：获取一个随机数范围在：【100、200】，包括100，包括200
-(int)random100__200;

@end

NS_ASSUME_NONNULL_END
