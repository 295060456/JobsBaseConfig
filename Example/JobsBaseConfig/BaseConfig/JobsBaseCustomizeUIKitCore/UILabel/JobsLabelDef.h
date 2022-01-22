//
//  JobsLabelDef.h
//  JobsBaseConfig
//
//  Created by Jobs on 2022/1/20.
//

#ifndef JobsLabelDef_h
#define JobsLabelDef_h

typedef enum : NSInteger {
    UILabelShowingType_01 = 0,/// 一行显示。定宽、定字体。多余部分用…表示（省略号的位置由NSLineBreakMode控制）
    UILabelShowingType_02,/// 一行显示。定宽、定字体。多余部分scrollerView
    UILabelShowingType_03,/// 一行显示。定字体，不定宽。宽度自适应
    UILabelShowingType_04,/// 一行显示。缩小字体方式全展示
    UILabelShowingType_05,/// 多行显示。定宽、定字体
} UILabelShowingType;// UILabel的显示样式

#endif /* JobsLabelDef_h */
