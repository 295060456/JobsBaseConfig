//
//  ReturnByCertainParameters.h
//  JobsBaseConfig
//
//  Created by Jobs on 2022/1/27.
//

#ifndef ReturnByCertainParameters_h
#define ReturnByCertainParameters_h
/// 确定入参个数 并且 有返回值的Block定义

typedef CGSize(^JobsReturnCGSizeByVoidBlock)(void);
typedef CGSize(^JobsReturnCGSizeByIDBlock)(id data);

typedef CGRect(^JobsReturnCGRectByVoidBlock)(void);
typedef CGRect(^JobsReturnCGRectByIDBlock)(id data);

typedef CGPoint(^JobsReturnCGPointByVoidBlock)(void);
typedef CGPoint(^JobsReturnCGPointByIDBlock)(id data);

typedef id(^JobsReturnIDByVoidBlock)(void);
typedef id(^JobsReturnIDByIDBlock)(id data);
/// 单形参
/// 统一返回ID类型
typedef id(^JobsReturnIDByNSIntegerBlock)(NSInteger data);
typedef id(^JobsReturnIDByUIntegerBlock)(NSUInteger data);
typedef id(^JobsReturnIDByCGFloatBlock)(CGFloat data);
typedef id(^JobsReturnIDByBOOLBlock)(BOOL data);
typedef id(^JobsReturnIDByIntBlock)(int data);
typedef id(^JobsReturnIDByUnsignedIntBlock)(unsigned int data);
typedef id(^JobsReturnIDByFloatBlock)(float data);
typedef id(^JobsReturnIDByDoubleBlock)(double data);
typedef id(^JobsReturnIDByCharBlock)(char data);
typedef id(^JobsReturnIDByUnsignedCharBlock)(unsigned char data);
typedef id(^JobsReturnIDByShortBlock)(short data);
typedef id(^JobsReturnIDByUnsignedShortBlock)(unsigned short data);
typedef id(^JobsReturnIDByLongBlock)(long data);
typedef id(^JobsReturnIDByUnsignedLongBlock)(unsigned long data);
typedef id(^JobsReturnIDByUnsignedLongLongBlock)(unsigned long long data);
/// 返回入参类型
typedef NSInteger(^JobsReturnByNSIntegerBlock)(NSInteger data);
typedef NSUInteger(^JobsReturnByNSUIntegerBlock)(NSUInteger data);
typedef CGFloat(^JobsReturnByCGFloatBlock)(CGFloat data);
typedef BOOL(^JobsReturnByBOOLBlock)(BOOL data);
typedef int(^JobsReturnByIntBlock)(int data);
typedef unsigned int(^JobsReturnByUnsignedIntBlock)(unsigned int data);
typedef float(^JobsReturnByFloatBlock)(float data);
typedef double(^JobsReturnByDoubleBlock)(double data);
typedef char(^JobsReturnByCharBlock)(char data);
typedef unsigned char(^JobsReturnByUnsignedCharBlock)(unsigned char data);
typedef short(^JobsReturnByShortBlock)(short data);
typedef unsigned short(^JobsReturnByUnsignedShortBlock)(unsigned short data);
typedef long(^JobsReturnByLongBlock)(long data);
typedef unsigned long(^JobsReturnByUnsignedLongBlock)(unsigned long data);
typedef unsigned long long(^JobsReturnByUnsignedLongLongBlock)(unsigned long long data);

typedef CGSize(^JobsReturnSizeByNSIntegerBlock)(NSInteger data);
typedef CGSize(^JobsReturnSizeByUIntegerBlock)(NSUInteger data);
typedef CGSize(^JobsReturnSizeByCGFloatBlock)(CGFloat data);
typedef CGSize(^JobsReturnSizeByBOOLBlock)(BOOL data);
typedef CGSize(^JobsReturnSizeByIntBlock)(int data);
typedef CGSize(^JobsReturnSizeByUnsignedIntBlock)(unsigned int data);
typedef CGSize(^JobsReturnSizeByFloatBlock)(float data);
typedef CGSize(^JobsReturnSizeByDoubleBlock)(double data);
typedef CGSize(^JobsReturnSizeByCharBlock)(char data);
typedef CGSize(^JobsReturnSizeByUnsignedCharBlock)(unsigned char data);
typedef CGSize(^JobsReturnSizeByShortBlock)(short data);
typedef CGSize(^JobsReturnSizeByUnsignedShortBlock)(unsigned short data);
typedef CGSize(^JobsReturnSizeByLongBlock)(long data);
typedef CGSize(^JobsReturnSizeByUnsignedLongBlock)(unsigned long data);
typedef CGSize(^JobsReturnSizeByUnsignedLongLongBlock)(unsigned long long data);

typedef CGRect(^JobsReturnRectByNSIntegerBlock)(NSInteger data);
typedef CGRect(^JobsReturnRectByUIntegerBlock)(NSUInteger data);
typedef CGRect(^JobsReturnRectByCGFloatBlock)(CGFloat data);
typedef CGRect(^JobsReturnRectByBOOLBlock)(BOOL data);
typedef CGRect(^JobsReturnRectByIntBlock)(int data);
typedef CGRect(^JobsReturnRectByUnsignedIntBlock)(unsigned int data);
typedef CGRect(^JobsReturnRectByFloatBlock)(float data);
typedef CGRect(^JobsReturnRectByDoubleBlock)(double data);
typedef CGRect(^JobsReturnRectByCharBlock)(char data);
typedef CGRect(^JobsReturnRectByUnsignedCharBlock)(unsigned char data);
typedef CGRect(^JobsReturnRectByShortBlock)(short data);
typedef CGRect(^JobsReturnRectByUnsignedShortBlock)(unsigned short data);
typedef CGRect(^JobsReturnRectByLongBlock)(long data);
typedef CGRect(^JobsReturnRectByUnsignedLongBlock)(unsigned long data);
typedef CGRect(^JobsReturnRectByUnsignedLongLongBlock)(unsigned long long data);

typedef CGPoint(^JobsReturnCGPointByNSIntegerBlock)(NSInteger data);
typedef CGPoint(^JobsReturnCGPointByUIntegerBlock)(NSUInteger data);
typedef CGPoint(^JobsReturnCGPointByCGFloatBlock)(CGFloat data);
typedef CGPoint(^JobsReturnCGPointByBOOLBlock)(BOOL data);
typedef CGPoint(^JobsReturnCGPointByIntBlock)(int data);
typedef CGPoint(^JobsReturnCGPointByUnsignedIntBlock)(unsigned int data);
typedef CGPoint(^JobsReturnCGPointByFloatBlock)(float data);
typedef CGPoint(^JobsReturnCGPointByDoubleBlock)(double data);
typedef CGPoint(^JobsReturnCGPointByCharBlock)(char data);
typedef CGPoint(^JobsReturnCGPointByUnsignedCharBlock)(unsigned char data);
typedef CGPoint(^JobsReturnCGPointByShortBlock)(short data);
typedef CGPoint(^JobsReturnCGPointByUnsignedShortBlock)(unsigned short data);
typedef CGPoint(^JobsReturnCGPointByLongBlock)(long data);
typedef CGPoint(^JobsReturnCGPointByUnsignedLongBlock)(unsigned long data);
typedef CGPoint(^JobsReturnCGPointByUnsignedLongLongBlock)(unsigned long long data);

/// 多形参
typedef id(^JobsReturnIDByTwoIDBlock)(id data,id data2);
typedef id(^JobsReturnIDByThreeIDBlock)(id data,id data2,id data3);
typedef id(^JobsReturnIDByFourIDBlock)(id data,id data2,id data3,id data4);
typedef id(^JobsReturnIDByFiveIDBlock)(id data,id data2,id data3,id data4,id data5);
typedef id(^JobsReturnIDBySixIDBlock)(id data,id data2,id data3,id data4,id data5,id data6);
typedef id(^JobsReturnIDBySevenIDBlock)(id data,id data2,id data3,id data4,id data5,id data7);
typedef id(^JobsReturnIDByEightIDBlock)(id data,id data2,id data3,id data4,id data5,id data7,id data8);
typedef id(^JobsReturnIDByNineIDBlock)(id data,id data2,id data3,id data4,id data5,id data7,id data8,id data9);
typedef id(^JobsReturnIDByTenIDBlock)(id data,id data2,id data3,id data4,id data5,id data7,id data8,id data9,id data10);

typedef CGSize(^JobsReturnCGSizeByTwoIDBlock)(id data,id data2);
typedef CGSize(^JobsReturnCGSizeByThreeIDBlock)(id data,id data2,id data3);
typedef CGSize(^JobsReturnCGSizeByFourIDBlock)(id data,id data2,id data3,id data4);
typedef CGSize(^JobsReturnCGSizeByFiveIDBlock)(id data,id data2,id data3,id data4,id data5);
typedef CGSize(^JobsReturnCGSizeBySixIDBlock)(id data,id data2,id data3,id data4,id data5,id data6);
typedef CGSize(^JobsReturnCGSizeBySevenIDBlock)(id data,id data2,id data3,id data4,id data5,id data7);
typedef CGSize(^JobsReturnCGSizeByEightIDBlock)(id data,id data2,id data3,id data4,id data5,id data7,id data8);
typedef CGSize(^JobsReturnCGSizeByNineIDBlock)(id data,id data2,id data3,id data4,id data5,id data7,id data8,id data9);
typedef CGSize(^JobsReturnCGSizeByTenIDBlock)(id data,id data2,id data3,id data4,id data5,id data7,id data8,id data9,id data10);

typedef CGRect(^JobsReturnCGRectByTwoIDBlock)(id data,id data2);
typedef CGRect(^JobsReturnCGRectByThreeIDBlock)(id data,id data2,id data3);
typedef CGRect(^JobsReturnCGRectByFourIDBlock)(id data,id data2,id data3,id data4);
typedef CGRect(^JobsReturnCGRectByFiveIDBlock)(id data,id data2,id data3,id data4,id data5);
typedef CGRect(^JobsReturnCGRectBySixIDBlock)(id data,id data2,id data3,id data4,id data5,id data6);
typedef CGRect(^JobsReturnCGRectBySevenIDBlock)(id data,id data2,id data3,id data4,id data5,id data7);
typedef CGRect(^JobsReturnCGRectByEightIDBlock)(id data,id data2,id data3,id data4,id data5,id data7,id data8);
typedef CGRect(^JobsReturnCGRectByNineIDBlock)(id data,id data2,id data3,id data4,id data5,id data7,id data8,id data9);
typedef CGRect(^JobsReturnCGRectByTenIDBlock)(id data,id data2,id data3,id data4,id data5,id data7,id data8,id data9,id data10);

typedef CGPoint(^JobsReturnCGPointByTwoIDBlock)(id data,id data2);
typedef CGPoint(^JobsReturnCGPointByThreeIDBlock)(id data,id data2,id data3);
typedef CGPoint(^JobsReturnCGPointByFourIDBlock)(id data,id data2,id data3,id data4);
typedef CGPoint(^JobsReturnCGPointByFiveIDBlock)(id data,id data2,id data3,id data4,id data5);
typedef CGPoint(^JobsReturnCGPointBySixIDBlock)(id data,id data2,id data3,id data4,id data5,id data6);
typedef CGPoint(^JobsReturnCGPointBySevenIDBlock)(id data,id data2,id data3,id data4,id data5,id data7);
typedef CGPoint(^JobsReturnCGPointByEightIDBlock)(id data,id data2,id data3,id data4,id data5,id data7,id data8);
typedef CGPoint(^JobsReturnCGPointByNineIDBlock)(id data,id data2,id data3,id data4,id data5,id data7,id data8,id data9);
typedef CGPoint(^JobsReturnCGPointByTenIDBlock)(id data,id data2,id data3,id data4,id data5,id data7,id data8,id data9,id data10);

#endif /* ReturnByCertainParameters_h */
