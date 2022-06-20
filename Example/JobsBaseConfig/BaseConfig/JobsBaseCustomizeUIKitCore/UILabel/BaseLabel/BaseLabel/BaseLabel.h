//
//  AutoScrollLabel.h
//  JobsBaseConfig
//
//  Created by Jobs on 2022/1/18.
//

#import <UIKit/UIKit.h>
#import "BaseViewProtocol.h"
#import "UIView+Extras.h"
#import "UILabel+Extra.h"
#import "NSString+Others.h"

NS_ASSUME_NONNULL_BEGIN
/**
 1、自定义UILabel 实现显示偏移量和内边距
 2、自定义UILabel 实现添加长按手势和点击手势
 https://www.jianshu.com/p/541ef795a1f2
 */
@interface BaseLabel : UILabel
<
BaseViewProtocol,
UIGestureRecognizerDelegate
>

@property(nonatomic,assign)UIEdgeInsets edgeInsets;
@property(nonatomic,assign)CGFloat offsetY;
@property(nonatomic,assign)CGFloat offsetX;

#pragma mark —— 一些公有方法
/// 当实现手势方法方可激活
-(void)actionTapGRBlock:(JobsReturnIDByGestureRecognizerBlock _Nullable)tapGRBlock;
-(void)actionLongPressGRBlock:(JobsReturnIDByGestureRecognizerBlock _Nullable)longPressGRBlock;
/// UILabel文字的复制
-(void)copyText;

@end

NS_ASSUME_NONNULL_END
