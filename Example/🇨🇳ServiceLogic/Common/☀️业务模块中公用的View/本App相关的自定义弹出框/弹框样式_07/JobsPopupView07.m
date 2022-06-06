//
//  JobsPopupView07.m
//  BaiShaEntertainmentProj
//
//  Created by Jobs on 2022/5/12.
//

#import "JobsPopupView07.h"

@interface JobsPopupView07 ()
/// UI
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)JobsDataShowBackView *dataShowBackView;
@property(nonatomic,strong)UILabel *subTitleLab;
@property(nonatomic,strong)UIButton *sureBtn;

@end

@implementation JobsPopupView07

@synthesize viewModel = _viewModel;

#pragma mark —— BaseProtocol
/// 单例化和销毁
+(void)destroySingleton{
    static_popupView07OnceToken = 0;
    static_popupView07 = nil;
}

static JobsPopupView07 *static_popupView07 = nil;
static dispatch_once_t static_popupView07OnceToken;
+(instancetype)sharedInstance{
    dispatch_once(&static_popupView07OnceToken, ^{
        static_popupView07 = JobsPopupView07.new;
    });return static_popupView07;
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
    
    self.titleLab.alpha = 1;
    self.dataShowBackView.alpha = 1;
    self.subTitleLab.alpha = 1;
    self.sureBtn.alpha = 1;

}
/// 具体由子类进行复写【数据尺寸】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
+(CGSize)viewSizeWithModel:(JobsUpDownLabModel *_Nullable)model{
    return CGSizeMake(JobsWidth(367), JobsWidth(380));
}
#pragma mark —— lazyLoad
-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = UILabel.new;
        _titleLab.text = Internationalization(@"流水詳情");
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.textColor = HEXCOLOR(0x3D4A58);
        _titleLab.font = [UIFont systemFontOfSize:JobsWidth(16) weight:UIFontWeightBold];
        [self addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(JobsWidth(24));
            make.left.equalTo(self).offset(JobsWidth(24));
        }];
        [_titleLab makeLabelByShowingType:UILabelShowingType_03];
    }return _titleLab;
}

-(JobsDataShowBackView *)dataShowBackView{
    if (!_dataShowBackView) {
        _dataShowBackView = JobsDataShowBackView.new;
        [_dataShowBackView richElementsInViewWithModel:nil];
        [self addSubview:_dataShowBackView];
        [_dataShowBackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo([JobsDataShowBackView viewSizeWithModel:nil]);
            make.centerX.equalTo(self);
            make.top.equalTo(self.titleLab.mas_bottom).offset(JobsWidth(16));
        }];
    }return _dataShowBackView;
}

-(UILabel *)subTitleLab{
    if (!_subTitleLab) {
        _subTitleLab = UILabel.new;
        _subTitleLab.text =
        Internationalization(@"1、完成流水後即可對中心錢包進行取款操作; \n2、每次充值獲得紅利,流水將單獨進行計算,不累計之前打出的額外流水;\n3、充值金額說明:計算最近一次申請取款到現在總累計充值金額;\n4、已獲紅利說明:計算最後一次申請取款到現在總累計獲得紅利金額");
        _subTitleLab.font = [UIFont systemFontOfSize:JobsWidth(12) weight:UIFontWeightRegular];
        _subTitleLab.textColor = HEXCOLOR(0x757575);
        [self addSubview:_subTitleLab];
        [_subTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self.dataShowBackView.mas_bottom).offset(JobsWidth(12));
            make.size.mas_equalTo(CGSizeMake(JobsWidth(303), JobsWidth(142)));
        }];
        [_subTitleLab makeLabelByShowingType:UILabelShowingType_05];
    }return _subTitleLab;
}

-(UIButton *)sureBtn{
    if (!_sureBtn) {
        _sureBtn = UIButton.new;
        [_sureBtn handelAdjustsImageWhenHighlighted];
        _sureBtn.normalBackgroundImage = KIMG(@"弹窗提交按钮");
        _sureBtn.selectedBackgroundImage = KIMG(@"弹窗提交按钮");
        _sureBtn.normalTitle = Internationalization(@"我知道了");
        _sureBtn.normalTitleColor = UIColor.blackColor;
        _sureBtn.titleFont = [UIFont systemFontOfSize:JobsWidth(18) weight:UIFontWeightRegular];
        [self addSubview:_sureBtn];
        [_sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_bottom).offset(JobsWidth(-26));
            make.centerX.equalTo(self);
            make.height.mas_equalTo(JobsWidth(40));
        }];
        BtnClickEvent(_sureBtn, {
            NSLog(@"确定");
            x.selected = !x.selected;
            [self tf_hide];
            [self.class destroySingleton];
            if(self.objectBlock) self.objectBlock(x);
        });
    }return _sureBtn;
}

@end
