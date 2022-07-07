//
//  UIButton+Extra.m
//  JobsBaseConfig
//
//  Created by Jobs on 2022/1/18.
//

#import "UIButton+Extra.h"

@implementation UIButton (Extra)
/// 灵活配置UIButton
/// @param edgeInsetsStyle UIButton 图文的相对位置关系
/// @param labelShowingType UIButton 文本显示标准
/// @param imageTitleSpace UIButton 图文相对位置
-(UIButton *)configButtonWithEdgeInsetsStyle:(GLButtonEdgeInsetsStyle)edgeInsetsStyle
                      labelShowingType:(UILabelShowingType)labelShowingType
                       imageTitleSpace:(CGFloat)imageTitleSpace{
    /// 1、一定要先刷新UI得出Masonry约束的值
    [self.superview layoutIfNeeded];
    /// 2、在（1）的大前提下，对按钮图文的相对位置进行重排（包括设置图文之间的间距）
    [self layoutButtonWithEdgeInsetsStyle:edgeInsetsStyle
                          imageTitleSpace:imageTitleSpace];
    /// 3、再一次刷新页面拿到一个最新的约束值，再根据参数UILabelShowingType，系统自动适配调整UIButton的约束值到最新
    [self makeBtnLabelByShowingType:labelShowingType];
    /// 4 、补偿（2）产生的图文间距
    self.width += imageTitleSpace;
    return self;
}

-(UIButton *)makeBtnLabelByShowingType:(UILabelShowingType)labelShowingType{
    [self.superview layoutIfNeeded];
    self.titleLabel.labelShowingType = labelShowingType;
    switch (labelShowingType) {
        case UILabelShowingType_01:{/// 一行显示。定宽、定高、定字体。多余部分用…表示（省略号的位置由NSLineBreakMode控制）
            self.titleLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;// NSLineBreakByTruncatingHead、NSLineBreakByTruncatingMiddle、NSLineBreakByTruncatingTail
        }break;
        case UILabelShowingType_02:{/// 一行显示。定宽、定高、定字体。多余部分scrollerView
            /// 在不全局集成@implementation UILabel (AutoScroll)的前提下
            /// 要求本类是 BaseButton
        }break;
        case UILabelShowingType_03:{/// 一行显示。不定宽、定高、定字体。宽度自适应
            [self buttonAutoWidthByFont];
            [self uninstall:NSLayoutAttributeWidth];
        }break;
        case UILabelShowingType_04:{/// 一行显示。定宽、定高。缩小字体方式全展示
            [self buttonAutoFontByWidth];
        }break;
        case UILabelShowingType_05:{/// 多行显示。定宽、不定高、定字体
            self.titleLabel.numberOfLines = 0;
            self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;/// 自动折行设置【默认】需要提前设置imageTitleSpace
            [self uninstall:NSLayoutAttributeHeight];
            NSLog(@"%f,%f",self.width,self.height);
            NSLog(@"%@",self.titleForNormalState);
            CGSize size = [UILabel sizeWithText:self.titleForNormalState
                                           font:self.titleLabel.font
                                        maxSize:CGSizeMake(self.width, MAXFLOAT)];
            [self mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(size.height + self.imageView.height + self.imageTitleSpace);// 文字 + 图片 + 手动偏移量
            }];
            if (self.objectBlock) self.objectBlock(@(size.height));
        }break;
            
        default:
            break;
    }return self;
}
static char *UIButton_Extra_imageTitleSpace = "UIButton_Extra_imageTitleSpace";
@dynamic imageTitleSpace;
#pragma mark —— @property(nonatomic,assign)CGFloat imageTitleSpace;
-(CGFloat)imageTitleSpace{//默认不显示
    CGFloat ImageTitleSpace = [objc_getAssociatedObject(self, UIButton_Extra_imageTitleSpace) floatValue];
    return ImageTitleSpace;
}

-(void)setImageTitleSpace:(CGFloat)imageTitleSpace{
    objc_setAssociatedObject(self,
                             UIButton_Extra_imageTitleSpace,
                             [NSNumber numberWithFloat:imageTitleSpace],
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
