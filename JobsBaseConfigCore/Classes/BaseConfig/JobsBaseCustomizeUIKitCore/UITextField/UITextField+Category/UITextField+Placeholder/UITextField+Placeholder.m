//
//  UITextField+Placeholder.m
//  Casino
//
//  Created by Jobs on 2021/12/20.
//

#import "UITextField+Placeholder.h"

@implementation UITextField (Placeholder)

static char *UITextField_Placeholder_placeholderColor = "UITextField_Placeholder_placeholderColor";
@dynamic placeholderColor;

static char *UITextField_Placeholder_placeholderFont = "UITextField_Placeholder_placeholderFont";
@dynamic placeholderFont;

static char *UITextField_Placeholder_defaultAttributedDataMutArr = "UITextField_Placeholder_defaultAttributedDataMutArr";
@dynamic defaultAttributedDataForPlaceHolderMutArr;
/**
    修改Placeholder亦可以通过富文本来完成
 */
-(NSAttributedString *)defaultAttributedPlaceholder{
    return [self richTextWithDataConfigMutArr:self.defaultAttributedDataForPlaceHolderMutArr];
}

-(UILabel *)placeholderLabel{
    //placeholder为nil或者为@"",placeholderLabel均为nil
    if (!self.placeholder.length || !self.placeholder) {
        self.placeholder = @" ";
    }
    Ivar ivar = class_getInstanceVariable(UITextField.class, "_placeholderLabel");
    UILabel *placeholderLabel = object_getIvar(self, ivar);
    placeholderLabel.numberOfLines = 0;/// 默认折行处理
    return placeholderLabel;
}
#pragma mark —— @property(nonatomic,strong)UIColor *placeholderColor;
-(UIColor *)placeholderColor{
    UIColor *PlaceholderColor = objc_getAssociatedObject(self, UITextField_Placeholder_placeholderColor);
    if (!PlaceholderColor) {
        PlaceholderColor = self.textColor;
        self.placeholderLabel.textColor = PlaceholderColor;
        objc_setAssociatedObject(self,
                                 UITextField_Placeholder_placeholderColor,
                                 PlaceholderColor,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return PlaceholderColor;
}

-(void)setPlaceholderColor:(UIColor *)placeholderColor{
    self.placeholderLabel.textColor = placeholderColor;
    objc_setAssociatedObject(self,
                             UITextField_Placeholder_placeholderColor,
                             placeholderColor,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,strong)UIFont *placeholderFont;
-(UIFont *)placeholderFont{
    UIFont *PlaceholderFont = objc_getAssociatedObject(self, UITextField_Placeholder_placeholderFont);
    if (!PlaceholderFont) {
        PlaceholderFont = self.font;
        self.placeholderLabel.font = PlaceholderFont;
        objc_setAssociatedObject(self,
                                 UITextField_Placeholder_placeholderFont,
                                 PlaceholderFont,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return PlaceholderFont;
}

-(void)setPlaceholderFont:(UIFont *)placeholderFont{
    self.placeholderLabel.font = placeholderFont;
    objc_setAssociatedObject(self,
                             UITextField_Placeholder_placeholderFont,
                             placeholderFont,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,strong)NSMutableArray <RichTextConfig *>*defaultAttributedDataMutArr;
-(NSMutableArray<RichTextConfig *> *)defaultAttributedDataForPlaceHolderMutArr{
    NSMutableArray *DefaultAttributedDataMutArr = objc_getAssociatedObject(self, UITextField_Placeholder_defaultAttributedDataMutArr);
    if (!DefaultAttributedDataMutArr) {
        DefaultAttributedDataMutArr = NSMutableArray.array;
        
        {
            RichTextConfig *richTextConfig = RichTextConfig.new;
            richTextConfig.targetString = self.placeholder;
            richTextConfig.font = [UIFont systemFontOfSize:JobsWidth(10) weight:UIFontWeightRegular];
            richTextConfig.cor = UIColor.blueColor;
    //        richTextConfig.underlineStyle;
    //        richTextConfig.paragraphStyle;
    //        richTextConfig.urlStr;
            richTextConfig.range =  NSMakeRange(0, self.placeholder.length);
            [DefaultAttributedDataMutArr addObject:richTextConfig];
        }
        
        objc_setAssociatedObject(self,
                                 UITextField_Placeholder_defaultAttributedDataMutArr,
                                 DefaultAttributedDataMutArr,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return DefaultAttributedDataMutArr;
}

-(void)setDefaultAttributedDataForPlaceHolderMutArr:(NSMutableArray<RichTextConfig *> *)defaultAttributedDataMutArr{
    objc_setAssociatedObject(self,
                             UITextField_Placeholder_defaultAttributedDataMutArr,
                             defaultAttributedDataMutArr,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
