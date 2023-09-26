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
    
    {
        self.viewModel.backBtnTitleModel.text = Internationalization(@"返回");
        self.viewModel.textModel.textCor = HEXCOLOR(0x3D4A58);
    //    self.viewModel.textModel.text = Internationalization(@"消息详情页");
        self.viewModel.textModel.font = UIFontWeightRegularSize(16);
        
        // 使用原则：底图有 + 底色有 = 优先使用底图数据
        // 以下2个属性的设置，涉及到的UI结论 请参阅父类（BaseViewController）的私有方法：-(void)setBackGround
        // self.viewModel.bgImage = JobsIMG(@"内部招聘导航栏背景图");/// self.gk_navBackgroundImage 和 self.bgImageView
        self.viewModel.bgCor = RGBA_COLOR(255, 238, 221, 1);/// self.gk_navBackgroundColor 和 self.view.backgroundColor
    //    self.viewModel.bgImage = JobsIMG(@"新首页的底图");
    }
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
            model.title = Internationalization(@"普通的.普通的.普通的.普通的.普通的.普通的.");
            model.font = UIFontWeightRegularSize(12);
            model.titleColor = UIColor.blueColor;
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
            model.title = Internationalization(@"我不换行.我不换行.我不换行.我不换行.");
            model.font = UIFontWeightRegularSize(12);
            model.titleColor = UIColor.redColor;
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
            model.title = Internationalization(@"我要换行.我要换行.我要换行.我要换行.我要换行.我要换行.我要换行.我要换行.");
            model.font = UIFontWeightRegularSize(12);
            model.titleColor = UIColor.greenColor;
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
