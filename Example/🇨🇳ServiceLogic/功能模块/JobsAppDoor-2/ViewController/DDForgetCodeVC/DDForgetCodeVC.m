//
//  DDForgetCodeVC.m
//  DouDong-II
//
//  Created by Jobs on 2020/12/17.
//

#import "DDForgetCodeVC.h"

@interface DDForgetCodeVC ()
/// UI
@property(nonatomic,strong)FindCodeFlowChartView *flowChartView;
@property(nonatomic,strong)UIButton *nextStepBtn;
@property(nonatomic,strong)UIButton *succeedBtn;
/// Data
@property(nonatomic,assign)NSInteger flowNum;///一共几个流程节点
@property(nonatomic,assign)NSInteger currentFlowSerialNum;///当前流程序号 从0开始
@property(nonatomic,strong)NSMutableArray <NSString *>*titleMutArr;
@property(nonatomic,strong)NSMutableArray <NSString *>*subTitleMutArr;
@property(nonatomic,strong)NSMutableArray <UIImage *>*backImageMutArr;
@property(nonatomic,strong)NSMutableArray <NSString *>*textFieldTitleMutArr_step1;
@property(nonatomic,strong)NSMutableArray <NSString *>*textFieldPlaceHolderMutArr_step1;
@property(nonatomic,strong)NSMutableArray <NSString *>*textFieldTitleMutArr_step2;
@property(nonatomic,strong)NSMutableArray <NSString *>*textFieldPlaceHolderMutArr_step2;
@property(nonatomic,strong)NSMutableArray <JobsAppDoorInputViewBaseStyle_5 *>*inputViewMutArr_step1;
@property(nonatomic,strong)NSMutableArray <JobsAppDoorInputViewBaseStyle_5 *>*inputViewMutArr_step2;
@property(nonatomic,strong)NSMutableDictionary *inputTFValueMutDic;

@end

@implementation DDForgetCodeVC

-(void)loadView{
    [super loadView];
    self.setupNavigationBarHidden = YES;
    self.currentFlowSerialNum = 0;
    self.flowNum = 3;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = JobsWhiteColor;
    @jobs_weakify(self)
    [UIView transitionWithView:self.view
                      duration:0.5
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
        @jobs_strongify(self)
        self.flowChartView.alpha = 1;
        self.nextStepBtn.alpha = 1;
        [self makeTextField_step1];
     } completion:nil];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
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
#pragma mark —— 一些私有化方法
/// 返回NO按钮不可点击
-(BOOL)checkStep1{
    NSLog(@"self.inputTFValueMutDic = %@",self.inputTFValueMutDic);
    if (self.inputTFValueMutDic.count == self.textFieldTitleMutArr_step1.count) {
        BOOL r = YES;
        for (NSString *textFieldPlaceHolder_step1 in self.textFieldPlaceHolderMutArr_step1) {
            r &= ![NSString isNullString:self.inputTFValueMutDic[textFieldPlaceHolder_step1]];
        }return r;
    }else{
        return NO;
    }
}
/// 返回NO按钮不可点击
-(BOOL)checkStep2{
    NSLog(@"self.inputTFValueMutDic = %@",self.inputTFValueMutDic);
    if (self.inputTFValueMutDic.count == self.textFieldTitleMutArr_step2.count) {
        BOOL r = YES;
        for (NSString *textFieldPlaceHolder_step2 in self.textFieldPlaceHolderMutArr_step2) {
            r &= ![NSString isNullString:self.inputTFValueMutDic[textFieldPlaceHolder_step2]];
        }return r;
    }else{
        return NO;
    }
}

-(void)makeTextField_step1{
    for (int i = 0; i < self.textFieldTitleMutArr_step1.count; i++) {
        JobsAppDoorInputViewBaseStyle_5 *inputView = JobsAppDoorInputViewBaseStyle_5.new;
        inputView.style_5 = InputViewStyle_5_2;
        [self.inputViewMutArr_step1 addObject:inputView];
        [self.view addSubview:inputView];
        [inputView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view).offset(JobsWidth(10));
            make.right.equalTo(self.view).offset(-JobsWidth(10));
            make.height.mas_equalTo(50);
            if (i == 0) {
                make.top.equalTo(self.flowChartView.mas_bottom).offset(JobsWidth(83));
            }else{
                JobsAppDoorInputViewBaseStyle_5 *inputView = (JobsAppDoorInputViewBaseStyle_5 *)self.inputViewMutArr_step1[i - 1];
                make.top.equalTo(inputView.mas_bottom).offset(JobsWidth(45));
            }
        }];
        
        JobsAppDoorInputViewBaseStyleModel *inputViewStyleModel = JobsAppDoorInputViewBaseStyleModel.new;
        inputViewStyleModel.placeHolderStr = self.textFieldPlaceHolderMutArr_step1[i];
        inputViewStyleModel.titleLabStr = self.textFieldTitleMutArr_step1[i];
        inputViewStyleModel.placeHolderAlignment = PlaceHolderAlignmentLeft;
        inputViewStyleModel.leftViewOffsetX = 0.1;
        inputViewStyleModel.offset = 0.1;
        inputViewStyleModel.ZYtextColor = JobsLightGrayColor;
        
        [inputView richElementsInViewWithModel:inputViewStyleModel];
        @jobs_weakify(self)
        // 监测输入字符回调 和 激活的textField
        [inputView actionObjectBlock:^(id data) {
            @jobs_strongify(self)
            if ([data isKindOfClass:NSDictionary.class]) {
                NSDictionary *dic = (NSDictionary *)data;
                JobsAppDoorInputViewTFModel *inputViewTFModel = (JobsAppDoorInputViewTFModel *)dic[@"TFResModel"];
                [self.inputTFValueMutDic setValue:inputViewTFModel.resString
                                           forKey:dic[@"PlaceHolder"]];
            }
            NSLog(@"DDss%@",self.inputTFValueMutDic);
            self.nextStepBtn.userInteractionEnabled = [self checkStep1];
//            NSLog(@"userInteractionEnabled = %d",self.nextStepBtn.userInteractionEnabled);
            if (self.nextStepBtn.userInteractionEnabled) {
                self.nextStepBtn.backgroundColor = [UIColor colorWithPatternImage:JobsIMG(@"找回密码_下一步_可点击")];
            }else{
                self.nextStepBtn.backgroundColor = [UIColor colorWithPatternImage:JobsIMG(@"找回密码_下一步_不可点击")];
            }
        }];
    }
}

-(void)makeTextField_step2{
    for (int i = 0; i < self.textFieldTitleMutArr_step2.count; i++) {
        JobsAppDoorInputViewBaseStyle_5 *inputView = JobsAppDoorInputViewBaseStyle_5.new;
        [self.inputViewMutArr_step2 addObject:inputView];
        [self.view addSubview:inputView];
        [inputView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view).offset(JobsWidth(10));
            make.right.equalTo(self.view).offset(-JobsWidth(10));
            make.height.mas_equalTo(50);
            if (i == 0) {
                inputView.style_5 = InputViewStyle_5_1;
                make.top.equalTo(self.flowChartView.mas_bottom).offset(JobsWidth(83));
            }else{
                inputView.style_5 = InputViewStyle_5_2;
                JobsAppDoorInputViewBaseStyle_5 *inputView = (JobsAppDoorInputViewBaseStyle_5 *)self.inputViewMutArr_step2[i - 1];
                make.top.equalTo(inputView.mas_bottom).offset(JobsWidth(45));
            }
        }];
        
        JobsAppDoorInputViewBaseStyleModel *inputViewStyleModel = JobsAppDoorInputViewBaseStyleModel.new;
        inputViewStyleModel.placeHolderStr = self.textFieldPlaceHolderMutArr_step2[i];
        inputViewStyleModel.titleLabStr = self.textFieldTitleMutArr_step2[i];
        inputViewStyleModel.placeHolderAlignment = PlaceHolderAlignmentLeft;
        inputViewStyleModel.leftViewOffsetX = 0.1;
        inputViewStyleModel.offset = 0.1;
        inputViewStyleModel.ZYtextColor = JobsLightGrayColor;
        
        [inputView richElementsInViewWithModel:inputViewStyleModel];
        @jobs_weakify(self)
        // 监测输入字符回调 和 激活的textField
        [inputView actionObjectBlock:^(id data) {
            @jobs_strongify(self)
            if ([data isKindOfClass:NSDictionary.class]) {
                NSDictionary *dic = (NSDictionary *)data;
                JobsAppDoorInputViewTFModel *inputViewTFModel = (JobsAppDoorInputViewTFModel *)dic[@"TFResModel"];
                [self.inputTFValueMutDic setValue:inputViewTFModel.resString
                                           forKey:dic[@"PlaceHolder"]];
            }
            
            self.nextStepBtn.userInteractionEnabled = [self checkStep2];
            NSLog(@"sw = %d",self.nextStepBtn.userInteractionEnabled);
            self.nextStepBtn.backgroundColor = [UIColor colorWithPatternImage:self.nextStepBtn.userInteractionEnabled ? JobsIMG(@"找回密码_下一步_可点击") : JobsIMG(@"找回密码_下一步_不可点击")];
        }];
    }
}

-(void)step1ToStep2{
    @jobs_weakify(self)
    [UIView transitionWithView:self.view
                      duration:0.5
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
        @jobs_strongify(self)
        for (JobsAppDoorInputViewBaseStyle_5 *inputView in self.inputViewMutArr_step1) {
            [inputView removeFromSuperview];
        }
        [self makeTextField_step2];
    } completion:^(BOOL finished) {
        @jobs_strongify(self)
        // 相关状态置空
        [self.inputTFValueMutDic removeAllObjects];
        self.nextStepBtn.userInteractionEnabled = NO;
        self.nextStepBtn.backgroundColor = [UIColor colorWithPatternImage:JobsIMG(@"找回密码_下一步_不可点击")];
        self.flowChartView.currentFlowSerialNum = self.currentFlowSerialNum;
        for (JobsAppDoorInputViewBaseStyle_5 *inputView in self.inputViewMutArr_step1) {
            [inputView removeFromSuperview];
        }
    }];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches
          withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
#pragma mark —— LazyLoad
-(FindCodeFlowChartView *)flowChartView{
    if (!_flowChartView) {
        _flowChartView = FindCodeFlowChartView.new;
        _flowChartView.currentFlowSerialNum = self.currentFlowSerialNum;
        _flowChartView.flowNum = self.flowNum;
        _flowChartView.titleMutArr = self.titleMutArr;
        _flowChartView.subTitleMutArr = self.subTitleMutArr;
        _flowChartView.backImageMutArr = self.backImageMutArr;
        [self.view addSubview:_flowChartView];
        [_flowChartView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.top.equalTo(self.gk_navigationBar.mas_bottom).offset(8);
            make.height.mas_equalTo(65);
        }];
    }return _flowChartView;
}

-(UIButton *)nextStepBtn{
    if (!_nextStepBtn) {
        _nextStepBtn = UIButton.new;
        _nextStepBtn.userInteractionEnabled = NO;
        [_nextStepBtn normalTitle:@"下一步"];
        _nextStepBtn.backgroundColor = [UIColor colorWithPatternImage:JobsIMG(@"找回密码_下一步_不可点击")];
        @jobs_weakify(self)
        [_nextStepBtn btnClickEventBlock:^(UIButton *x) {
            @jobs_strongify(self)
            if (self.currentFlowSerialNum == 0) {
                [self step1ToStep2];//
                self.currentFlowSerialNum ++;
            }else if (self.currentFlowSerialNum == 1){
                for (JobsAppDoorInputViewBaseStyle_5 *inputView in self.inputViewMutArr_step2) {
                    [inputView removeFromSuperview];
                }
                [x normalTitle:@"去登陆"];
                [self.succeedBtn animationAlert];
                self.currentFlowSerialNum ++;
                self.flowChartView.currentFlowSerialNum = self.currentFlowSerialNum;
            }else{}
        }];
        [self.view addSubview:_nextStepBtn];
        [_nextStepBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_offset(CGSizeMake(JobsWidth(192), JobsWidth(32)));
            make.centerX.equalTo(self.view);
            make.bottom.equalTo(self.view).offset(-JobsWidth(172));
        }];
    }return _nextStepBtn;
}

-(UIButton *)succeedBtn{
    if (!_succeedBtn) {
        _succeedBtn = UIButton.new;
        
        _succeedBtn.normalTitle = Internationalization(@"密码修改成功");
        _succeedBtn.normalImage = JobsIMG(@"密码修改成功");
        _succeedBtn.normalTitleColor = JobsBlackColor;
        _succeedBtn.titleFont = UIFontWeightMediumSize(17);

        [_succeedBtn btnClickEventBlock:^(UIButton *x) {
            toast(x.titleForNormalState);
        }];
        [self.view addSubview:_succeedBtn];
        [_succeedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.view);
            make.size.mas_equalTo(CGSizeMake(150, 150));
        }];
        [_succeedBtn layoutButtonWithEdgeInsetsStyle:GLButtonEdgeInsetsStyleTop
                                     imageTitleSpace:16];
    }return _succeedBtn;
}

-(NSMutableArray<NSString *> *)titleMutArr{
    if (!_titleMutArr) {
        _titleMutArr = NSMutableArray.array;
        [_titleMutArr addObject:@"01"];
        [_titleMutArr addObject:@"02"];
        [_titleMutArr addObject:@"03"];
    }return _titleMutArr;
}

-(NSMutableArray<NSString *> *)subTitleMutArr{
    if (!_subTitleMutArr) {
        _subTitleMutArr = NSMutableArray.array;
        [_subTitleMutArr addObject:Internationalization(@"身份登录")];
        [_subTitleMutArr addObject:Internationalization(@"修改密码")];
        [_subTitleMutArr addObject:Internationalization(@"完成")];
    }return _subTitleMutArr;
}

-(NSMutableArray<UIImage *> *)backImageMutArr{
    if (!_backImageMutArr) {
        _backImageMutArr = NSMutableArray.array;
        [_backImageMutArr addObject:JobsIMG(@"di_1")];
        [_backImageMutArr addObject:JobsIMG(@"di_2")];
        [_backImageMutArr addObject:JobsIMG(@"di_3")];
        [_backImageMutArr addObject:JobsIMG(@"di_4")];
    }return _backImageMutArr;
}

-(NSMutableArray<NSString *> *)textFieldTitleMutArr_step2{
    if (!_textFieldTitleMutArr_step2) {
        _textFieldTitleMutArr_step2 = NSMutableArray.array;
        [_textFieldTitleMutArr_step2 addObject:Internationalization(@"验证码")];
        [_textFieldTitleMutArr_step2 addObject:Internationalization(@"新密码")];
        [_textFieldTitleMutArr_step2 addObject:Internationalization(@"确认新密码")];
    }return _textFieldTitleMutArr_step2;
}

-(NSMutableArray<NSString *> *)textFieldPlaceHolderMutArr_step2{
    if (!_textFieldPlaceHolderMutArr_step2) {
        _textFieldPlaceHolderMutArr_step2 = NSMutableArray.array;
        [_textFieldPlaceHolderMutArr_step2 addObject:Internationalization(@"请输入验证码")];
        [_textFieldPlaceHolderMutArr_step2 addObject:Internationalization(@"确认新密码")];
        [_textFieldPlaceHolderMutArr_step2 addObject:Internationalization(@"请再次输入密码")];
    }return _textFieldPlaceHolderMutArr_step2;
}

-(NSMutableArray<JobsAppDoorInputViewBaseStyle_5 *> *)inputViewMutArr_step1{
    if (!_inputViewMutArr_step1) {
        _inputViewMutArr_step1 = NSMutableArray.array;
    }return _inputViewMutArr_step1;
}

-(NSMutableArray<JobsAppDoorInputViewBaseStyle_5 *> *)inputViewMutArr_step2{
    if (!_inputViewMutArr_step2) {
        _inputViewMutArr_step2 = NSMutableArray.array;
    }return _inputViewMutArr_step2;
}

-(NSMutableArray<NSString *> *)textFieldTitleMutArr_step1{
    if (!_textFieldTitleMutArr_step1) {
        _textFieldTitleMutArr_step1 = NSMutableArray.array;
        [_textFieldTitleMutArr_step1 addObject:Internationalization(@"用户名")];
        [_textFieldTitleMutArr_step1 addObject:Internationalization(@"手机号")];
    }return _textFieldTitleMutArr_step1;
}

-(NSMutableArray<NSString *> *)textFieldPlaceHolderMutArr_step1{
    if (!_textFieldPlaceHolderMutArr_step1) {
        _textFieldPlaceHolderMutArr_step1 = NSMutableArray.array;
        [_textFieldPlaceHolderMutArr_step1 addObject:Internationalization(@"请输入4-11位字母或数字的用户名")];
        [_textFieldPlaceHolderMutArr_step1 addObject:Internationalization(@"请输入手机号")];
    }return _textFieldPlaceHolderMutArr_step1;
}

-(NSMutableDictionary *)inputTFValueMutDic{
    if (!_inputTFValueMutDic) {
        _inputTFValueMutDic = NSMutableDictionary.dictionary;
    }return _inputTFValueMutDic;
}

@end
