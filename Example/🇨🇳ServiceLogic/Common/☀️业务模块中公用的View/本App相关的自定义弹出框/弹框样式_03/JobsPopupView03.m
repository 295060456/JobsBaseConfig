//
//  JobsPopupView03.m
//  BaiShaEntertainmentProj
//
//  Created by Jobs on 2022/5/12.
//

#import "JobsPopupView03.h"

@interface JobsPopupView03 (){
    // UI
    JobsUpDownLab *popupViewTitleLab;
    UIButton *cancelBtn;
    UIButton *sureBtn;
    // Data
    JobsUpDownLabModel *upDownLabModel;
}

@end

@implementation JobsPopupView03

@synthesize viewModel = _viewModel;

#pragma mark —— BaseProtocol
/// 单例化和销毁
+(void)destroySingleton{
    static_popupView03OnceToken = 0;
    static_popupView03 = nil;
}

static JobsPopupView03 *static_popupView03 = nil;
static dispatch_once_t static_popupView03OnceToken;
+(instancetype)sharedInstance{
    dispatch_once(&static_popupView03OnceToken, ^{
        static_popupView03 = JobsPopupView03.new;
    });return static_popupView03;
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
    upDownLabModel.upLabText = [NSString isNullString:self.viewModel.textModel.text] ? Internationalization(@"温馨提示"): self.viewModel.textModel.text;
    upDownLabModel.downLabText = [NSString isNullString:self.viewModel.subTextModel.text] ? Internationalization(@"會員可在VIP特權頁面進行申請，申請晉級\n優惠後開始計算活動有效流水。此優惠不與\n平台其它優惠共享，僅與返水優惠共享。\n有任何疑問請諮詢7x24小時在線客服。\n\n備註：達到流水額度或餘額低於5元\n時轉入任意金額即可解鎖場館"): self.viewModel.textModel.text;
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
    return CGSizeMake(JobsWidth(327), JobsWidth(266));
}
#pragma mark —— lazyLoad

@end
