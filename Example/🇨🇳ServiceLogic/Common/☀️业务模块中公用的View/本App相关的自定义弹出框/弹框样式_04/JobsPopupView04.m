//
//  JobsPopupView04.m
//  BaiShaEntertainmentProj
//
//  Created by Jobs on 2022/5/12.
//

#import "JobsPopupView04.h"

@interface JobsPopupView04 (){
    CGSize titleLabSize;
    CGSize inputViewSize;
}
// UI
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UILabel *nameFromLab;
@property(nonatomic,strong)UILabel *nameToLab;
@property(nonatomic,strong)UIImageView *titleIMGV;
@property(nonatomic,strong)UILabel *subTitleLab;
@property(nonatomic,strong)JobsLeftRightLab *leftRightLab;
@property(nonatomic,strong)JobsAppDoorInputViewBaseStyle_10 *inputView;
@property(nonatomic,strong)UIButton *cancelBtn;
@property(nonatomic,strong)UIButton *sureBtn;
@property(nonatomic,strong)UIColor *cor;
// Data
@property(nonatomic,strong)JobsLeftRightLabModel *leftRightLabModel;
@property(nonatomic,strong)JobsAppDoorInputViewBaseStyleModel *配置金额输入框;

@end

@implementation JobsPopupView04
@synthesize viewModel = _viewModel;

#pragma mark —— BaseProtocol
/// 单例化和销毁
+(void)destroySingleton{
    static_popupView04OnceToken = 0;
    static_popupView04 = nil;
}

static JobsPopupView04 *static_popupView04 = nil;
static dispatch_once_t static_popupView04OnceToken;
+(instancetype)sharedInstance{
    dispatch_once(&static_popupView04OnceToken, ^{
        static_popupView04 = JobsPopupView04.new;
    });return static_popupView04;
}

-(instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = UIColor.clearColor;
        titleLabSize = CGSizeMake(JobsWidth(347), JobsWidth(47));
        inputViewSize = CGSizeMake(JobsWidth(323), JobsWidth(25));
        self.backgroundImageView.image = JobsIMG(@"弹框样式_01背景图");
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
    self.titleIMGV.alpha = 1;
    self.nameFromLab.alpha = 1;
    self.nameToLab.alpha = 1;
    self.subTitleLab.alpha = 1;
    self.leftRightLab.alpha = 1;
    self.inputView.alpha = 1;
    
    self.cancelBtn.alpha = 1;
    self.sureBtn.alpha = 1;
}
/// 具体由子类进行复写【数据尺寸】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
+(CGSize)viewSizeWithModel:(JobsUpDownLabModel *_Nullable)model{
    return CGSizeMake(JobsWidth(367), JobsWidth(240));
}
#pragma mark —— lazyLoad
-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = UILabel.new;
        _titleLab.backgroundColor = self.cor;
        [self addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(JobsWidth(12));
            make.centerX.equalTo(self);
            make.size.mas_equalTo(titleLabSize);
        }];
        [self layoutIfNeeded];
        [_titleLab appointCornerCutToCircleByRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight
                                                 cornerRadii:CGSizeMake(JobsWidth(8), JobsWidth(8))];
    }return _titleLab;
}

-(UIColor *)cor{
    if (!_cor) {
        _cor = [UIColor gradientCorDataMutArr:[NSMutableArray arrayWithArray:@[HEXCOLOR(0xE9C65D),HEXCOLOR(0xDDAA3A)]]
                                   startPoint:CGPointZero
                                     endPoint:CGPointZero
                                       opaque:NO
                               targetViewRect:CGRectMake(0, 0, titleLabSize.width, titleLabSize.height)];
    }return _cor;
}

-(UIImageView *)titleIMGV{
    if (!_titleIMGV) {
        _titleIMGV = UIImageView.new;
        _titleIMGV.image = JobsIMG(@"箭头");
        [self.titleLab addSubview:_titleIMGV];
        [_titleIMGV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(JobsWidth(24), JobsWidth(22.4)));
            make.centerX.equalTo(self);
            make.centerY.equalTo(self.titleLab);
        }];
    }return _titleIMGV;
}

-(UILabel *)nameFromLab{
    if (!_nameFromLab) {
        _nameFromLab = UILabel.new;
        _nameFromLab.text = Internationalization(@"中心钱包");
        _nameFromLab.textColor = HEXCOLOR(0x3D4A58);
        _nameFromLab.font = UIFontWeightMediumSize(16);
        [self.titleLab addSubview:_nameFromLab];
        [_nameFromLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.titleIMGV.mas_left).offset(JobsWidth(-36));
            make.centerY.equalTo(self.titleIMGV);
        }];
        [_nameFromLab makeLabelByShowingType:UILabelShowingType_03];
    }return _nameFromLab;
}

-(UILabel *)nameToLab{
    if (!_nameToLab) {
        _nameToLab = UILabel.new;
        _nameToLab.text = Internationalization(@"AG體育錢包");
        _nameToLab.textColor = HEXCOLOR(0x3D4A58);
        _nameToLab.font = UIFontWeightMediumSize(16);
        [self.titleLab addSubview:_nameToLab];
        [_nameToLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleIMGV.mas_right).offset(JobsWidth(36));
            make.centerY.equalTo(self.titleIMGV);
        }];
        [_nameToLab makeLabelByShowingType:UILabelShowingType_03];
    }return _nameToLab;
}

-(UILabel *)subTitleLab{
    if (!_subTitleLab) {
        _subTitleLab = UILabel.new;
        _subTitleLab.text = Internationalization(@"*場館內錢包不支持互轉");
        _subTitleLab.textColor = HEXCOLOR(0x757575);
        _subTitleLab.font = UIFontWeightMediumSize(12);
        [self addSubview:_subTitleLab];
        [_subTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(JobsWidth(24));
            make.top.equalTo(self.titleLab.mas_bottom).offset(JobsWidth(16));
        }];
        [_subTitleLab makeLabelByShowingType:UILabelShowingType_03];
    }return _subTitleLab;
}

-(JobsLeftRightLab *)leftRightLab{
    if (!_leftRightLab) {
        _leftRightLab = JobsLeftRightLab.new;
        [_leftRightLab richElementsInViewWithModel:self.leftRightLabModel];
        [self addSubview:_leftRightLab];
        [_leftRightLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.subTitleLab.mas_bottom).offset(JobsWidth(12));
            make.left.equalTo(self.subTitleLab);
            make.size.mas_equalTo(CGSizeMake(titleLabSize.width / 2, JobsWidth(14)));
        }];
    }return _leftRightLab;
}

-(JobsAppDoorInputViewBaseStyle_10 *)inputView{
    if (!_inputView) {
        _inputView = [JobsAppDoorInputViewBaseStyle_10.alloc initWithSize:inputViewSize];
        @jobs_weakify(self)
        [_inputView actionObjectBlock:^(id data) {
            @jobs_strongify(self)
            NSLog(@"%@",data);
            if ([data isKindOfClass:UITextField.class]) {
                UITextField *textField = (UITextField *)data;
            }else if ([data isKindOfClass:JobsAppDoorInputViewTFModel.class]){
                JobsAppDoorInputViewTFModel *inputViewTFModel = (JobsAppDoorInputViewTFModel *)data;
            }else{
                
            }
        }];
        
        [self addSubview:_inputView];
        [_inputView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(JobsWidth(24));
            make.size.mas_equalTo(inputViewSize);
            make.top.equalTo(self.leftRightLab.mas_bottom).offset(JobsWidth(12));
        }];
        [_inputView richElementsInViewWithModel:self.配置金额输入框];
    }return _inputView;
}

-(JobsAppDoorInputViewBaseStyleModel *)配置金额输入框{
    if (!_配置金额输入框) {
        _配置金额输入框 = JobsAppDoorInputViewBaseStyleModel.new;
//        _配置金额输入框.leftViewIMG = JobsIMG(@"安全");
        _配置金额输入框.placeHolderStr = Internationalization(@"請輸入金額");
        _配置金额输入框.placeholderFont = UIFontWeightRegularSize(14);
        _配置金额输入框.isShowDelBtn = YES;
        _配置金额输入框.isShowSecurityBtn = NO;
        _配置金额输入框.returnKeyType = UIReturnKeyDone;
        _配置金额输入框.keyboardAppearance = UIKeyboardAppearanceAlert;
        _配置金额输入框.leftViewMode = UITextFieldViewModeAlways;
        _配置金额输入框.titleStrCor = _配置金额输入框.placeholderColor = HEXCOLOR_ALPHA(0xC4C4C4,1.f);
//        _配置金额输入框.fieldEditorOffset = JobsWidth(80);
    }return _配置金额输入框;
}

-(UIButton *)cancelBtn{
    if (!_cancelBtn) {
        _cancelBtn = UIButton.new;
        [_cancelBtn handelAdjustsImageWhenHighlighted];
        _cancelBtn.normalBackgroundImage = JobsIMG(@"弹窗取消按钮");
        _cancelBtn.selectedBackgroundImage = JobsIMG(@"弹窗取消按钮");
        _cancelBtn.normalTitle = Internationalization(@"取消");
        _cancelBtn.normalTitleColor = HEXCOLOR(0xB0B0B0);
        _cancelBtn.titleFont = notoSansRegular(18);
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
            [self cancelBtnActionForPopView:x];
        }];
    }return _cancelBtn;
}

-(UIButton *)sureBtn{
    if (!_sureBtn) {
        _sureBtn = UIButton.new;
        [_sureBtn handelAdjustsImageWhenHighlighted];
        _sureBtn.normalBackgroundImage = JobsIMG(@"弹窗提交按钮");
        _sureBtn.selectedBackgroundImage = JobsIMG(@"弹窗提交按钮");
        _sureBtn.normalTitle = Internationalization(@"确定");
        _sureBtn.normalTitleColor = JobsBlackColor;
        _sureBtn.titleFont = UIFontWeightRegularSize(18);
        [self addSubview:_sureBtn];
        [_sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_bottom).offset(JobsWidth(-26));
            make.right.equalTo(self).offset(JobsWidth(-24));
            make.size.mas_equalTo(CGSizeMake(JobsWidth(120), JobsWidth(40)));
        }];
        @jobs_weakify(self)
        [_sureBtn btnClickEventBlock:^(UIButton *x) {
            @jobs_strongify(self)
            x.selected = !x.selected;
            [self cancelBtnActionForPopView:x];
        }];
    }return _sureBtn;
}

-(JobsLeftRightLabModel *)leftRightLabModel{
    if (!_leftRightLabModel) {
        _leftRightLabModel = JobsLeftRightLabModel.new;
        
        _leftRightLabModel.upLabText = Internationalization(@"中心钱包");
        _leftRightLabModel.upLabTextAlignment = NSTextAlignmentLeft;
        _leftRightLabModel.upLabFont = UIFontWeightRegularSize(14);
        _leftRightLabModel.upLabTextCor = HEXCOLOR(0x757575);
        _leftRightLabModel.upLabBgCor = UIColor.clearColor;

        _leftRightLabModel.downLabText = Internationalization(@"3000.00");
        _leftRightLabModel.downLabTextAlignment = NSTextAlignmentLeft;
        _leftRightLabModel.downLabFont = UIFontWeightMediumSize(14);
        _leftRightLabModel.downLabTextCor = HEXCOLOR(0xAE8330);
        _leftRightLabModel.downLabBgCor = UIColor.clearColor;
        
        _leftRightLabModel.upLabVerticalAlign = JobsUpDownLabAlign_TopLeft;
        _leftRightLabModel.upLabLevelAlign = JobsUpDownLabAlign_TopLeft;
        _leftRightLabModel.downLabVerticalAlign = JobsUpDownLabAlign_TopLeft;
        _leftRightLabModel.downLabLevelAlign = JobsUpDownLabAlign_TopLeft;
        SuppressWdeprecatedDeclarationsWarning(_leftRightLabModel.upLabContentEdgeInsets = UIEdgeInsetsMake(0, -JobsWidth(20), 0, 0););
        
        _leftRightLabModel.space = JobsWidth(12);
        _leftRightLabModel.rate = 0.7;
        
    }return _leftRightLabModel;
}

@end
