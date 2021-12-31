//
//  NSString+Replace.m
//  Casino
//
//  Created by Jobs on 2021/11/30.
//

#import "NSString+Replace.h"

@implementation NSString (Replace)
#pragma mark —— 字符串替换
///  有时候我们加载的URL中可能会出现中文,需要我们手动进行转码,但是同时又要保证URL中的特殊字符保持不变,那么我们就可以使用下面的方法
-(NSURL *)Url_Chinese{
    SuppressWdeprecatedDeclarationsWarning(return [NSURL URLWithString:(NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                                                                                             (CFStringRef)self,
                                                                                                                                             (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]",
                                                                                                                                             NULL,kCFStringEncodingUTF8))]);
}
/// 替换相关的字符为暂位符 example
-(NSString *)numberSuitScanf{
    NSString *numberString = [self stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    return numberString;
}
/// 每隔num个字符添加一个空格的字符串算法
/// @param num 默认值是4
-(NSString *)dealWithString:(NSInteger)num{
    NSString *doneTitle = @"";
    if (num == 0) num = 4;
    int count = 0;
    for (int i = 0; i < self.length; i++) {
        count++;
        doneTitle = [doneTitle stringByAppendingString:[self substringWithRange:NSMakeRange(i, 1)]];
        if (count == num) {
            doneTitle = [NSString stringWithFormat:@"%@ ", doneTitle];
            count = 0;
        }
    }
    NSLog(@"%@", doneTitle);
    return doneTitle;
}
/// 服务器请求的数据为空值的时候进行替换本地默认值
/// 因为json传输是通过对象包装来进行，所以其实归结起来就是2类，一类是基本数据类型被包装成Number、其他包装成String
/// @param nullableStr 进行检查的资源
/// @param replaceStr 进行替换的备用文字资源
+(NSString *)ensureNonnullString:(id)nullableStr
                      replaceStr:(NSString *)replaceStr{
    //只有NSNumber 和 NSString 这两种情况
    //过滤特殊字符：空格
    NSCharacterSet *whitespace = NSCharacterSet.whitespaceAndNewlineCharacterSet;
    replaceStr = [replaceStr stringByTrimmingCharactersInSet:whitespace];//有空格，去除空格
    if (replaceStr == nil ||
        replaceStr == Nil ||
        replaceStr.length == 0) {
        replaceStr = Internationalization(@"No Data");
    }
    if (nullableStr == nil ||
        nullableStr == NULL ||
        [nullableStr isKindOfClass:NSNull.class]) {//判断空 或者 空对象
        return replaceStr;
    }else if([nullableStr isKindOfClass:NSString.class]){
        NSString *str = (NSString *)nullableStr;
        str = [str stringByTrimmingCharactersInSet:whitespace];//有空格，去除空格
        return str.length == 0 ? replaceStr : str;
    }else if ([nullableStr isKindOfClass:NSNumber.class]){
        NSNumber *b = (NSNumber *)nullableStr;
        return [NSString isNullString:[b toString:nil]] ? replaceStr : [b toString:nil];
    }else return replaceStr;
}

@end
