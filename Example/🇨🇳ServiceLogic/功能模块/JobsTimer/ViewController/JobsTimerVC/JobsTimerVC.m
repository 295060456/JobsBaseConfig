//
//  JobsTimerVC.m
//  JobsBaseConfig
//
//  Created by Jobs on 2022/1/20.
//

#import "JobsTimerVC.h"

@interface JobsTimerVC ()
/// UI
@property(nonatomic,strong)UIButton *countDownBtn;
@property(nonatomic,strong)JobsCountdownView *countdownView;
@property(nonatomic,strong)NSMutableArray <UIButton *>*btnMutArr;
/// Data
@property(nonatomic,strong)ButtonTimerConfigModel *btnTimerConfigModel;
@property(nonatomic,strong)NSMutableArray <NSString *>*btnTitleMutArr;

@end

@implementation JobsTimerVC

- (void)dealloc{
    NSLog(@"%@",JobsLocalFunc);
    //    [NSNotificationCenter.defaultCenter removeObserver:self];
    [self.countDownBtn timerDestroy];
}

-(void)loadView{
    [super loadView];
    
    if ([self.requestParams isKindOfClass:UIViewModel.class]) {
        self.viewModel = (UIViewModel *)self.requestParams;
    }
    self.setupNavigationBarHidden = YES;
    
    {
        self.viewModel.backBtnTitleModel.text = Internationalization(@"返回");
        self.viewModel.textModel.textCor = HEXCOLOR(0x3D4A58);
        self.viewModel.textModel.text = Internationalization(@"");
        self.viewModel.textModel.font = UIFontWeightRegularSize(16);
        
        // 使用原则：底图有 + 底色有 = 优先使用底图数据
        // 以下2个属性的设置，涉及到的UI结论 请参阅父类（BaseViewController）的私有方法：-(void)setBackGround
        // self.viewModel.bgImage = JobsIMG(@"内部招聘导航栏背景图");/// self.gk_navBackgroundImage 和 self.bgImageView
        self.viewModel.bgCor = RGBA_COLOR(255, 238, 221, 1);/// self.gk_navBackgroundColor 和 self.view.backgroundColor
    //    self.viewModel.bgImage = JobsIMG(@"新首页的底图");
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = JobsMagentaColor;
    [self setGKNav];
    [self setGKNavBackBtn];
    
    [self test_masonry_horizontal_fixSpace];
    self.countDownBtn.alpha = 1;
    self.countdownView.alpha = 1;
    
    @jobs_weakify(self)
    /// 开始
    [self.btnMutArr[0] jobsBtnClickEventBlock:^id(UIButton *data) {
        @jobs_strongify(self)
        [self.countDownBtn startTimer];
        return nil;
    }];
    /// 暂停
    [self.btnMutArr[1] jobsBtnClickEventBlock:^id(UIButton *data) {
        @jobs_strongify(self)
        [self.countDownBtn timerSuspend];
        return nil;
    }];
    /// 继续
    [self.btnMutArr[2] jobsBtnClickEventBlock:^id(UIButton *data) {
        @jobs_strongify(self)
        [self.countDownBtn timerContinue];
        return nil;
    }];
    /// 结束
    [self.btnMutArr[3] jobsBtnClickEventBlock:^id(UIButton *data) {
        @jobs_strongify(self)
        [self.countDownBtn timerDestroy];
        return nil;
    }];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.countDownBtn timerContinue];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.countDownBtn timerSuspend];
}
#pragma mark —— 一些私有方法
-(void)test_masonry_horizontal_fixSpace {
    /// 实现masonry水平固定间隔方法
    [self.btnMutArr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal
                                withFixedSpacing:30
                                     leadSpacing:10
                                     tailSpacing:10];
    /// 设置array的垂直方向的约束
    [self.btnMutArr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.gk_navigationBar.mas_bottom).offset(JobsWidth(10));
        make.height.mas_equalTo(JobsWidth(30));
    }];
}
#pragma mark —— lazyLoad
-(UIButton *)countDownBtn{
    if (!_countDownBtn) {
        _countDownBtn = [UIButton.alloc initWithConfig:self.btnTimerConfigModel];
        [self.view addSubview:_countDownBtn];
        [_countDownBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(JobsWidth(25));
            make.center.equalTo(self.view);
        }];
        [_countDownBtn makeBtnLabelByShowingType:UILabelShowingType_03];
        
        [_countDownBtn jobsBtnClickEventBlock:^id(UIButton *x) {
            [x startTimer];//选择时机、触发启动
            NSLog(@"🪓🪓🪓🪓🪓 = 获取验证码");
            return nil;
        }];
        
        [_countDownBtn actionObjectBlock:^(id data) {
//            @jobs_strongify(self)
            if ([data isKindOfClass:TimerProcessModel.class]) {
                TimerProcessModel *model = (TimerProcessModel *)data;
                NSLog(@"❤️❤️❤️❤️❤️%f",model.data.anticlockwiseTime);
            }
        }];
    }return _countDownBtn;
}

-(ButtonTimerConfigModel *)btnTimerConfigModel{
    if (!_btnTimerConfigModel) {
        _btnTimerConfigModel = ButtonTimerConfigModel.new;
        
        /// 一些通用的设置
        _btnTimerConfigModel.jobsSize = CGSizeMake(JobsWidth(100), JobsWidth(25));
        _btnTimerConfigModel.count = 5;
        _btnTimerConfigModel.showTimeType = ShowTimeType_SS;//时间显示风格
        _btnTimerConfigModel.countDownBtnType = TimerStyle_anticlockwise;/// 逆时针模式（倒计时模式）
        _btnTimerConfigModel.cequenceForShowTitleRuningStrType = CequenceForShowTitleRuningStrType_tail;
        _btnTimerConfigModel.labelShowingType = UILabelShowingType_03;/// 一行显示。不定宽、定高、定字体。宽度自适应 【单行：ByFont】
        /// 计时器未开始【静态值】
        _btnTimerConfigModel.readyPlayValue.layerBorderWidth = 0.1;
        _btnTimerConfigModel.readyPlayValue.layerCornerRadius = JobsWidth(8);
        _btnTimerConfigModel.readyPlayValue.bgCor = JobsYellowColor;
        _btnTimerConfigModel.readyPlayValue.layerBorderCor = JobsBrownColor;
        _btnTimerConfigModel.readyPlayValue.textCor = JobsBlueColor;
        _btnTimerConfigModel.readyPlayValue.text = Internationalization(@"      获取验证码       ");
        _btnTimerConfigModel.readyPlayValue.font = UIFontWeightMediumSize(13);
        /// 计时器进行中【动态值】
        _btnTimerConfigModel.runningValue.bgCor = JobsCyanColor;
        _btnTimerConfigModel.runningValue.text = Internationalization(Title12);
        _btnTimerConfigModel.runningValue.layerBorderCor = JobsRedColor;
        _btnTimerConfigModel.runningValue.textCor = JobsBlackColor;
        /// 计时器结束【静态值】
        _btnTimerConfigModel.endValue.bgCor = JobsYellowColor;
        _btnTimerConfigModel.endValue.text = Internationalization(@"    哈哈哈哈    ");
        _btnTimerConfigModel.endValue.layerBorderCor = JobsPurpleColor;
        _btnTimerConfigModel.endValue.textCor = JobsBlackColor;
        
    }return _btnTimerConfigModel;
}

-(NSMutableArray<UIButton *> *)btnMutArr{
    if (!_btnMutArr) {
        _btnMutArr = NSMutableArray.array;
        for (NSString *title in self.btnTitleMutArr) {
            UIButton *btn = UIButton.new;
            btn.normalTitle = title;
            btn.normalTitleColor = JobsBlackColor;
            btn.normalBackgroundImage = JobsIMG(@"弹窗取消按钮背景图");
            btn.selectedBackgroundImage = JobsIMG(@"弹窗取消按钮背景图");
            [btn cornerCutToCircleWithCornerRadius:JobsWidth(8)];
            [btn layerBorderCor:HEXCOLOR(0xAE8330) andBorderWidth:0.5f];
            [self.view addSubview:btn];
            [_btnMutArr addObject:btn];
        }
    }return _btnMutArr;
}

-(NSMutableArray<NSString *> *)btnTitleMutArr{
    if (!_btnTitleMutArr) {
        _btnTitleMutArr = NSMutableArray.array;
        [_btnTitleMutArr addObject:Internationalization(@"开始")];
        [_btnTitleMutArr addObject:Internationalization(@"暂停")];
        [_btnTitleMutArr addObject:Internationalization(@"继续")];
        [_btnTitleMutArr addObject:Internationalization(@"结束")];
    }return _btnTitleMutArr;
}

-(JobsCountdownView *)countdownView{
    if (!_countdownView) {
        _countdownView = JobsCountdownView.new;
        [_countdownView richElementsInViewWithModel:nil];
        [self.view addSubview:_countdownView];
        [_countdownView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.view);
            make.size.mas_equalTo([JobsCountdownView viewSizeWithModel:nil]);
        }];
    }return _countdownView;
}

@end
