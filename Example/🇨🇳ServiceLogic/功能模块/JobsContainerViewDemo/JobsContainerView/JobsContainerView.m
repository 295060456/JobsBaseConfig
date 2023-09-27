//
//  JobsContainerView.m
//  MataShop
//
//  Created by Jobs Hi on 9/21/23.
//

#import "JobsContainerView.h"

@interface JobsContainerView (){
    CGFloat btnWidth;
}

@property(nonatomic,strong)NSArray<JobsBtnModel *> *buttonModels;
@property(nonatomic,assign)CGFloat widthBySelf;

@end

@implementation JobsContainerView
#pragma mark —— 初始化方法
/// 禁止使用系统的alloc.init方法来进行创建对象
/// 强制用户使用-(instancetype)initWithValues:(id)firstValue, ... 来进行创建对象
-(instancetype)init{
    @throw [NSException exceptionWithName:NSGenericException
                                   reason:@"`-init` unavailable. Use `-initWithReachability:` instead"
                                 userInfo:nil];
    return nil;
}
/// 禁止使用系统的new方法来进行创建对象
/// 强制用户使用-(instancetype)initWithValues:(id)firstValue, ... 来进行创建对象
+ (instancetype)new NS_UNAVAILABLE {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:@"'new' is not a valid method for this class. Use a custom initialization method instead."
                                 userInfo:nil];
}

- (instancetype)initWithWidth:(CGFloat)widthBySelf
                 buttonModels:(NSArray<JobsBtnModel *> *)buttonModels{
    if (self = [super initWithFrame:CGRectZero]) {
        if([buttonModels isKindOfClass:NSArray.class]){
            self.widthBySelf = widthBySelf;
            [self createByModels:buttonModels];
        }
    }return self;
}
#pragma mark —— 一些私有方法
-(void)createByModels:(NSArray<JobsBtnModel *> *)buttonModels{
    self.buttonModels = buttonModels;

    CGFloat maxWidth = 0.f;
    CGFloat totalHeight = 0.f;
    
    CGFloat nbtnY = 0.0f;// 本次的Btn的头Y
    CGFloat btnBottom = 0.f;// 本次的Btn的底Y
    
    NSInteger index = 0;
    CGFloat buttonHeight = 0.0;

    for (JobsBtnModel *model in buttonModels) {

/**
 1、如果在数据源（JobsBtnModel *）里面设置了Btn的宽度
 这个view的宽度 = 所有的Btn的宽度最长的那一个值【Btn为基准】
 
 2、如果在数据源（JobsBtnModel *）里面没有设置Btn的宽度
    2.1、如果不提行
        这个view的宽度 = 单行文字 + 字体 得出的这段文字的宽
    2.2、如果文字提行
        这个view的宽度 = 这个view在初始化方法中的预设值
 
❤️优先级示意图：JobsBtnModel.btnWidth > 不提行时候的最大宽度 > 整个容器的宽widthBySelf ❤️
 */
        if(model.btnWidth){
            btnWidth = model.btnWidth;
            maxWidth = MAX(maxWidth, btnWidth);
        }else{
            if(model.lineBreakMode){// 不提行
                NSDictionary *attributes = @{NSFontAttributeName: model.font};
                btnWidth = [model.title sizeWithAttributes:attributes].width;
                maxWidth = MAX(maxWidth, btnWidth);
            }else{
                maxWidth = self.widthBySelf;
            }
        }
        
        UIButton *button = [self createButtonWithModel:model];
        [self addSubview:button];
        
        buttonHeight = CGRectGetHeight(button.frame);
        totalHeight += buttonHeight + model.contentSpacing;
        
        if(index){
            nbtnY += btnBottom + model.contentSpacing;
        }else{
            btnBottom = button.height;
        }
        button.y = nbtnY;
        index += 1;
    }
    // 设置容器视图的大小
    self.jobsSize = CGSizeMake(maxWidth, totalHeight);
}
/// 批量创建UIButton（使之兼容图文）
/// - Parameter model: 数据源
-(UIButton *)createButtonWithModel:(JobsBtnModel *)model{
    UIButton *button = nil;
    
    if(HDDeviceSystemVersion.floatValue <= 15.0){
        button = [UIButton buttonWithType:UIButtonTypeCustom];
        SuppressWdeprecatedDeclarationsWarning(button.contentEdgeInsets = model.contentEdgeInsets;);
        button.normalTitle = model.title;
        button.normalTitleColor = model.titleColor;
        button.normalImage = model.image;
        
    }else{
        /// 使用 UIButtonConfiguration
        UIButtonConfiguration *buttonConfig = UIButtonConfiguration.plainButtonConfiguration;
        buttonConfig.contentInsets = model.contentInsets;
        buttonConfig.image = model.image;
        buttonConfig.attributedTitle = [NSAttributedString.alloc initWithString:model.title
                                                                     attributes:@{NSForegroundColorAttributeName:model.titleColor}];
        button = [UIButton buttonWithConfiguration:buttonConfig primaryAction:nil];
    }

    button.width = self.widthBySelf;/// 预设值，否则撑不开
    button.backgroundColor = model.backgroundColor;
    button.titleFont = model.font;
    button.contentVerticalAlignment = model.contentVerticalAlignment;
    button.contentHorizontalAlignment = model.contentHorizontalAlignment;
    button.titleLabel.lineBreakMode = model.lineBreakMode;/// NSLineBreakByWordWrapping = 自动换行
    // 计算按钮文本所需的高度
    CGSize buttonSize = [button.titleLabel sizeThatFits:CGSizeMake(button.frame.size.width, CGFLOAT_MAX)];
    // 调整按钮的高度，确保文本不超出按钮的边界
    button.height = buttonSize.height;
    return button;
}
#pragma mark —— lazyLoad
-(CGFloat)widthBySelf{
    if(!_widthBySelf){
        _widthBySelf = JobsWidth(200);
    }return _widthBySelf;
}

@end
