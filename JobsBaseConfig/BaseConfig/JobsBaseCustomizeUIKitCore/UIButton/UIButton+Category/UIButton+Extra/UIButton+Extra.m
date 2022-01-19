//
//  UIButton+Extra.m
//  JobsBaseConfig
//
//  Created by Jobs on 2022/1/18.
//

#import "UIButton+Extra.h"

@implementation UIButton (Extra)

-(void)makeBtnLabelByShowingType:(UILabelShowingType)labelShowingType{
    [self.superview layoutIfNeeded];
    self.titleLabel.labelShowingType = labelShowingType;
    switch (labelShowingType) {
        case UILabelShowingType_01:{///  一行显示。定宽、定字体。多余部分用…表示（省略号的位置由NSLineBreakMode控制）
            self.titleLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;// NSLineBreakByTruncatingHead、NSLineBreakByTruncatingMiddle、NSLineBreakByTruncatingTail
        }break;
        case UILabelShowingType_02:{/// 一行显示。定宽、定字体。多余部分scrollerView
            /// 在不全局集成@implementation UILabel (AutoScroll)的前提下
            /// 要求本类是 BaseButton
        }break;
        case UILabelShowingType_03:{/// 一行显示。定字体，不定宽。宽度自适应
            [self buttonAutoWidthByFont];
            [self uninstall:NSLayoutAttributeWidth];
        }break;
        case UILabelShowingType_04:{/// 一行显示。缩小字体方式全展示
            [self buttonAutoFontByWidth];
        }break;
        case UILabelShowingType_05:{/// 多行显示。定宽、定字体
            self.titleLabel.numberOfLines = 0;
            self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;/// 自动折行设置【默认】
            [self uninstall:NSLayoutAttributeHeight];
            CGSize size = [UILabel sizeWithText:self.titleForNormalState
                                           font:self.titleLabel.font
                                        maxSize:CGSizeMake(self.width, MAXFLOAT)];
            [self mas_updateConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(self.width, size.height));
            }];
            if (self.viewBlock) self.viewBlock(@(size.height));
        }break;
            
        default:
            break;
    }
}

@end
