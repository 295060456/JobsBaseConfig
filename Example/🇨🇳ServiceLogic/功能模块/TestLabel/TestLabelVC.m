//
//  TestLabelVC.m
//  JobsBaseConfig
//
//  Created by Jobs on 2022/1/18.
//

#import "TestLabelVC.h"

@interface TestLabelVC ()
/// UILabel
@property(nonatomic,strong)BaseLabel *lab1;///【UILabelShowingType_01】 一行显示。定宽、定字体。多余部分用…表示（省略号的位置由NSLineBreakMode控制）
@property(nonatomic,strong)BaseLabel *lab2;///【UILabelShowingType_02】 一行显示。定宽、定字体。多余部分scrollerView ❤️集成@implementation UILabel (AutoScroll)❤️
@property(nonatomic,strong)BaseLabel *lab3;///【UILabelShowingType_03】 一行显示。定字体，不定宽。宽度自适应
@property(nonatomic,strong)BaseLabel *lab4;///【UILabelShowingType_04】 一行显示。缩小字体方式全展示
@property(nonatomic,strong)BaseLabel *lab5;///【UILabelShowingType_05】 多行显示，自动提行。定宽、定字体
@property(nonatomic,strong)BaseLabel *lab6;///【UILabelShowingType_05】 多行显示，手动\n提行。定宽、定字体
/// UIButton
@property(nonatomic,strong)BaseButton *btn1;///【UILabelShowingType_01】 一行显示。定宽、定字体。多余部分用…表示（省略号的位置由NSLineBreakMode控制）
@property(nonatomic,strong)BaseButton *btn2;///【UILabelShowingType_02】 一行显示。定宽、定字体。多余部分scrollerView ❤️集成@implementation UILabel (AutoScroll)❤️
@property(nonatomic,strong)BaseButton *btn3;///【UILabelShowingType_03】 一行显示。定字体，不定宽。宽度自适应
@property(nonatomic,strong)BaseButton *btn4;///【UILabelShowingType_04】 一行显示。缩小字体方式全展示
@property(nonatomic,strong)BaseButton *btn5;///【UILabelShowingType_05】 多行显示，自动提行。定宽、定字体
@property(nonatomic,strong)BaseButton *btn6;///【UILabelShowingType_05】 多行显示，手动\n提行。定宽、定字体

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
    
    [self.lab1 makeLabelByShowingType:UILabelShowingType_01];
    [self.lab2 makeLabelByShowingType:UILabelShowingType_02];
    [self.lab3 makeLabelByShowingType:UILabelShowingType_03];
    [self.lab4 makeLabelByShowingType:UILabelShowingType_04];
    [self.lab5 makeLabelByShowingType:UILabelShowingType_05];
    [self.lab6 makeLabelByShowingType:UILabelShowingType_05];
    
    [self.btn1 makeBtnLabelByShowingType:UILabelShowingType_01];
    [self.btn2 makeBtnLabelByShowingType:UILabelShowingType_02];
    [self.btn3 makeBtnLabelByShowingType:UILabelShowingType_03];
    [self.btn4 makeBtnLabelByShowingType:UILabelShowingType_04];
    [self.btn5 makeBtnLabelByShowingType:UILabelShowingType_05];
    [self.btn6 makeBtnLabelByShowingType:UILabelShowingType_05];
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
#pragma mark —— BaseLabel
/// 一行显示。定宽、定高、定字体。多余部分用…表示（省略号的位置由NSLineBreakMode控制）
-(BaseLabel *)lab1{
    if (!_lab1) {
        _lab1 = BaseLabel.new;
        _lab1.backgroundColor = UIColor.redColor;
        _lab1.text = @"编译器自动管理内存地址，让程序员更加专注于APP的业务。";
        [self.view addSubview:_lab1];
        [_lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(100, 20));
            make.top.equalTo(self.gk_navigationBar.mas_bottom).offset(20);
            make.centerX.equalTo(self.view);
        }];
    }return _lab1;
}
/// 一行显示。定宽、定高、定字体。多余部分scrollerView ❤️集成@implementation UILabel (AutoScroll)❤️
-(BaseLabel *)lab2{
    if (!_lab2) {
        _lab2 = BaseLabel.new;
        _lab2.backgroundColor = UIColor.redColor;
        _lab2.text = @"编译器自动管理内存地址，让程序员更加专注于APP的业务。";
        [self.view addSubview:_lab2];
        [_lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(100, 20));
            make.top.equalTo(self.lab1.mas_bottom).offset(20);
            make.centerX.equalTo(self.view);
        }];
    }return _lab2;
}
/// 一行显示。不定宽、定高、定字体。宽度自适应
-(BaseLabel *)lab3{
    if (!_lab3) {
        _lab3 = BaseLabel.new;
        _lab3.backgroundColor = UIColor.redColor;
        _lab3.text = @"编译器自动管理内存地址，让程序员更加专注于APP的业务。";
        [self.view addSubview:_lab3];
        [_lab3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(20);
            make.top.equalTo(self.lab2.mas_bottom).offset(20);
            make.centerX.equalTo(self.view);
        }];
    }return _lab3;
}
/// 一行显示。定宽、定高。缩小字体方式全展示
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
/// 多行显示。定宽、不定高、定字体
-(BaseLabel *)lab5{
    if (!_lab5) {
        _lab5 = BaseLabel.new;
        _lab5.backgroundColor = UIColor.redColor;
        _lab5.text = @"编译器自动管理内存地址，让程序员更加专注于APP的业务。";
        [self.view addSubview:_lab5];
        [_lab5 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(100);
            make.top.equalTo(self.lab4.mas_bottom).offset(20);
            make.centerX.equalTo(self.view);
        }];
    }return _lab5;
}
/// 多行显示，手动\n提行。定宽（宽要足够长，否则就面临自动提行）、定字体
-(BaseLabel *)lab6{
    if (!_lab6) {
        _lab6 = BaseLabel.new;
        _lab6.backgroundColor = UIColor.redColor;
        _lab6.text = @"编译器自动管理内存地址，\n让程序员更加专注于\nAPP的业务。";
        [self.view addSubview:_lab6];
        [_lab6 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(JobsMainScreen_WIDTH());
            make.top.equalTo(self.lab5.mas_bottom).offset(20);
            make.centerX.equalTo(self.view);
        }];
    }return _lab6;
}
#pragma mark —— BaseButton
/// 一行显示。定宽、定高、定字体。多余部分用…表示（省略号的位置由NSLineBreakMode控制）
-(BaseButton *)btn1{
    if (!_btn1) {
        _btn1 = BaseButton.new;
        _btn1.backgroundColor = UIColor.brownColor;
        [_btn1 normalTitle:@"编译器自动管理内存地址，让程序员更加专注于APP的业务。"];
        [self.view addSubview:_btn1];
        [_btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(100, 20));
            make.top.equalTo(self.lab6.mas_bottom).offset(20);
            make.centerX.equalTo(self.view);
        }];
    }return _btn1;
}
/// 一行显示。定宽、定高、定字体。多余部分scrollerView ❤️集成@implementation UILabel (AutoScroll)❤️
-(BaseButton *)btn2{
    if (!_btn2) {
        _btn2 = BaseButton.new;
        _btn2.backgroundColor = UIColor.brownColor;
        [_btn2 normalTitle:@"编译器自动管理内存地址，让程序员更加专注于APP的业务。"];
        [self.view addSubview:_btn2];
        [_btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(100, 20));
            make.top.equalTo(self.btn1.mas_bottom).offset(20);
            make.centerX.equalTo(self.view);
        }];
    }return _btn2;
}
/// 一行显示。不定宽、定高、定字体。宽度自适应
-(BaseButton *)btn3{
    if (!_btn3) {
        _btn3 = BaseButton.new;
        _btn3.backgroundColor = UIColor.brownColor;
        [_btn3 normalTitle:@"编译器自动管理内存地址，让程序员更加专注于APP的业务。"];
        [self.view addSubview:_btn3];
        [_btn3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(100, 20));
            make.top.equalTo(self.btn2.mas_bottom).offset(20);
            make.centerX.equalTo(self.view);
        }];
    }return _btn3;
}
/// 一行显示。定宽、定高。缩小字体方式全展示
-(BaseButton *)btn4{
    if (!_btn4) {
        _btn4 = BaseButton.new;
        _btn4.backgroundColor = UIColor.brownColor;
        [_btn4 normalTitle:@"编译器自动管理内存地址，让程序员更加专注于APP的业务。"];
        [self.view addSubview:_btn4];
        [_btn4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(100, 20));
            make.top.equalTo(self.btn3.mas_bottom).offset(20);
            make.centerX.equalTo(self.view);
        }];
    }return _btn4;
}
/// 多行显示。定宽、不定高、定字体
-(BaseButton *)btn5{
    if (!_btn5) {
        _btn5 = BaseButton.new;
        _btn5.backgroundColor = UIColor.brownColor;
        [_btn5 normalTitle:@"编译器自动管理内存地址，让程序员更加专注于APP的业务。"];
        _btn5.titleLabel.numberOfLines = 0;
        [_btn5 labelAutoWidthByFont];
        [self.view addSubview:_btn5];
        [_btn5 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(100, 20));
            make.top.equalTo(self.btn4.mas_bottom).offset(20);
            make.centerX.equalTo(self.view);
        }];
    }return _btn5;
}
/// 多行显示，手动\n提行。定宽（宽要足够长，否则就面临自动提行）、定字体
-(BaseButton *)btn6{
    if (!_btn6) {
        _btn6 = BaseButton.new;
        _btn6.backgroundColor = UIColor.brownColor;
        [_btn6 normalTitle:@"编译器自动管理内存地址，\n让程序员更加专注于\nAPP的业务。"];
        _btn6.titleLabel.numberOfLines = 0;
        [_btn6 labelAutoWidthByFont];
        [self.view addSubview:_btn6];
        [_btn6 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(JobsMainScreen_WIDTH(), 20));
            make.top.equalTo(self.btn5.mas_bottom).offset(20);
            make.centerX.equalTo(self.view);
        }];
    }return _btn6;
}

@end
