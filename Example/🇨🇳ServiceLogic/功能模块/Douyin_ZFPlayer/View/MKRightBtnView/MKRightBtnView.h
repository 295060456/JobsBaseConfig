//
//  MKRightBtnView.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/9/19.
//  Copyright © 2020 MonkeyKingVideo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, MKRightBtnViewBtnType) {
    MKRightBtnViewBtnType_mkZanView,//👍
    MKRightBtnViewBtnType_mkCommentView,//评论
    MKRightBtnViewBtnType_mkShareView,//分享
};

@interface MKRightBtnView : UIView

@property(nonatomic,strong)NSString *ZanNumStr;//点赞的数量
@property(nonatomic,strong)NSString *CommentNumStr;//评论的数量
@property(nonatomic,assign)BOOL isSelected;
@property(nonatomic,assign)CGSize MKRightBtnViewSize;
@property(nonatomic,assign)CGFloat offset;

//点击的是哪一个按钮
-(void)actionBlockMKRightBtnView:(jobsByIDBlock _Nullable)MKRightBtnViewBlock;

@end

NS_ASSUME_NONNULL_END
