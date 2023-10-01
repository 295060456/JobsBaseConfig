#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import "NSObject+CurrentDevice.h"
#import "NSObject+RichText.h"
#import "UITextField+Extend.h"
#import "LoadingImage.h"
#import "MacroDef_Cor.h"
#import "TextFieldDefine.h"

@interface ZYTextField : UITextField
#pragma mark —— 自定义属性
@property(nonatomic,assign)CGFloat TFRiseHeight; /// 键盘在此手机上的最高弹起，区别于全面屏结合非全面屏，有一个安全区域34
@property(nonatomic,assign)CGFloat offset; /// 光标的起始距离距离控件最左边(不包括leftView)的差值
@property(nonatomic,assign)CGFloat leftViewOffsetX; /// leftView 距离控件最左边的差值
@property(nonatomic,assign)CGFloat rightViewOffsetX; /// TextField的删除按钮距离控件最右边的差值
@property(nonatomic,assign)CGFloat fieldEditorOffset; /// 因为设置了leftView后fieldEditor所需的偏移量
@property(nonatomic,assign)PlaceHolderAlignment placeHolderAlignment; /// PlaceHolder的位置（左/中/右）
@property(nonatomic,assign)CGFloat placeHolderOffset; /// 左/右/居中 对齐的时候的偏移量 传正值
@property(nonatomic,assign)CGFloat ZYTextFieldCornerRadius;
@property(nonatomic,assign)CGFloat ZYTextFieldBorderWidth;
@property(nonatomic,assign)UIColor *ZYTextFieldBorderColor;
@property(nonatomic,assign)BOOL ZYTextFieldMasksToBounds;
@property(nonatomic,assign)BOOL isShowDelBtn;/// 是否显示删除按钮，默认不显示
@property(nonatomic,assign)BOOL useCustomClearButton;/// 是否使用自定义的删除按钮 默认不使用
@property(nonatomic,assign)BOOL isShowMenu; /// 是否显示菜单 默认不显示
#pragma mark —— Sys 以下属性的优先级最高，分别对应了系统中的各自的方法名
@property(nonatomic,assign)CGRect clearButtonRectForBounds;/// 重置clearButton位置 😭
@property(nonatomic,assign)CGRect borderRectForBounds;/// 重置边缘区域  😭
@property(nonatomic,assign)CGRect drawPlaceholderInRect;/// Placeholder位置 【初始化的时候调用】🥶和placeholderRectForBounds有什么区别？
@property(nonatomic,assign)CGRect leftViewRectForBounds;/// leftView位置 【键盘弹起会调用此方法，但是键盘落下去不会调用】❤️
@property(nonatomic,assign)CGRect rightViewRectForBounds;/// rightView位置 【键盘弹起会调用此方法，但是键盘落下去不会调用】❤️
@property(nonatomic,assign)CGRect placeholderRectForBounds;/// Placeholder区域 【键盘弹起会调用此方法，但是键盘落下去不会调用】❤️ UITextFieldLabel的高度，即承载placeholder的控件的高度
@property(nonatomic,assign)CGRect textRectForBounds;/// 重置文字区域 【未编辑状态下光标的起始位置】【键盘弹起+落下会调用此方法】❤️❤️这个属性决定承载text的控件UITextLayoutFragmentView的父控件UITextLayoutCanvasView和UITouchPassthroughView的Fram。图层结构由上至下是：UITextLayoutFragmentView—>UITextLayoutCanvasView—>UITouchPassthroughView。其x和y都是0，文本超过这个size会以...的形式出现。textRectForBounds的高度过于小就会导致UITextLayoutFragmentView加载不到图层。一般这里的最后一个参数（高度，固定写死100，不要有任何比例尺）
@property(nonatomic,assign)CGRect editingRectForBounds;/// 重置编辑区域【编辑状态下的起始位置】、UIFieldEditor的位置大小【键盘弹起+落下会调用此方法】❤️❤️这个值，一般 == textRectForBounds。当超过输入距离的时候，新输入的字符会将之前的字符往左边顶

@end

/**
 过滤字符请结合RAC，是目前的最优解
 
 @jobs_weakify(self)
 [_textField jobsTextFieldEventFilterBlock:^BOOL(id data) {
//            @jobs_strongify(self)
     return YES;
 } subscribeNextBlock:^(NSString * _Nullable x) {
     @jobs_strongify(self)
     self.textField.text = x;
     [self textFieldBlock:self.textField
           textFieldValue:x];
 }];
*/

/**
 
 -(ZYTextField *)textField{
     if (!_textField) {
         _textField = ZYTextField.new;
         _textField.delegate = self;
         _textField.textColor = JobsBlackColor;
         _textField.backgroundColor = RGBA_COLOR(245, 245, 245, 1);
         _textField.returnKeyType = UIReturnKeyDefault;
         _textField.keyboardAppearance = UIKeyboardAppearanceDefault;
         _textField.keyboardType = UIKeyboardTypeDefault;
         _textField.rightView = self.titleLab;
         _textField.rightViewMode = UITextFieldViewModeAlways;
         _textField.placeholder = Internationalization(@"打赏的Mata值");
         _textField.placeholderColor = JobsCor(@"#333333");
         _textField.placeholderFont = UIFontWeightRegularSize(12);

         _textField.drawPlaceholderInRect = CGRectMake(0, 0, JobsWidth(255 - 20 - 40 - 5), JobsWidth(32));
         _textField.rightViewRectForBounds = CGRectMake(JobsWidth(255 - 20 - 40), JobsWidth(10), JobsWidth(40), JobsWidth(12));
         _textField.placeholderRectForBounds = CGRectMake(JobsWidth(10), JobsWidth(10), JobsWidth(255 - 20 - 40 - 5), JobsWidth(12));
         _textField.textRectForBounds = CGRectMake(JobsWidth(10), 0, JobsWidth(255 - 20 - 40 - 10), 100);
         _textField.editingRectForBounds = CGRectMake(JobsWidth(10), 0, JobsWidth(255 - 20 - 40 - 10), 100);

         @jobs_weakify(self)
         [_textField jobsTextFieldEventFilterBlock:^BOOL(id data) {
 //            @jobs_strongify(self)
             return YES;
         } subscribeNextBlock:^(NSString * _Nullable x) {
             @jobs_strongify(self)
             self.textField.text = x;
             [self textFieldBlock:self.textField
                   textFieldValue:x];
         }];
         [_textField cornerCutToCircleWithCornerRadius:JobsWidth(8)];
         [self addSubview:_textField];
         [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
             make.size.mas_equalTo(CGSizeMake(JobsWidth(255), JobsWidth(32)));
             make.centerX.equalTo(self);
             make.top.equalTo(self.titleView.mas_bottom).offset(JobsWidth(10));
         }];
     }return _textField;
 }
 
 */
