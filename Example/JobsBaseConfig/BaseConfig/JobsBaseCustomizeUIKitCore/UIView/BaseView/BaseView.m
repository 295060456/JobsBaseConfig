//
//  BaseView.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2021/2/5.
//  Copyright © 2021 MonkeyKingVideo. All rights reserved.
//

#import "BaseView.h"

@interface BaseView ()

@end

@implementation BaseView

#pragma mark —— UIViewModelProtocol
UIViewModelProtocol_synthesize
#pragma mark —— BaseProtocol
BaseProtocol_synthesize
#pragma mark —— BaseViewProtocol
BaseViewProtocol_synthesize

-(instancetype)init{
    if (self = [super init]) {

    }return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
    }return self;
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
}
/**
 1. 刷新完成后触发 layoutsubview
 UICollectionView 在 reloaddata 后, 会触发 layoutsubview , 可以继承父类的 superview 方法, 在其中处理需要在刷新完数据后做的操作, 如播放短视频.

 2. 使用layoutIfNeeded方法，强制重绘
 在 UICollectionView 调用 reloaddata 方法后, 强制调用其 layoutIfNeeded 方法, 接着调用刷新完后的操作.
 */
-(void)layoutSubviews{
    [super layoutSubviews];
    if(!CGSizeEqualToSize(CGSizeZero, self.layoutSubviewsRectCornerSize)){
        [self layoutSubviewsCutCnrByRoundingCorners:self.layoutSubviewsRectCorner
                                        cornerRadii:self.layoutSubviewsRectCornerSize];
    }
}

-(void)layoutIfNeeded{
    [super layoutIfNeeded];
}
#pragma mark —— BaseViewProtocol
/// 具体由子类进行复写【数据定UI】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
-(void)richElementsInViewWithModel:(id _Nullable)model{}
/// 具体由子类进行复写【数据定宽】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
+(CGFloat)viewWidthWithModel:(id _Nullable)model{
    return 0;
}
/// 具体由子类进行复写【数据定高】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
+(CGFloat)viewHeightWithModel:(id _Nullable)model{
    return 0;
}
/// 具体由子类进行复写【数据尺寸】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
+(CGSize)viewSizeWithModel:(id _Nullable)model{
    return CGSizeZero;
}
/// 具体由子类进行复写【数据Frame】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
+(CGRect)viewFrameWithModel:(id _Nullable)model{
    return CGRectZero;
}

@end
