//
//  UILabel+Extra.h
//  Casino
//
//  Created by Jobs on 2021/12/27.
//

#import <UIKit/UIKit.h>
#import "UIView+Masonry.h"
#import "UIView+AutoSelfAdaptionSize.h"

typedef enum : NSInteger {
    UILabelShowingType_01 = 0,/// 一行显示。定宽、定字体。多余部分用…表示（省略号的位置由NSLineBreakMode控制）
    UILabelShowingType_02,/// 一行显示。定宽、定字体。多余部分scrollerView
    UILabelShowingType_03,/// 一行显示。定字体，不定宽。宽度自适应
    UILabelShowingType_04,/// 一行显示。缩小字体方式全展示
    UILabelShowingType_05,/// 多行显示。定宽、定字体
} UILabelShowingType;// UILabel的显示样式

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (Extra)

@property(nonatomic,assign)UILabelShowingType labelShowingType;

-(void)lbBackgroundImage:(UIImage *)bgImage;
/**
 在Masonry以后拿到了frame
 */
-(void)makeLabelByShowingType:(UILabelShowingType)labelShowingType;

@end

NS_ASSUME_NONNULL_END
