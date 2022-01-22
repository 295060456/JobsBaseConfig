//
//  UILabel+Extra.m
//  Casino
//
//  Created by Jobs on 2021/12/27.
//

#import "UILabel+Extra.h"

@implementation UILabel (Extra)

static char *UILabel_Extra_labelShowingType = "UILabel_Extra_labelShowingType";
@dynamic labelShowingType;

-(void)lbBackgroundImage:(UIImage *)bgImage{
    self.backgroundColor = [UIColor colorWithPatternImage:bgImage];
}

-(void)makeLabelByShowingType:(UILabelShowingType)labelShowingType{
    [self.superview layoutIfNeeded];
    self.labelShowingType = labelShowingType;
    switch (labelShowingType) {
        case UILabelShowingType_01:{///  一行显示。定宽、定字体。多余部分用…表示（省略号的位置由NSLineBreakMode控制）
            self.lineBreakMode = NSLineBreakByTruncatingMiddle;// NSLineBreakByTruncatingHead、NSLineBreakByTruncatingMiddle、NSLineBreakByTruncatingTail
        }break;
        case UILabelShowingType_02:{/// 一行显示。定宽、定字体。多余部分scrollerView
            /// 在不全局集成@implementation UILabel (AutoScroll)的前提下
            /// 要求本类是 BaseLabel
        }break;
        case UILabelShowingType_03:{/// 一行显示。定字体，不定宽。宽度自适应
            [self labelAutoWidthByFont];
            [self uninstall:NSLayoutAttributeWidth];
        }break;
        case UILabelShowingType_04:{/// 一行显示。缩小字体方式全展示
            [self labelAutoFontByWidth];
        }break;
        case UILabelShowingType_05:{/// 多行显示。定宽、定字体
            self.numberOfLines = 0;
            self.lineBreakMode = NSLineBreakByWordWrapping;/// 自动折行设置【默认】
            [self uninstall:NSLayoutAttributeHeight];
        }break;
            
        default:
            break;
    }
}
#pragma mark —— @property(nonatomic,assign)UILabelShowingType labelShowingType;
-(UILabelShowingType)labelShowingType{
    UILabelShowingType LabelShowingType = [objc_getAssociatedObject(self, UILabel_Extra_labelShowingType) integerValue];
    return LabelShowingType;
}

-(void)setLabelShowingType:(UILabelShowingType)labelShowingType{
    objc_setAssociatedObject(self,
                             UILabel_Extra_labelShowingType,
                             [NSNumber numberWithInteger:labelShowingType],
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
