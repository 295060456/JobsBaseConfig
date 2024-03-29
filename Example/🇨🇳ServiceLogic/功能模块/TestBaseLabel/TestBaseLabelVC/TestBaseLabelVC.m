//
//  TestBaseLabelVC.m
//  JobsBaseConfig
//
//  Created by Jobs on 2022/6/20.
//

#import "TestBaseLabelVC.h"

@interface TestBaseLabelVC ()
/// UI
@property(nonatomic,strong)JobsBaseLabel *titleLab;
@property(nonatomic,strong)BaseLabel *baseLabel;

@end

@implementation TestBaseLabelVC

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
    
    {
        self.viewModel.backBtnTitleModel.text = Internationalization(@"返回");
        self.viewModel.textModel.textCor = HEXCOLOR(0x3D4A58);
        self.viewModel.textModel.text = Internationalization(@"TestBaseLabel");
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
    
    [self setGKNav];
    [self setGKNavBackBtn];
    
    self.titleLab.alpha = 1;
    self.baseLabel.alpha = 1;
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
#pragma mark —— LazyLoad
-(JobsBaseLabel *)titleLab{
    if (!_titleLab) {
        _titleLab = JobsBaseLabel.new;
        [_titleLab richElementsInViewWithModel:nil];
        _titleLab.getLabel.jobsOffsetY = JobsWidth(-2);
        _titleLab.getLabel.textColor = UIColor.whiteColor;
        _titleLab.getLabel.font = notoSansRegular(12);
        _titleLab.getLabel.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(JobsWidth(100));
            make.left.equalTo(self.view).offset(JobsWidth(100));
            make.height.mas_equalTo(JobsWidth(26));
        }];

        [_titleLab.getLabel actionReturnIDByGestureRecognizerBlock:^id(UIGestureRecognizer *data) {
            NSLog(@"JobsBaseLabel的Tap手势");
            return @1;
        }];
        
        [_titleLab.getLabel actionReturnIDByGestureRecognizerBlock:^id(UIGestureRecognizer *data) {
            NSLog(@"JobsBaseLabel的LongPress手势");
            return @1;
        }];
    }
    _titleLab.getLabel.text = Internationalization(@" 真人           ");
    _titleLab.getBgImageView.image = JobsIMG(@"优惠活动背景图_真人");
    
    [_titleLab.getLabel makeLabelByShowingType:UILabelShowingType_03];
    [_titleLab.getLabel appointCornerCutToCircleByRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(JobsWidth(8), JobsWidth(8))];
    return _titleLab;
}

-(BaseLabel *)baseLabel{
    if (!_baseLabel) {
        _baseLabel = BaseLabel.new;
        _baseLabel.jobsOffsetX = JobsWidth(10);
        _baseLabel.text = Internationalization(@"测试 -BaseLabel-");
        _baseLabel.backgroundColor = JobsCyanColor;
        [self.view addSubview:_baseLabel];
        [_baseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLab.mas_bottom).offset(JobsWidth(20));
            make.left.equalTo(self.view).offset(JobsWidth(100));
            make.height.mas_equalTo(JobsWidth(26));
        }];
        
        [_baseLabel actionReturnIDByGestureRecognizerBlock:^id(UIGestureRecognizer *data) {
            NSLog(@"BaseLabel的Tap手势");
            return @1;
        }];
        
        [_baseLabel actionReturnIDByGestureRecognizerBlock:^id(UIGestureRecognizer *data) {
            NSLog(@"BaseLabel的LongPress手势");
            return @1;
        }];
        
    }return _baseLabel;
}


@end
