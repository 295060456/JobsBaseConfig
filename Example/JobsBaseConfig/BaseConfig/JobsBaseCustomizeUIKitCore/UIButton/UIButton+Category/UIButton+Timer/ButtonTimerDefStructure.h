//
//  ButtonTimerDefStructure.h
//  SelectorBlock
//
//  Created by Jobs on 2021/3/23.
//

#ifndef ButtonTimerDefStructure_h
#define ButtonTimerDefStructure_h
/// 时间显示风格
typedef enum : NSUInteger {
    ShowTimeType_SS = 0,//秒
    ShowTimeType_MMSS,//分秒
    ShowTimeType_HHMMSS,//时分秒
} ShowTimeType;
/// 文本显示类型
typedef enum : NSUInteger {
    CequenceForShowTitleRuningStrType_front = 0,//TitleRuningStr（固定值） 相对于 currentTime（浮动值）在前面 | 首在前
    CequenceForShowTitleRuningStrType_tail//TitleRuningStr（固定值） 相对于 currentTime（浮动值）在后面 | 首在后
} CequenceForShowTitleRuningStrType;

#endif /* ButtonTimerDefStructure_h */
