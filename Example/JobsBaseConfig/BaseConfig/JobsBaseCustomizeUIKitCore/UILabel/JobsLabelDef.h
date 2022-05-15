//
//  JobsLabelDef.h
//  JobsBaseConfig
//
//  Created by Jobs on 2022/1/20.
//

#ifndef JobsLabelDef_h
#define JobsLabelDef_h

typedef enum : NSInteger {
    /// 一行显示。定宽、定高、定字体。多余部分用…表示（省略号的位置由NSLineBreakMode控制）
    UILabelShowingType_01 = 0,
    /// 一行显示。定宽、定高、定字体。多余部分scrollerView
    UILabelShowingType_02,
    /// 一行显示。不定宽、定高、定字体。宽度自适应
    UILabelShowingType_03,
    /// 一行显示。定宽、定高。缩小字体方式全展示
    UILabelShowingType_04,
    /// 多行显示。定宽、不定高、定字体
    UILabelShowingType_05,
} UILabelShowingType;// UILabel的显示样式

#endif /* JobsLabelDef_h */
