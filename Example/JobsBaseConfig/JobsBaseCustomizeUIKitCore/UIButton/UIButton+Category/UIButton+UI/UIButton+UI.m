//
//  UIButton+UI.m
//  Casino
//
//  Created by Jobs on 2021/11/29.
//

#import "UIButton+UI.h"

@implementation UIButton (UI)
#pragma mark —— 一些功能性
/// 为了兼容新的Api，批量设定UIButton
/// 资料来源：https://www.jianshu.com/p/12426709420e
/// - Parameters:
///   - btnConfiguration: 来自新Api的配置文件。UIButtonConfiguration.filledButtonConfiguration;
///   - background: 自定义按钮背景的配置
///   - titleAlignment: 针对文本的对齐方式 UIButtonConfiguration.titleAlignment 【新Api】
///   - textAlignment: 针对文本的对齐方式 UIButton.titleLabel.titleAlignment【老Api】
///   - normalImage: 正常情况下的image
///   - highlightImage: 高亮情况下的image
///   - attributedTitle: 主标题的富文本（优先级高于普通文本）
///   - selectedAttributedTitle: UIControlStateSelected状态下的标题富文本
///   - attributedSubtitle: 副标题的富文本（优先级高于普通文本）
///   - title: 主标题
///   - subTitle: 副标题（新Api才有的）
///   - titleFont: 主标题字体
///   - subTitleFont: 副标题字体
///   - titleCor: 主标题文字颜色
///   - subTitleCor: 副标题文字颜色
///   - titleLineBreakMode: 主标题换行模式
///   - subtitleLineBreakMode: 副标题换行模式
///   - baseBackgroundColor: 背景颜色
///   - imagePadding: 图像与标题之间的间距
///   - titlePadding: 标题和副标题标签之间的距离
///   - imagePlacement: ❤️图片和文字的位置关系❤️
///   - contentHorizontalAlignment: 针对内容的横向对齐方式
///   - contentVerticalAlignment: 针对内容的竖向对齐方式
///   - contentInsets: 定位内边距的方向
///   - cornerRadiusValue: 圆切角—作用于所有的角
///   - roundingCorners: 圆切角—作用于指定的方位
///   - roundingCornersRadii: 圆切角—指定方位的Size大小
///   - layerBorderCor: 描边的颜色
///   - borderWidth: 描边线的宽度
///   - primaryAction: 新Api的点击事件
///   - clickEventBlock: 老Api的点击事件，利用RAC实现
///   如果同时设置 clickEventBlock 和 primaryAction，会优先响应新的Api，再响应老的Api
-(instancetype)jobsInitBtnByConfiguration:(UIButtonConfiguration *_Nullable)btnConfiguration
                               background:(UIBackgroundConfiguration *_Nullable)background
                           titleAlignment:(UIButtonConfigurationTitleAlignment)titleAlignment/// 针对文本的对齐方式 UIButtonConfiguration.titleAlignment 【新Api】
                            textAlignment:(NSTextAlignment)textAlignment/// 针对文本的对齐方式 UIButton.titleLabel.titleAlignment【老Api】
                              normalImage:(UIImage *_Nullable)normalImage
                           highlightImage:(UIImage *_Nullable)highlightImage
                          attributedTitle:(NSAttributedString *_Nullable)attributedTitle
                  selectedAttributedTitle:(NSAttributedString *_Nullable)selectedAttributedTitle
                       attributedSubtitle:(NSAttributedString *_Nullable)attributedSubtitle
                                    title:(NSString *_Nullable)title
                                 subTitle:(NSString *_Nullable)subTitle
                                titleFont:(UIFont *_Nullable)titleFont
                             subTitleFont:(UIFont *_Nullable)subTitleFont
                                 titleCor:(UIColor *_Nullable)titleCor
                              subTitleCor:(UIColor *_Nullable)subTitleCor
                       titleLineBreakMode:(NSLineBreakMode)titleLineBreakMode/// 对应老Api中的：UIButton.lineBreakMode
                    subtitleLineBreakMode:(NSLineBreakMode)subtitleLineBreakMode
                      baseBackgroundColor:(UIColor *_Nullable)baseBackgroundColor
                             imagePadding:(CGFloat)imagePadding
                             titlePadding:(CGFloat)titlePadding
                           imagePlacement:(NSDirectionalRectEdge)imagePlacement
               contentHorizontalAlignment:(UIControlContentHorizontalAlignment)contentHorizontalAlignment /// 针对内容
                 contentVerticalAlignment:(UIControlContentVerticalAlignment)contentVerticalAlignment /// 针对内容
                            contentInsets:(NSDirectionalEdgeInsets)contentInsets/// 对应老Api中的：UIButton.contentEdgeInsets
                        cornerRadiusValue:(CGFloat)cornerRadiusValue
                          roundingCorners:(UIRectCorner)roundingCorners
                     roundingCornersRadii:(CGSize)roundingCornersRadii
                           layerBorderCor:(UIColor *_Nullable)layerBorderCor
                              borderWidth:(CGFloat)borderWidth
                            primaryAction:(UIAction *_Nullable)primaryAction
                          clickEventBlock:(JobsReturnIDByIDBlock _Nullable)clickEventBlock{
    if(!btnConfiguration) btnConfiguration = UIButtonConfiguration.filledButtonConfiguration;
    /// 图片
    {
        btnConfiguration.image = normalImage;
        btnConfiguration.imagePlacement = imagePlacement;
        btnConfiguration.imagePadding = imagePadding;/// 设置图像与标题之间的间距
    }
    /// 一般的文字
    {
        btnConfiguration.title = title;
        btnConfiguration.titlePadding = titlePadding;
        btnConfiguration.subtitle = subTitle;
        btnConfiguration.baseForegroundColor = titleCor;
        btnConfiguration.titleAlignment = titleAlignment;/// 文本的对齐方式
        btnConfiguration.titleLineBreakMode = titleLineBreakMode;/// 主标题的提行方式
        btnConfiguration.subtitleLineBreakMode = subtitleLineBreakMode;/// 副标题的提行方式
    }
    /// 富文本 优先级高于普通文本
    {
        /// 设置按钮标题的文本属性
        if (attributedTitle) {
            btnConfiguration.attributedTitle = attributedTitle;
        }else{
            if(titleFont && titleCor){
                btnConfiguration.titleTextAttributesTransformer = ^NSDictionary<NSAttributedStringKey, id> *(NSDictionary<NSAttributedStringKey, id> *textAttributes) {
                    NSMutableDictionary<NSAttributedStringKey, id> *newTextAttributes = textAttributes.mutableCopy;
                    [newTextAttributes addEntriesFromDictionary:@{
                        NSFontAttributeName:titleFont, /// 替换为你想要的字体和大小
                        NSForegroundColorAttributeName:titleCor /// 替换为你想要的文本颜色
                    }];return newTextAttributes;
                };
            }
            if(titleCor && title) btnConfiguration.attributedTitle = [NSAttributedString.alloc initWithString:title attributes:@{NSForegroundColorAttributeName:titleCor}];
        }
        /// 设置按钮副标题的文本属性
        if(attributedSubtitle){
            btnConfiguration.attributedSubtitle = attributedSubtitle;
        }else{
            if(subTitleFont && subTitleCor){
                btnConfiguration.subtitleTextAttributesTransformer = ^NSDictionary<NSAttributedStringKey, id> *(NSDictionary<NSAttributedStringKey, id> *textAttributes) {
                    NSMutableDictionary<NSAttributedStringKey, id> *newTextAttributes = textAttributes.mutableCopy;
                    [newTextAttributes addEntriesFromDictionary:@{
                        NSFontAttributeName: subTitleFont, // 替换为你想要的副标题字体和大小
                        NSForegroundColorAttributeName: subTitleCor // 替换为你想要的副标题文本颜色
                    }];return newTextAttributes;
                };
            }
            
            if(subTitleCor && subTitle) btnConfiguration.attributedSubtitle = [NSAttributedString.alloc initWithString:subTitle attributes:@{NSForegroundColorAttributeName:subTitleCor}];
        }
    }
    /// 其他
    {
        btnConfiguration.baseBackgroundColor = baseBackgroundColor;// 背景颜色
        btnConfiguration.contentInsets = contentInsets; // 内边距
    }
    UIButton *btn = nil;
    if(self.deviceSystemVersion.floatValue >= 15.0){
        btn = [UIButton buttonWithConfiguration:btnConfiguration
                                  primaryAction:primaryAction];
        
        NSLog(@"%@",btnConfiguration);
        NSLog(@"%@",btn.configuration);
        NSLog(@"");
    /**
     UIAction *action = [UIAction actionWithTitle:@"按钮点击操作"
                                            image:nil
                                       identifier:nil
                                          handler:^(__kindof UIAction * _Nonnull action) {
         NSLog(@"按钮被点击了！");
         // 在这里执行按钮点击时的操作
     }];
     */
    }else{
        btn = UIButton.new;
        /// 公共设置
        btn.normalImage = normalImage;
        btn.titleFont = titleFont;
        
        if(attributedTitle){
            btn.normalAttributedTitle = attributedTitle;
        }else{
            btn.normalTitle = title;
            btn.normalTitleColor = titleCor;
        }
        SuppressWdeprecatedDeclarationsWarning(btn.contentEdgeInsets = UIEdgeInsetsMake(contentInsets.top,
                                                                                        contentInsets.leading,
                                                                                        contentInsets.bottom,
                                                                                        contentInsets.trailing););
        if(selectedAttributedTitle) btn.selectedAttributedTitle = selectedAttributedTitle;
        
        /// 在按钮高亮状态变化时，使用 configurationUpdateHandler 来自定义图像样式
        btn.configurationUpdateHandler = ^(UIButton * _Nonnull updatedButton) {
            updatedButton.configuration.image = updatedButton.isHighlighted ? highlightImage : normalImage;
        };
        btn.titleLabel.textAlignment = textAlignment;
        
        [btn layoutButtonWithEdgeInsetsStyle:imagePlacement
                                imagePadding:imagePadding];
    }
    /// 公共设置
    {
        /// 描边
        [btn layerBorderCor:layerBorderCor andBorderWidth:borderWidth];
        
        if(roundingCorners == UIRectCornerAllCorners && jobsZeroSizeValue(roundingCornersRadii)){
            /// 圆切角（四个角全部按照统一的标准切）
            [btn cornerCutToCircleWithCornerRadius:cornerRadiusValue];
        }else{
            /// 圆切角（指定某个角按照统一的标准Size切）
            [btn appointCornerCutToCircleByRoundingCorners:roundingCorners cornerRadii:roundingCornersRadii];
        }
        /// 内容的对齐方式
        btn.contentVerticalAlignment = contentVerticalAlignment;
        btn.contentHorizontalAlignment = contentHorizontalAlignment;
        /// 点击事件
        [btn jobsBtnClickEventBlock:clickEventBlock];
    }return btn;
}
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
/**
 1、一一对应UIButtonConfiguration.h文件里面的属性
 2、只有通过UIButtonConfiguration创建的UIButton，这个UIbutton的configuration属性才不为空
 3、要修改通过UIButtonConfiguration创建的UIButton的各属性值，只有通过下列方式方可以
 */
#pragma mark —— UIButton.configuration的各项属性值的修改
-(void)setBtnConfigBackground:(UIBackgroundConfiguration *)background{
    UIButtonConfiguration *btnConfig = self.configuration;
    btnConfig.background = background;
    self.configuration = btnConfig;
}

-(void)setBtnConfigCornerStyle:(UIButtonConfigurationCornerStyle)cornerStyle{
    UIButtonConfiguration *btnConfig = self.configuration;
    btnConfig.cornerStyle = cornerStyle;
    self.configuration = btnConfig;
}

-(void)setBtnConfigButtonSize:(UIButtonConfigurationSize)buttonSize{
    UIButtonConfiguration *btnConfig = self.configuration;
    btnConfig.buttonSize = buttonSize;
    self.configuration = btnConfig;
}

-(void)setBtnConfigMacIdiomStyle:(UIButtonConfigurationMacIdiomStyle)macIdiomStyle{
    UIButtonConfiguration *btnConfig = self.configuration;
    btnConfig.macIdiomStyle = macIdiomStyle;
    self.configuration = btnConfig;
}

-(void)setBtnConfigBaseForegroundColor:(UIColor *)baseForegroundColor{
    UIButtonConfiguration *btnConfig = self.configuration;
    btnConfig.baseForegroundColor = baseForegroundColor;
    self.configuration = btnConfig;
}

-(void)setBtnConfigBaseBackgroundColor:(UIColor *)baseBackgroundColor{
    UIButtonConfiguration *btnConfig = self.configuration;
    btnConfig.baseBackgroundColor = baseBackgroundColor;
    self.configuration = btnConfig;
}

-(void)setBtnConfigImage:(UIImage *)image{
    UIButtonConfiguration *btnConfig = self.configuration;
    btnConfig.image = image;
    self.configuration = btnConfig;
}

-(void)setBtnConfigImageColorTransformer:(UIConfigurationColorTransformer)imageColorTransformer{
    UIButtonConfiguration *btnConfig = self.configuration;
    btnConfig.imageColorTransformer = imageColorTransformer;
    self.configuration = btnConfig;
}

-(void)setBtnConfigPreferredSymbolConfigurationForImage:(UIImageSymbolConfiguration *)preferredSymbolConfigurationForImage{
    UIButtonConfiguration *btnConfig = self.configuration;
    btnConfig.preferredSymbolConfigurationForImage = preferredSymbolConfigurationForImage;
    self.configuration = btnConfig;
}

-(void)setBtnConfigShowsActivityIndicator:(BOOL)showsActivityIndicator{
    UIButtonConfiguration *btnConfig = self.configuration;
    btnConfig.showsActivityIndicator = showsActivityIndicator;
    self.configuration = btnConfig;
}

-(void)setBtnConfigActivityIndicatorColorTransformer:(UIConfigurationColorTransformer)activityIndicatorColorTransformer{
    UIButtonConfiguration *btnConfig = self.configuration;
    btnConfig.activityIndicatorColorTransformer = activityIndicatorColorTransformer;
    self.configuration = btnConfig;
}

-(void)setBtnConfigTitle:(NSString *)title{
    UIButtonConfiguration *btnConfig = self.configuration;
    btnConfig.title = title;
    self.configuration = btnConfig;
}

-(void)setBtnConfigAttributedTitle:(NSAttributedString *)attributedTitle{
    UIButtonConfiguration *btnConfig = self.configuration;
    btnConfig.attributedTitle = attributedTitle;
    self.configuration = btnConfig;
}

-(void)setBtnConfigTitleTextAttributesTransformer:(UIConfigurationTextAttributesTransformer)titleTextAttributesTransformer{
    UIButtonConfiguration *btnConfig = self.configuration;
    btnConfig.titleTextAttributesTransformer = titleTextAttributesTransformer;
    self.configuration = btnConfig;
}

-(void)setBtnConfigTitleLineBreakMode:(NSLineBreakMode)titleLineBreakMode{
    UIButtonConfiguration *btnConfig = self.configuration;
    btnConfig.titleLineBreakMode = titleLineBreakMode;
    self.configuration = btnConfig;
}

-(void)setBtnConfigSubtitle:(NSString *)subtitle{
    UIButtonConfiguration *btnConfig = self.configuration;
    btnConfig.subtitle = subtitle;
    self.configuration = btnConfig;
}

-(void)setBtnConfigAttributedSubtitle:(NSAttributedString *)attributedSubtitle{
    UIButtonConfiguration *btnConfig = self.configuration;
    btnConfig.attributedSubtitle = attributedSubtitle;
    self.configuration = btnConfig;
}

-(void)setBtnConfigSubtitleTextAttributesTransformer:(UIConfigurationTextAttributesTransformer)subtitleTextAttributesTransformer{
    UIButtonConfiguration *btnConfig = self.configuration;
    btnConfig.subtitleTextAttributesTransformer = subtitleTextAttributesTransformer;
    self.configuration = btnConfig;
}

-(void)setBtnConfigSubtitleLineBreakMode:(NSLineBreakMode)subtitleLineBreakMode{
    UIButtonConfiguration *btnConfig = self.configuration;
    btnConfig.subtitleLineBreakMode = subtitleLineBreakMode;
    self.configuration = btnConfig;
}

-(void)setBtnConfigIndicator:(UIButtonConfigurationIndicator)indicator{
    UIButtonConfiguration *btnConfig = self.configuration;
    btnConfig.indicator = indicator;
    self.configuration = btnConfig;
}

-(void)setBtnConfigIndicatorColorTransformer:(UIConfigurationColorTransformer)indicatorColorTransformer{
    UIButtonConfiguration *btnConfig = self.configuration;
    btnConfig.indicatorColorTransformer = indicatorColorTransformer;
    self.configuration = btnConfig;
}

-(void)setBtnConfigContentInsets:(NSDirectionalEdgeInsets)contentInsets{
    UIButtonConfiguration *btnConfig = self.configuration;
    btnConfig.contentInsets = contentInsets;
    self.configuration = btnConfig;
}

-(void)setBtnConfigImagePlacement:(NSDirectionalRectEdge)imagePlacement{
    UIButtonConfiguration *btnConfig = self.configuration;
    btnConfig.imagePlacement = imagePlacement;
    self.configuration = btnConfig;
}

-(void)setBtnConfigImagePadding:(CGFloat)imagePadding{
    UIButtonConfiguration *btnConfig = self.configuration;
    btnConfig.imagePadding = imagePadding;
    self.configuration = btnConfig;
}

-(void)setBtnConfigTitlePadding:(CGFloat)titlePadding{
    UIButtonConfiguration *btnConfig = self.configuration;
    btnConfig.titlePadding = titlePadding;
    self.configuration = btnConfig;
}

-(void)setBtnConfigTitleAlignment:(UIButtonConfigurationTitleAlignment)titleAlignment{
    UIButtonConfiguration *btnConfig = self.configuration;
    btnConfig.titleAlignment = titleAlignment;
    self.configuration = btnConfig;
}

-(void)setBtnConfigAutomaticallyUpdateForSelection:(BOOL)automaticallyUpdateForSelection{
    UIButtonConfiguration *btnConfig = self.configuration;
    btnConfig.automaticallyUpdateForSelection = automaticallyUpdateForSelection;
    self.configuration = btnConfig;
}
#pragma mark —— UIButton普通文本的通用设置
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
#pragma mark —— UIButton.UIControlStateNormal.set
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
#pragma mark —— UIButton.UIControlStateNormal.get
-(nullable UIImage *)imageForNormalState{
    return [self imageForState:UIControlStateNormal];
}

-(nullable UIImage *)backgroundImageForNormalState{
    return [self backgroundImageForState:UIControlStateNormal];
}

-(nullable NSString *)titleForNormalState{
    return [self titleForState:UIControlStateNormal];
}

-(nullable UIColor *)titleColorForNormalState{
    return [self titleColorForState:UIControlStateNormal];
}

-(nullable NSAttributedString *)attributedTitleForNormalState{
    return [self attributedTitleForState:UIControlStateNormal];
}
#pragma mark —— UIButton.UIControlStateSelected.set
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
/// 富文本
-(void)selectedAttributedTitle:(NSAttributedString *)title{
    [self setAttributedTitle:title forState:UIControlStateSelected];
}
#pragma mark —— UIButton.UIControlStateSelected.get
-(nullable UIImage *)imageForSelectedState{
    return [self imageForState:UIControlStateSelected];
}

-(nullable UIImage *)backgroundImageForSelectedState{
    return [self backgroundImageForState:UIControlStateSelected];
}

-(nullable NSString *)titleForSelectedState{
    return [self titleForState:UIControlStateSelected];
}

-(nullable UIColor *)titleColorForSelectedState{
    return [self titleColorForState:UIControlStateSelected];
}

-(nullable NSAttributedString *)attributedTitleForSelectedState{
    return [self attributedTitleForState:UIControlStateSelected];
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
#pragma mark —— @property(nonatomic,strong)NSString *normalSubTitle
@dynamic normalSubTitle;
JobsKey(_normalSubTitle)
-(NSString *)normalSubTitle{
    return Jobs_getAssociatedObject(_normalSubTitle);
}

-(void)setNormalSubTitle:(NSString *)normalSubTitle{
    [self setTitle:normalSubTitle forState:UIControlStateNormal];
    Jobs_setAssociatedRETAIN_NONATOMIC(_normalSubTitle, normalSubTitle)
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
#pragma mark —— @property(nonatomic,strong)UIColor *normalSubTitleColor;
JobsKey(_normalSubTitleColor)
@dynamic normalSubTitleColor;
-(UIColor *)normalSubTitleColor{
    UIColor *NormalSubTitleColor = Jobs_getAssociatedObject(_normalSubTitleColor);
    if (!NormalSubTitleColor) {
        NormalSubTitleColor = JobsBlackColor;
        Jobs_setAssociatedRETAIN_NONATOMIC(_normalSubTitleColor, NormalSubTitleColor);
    }return NormalSubTitleColor;
}

-(void)setNormalSubTitleColor:(UIColor *)normalSubTitleColor{
    [self setTitleColor:normalSubTitleColor forState:UIControlStateNormal];
    Jobs_setAssociatedRETAIN_NONATOMIC(_normalSubTitleColor, normalSubTitleColor);
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
#pragma mark —— @property(nonatomic,strong)NSAttributedString *normalAttributedSubTitle;
JobsKey(_normalAttributedSubTitle)
@dynamic normalAttributedSubTitle;
-(NSAttributedString *)normalAttributedSubTitle{
    return Jobs_getAssociatedObject(_normalAttributedSubTitle);
}

-(void)setNormalAttributedSubTitle:(NSAttributedString *)normalAttributedSubTitle{
    [self setAttributedTitle:normalAttributedSubTitle forState:UIControlStateNormal];
    Jobs_setAssociatedRETAIN_NONATOMIC(_normalAttributedSubTitle, normalAttributedSubTitle)
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
#pragma mark —— @property(nonatomic,strong)NSString *selectedSubTitle;
JobsKey(_selectedSubTitle)
@dynamic selectedSubTitle;
-(NSString *)selectedSubTitle{
    return Jobs_getAssociatedObject(_selectedSubTitle);
}

-(void)setSelectedSubTitle:(NSString *)selectedSubTitle{
    [self setTitle:selectedSubTitle forState:UIControlStateSelected];
    Jobs_setAssociatedRETAIN_NONATOMIC(_selectedSubTitle, selectedSubTitle)
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
#pragma mark —— @property(nonatomic,strong)UIColor *selectedSubTitleColor;
JobsKey(_selectedSubTitleColor)
@dynamic selectedSubTitleColor;
-(UIColor *)selectedSubTitleColor{
    return Jobs_getAssociatedObject(_selectedSubTitleColor);
}

-(void)setSelectedSubTitleColor:(UIColor *)selectedSubTitleColor{
    [self setTitleColor:selectedSubTitleColor forState:UIControlStateSelected];
    Jobs_setAssociatedRETAIN_NONATOMIC(_selectedSubTitleColor, selectedSubTitleColor)
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
#pragma mark —— @property(nonatomic,strong)NSAttributedString *selectedAttributedSubTitle;
JobsKey(_selectedAttributedSubTitle)
@dynamic selectedAttributedSubTitle;
-(NSAttributedString *)selectedAttributedSubTitle{
    return Jobs_getAssociatedObject(_selectedAttributedSubTitle);
}

-(void)setSelectedAttributedSubTitle:(NSAttributedString *)selectedAttributedSubTitle{
    [self setAttributedTitle:selectedAttributedSubTitle forState:UIControlStateSelected];
    Jobs_setAssociatedRETAIN_NONATOMIC(_selectedAttributedSubTitle, selectedAttributedSubTitle);
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
