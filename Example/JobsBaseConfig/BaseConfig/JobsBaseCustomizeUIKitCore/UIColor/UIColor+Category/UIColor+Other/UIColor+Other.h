//
//  UIColor+Other.h
//  MataShop
//
//  Created by Jobs Hi on 9/16/23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (Other)
/// 将一个确定的UIColor子类，翻译成RGB格式的字符串值并对外输出【可能因为四舍五入的问题影响末位精度，误差在±1】
/// 资料来源  https://blog.csdn.net/thanklife/article/details/25784879
-(NSString *_Nonnull)rgbCorStr;
/// 将一个确定的UIColor子类，翻译成十六进制格式的字符串值并对外输出
-(NSString *_Nonnull)hexadecimalCorStr;
/// 十六进制格式的字符串翻译成UIColor *
+(UIColor *)colorWithHexString:(NSString *)color;
/// 从十六进制字符串获取颜色，
/// color:支持@“#123456”、 @“0X123456”、 @“123456”三种格式
+(UIColor *)colorWithHexString:(NSString *)color
                         alpha:(CGFloat)alpha;
/// 颜色转换为背景图片
+(UIImage *)imageWithColor:(UIColor *)color;
/// 渐变色 ⚠️在cell上可能失灵，目前原因不明⚠️
+(UIColor *)gradientCorDataMutArr:(NSMutableArray <UIColor *>*_Nullable)CorDataMutArr
                       startPoint:(CGPoint)startPoint
                         endPoint:(CGPoint)endPoint
                           opaque:(BOOL)opaque
                   targetViewRect:(CGRect)targetViewRect;
@end

NS_ASSUME_NONNULL_END
/**
 
 示例代码：渐变色
 
 UIColor *cor = [UIColor gradientCorDataMutArr:[NSMutableArray arrayWithArray:@[RGB_COLOR(247, 131, 97),RGB_COLOR(245, 75, 100)]]
                                    startPoint:CGPointZero
                                      endPoint:CGPointZero
                                        opaque:NO
                                targetViewRect:label.frame];
 
 self.titleLabTextColor = cor;
 
 */
