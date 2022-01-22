//
//  DetermineParametersBlock.h
//  Casino
//
//  Created by Jobs on 2022/1/4.
//

#ifndef DetermineParametersBlock_h
#define DetermineParametersBlock_h
/* 确定参数Block */
#pragma mark —— 没有返回值的Block
typedef void(^NoResultBlock)(void);
typedef void(^MKDataBlock)(id data);
/// 单形参
typedef void(^MKIntegerBlock)(NSInteger data);
typedef void(^MKUIntegerBlock)(NSUInteger data);
typedef void(^MKCGFloatBlock)(CGFloat data);
typedef void(^MKBOOLBlock)(BOOL data);
typedef void(^MKIntBlock)(int data);
typedef void(^MKUnsignedIntBlock)(unsigned int data);
typedef void(^MKFloatBlock)(float data);
typedef void(^MKDoubleBlock)(double data);
typedef void(^MKCharBlock)(char data);
typedef void(^MKUnsignedCharBlock)(unsigned char data);
typedef void(^MKShortBlock)(short data);
typedef void(^MKUnsignedShortBlock)(unsigned short data);
typedef void(^MKLongBlock)(long data);
typedef void(^MKUnsignedLongBlock)(unsigned long data);
typedef void(^MKUnsignedLongLongBlock)(unsigned long long data);
/// 多形参
typedef void(^TwoDataBlock)(id data,id data2);
typedef void(^ThreeDataBlock)(id data,id data2,id data3);
typedef void(^FourDataBlock)(id data,id data2,id data3,id data4);
typedef void(^FiveDataBlock)(id data,id data2,id data3,id data4,id data5);
typedef void(^SixDataBlock)(id data,id data2,id data3,id data4,id data5,id data6);
typedef void(^SevenDataBlock)(id data,id data2,id data3,id data4,id data5,id data7);
typedef void(^EightDataBlock)(id data,id data2,id data3,id data4,id data5,id data7,id data8);
typedef void(^NineDataBlock)(id data,id data2,id data3,id data4,id data5,id data7,id data8,id data9);
typedef void(^TenDataBlock)(id data,id data2,id data3,id data4,id data5,id data7,id data8,id data9,id data10);

#pragma mark —— 有返回值的Block
typedef CGSize(^ResultSizeBlock)(void);
typedef CGSize(^resultSizeBlock)(id data);

typedef CGRect(^ResultRectBlock)(void);
typedef CGRect(^resultRectBlock)(id data);

typedef CGPoint(^ResultPointBlock)(void);
typedef CGPoint(^resultPointBlock)(id data);

typedef id(^ResultBlock)(void);
typedef id(^mkDataBlock)(id data);
/// 单形参
typedef id(^mkIntegerBlock)(NSInteger data);
typedef id(^mkUIntegerBlock)(NSUInteger data);
typedef id(^mkCGFloatBlock)(CGFloat data);
typedef id(^mkBOOLBlock)(BOOL data);
typedef id(^mkIntBlock)(int data);
typedef id(^mkUnsignedIntBlock)(unsigned int data);
typedef id(^mkFloatBlock)(float data);
typedef id(^mkDoubleBlock)(double data);
typedef id(^mkCharBlock)(char data);
typedef id(^mkUnsignedCharBlock)(unsigned char data);
typedef id(^mkShortBlock)(short data);
typedef id(^mkUnsignedShortBlock)(unsigned short data);
typedef id(^mkLongBlock)(long data);
typedef id(^mkUnsignedLongBlock)(unsigned long data);
typedef id(^mkUnsignedLongLongBlock)(unsigned long long data);

typedef CGSize(^mkReturnSizeIntegerBlock)(NSInteger data);
typedef CGSize(^mkReturnSizeUIntegerBlock)(NSUInteger data);
typedef CGSize(^mkReturnSizeCGFloatBlock)(CGFloat data);
typedef CGSize(^mkReturnSizeBOOLBlock)(BOOL data);
typedef CGSize(^mkReturnSizeIntBlock)(int data);
typedef CGSize(^mkReturnSizeUnsignedIntBlock)(unsigned int data);
typedef CGSize(^mkReturnSizeFloatBlock)(float data);
typedef CGSize(^mkReturnSizeDoubleBlock)(double data);
typedef CGSize(^mkReturnSizeCharBlock)(char data);
typedef CGSize(^mkReturnSizeUnsignedCharBlock)(unsigned char data);
typedef CGSize(^mkReturnSizeShortBlock)(short data);
typedef CGSize(^mkReturnSizeUnsignedShortBlock)(unsigned short data);
typedef CGSize(^mkReturnSizeLongBlock)(long data);
typedef CGSize(^mkReturnSizeUnsignedLongBlock)(unsigned long data);
typedef CGSize(^mkReturnSizeUnsignedLongLongBlock)(unsigned long long data);

typedef CGRect(^mkReturnRectIntegerBlock)(NSInteger data);
typedef CGRect(^mkReturnRectUIntegerBlock)(NSUInteger data);
typedef CGRect(^mkReturnRectCGFloatBlock)(CGFloat data);
typedef CGRect(^mkReturnRectBOOLBlock)(BOOL data);
typedef CGRect(^mkReturnRectIntBlock)(int data);
typedef CGRect(^mkReturnRectUnsignedIntBlock)(unsigned int data);
typedef CGRect(^mkReturnRectFloatBlock)(float data);
typedef CGRect(^mkReturnRectDoubleBlock)(double data);
typedef CGRect(^mkReturnRectCharBlock)(char data);
typedef CGRect(^mkReturnRectUnsignedCharBlock)(unsigned char data);
typedef CGRect(^mkReturnRectShortBlock)(short data);
typedef CGRect(^mkReturnRectUnsignedShortBlock)(unsigned short data);
typedef CGRect(^mkReturnRectLongBlock)(long data);
typedef CGRect(^mkReturnRectUnsignedLongBlock)(unsigned long data);
typedef CGRect(^mkReturnRectUnsignedLongLongBlock)(unsigned long long data);

typedef CGPoint(^mkReturnPointIntegerBlock)(NSInteger data);
typedef CGPoint(^mkReturnPointUIntegerBlock)(NSUInteger data);
typedef CGPoint(^mkReturnPointCGFloatBlock)(CGFloat data);
typedef CGPoint(^mkReturnPointBOOLBlock)(BOOL data);
typedef CGPoint(^mkReturnPointIntBlock)(int data);
typedef CGPoint(^mkReturnPointUnsignedIntBlock)(unsigned int data);
typedef CGPoint(^mkReturnPointFloatBlock)(float data);
typedef CGPoint(^mkReturnPointDoubleBlock)(double data);
typedef CGPoint(^mkReturnPointCharBlock)(char data);
typedef CGPoint(^mkReturnPointUnsignedCharBlock)(unsigned char data);
typedef CGPoint(^mkReturnPointShortBlock)(short data);
typedef CGPoint(^mkReturnPointUnsignedShortBlock)(unsigned short data);
typedef CGPoint(^mkReturnPointLongBlock)(long data);
typedef CGPoint(^mkReturnPointUnsignedLongBlock)(unsigned long data);
typedef CGPoint(^mkReturnPointUnsignedLongLongBlock)(unsigned long long data);

/// 多形参
typedef id(^twoDataBlock)(id data,id data2);
typedef id(^threeDataBlock)(id data,id data2,id data3);
typedef id(^fourDataBlock)(id data,id data2,id data3,id data4);
typedef id(^fiveDataBlock)(id data,id data2,id data3,id data4,id data5);
typedef id(^sixDataBlock)(id data,id data2,id data3,id data4,id data5,id data6);
typedef id(^sevenDataBlock)(id data,id data2,id data3,id data4,id data5,id data7);
typedef id(^eightDataBlock)(id data,id data2,id data3,id data4,id data5,id data7,id data8);
typedef id(^nineDataBlock)(id data,id data2,id data3,id data4,id data5,id data7,id data8,id data9);
typedef id(^tenDataBlock)(id data,id data2,id data3,id data4,id data5,id data7,id data8,id data9,id data10);

typedef CGSize(^twoDataReturnSizeBlock)(id data,id data2);
typedef CGSize(^threeDataReturnSizeBlock)(id data,id data2,id data3);
typedef CGSize(^fourDataReturnSizeBlock)(id data,id data2,id data3,id data4);
typedef CGSize(^fiveDataReturnSizeBlock)(id data,id data2,id data3,id data4,id data5);
typedef CGSize(^sixDataReturnSizeBlock)(id data,id data2,id data3,id data4,id data5,id data6);
typedef CGSize(^sevenDataReturnSizeBlock)(id data,id data2,id data3,id data4,id data5,id data7);
typedef CGSize(^eightDataReturnSizeBlock)(id data,id data2,id data3,id data4,id data5,id data7,id data8);
typedef CGSize(^nineDataReturnSizeBlock)(id data,id data2,id data3,id data4,id data5,id data7,id data8,id data9);
typedef CGSize(^tenDataReturnSizeBlock)(id data,id data2,id data3,id data4,id data5,id data7,id data8,id data9,id data10);

typedef CGRect(^twoDataReturnRectBlock)(id data,id data2);
typedef CGRect(^threeDataReturnRectBlock)(id data,id data2,id data3);
typedef CGRect(^fourDataReturnRectBlock)(id data,id data2,id data3,id data4);
typedef CGRect(^fiveDataReturnRectBlock)(id data,id data2,id data3,id data4,id data5);
typedef CGRect(^sixDataReturnRectBlock)(id data,id data2,id data3,id data4,id data5,id data6);
typedef CGRect(^sevenDataReturnRectBlock)(id data,id data2,id data3,id data4,id data5,id data7);
typedef CGRect(^eightDataReturnRectBlock)(id data,id data2,id data3,id data4,id data5,id data7,id data8);
typedef CGRect(^nineDataReturnRectBlock)(id data,id data2,id data3,id data4,id data5,id data7,id data8,id data9);
typedef CGRect(^tenDataReturnRectBlock)(id data,id data2,id data3,id data4,id data5,id data7,id data8,id data9,id data10);

typedef CGPoint(^twoDataReturnPointBlock)(id data,id data2);
typedef CGPoint(^threeDataReturnPointBlock)(id data,id data2,id data3);
typedef CGPoint(^fourDataReturnPointBlock)(id data,id data2,id data3,id data4);
typedef CGPoint(^fiveDataReturnPointBlock)(id data,id data2,id data3,id data4,id data5);
typedef CGPoint(^sixDataReturnPointBlock)(id data,id data2,id data3,id data4,id data5,id data6);
typedef CGPoint(^sevenDataReturnPointBlock)(id data,id data2,id data3,id data4,id data5,id data7);
typedef CGPoint(^eightDataReturnPointBlock)(id data,id data2,id data3,id data4,id data5,id data7,id data8);
typedef CGPoint(^nineDataReturnPointBlock)(id data,id data2,id data3,id data4,id data5,id data7,id data8,id data9);
typedef CGPoint(^tenDataReturnPointBlock)(id data,id data2,id data3,id data4,id data5,id data7,id data8,id data9,id data10);

#endif /* DetermineParametersBlock_h */
