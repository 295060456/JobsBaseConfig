//
//  JobsBaseConfigTestPopupView.m
//  JobsBaseConfig
//
//  Created by Jobs on 2022/5/12.
//

#import "JobsBaseConfigTestPopupView.h"

@interface JobsBaseConfigTestPopupView ()

@property(nonatomic,strong)JobsUpDownLab *testPopupViewTitleLab;
@property(nonatomic,strong)UIButton *testPopupViewSureBtn;

@end

@implementation JobsBaseConfigTestPopupView

@synthesize viewModel = _viewModel;

-(instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = UIColor.whiteColor;
        self.backgroundImageView.image = KIMG(@"测试弹窗的背景图");
    }return self;
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
}
#pragma mark —— BaseViewProtocol
/// 具体由子类进行复写【数据定UI】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
-(void)richElementsInViewWithModel:(JobsUpDownLabModel *_Nullable)model{
    self.viewModel = model;
    self.testPopupViewTitleLab.alpha = 1;
    self.testPopupViewSureBtn.alpha = 1;
}
/// 具体由子类进行复写【数据尺寸】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
+(CGSize)viewSizeWithModel:(JobsUpDownLabModel *_Nullable)model{
    return CGSizeMake(JobsWidth(327), JobsWidth(226));
}
#pragma mark —— lazyLoad
-(JobsUpDownLab *)testPopupViewTitleLab{
    if (!_testPopupViewTitleLab) {
        _testPopupViewTitleLab = JobsUpDownLab.new;
        [self addSubview:_testPopupViewTitleLab];
        [_testPopupViewTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(JobsWidth(24));
            make.centerX.equalTo(self);
        }];
        
        {
            JobsUpDownLabModel *model = JobsUpDownLabModel.new;
            model.upLabText = [NSString isNullString:self.viewModel.textModel.text] ? Internationalization(@"测试弹窗"): self.viewModel.textModel.text;
            model.upLabTextAlignment = NSTextAlignmentCenter;
            model.upLabFont = [UIFont systemFontOfSize:JobsWidth(20)
                                                weight:UIFontWeightBold];
            model.upLabTextCor = UIColor.blackColor;
            model.upLabBgCor = UIColor.clearColor;
            model.upLabTextAlignment = NSTextAlignmentCenter;
            
            model.downLabText = [NSString isNullString:self.viewModel.subTextModel.text] ? Internationalization(@"相关信息"): self.viewModel.textModel.text;
            model.downLabTextAlignment = NSTextAlignmentCenter;
            model.downLabFont = [UIFont systemFontOfSize:JobsWidth(16)
                                                  weight:UIFontWeightRegular];
            model.downLabTextCor = HEXCOLOR(0xB0B0B0);
            model.downLabBgCor = UIColor.clearColor;
            model.downLabTextAlignment = NSTextAlignmentCenter;
            
            model.space = JobsWidth(12);
            
            [_testPopupViewTitleLab richElementsInViewWithModel:model];
        }
    }return _testPopupViewTitleLab;
}

-(UIButton *)testPopupViewSureBtn{
    if (!_testPopupViewSureBtn) {
        _testPopupViewSureBtn = UIButton.new;
        [_testPopupViewSureBtn handelAdjustsImageWhenHighlighted];
        _testPopupViewSureBtn.normalBackgroundImage = KIMG(@"测试弹窗的确定按钮");
        _testPopupViewSureBtn.selectedBackgroundImage = KIMG(@"测试弹窗的确定按钮");
        _testPopupViewSureBtn.normalTitle = Internationalization(@"确定");
        _testPopupViewSureBtn.normalTitleColor = UIColor.blackColor;
        _testPopupViewSureBtn.titleFont = [UIFont systemFontOfSize:JobsWidth(18) weight:UIFontWeightRegular];
        [self addSubview:_testPopupViewSureBtn];
        [_testPopupViewSureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_bottom).offset(JobsWidth(-15));
            make.centerX.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(JobsWidth(190), JobsWidth(40)));
        }];
        BtnClickEvent(_testPopupViewSureBtn, {
            NSLog(@"确定");
            x.selected = !x.selected;
            [self tf_hide];
        });
    }return _testPopupViewSureBtn;
}


@end
