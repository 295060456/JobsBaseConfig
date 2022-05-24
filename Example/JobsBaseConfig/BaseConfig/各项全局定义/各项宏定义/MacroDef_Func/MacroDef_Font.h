//
//  MacroDef_Font.h
//  BaiShaEntertainmentProj
//
//  Created by Jobs on 2022/5/23.
//

#ifndef MacroDef_Font_h
#define MacroDef_Font_h

#import "MacroDef_Size.h"

static inline UIFont *UIFontWeightUltraLightSize(CGFloat fontSize) {
    return [UIFont systemFontOfSize:JobsWidth(fontSize) weight:UIFontWeightUltraLight];
}

static inline UIFont *UIFontWeightThinSize(CGFloat fontSize) {
    return [UIFont systemFontOfSize:JobsWidth(fontSize) weight:UIFontWeightThin];
}

static inline UIFont *UIFontWeightLightSize(CGFloat fontSize) {
    return [UIFont systemFontOfSize:JobsWidth(fontSize) weight:UIFontWeightLight];
}

static inline UIFont *UIFontWeightRegularSize(CGFloat fontSize) {
    return [UIFont systemFontOfSize:JobsWidth(fontSize) weight:UIFontWeightRegular];
}

static inline UIFont *UIFontWeightMediumSize(CGFloat fontSize) {
    return [UIFont systemFontOfSize:JobsWidth(fontSize) weight:UIFontWeightMedium];
}

static inline UIFont *UIFontWeightSemiboldSize(CGFloat fontSize) {
    return [UIFont systemFontOfSize:JobsWidth(fontSize) weight:UIFontWeightSemibold];
}

static inline UIFont *UIFontWeightBoldSize(CGFloat fontSize) {
    return [UIFont systemFontOfSize:JobsWidth(fontSize) weight:UIFontWeightBold];
}

static inline UIFont *UIFontWeightHeavySize(CGFloat fontSize) {
    return [UIFont systemFontOfSize:JobsWidth(fontSize) weight:UIFontWeightHeavy];
}

static inline UIFont *UIFontWeightBlackSize(CGFloat fontSize) {
    return [UIFont systemFontOfSize:JobsWidth(fontSize) weight:UIFontWeightBlack];
}
/// 根据fontName出字体
/// https://www.jianshu.com/p/736f2972a660
/// @param fontName 外来字体要先通过方法：+(NSMutableArray <NSString *>*)getAvailableFont，获得fontName再进行代入
/// @param fontSize 字体大小
static inline UIFont *fontName(NSString *fontName,CGFloat fontSize) {
    return [UIFont fontWithName:fontName size:JobsWidth(fontSize)];
}

#endif /* MacroDef_Font_h */
