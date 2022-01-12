#import "ZYTextField.h"

@interface ZYTextField ()

@end

@implementation ZYTextField

-(instancetype)init{
    if (self = [super init]) {
        self.placeHolderAlignment = PlaceHolderAlignmentLeft;
    }return self;
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
}
#pragma mark —— 一些私有方法
-(void)setIsShowDelBtn:(BOOL)isShowDelBtn{
    _isShowDelBtn = isShowDelBtn;
    self.clearButtonMode = _isShowDelBtn ? UITextFieldViewModeWhileEditing : UITextFieldViewModeNever;
}

-(void)setUseCustomClearButton:(BOOL)useCustomClearButton{
    _useCustomClearButton = useCustomClearButton;
    if (_useCustomClearButton) {
        [self modifyClearButtonWithImage:KBuddleIMG(nil,@"ZYTextField",@"", @"CloseCircle（小号）.png")];
    }
}
/// iOS UIMenuController
-(BOOL)canPerformAction:(SEL)action
             withSender:(id)sender{
//    UIMenuController.sharedMenuController.menuVisible = self.isShowMenu;
    return self.isShowMenu;
}
/// 当前文本框聚焦时就会调用
-(BOOL)becomeFirstResponder{
    return [super becomeFirstResponder];
}
/// 当前文本框失去焦点时就会调用
-(BOOL)resignFirstResponder{
    return [super resignFirstResponder];
}
/// 必须在self有具体frame的时候才管用
-(void)setZYTextFieldMasksToBounds:(BOOL)ZYTextFieldMasksToBounds{
    _ZYTextFieldMasksToBounds = ZYTextFieldMasksToBounds;
    if (CGRectEqualToRect(self.bounds, CGRectZero)) {
        NSLog(@"self.frame 为空，绘制失败");
    }else{
        if (_ZYTextFieldMasksToBounds) {
            self.layer.cornerRadius = self.ZYTextFieldCornerRadius;
            self.layer.borderColor = self.ZYTextFieldBorderColor.CGColor;
            self.layer.borderWidth = self.ZYTextFieldBorderWidth;
            self.layer.masksToBounds = ZYTextFieldMasksToBounds;//必须写在最后，否则绘制无效
        }
    }
}
#pragma mark —— 重写父类方法
/// leftView——Rect
-(CGRect)leftViewRectForBounds:(CGRect)bounds{
    CGRect iconRect = [super leftViewRectForBounds:bounds];
    iconRect.origin.x += self.leftViewOffsetX;
    return iconRect;
}
/// rightView——Rect
- (CGRect)rightViewRectForBounds:(CGRect)bounds{
    CGRect iconRect = [super rightViewRectForBounds:bounds];
    iconRect.origin.x -= self.rightViewOffsetX;
    return iconRect;
}
/// Placeholder —— Rect
-(void)drawPlaceholderInRect:(CGRect)rect {
    // 计算占位文字的 Size
    CGSize placeholderSize = [self.placeholder sizeWithAttributes: @{NSFontAttributeName : self.placeholderFont}];
    [self.placeholder drawInRect:CGRectMake(0,
                                            (rect.size.height - placeholderSize.height) / 2,
                                            rect.size.width,
                                            rect.size.height)
                  withAttributes:@{NSForegroundColorAttributeName : self.placeholderColor,
                                   NSFontAttributeName : self.placeholderFont}];
}
/// placeholder——Rect
-(CGRect)placeholderRectForBounds:(CGRect)bounds{
    
    CGRect newbounds = bounds;
    CGSize size = [self.placeholder sizeWithAttributes:@{NSFontAttributeName:self.placeholderFont}];
    
    switch (self.placeHolderAlignment) {
        case PlaceHolderAlignmentLeft:{
            newbounds.origin.x += self.placeHolderOffset + self.leftViewOffsetX;
            return newbounds;
        }break;
        case PlaceHolderAlignmentCenter:{
            CGFloat width = bounds.size.width - size.width;
            newbounds.origin.x = width / 2 + self.placeHolderOffset + self.leftViewOffsetX;
            newbounds.size.width = size.width;
            return newbounds;
        }break;
        case PlaceHolderAlignmentRight:{
            CGFloat width = bounds.size.width - size.width;
            newbounds.origin.x = width - (self.placeHolderOffset + self.leftViewOffsetX);
            newbounds.size.width = size.width;
            return newbounds;
        }break;
        default:
            return CGRectZero;
            break;
    }
}
/// text——Rect 【未编辑状态下光标的起始位置】
-(CGRect)textRectForBounds:(CGRect)bounds{
    CGRect inset = CGRectMake((bounds.origin.x + self.offset) + (self.leftView.origin.x + self.leftView.size.width + self.leftViewOffsetX),
                              bounds.origin.y,
                              bounds.size.width - (self.offset + self.leftViewOffsetX + self.rightViewOffsetX),
                              bounds.size.height);
    return inset;
}
/// editing——Rect【编辑状态下的起始位置】
-(CGRect)editingRectForBounds:(CGRect)bounds{
    CGRect inset = CGRectMake((bounds.origin.x + self.offset) + (self.leftView.origin.x + self.leftView.size.width + self.leftViewOffsetX),
                              bounds.origin.y,
                              bounds.size.width - (self.offset + self.leftViewOffsetX + self.rightViewOffsetX),
                              bounds.size.height);
    return inset;
}
#pragma mark —— lazyLoad
-(CGFloat)offset{
    if (_offset == 0) {
        _offset = 0.1;
    }return _offset;
}

-(CGFloat)leftViewOffsetX{
    if (_leftViewOffsetX == 0) {
        _leftViewOffsetX = 0.1;
    }return _leftViewOffsetX;
}

-(CGFloat)rightViewOffsetX{
    if (_rightViewOffsetX == 0) {
        _rightViewOffsetX = 0.1;
    }return _rightViewOffsetX;
}

-(CGFloat)ZYTextFieldBorderWidth{
    if (_ZYTextFieldBorderWidth == 0) {
        _ZYTextFieldBorderWidth = 0.1;
    }return _ZYTextFieldBorderWidth;
}

-(UIColor *)ZYTextFieldBorderColor{
    if (!_ZYTextFieldBorderColor) {
        _ZYTextFieldBorderColor = kBlackColor;
    }return _ZYTextFieldBorderColor;
}

@end
