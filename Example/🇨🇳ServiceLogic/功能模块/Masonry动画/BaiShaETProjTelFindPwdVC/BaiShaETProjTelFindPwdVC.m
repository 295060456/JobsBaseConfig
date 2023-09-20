//
//  BaiShaETProjTelFindPwdVC.m
//  BaiShaEntertainmentProj
//
//  Created by Jobs on 2022/7/7.
//

#import "BaiShaETProjTelFindPwdVC.h"

@interface BaiShaETProjTelFindPwdVC ()
/// UI
@property(nonatomic,strong)JobsLeftRightLab *titleLab;
@property(nonatomic,strong)JobsAppDoorInputViewBaseStyle_8 *inputUserNameView;
@property(nonatomic,strong)JobsAppDoorInputViewBaseStyle_7 *inputTelPhView;
@property(nonatomic,strong)JobsAppDoorInputViewBaseStyle_9 *inputVerificationCodeView;
@property(nonatomic,strong)JobsAppDoorInputViewBaseStyle_3 *inputPwdView;
@property(nonatomic,strong)JobsAppDoorInputViewBaseStyle_3 *inputPwdConfirmView;
@property(nonatomic,strong)UILabel *errTipsLab;
@property(nonatomic,strong)UIButton *nextBtn;
@property(nonatomic,strong)UILabel *tipsLab;
/// Data
@property(nonatomic,strong)JobsLeftRightLabModel *leftRightLabModel;
@property(nonatomic,strong)JobsAppDoorInputViewBaseStyleModel *inputUserNameViewDataModel;
@property(nonatomic,strong)JobsAppDoorInputViewBaseStyleModel *inputTelPhViewDataModel;
@property(nonatomic,strong)JobsAppDoorInputViewBaseStyleModel *inputVerificationCodeViewDataModel;
@property(nonatomic,strong)JobsAppDoorInputViewBaseStyleModel *inputPwdViewDataModel;
@property(nonatomic,strong)JobsAppDoorInputViewBaseStyleModel *inputPwdConfirmViewDataModel;
@property(nonatomic,assign)CGSize inputViewSize;
@property(nonatomic,assign)CGSize nextBtnSize;
@property(nonatomic,strong)UIColor *nextBtnCor;
@property(nonatomic,weak)MASConstraint *constraint;
@property(nonatomic,assign)int step;

@end

@implementation BaiShaETProjTelFindPwdVC

- (void)dealloc{
    [NSNotificationCenter.defaultCenter removeObserver:self];
    NSLog(@"%@",JobsLocalFunc);
}

-(void)loadView{
    [super loadView];
    
    if ([self.requestParams isKindOfClass:UIViewModel.class]) {
        self.viewModel = (UIViewModel *)self.requestParams;
    }
    self.setupNavigationBarHidden = YES;
    self.bgImage = nil;
    self.inputViewSize = CGSizeMake(JobsWidth(343), JobsWidth(52));
    self.nextBtnSize = CGSizeMake(JobsWidth(343), JobsWidth(40));
    self.step = 1;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setGKNav];
    [self setGKNavBackBtn];
    self.gk_navigationBar.jobsVisible = NO;
    self.titleLab.alpha = 1;
    self.errTipsLab.jobsVisible = NO;
    self.inputUserNameView.alpha = 1;
    self.inputTelPhView.alpha = 1;
    self.nextBtn.alpha = 1;
    self.connectionTipsTV.alpha = 1;
    self.tipsLab.alpha = 1;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    NSLog(@"");
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    NSLog(@"");
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}
#pragma mark —— 一些私有方法
-(void)inputUserNameViewConstraint:(MASConstraintMaker *)make{
    make.size.mas_equalTo(self.inputViewSize);
    make.left.equalTo(self.view).offset(JobsWidth(16));
    make.top.equalTo(self.errTipsLab.mas_bottom).offset(JobsWidth(14));
}

-(void)inputTelPhViewConstraint:(MASConstraintMaker *)make{
    make.size.mas_equalTo(self.inputViewSize);
    make.left.equalTo(self.view).offset(JobsWidth(16));
    make.top.equalTo(self.inputUserNameView.mas_bottom).offset(JobsWidth(14));
}

-(void)inputVerificationCodeViewConstraint:(MASConstraintMaker *)make{
    make.size.mas_equalTo(self.inputViewSize);
    make.left.equalTo(self.view).offset(JobsWidth(16));
    make.top.equalTo(self.inputTelPhView.mas_bottom).offset(JobsWidth(14));
}

-(void)inputNextBtnConstraint:(MASConstraintMaker *)make{
    make.size.mas_equalTo(self.nextBtnSize);
    make.centerX.equalTo(self.view);
    self.constraint = make.top.equalTo(self.inputTelPhView.mas_bottom).offset(JobsWidth(36));
}
#pragma mark —— lazyLoad
-(JobsLeftRightLab *)titleLab{
    if (!_titleLab) {
        _titleLab = JobsLeftRightLab.new;
        [self.view addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(JobsWidth(188), JobsWidth(16)));
            make.left.equalTo(self.view).offset(JobsWidth(16));
            make.top.equalTo(self.view).offset(JobsWidth(36));
        }];
        [_titleLab richElementsInViewWithModel:self.leftRightLabModel];
    }return _titleLab;
}

-(UILabel *)errTipsLab{
    if (!_errTipsLab) {
        _errTipsLab = UILabel.new;
        _errTipsLab.text = Internationalization(@"您輸入的密碼和用戶名有誤");
        _errTipsLab.textColor = HEXCOLOR(0xEB677F);
        _errTipsLab.font = notoSansRegular(12);
        [_errTipsLab makeLabelByShowingType:UILabelShowingType_03];
        [self.view addSubview:_errTipsLab];
        [_errTipsLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLab.mas_bottom).offset(JobsWidth(14));
            make.left.equalTo(self.view).offset(JobsWidth(16));
        }];
    }return _errTipsLab;
}

-(JobsAppDoorInputViewBaseStyle_8 *)inputUserNameView{
    if (!_inputUserNameView) {
        _inputUserNameView = [JobsAppDoorInputViewBaseStyle_8.alloc initWithSize:self.inputViewSize];
        _inputUserNameView.backgroundColor = HEXCOLOR(0xFFFCF7);
        @jobs_weakify(self)
        [_inputUserNameView actionObjectBlock:^(UITextField *data) {
//            JobsAppDoorInputViewTFModel *textFieldInputModel = (JobsAppDoorInputViewTFModel *)data.objBindingParams;
            @jobs_strongify(self)
        }];
        [_inputUserNameView richElementsInViewWithModel:self.inputUserNameViewDataModel];
        [self.view addSubview:_inputUserNameView];
        [_inputUserNameView mas_makeConstraints:^(MASConstraintMaker *make) {
            [self inputUserNameViewConstraint:make];
        }];
        [self.view layoutIfNeeded];
        [_inputUserNameView cornerCutToCircleWithCornerRadius:JobsWidth(self.inputViewSize.height / 2)];
        [_inputUserNameView layerBorderCor:HEXCOLOR(0xEEE2C8) andBorderWidth:JobsWidth(1)];
    }return _inputUserNameView;
}

-(JobsAppDoorInputViewBaseStyle_7 *)inputTelPhView{
    if (!_inputTelPhView) {
        _inputTelPhView = [JobsAppDoorInputViewBaseStyle_7.alloc initWithSize:self.inputViewSize];
        _inputTelPhView.backgroundColor = HEXCOLOR(0xFFFCF7);
        @jobs_weakify(self)
        [_inputTelPhView actionObjectBlock:^(UITextField *data) {
//            JobsAppDoorInputViewTFModel *textFieldInputModel = (JobsAppDoorInputViewTFModel *)data.objBindingParams;
            @jobs_strongify(self)
        }];
        [_inputTelPhView richElementsInViewWithModel:self.inputTelPhViewDataModel];
        [self.view addSubview:_inputTelPhView];
        [_inputTelPhView mas_makeConstraints:^(MASConstraintMaker *make) {
            [self inputTelPhViewConstraint:make];
        }];
        [self.view layoutIfNeeded];
        [_inputTelPhView cornerCutToCircleWithCornerRadius:JobsWidth(self.inputViewSize.height / 2)];
        [_inputTelPhView layerBorderCor:HEXCOLOR(0xEEE2C8) andBorderWidth:JobsWidth(1)];
    }return _inputTelPhView;
}

-(JobsAppDoorInputViewBaseStyle_9 *)inputVerificationCodeView{
    if (!_inputVerificationCodeView) {
        _inputVerificationCodeView = [JobsAppDoorInputViewBaseStyle_9.alloc initWithSize:inputSize()];
        _inputVerificationCodeView.countDownBtnWidth = JobsWidth(80);
        _inputVerificationCodeView.textFieldWidth = JobsWidth(220);
        @jobs_weakify(self)
        [_inputVerificationCodeView actionObjectBlock:^(JobsAppDoorInputViewTFModel *data) {
            @jobs_strongify(self)

        }];
        
        [self.view addSubview:_inputVerificationCodeView];
        [_inputVerificationCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
            [self inputVerificationCodeViewConstraint:make];
        }];
        
        _inputVerificationCodeView.layer.cornerRadius = JobsWidth(52 / 2);
        _inputVerificationCodeView.layer.borderColor = HEXCOLOR(0xEEE2C8).CGColor;
        [_inputVerificationCodeView richElementsInViewWithModel:self.inputVerificationCodeViewDataModel];
    }return _inputVerificationCodeView;
}

-(JobsAppDoorInputViewBaseStyle_3 *)inputPwdView{
    if (!_inputPwdView) {
        _inputPwdView = JobsAppDoorInputViewBaseStyle_3.new;
        @jobs_weakify(self)
        [_inputPwdView actionObjectBlock:^(JobsAppDoorInputViewTFModel *data) {
            @jobs_strongify(self)
        }];
        
        [self.view addSubview:_inputPwdView];
        [_inputPwdView mas_makeConstraints:^(MASConstraintMaker *make) {
            [self inputUserNameViewConstraint:make];
        }];
        
        _inputPwdView.layer.cornerRadius = self.inputViewSize.height / 2;
        [_inputPwdView layerBorderCor:HEXCOLOR(0xEEE2C8) andBorderWidth:1.f];
        
        [_inputPwdView richElementsInViewWithModel:self.inputPwdViewDataModel];
    }return _inputPwdView;
}

-(JobsAppDoorInputViewBaseStyle_3 *)inputPwdConfirmView{
    if (!_inputPwdConfirmView) {
        _inputPwdConfirmView = JobsAppDoorInputViewBaseStyle_3.new;
        @jobs_weakify(self)
        [_inputPwdConfirmView actionObjectBlock:^(JobsAppDoorInputViewTFModel *data) {
            @jobs_strongify(self)
        }];
        
        [self.view addSubview:_inputPwdConfirmView];
        [_inputPwdConfirmView mas_makeConstraints:^(MASConstraintMaker *make) {
//            [self inputTelPhViewConstraint:make];
            make.size.mas_equalTo(self.inputViewSize);
            make.left.equalTo(self.view).offset(JobsWidth(16));
            make.top.equalTo(self.inputPwdView.mas_bottom).offset(JobsWidth(14));
        }];
        
        _inputPwdConfirmView.layer.cornerRadius = self.inputViewSize.height / 2;
        [_inputPwdConfirmView layerBorderCor:HEXCOLOR(0xEEE2C8) andBorderWidth:1.f];
        
        [_inputPwdConfirmView richElementsInViewWithModel:self.inputPwdConfirmViewDataModel];
    }return _inputPwdConfirmView;
}

-(UIButton *)nextBtn{
    if (!_nextBtn) {
        _nextBtn = UIButton.new;
        _nextBtn.normalTitle = Internationalization(@"下一步");
        _nextBtn.normalTitleColor = HEXCOLOR(0xB3B3B3);
        _nextBtn.titleFont = notoSansBold(18);
        _nextBtn.backgroundColor = self.nextBtnCor;
        [self.view addSubview:_nextBtn];
        [_nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            [self inputNextBtnConstraint:make];
        }];
        [_nextBtn cornerCutToCircleWithCornerRadius:self.nextBtnSize.height / 2];
        @jobs_weakify(self)
        [_nextBtn btnClickEventBlock:^(UIButton *x) {
            @jobs_strongify(self)
            self.step += 1;
            if (self.step == 2) {
                [UIView transitionWithView:self.inputUserNameView
                                  duration:1
                                   options:UIViewAnimationOptionTransitionCrossDissolve
                                animations:^{
                    self.inputUserNameView.jobsVisible = NO;
                } completion:^(BOOL finished) {
                    [self.inputTelPhView mas_updateConstraints:^(MASConstraintMaker *make) {
                        [self inputUserNameViewConstraint:make];
                    }];
                    self.inputVerificationCodeView.jobsVisible = YES;
                    /// Masonry 更新单个约束
                    [self.constraint uninstall];
                    [x mas_updateConstraints:^(MASConstraintMaker *make) {
                        make.top.equalTo(self.inputVerificationCodeView.mas_bottom).offset(JobsWidth(36)).priorityHigh();
                    }];
                    [self.view layoutIfNeeded];
                }];
                self.leftRightLabModel.downLabText = Internationalization(@"2/3步");
                self.leftRightLabModel.upLabText = Internationalization(@"填写验证码");
                [self.titleLab richElementsInViewWithModel:self.leftRightLabModel];
                [self.titleLab.getLeftBtn makeBtnLabelByShowingType:UILabelShowingType_03];
            }else if (self.step == 3){
                [UIView transitionWithView:self.inputTelPhView
                                  duration:1
                                   options:UIViewAnimationOptionTransitionCrossDissolve
                                animations:^{
                    self.inputTelPhView.jobsVisible = NO;
                    
                    [UIView transitionWithView:self.inputVerificationCodeView
                                      duration:1
                                       options:UIViewAnimationOptionTransitionCrossDissolve
                                    animations:^{
                        self.inputVerificationCodeView.jobsVisible = NO;
                    } completion:^(BOOL finished) {
                        self.inputPwdView.jobsVisible = YES;
                        self.inputPwdConfirmView.jobsVisible = YES;
                    }];
                    
                } completion:^(BOOL finished) {

                }];
                
                self.leftRightLabModel.downLabText = Internationalization(@"3/3步");
                self.leftRightLabModel.upLabText = Internationalization(@"填写和确认密码");
                [self.titleLab richElementsInViewWithModel:self.leftRightLabModel];
            }

        }];
    }return _nextBtn;
}

-(UILabel *)tipsLab{
    if (!_tipsLab) {
        _tipsLab = UILabel.new;
        _tipsLab.textColor = HEXCOLOR(0xB0B0B0);
        _tipsLab.textAlignment = NSTextAlignmentCenter;
        _tipsLab.font = notoSansRegular(12);
        _tipsLab.text = Internationalization(@"如果您沒有綁定手機號或電子郵箱請聯繫客服找回密碼");
        [self.view addSubview:_tipsLab];
        [_tipsLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(JobsWidth(190));
            make.centerX.equalTo(self.view);
            make.bottom.equalTo(self.connectionTipsTV.mas_top).offset(-JobsWidth(40));
        }];
        [_tipsLab makeLabelByShowingType:UILabelShowingType_05];
    }return _tipsLab;
}

-(UIColor *)nextBtnCor{
    if (!_nextBtnCor) {
        _nextBtnCor = [UIColor gradientCorDataMutArr:[NSMutableArray arrayWithArray:@[HEXCOLOR(0xE7E7E7),HEXCOLOR(0xDDDADA)]]
                                          startPoint:CGPointZero
                                            endPoint:CGPointZero
                                              opaque:NO
                                      targetViewRect:CGRectMake(0, 0, self.nextBtnSize.width, self.nextBtnSize.height)];
    }return _nextBtnCor;
}

-(JobsLeftRightLabModel *)leftRightLabModel{
    if (!_leftRightLabModel) {
        _leftRightLabModel = JobsLeftRightLabModel.new;
        _leftRightLabModel.upLabText = Internationalization(@"手機驗證");
        _leftRightLabModel.upLabTextAlignment = NSTextAlignmentCenter;
        _leftRightLabModel.upLabFont = notoSansBold(16);
        _leftRightLabModel.upLabTextCor = HEXCOLOR(0x757575);
        _leftRightLabModel.upLabBgCor = UIColor.clearColor;

        _leftRightLabModel.downLabText = Internationalization(@"1/3步");
        _leftRightLabModel.downLabTextAlignment = NSTextAlignmentCenter;
        _leftRightLabModel.downLabFont = notoSansRegular(14);
        _leftRightLabModel.downLabTextCor = HEXCOLOR(0x757575);
        _leftRightLabModel.downLabBgCor = UIColor.clearColor;

        _leftRightLabModel.upLabVerticalAlign = JobsUpDownLabAlign_TopLeft;
        _leftRightLabModel.upLabLevelAlign = JobsUpDownLabAlign_TopLeft;
        _leftRightLabModel.downLabVerticalAlign = JobsUpDownLabAlign_TopLeft;
        _leftRightLabModel.downLabLevelAlign = JobsUpDownLabAlign_TopLeft;

        _leftRightLabModel.space = JobsWidth(12);
        _leftRightLabModel.labelShowingType = UILabelShowingType_03;
    }

    
    return _leftRightLabModel;
}

-(JobsAppDoorInputViewBaseStyleModel *)inputUserNameViewDataModel{
    if (!_inputUserNameViewDataModel) {
        _inputUserNameViewDataModel = JobsAppDoorInputViewBaseStyleModel.new;
        _inputUserNameViewDataModel.placeHolderStr = Internationalization(@"請輸入您的用戶名");
        _inputUserNameViewDataModel.placeholderColor = HEXCOLOR(0xC4C4C4);
        _inputUserNameViewDataModel.placeholderFont = notoSansRegular(16);
        _inputUserNameViewDataModel.placeHolderOffset = JobsWidth(35);
        _inputUserNameViewDataModel.leftViewIMG = JobsIMG(@"用户名");
        _inputUserNameViewDataModel.leftViewMode = UITextFieldViewModeAlways;
        _inputUserNameViewDataModel.textModel.text = Internationalization(@"");
        _inputUserNameViewDataModel.textModel.textCor = HEXCOLOR(0xFFE8D1);
        _inputUserNameViewDataModel.isShowDelBtn = YES;
        _inputUserNameViewDataModel.isShowSecurityBtn = NO;
        _inputUserNameViewDataModel.returnKeyType = UIReturnKeyDone;
        _inputUserNameViewDataModel.keyboardAppearance = UIKeyboardAppearanceAlert;
        _inputUserNameViewDataModel.titleStrCor = HEXCOLOR(0x6D655D);
    }return _inputUserNameViewDataModel;
}

-(JobsAppDoorInputViewBaseStyleModel *)inputTelPhViewDataModel{
    if (!_inputTelPhViewDataModel) {
        _inputTelPhViewDataModel = JobsAppDoorInputViewBaseStyleModel.new;
        _inputTelPhViewDataModel.placeHolderStr = Internationalization(@"請輸入您的手機號");
        _inputTelPhViewDataModel.placeholderColor = HEXCOLOR(0xC4C4C4);
        _inputTelPhViewDataModel.placeholderFont = notoSansRegular(16);
        _inputTelPhViewDataModel.placeHolderOffset = JobsWidth(35);
        _inputTelPhViewDataModel.leftViewIMG = JobsIMG(@"小手机图标");
        _inputTelPhViewDataModel.leftViewMode = UITextFieldViewModeAlways;
        _inputTelPhViewDataModel.textModel.text = Internationalization(@"");
        _inputTelPhViewDataModel.textModel.textCor = HEXCOLOR(0xFFE8D1);
        _inputTelPhViewDataModel.isShowDelBtn = YES;
        _inputTelPhViewDataModel.isShowSecurityBtn = NO;
        _inputTelPhViewDataModel.returnKeyType = UIReturnKeyDone;
        _inputTelPhViewDataModel.keyboardAppearance = UIKeyboardAppearanceAlert;
        _inputTelPhViewDataModel.titleStrCor = HEXCOLOR(0x6D655D);
    }return _inputTelPhViewDataModel;
}

-(JobsAppDoorInputViewBaseStyleModel *)inputVerificationCodeViewDataModel{
    if (!_inputVerificationCodeViewDataModel) {
        _inputVerificationCodeViewDataModel = JobsAppDoorInputViewBaseStyleModel.new;
        _inputVerificationCodeViewDataModel.leftViewIMG = JobsIMG(@"安全");
        _inputVerificationCodeViewDataModel.placeHolderStr = Internationalization(@"請輸入驗證碼");
        _inputVerificationCodeViewDataModel.placeholderFont = notoSansRegular(JobsWidth(16));
        _inputVerificationCodeViewDataModel.placeholderColor = HEXCOLOR_ALPHA(0xC4C4C4,1.f);
        _inputVerificationCodeViewDataModel.isShowDelBtn = YES;
        _inputVerificationCodeViewDataModel.isShowSecurityBtn = NO;
        _inputVerificationCodeViewDataModel.returnKeyType = UIReturnKeyDone;
        _inputVerificationCodeViewDataModel.keyboardAppearance = UIKeyboardAppearanceAlert;
        _inputVerificationCodeViewDataModel.leftViewMode = UITextFieldViewModeAlways;
        _inputVerificationCodeViewDataModel.titleStrCor = HEXCOLOR(0x6D655D);
//       _inputVerificationCodeViewDataModel.fieldEditorOffset = JobsWidth(80);
    }return _inputVerificationCodeViewDataModel;
}

-(JobsAppDoorInputViewBaseStyleModel *)inputPwdViewDataModel{
    if (!_inputPwdViewDataModel) {
        _inputPwdViewDataModel = JobsAppDoorInputViewBaseStyleModel.new;
        _inputPwdViewDataModel.leftViewIMG = JobsIMG(@"密码锁");
        _inputPwdViewDataModel.placeHolderStr = Internationalization(@"請輸入新的密碼");
        _inputPwdViewDataModel.placeholderFont = notoSansRegular(16);
        _inputPwdViewDataModel.placeholderColor = HEXCOLOR(0xC4C4C4);
        _inputPwdViewDataModel.placeHolderOffset = JobsWidth(35);
        _inputPwdViewDataModel.leftViewOffsetX = JobsWidth(10);
        _inputPwdViewDataModel.isShowDelBtn = YES;
        _inputPwdViewDataModel.isShowSecurityBtn = NO;
        _inputPwdViewDataModel.returnKeyType = UIReturnKeyDone;
        _inputPwdViewDataModel.keyboardAppearance = UIKeyboardAppearanceAlert;
        _inputPwdViewDataModel.leftViewMode = UITextFieldViewModeAlways;
        _inputPwdViewDataModel.moveDistance = JobsWidth(40);
        _inputPwdViewDataModel.titleStrCor = HEXCOLOR(0x524740);
        _inputPwdViewDataModel.background = JobsIMG(@"设置弹出框输入框背景图");
        _inputPwdViewDataModel.animationColor = HEXCOLOR(0xF2CC78);
    }return _inputPwdViewDataModel;
}

-(JobsAppDoorInputViewBaseStyleModel *)inputPwdConfirmViewDataModel{
    if (!_inputPwdConfirmViewDataModel) {
        _inputPwdConfirmViewDataModel = JobsAppDoorInputViewBaseStyleModel.new;
        _inputPwdConfirmViewDataModel.leftViewIMG = JobsIMG(@"密码锁");
        _inputPwdConfirmViewDataModel.placeHolderStr = Internationalization(@"再次確認密碼");
        _inputPwdConfirmViewDataModel.placeholderFont = notoSansRegular(16);
        _inputPwdConfirmViewDataModel.placeholderColor = HEXCOLOR(0xC4C4C4);
        _inputPwdConfirmViewDataModel.placeHolderOffset = JobsWidth(35);
        _inputPwdConfirmViewDataModel.leftViewOffsetX = JobsWidth(10);
        _inputPwdConfirmViewDataModel.isShowDelBtn = YES;
        _inputPwdConfirmViewDataModel.isShowSecurityBtn = NO;
        _inputPwdConfirmViewDataModel.returnKeyType = UIReturnKeyDone;
        _inputPwdConfirmViewDataModel.keyboardAppearance = UIKeyboardAppearanceAlert;
        _inputPwdConfirmViewDataModel.leftViewMode = UITextFieldViewModeAlways;
        _inputPwdConfirmViewDataModel.moveDistance = JobsWidth(40);
        _inputPwdConfirmViewDataModel.titleStrCor = HEXCOLOR(0x524740);
        _inputPwdConfirmViewDataModel.background = JobsIMG(@"设置弹出框输入框背景图");
        _inputPwdConfirmViewDataModel.animationColor = HEXCOLOR(0xF2CC78);
    }return _inputPwdConfirmViewDataModel;
}

@end
