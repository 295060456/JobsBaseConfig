//
//  JobsPopupView06.m
//  BaiShaEntertainmentProj
//
//  Created by Jobs on 2022/5/12.
//

#import "JobsPopupView06.h"

@interface JobsPopupView06 ()
/// UI
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UIButton *closeBtn;
@property(nonatomic,strong)JobsShowNumView *showNumView;
@property(nonatomic,strong)JobsUpDownLab *popupViewTitleLab;
@property(nonatomic,strong)UIButton *sureBtn;
/// Data
@property(nonatomic,strong)JobsUpDownLabModel *upDownLabModel;

@end

@implementation JobsPopupView06

@synthesize viewModel = _viewModel;

#pragma mark —— BaseProtocol
/// 单例化和销毁
+(void)destroySingleton{
    static_popupView06OnceToken = 0;
    static_popupView06 = nil;
}

static JobsPopupView06 *static_popupView06 = nil;
static dispatch_once_t static_popupView06OnceToken;
+(instancetype)sharedInstance{
    dispatch_once(&static_popupView06OnceToken, ^{
        static_popupView06 = JobsPopupView06.new;
    });return static_popupView06;
}

-(instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = UIColor.clearColor;
        self.backgroundImageView.image = KIMG(@"弹框样式_06背景图");
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

    self.titleLab.alpha = 1;
    self.titleLab.alpha = 1;
    self.showNumView.alpha = 1;
    self.popupViewTitleLab.alpha = 1;
    self.sureBtn.alpha = 1;
}
/// 具体由子类进行复写【数据尺寸】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
+(CGSize)viewSizeWithModel:(JobsUpDownLabModel *_Nullable)model{
    return CGSizeMake(JobsWidth(367), JobsWidth(316));
}
#pragma mark —— lazyLoad
-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = UILabel.new;
        _titleLab.text = Internationalization(@"代客充值暗號");
        _titleLab.font = [UIFont systemFontOfSize:JobsWidth(16) weight:UIFontWeightBold];
        _titleLab.textColor = UIColor.blackColor;
        [self addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(JobsWidth(24));
            make.centerX.equalTo(self);
        }];
        [_titleLab makeLabelByShowingType:UILabelShowingType_03];
    }return _titleLab;
}

-(UIButton *)closeBtn{
    if (!_closeBtn) {
        _closeBtn = UIButton.new;
        _closeBtn.normalImage = _closeBtn.selectedImage = KIMG(@"弹窗关闭按钮");
        [self addSubview:_closeBtn];
        [_closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(JobsWidth(12.19), JobsWidth(12.19)));
            make.top.equalTo(self).offset(JobsWidth(20.91));
            make.right.equalTo(self).offset(JobsWidth(20.91));
        }];
        BtnClickEvent(_closeBtn,
                      {
            [self tf_hide];
            [self.class destroySingleton];
            if (self.objectBlock) self.objectBlock(x.titleForNormalState);
        });
    }return _closeBtn;
}

-(JobsShowNumView *)showNumView{
    if (!_showNumView) {
        CGSize showNumViewSize = CGSizeMake(JobsWidth(327 - 14 * 2), JobsWidth(60));
        _showNumView = [JobsShowNumView.alloc initWithSize:showNumViewSize];
        [self addSubview:_showNumView];
        [_showNumView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.size.mas_equalTo(showNumViewSize);
            make.top.equalTo(self.titleLab.mas_bottom).offset(JobsWidth(24));
        }];
        [_showNumView richElementsInViewWithModel:nil];
    }return _showNumView;
}

-(JobsUpDownLab *)popupViewTitleLab{
    if (!_popupViewTitleLab) {
        _popupViewTitleLab = JobsUpDownLab.new;
        [self addSubview:_popupViewTitleLab];
        [_popupViewTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.showNumView.mas_bottom).offset(JobsWidth(24));
            make.left.equalTo(self).offset(JobsWidth(24));
        }];
        [_popupViewTitleLab richElementsInViewWithModel:self.upDownLabModel];
    }return _popupViewTitleLab;
}

-(UIButton *)sureBtn{
    if (!_sureBtn) {
        _sureBtn = UIButton.new;
        _sureBtn.normalTitle = Internationalization(@"我已記住暗號，繼續充值");
        _sureBtn.normalBackgroundImage = KIMG(@"弹窗按钮_我知道了");
        _sureBtn.selectedBackgroundImage = KIMG(@"弹窗按钮_我知道了");
        _sureBtn.normalTitleColor = UIColor.blackColor;
        _sureBtn.titleFont = [UIFont systemFontOfSize:JobsWidth(18) weight:UIFontWeightRegular];
        [self addSubview:_sureBtn];
        [_sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_bottom).offset(JobsWidth(-26));
            make.centerX.equalTo(self);
            make.height.mas_equalTo(JobsWidth(40));
        }];
        BtnClickEvent(_sureBtn, {
            [self tf_hide];
            [self.class destroySingleton];
        });
    }return _sureBtn;
}

-(JobsUpDownLabModel *)upDownLabModel{
    if (!_upDownLabModel) {
        _upDownLabModel = JobsUpDownLabModel.new;
        _upDownLabModel.upLabText = [NSString isNullString:self.viewModel.textModel.text] ? Internationalization(@"*溫馨提示"): self.viewModel.textModel.text;
        _upDownLabModel.upLabTextAlignment = NSTextAlignmentLeft;
        _upDownLabModel.upLabFont = [UIFont systemFontOfSize:JobsWidth(16)
                                                      weight:UIFontWeightBold];
        _upDownLabModel.upLabTextCor = UIColor.blackColor;
        _upDownLabModel.upLabBgCor = UIColor.clearColor;
        
        _upDownLabModel.downLabText = [NSString isNullString:self.viewModel.subTextModel.text] ? Internationalization(@"1.財務客服將主動詢問您所收到的暗號是否為xxxx\n2.如果客服沒有主動詢問您或發給您的暗號不相符，\n請勿進行交易，否則所引發的不到賬等情況，將概不負責"): self.viewModel.textModel.text;
        _upDownLabModel.downLabTextAlignment = NSTextAlignmentLeft;
        _upDownLabModel.downLabFont = [UIFont systemFontOfSize:JobsWidth(12)
                                                        weight:UIFontWeightRegular];
        _upDownLabModel.downLabTextCor = HEXCOLOR(0x757575);
        _upDownLabModel.downLabBgCor = UIColor.clearColor;
        _upDownLabModel.isDownLabMultiLineShows = YES;
        
        _upDownLabModel.upLabVerticalAlign = JobsUpDownLabAlign_TopLeft;
        _upDownLabModel.upLabLevelAlign = JobsUpDownLabAlign_TopLeft;
        _upDownLabModel.downLabVerticalAlign = JobsUpDownLabAlign_TopLeft;
        _upDownLabModel.downLabLevelAlign = JobsUpDownLabAlign_TopLeft;
        
        _upDownLabModel.space = JobsWidth(12);
    }return _upDownLabModel;
}


@end
