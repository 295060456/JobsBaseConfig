//
//  RandomTestVC.m
//  JobsBaseConfig
//
//  Created by Jobs on 2022/6/20.
//

#import "RandomTestVC.h"

@interface RandomTestVC ()

@end

@implementation RandomTestVC

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
    self.viewModel.textModel.text = Internationalization(@"随机数测试模块点击屏幕进行测试");
    self.viewModel.textModel.font = notoSansBold(16);

    self.bgImage = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setGKNav];
    [self setGKNavBackBtn];
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
#pragma mark —— 复写父类方法
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    int e = baseRandomNOContainBorderValue(20);/// 获取一个随机整数范围在【0、borderValue）： 包括0、不包括borderValu
    int r = baseRandomContainBorderValue(30);/// 获取一个随机整数范围在【0、borderValue】： 包括0、包括borderValue
    int t = baseRandomOffsetValueWithNoContainborderValue(4, 9);/// 获取一个随机整数范围在【offsetValue、borderValue）： 包括offsetValue、不包括borderValue
    int f = baseRandomOffsetValueWithContainborderValue(4,9);/// 获取一个随机整数范围在【offsetValue、borderValue】： 包括offsetValue、包括borderValu
    int h = getRandomNumber(2, 9);/// 获取一个随机整数，范围在【from、to】：包括from，包括to
    int x = randomXY(3, 7);/// 用rand()随机生成在[x,y]内的整数。rand()%a的结果最大为a-1
    int a = random0_100();/// 示例：获取一个随机整数范围在【0、100）： 包括0、不包括100
    int s = random0__100();/// 示例：获取一个随机整数范围在【0、100】： 包括0、包括100
    int l = random100_200();/// 示例：获取一个随机数范围在：【100、200），包括100，不包括200
    int j = random100__200();/// 示例：获取一个随机数范围在：【100、200】，包括100，包括200
    
    NSLog(@"%d",f);
}
#pragma mark —— LazyLoad

@end
