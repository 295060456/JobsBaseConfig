//
//  NSTimerManagerTestVC.m
//  JobsBaseConfig
//
//  Created by Jobs on 2022/6/24.
//

#import "NSTimerManagerTestVC.h"

@interface NSTimerManagerTestVC ()
/// UI
@property(nonatomic,strong)UILabel *valueLab;
@property(nonatomic,strong)NSMutableArray <UIButton *>*btnMutArr;
/// Data
@property(nonatomic,strong)NSTimerManager *nsTimerManager;
@property(nonatomic,strong)NSMutableArray <NSString *>*btnTitleMutArr;
// SEL是不可以保存到array数组中去的
@end

@implementation NSTimerManagerTestVC

- (void)dealloc{
    NSLog(@"%@",JobsLocalFunc);
    //    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)loadView{
    [super loadView];
    if ([self.requestParams isKindOfClass:UIViewModel.class]) {
        self.viewModel = (UIViewModel *)self.requestParams;
    }
    self.setupNavigationBarHidden = YES;
    
    self.viewModel.backBtnTitleModel.text = @"";
    self.viewModel.textModel.textCor = HEXCOLOR(0x3D4A58);
    self.viewModel.textModel.text = Internationalization(@"NSTimerManager模块测试");
    self.viewModel.textModel.font = notoSansBold(16);

    self.bgImage = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setGKNav];
    [self setGKNavBackBtn];
    
    [self test_masonry_horizontal_fixSpace];
    self.valueLab.alpha = 1;
    
    @jobs_weakify(self)
    /// 开始
    [self.btnMutArr[0] btnClickEventBlock:^(UIButton *data) {
        @jobs_strongify(self)
        [self reloadBtn:data];
        [self.nsTimerManager nsTimeStartSysAutoInRunLoop];
    }];
    /// 暂停
    [self.btnMutArr[1] btnClickEventBlock:^(UIButton *data) {
        @jobs_strongify(self)
        [self reloadBtn:data];
        [self.nsTimerManager nsTimePause];
    }];
    /// 继续
    [self.btnMutArr[2] btnClickEventBlock:^(UIButton *data) {
        @jobs_strongify(self)
        [self reloadBtn:data];
        [self.nsTimerManager nsTimecontinue];
    }];
    /// 结束
    [self.btnMutArr[3] btnClickEventBlock:^(UIButton *data) {
        @jobs_strongify(self)
        [self reloadBtn:data];
        [self.nsTimerManager nsTimeDestroy];
        self.nsTimerManager = nil;
        self.valueLab.text = @"";
    }];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}
#pragma mark —— 一些私有方法
-(void)reloadBtn:(UIButton *)button{
    for (UIButton *btn in self.btnMutArr) {
        btn.selected = NO;
    }
    button.selected = !button.selected;
}

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
#pragma mark —— LazyLoad
-(NSTimerManager *)nsTimerManager{
    if (!_nsTimerManager) {
        _nsTimerManager = NSTimerManager.new;
        /// 以下2种模式任选一种
        {/// 顺时针模式
            _nsTimerManager.timerStyle = TimerStyle_clockwise;
        }
        
//        {/// 逆时针模式
//            _nsTimerManager.timerStyle = TimerStyle_anticlockwise;
//            _nsTimerManager.anticlockwiseTime = 100;
//        }
        
        _nsTimerManager.timeInterval = .5f;
        @jobs_weakify(self)
        [_nsTimerManager actionObjectBlock:^(id data) {
            @jobs_strongify(self)
            if ([data isKindOfClass:TimerProcessModel.class]) {
                TimerProcessModel *model = (TimerProcessModel *)data;
                NSLog(@"❤️❤️❤️❤️❤️%f",model.data.anticlockwiseTime);
                self.valueLab.text = [NSString stringWithFormat:@"%.2f",model.data.anticlockwiseTime];
            }
        }];
    }return _nsTimerManager;
}

-(UILabel *)valueLab{
    if (!_valueLab) {
        _valueLab = UILabel.new;
        _valueLab.backgroundColor = HEXCOLOR(0xAE8330);
        [self.view addSubview:_valueLab];
        [_valueLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(JobsWidth(20));
            make.center.equalTo(self.view);
        }];
        [_valueLab makeLabelByShowingType:UILabelShowingType_03];
    }return _valueLab;
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
            [btn layerBorderColour:HEXCOLOR(0xAE8330) andBorderWidth:0.5f];
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

@end
