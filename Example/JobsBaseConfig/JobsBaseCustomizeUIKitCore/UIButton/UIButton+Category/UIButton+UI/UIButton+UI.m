//
//  UIButton+UI.m
//  Casino
//
//  Created by Jobs on 2021/11/29.
//

#import "UIButton+UI.h"

@implementation UIButton (UI)
#pragma mark —— 一些功能性
/// RAC 点击事件2次封装
-(RACDisposable *)jobsBtnClickEventBlock:(JobsReturnIDByIDBlock)subscribeNextBlock{
    return [[self rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIButton * _Nullable x) {
        if(subscribeNextBlock) subscribeNextBlock(x);
    }];
}
/// 方法名字符串（带参数、参数之间用"："隔开）、作用对象、参数
-(JobsReturnIDByThreeIDBlock)btnClickActionWithParamarrays{
    // SEL method = @selector(func);//定义一个类方法的指针，selector查找是当前类（包含子类）的方法
    // SEL 用 assign修饰
    @jobs_weakify(self)
    return ^(NSString * _Nonnull methodName,
             id _Nonnull targetObj,
             NSArray * _Nullable paramarrays){
        @jobs_strongify(self)
        return [[self rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIButton * _Nullable x) {
            [NSObject methodName:methodName
                       targetObj:targetObj
                     paramarrays:paramarrays];
        }];
    };
}
/// 方法名字符串（不带参数）、作用对象
-(JobsReturnIDByTwoIDBlock)btnClickActionWithMethodName{
    return ^(NSString * _Nonnull methodName,
             id _Nonnull targetObj){
        SuppressWarcPerformSelectorLeaksWarning(return [self jobsBtnClickEventBlock:^(id data) {
            return [targetObj performSelector:NSSelectorFromString(methodName) withObject:nil];
         }];);
    };
}
/// 代码触发点击调用
-(void)actionByCode{
    [self sendActionsForControlEvents:UIControlEventTouchUpInside];
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
        self.normalTitleColor = self.enabled ? self.normalTitleColor : HEXCOLOR(0xB0B0B0);
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
#pragma mark —— @property(nonatomic,strong)UIFont *titleFont;
JobsKey(_titleFont)
@dynamic titleFont;
-(UIFont *)titleFont{
    UIFont *TitleFont = Jobs_getAssociatedObject(_titleFont);
    if (!TitleFont) {
        TitleFont = UIFontWeightBoldSize(12);
        self.titleLabel.font = TitleFont;
        Jobs_setAssociatedRETAIN_NONATOMIC(_titleFont, TitleFont);
    }return TitleFont;
}

-(void)setTitleFont:(UIFont *)titleFont{
    self.titleLabel.font = titleFont;
    Jobs_setAssociatedRETAIN_NONATOMIC(_titleFont, titleFont);
}
#pragma mark —— @property(nonatomic,strong)UIImage *normalImage;
JobsKey(_normalImage)
@dynamic normalImage;
-(UIImage *)normalImage{
    return Jobs_getAssociatedObject(_normalImage);
}

-(void)setNormalImage:(UIImage *)normalImage{
    if (normalImage) [self setImage:normalImage forState:UIControlStateNormal];
    Jobs_setAssociatedRETAIN_NONATOMIC(_normalImage, normalImage)
}
#pragma mark —— @property(nonatomic,strong)UIImage *normalBackgroundImage;
JobsKey(_normalBackgroundImage)
@dynamic normalBackgroundImage;
-(UIImage *)normalBackgroundImage{
    return Jobs_getAssociatedObject(_normalBackgroundImage);
}

-(void)setNormalBackgroundImage:(UIImage *)normalBackgroundImage{
    if (normalBackgroundImage) [self setBackgroundImage:normalBackgroundImage forState:UIControlStateNormal];
    Jobs_setAssociatedRETAIN_NONATOMIC(_normalBackgroundImage, normalBackgroundImage)
}
#pragma mark —— @property(nonatomic,strong)NSString *normalTitle;
@dynamic normalTitle;
JobsKey(_normalTitle)
-(NSString *)normalTitle{
    return Jobs_getAssociatedObject(_normalTitle);
}

-(void)setNormalTitle:(NSString *)normalTitle{
    [self setTitle:normalTitle forState:UIControlStateNormal];
    Jobs_setAssociatedRETAIN_NONATOMIC(_normalTitle, normalTitle)
}
#pragma mark —— @property(nonatomic,strong)UIColor *normalTitleColor;
JobsKey(_normalTitleColor)
@dynamic normalTitleColor;
-(UIColor *)normalTitleColor{
    UIColor *NormalTitleColor = Jobs_getAssociatedObject(_normalTitleColor);
    if (!NormalTitleColor) {
        NormalTitleColor = JobsBlackColor;
        Jobs_setAssociatedRETAIN_NONATOMIC(_normalTitleColor, NormalTitleColor);
    }return NormalTitleColor;
}

-(void)setNormalTitleColor:(UIColor *)normalTitleColor{
    [self setTitleColor:normalTitleColor forState:UIControlStateNormal];
    Jobs_setAssociatedRETAIN_NONATOMIC(_normalTitleColor, normalTitleColor);
}
#pragma mark —— @property(nonatomic,strong)NSAttributedString *normalAttributedTitle;
JobsKey(_normalAttributedTitle)
@dynamic normalAttributedTitle;
-(NSAttributedString *)normalAttributedTitle{
    return Jobs_getAssociatedObject(_normalAttributedTitle);
}

-(void)setNormalAttributedTitle:(NSAttributedString *)normalAttributedTitle{
    [self setAttributedTitle:normalAttributedTitle forState:UIControlStateNormal];
    Jobs_setAssociatedRETAIN_NONATOMIC(_normalAttributedTitle, normalAttributedTitle)
}
#pragma mark —— @property(nonatomic,strong)UIImage *selectedImage;
JobsKey(_selectedImage)
@dynamic selectedImage;
-(UIImage *)selectedImage{
    return Jobs_getAssociatedObject(_selectedImage);
}

-(void)setSelectedImage:(UIImage *)selectedImage{
    [self setImage:selectedImage forState:UIControlStateSelected];
    Jobs_setAssociatedRETAIN_NONATOMIC(_selectedImage, selectedImage)
}
#pragma mark —— @property(nonatomic,strong)UIImage *selectedBackgroundImage;
JobsKey(_selectedBackgroundImage)
@dynamic selectedBackgroundImage;
-(UIImage *)selectedBackgroundImage{
    return Jobs_getAssociatedObject(_selectedBackgroundImage);
}

-(void)setSelectedBackgroundImage:(UIImage *)selectedBackgroundImage{
    [self setBackgroundImage:selectedBackgroundImage forState:UIControlStateSelected];
    Jobs_setAssociatedRETAIN_NONATOMIC(_selectedBackgroundImage, selectedBackgroundImage)
}
#pragma mark —— @property(nonatomic,strong)NSString *selectedTitle;
JobsKey(_selectedTitle)
@dynamic selectedTitle;
-(NSString *)selectedTitle{
    return Jobs_getAssociatedObject(_selectedTitle);
}

-(void)setSelectedTitle:(NSString *)selectedTitle{
    [self setTitle:selectedTitle forState:UIControlStateSelected];
    Jobs_setAssociatedRETAIN_NONATOMIC(_selectedTitle, selectedTitle)
}
#pragma mark —— @property(nonatomic,strong)UIColor *selectedTitleColor;
JobsKey(_selectedTitleColor)
@dynamic selectedTitleColor;
-(UIColor *)selectedTitleColor{
    return Jobs_getAssociatedObject(_selectedTitleColor);
}

-(void)setSelectedTitleColor:(UIColor *)selectedTitleColor{
    [self setTitleColor:selectedTitleColor forState:UIControlStateSelected];
    Jobs_setAssociatedRETAIN_NONATOMIC(_selectedTitleColor, selectedTitleColor)
}
#pragma mark —— @property(nonatomic,strong)NSAttributedString *selectedAttributedTitle;
JobsKey(_selectedAttributedTitle)
@dynamic selectedAttributedTitle;
-(NSAttributedString *)selectedAttributedTitle{
    return Jobs_getAssociatedObject(_selectedAttributedTitle);
}

-(void)setSelectedAttributedTitle:(NSAttributedString *)selectedAttributedTitle{
    [self setAttributedTitle:selectedAttributedTitle forState:UIControlStateSelected];
    Jobs_setAssociatedRETAIN_NONATOMIC(_selectedAttributedTitle, selectedAttributedTitle);
}
#pragma mark —— @property(nonatomic,assign)NSTextAlignment titleAlignment;
JobsKey(_titleAlignment)
@dynamic titleAlignment;
-(NSTextAlignment)titleAlignment{
    return [Jobs_getAssociatedObject(_titleAlignment) NSIntValue];;
}

-(void)setTitleAlignment:(NSTextAlignment)titleAlignment{
    self.titleLabel.textAlignment = titleAlignment;
    Jobs_setAssociatedRETAIN_NONATOMIC(_titleAlignment, @(titleAlignment))
}
#pragma mark —— <BaseProtocol> @property(nonatomic,strong)RACDisposable *racDisposable;
JobsKey(_racDisposable)
@dynamic racDisposable;
-(RACDisposable *)racDisposable{
    return Jobs_getAssociatedObject(_racDisposable);
}

-(void)setRacDisposable:(RACDisposable *)racDisposable{
    Jobs_setAssociatedRETAIN_NONATOMIC(_racDisposable, racDisposable)
}

@end
