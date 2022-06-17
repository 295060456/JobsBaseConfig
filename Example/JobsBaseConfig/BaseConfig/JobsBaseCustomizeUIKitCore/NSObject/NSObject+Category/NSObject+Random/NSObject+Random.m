//
//  NSObject+Random.m
//  Shooting
//
//  Created by Jobs on 2020/8/28.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "NSObject+Random.h"
/**
 
 在C中提供了rand()、srand()、random()、arc4random()几个函数
 
 使用 rand() 生成随机数
 printf("Random numbers are: %i %i\n",rand(),rand());
 1、在标准的C库中函数rand()可以生成0~RAND_MAX之间的一个随机数，其中RAND_MAX 是stdlib.h 中定义的一个整数，它与系统有关
 2、rand()函数没有输入参数，直接通过表达式rand()来引用
 3、因为rand()函数是按指定的顺序来产生整数，因此每次执行上面的语句都打印相同的两个值，所以说C语言的随机并不是真正意义上的随机，有时候也叫伪随机数
 4、我们通常通过为随机数生成器提供一粒新的随机种子。函数 srand()(来自stdlib.h)可以为随机数生成器播散种子。只要种子不同rand()函数就会产生不同的随机数序列
 5、srand()称为随机数生成器的初始化器
 
 arc4random() 是一个真正的伪随机算法，不需要生成随机种子。
 1、因为第一次调用的时候就会自动生成。而且范围是rand()的两倍
 2、在iPhone中，RAND_MAX是0x7fffffff (2147483647)，而arc4random()返回的最大值则是 0x100000000 (4294967296)
 
 精确度比较：arc4random() > random() > rand()

 */
@implementation NSObject (Random)
/// ❤️获取一个随机整数范围在【0、borderValue）： 包括0、不包括borderValue❤️
-(int)baseRandomNOContainBorderValue:(int)borderValue{
    return arc4random() % borderValue;
}
/// ❤️获取一个随机整数范围在【0、borderValue】： 包括0、包括borderValue❤️
-(int)baseRandomContainBorderValue:(int)borderValue{
    return arc4random() % (borderValue + 1);
}
/// ❤️获取一个随机整数范围在【offsetValue、borderValue）： 包括offsetValue、不包括borderValue❤️
-(int)baseRandomOffsetValue:(int)offsetValue noContainborderValue:(int)borderValue{
    return offsetValue + [self baseRandomNOContainBorderValue:borderValue - offsetValue];
}
/// ❤️获取一个随机整数范围在【offsetValue、borderValue】： 包括offsetValue、包括borderValue❤️
-(int)baseRandomOffsetValue:(int)offsetValue containborderValue:(int)borderValue{
    return offsetValue + [self baseRandomContainBorderValue:borderValue - offsetValue];
}
/// ❤️获取一个随机整数，范围在【from、to】：包括from，包括to❤️
-(int)getRandomNumberFrom:(int)from to:(int)to{
    return (int)(from + (arc4random() % to - from + 1));
}
/// ❤️用rand()随机生成在[x,y]内的整数。rand()%a的结果最大为a-1❤️
-(int)randomX:(int)x Y:(int)y{
    return x + rand() % (y - x + 1);
}
/// 示例：获取一个随机整数范围在【0、100）： 包括0、不包括100
-(int)random0_100{
    return [self baseRandomNOContainBorderValue:100];
}
/// 示例：获取一个随机整数范围在【0、100】： 包括0、包括100
-(int)random0__100{
    return [self baseRandomContainBorderValue:100];
}
/// 示例：获取一个随机数范围在：【100、200），包括100，不包括200
-(int)random100_200{
    return [self baseRandomOffsetValue:100 noContainborderValue:200];
}
/// 示例：获取一个随机数范围在：【100、200】，包括100，包括200
-(int)random100__200{
    return [self baseRandomOffsetValue:100 containborderValue:200];
}

@end
