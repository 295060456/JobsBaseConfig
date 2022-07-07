//
//  JobsPopupView08.m
//  BaiShaEntertainmentProj
//
//  Created by Jobs on 2022/5/12.
//

#import "JobsPopupView08.h"

@interface JobsPopupView08 (){
    // UI
    JobsUpDownLab *popupViewTitleLab;
    UIButton *cancelBtn;
    UIButton *sureBtn;
    // Data
    JobsUpDownLabModel *upDownLabModel;
}

@end

@implementation JobsPopupView08

@synthesize viewModel = _viewModel;

#pragma mark —— BaseProtocol
/// 单例化和销毁
+(void)destroySingleton{
    static_popupView08OnceToken = 0;
    static_popupView08 = nil;
}

static JobsPopupView08 *static_popupView08 = nil;
static dispatch_once_t static_popupView08OnceToken;
+(instancetype)sharedInstance{
    dispatch_once(&static_popupView08OnceToken, ^{
        static_popupView08 = JobsPopupView08.new;
    });return static_popupView08;
}

-(instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = UIColor.clearColor;
        self.backgroundImageView.image = JobsIMG(@"弹框样式_03背景图");
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
    upDownLabModel.downLabText = [NSString isNullString:self.viewModel.subTextModel.text] ? Internationalization(@"當前實時匯率 1USDT=6.95RMB\n預計實際到賬 24USDT"): self.viewModel.textModel.text;
    upDownLabModel.upLabVerticalAlign = JobsUpDownLabAlign_TopLeft;
    upDownLabModel.upLabLevelAlign = JobsUpDownLabAlign_TopLeft;
    upDownLabModel.downLabVerticalAlign = JobsUpDownLabAlign_TopLeft;
    upDownLabModel.downLabLevelAlign = JobsUpDownLabAlign_TopLeft;
    
    popupViewTitleLab = self.valueForKeyBlock(@"popupViewTitleLab");
    
    [popupViewTitleLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(JobsWidth(24));
        make.left.equalTo(self).offset(JobsWidth(24));
        make.right.equalTo(self).offset(JobsWidth(-24));
    }];
    
    [popupViewTitleLab richElementsInViewWithModel:upDownLabModel];
    
    cancelBtn = self.valueForKeyBlock(@"cancelBtn");
    [cancelBtn removeFromSuperview];
    sureBtn = self.valueForKeyBlock(@"sureBtn");
    [sureBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(JobsWidth(-26));
        make.centerX.equalTo(self);
        make.height.mas_equalTo(JobsWidth(40));
    }];
    sureBtn.normalTitle = Internationalization(@"我知道了");
    sureBtn.normalBackgroundImage = JobsIMG(@"弹窗按钮_我知道了");
    sureBtn.selectedBackgroundImage = JobsIMG(@"弹窗按钮_我知道了");
    sureBtn.normalTitleColor = JobsBlackColor;
    sureBtn.titleFont = [UIFont systemFontOfSize:JobsWidth(18) weight:UIFontWeightRegular];
}
/// 具体由子类进行复写【数据尺寸】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
+(CGSize)viewSizeWithModel:(JobsUpDownLabModel *_Nullable)model{
    return CGSizeMake(JobsWidth(327), JobsWidth(186));
}
#pragma mark —— lazyLoad


@end
