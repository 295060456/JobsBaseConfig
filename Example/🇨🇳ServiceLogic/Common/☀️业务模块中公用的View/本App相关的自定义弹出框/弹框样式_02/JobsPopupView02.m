//
//  JobsPopupView02.m
//  BaiShaEntertainmentProj
//
//  Created by Jobs on 2022/5/12.
//

#import "JobsPopupView02.h"

@interface JobsPopupView02 (){
    // UI
    JobsUpDownLab *popupViewTitleLab;
    UIButton *cancelBtn;
    UIButton *sureBtn;
    // Data
    JobsUpDownLabModel *upDownLabModel;
}
// UI
@property(nonatomic,strong)UIButton *noTipsBtn;
// Data

@end

@implementation JobsPopupView02

@synthesize viewModel = _viewModel;

#pragma mark —— BaseProtocol
/// 单例化和销毁
+(void)destroySingleton{
    static_popupView02OnceToken = 0;
    static_popupView02 = nil;
}

static JobsPopupView02 *static_popupView02 = nil;
static dispatch_once_t static_popupView02OnceToken;
+(instancetype)sharedInstance{
    dispatch_once(&static_popupView02OnceToken, ^{
        static_popupView02 = JobsPopupView02.new;
    });return static_popupView02;
}

-(instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = UIColor.clearColor;
        self.backgroundImageView.image = KIMG(@"弹框样式_02背景图");
    }return self;
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
}
#pragma mark —— BaseViewProtocol
/// 具体由子类进行复写【数据定UI】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
-(void)richElementsInViewWithModel:(JobsUpDownLabModel *_Nullable)model{
    
    self.viewModel = model ? : UIViewModel.new;
    
    MakeDataNull
    
    upDownLabModel = self.valueForKeyBlock(@"upDownLabModel");
    upDownLabModel.upLabText = [NSString isNullString:self.viewModel.textModel.text] ? Internationalization(@"提示"): self.viewModel.textModel.text;
    upDownLabModel.downLabText = [NSString isNullString:self.viewModel.subTextModel.text] ? Internationalization(@"您的紅利總額4,000元,己發放到您的賬戶。領取\n該紅利後，需要再完成該紅利所需的有效投注才\n可領取"): self.viewModel.textModel.text;
    
    upDownLabModel.upLabVerticalAlign = JobsUpDownLabAlign_TopLeft;
    upDownLabModel.upLabLevelAlign = JobsUpDownLabAlign_TopLeft;
    upDownLabModel.downLabVerticalAlign = JobsUpDownLabAlign_TopLeft;
    upDownLabModel.downLabLevelAlign = JobsUpDownLabAlign_TopLeft;
    
    popupViewTitleLab = self.valueForKeyBlock(@"popupViewTitleLab");
    [popupViewTitleLab richElementsInViewWithModel:upDownLabModel];
    
    cancelBtn = self.valueForKeyBlock(@"cancelBtn");
    sureBtn = self.valueForKeyBlock(@"sureBtn");
    sureBtn.normalTitle = Internationalization(@"立即領取");
    self.noTipsBtn.alpha = 1;
}
/// 具体由子类进行复写【数据尺寸】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
+(CGSize)viewSizeWithModel:(JobsUpDownLabModel *_Nullable)model{
    return CGSizeMake(JobsWidth(347), JobsWidth(234));
}
#pragma mark —— lazyLoad
-(UIButton *)noTipsBtn{
    if (!_noTipsBtn) {
        _noTipsBtn = UIButton.new;
        [_noTipsBtn handelAdjustsImageWhenHighlighted];
        _noTipsBtn.normalImage = KIMG(@"按钮未选中");
        _noTipsBtn.selectedImage = KIMG(@"按钮已选中");
        _noTipsBtn.normalTitle = Internationalization(@"本次登入不再提示");
        _noTipsBtn.normalTitleColor = HEXCOLOR(0x757575);
        _noTipsBtn.titleFont = [UIFont systemFontOfSize:JobsWidth(12) weight:UIFontWeightRegular];
        [self addSubview:_noTipsBtn];
        [_noTipsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(cancelBtn.mas_top).offset(JobsWidth(-29));
            make.left.equalTo(cancelBtn);
            make.height.mas_equalTo(JobsWidth(14));
        }];
        [_noTipsBtn makeBtnLabelByShowingType:UILabelShowingType_03];
        [_noTipsBtn layoutButtonWithEdgeInsetsStyle:GLButtonEdgeInsetsStyleLeft
                                    imageTitleSpace:JobsWidth(5)];
        BtnClickEvent(_noTipsBtn, {
            NSLog(@"本次登入不再提示?");
            x.selected = !x.selected;
            if(self.objectBlock) self.objectBlock(x);
        });
    }return _noTipsBtn;
}

@end
