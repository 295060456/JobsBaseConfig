//
//  UILabel+Extra.m
//  Casino
//
//  Created by Jobs on 2021/12/27.
//

#import "UILabel+Extra.h"

@implementation UILabel (Extra)
#pragma mark —— 一些公共方法
/// UILabel文字旋转
-(void)transformLayer:(TransformLayerDirectionType)directionType{
    /**
     资料来源：
     https://www.jianshu.com/p/3a08ef4762ac
     https://github.com/wuzhenweichn/TextDirection
     */
    self.transformLayerDirectionType = directionType;
    [self.layer addSublayer:self.shapeLayer];
    self.textColor = UIColor.clearColor;
}
/// 通过传入的(UIImage *)bgImage 来设置背景颜色
-(void)lbBackgroundImage:(UIImage *)bgImage{
    self.backgroundColor = [UIColor colorWithPatternImage:bgImage];
}
/// 设置UILabel的显示样式 【在Masonry以后拿到了frame】
-(void)makeLabelByShowingType:(UILabelShowingType)labelShowingType{
    /// 先刷新得出Label的frame.及其Size
    [self.superview layoutIfNeeded];
    self.labelShowingType = labelShowingType;
    switch (labelShowingType) {
        case UILabelShowingType_01:{///  一行显示。定宽、定高、定字体。多余部分用…表示（省略号的位置由NSLineBreakMode控制）
            if (self.width && self.height) {
                self.lineBreakMode = NSLineBreakByTruncatingMiddle;// NSLineBreakByTruncatingHead、NSLineBreakByTruncatingMiddle、NSLineBreakByTruncatingTail
            }
        }break;
        case UILabelShowingType_02:{/// 一行显示。定宽、定高、定字体。多余部分scrollerView
            /// 在不全局集成@implementation UILabel (AutoScroll)的前提下
            /// 要求本类是 BaseLabel
        }break;
        case UILabelShowingType_03:{/// 一行显示。不定宽、不定高、定字体。宽高自适应 【单行：ByFont】 可以不要高
            if (self.height) {
                [self labelAutoWidthByFont];
                if (self.width) {
                    [self uninstall:NSLayoutAttributeWidth];//强制
                }
            }
        }break;
        case UILabelShowingType_04:{/// 一行显示。定宽、定高。缩小字体方式全展示 【单行：ByWidth】
            if (self.width && self.height) {
                [self labelAutoFontByWidth];
            }
        }break;
        case UILabelShowingType_05:{/// 多行显示。定宽、不定高、定字体 【多行：ByFont】
            if (self.width) {
                self.numberOfLines = 0;
                self.lineBreakMode = NSLineBreakByWordWrapping;/// 自动折行设置【默认】
                if (self.height) {
                    [self uninstall:NSLayoutAttributeHeight];
                }
            }
        }break;
            
        default:
            break;
    }
}
static char *UILabel_Extra_labelShowingType = "UILabel_Extra_labelShowingType";
@dynamic labelShowingType;
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
static char *UILabel_Extra_value = "UILabel_Extra_value";
@dynamic value;
#pragma mark —— @property(nonatomic,assign)CGFloat value;
-(CGFloat)value{
    return [objc_getAssociatedObject(self, UILabel_Extra_value) floatValue];
}

-(void)setValue:(CGFloat)value{
    objc_setAssociatedObject(self,
                             UILabel_Extra_value,
                             [NSNumber numberWithFloat:value],
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

static char *UILabel_Extra_lastValue = "UILabel_Extra_lastValue";
@dynamic lastValue;
#pragma mark —— @property(nonatomic,assign)CGFloat lastValue;
-(CGFloat)lastValue{
    return [objc_getAssociatedObject(self, UILabel_Extra_lastValue) floatValue];
}

-(void)setLastValue:(CGFloat)lastValue{
    objc_setAssociatedObject(self,
                             UILabel_Extra_lastValue,
                             [NSNumber numberWithFloat:lastValue],
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
static char *UILabel_Extra_shapeLayer = "UILabel_Extra_shapeLayer";
@dynamic shapeLayer;
#pragma mark —— @property(nonatomic,strong)CAShapeLayer *shapeLayer;
-(CAShapeLayer *)shapeLayer{
    CAShapeLayer *ShapeLayer = objc_getAssociatedObject(self, UILabel_Extra_shapeLayer);
    if (!ShapeLayer) {
        ShapeLayer = [self.text animateOnView:self
                                       atRect:self.bounds
                                      forFont:self.font
                                    withColor:self.textColor
                                 andDirection:self.transformLayerDirectionType];
        objc_setAssociatedObject(self,
                                 UILabel_Extra_shapeLayer,
                                 ShapeLayer,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return ShapeLayer;
}

-(void)setShapeLayer:(CAShapeLayer *)shapeLayer{
    objc_setAssociatedObject(self,
                             UILabel_Extra_shapeLayer,
                             shapeLayer,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
static char *UILabel_Extra_transformLayerDirectionType = "UILabel_Extra_transformLayerDirectionType";
@dynamic transformLayerDirectionType;
#pragma mark —— @property(nonatomic,assign)TransformLayerDirectionType transformLayerDirectionType;
-(TransformLayerDirectionType)transformLayerDirectionType{
    return [objc_getAssociatedObject(self, UILabel_Extra_transformLayerDirectionType) unsignedIntegerValue];
}

-(void)setTransformLayerDirectionType:(TransformLayerDirectionType)transformLayerDirectionType{
    objc_setAssociatedObject(self,
                             UILabel_Extra_transformLayerDirectionType,
                             [NSNumber numberWithUnsignedInteger:transformLayerDirectionType],
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
