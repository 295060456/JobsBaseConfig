//
//  UIButton+UI.m
//  Casino
//
//  Created by Jobs on 2021/11/29.
//

#import "UIButton+UI.h"

@implementation UIButton (UI)

static char *UIButton_UI_titleFont = "UIButton_UI_titleFont";
@dynamic titleFont;
//@property(nonatomic,strong)UIFont *titleFont;
-(UIFont *)titleFont{
    UIFont *TitleFont = objc_getAssociatedObject(self, UIButton_UI_titleFont);
    if (!TitleFont) {
        TitleFont = [UIFont systemFontOfSize:JobsWidth(12) weight:UIFontWeightBold];
        objc_setAssociatedObject(self,
                                 UIButton_UI_titleFont,
                                 TitleFont,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    self.titleLabel.font = TitleFont;
    return TitleFont;
}

-(void)setTitleFont:(UIFont *)titleFont{
    objc_setAssociatedObject(self,
                             UIButton_UI_titleFont,
                             titleFont,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.titleLabel.font = titleFont;
}
static char *UIButton_UI_normalImage = "UIButton_UI_normalImage";
@dynamic normalImage;
//@property(nonatomic,strong)UIImage *normalImage;
-(UIImage *)normalImage{
    UIImage *NormalImage = objc_getAssociatedObject(self, UIButton_UI_normalImage);
    if (NormalImage) {
        [self setImage:NormalImage forState:UIControlStateNormal];
    }return NormalImage;
}

-(void)setNormalImage:(UIImage *)normalImage{
    objc_setAssociatedObject(self,
                             UIButton_UI_normalImage,
                             normalImage,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (normalImage) {
        [self setImage:normalImage forState:UIControlStateNormal];
    }
}
static char *UIButton_UI_normalBackgroundImage = "UIButton_UI_normalBackgroundImage";
@dynamic normalBackgroundImage;
//@property(nonatomic,strong)UIImage *normalBackgroundImage;
-(UIImage *)normalBackgroundImage{
    UIImage *NormalBackgroundImage = objc_getAssociatedObject(self, UIButton_UI_normalBackgroundImage);
    if (NormalBackgroundImage) {
        [self setBackgroundImage:NormalBackgroundImage forState:UIControlStateNormal];
    }return NormalBackgroundImage;
}

-(void)setNormalBackgroundImage:(UIImage *)normalBackgroundImage{
    objc_setAssociatedObject(self,
                             UIButton_UI_normalBackgroundImage,
                             normalBackgroundImage,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (normalBackgroundImage) {
        [self setBackgroundImage:normalBackgroundImage forState:UIControlStateNormal];
    }
}
static char *UIButton_UI_normalTitle = "UIButton_UI_normalTitle";
@dynamic normalTitle;
//@property(nonatomic,strong)NSString *normalTitle;
-(NSString *)normalTitle{
    NSString *NormalTitle = objc_getAssociatedObject(self, UIButton_UI_normalTitle);
    if (!NormalTitle) {
        NormalTitle = Internationalization(@"normalTitle");
        objc_setAssociatedObject(self,
                                 UIButton_UI_normalTitle,
                                 NormalTitle,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    [self setTitle:NormalTitle forState:UIControlStateNormal];
    return NormalTitle;
}

-(void)setNormalTitle:(NSString *)normalTitle{
    objc_setAssociatedObject(self,
                             UIButton_UI_normalTitle,
                             normalTitle,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setTitle:normalTitle forState:UIControlStateNormal];
}
static char *UIButton_UI_normalTitleColor = "UIButton_UI_normalTitleColor";
@dynamic normalTitleColor;
//@property(nonatomic,strong)UIColor *normalTitleColor;
-(UIColor *)normalTitleColor{
    UIColor *NormalTitleColor = objc_getAssociatedObject(self, UIButton_UI_normalTitleColor);
    if (!NormalTitleColor) {
        NormalTitleColor = UIColor.blackColor;
        objc_setAssociatedObject(self,
                                 UIButton_UI_normalTitleColor,
                                 NormalTitleColor,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    [self setTitleColor:NormalTitleColor forState:UIControlStateNormal];
    return NormalTitleColor;
}

-(void)setNormalTitleColor:(UIColor *)normalTitleColor{
    objc_setAssociatedObject(self,
                             UIButton_UI_normalTitleColor,
                             normalTitleColor,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setTitleColor:normalTitleColor forState:UIControlStateNormal];
}
static char *UIButton_UI_normalAttributedTitle = "UIButton_UI_normalAttributedTitle";
@dynamic normalAttributedTitle;
//@property(nonatomic,strong)NSAttributedString *normalAttributedTitle;
-(NSAttributedString *)normalAttributedTitle{
    NSAttributedString *NormalAttributedTitle = objc_getAssociatedObject(self, UIButton_UI_normalAttributedTitle);
    [self setAttributedTitle:NormalAttributedTitle forState:UIControlStateNormal];
    return NormalAttributedTitle;
}

-(void)setNormalAttributedTitle:(NSAttributedString *)normalAttributedTitle{
    objc_setAssociatedObject(self,
                             UIButton_UI_normalAttributedTitle,
                             normalAttributedTitle,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setAttributedTitle:normalAttributedTitle forState:UIControlStateNormal];
}
static char *UIButton_UI_selectedImage = "UIButton_UI_selectedImage";
@dynamic selectedImage;
//@property(nonatomic,strong)UIImage *selectedImage;
-(UIImage *)selectedImage{
    UIImage *SelectedImage = objc_getAssociatedObject(self, UIButton_UI_selectedImage);
    [self setImage:SelectedImage forState:UIControlStateSelected];
    return SelectedImage;
}

-(void)setSelectedImage:(UIImage *)selectedImage{
    objc_setAssociatedObject(self,
                             UIButton_UI_selectedImage,
                             selectedImage,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setImage:selectedImage forState:UIControlStateSelected];
}
static char *UIButton_UI_selectedBackgroundImage = "UIButton_UI_selectedBackgroundImage";
@dynamic selectedBackgroundImage;
//@property(nonatomic,strong)UIImage *selectedBackgroundImage;
-(UIImage *)selectedBackgroundImage{
    UIImage *SelectedBackgroundImage = objc_getAssociatedObject(self, UIButton_UI_selectedBackgroundImage);
    [self setBackgroundImage:SelectedBackgroundImage forState:UIControlStateSelected];
    return SelectedBackgroundImage;
}

-(void)setSelectedBackgroundImage:(UIImage *)selectedBackgroundImage{
    objc_setAssociatedObject(self,
                             UIButton_UI_selectedBackgroundImage,
                             selectedBackgroundImage,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setBackgroundImage:selectedBackgroundImage forState:UIControlStateSelected];
}
static char *UIButton_UI_selectedTitle = "UIButton_UI_selectedTitle";
@dynamic selectedTitle;
//@property(nonatomic,strong)NSString *selectedTitle;
-(NSString *)selectedTitle{
    NSString *selectedTitle = objc_getAssociatedObject(self, UIButton_UI_selectedTitle);
    if (!selectedTitle) {
        selectedTitle = Internationalization(@"selectedTitle");
        objc_setAssociatedObject(self,
                                 UIButton_UI_selectedTitle,
                                 selectedTitle,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    [self setTitle:selectedTitle forState:UIControlStateSelected];
    return selectedTitle;
}

-(void)setSelectedTitle:(NSString *)selectedTitle{
    objc_setAssociatedObject(self,
                             UIButton_UI_selectedTitle,
                             selectedTitle,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setTitle:selectedTitle forState:UIControlStateSelected];
}
static char *UIButton_UI_selectedTitleColor = "UIButton_UI_selectedTitleColor";
@dynamic selectedTitleColor;
//@property(nonatomic,strong)UIColor *selectedTitleColor;
-(UIColor *)selectedTitleColor{
    UIColor *SelectedTitleColor = objc_getAssociatedObject(self, UIButton_UI_selectedTitleColor);
    [self setTitleColor:SelectedTitleColor forState:UIControlStateSelected];
    return SelectedTitleColor;
}

-(void)setSelectedTitleColor:(UIColor *)selectedTitleColor{
    objc_setAssociatedObject(self,
                             UIButton_UI_selectedTitleColor,
                             selectedTitleColor,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setTitleColor:selectedTitleColor forState:UIControlStateSelected];
}
static char *UIButton_UI_selectedAttributedTitle = "UIButton_UI_selectedAttributedTitle";
@dynamic selectedAttributedTitle;
//@property(nonatomic,strong)NSAttributedString *selectedAttributedTitle;
-(NSAttributedString *)selectedAttributedTitle{
    NSAttributedString *SelectedAttributedTitle = objc_getAssociatedObject(self, UIButton_UI_selectedAttributedTitle);
    [self setAttributedTitle:SelectedAttributedTitle forState:UIControlStateSelected];
    return SelectedAttributedTitle;
}

-(void)setSelectedAttributedTitle:(NSAttributedString *)selectedAttributedTitle{
    objc_setAssociatedObject(self,
                             UIButton_UI_selectedAttributedTitle,
                             selectedAttributedTitle,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setAttributedTitle:selectedAttributedTitle forState:UIControlStateSelected];
}
static char *UIButton_UI_titleAlignment = "UIButton_UI_titleAlignment";
@dynamic titleAlignment;
//@property(nonatomic,assign)NSTextAlignment titleAlignment;
-(NSTextAlignment)titleAlignment{
    NSTextAlignment TitleAlignment = [objc_getAssociatedObject(self, UIButton_UI_titleAlignment) NSIntValue];
    self.titleLabel.textAlignment = TitleAlignment;
    return TitleAlignment;
}

-(void)setTitleAlignment:(NSTextAlignment)titleAlignment{
    objc_setAssociatedObject(self,
                             UIButton_UI_titleAlignment,
                             [NSNumber numberWithInteger:titleAlignment],
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.titleLabel.textAlignment = titleAlignment;
}
static char *UIButton_UI_makeNewLineShows = "UIButton_UI_makeNewLineShows";
@dynamic makeNewLineShows;
//@property(nonatomic,assign)BOOL makeNewLineShows;
-(BOOL)makeNewLineShows{
    BOOL MakeNewLineShows = [objc_getAssociatedObject(self, UIButton_UI_makeNewLineShows) booLValue];
    self.titleLabel.numberOfLines = !MakeNewLineShows;
    return MakeNewLineShows;
}

-(void)setMakeNewLineShows:(BOOL)makeNewLineShows{
    objc_setAssociatedObject(self,
                             UIButton_UI_makeNewLineShows,
                             [NSNumber numberWithBool:makeNewLineShows],
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.titleLabel.numberOfLines = !makeNewLineShows;
}
#pragma mark —— Common
/// 代码触发点击调用
-(void)actionByCode{
    [self sendActionsForControlEvents:UIControlEventTouchUpInside];
}
/// 这个方法还有待完善
-(void)handelAdjustsImageWhenHighlighted{
    if (@available(iOS 15, *)) {
//            'adjustsImageWhenHighlighted' is deprecated: first deprecated in iOS 15.0 - This property is ignored when using UIButtonConfiguration, you may customize to replicate this behavior via a configurationUpdateHandler
    }else{
        SuppressWdeprecatedDeclarationsWarning(self.adjustsImageWhenHighlighted = NO;);
    }
}

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

@end
