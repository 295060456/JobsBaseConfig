//
//  NSString+Others.h
//  Casino
//
//  Created by Jobs on 2021/11/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Others)
#pragma mark —— 其他
/// 复制到系统剪切板
-(void)pasteboard;
+(NSString *)test:(NSArray <NSString *>*)arr;
/// ？？？
-(NSString *)formatDecimalNumber;
-(NSString *)getAnonymousString;
/**
 问题：直接其他地方复制过来的中文字进行网页搜索、或者中文字识别排序等情况的，会出现搜索不到的情况。
 解决方法：可能存在复制源里面的文字带了空白url编码%E2%80%8B，空白编码没有宽度，虽然看不到但是会影响结果无法正确匹配对应的中文字。可以把文字重新url编码即可。
 */
-(NSString *)urlProtect;
/// 系统的stringByAppendingString方法在参数为nil的时候会崩溃
-(NSString *)jobsStringByAppendingString:(NSString *_Nullable)str;
/// 获取到最后一个字符
-(NSString *)getLastChars;
/// 获取到最后一个非空格字符
-(NSString *)getLastValuedChars;
/// 去除最后一个字符
-(NSString *)removeLastChars;

@end

NS_ASSUME_NONNULL_END
