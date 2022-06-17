//
//  UIView+Gesture.m
//  DouDong-II
//
//  Created by Jobs on 2021/1/4.
//

#import "UIView+Gesture.h"

#warning —— 本类不实现UIGestureRecognizerDelegate的原因说明:覆盖了 UISCrollView 里面对应的方法
@implementation UIView (Gesture)
#pragma mark —— 一些公有方法
-(void)defaultFunc{
    NSLog(@"defaultFunc");
}
/// 取消注册各种手势对应的方法
-(void)Dealloc{
    UILongPressGestureRecognizer *LongPressGR = objc_getAssociatedObject(self, UIView_Gesture_longPressGR);
    if (LongPressGR) {
        if (self.longPressGR_SelImp.selector) {
            [LongPressGR removeTarget:self.target
                               action:self.longPressGR_SelImp.selector];
        }
    }
    UITapGestureRecognizer *TapGR = objc_getAssociatedObject(self, UIView_Gesture_tapGR);
    if (TapGR) {
        if (self.tapGR_SelImp.selector) {
            [TapGR removeTarget:self.target
                         action:self.tapGR_SelImp.selector];
        }
    }
    UISwipeGestureRecognizer *SwipeGR = objc_getAssociatedObject(self, UIView_Gesture_swipeGR);
    if (SwipeGR) {
        if (self.swipeGR_SelImp.selector) {
            [SwipeGR removeTarget:self.target
                           action:self.swipeGR_SelImp.selector];
        }
    }
    UIPanGestureRecognizer *PanGR = objc_getAssociatedObject(self, UIView_Gesture_panGR);
    if (PanGR) {
        
        if (self.panGR_SelImp.selector) {
            [PanGR removeTarget:self.target
                         action:self.panGR_SelImp.selector];
        }
    }
    UIPinchGestureRecognizer *PinchGR = objc_getAssociatedObject(self, UIView_Gesture_pinchGR);
    if (PinchGR) {
        if (self.pinchGR_SelImp.selector) {
            [PinchGR removeTarget:self.target
                           action:self.pinchGR_SelImp.selector];
        }
    }
    UIRotationGestureRecognizer *RotationGR = objc_getAssociatedObject(self, UIView_Gesture_rotationGR);
    if (RotationGR) {
        if (self.rotationGR_SelImp.selector) {
            [RotationGR removeTarget:self.target
                              action:self.rotationGR_SelImp.selector];
        }
    }
    UIScreenEdgePanGestureRecognizer *ScreenEdgePanGR = objc_getAssociatedObject(self, UIView_Gesture_screenEdgePanGR);
    if (ScreenEdgePanGR) {
        if (self.screenEdgePanGR_SelImp.selector) {
            [ScreenEdgePanGR removeTarget:self.target
                                   action:self.screenEdgePanGR_SelImp.selector];
        }
    }
}
static char *UIView_Gesture_target = "UIView_Gesture_target";
@dynamic target;
#pragma mark —— @property(nonatomic,strong,nullable)id target;/// 描述方法实现的位置
-(id)target{
    id target = objc_getAssociatedObject(self, UIView_Gesture_target);
    if (!target) {
        @jobs_weakify(self)
        [self setTarget:weak_self];
    }return target;
}

-(void)setTarget:(id)target{
    objc_setAssociatedObject(self,
                             UIView_Gesture_target,
                             target,
                             OBJC_ASSOCIATION_ASSIGN);
}
static char *UIView_Gesture_numberOfTapsRequired = "UIView_Gesture_numberOfTapsRequired";
@dynamic numberOfTapsRequired;
#pragma mark —— @property(nonatomic,assign)NSUInteger numberOfTapsRequired;//设置轻拍次数【UILongPressGestureRecognizer】【UITapGestureRecognizer】
-(NSUInteger)numberOfTapsRequired{
    return [objc_getAssociatedObject(self, UIView_Gesture_numberOfTapsRequired) unsignedIntegerValue];
}

-(void)setNumberOfTapsRequired:(NSUInteger)numberOfTapsRequired{
    objc_setAssociatedObject(self,
                             UIView_Gesture_numberOfTapsRequired,
                             [NSNumber numberWithInteger:numberOfTapsRequired],
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
static char *UIView_Gesture_numberOfTouchesRequired = "UIView_Gesture_numberOfTouchesRequired";
@dynamic numberOfTouchesRequired;
#pragma mark —— @property(nonatomic,assign)NSUInteger numberOfTouchesRequired;//设置手指字数【UILongPressGestureRecognizer】【UITapGestureRecognizer】
-(NSUInteger)numberOfTouchesRequired{
    return [objc_getAssociatedObject(self, UIView_Gesture_numberOfTouchesRequired) unsignedIntegerValue];
}

-(void)setNumberOfTouchesRequired:(NSUInteger)numberOfTouchesRequired{
    objc_setAssociatedObject(self,
                             UIView_Gesture_numberOfTouchesRequired,
                             [NSNumber numberWithUnsignedInteger:numberOfTouchesRequired],
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
static char *UIView_Gesture_minimumPressDuration = "UIView_Gesture_minimumPressDuration";
@dynamic minimumPressDuration;
#pragma mark —— @property(nonatomic,assign)NSTimeInterval minimumPressDuration;//longPressGR最小长按时间【UILongPressGestureRecognizer】
-(NSTimeInterval)minimumPressDuration{
    return [objc_getAssociatedObject(self, UIView_Gesture_minimumPressDuration) doubleValue];
}

-(void)setMinimumPressDuration:(NSTimeInterval)minimumPressDuration{
    objc_setAssociatedObject(self,
                             UIView_Gesture_minimumPressDuration,
                             [NSNumber numberWithDouble:minimumPressDuration],
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
static char *UIView_Gesture_allowableMovement = "UIView_Gesture_allowableMovement";
@dynamic allowableMovement;
#pragma mark —— @property(nonatomic,assign)CGFloat allowableMovement;//【UILongPressGestureRecognizer】
-(CGFloat)allowableMovement{
    return [objc_getAssociatedObject(self, UIView_Gesture_allowableMovement) floatValue];
}

-(void)setAllowableMovement:(CGFloat)allowableMovement{
    objc_setAssociatedObject(self,
                             UIView_Gesture_allowableMovement,
                             [NSNumber numberWithFloat:allowableMovement],
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
static char *UIView_Gesture_swipeGRDirection = "UIView_Gesture_swipeGRDirection";
@dynamic swipeGRDirection;
#pragma mark —— @property(nonatomic,assign)UISwipeGestureRecognizerDirection swipeGRDirection;//swipe手势清扫方向
-(UISwipeGestureRecognizerDirection)swipeGRDirection{
    return [objc_getAssociatedObject(self, UIView_Gesture_swipeGRDirection) unsignedIntegerValue];
}

-(void)setSwipeGRDirection:(UISwipeGestureRecognizerDirection)swipeGRDirection{
    objc_setAssociatedObject(self,
                             UIView_Gesture_swipeGRDirection,
                             [NSNumber numberWithUnsignedInteger:swipeGRDirection],
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
static char *UIView_Gesture_allowedScrollTypesMask = "UIView_Gesture_allowedScrollTypesMask";
@dynamic allowedScrollTypesMask;
#pragma mark —— @property(nonatomic,assign)UIScrollTypeMask allowedScrollTypesMask;
-(UIScrollTypeMask)allowedScrollTypesMask{
    return [objc_getAssociatedObject(self, UIView_Gesture_allowedScrollTypesMask) integerValue];
}

-(void)setAllowedScrollTypesMask:(UIScrollTypeMask)allowedScrollTypesMask{
    objc_setAssociatedObject(self,
                             UIView_Gesture_allowedScrollTypesMask,
                             [NSNumber numberWithInteger:allowedScrollTypesMask],
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
static char *UIView_Gesture_scale = "UIView_Gesture_scale";
@dynamic scale;
#pragma mark —— @property(nonatomic,assign)CGFloat scale;
-(CGFloat)scale{
    return [objc_getAssociatedObject(self, UIView_Gesture_scale) floatValue];
}

-(void)setScale:(CGFloat)scale{
    objc_setAssociatedObject(self,
                             UIView_Gesture_scale,
                             [NSNumber numberWithFloat:scale],
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
static char *UIView_Gesture_rotate = "UIView_Gesture_rotate";
@dynamic rotate;
#pragma mark —— @property(nonatomic,assign)CGFloat rotate;
-(CGFloat)rotate{
    return [objc_getAssociatedObject(self, UIView_Gesture_rotate) floatValue];
}

-(void)setRotate:(CGFloat)rotate{
    objc_setAssociatedObject(self,
                             UIView_Gesture_rotate,
                             [NSNumber numberWithFloat:rotate],
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
static char *UIView_Gesture_longPressGR = "UIView_Gesture_longPressGR";
@dynamic longPressGR;
#pragma mark —— @property(nonatomic,strong)UILongPressGestureRecognizer *longPressGR;//长按手势
-(UILongPressGestureRecognizer *)longPressGR{
    UILongPressGestureRecognizer *LongPressGR = objc_getAssociatedObject(self, UIView_Gesture_longPressGR);
    if (!LongPressGR) {
        LongPressGR = UILongPressGestureRecognizer.new;
        NSLog(@"self.target = %@",self.target);
        LongPressGR.delegate = self.target;
        if (self.minimumPressDuration) {
            LongPressGR.minimumPressDuration = self.minimumPressDuration;// longPressGR最小长按时间,默认0.5
        }
        if (self.numberOfTouchesRequired) {
            LongPressGR.numberOfTouchesRequired = self.numberOfTouchesRequired;// 设置手指字数,默认1
        }
        if (self.allowableMovement) {
            LongPressGR.allowableMovement = self.allowableMovement;// 手势失败前允许的最大像素移动,默认10
        }
        if (self.longPressGR_SelImp.selector) {
            [LongPressGR addTarget:self.target action:self.longPressGR_SelImp.selector];
        }
        [self addGestureRecognizer:LongPressGR];
        [self setLongPressGR:LongPressGR];
    }return LongPressGR;
}

-(void)setLongPressGR:(UILongPressGestureRecognizer *)longPressGR{
    objc_setAssociatedObject(self,
                             UIView_Gesture_longPressGR,
                             longPressGR,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
static char *UIView_Gesture_tapGR = "UIView_Gesture_tapGR";
@dynamic tapGR;
#pragma mark —— @property(nonatomic,strong)UITapGestureRecognizer *tapGR;//点击手势
-(UITapGestureRecognizer *)tapGR{
    UITapGestureRecognizer *TapGR = objc_getAssociatedObject(self, UIView_Gesture_tapGR);
    if (!TapGR) {
        TapGR = UITapGestureRecognizer.new;
        NSLog(@"self.target = %@",self.target);
        TapGR.delegate = self.target;
        if (self.numberOfTapsRequired) {
            TapGR.numberOfTapsRequired = self.numberOfTapsRequired;// 设置轻拍次数,默认0
        }
        if (self.numberOfTouchesRequired) {
            TapGR.numberOfTouchesRequired = self.numberOfTouchesRequired;// 设置手指字数,默认1
        }
        if (self.tapGR_SelImp.selector) {
            [TapGR addTarget:self.target action:self.tapGR_SelImp.selector];
        }
        [self addGestureRecognizer:TapGR];
        [self setTapGR:TapGR];
    }return TapGR;
}

-(void)setTapGR:(UITapGestureRecognizer *)tapGR{
    objc_setAssociatedObject(self,
                             UIView_Gesture_tapGR,
                             tapGR,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
static char *UIView_Gesture_swipeGR = "UIView_Gesture_swipeGR";
@dynamic swipeGR;
#pragma mark —— @property(nonatomic,strong)UISwipeGestureRecognizer *swipeGR;//轻扫手势
-(UISwipeGestureRecognizer *)swipeGR{
    UISwipeGestureRecognizer *SwipeGR = objc_getAssociatedObject(self, UIView_Gesture_swipeGR);
    if (!SwipeGR) {
        SwipeGR = UISwipeGestureRecognizer.new;
        NSLog(@"self.target = %@",self.target);
        SwipeGR.delegate = self.target;
        SwipeGR.direction = self.swipeGRDirection;// 清扫方向。如果多组可以用|来进行,默认UISwipeGestureRecognizerDirectionRight
        SwipeGR.numberOfTouchesRequired = self.numberOfTouchesRequired;// 设置手指字数,默认1
        if (self.swipeGR_SelImp.selector) {
            [SwipeGR addTarget:self.target action:self.swipeGR_SelImp.selector];
        }
        [self addGestureRecognizer:SwipeGR];
        [self setSwipeGR:SwipeGR];
    }return SwipeGR;
}

-(void)setSwipeGR:(UISwipeGestureRecognizer *)swipeGR{
    objc_setAssociatedObject(self,
                             UIView_Gesture_swipeGR,
                             swipeGR,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
static char *UIView_Gesture_panGR = "UIView_Gesture_panGR";
@dynamic panGR;
#pragma mark —— @property(nonatomic,strong)UIPanGestureRecognizer *panGR;//平移手势
-(UIPanGestureRecognizer *)panGR{
    UIPanGestureRecognizer *PanGR = objc_getAssociatedObject(self, UIView_Gesture_panGR);
    if (!PanGR) {
        PanGR = UIPanGestureRecognizer.new;
        NSLog(@"self.target = %@",self.target);
        PanGR.delegate = self.target;
        if (@available(iOS 13.4, *)) {
            PanGR.allowedScrollTypesMask = self.allowedScrollTypesMask;
        }
        if (self.panGR_SelImp.selector) {
            [PanGR addTarget:self.target action:self.panGR_SelImp.selector];
        }
        [self addGestureRecognizer:PanGR];
        [self setPanGR:PanGR];
    }return PanGR;
}

-(void)setPanGR:(UIPanGestureRecognizer *)panGR{
    objc_setAssociatedObject(self,
                             UIView_Gesture_panGR,
                             panGR,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
static char *UIView_Gesture_pinchGR = "UIView_Gesture_pinchGR";
@dynamic pinchGR;
#pragma mark —— @property(nonatomic,strong)UIPinchGestureRecognizer *pinchGR;//捏合（缩放）手势
-(UIPinchGestureRecognizer *)pinchGR{
    UIPinchGestureRecognizer *PinchGR = objc_getAssociatedObject(self, UIView_Gesture_pinchGR);
    if (!PinchGR) {
        PinchGR = UIPinchGestureRecognizer.new;
        NSLog(@"self.target = %@",self.target);
        PinchGR.delegate = self.target;
        PinchGR.scale = self.scale;
        if (self.pinchGR_SelImp.selector) {
            [PinchGR addTarget:self.target action:self.pinchGR_SelImp.selector];
        }
        [self addGestureRecognizer:PinchGR];
        [self setPinchGR:PinchGR];
    }return PinchGR;
}

-(void)setPinchGR:(UIPinchGestureRecognizer *)pinchGR{
    objc_setAssociatedObject(self,
                             UIView_Gesture_pinchGR,
                             pinchGR,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
static char *UIView_Gesture_rotationGR = "UIView_Gesture_rotationGR";
@dynamic rotationGR;
#pragma mark —— @property(nonatomic,strong)UIRotationGestureRecognizer *rotationGR;//旋转手势
-(UIRotationGestureRecognizer *)rotationGR{
    UIRotationGestureRecognizer *RotationGR = objc_getAssociatedObject(self, UIView_Gesture_rotationGR);
    if (!RotationGR) {
        RotationGR = UIRotationGestureRecognizer.new;
        NSLog(@"self.target = %@",self.target);
        RotationGR.delegate = self.target;
        RotationGR.rotation = self.rotate;
        if (self.rotationGR_SelImp.selector) {
            [RotationGR addTarget:self.target action:self.rotationGR_SelImp.selector];
        }
        [self addGestureRecognizer:RotationGR];
        [self setRotationGR:RotationGR];
    }return RotationGR;
}

-(void)setRotationGR:(UIRotationGestureRecognizer *)rotationGR{
    objc_setAssociatedObject(self,
                             UIView_Gesture_rotationGR,
                             rotationGR,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
static char *UIView_Gesture_screenEdgePanGR = "UIView_Gesture_screenEdgePanGR";
@dynamic screenEdgePanGR;
#pragma mark —— @property(nonatomic,strong)UIScreenEdgePanGestureRecognizer *screenEdgePanGR;//屏幕边缘平移
-(UIScreenEdgePanGestureRecognizer *)screenEdgePanGR{
    UIScreenEdgePanGestureRecognizer *ScreenEdgePanGR = objc_getAssociatedObject(self, UIView_Gesture_screenEdgePanGR);
    if (!ScreenEdgePanGR) {
        ScreenEdgePanGR = UIScreenEdgePanGestureRecognizer.new;
        NSLog(@"self.target = %@",self.target);
        ScreenEdgePanGR.delegate = self.target;
        if (self.screenEdgePanGR_SelImp.selector) {
            [ScreenEdgePanGR addTarget:self.target action:self.screenEdgePanGR_SelImp.selector];
        }
        [self addGestureRecognizer:ScreenEdgePanGR];
        [self setScreenEdgePanGR:ScreenEdgePanGR];
    }return ScreenEdgePanGR;
}

-(void)setScreenEdgePanGR:(UIScreenEdgePanGestureRecognizer *)screenEdgePanGR{
    objc_setAssociatedObject(self,
                             UIView_Gesture_screenEdgePanGR,
                             screenEdgePanGR,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
static char *UIView_Gesture_longPressGRSelImp = "UIView_Gesture_longPressGRSelImp";
@dynamic longPressGR_SelImp;
#pragma mark —— @property(nonatomic,strong)JobsSEL_IMP *longPressGR_SelImp;
-(JobsSEL_IMP *)longPressGR_SelImp{
    JobsSEL_IMP *SEL_IMP = objc_getAssociatedObject(self, UIView_Gesture_longPressGRSelImp);
    if (!SEL_IMP) {
        SEL_IMP = JobsSEL_IMP.new;
        [self setLongPressGR_SelImp:SEL_IMP];
    }return SEL_IMP;
}

-(void)setLongPressGR_SelImp:(JobsSEL_IMP *)longPressGR_SelImp{
    objc_setAssociatedObject(self,
                             UIView_Gesture_longPressGRSelImp,
                             longPressGR_SelImp,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
static char *UIView_Gesture_tapGRSelImp = "UIView_Gesture_tapGRSelImp";
@dynamic tapGR_SelImp;
#pragma mark —— @property(nonatomic,strong)JobsSEL_IMP *tapGR_SelImp;
-(JobsSEL_IMP *)tapGR_SelImp{
    JobsSEL_IMP *SEL_IMP = objc_getAssociatedObject(self, UIView_Gesture_tapGRSelImp);
    if (!SEL_IMP) {
        SEL_IMP = JobsSEL_IMP.new;
        [self setTapGR_SelImp:SEL_IMP];
    }return SEL_IMP;
}

-(void)setTapGR_SelImp:(JobsSEL_IMP *)tapGR_SelImp{
    objc_setAssociatedObject(self,
                             UIView_Gesture_tapGRSelImp,
                             tapGR_SelImp,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
static char *UIView_Gesture_swipeGRSelImp = "UIView_Gesture_swipeGRSelImp";
@dynamic swipeGR_SelImp;
#pragma mark —— @property(nonatomic,strong)JobsSEL_IMP *swipeGR_SelImp;
-(JobsSEL_IMP *)swipeGR_SelImp{
    JobsSEL_IMP *SEL_IMP = objc_getAssociatedObject(self, UIView_Gesture_swipeGRSelImp);
    if (!SEL_IMP) {
        SEL_IMP = JobsSEL_IMP.new;
        [self setSwipeGR_SelImp:SEL_IMP];
    }return SEL_IMP;
}
-(void)setSwipeGR_SelImp:(JobsSEL_IMP *)swipeGR_SelImp{
    objc_setAssociatedObject(self,
                             UIView_Gesture_swipeGRSelImp,
                             swipeGR_SelImp,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
static char *UIView_Gesture_panGRSelImp = "UIView_Gesture_panGRSelImp";
@dynamic panGR_SelImp;
#pragma mark —— @property(nonatomic,strong)JobsSEL_IMP *panGR_SelImp;
-(JobsSEL_IMP *)panGR_SelImp{
    JobsSEL_IMP *SEL_IMP = objc_getAssociatedObject(self, UIView_Gesture_panGRSelImp);
    if (!SEL_IMP) {
        SEL_IMP = JobsSEL_IMP.new;
        [self setPanGR_SelImp:SEL_IMP];
    }return SEL_IMP;
}

-(void)setPanGR_SelImp:(JobsSEL_IMP *)panGR_SelImp{
    objc_setAssociatedObject(self,
                             UIView_Gesture_panGRSelImp,
                             panGR_SelImp,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
static char *UIView_Gesture_pinchGRSelImp = "UIView_Gesture_pinchGRSelImp";
@dynamic pinchGR_SelImp;
#pragma mark —— @property(nonatomic,strong)JobsSEL_IMP *pinchGR_SelImp;
-(JobsSEL_IMP *)pinchGR_SelImp{
    JobsSEL_IMP *SEL_IMP = objc_getAssociatedObject(self, UIView_Gesture_pinchGRSelImp);
    if (!SEL_IMP) {
        SEL_IMP = JobsSEL_IMP.new;
        [self setPinchGR_SelImp:SEL_IMP];
    }return SEL_IMP;
}

-(void)setPinchGR_SelImp:(JobsSEL_IMP *)pinchGR_SelImp{
    objc_setAssociatedObject(self,
                             UIView_Gesture_pinchGRSelImp,
                             pinchGR_SelImp,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
static char *UIView_Gesture_rotationGRSelImp = "UIView_Gesture_rotationGRSelImp";
@dynamic rotationGR_SelImp;
#pragma mark —— @property(nonatomic,strong)JobsSEL_IMP *rotationGR_SelImp;
-(JobsSEL_IMP *)rotationGR_SelImp{
    JobsSEL_IMP *SEL_IMP = objc_getAssociatedObject(self, UIView_Gesture_rotationGRSelImp);
    if (!SEL_IMP) {
        SEL_IMP = JobsSEL_IMP.new;
        [self setRotationGR_SelImp:SEL_IMP];
    }return SEL_IMP;
}

-(void)setRotationGR_SelImp:(JobsSEL_IMP *)rotationGR_SelImp{
    objc_setAssociatedObject(self,
                             UIView_Gesture_rotationGRSelImp,
                             rotationGR_SelImp,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
static char *UIView_Gesture_screenEdgePanGRSelImp = "UIView_Gesture_screenEdgePanGRSelImp";
@dynamic screenEdgePanGR_SelImp;
#pragma mark —— @property(nonatomic,strong)JobsSEL_IMP *screenEdgePanGR_SelImp;
-(JobsSEL_IMP *)screenEdgePanGR_SelImp{
    JobsSEL_IMP *SEL_IMP = objc_getAssociatedObject(self, UIView_Gesture_screenEdgePanGRSelImp);
    if (!SEL_IMP) {
        SEL_IMP = JobsSEL_IMP.new;
        [self setScreenEdgePanGR_SelImp:SEL_IMP];
    }return SEL_IMP;
}

-(void)setScreenEdgePanGR_SelImp:(JobsSEL_IMP *)screenEdgePanGR_SelImp{
    objc_setAssociatedObject(self,
                             UIView_Gesture_screenEdgePanGRSelImp,
                             screenEdgePanGR_SelImp,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

