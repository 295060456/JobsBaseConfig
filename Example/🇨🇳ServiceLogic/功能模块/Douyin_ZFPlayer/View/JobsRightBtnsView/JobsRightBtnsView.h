//
//  JobsRightBtnsView.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/9/19.
//  Copyright © 2020 MonkeyKingVideo. All rights reserved.
//

#import "BaseView.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, MKRightBtnViewBtnType) {
    MKRightBtnViewBtnType_mkZanView,///点赞
    MKRightBtnViewBtnType_mkCommentView,/// 评论
    MKRightBtnViewBtnType_mkShareView,/// 分享
};

@interface JobsRightBtnsView : BaseView

@end

NS_ASSUME_NONNULL_END
