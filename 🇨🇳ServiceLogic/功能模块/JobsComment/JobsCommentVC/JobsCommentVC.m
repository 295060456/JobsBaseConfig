//
//  JobsCommentVC.m
//  JobsBaseConfig
//
//  Created by Jobs on 2022/1/10.
//

#import "JobsCommentVC.h"

@interface JobsCommentVC (){
    JobsCommentCoreVC *jobsCommentCoreVC;
    PopUpVC *popUpVC;
}

@property(nonatomic,strong)UIButton *contactCustomerServiceBtn;// 联系客服按钮

@end

@implementation JobsCommentVC

- (void)dealloc{
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
    //    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)loadView{
    [super loadView];
    
    if ([self.requestParams isKindOfClass:UIViewModel.class]) {
        self.viewModel = (UIViewModel *)self.requestParams;
    }
    
    //    {// 外界推得时候这么写
    //        [self comingToPushVC:CasinoOpenAccountVC.new
    //                withNavTitle:Internationalization(@"Open an account")];
    //    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.setupNavigationBarHidden = YES;
    [self setGKNav];
    
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
    jobsCommentCoreVC = JobsCommentCoreVC.new;
//        @weakify(self)
    [jobsCommentCoreVC actionViewBlock:^(id data) {
//            @strongify(self)
        NSLog(@"您点击了关注");
    }];

    [self comingToPushVC:jobsCommentCoreVC
           requestParams:@""];
}
#pragma mark —— lazyLoad
-(UIButton *)contactCustomerServiceBtn{
    if (!_contactCustomerServiceBtn) {
        _contactCustomerServiceBtn = UIButton.new;
        [_contactCustomerServiceBtn normalImage:KIMG(Internationalization(@"zaixiankefu_en"))];
        [_contactCustomerServiceBtn selectedImage:KIMG(Internationalization(@"zaixiankefu_en"))];
        BtnClickEvent(_contactCustomerServiceBtn, {
            [self makeJobsCommentCoreVC];
        });
        [self.view addSubview:_contactCustomerServiceBtn];
        [_contactCustomerServiceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(JobsWidth(230), JobsWidth(50)));
            make.center.equalTo(self.view);
        }];
    }return _contactCustomerServiceBtn;
}

@end
