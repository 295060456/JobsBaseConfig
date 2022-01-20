//
//  NSString+Others.m
//  Casino
//
//  Created by Jobs on 2021/11/30.
//

#import "NSString+Others.h"

@implementation NSString (Others)
#pragma mark —— 其他
/// 复制到系统剪切板
-(void)pasteboard{
    UIPasteboard *pasteboard = UIPasteboard.generalPasteboard;
    pasteboard.string = self;
    [WHToast toastMsg:@"复制成功"];
}

+(NSString *)test:(NSArray <NSString *>*)arr{
    NSString *resultStr;
    for (int i = 0; i < arr.count; i++) {
        NSString *tempStr = arr[i];
        tempStr = [tempStr stringByReplacingOccurrencesOfString:@"/" withString:@""];//去除字符 /
        [resultStr stringByAppendingString:[NSString stringWithFormat:@"/%@",tempStr]];
    }return resultStr;
}
/// ？？？
-(NSString *)formatDecimalNumber{
    if (!self || self.length == 0) {
        return self;
    }
    NSNumber *number = @(self.doubleValue);
    NSNumberFormatter *formatter = NSNumberFormatter.new;
    formatter.numberStyle = kCFNumberFormatterDecimalStyle;
    formatter.positiveFormat = @"###,##0.00";
    NSString *amountString = [formatter stringFromNumber:number];
    return amountString;
}

-(NSString *)getAnonymousString{
    if (self.length < 2) {
        return self;
    }
    NSMutableArray* carries = NSMutableArray.array;
    for (int i = 1; i < self.length - 1; i++) {
        char s = [self characterAtIndex:i];
        s = '*';
        NSString *tempString = [NSString stringWithUTF8String:&s];
        [carries addObject:tempString];
    }
    NSString *string = [carries componentsJoinedByString:@""];
    NSString *anonymousString = [self stringByReplacingCharactersInRange:NSMakeRange(1, self.length - 2)
                                                              withString:string];
    return anonymousString;
}
/**
 问题：直接其他地方复制过来的中文字进行网页搜索、或者中文字识别排序等情况的，会出现搜索不到的情况。
 解决方法：可能存在复制源里面的文字带了空白url编码%E2%80%8B，空白编码没有宽度，虽然看不到但是会影响结果无法正确匹配对应的中文字。可以把文字重新url编码即可。
 */
-(NSString *)urlProtect{
    if ([self containsString:@"\u200B"]) {
        return [self stringByReplacingOccurrencesOfString:@"\u200B" withString:@""];
    }else return self;
}
/// 系统的stringByAppendingString方法在参数为nil的时候会崩溃
-(NSString *)jobsStringByAppendingString:(NSString *_Nullable)str{
    if (!str) {
        str = @"";
    }return [self stringByAppendingString:str];
}
/// 获取到最后一个字符
-(NSString *)getLastChars{
    return [self substringFromIndex:self.length - 1];
}
/// 获取到最后一个非空格字符
-(NSString *)getLastValuedChars{
    NSString *valuedStr = [self stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet];
    return [valuedStr substringFromIndex:valuedStr.length - 1];
}
/// 去除最后一个字符
-(NSString *)removeLastChars{
    return [self substringToIndex:self.length - 1];
}

@end
