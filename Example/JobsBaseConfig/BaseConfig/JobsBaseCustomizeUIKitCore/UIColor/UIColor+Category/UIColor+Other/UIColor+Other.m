//
//  UIColor+Other.m
//  MataShop
//
//  Created by Jobs Hi on 9/16/23.
//

#import "UIColor+Other.h"

@implementation UIColor (Other)
/// 将一个确定的UIColor子类，翻译成RGB格式的字符串值并对外输出【可能因为四舍五入的问题影响末位精度，误差在±1】
/// 资料来源  https://blog.csdn.net/thanklife/article/details/25784879
-(NSString *_Nonnull)rgbCorStr{
    /// 获得RGB值描述
    NSString *RGBValue = [NSString stringWithFormat:@"%@",self];
    /// 将RGB值描述分隔成字符串
    NSArray *RGBArr = [RGBValue componentsSeparatedByString:@" "];
    /// 获取红色值
    int r = [[RGBArr objectAtIndex:1] floatValue] * 255;
    NSString *redStr = [NSString stringWithFormat:@"%d",r];
    /// 获取绿色值
    int g = [[RGBArr objectAtIndex:2] floatValue] * 255;
    NSString *greenStr = [NSString stringWithFormat:@"%d",g];
    /// 获取蓝色值
    int b = [[RGBArr objectAtIndex:3] floatValue] * 255;
    NSString *blueStr = [NSString stringWithFormat:@"%d",b];

    return [NSString stringWithFormat:@"红色:%@,绿色%@,蓝色%@",redStr,greenStr,blueStr];
}
/// 将一个确定的UIColor子类，翻译成十六进制格式的字符串值并对外输出
-(NSString *_Nonnull)hexadecimalCorStr{
    // 获取颜色组件
    const CGFloat *components = CGColorGetComponents(self.CGColor);
    // 提取RGB值
    CGFloat redCor = components[0];
    CGFloat greenCor = components[1];
    CGFloat blueCor = components[2];
    // 将RGB值转换为十六进制字符串
    return [NSString stringWithFormat:@"#%02X%02X%02X",
            (int)(redCor * 255),
            (int)(greenCor * 255),
            (int)(blueCor * 255)];
}
/// 十六进制格式的字符串翻译成UIColor *
+(UIColor *)colorWithHexString:(NSString *)color
                         alpha:(CGFloat)alpha{
    //删除字符串中的空格
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6){
        return UIColor.clearColor;
    }
    // strip 0X if it appears
    //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([cString hasPrefix:@"0X"]){
        cString = [cString substringFromIndex:2];
    }
    //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([cString hasPrefix:@"#"]) {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6){
        return UIColor.clearColor;
    }
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float)r / 255.0f)
                           green:((float)g / 255.0f)
                            blue:((float)b / 255.0f)
                           alpha:alpha];
}
/// 默认alpha值为1
+(UIColor *)colorWithHexString:(NSString *)color{
    return [self colorWithHexString:color
                              alpha:1.0f];
}
/// 颜色转换为背景图片
+(UIImage *)imageWithColor:(UIColor *)color{
    CGRect rect = CGRectMake(0.0f,
                             0.0f,
                             1.0f,
                             1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
/// UIDynamicPatternColor
+(UIColor *)gradientCorDataMutArr:(NSMutableArray <UIColor *>*_Nullable)CorDataMutArr
                       startPoint:(CGPoint)startPoint
                         endPoint:(CGPoint)endPoint
                           opaque:(BOOL)opaque
                   targetViewRect:(CGRect)targetViewRect{
    
    if (targetViewRect.size.width == 0 || targetViewRect.size.height == 0) {
        NSAssert(NO, @"宽或者高为0,则会对外输出nil");
    }
    
    if (!CorDataMutArr) {
        CorDataMutArr = NSMutableArray.array;
        [CorDataMutArr addObject:(id)UIColor.redColor.CGColor];
        [CorDataMutArr addObject:(id)UIColor.greenColor.CGColor];
    }else{
        for (int t = 0; t < CorDataMutArr.count; t++) {
            [CorDataMutArr replaceObjectAtIndex:t
                                     withObject:(id)CorDataMutArr[t].CGColor];
        }
    }
    
    UIGraphicsBeginImageContextWithOptions(targetViewRect.size,
                                           opaque,
                                           UIScreen.mainScreen.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    //绘制渐变层
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradientRef = CGGradientCreateWithColors(colorSpaceRef,
                                                           (__bridge CFArrayRef)CorDataMutArr,
                                                           NULL);
    
    CGPoint EndPoint = endPoint;
    if (CGPointEqualToPoint(endPoint, CGPointZero)) {
        EndPoint = CGPointMake(CGRectGetMaxX(targetViewRect),
                               CGRectGetMaxY(targetViewRect));
    }

    CGContextDrawLinearGradient(context,
                                gradientRef,
                                startPoint,
                                EndPoint,
                                kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    //取到渐变图片
    UIImage *gradientImage = UIGraphicsGetImageFromCurrentImageContext();
    //释放资源
    CGColorSpaceRelease(colorSpaceRef);
    CGGradientRelease(gradientRef);
    UIGraphicsEndImageContext();
    
    return [UIColor colorWithPatternImage:gradientImage];
}

@end
