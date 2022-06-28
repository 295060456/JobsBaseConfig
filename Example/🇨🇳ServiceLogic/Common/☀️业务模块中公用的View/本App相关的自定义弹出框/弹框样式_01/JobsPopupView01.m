//
//  JobsPopupView01.m
//  BaiShaEntertainmentProj
//
//  Created by Jobs on 2022/5/12.
//

#import "JobsPopupView01.h"

@interface JobsPopupView01()
// UI
@property(nonatomic,strong)JobsUpDownLab *popupViewTitleLab;
@property(nonatomic,strong)UIButton *cancelBtn;
@property(nonatomic,strong)UIButton *sureBtn;
// Data
@property(nonatomic,strong)JobsUpDownLabModel *upDownLabModel;

@end

@implementation JobsPopupView01

@synthesize viewModel = _viewModel;

#pragma mark —— BaseProtocol
/// 单例化和销毁
+(void)destroySingleton{
    static_popupView01OnceToken = 0;
    static_popupView01 = nil;
}

static JobsPopupView01 *static_popupView01 = nil;
static dispatch_once_t static_popupView01OnceToken;
+(instancetype)sharedInstance{
    dispatch_once(&static_popupView01OnceToken, ^{
        static_popupView01 = JobsPopupView01.new;
    });return static_popupView01;
}

-(instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = UIColor.clearColor;
        self.backgroundImageView.image = JobsIMG(@"弹框样式_01背景图");
        [self cornerCutToCircleWithCornerRadius:JobsWidth(8)];
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
    
    self.popupViewTitleLab.alpha = 1;
    self.cancelBtn.alpha = 1;
    self.sureBtn.alpha = 1;
}
/// 具体由子类进行复写【数据尺寸】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
+(CGSize)viewSizeWithModel:(JobsUpDownLabModel *_Nullable)model{
    return CGSizeMake(JobsWidth(367), JobsWidth(226));
}
#pragma mark —— lazyLoad
-(JobsUpDownLab *)popupViewTitleLab{
    if (!_popupViewTitleLab) {
        _popupViewTitleLab = JobsUpDownLab.new;
        [self addSubview:_popupViewTitleLab];
        [_popupViewTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(JobsWidth(24));
            make.left.equalTo(self).offset(JobsWidth(24));
        }];
        [_popupViewTitleLab richElementsInViewWithModel:self.upDownLabModel];
    }return _popupViewTitleLab;
}

-(UIButton *)cancelBtn{
    if (!_cancelBtn) {
        _cancelBtn = UIButton.new;
        [_cancelBtn handelAdjustsImageWhenHighlighted];
        _cancelBtn.normalBackgroundImage = JobsIMG(@"弹窗取消按钮");
        _cancelBtn.selectedBackgroundImage = JobsIMG(@"弹窗取消按钮");
        _cancelBtn.normalTitle = Internationalization(@"取消");
        _cancelBtn.normalTitleColor = HEXCOLOR(0xB0B0B0);
        _cancelBtn.titleFont = UIFontWeightRegularSize(18);
        [self addSubview:_cancelBtn];
        [_cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_bottom).offset(JobsWidth(-26));
            make.left.equalTo(self).offset(JobsWidth(24));
            make.size.mas_equalTo(CGSizeMake(JobsWidth(120), JobsWidth(40)));
        }];
        @jobs_weakify(self)
        [_cancelBtn btnClickEventBlock:^(UIButton *x) {
            @jobs_strongify(self)
            NSLog(@"确定");
            x.selected = !x.selected;
            [self tf_hide];
            [self.class destroySingleton];
            if(self.objectBlock) self.objectBlock(x);
        }];
    }return _cancelBtn;
}

-(UIButton *)sureBtn{
    if (!_sureBtn) {
        _sureBtn = UIButton.new;
        [_sureBtn handelAdjustsImageWhenHighlighted];
        _sureBtn.normalBackgroundImage = JobsIMG(@"弹窗提交按钮");
        _sureBtn.selectedBackgroundImage = JobsIMG(@"弹窗提交按钮");
        _sureBtn.normalTitle = Internationalization(@"继续开启");
        _sureBtn.normalTitleColor = JobsBlackColor;
        _sureBtn.titleFont = UIFontWeightRegularSize(18);;
        [self addSubview:_sureBtn];
        [_sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_bottom).offset(JobsWidth(-26));
            make.right.equalTo(self).offset(JobsWidth(-24));
            make.size.mas_equalTo(CGSizeMake(JobsWidth(120), JobsWidth(40)));
        }];
        @jobs_weakify(self)
        [_sureBtn btnClickEventBlock:^(UIButton *x) {
            @jobs_strongify(self)
            NSLog(@"确定");
            x.selected = !x.selected;
            [self tf_hide];
            [self.class destroySingleton];
            if (self.class == JobsPopupView01.class) {
                [self forceComingToPushVC:JobsSettingGestureVC.new requestParams:UIViewModel.new];
            }
            if(self.objectBlock) self.objectBlock(x);
        }];
    }return _sureBtn;
}

-(JobsUpDownLabModel *)upDownLabModel{
    if (!_upDownLabModel) {
        _upDownLabModel = JobsUpDownLabModel.new;
        _upDownLabModel.upLabText = [NSString isNullString:self.viewModel.textModel.text] ? Internationalization(@"提示"): self.viewModel.textModel.text;
        _upDownLabModel.upLabTextAlignment = NSTextAlignmentLeft;
        _upDownLabModel.upLabFont = UIFontWeightBoldSize(16);
        _upDownLabModel.upLabTextCor = JobsBlackColor;
        _upDownLabModel.upLabBgCor = JobsClearColor;
        
        _upDownLabModel.downLabText = [NSString isNullString:self.viewModel.subTextModel.text] ? Internationalization(@"開啟手勢密碼，系統將默認記住您的賬戶密碼\n進入免登陸狀態"): self.viewModel.textModel.text;
        _upDownLabModel.downLabTextAlignment = NSTextAlignmentLeft;
        _upDownLabModel.downLabFont = UIFontWeightRegularSize(14);
        _upDownLabModel.downLabTextCor = HEXCOLOR(0x757575);
        _upDownLabModel.downLabBgCor = JobsClearColor;
        _upDownLabModel.isDownLabMultiLineShows = YES;
        
        _upDownLabModel.upLabVerticalAlign = JobsUpDownLabAlign_TopLeft;
        _upDownLabModel.upLabLevelAlign = JobsUpDownLabAlign_TopLeft;
        _upDownLabModel.downLabVerticalAlign = JobsUpDownLabAlign_TopLeft;
        _upDownLabModel.downLabLevelAlign = JobsUpDownLabAlign_TopLeft;
        
        _upDownLabModel.space = JobsWidth(12);
    }return _upDownLabModel;
}

@end
