//
//  UIButton+Extra.h
//  JobsBaseConfig
//
//  Created by Jobs on 2022/1/18.
//

#import <UIKit/UIKit.h>
#import "UIView+Measure.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (Extra)

@property(nonatomic,assign)CGFloat imageTitleSpace;

/// 灵活配置UIButton
/// @param edgeInsetsStyle UIButton 图文的相对位置关系
/// @param labelShowingType UIButton 文本显示标准
/// @param imageTitleSpace UIButton 图文相对位置
-(UIButton *)configButtonWithEdgeInsetsStyle:(GLButtonEdgeInsetsStyle)edgeInsetsStyle
                      labelShowingType:(UILabelShowingType)labelShowingType
                             imageTitleSpace:(CGFloat)imageTitleSpace;
-(UIButton *)makeBtnLabelByShowingType:(UILabelShowingType)labelShowingType;

@end

NS_ASSUME_NONNULL_END
