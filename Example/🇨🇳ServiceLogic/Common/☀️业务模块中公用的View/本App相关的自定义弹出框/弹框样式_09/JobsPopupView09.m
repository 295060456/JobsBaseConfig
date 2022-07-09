//
//  JobsPopupView09.m
//  BaiShaEntertainmentProj
//
//  Created by Jobs on 2022/5/12.
//

#import "JobsPopupView09.h"

@interface JobsPopupView09 (){
    // UI
    JobsUpDownLab *popupViewTitleLab;
    UIButton *cancelBtn;
    UIButton *sureBtn;
    // Data
    JobsUpDownLabModel *upDownLabModel;
}

@end

@implementation JobsPopupView09

@synthesize viewModel = _viewModel;

#pragma mark —— BaseProtocol
/// 单例化和销毁
+(void)destroySingleton{
    static_popupView09OnceToken = 0;
    static_popupView09 = nil;
}

static JobsPopupView09 *static_popupView09 = nil;
static dispatch_once_t static_popupView09OnceToken;
+(instancetype)sharedInstance{
    dispatch_once(&static_popupView09OnceToken, ^{
        static_popupView09 = JobsPopupView09.new;
    });return static_popupView09;
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
    upDownLabModel.upLabText = self.viewModel.textModel.text.nullString ? Internationalization(@"提示"): self.viewModel.textModel.text;
    upDownLabModel.downLabText = self.viewModel.subTextModel.text.nullString ? Internationalization(@"由於此平台的活動正在進行中，您若要轉入\n金額，還需完成1518.54元的流水，您確定要\n繼續轉入嗎？"): self.viewModel.textModel.text;
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
    sureBtn = self.valueForKeyBlock(@"sureBtn");
}
/// 具体由子类进行复写【数据尺寸】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
+(CGSize)viewSizeWithModel:(JobsUpDownLabModel *_Nullable)model{
    return CGSizeMake(JobsWidth(327), JobsWidth(206));
}
#pragma mark —— lazyLoad

@end
