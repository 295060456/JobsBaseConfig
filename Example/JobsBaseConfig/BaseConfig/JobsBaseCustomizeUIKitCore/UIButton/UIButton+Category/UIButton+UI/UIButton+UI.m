//
//  UIButton+UI.m
//  Casino
//
//  Created by Jobs on 2021/11/29.
//

#import "UIButton+UI.h"

@implementation UIButton (UI)
#pragma mark —— 一些功能性
-(void)btnClickEventBlock:(jobsByIDBlock)subscribeNextBlock{
    [[self rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIButton * _Nullable x) {
        if(subscribeNextBlock) subscribeNextBlock(x);
    }];
}
/// 方法名字符串（带参数、参数之间用"："隔开）、作用对象、参数
-(jobsByThreeIDBlock)btnClickActionWithParamarrays{
    // SEL method = @selector(func);//定义一个类方法的指针，selector查找是当前类（包含子类）的方法
    // SEL 用 assign修饰
    @jobs_weakify(self)
    return ^(NSString * _Nonnull methodName,
             id _Nonnull targetObj,
             NSArray * _Nullable paramarrays){
        @jobs_strongify(self)
        [[self rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIButton * _Nullable x) {
            [NSObject methodName:methodName
                       targetObj:targetObj
                     paramarrays:paramarrays];
        }];
    };
}
/// 方法名字符串（不带参数）、作用对象
-(jobsByTwoIDBlock)btnClickActionWithMethodName{
    return ^(NSString * _Nonnull methodName,
             id _Nonnull targetObj){
        SEL selector = NSSelectorFromString(methodName);
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [[self rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIButton * _Nullable x) {
            [targetObj performSelector:selector withObject:nil];
        }];
#pragma clang diagnostic pop
    };
}
/// 代码触发点击调用
-(void)actionByCode{
    [self sendActionsForControlEvents:UIControlEventTouchUpInside];
}
/// 这个方法还有待完善
-(void)handelAdjustsImageWhenHighlighted{
    if (HDDeviceSystemVersion.floatValue >= 15.0) {
#warning UIButtonConfiguration 怎么适配使用？
//            'adjustsImageWhenHighlighted' is deprecated: first deprecated in iOS 15.0 - This property is ignored when using UIButtonConfiguration, you may customize to replicate this behavior via a configurationUpdateHandler
    }
    SuppressWdeprecatedDeclarationsWarning(self.adjustsImageWhenHighlighted = NO;);
}
/// UIButton 上的 image 旋转一定的角度angle
-(void)changeAction:(CGFloat)angle{
    @jobs_weakify(self)
    [UIView animateWithDuration:.3f
                     animations:^{
        @jobs_strongify(self)
        self.imageView.transform = CGAffineTransformMakeRotation(M_PI * angle);/// 最后实际改变位置
    }];
}
/// 当Button不可用的时候，需要做些什么
-(jobsByBOOLBlock _Nonnull)enabledBlock{
    @jobs_weakify(self)
    return ^(BOOL enabled) {
        @jobs_strongify(self)
        self.enabled = enabled;
        self.endableNormalTitleColor = self.endableNormalTitleColor ? : self.normalTitleColor;
        self.normalTitleColor = self.enabled ? self.endableNormalTitleColor : HEXCOLOR(0xB0B0B0);
    };
}
#pragma mark —— Common
/// 代码触发点击调用
-(void)titleFont:(UIFont *)font{
    self.titleLabel.font = font;
}

-(void)titleAlignment:(NSTextAlignment)textAlignment{
    self.titleLabel.textAlignment = textAlignment;
}
/// 换行显示
-(void)makeNewLineShows:(BOOL)breakLine{
    self.titleLabel.numberOfLines = !breakLine;
}
#pragma mark —— Normal
// set
-(void)normalImage:(UIImage *)image{
    [self setImage:image forState:UIControlStateNormal];
}

-(void)normalBackgroundImage:(UIImage *)backgroundImage{
    [self setBackgroundImage:backgroundImage forState:UIControlStateNormal];
}

-(void)normalTitle:(NSString *)title{
    [self setTitle:title forState:UIControlStateNormal];
}

-(void)normalTitleColor:(UIColor *)titleColor{
    [self setTitleColor:titleColor forState:UIControlStateNormal];
}

-(void)normalAttributedTitle:(NSAttributedString *)title{
    [self setAttributedTitle:title forState:UIControlStateNormal];
}
// get
-(nullable NSString *)titleForNormalState{
    return [self titleForState:UIControlStateNormal];
}

-(nullable NSAttributedString *)attributedTitleForNormalState{
    return [self attributedTitleForState:UIControlStateNormal];
}

-(nullable UIColor *)titleColorForNormalState{
    return [self titleColorForState:UIControlStateNormal];
}

-(nullable UIImage *)imageForNormalState{
    return [self imageForState:UIControlStateNormal];
}

-(nullable UIImage *)backgroundImageForNormalState{
    return [self backgroundImageForState:UIControlStateNormal];
}
#pragma mark —— Selected
// set
-(void)selectedImage:(UIImage *)image{
    [self setImage:image forState:UIControlStateSelected];
}

-(void)selectedBackgroundImage:(UIImage *)backgroundImage{
    [self setBackgroundImage:backgroundImage forState:UIControlStateSelected];
}

-(void)selectedTitle:(NSString *)title{
    [self setTitle:title forState:UIControlStateSelected];
}

-(void)selectedTitleColor:(UIColor *)titleColor{
    [self setTitleColor:titleColor forState:UIControlStateSelected];
}

-(void)selectedAttributedTitle:(NSAttributedString *)title{
    [self setAttributedTitle:title forState:UIControlStateSelected];
}
// get
-(nullable NSString *)titleForSelectedState{
    return [self titleForState:UIControlStateSelected];
}

-(nullable NSAttributedString *)attributedTitleForSelectedState{
    return [self attributedTitleForState:UIControlStateSelected];
}

-(nullable UIColor *)titleColorForSelectedState{
    return [self titleColorForState:UIControlStateSelected];
}

-(nullable UIImage *)imageForSelectedState{
    return [self imageForState:UIControlStateSelected];
}

-(nullable UIImage *)backgroundImageForSelectedState{
    return [self backgroundImageForState:UIControlStateSelected];
}
#pragma mark —— SET | GET
static char *UIButton_UI_titleFont = "UIButton_UI_titleFont";
@dynamic titleFont;
//@property(nonatomic,strong)UIFont *titleFont;
-(UIFont *)titleFont{
    UIFont *TitleFont = objc_getAssociatedObject(self, UIButton_UI_titleFont);
    if (!TitleFont) {
        TitleFont = UIFontWeightBoldSize(JobsWidth(12));
        [self setTitleFont:TitleFont];
    }return TitleFont;
}

-(void)setTitleFont:(UIFont *)titleFont{
    self.titleLabel.font = titleFont;
    objc_setAssociatedObject(self,
                             UIButton_UI_titleFont,
                             titleFont,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
static char *UIButton_UI_normalImage = "UIButton_UI_normalImage";
@dynamic normalImage;
//@property(nonatomic,strong)UIImage *normalImage;
-(UIImage *)normalImage{
    UIImage *NormalImage = objc_getAssociatedObject(self, UIButton_UI_normalImage);
    return NormalImage;
}

-(void)setNormalImage:(UIImage *)normalImage{
    if (normalImage) {
        [self setImage:normalImage forState:UIControlStateNormal];
    }
    objc_setAssociatedObject(self,
                             UIButton_UI_normalImage,
                             normalImage,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
static char *UIButton_UI_normalBackgroundImage = "UIButton_UI_normalBackgroundImage";
@dynamic normalBackgroundImage;
//@property(nonatomic,strong)UIImage *normalBackgroundImage;
-(UIImage *)normalBackgroundImage{
    UIImage *NormalBackgroundImage = objc_getAssociatedObject(self, UIButton_UI_normalBackgroundImage);
    return NormalBackgroundImage;
}

-(void)setNormalBackgroundImage:(UIImage *)normalBackgroundImage{
    if (normalBackgroundImage) {
        [self setBackgroundImage:normalBackgroundImage forState:UIControlStateNormal];
    }
    objc_setAssociatedObject(self,
                             UIButton_UI_normalBackgroundImage,
                             normalBackgroundImage,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
static char *UIButton_UI_normalTitle = "UIButton_UI_normalTitle";
@dynamic normalTitle;
//@property(nonatomic,strong)NSString *normalTitle;
-(NSString *)normalTitle{
    NSString *NormalTitle = objc_getAssociatedObject(self, UIButton_UI_normalTitle);
    if (!NormalTitle) {
        NormalTitle = Internationalization(@"normalTitle");
        [self setNormalTitle:NormalTitle];
    }return NormalTitle;
}

-(void)setNormalTitle:(NSString *)normalTitle{
    [self setTitle:normalTitle forState:UIControlStateNormal];
    objc_setAssociatedObject(self,
                             UIButton_UI_normalTitle,
                             normalTitle,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
static char *UIButton_UI_normalTitleColor = "UIButton_UI_normalTitleColor";
@dynamic normalTitleColor;
//@property(nonatomic,strong)UIColor *normalTitleColor;
-(UIColor *)normalTitleColor{
    UIColor *NormalTitleColor = objc_getAssociatedObject(self, UIButton_UI_normalTitleColor);
    if (!NormalTitleColor) {
        NormalTitleColor = JobsBlackColor;
        [self setNormalTitleColor:NormalTitleColor];
    }return NormalTitleColor;
}

-(void)setNormalTitleColor:(UIColor *)normalTitleColor{
    [self setTitleColor:normalTitleColor forState:UIControlStateNormal];
    objc_setAssociatedObject(self,
                             UIButton_UI_normalTitleColor,
                             normalTitleColor,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
static char *UIButton_UI_normalAttributedTitle = "UIButton_UI_normalAttributedTitle";
@dynamic normalAttributedTitle;
//@property(nonatomic,strong)NSAttributedString *normalAttributedTitle;
-(NSAttributedString *)normalAttributedTitle{
    NSAttributedString *NormalAttributedTitle = objc_getAssociatedObject(self, UIButton_UI_normalAttributedTitle);
    return NormalAttributedTitle;
}

-(void)setNormalAttributedTitle:(NSAttributedString *)normalAttributedTitle{
    [self setAttributedTitle:normalAttributedTitle forState:UIControlStateNormal];
    objc_setAssociatedObject(self,
                             UIButton_UI_normalAttributedTitle,
                             normalAttributedTitle,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
static char *UIButton_UI_selectedImage = "UIButton_UI_selectedImage";
@dynamic selectedImage;
//@property(nonatomic,strong)UIImage *selectedImage;
-(UIImage *)selectedImage{
    UIImage *SelectedImage = objc_getAssociatedObject(self, UIButton_UI_selectedImage);
    return SelectedImage;
}

-(void)setSelectedImage:(UIImage *)selectedImage{
    [self setImage:selectedImage forState:UIControlStateSelected];
    objc_setAssociatedObject(self,
                             UIButton_UI_selectedImage,
                             selectedImage,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
static char *UIButton_UI_selectedBackgroundImage = "UIButton_UI_selectedBackgroundImage";
@dynamic selectedBackgroundImage;
//@property(nonatomic,strong)UIImage *selectedBackgroundImage;
-(UIImage *)selectedBackgroundImage{
    UIImage *SelectedBackgroundImage = objc_getAssociatedObject(self, UIButton_UI_selectedBackgroundImage);
    return SelectedBackgroundImage;
}

-(void)setSelectedBackgroundImage:(UIImage *)selectedBackgroundImage{
    [self setBackgroundImage:selectedBackgroundImage forState:UIControlStateSelected];
    objc_setAssociatedObject(self,
                             UIButton_UI_selectedBackgroundImage,
                             selectedBackgroundImage,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
static char *UIButton_UI_selectedTitle = "UIButton_UI_selectedTitle";
@dynamic selectedTitle;
//@property(nonatomic,strong)NSString *selectedTitle;
-(NSString *)selectedTitle{
    NSString *selectedTitle = objc_getAssociatedObject(self, UIButton_UI_selectedTitle);
    if (!selectedTitle) {
        selectedTitle = Internationalization(@"selectedTitle");
        [self setSelectedTitle:selectedTitle];
    }return selectedTitle;
}

-(void)setSelectedTitle:(NSString *)selectedTitle{
    [self setTitle:selectedTitle forState:UIControlStateSelected];
    objc_setAssociatedObject(self,
                             UIButton_UI_selectedTitle,
                             selectedTitle,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
static char *UIButton_UI_selectedTitleColor = "UIButton_UI_selectedTitleColor";
@dynamic selectedTitleColor;
//@property(nonatomic,strong)UIColor *selectedTitleColor;
-(UIColor *)selectedTitleColor{
    UIColor *SelectedTitleColor = objc_getAssociatedObject(self, UIButton_UI_selectedTitleColor);
    return SelectedTitleColor;
}

-(void)setSelectedTitleColor:(UIColor *)selectedTitleColor{
    [self setTitleColor:selectedTitleColor forState:UIControlStateSelected];
    objc_setAssociatedObject(self,
                             UIButton_UI_selectedTitleColor,
                             selectedTitleColor,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
static char *UIButton_UI_selectedAttributedTitle = "UIButton_UI_selectedAttributedTitle";
@dynamic selectedAttributedTitle;
//@property(nonatomic,strong)NSAttributedString *selectedAttributedTitle;
-(NSAttributedString *)selectedAttributedTitle{
    NSAttributedString *SelectedAttributedTitle = objc_getAssociatedObject(self, UIButton_UI_selectedAttributedTitle);
    return SelectedAttributedTitle;
}

-(void)setSelectedAttributedTitle:(NSAttributedString *)selectedAttributedTitle{
    [self setAttributedTitle:selectedAttributedTitle forState:UIControlStateSelected];
    objc_setAssociatedObject(self,
                             UIButton_UI_selectedAttributedTitle,
                             selectedAttributedTitle,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
static char *UIButton_UI_titleAlignment = "UIButton_UI_titleAlignment";
@dynamic titleAlignment;
//@property(nonatomic,assign)NSTextAlignment titleAlignment;
-(NSTextAlignment)titleAlignment{
    NSTextAlignment TitleAlignment = [objc_getAssociatedObject(self, UIButton_UI_titleAlignment) NSIntValue];
    return TitleAlignment;
}

-(void)setTitleAlignment:(NSTextAlignment)titleAlignment{
    self.titleLabel.textAlignment = titleAlignment;
    objc_setAssociatedObject(self,
                             UIButton_UI_titleAlignment,
                             [NSNumber numberWithInteger:titleAlignment],
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
static char *UIButton_UI_makeNewLineShows = "UIButton_UI_makeNewLineShows";
@dynamic makeNewLineShows;
//@property(nonatomic,assign)BOOL makeNewLineShows;
-(BOOL)makeNewLineShows{
    BOOL MakeNewLineShows = [objc_getAssociatedObject(self, UIButton_UI_makeNewLineShows) booLValue];
    return MakeNewLineShows;
}

-(void)setMakeNewLineShows:(BOOL)makeNewLineShows{
    self.titleLabel.numberOfLines = !makeNewLineShows;
    objc_setAssociatedObject(self,
                             UIButton_UI_makeNewLineShows,
                             [NSNumber numberWithBool:makeNewLineShows],
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
static char *UIButton_UI_endableNormalTitleColor = "UIButton_UI_endableNormalTitleColor";
@dynamic endableNormalTitleColor;
//@property(nonatomic,strong)UIColor *endableNormalTitleColor;
-(UIColor *)endableNormalTitleColor{
    return objc_getAssociatedObject(self, UIButton_UI_endableNormalTitleColor);
}

-(void)setEndableNormalTitleColor:(UIColor *)endableNormalTitleColor{
    objc_setAssociatedObject(self,
                             UIButton_UI_endableNormalTitleColor,
                             endableNormalTitleColor,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
