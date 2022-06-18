//
//  VoidByCertainParameters.h
//  JobsBaseConfig
//
//  Created by Jobs on 2022/1/27.
//

#ifndef VoidByCertainParameters_h
#define VoidByCertainParameters_h
///【 确定入参个数 并且 没有返回值的Block定义】
#pragma mark —— 单形参
/// 1、没有入参、且没有返回值的Block定义
typedef void(^jobsByVoidBlock)(void);
/// 2、入参为其他数据类型、 且没有返回值的Block定义
typedef void(^jobsByIDBlock)(id data);
typedef void(^jobsByGestureRecognizerBlock)(UIGestureRecognizer *data);
typedef void(^jobsBySELBlock)(SEL data);
typedef void(^jobsByStringBlock)(NSString *data);
/// 3、入参为基本数据类型、 且没有返回值的Block定义
typedef void(^jobsByNSIntegerBlock)(NSInteger data);
typedef void(^jobsByNSUIntegerBlock)(NSUInteger data);
typedef void(^jobsByCGFloatBlock)(CGFloat data);
typedef void(^jobsByBOOLBlock)(BOOL data);
typedef void(^jobsByIntBlock)(int data);
typedef void(^jobsByUnsignedIntBlock)(unsigned int data);
typedef void(^jobsByFloatBlock)(float data);
typedef void(^jobsByDoubleBlock)(double data);
typedef void(^jobsByCharBlock)(char data);
typedef void(^jobsByUnsignedCharBlock)(unsigned char data);
typedef void(^jobsByShortBlock)(short data);
typedef void(^jobsByUnsignedShortBlock)(unsigned short data);
typedef void(^jobsByLongBlock)(long data);
typedef void(^jobsByUnsignedLongBlock)(unsigned long data);
typedef void(^jobsByUnsignedLongLongBlock)(unsigned long long data);
#pragma mark —— 多形参
/// 4、入参个数为2~10的ID类型、且没有返回值的Block定义
typedef void(^jobsByTwoIDBlock)(id data,id data2);
typedef void(^jobsByThreeIDBlock)(id data,id data2,id data3);
typedef void(^jobsByFourIDBlock)(id data,id data2,id data3,id data4);
typedef void(^jobsByFiveIDBlock)(id data,id data2,id data3,id data4,id data5);
typedef void(^jobsBySixIDBlock)(id data,id data2,id data3,id data4,id data5,id data6);
typedef void(^jobsBySevenIDBlock)(id data,id data2,id data3,id data4,id data5,id data7);
typedef void(^jobsByEightIDBlock)(id data,id data2,id data3,id data4,id data5,id data7,id data8);
typedef void(^jobsByNineIDBlock)(id data,id data2,id data3,id data4,id data5,id data7,id data8,id data9);
typedef void(^jobsByTenIDBlock)(id data,id data2,id data3,id data4,id data5,id data7,id data8,id data9,id data10);

#endif /* VoidByCertainParameters_h */
