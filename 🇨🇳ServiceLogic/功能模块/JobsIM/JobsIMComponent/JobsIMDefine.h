//
//  JobsIMDefine.h
//  JobsBaseConfig
//
//  Created by Jobs on 2022/1/13.
//

#ifndef JobsIMDefine_h
#define JobsIMDefine_h

#define isAllowSysEdit NO// 编译期就要优先进去，所以不能用属性

static inline CGFloat JobsIMInputviewHeight(){
    return 60;
}

static inline CGFloat JobsIMChatInfoTimeLabWidth(){
    return 55;
}

static inline CGFloat JobsIMChatInfoTBVDefaultCellHeight(){
    return 50;
}

static inline CGFloat JobsIMChatInfoTBVChatContentLabWidth(){
    return JobsSCREEN_WIDTH - JobsIMChatInfoTimeLabWidth() - (JobsIMChatInfoTBVDefaultCellHeight() - 5) - 20;
}

static inline CGFloat JobsIMChatInfoTBVChatContentLabDefaultWidth(){
    return 30;
}

/** 消息显示位置 */
typedef NS_ENUM(NSInteger,InfoLocation) {
    InfoLocation_Unknown = 0,
    InfoLocation_Left = 1,
    InfoLocation_Right = 2
};


#endif /* JobsIMDefine_h */
