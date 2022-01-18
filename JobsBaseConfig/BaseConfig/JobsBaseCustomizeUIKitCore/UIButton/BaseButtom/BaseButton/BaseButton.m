//
//  BaseButton.m
//  DouDong-II
//
//  Created by Jobs on 2021/6/1.
//

#import "BaseButton.h"

@interface BaseButton ()

@end

@implementation BaseButton

-(instancetype)init{
    if (self = [super init]) {
        
    }return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
    }return self;
}

- (void)drawRect:(CGRect)rect{
    if (self.titleLabel.labelShowingType == UILabelShowingType_02) {
        self.layer.masksToBounds = true;
        if (!self.shouldAutoScroll){
            [super drawRect:rect];
        }
        [self setTextLayerScroll];
        [self normalTitle:@""];
    }else{
        [super drawRect:rect];
    }
}

-(void)setFrame:(CGRect)frame{
    if (self.titleLabel.labelShowingType == UILabelShowingType_02) {
        [self setTextLayerScroll];
    }else{
        NSLog(@"%ld",self.titleLabel.labelShowingType);
        [super setFrame:frame];
    }
}
#pragma mark —— BaseButtonProtocol
/// 具体由子类进行复写【数据定UI】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
-(void)richElementsInButtonWithModel:(id _Nullable)model{}
/// 具体由子类进行复写【数据定宽】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
+(CGFloat)buttonWidthWithModel:(id _Nullable)model{
    return 0;
}
/// 具体由子类进行复写【数据定高】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
+(CGFloat)buttonHeightWithModel:(id _Nullable)model{
    return 0;
}
/// 具体由子类进行复写【数据尺寸】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
+(CGSize)buttonSizeWithModel:(id _Nullable)model{
    return CGSizeZero;
}
/// 具体由子类进行复写【数据Frame】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
+(CGRect)buttonFrameWithModel:(id _Nullable)model{
    return CGRectZero;
}

@end
