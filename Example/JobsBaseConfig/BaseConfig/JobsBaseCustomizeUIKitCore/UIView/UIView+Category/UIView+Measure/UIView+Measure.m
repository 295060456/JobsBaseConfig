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
#pragma mark —— 一些工具方法
/// 重设Frame
-(JobsReturnCGRectByCGFloatBlock _Nonnull)resetOriginX{
    @jobs_weakify(self)
    return ^(CGFloat data) {
        @jobs_strongify(self)
        CGRect frame = self.frame;
        frame.origin.x = data;
        self.frame = frame;
        return self.frame;
    };
}

-(JobsReturnCGRectByCGFloatBlock _Nonnull)resetOriginY{
    @jobs_weakify(self)
    return ^(CGFloat data) {
        @jobs_strongify(self)
        CGRect frame = self.frame;
        frame.origin.y = data;
        self.frame = frame;
        return self.frame;
    };
}

-(JobsReturnCGRectByCGFloatBlock _Nonnull)resetWidth{
    @jobs_weakify(self)
    return ^(CGFloat data) {
        @jobs_strongify(self)
        CGRect frame = self.frame;
        frame.size.width = data;
        self.frame = frame;
        return self.frame;
    };
}

-(JobsReturnCGRectByCGFloatBlock _Nonnull)resetHeight{
    @jobs_weakify(self)
    return ^(CGFloat data) {
        @jobs_strongify(self)
        CGRect frame = self.frame;
        frame.size.height = data;
        self.frame = frame;
        return self.frame;
    };
}

-(JobsReturnCGRectByCGPointBlock _Nonnull)resetOrigin{
    @jobs_weakify(self)
    return ^(CGPoint data) {
        @jobs_strongify(self)
        CGRect frame = self.frame;
        frame.origin.x = data.x;
        frame.origin.y = data.y;
        self.frame = frame;
        return self.frame;
    };
}

-(JobsReturnCGRectByCGSizeBlock _Nonnull)resetSize{
    @jobs_weakify(self)
    return ^(CGSize data) {
        @jobs_strongify(self)
        CGRect frame = self.frame;
        frame.size = data;
        self.frame = frame;
        return self.frame;
    };
}
/// 依据偏移量重设Frame
-(JobsReturnCGRectByCGFloatBlock _Nonnull)resetByOffsetOriginX{
    @jobs_weakify(self)
    return ^(CGFloat data) {
        @jobs_strongify(self)
        CGRect frame = self.frame;
        frame.origin.x += data;
        self.frame = frame;
        return self.frame;
    };
}

-(JobsReturnCGRectByCGFloatBlock _Nonnull)resetByOffsetOriginY{
    @jobs_weakify(self)
    return ^(CGFloat data) {
        @jobs_strongify(self)
        CGRect frame = self.frame;
        frame.origin.y += data;
        self.frame = frame;
        return self.frame;
    };
}

-(JobsReturnCGRectByCGFloatBlock _Nonnull)resetCenterX{
    @jobs_weakify(self)
    return ^(CGFloat data) {
        @jobs_strongify(self)
        CGPoint center = self.center;
        center.x = data;
        self.center = center;
        return self.frame;
    };
}

-(JobsReturnCGRectByCGFloatBlock _Nonnull)resetCenterY{
    @jobs_weakify(self)
    return ^(CGFloat data) {
        @jobs_strongify(self)
        CGPoint center = self.center;
        center.y = data;
        self.center = center;
        return self.frame;
    };
}

-(JobsReturnCGRectByCGFloatBlock _Nonnull)resetByOffsetWidth{
    @jobs_weakify(self)
    return ^(CGFloat data) {
        @jobs_strongify(self)
        CGRect frame = self.frame;
        frame.size.width += data;
        self.frame = frame;
        return self.frame;
    };
}

-(JobsReturnCGRectByCGFloatBlock _Nonnull)resetByOffsetHeight{
    @jobs_weakify(self)
    return ^(CGFloat data) {
        @jobs_strongify(self)
        CGRect frame = self.frame;
        frame.size.height += data;
        self.frame = frame;
        return self.frame;
    };
}

-(JobsReturnCGRectByCGPointBlock _Nonnull)resetByOffsetOrigin{
    @jobs_weakify(self)
    return ^(CGPoint data) {
        @jobs_strongify(self)
        CGRect frame = self.frame;
        frame.origin.x += data.x;
        frame.origin.y += data.y;
        self.frame = frame;
        return self.frame;
    };
}

-(JobsReturnCGRectByCGSizeBlock _Nonnull)resetByOffsetSize{
    @jobs_weakify(self)
    return ^(CGSize data) {
        @jobs_strongify(self)
        CGRect frame = self.frame;
        frame.size.width += data.width;
        frame.size.height += data.height;
        self.frame = frame;
        return self.frame;
    };
}
/// 依据偏移量重塑Frame
-(void)offsetForView:(UIViewModel *)viewModel{
    CGRect viewFrame = self.frame;
    viewFrame.origin.x += viewModel.offsetXForEach;
    viewFrame.origin.y += viewModel.offsetYForEach;
    viewFrame.size.width += viewModel.offsetWidth;
    viewFrame.size.height += viewModel.offsetHeight;
    self.frame = viewFrame;
}
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
            self.right =  self.centerX + view.width/2;
        }else{
            self.right = view.right;
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
            self.height = self.centerY + view.height/2;
        }else{
            self.height = view.height;
        }
    };
}
#pragma mark —— BaseViewProtocol
/// 数据（字符串）定宽
/// data.textModel.textLineSpacing
/// data.textModel.font
/// data.jobsHeight
/// data.textModel.text
+(CGFloat)widthByData:(UIViewModel *_Nonnull)data{
    return [data.textModel.text getContentHeightOrWidthWithParagraphStyleLineSpacing:data.textModel.textLineSpacing
                                                               calcLabelHeight_Width:CalcLabelWidth
                                                                                font:data.textModel.font
                                                        boundingRectWithHeight_Width:data.jobsHeight];
}
/// 数据（字符串）定高
/// data.textModel.textLineSpacing
/// data.textModel.font
/// data.jobsWidth
/// data.textModel.text
+(CGFloat)heightByData:(UIViewModel *_Nonnull)data{
    return [data.textModel.text getContentHeightOrWidthWithParagraphStyleLineSpacing:data.textModel.textLineSpacing
                                                               calcLabelHeight_Width:CalcLabelHeight
                                                                                font:data.textModel.font
                                                        boundingRectWithHeight_Width:data.jobsWidth];
}
#pragma mark —— 简捷获得控件坐标
static char *UIView_Measure_x = "UIView_Measure_x";
@dynamic x;
#pragma mark —— @property(nonatomic,assign)CGFloat x
-(CGFloat)x{
    if (objc_getAssociatedObject(self, UIView_Measure_x)) {
        return [objc_getAssociatedObject(self, UIView_Measure_x) floatValue];
    }else{
        CGFloat X = self.frame.origin.x;
        [self setX:X];
        return X;
    }
}

-(void)setX:(CGFloat)x{
    self.frame = self.resetOriginX(x);
    objc_setAssociatedObject(self,
                             UIView_Measure_x,
                             [NSNumber numberWithFloat:x],
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

static char *UIView_Measure_y = "UIView_Measure_y";
@dynamic y;
#pragma mark —— @property(nonatomic,assign)CGFloat y
-(CGFloat)y{
    if (objc_getAssociatedObject(self, UIView_Measure_y)) {
        return [objc_getAssociatedObject(self, UIView_Measure_y) floatValue];
    }else{
        CGFloat Y = self.frame.origin.y;
        [self setY:Y];
        return Y;
    }
}

-(void)setY:(CGFloat)y{
    self.frame = self.resetOriginY(y);
    objc_setAssociatedObject(self,
                             UIView_Measure_y,
                             [NSNumber numberWithFloat:y],
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

static char *UIView_Measure_width = "UIView_Measure_width";
@dynamic width;
#pragma mark —— @property(nonatomic,assign)CGFloat width
-(CGFloat)width{
    if (objc_getAssociatedObject(self, UIView_Measure_width)) {
        return [objc_getAssociatedObject(self, UIView_Measure_width) floatValue];
    }else{
        CGFloat Width = self.frame.size.width;
        [self setWidth:Width];
        return Width;
    }
}

-(void)setWidth:(CGFloat)width{
    self.frame = self.resetWidth(width);
    objc_setAssociatedObject(self,
                             UIView_Measure_width,
                             [NSNumber numberWithFloat:width],
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

static char *UIView_Measure_height = "UIView_Measure_height";
@dynamic height;
#pragma mark —— @property(nonatomic,assign)CGFloat height
-(CGFloat)height{
    if (objc_getAssociatedObject(self, UIView_Measure_height)) {
        return [objc_getAssociatedObject(self, UIView_Measure_height) floatValue];
    }else{
        CGFloat Height = self.frame.size.height;
        [self setHeight:Height];
        return Height;
    }
}

-(void)setHeight:(CGFloat)height{
    self.frame = self.resetHeight(height);
    objc_setAssociatedObject(self,
                             UIView_Measure_height,
                             [NSNumber numberWithFloat:height],
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

static char *UIView_Measure_centerX = "UIView_Measure_centerX";
@dynamic centerX;
#pragma mark —— @property(nonatomic,assign)CGFloat centerX
-(CGFloat)centerX{
    if (objc_getAssociatedObject(self, UIView_Measure_centerX)) {
        return [objc_getAssociatedObject(self, UIView_Measure_centerX) floatValue];
    }else{
        CGFloat CenterX = self.center.x;
        [self setCenterX:CenterX];
        return CenterX;
    }
}

-(void)setCenterX:(CGFloat)centerX{
    self.frame = self.resetCenterX(centerX);
    objc_setAssociatedObject(self,
                             UIView_Measure_centerX,
                             [NSNumber numberWithFloat:centerX],
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

static char *UIView_Measure_centerY = "UIView_Measure_centerY";
@dynamic centerY;
#pragma mark —— @property(nonatomic,assign)CGFloat centerY
-(CGFloat)centerY{
    if (objc_getAssociatedObject(self, UIView_Measure_centerY)) {
        return [objc_getAssociatedObject(self, UIView_Measure_centerY) floatValue];
    }else{
        CGFloat CenterY = self.center.y;
        [self setCenterY:CenterY];
        return CenterY;
    }
}

-(void)setCenterY:(CGFloat)centerY{
    self.frame = self.resetCenterY(centerY);
    objc_setAssociatedObject(self,
                             UIView_Measure_centerY,
                             [NSNumber numberWithFloat:centerY],
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

static char *UIView_Measure_left = "UIView_Measure_left";
@dynamic left;
#pragma mark —— @property(nonatomic,assign)CGFloat left
-(CGFloat)left{
    if (objc_getAssociatedObject(self, UIView_Measure_left)) {
        return [objc_getAssociatedObject(self, UIView_Measure_left) floatValue];
    }else{
        CGFloat Left = self.frame.origin.x;
        [self setLeft:Left];
        return Left;
    }
}

-(void)setLeft:(CGFloat)left{
    self.frame = self.resetOriginX(left);
    objc_setAssociatedObject(self,
                             UIView_Measure_left,
                             [NSNumber numberWithFloat:left],
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

static char *UIView_Measure_right = "UIView_Measure_right";
@dynamic right;
#pragma mark —— @property(nonatomic,assign)CGFloat right
-(CGFloat)right{
    if (objc_getAssociatedObject(self, UIView_Measure_right)) {
        return [objc_getAssociatedObject(self, UIView_Measure_right) floatValue];
    }else{
        CGFloat Right = self.frame.origin.x + self.frame.size.width;
        [self setRight:Right];
        return Right;
    }
}

-(void)setRight:(CGFloat)right{
    self.frame = self.resetOriginX(right - self.width);
    objc_setAssociatedObject(self,
                             UIView_Measure_right,
                             [NSNumber numberWithFloat:right],
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

static char *UIView_Measure_top = "UIView_Measure_top";
@dynamic top;
#pragma mark —— @property(nonatomic,assign)CGFloat top
-(CGFloat)top{
    if (objc_getAssociatedObject(self, UIView_Measure_top)) {
        return [objc_getAssociatedObject(self, UIView_Measure_top) floatValue];
    }else{
        CGFloat Top = CGRectGetMinY(self.frame);
        [self setTop:Top];
        return Top;
    }
}

-(void)setTop:(CGFloat)top{
    self.frame = self.resetOriginY(top);
    objc_setAssociatedObject(self,
                             UIView_Measure_top,
                             [NSNumber numberWithFloat:top],
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

static char *UIView_Measure_bottom = "UIView_Measure_bottom";
@dynamic bottom;
#pragma mark —— @property(nonatomic,assign)CGFloat bottom
-(CGFloat)bottom{
    if (objc_getAssociatedObject(self, UIView_Measure_bottom)) {
        return [objc_getAssociatedObject(self, UIView_Measure_bottom) floatValue];
    }else{
        CGFloat Bottom = self.frame.origin.y + self.frame.size.height;
        [self setBottom:Bottom];
        return Bottom;
    }
}

-(void)setBottom:(CGFloat)bottom{
    self.frame = self.resetOriginY(bottom - self.height);
    objc_setAssociatedObject(self,
                             UIView_Measure_bottom,
                             [NSNumber numberWithFloat:bottom],
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

static char *UIView_Measure_size = "UIView_Measure_size";
@dynamic size;
#pragma mark —— @property(nonatomic,assign)CGSize size
-(CGSize)size{
    if (objc_getAssociatedObject(self, UIView_Measure_size)) {
        return [objc_getAssociatedObject(self, UIView_Measure_size) CGSizeValue];
    }else{
        CGSize Size = self.frame.size;
        [self setSize:Size];
        return Size;
    }
}

-(void)setSize:(CGSize)size{
    self.frame = self.resetSize(size);
    objc_setAssociatedObject(self,
                             UIView_Measure_size,
                             [NSValue valueWithCGSize:size],
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

static char *NSObject_Extras_origin = "NSObject_Extras_origin";
@dynamic origin;
#pragma mark —— @property(nonatomic,assign)CGPoint origin
-(CGPoint)origin{
    if (objc_getAssociatedObject(self, NSObject_Extras_origin)) {
        return [objc_getAssociatedObject(self, NSObject_Extras_origin) CGPointValue];
    }else{
        CGPoint Point = self.frame.origin;
        [self setOrigin:Point];
        return Point;
    }
}

-(void)setOrigin:(CGPoint)origin{
    self.frame = self.resetOrigin(origin);
    objc_setAssociatedObject(self,
                             NSObject_Extras_origin,
                             [NSValue valueWithCGPoint:origin],
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
