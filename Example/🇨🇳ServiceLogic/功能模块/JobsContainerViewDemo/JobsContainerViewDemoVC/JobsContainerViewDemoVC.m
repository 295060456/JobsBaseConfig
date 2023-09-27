//
//  JobsContainerViewDemoVC.m
//  JobsBaseConfig
//
//  Created by Jobs Hi on 9/21/23.
//

#import "JobsContainerViewDemoVC.h"

@interface JobsContainerViewDemoVC ()
/// UI
@property(nonatomic,strong)JobsContainerView *containerView;
/// Data
@property(nonatomic,strong)NSMutableArray <JobsBtnModel *>*btnModelMutArr;

@end

@implementation JobsContainerViewDemoVC

- (void)dealloc{
    [NSNotificationCenter.defaultCenter removeObserver:self];
    NSLog(@"%@",JobsLocalFunc);
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
    
    self.view.backgroundColor = JobsRandomColor;
    [self setGKNav];
    [self setGKNavBackBtn];
    self.gk_navigationBar.jobsVisible = YES;
    
    self.containerView.alpha = 1;
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

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}
#pragma mark —— lazyLoad
-(JobsContainerView *)containerView{
    if(!_containerView){
        _containerView = [JobsContainerView.alloc initWithWidth:JobsWidth(200)
                                                     buttonModels:self.btnModelMutArr];
        _containerView.backgroundColor = UIColor.purpleColor;
        [self.view addSubview:_containerView];
        [_containerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(_containerView.jobsSize);
            make.center.equalTo(self.view);
        }];
    }return _containerView;
}

-(NSMutableArray<JobsBtnModel *> *)btnModelMutArr{
    if(!_btnModelMutArr){
        _btnModelMutArr = NSMutableArray.array;
        {
            JobsBtnModel *model = JobsBtnModel.new;
            model.backgroundColor = UIColor.yellowColor;
//            model.backgroundImage = JobsIMG(@"手机号码");
            model.normalTitle = Internationalization(@"普通的.普通的.普通的.普通的.普通的.普通的.");
            model.titleFont = UIFontWeightRegularSize(12);
            model.normalTitleColor = UIColor.blueColor;
            model.image = JobsIMG(@"手机号码");
            model.imageSize = CGSizeMake(JobsWidth(50), JobsWidth(80));
            model.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
            model.contentSpacing = JobsWidth(8);
            model.lineBreakMode = NSLineBreakByWordWrapping;
            model.btnWidth = JobsWidth(200);

            [_btnModelMutArr addObject:model];
        }
//
        {
            JobsBtnModel *model = JobsBtnModel.new;
            model.backgroundColor = UIColor.grayColor;
//            model.backgroundImage = JobsIMG(@"手机号码");
            model.normalTitle = Internationalization(@"我不换行.我不换行.我不换行.我不换行.");
            model.titleFont = UIFontWeightRegularSize(12);
            model.normalTitleColor = UIColor.redColor;
            model.image = JobsIMG(@"手机号码");
            model.imageSize = CGSizeMake(JobsWidth(50), JobsWidth(80));
            model.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
            model.contentSpacing = JobsWidth(2);
            model.lineBreakMode = NSLineBreakByWordWrapping;
            model.btnWidth = JobsWidth(200);

            [_btnModelMutArr addObject:model];
        }
        
        {
            JobsBtnModel *model = JobsBtnModel.new;
            model.backgroundColor = UIColor.yellowColor;
//            model.backgroundImage = JobsIMG(@"手机号码");
            model.normalTitle = Internationalization(@"我要换行.我要换行.我要换行.我要换行.我要换行.我要换行.我要换行.我要换行.");
            model.titleFont = UIFontWeightRegularSize(12);
            model.normalTitleColor = UIColor.greenColor;
            model.image = JobsIMG(@"手机号码");
            model.imageSize = CGSizeMake(JobsWidth(50), JobsWidth(80));
            model.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
            model.contentSpacing = JobsWidth(8);
            model.lineBreakMode = NSLineBreakByWordWrapping;
            model.btnWidth = JobsWidth(200);

            [_btnModelMutArr addObject:model];
        }
        
    }return _btnModelMutArr;
}

@end
