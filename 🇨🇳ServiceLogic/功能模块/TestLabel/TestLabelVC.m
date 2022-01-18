//
//  TestLabelVC.m
//  JobsBaseConfig
//
//  Created by Jobs on 2022/1/18.
//

#import "TestLabelVC.h"

@interface TestLabelVC ()

@property(nonatomic,strong)BaseLabel *lab1;///【UILabelShowingType_01】 一行显示。定宽、定字体。多余部分用…表示（省略号的位置由NSLineBreakMode控制）
@property(nonatomic,strong)BaseLabel *lab2;///【UILabelShowingType_02】 一行显示。定宽、定字体。多余部分scrollerView ❤️集成@implementation UILabel (AutoScroll)❤️
@property(nonatomic,strong)BaseLabel *lab3;///【UILabelShowingType_03】 一行显示。定字体，不定宽。宽度自适应
@property(nonatomic,strong)BaseLabel *lab4;///【UILabelShowingType_04】 一行显示。缩小字体方式全展示
@property(nonatomic,strong)BaseLabel *lab5;///【UILabelShowingType_05】 多行显示。定宽、定字体

@end

@implementation TestLabelVC

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
    self.view.backgroundColor = KYellowColor;
    [self setGKNav];
    [self setGKNavBackBtn];
    
//    self.lab1.alpha = 1;
//    self.lab2.alpha = 1;
//    self.lab3.alpha = 1;
//    self.lab4.alpha = 1;
//    self.lab5.alpha = 1;
    
    [self.lab1 makeLabelByShowingType:UILabelShowingType_01];
    [self.lab2 makeLabelByShowingType:UILabelShowingType_02];
    [self.lab3 makeLabelByShowingType:UILabelShowingType_03];
    [self.lab4 makeLabelByShowingType:UILabelShowingType_04];
    [self.lab5 makeLabelByShowingType:UILabelShowingType_05];

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
/// 多余部分用…表示
-(BaseLabel *)lab1{
    if (!_lab1) {
        _lab1 = BaseLabel.new;
        _lab1.backgroundColor = UIColor.redColor;
        _lab1.text = @"编译器自动管理内存地址，让程序员更加专注于APP的业务。";
        [self.view addSubview:_lab1];
        [_lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(100, 20));
            make.top.equalTo(self.gk_navigationBar.mas_bottom).offset(50);
            make.centerX.equalTo(self.view);
        }];
    }return _lab1;
}
/// 多余部分scrollerView ❤️集成@implementation UILabel (AutoScroll)❤️
-(BaseLabel *)lab2{
    if (!_lab2) {
        _lab2 = BaseLabel.new;
        _lab2.backgroundColor = UIColor.redColor;
        _lab2.text = @"qqqqqqqwwwwweeeee";
        [self.view addSubview:_lab2];
        [_lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(100, 20));
            make.top.equalTo(self.lab1.mas_bottom).offset(20);
            make.centerX.equalTo(self.view);
        }];
    }return _lab2;
}
/// 定高，宽度自适应
-(BaseLabel *)lab3{
    if (!_lab3) {
        _lab3 = BaseLabel.new;
        _lab3.backgroundColor = UIColor.redColor;
        _lab3.text = @"编译器自动管理内存地址，让程序员更加专注于APP的业务。";
        [self.view addSubview:_lab3];
        [_lab3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(100, 20));
            make.top.equalTo(self.lab2.mas_bottom).offset(20);
            make.centerX.equalTo(self.view);
        }];
    }return _lab3;
}
/// 缩小字体方式全展示
-(BaseLabel *)lab4{
    if (!_lab4) {
        _lab4 = BaseLabel.new;
        _lab4.backgroundColor = UIColor.redColor;
        _lab4.text = @"编译器自动管理内存地址，让程序员更加专注于APP的业务。";
        [self.view addSubview:_lab4];
        [_lab4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(100, 20));
            make.top.equalTo(self.lab3.mas_bottom).offset(20);
            make.centerX.equalTo(self.view);
        }];
    }return _lab4;
}
/// 定宽，多行显示
-(BaseLabel *)lab5{
    if (!_lab5) {
        _lab5 = BaseLabel.new;
        _lab5.backgroundColor = UIColor.redColor;
        _lab5.text = @"编译器自动管理内存地址，让程序员更加专注于APP的业务。";
        [self.view addSubview:_lab5];
        [_lab5 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(100, 20));
            make.top.equalTo(self.lab4.mas_bottom).offset(20);
            make.centerX.equalTo(self.view);
        }];
    }return _lab5;
}

@end
