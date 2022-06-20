//
//  JobsProgressVC.m
//  JobsBaseConfig
//
//  Created by Jobs on 2022/1/8.
//

#import "JobsProgressVC.h"

@interface JobsProgressVC ()

@property(nonatomic,strong)PHCycleView *progressView;

@end

@implementation JobsProgressVC

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
    self.view.backgroundColor = JobsYellowColor;
    
    [self setGKNav];
    [self setGKNavBackBtn];
    
    self.progressView.alpha = 1;
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
-(PHCycleView *)progressView{
    if (!_progressView) {
        _progressView = [[PHCycleView alloc]initWithFrame:CGRectMake(0, 0, 130, 130)];
        _progressView.center = self.view.center;
        _progressView.backgroundColor = [UIColor clearColor];
        [_progressView setProgressColor:[UIColor blueColor]];
        _progressView.progressFont = [UIFont systemFontOfSize:30];
        [self.view addSubview:_progressView];
        [_progressView updateProgress:50];
        [_progressView setLinePreAngle:15 lineSize:CGSizeMake(3, 10) color:[UIColor redColor]];
        _progressView.describeFont = [UIFont systemFontOfSize:12];
        _progressView.describeStr = @"历史最高分";
        _progressView.progressTextColor = [UIColor blackColor];
        _progressView.describeTextColor = [UIColor blackColor];
        _progressView.outLayerColor = [UIColor colorWithRed:0 green:0 blue:255 alpha:0.3];
    }return _progressView;
}

@end
