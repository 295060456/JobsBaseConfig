//
//  AutoScrollLabelTestVC.m
//  JobsBaseConfig
//
//  Created by Jobs on 2022/1/17.
//

#import "AutoScrollLabelTestVC.h"

@interface AutoScrollLabelTestVC ()

@property(nonatomic,strong)UILabel *label;

@end

@implementation AutoScrollLabelTestVC

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
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.label.alpha = 1;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}
#pragma mark —— lazyLoad
-(UILabel *)label{
    if (!_label) {
        _label = UILabel.new;
        _label.text = @"1234567890-0987654321";
        _label.textColor = UIColor.blackColor;
        [self.view addSubview:_label];
        [_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(80, 50));
            make.center.equalTo(self.view);
        }];
    }return _label;
}

@end
