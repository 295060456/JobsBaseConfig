//
//  TransparentRegionVC.m
//  JobsBaseConfig
//
//  Created by Jobs on 2022/1/8.
//

#import "TransparentRegionVC.h"

@interface TransparentRegionVC ()

@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)UILabel *lab;

@end

@implementation TransparentRegionVC

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
    
    self.scrollView.alpha = 1;
    self.lab.alpha = 1;
    [self addArc];
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
#pragma mark —— 一些私有方法
- (void)addArc {
    //中间镂空的矩形框
    CGRect myRect =CGRectMake(100,100,200,200);

    //背景
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:[UIScreen mainScreen].bounds cornerRadius:0];
    //镂空
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithOvalInRect:myRect];
    [path appendPath:circlePath];
    [path setUsesEvenOddFillRule:YES];

    CAShapeLayer *fillLayer = [CAShapeLayer layer];
    fillLayer.path = path.CGPath;
    fillLayer.fillRule = kCAFillRuleEvenOdd;
    fillLayer.fillColor = [UIColor whiteColor].CGColor;
    fillLayer.opacity = 0.5;
    [self.view.layer addSublayer:fillLayer];
}
#pragma mark —— lazyLoad
-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = UIScrollView.new;
        _scrollView.backgroundColor = [UIColor redColor];
        _scrollView.contentSize = CGSizeMake(JobsMainScreen_WIDTH(), JobsMainScreen_HEIGHT() * 2);
        [self.view addSubview:_scrollView];
        [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.bottom.equalTo(self.view);
        }];
    }return _scrollView;
}

-(UILabel *)lab{
    if (!_lab) {
        _lab = UILabel.new;
        _lab.backgroundColor = [UIColor blueColor];
        _lab.frame = CGRectMake(100, 300, 100, 100);
        [self.scrollView addSubview:_lab];
    }return _lab;;
}



@end
