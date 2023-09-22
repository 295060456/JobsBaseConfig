//
//  JobsCommentVC.m
//  JobsBaseConfig
//
//  Created by Jobs on 2022/1/10.
//

#import "JobsCommentVC.h"

@interface JobsCommentVC ()

@property(nonatomic,strong)UIButton *contactCustomerServiceBtn;// 联系客服按钮

@end

@implementation JobsCommentVC

- (void)dealloc{
    NSLog(@"%@",JobsLocalFunc);
    //    [NSNotificationCenter.defaultCenter removeObserver:self];
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
    
    [self setGKNav];
    [self setGKNavBackBtn];
    
    self.contactCustomerServiceBtn.alpha = 1;
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
-(void)makeJobsCommentCoreVC{    //触发
    JobsCommentCoreVC *jobsCommentCoreVC = JobsCommentCoreVC.new;
//        @jobs_weakify(self)
    [jobsCommentCoreVC actionObjectBlock:^(id data) {
//            @jobs_strongify(self)
        NSLog(@"您点击了关注");
    }];

    [self comingToPresentVC:jobsCommentCoreVC
              requestParams:@""];
}
#pragma mark —— lazyLoad
-(UIButton *)contactCustomerServiceBtn{
    if (!_contactCustomerServiceBtn) {
        _contactCustomerServiceBtn = UIButton.new;
        _contactCustomerServiceBtn.normalImage = JobsIMG(Internationalization(@"zaixiankefu_en"));
        _contactCustomerServiceBtn.selectedImage = JobsIMG(Internationalization(@"zaixiankefu_en"));
        @jobs_weakify(self)
        [_contactCustomerServiceBtn jobsBtnClickEventBlock:^(UIButton *x) {
            @jobs_strongify(self)
            [self makeJobsCommentCoreVC];
        }];
        [self.view addSubview:_contactCustomerServiceBtn];
        [_contactCustomerServiceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(JobsWidth(230), JobsWidth(50)));
            make.center.equalTo(self.view);
        }];
    }return _contactCustomerServiceBtn;
}

@end
