//
//  VoidByCertainParameters.h
//  JobsBaseConfig
//
//  Created by Jobs on 2022/1/27.
//

#ifndef VoidByCertainParameters_h
#define VoidByCertainParameters_h

typedef void(^jobsByVoidBlock)(void);
typedef void(^jobsByIDBlock)(id data);
/// 单形参
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
/// 多形参
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
