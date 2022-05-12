//
//  UIButton+UI.h
//  Casino
//
//  Created by Jobs on 2021/11/29.
//

#import <UIKit/UIKit.h>
#import "MacroDef_Strong@Weak.h"
/// For RAC
/// @jobs_weakify(self) 在内层定义
#define BtnClickEvent(button,action)\
@jobs_weakify(self)\
[[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIButton * _Nullable x) {\
    @jobs_strongify(self)\
    action\
}];\
/// @jobs_weakify(self) 在外层定义
#define btnClickEvent(button,action)\
[[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIButton * _Nullable x) {\
    @jobs_strongify(self)\
    action\
}];\
/// For UIKit
#define BtnAction(button,target,action)\
[button addTarget:target\
           action:action\
 forControlEvents:UIControlEventTouchUpInside];\

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (UI)
/// 为了迎合点语法而故意把下列方法属性化
/// Common
@property(nonatomic,strong)UIFont *titleFont;
@property(nonatomic,assign)NSTextAlignment titleAlignment;
@property(nonatomic,assign)BOOL makeNewLineShows;
/// Normal
@property(nonatomic,strong)UIImage *normalImage;
@property(nonatomic,strong)UIImage *normalBackgroundImage;
@property(nonatomic,strong)NSString *normalTitle;
@property(nonatomic,strong)UIColor *normalTitleColor;
@property(nonatomic,strong)NSAttributedString *normalAttributedTitle;
/// Selected
@property(nonatomic,strong)UIImage *selectedImage;
@property(nonatomic,strong)UIImage *selectedBackgroundImage;
@property(nonatomic,strong)NSString *selectedTitle;
@property(nonatomic,strong)UIColor *selectedTitleColor;
@property(nonatomic,strong)NSAttributedString *selectedAttributedTitle;

#pragma mark —— Common
-(void)actionByCode;/// 代码触发点击调用
-(void)handelAdjustsImageWhenHighlighted;
-(void)titleFont:(UIFont *)font;
-(void)titleAlignment:(NSTextAlignment)textAlignment;
-(void)makeNewLineShows:(BOOL)breakLine;/// 换行显示
#pragma mark —— Normal
// set
-(void)normalImage:(UIImage *)image;
-(void)normalBackgroundImage:(UIImage *)backgroundImage;
-(void)normalTitle:(NSString *)title;
-(void)normalTitleColor:(UIColor *)titleColor;
-(void)normalAttributedTitle:(NSAttributedString *)title;
// get
-(nullable NSString *)titleForNormalState;
-(nullable NSAttributedString *)attributedTitleForNormalState;
-(nullable UIColor *)titleColorForNormalState;
-(nullable UIImage *)imageForNormalState;
-(nullable UIImage *)backgroundImageForNormalState;
#pragma mark —— Selected
// set
-(void)selectedImage:(UIImage *)image;
-(void)selectedBackgroundImage:(UIImage *)backgroundImage;
-(void)selectedTitle:(NSString *)title;
-(void)selectedTitleColor:(UIColor *)titleColor;
-(void)selectedAttributedTitle:(NSAttributedString *)title;
// get
-(nullable NSString *)titleForSelectedState;
-(nullable NSAttributedString *)attributedTitleForSelectedState;
-(nullable UIColor *)titleColorForSelectedState;
-(nullable UIImage *)imageForSelectedState;
-(nullable UIImage *)backgroundImageForSelectedState;

@end

NS_ASSUME_NONNULL_END
