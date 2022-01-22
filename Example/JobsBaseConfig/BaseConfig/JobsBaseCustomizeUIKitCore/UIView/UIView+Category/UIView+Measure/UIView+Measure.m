//
//  UIView+Measure.m
//  My_BaseProj
//
//  Created by Jobs on 2020/9/1.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "UIView+Measure.h"
/* ❤️【优先级】 @implementation UIView (Measure) > Masonry,因为Masonry刷新后才有frame ❤️*/
@implementation UIView (Measure)

#pragma mark ——【UIView对齐方法扩充】 https://github.com/MisterZhouZhou/ZWUIViewExtension
/// 设置水平方向对齐
-(EqualToView)centerxEqualToView{
    @jobs_weakify(self);
    return ^(UIView *view){
        @jobs_strongify(self);
        //如果是子父关系
        if ([self.superview isKindOfClass:view.class]) {
            self.center = CGPointMake(view.center.x - view.x, self.center.y);
        }else{
            self.center = CGPointMake(view.center.x, self.center.y);
        }
    };
}
/// 设置垂平方向对齐
-(EqualToView)centeryEqualToView{
    @jobs_weakify(self);
    return ^(UIView *view){
        @jobs_strongify(self);
        //如果是子父关系
         if ([self.superview isKindOfClass:view.class]) {
             self.center = CGPointMake(self.center.x, view.center.y - view.y);
         }else{
             self.center = CGPointMake(self.center.x, view.center.y);
         }
    };
}
/// 设置中心方向对齐
-(EqualToView)centerEqualToView{
    @jobs_weakify(self);
    return ^(UIView *view){
        @jobs_strongify(self);
        //如果是子父关系
        if ([self.superview isKindOfClass:view.class]) {
            self.center = CGPointMake(view.center.x - view.x , view.center.y - view.y);
        }else{
            self.center = view.center;
        }
    };
}
/// 设置左对齐
-(EqualToView)leftEqualToView{
    @jobs_weakify(self);
    return ^(UIView *view){
        @jobs_strongify(self);
        //如果是子父关系
        if ([self.superview isKindOfClass:view.class]) {
            self.center = CGPointMake(view.center.x - view.x,self.center.y);
            self.x =  self.centerX - view.width/2;
        }else{
            self.x = view.x;
        }
    };
}
/// 设置右对齐
-(EqualToView)rightEqualToView{
    @jobs_weakify(self);
    return ^(UIView *view){
        @jobs_strongify(self);
        //如果是子父关系
        if ([self.superview isKindOfClass:view.class]) {
            self.center = CGPointMake(view.center.x - view.x,self.center.y);
            self.maxX =  self.centerX + view.width/2;
        }else{
            self.maxX = view.maxX;
        }
    };
}
/// 设置顶部对齐
-(EqualToView)topEqualToView{
    @jobs_weakify(self);
    return ^(UIView *view){
        @jobs_strongify(self);
        //如果是子父关系
        if ([self.superview isKindOfClass:view.class]) {
            self.center = CGPointMake(self.center.x,view.center.y - view.y);
            self.y =  self.centerY - view.height/2;
        }else{
            self.y = view.y;
        }
    };
}
/// 设置底部对齐
-(EqualToView)bottomEqualToView{
    @jobs_weakify(self);
    return ^(UIView *view){
        @jobs_strongify(self);
        //如果是子父关系
        if ([self.superview isKindOfClass:view.class]) {
            self.center = CGPointMake(self.center.x,view.center.y - view.y);
            self.maxY = self.centerY + view.height/2;
        }else{
            self.maxY = view.maxY;
        }
    };
}
#pragma mark —— 简捷获得控件坐标
-(CGFloat)top {
    return CGRectGetMinY(self.frame);
}

-(void)setTop:(CGFloat)y{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

-(void)setX:(CGFloat)x{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

-(void)setY:(CGFloat)y{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

-(CGFloat)x{
    return self.frame.origin.x;
}

-(CGFloat)y{
    return self.frame.origin.y;
}

-(void)setCenterX:(CGFloat)centerX{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

-(CGFloat)centerX{
    return self.center.x;
}

-(void)setCenterY:(CGFloat)centerY{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

-(CGFloat)centerY{
    return self.center.y;
}

-(void)setWidth:(CGFloat)width{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

-(void)setHeight:(CGFloat)height{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

-(CGFloat)height{
    return self.frame.size.height;
}

-(CGFloat)width{
    return self.frame.size.width;
}

-(void)setSize:(CGSize)size{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

-(CGSize)size{
    return self.frame.size;
}

-(void)setOrigin:(CGPoint)origin{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

-(CGPoint)origin{
    return self.frame.origin;
}

-(CGFloat)getX{
    return CGRectGetMaxX(self.frame);
}

-(CGFloat)left{
    return self.frame.origin.x;
}

-(CGFloat)getY{
    return CGRectGetMaxY(self.frame);
}

-(CGFloat)right{
    return self.frame.origin.x + self.frame.size.width;
}

-(void)setLeft:(CGFloat)x{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

-(void)setRight:(CGFloat)right{
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

-(CGFloat)bottom{
    return self.frame.origin.y + self.frame.size.height;
}

-(void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (void)setMaxX:(CGFloat)maxX{
    CGRect frame = self.frame;
    frame.origin.x = maxX - self.width;
    self.frame = frame;
}

-(CGFloat)maxX{
    return self.frame.origin.x + self.frame.size.width;
}

-(CGFloat)maxY{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setMaxY:(CGFloat)maxY{
    CGRect frame = self.frame;
    frame.origin.y = maxY - self.height;
    self.frame = frame;
}
#pragma mark —— BaseViewProtocol
/// 数据（字符串）定宽
+(CGFloat)widthByData:(UIViewModel *_Nonnull)data{
    return [data.textModel.text getContentHeightOrWidthWithParagraphStyleLineSpacing:data.textModel.textLineSpacing
                                                               calcLabelHeight_Width:CalcLabelWidth
                                                                                font:data.textModel.font
                                                        boundingRectWithHeight_Width:data.jobsHeight];
}
/// 数据（字符串）定高
+(CGFloat)heightByData:(UIViewModel *_Nonnull)data{
    return [data.textModel.text getContentHeightOrWidthWithParagraphStyleLineSpacing:data.textModel.textLineSpacing
                                                               calcLabelHeight_Width:CalcLabelHeight
                                                                                font:data.textModel.font
                                                        boundingRectWithHeight_Width:data.jobsWidth];
}

@end
