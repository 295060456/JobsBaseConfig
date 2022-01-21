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
/// Data
@property(nonatomic,strong)ButtonTimerConfigModel *btnTimerConfigModel;

@end

@implementation JobsTimerVC

- (void)dealloc{
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
    //    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)loadView{
    [super loadView];
    
    if ([self.requestParams isKindOfClass:UIViewModel.class]) {
        self.viewModel = (UIViewModel *)self.requestParams;
    }
    self.setupNavigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = KMagentaColor;
    [self setGKNav];
    [self setGKNavBackBtn];
    
    self.countDownBtn.alpha = 1;
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
#pragma mark —— lazyLoad
-(UIButton *)countDownBtn{
    if (!_countDownBtn) {
        _countDownBtn = [UIButton.alloc initWithConfig:self.btnTimerConfigModel];
        
        BtnClickEvent(_countDownBtn, {
            [x startTimer];//选择时机、触发启动
            NSLog(@"🪓🪓🪓🪓🪓 = 获取验证码");
        })
        
        [_countDownBtn actionBlockTimerRunning:^(TimerProcessModel *data) {
            @jobs_strongify(self)
            NSLog(@"❤️❤️❤️❤️❤️%f",data.data.anticlockwiseTime);
        }];

        [self.view addSubview:_countDownBtn];
        [_countDownBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(JobsWidth(80), JobsWidth(25)));
            make.center.equalTo(self.view);
        }];
        
    }return _countDownBtn;
}

-(ButtonTimerConfigModel *)btnTimerConfigModel{
    if (!_btnTimerConfigModel) {
        _btnTimerConfigModel = ButtonTimerConfigModel.new;
        
        /// 一些通用的设置
        _btnTimerConfigModel.count = 5;
        _btnTimerConfigModel.showTimeType = ShowTimeType_SS;//时间显示风格
        _btnTimerConfigModel.countDownBtnType = TimerStyle_anticlockwise;// 时间方向
        _btnTimerConfigModel.cequenceForShowTitleRuningStrType = CequenceForShowTitleRuningStrType_tail;//
        _btnTimerConfigModel.labelShowingType = UILabelShowingType_03;//【换行模式】
        
        /// 计时器未开始【静态值】
        _btnTimerConfigModel.readyPlayValue.layerBorderWidth = 1;
        _btnTimerConfigModel.readyPlayValue.layerCornerRadius = JobsWidth(25 / 2);
        _btnTimerConfigModel.readyPlayValue.bgCor = UIColor.yellowColor;
        _btnTimerConfigModel.readyPlayValue.layerBorderColour = UIColor.brownColor;
        _btnTimerConfigModel.readyPlayValue.textCor = UIColor.blueColor;
        _btnTimerConfigModel.readyPlayValue.text = Title9;
        _btnTimerConfigModel.readyPlayValue.font = [UIFont systemFontOfSize:JobsWidth(13)
                                                                               weight:UIFontWeightMedium];
        /// 计时器进行中【动态值】
        _btnTimerConfigModel.runningValue.bgCor = UIColor.cyanColor;
        _btnTimerConfigModel.runningValue.text = Internationalization(Title12);
        _btnTimerConfigModel.runningValue.layerBorderColour = UIColor.redColor;
        _btnTimerConfigModel.runningValue.textCor = UIColor.blackColor;
        /// 计时器结束【静态值】
        _btnTimerConfigModel.endValue.bgCor = UIColor.yellowColor;;
        _btnTimerConfigModel.endValue.text = Internationalization(@"哈哈哈哈");
        _btnTimerConfigModel.endValue.layerBorderColour = UIColor.purpleColor;
        _btnTimerConfigModel.endValue.textCor = UIColor.blackColor;
        
    }return _btnTimerConfigModel;
}

@end
