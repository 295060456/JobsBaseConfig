//
//  JobsPopupView05.m
//  BaiShaEntertainmentProj
//
//  Created by Jobs on 2022/5/12.
//

#import "JobsPopupView05.h"

@interface JobsPopupView05 (){
    // UI
    JobsUpDownLab *popupViewTitleLab;
    UIButton *cancelBtn;
    UIButton *sureBtn;
    // Data
    JobsUpDownLabModel *upDownLabModel;
}

@end

@implementation JobsPopupView05

@synthesize viewModel = _viewModel;

#pragma mark —— BaseProtocol
/// 单例化和销毁
+(void)destroySingleton{
    static_popupView05OnceToken = 0;
    static_popupView05 = nil;
}

static JobsPopupView05 *static_popupView05 = nil;
static dispatch_once_t static_popupView05OnceToken;
+(instancetype)sharedInstance{
    dispatch_once(&static_popupView05OnceToken, ^{
        static_popupView05 = JobsPopupView05.new;
    });return static_popupView05;
}

-(instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = UIColor.clearColor;
        self.backgroundImageView.image = KIMG(@"弹框样式_03背景图");
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
    upDownLabModel.upLabText = [NSString isNullString:self.viewModel.textModel.text] ? Internationalization(@"轉帳請核對以下信息"): self.viewModel.textModel.text;
    upDownLabModel.downLabText = [NSString isNullString:self.viewModel.subTextModel.text] ? Internationalization(@"公司銀行卡不定期更換，每次充值請根據提\n交訂單生成的銀行卡轉賬，切勿直接轉賬至\n之前轉入的銀行卡，並且不要使用微信進行\n轉賬存款，否則無法到賬，概不負責！"): self.viewModel.textModel.text;
    upDownLabModel.upLabVerticalAlign = JobsUpDownLabAlign_TopLeft;
    upDownLabModel.upLabLevelAlign = JobsUpDownLabAlign_TopLeft;
    upDownLabModel.downLabVerticalAlign = JobsUpDownLabAlign_TopLeft;
    upDownLabModel.downLabLevelAlign = JobsUpDownLabAlign_TopLeft;
    
    popupViewTitleLab = self.valueForKeyBlock(@"popupViewTitleLab");
    [popupViewTitleLab richElementsInViewWithModel:upDownLabModel];
    
    cancelBtn = self.valueForKeyBlock(@"cancelBtn");
    [cancelBtn removeFromSuperview];
    sureBtn = self.valueForKeyBlock(@"sureBtn");
    [sureBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(JobsWidth(-26));
        make.centerX.equalTo(self);
        make.height.mas_equalTo(JobsWidth(40));
    }];
    sureBtn.normalTitle = Internationalization(@"确定");
    sureBtn.normalBackgroundImage = KIMG(@"弹窗按钮_我知道了");
    sureBtn.selectedBackgroundImage = KIMG(@"弹窗按钮_我知道了");
    sureBtn.normalTitleColor = UIColor.blackColor;
    sureBtn.titleFont = [UIFont systemFontOfSize:JobsWidth(18) weight:UIFontWeightRegular];
}
/// 具体由子类进行复写【数据尺寸】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
+(CGSize)viewSizeWithModel:(JobsUpDownLabModel *_Nullable)model{
    return CGSizeMake(JobsWidth(327), JobsWidth(266));
}
#pragma mark —— lazyLoad


@end
