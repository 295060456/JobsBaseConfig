//
//  JobsSearchConfig.h
//  JobsBaseConfig
//
//  Created by Jobs on 2022/1/14.
//

#ifndef JobsSearchConfig_h
#define JobsSearchConfig_h

static const CGFloat cellHeight = 40;//行高
static const CGFloat listNum = 2;//列数

typedef NS_ENUM(NSUInteger, HotSearchStyle) {
    HotSearchStyle_1,//横排自适应提行
    HotSearchStyle_2,//一行N列（默认N = 2），前三颜色突出表示
    HotSearchStyle_3,//暂时未定义
};

#endif /* JobsSearchConfig_h */
