//
//  BaiShaETProjChoiceStadiumView.m
//  BaiShaEntertainmentProj
//
//  Created by Jobs on 2022/6/9.
//

#import "BaiShaETProjChoiceStadiumView.h"

@interface BaiShaETProjChoiceStadiumTBVHeaderView : BaseLabel

@property(nonatomic,strong)UIColor *cor;

@end

@implementation BaiShaETProjChoiceStadiumTBVHeaderView

-(instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = self.cor;
    }return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = self.cor;
    }return self;
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
}

-(void)layoutSubviews{
    [super layoutSubviews];
}
#pragma mark —— BaseViewProtocol
/// 具体由子类进行复写【数据尺寸】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
+(CGSize)viewSizeWithModel:(UIViewModel *_Nullable)model{
    return CGSizeMake(JobsMainScreen_WIDTH(),JobsWidth(46));
}
#pragma mark —— lazyLoad
-(UIColor *)cor{
    if (!_cor) {
        _cor = [UIColor colorWithPatternImage:JobsIMG(@"选择场馆上拉列表背景")];// 用@2x@3x会有偏移异常
        /// 👇🏻下面有偏移
//        [UIColor gradientCorDataMutArr:[NSMutableArray arrayWithArray:@[HEXCOLOR(0xF2CD7A),HEXCOLOR(0xFFEABA)]]
//                            startPoint:CGPointMake(100, 100)
//                              endPoint:CGPointZero
//                                opaque:NO
//                        targetViewRect:CGRectMake(0,
//                                                  0,
//                                                  JobsMainScreen_WIDTH(),
//                                                  JobsWidth(46))];
    }return _cor;
}

@end

@interface BaiShaETProjChoiceStadiumView ()
/// UI
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)BaiShaETProjChoiceStadiumTBVHeaderView *tbvHeaderView;
/// Data
@property(nonatomic,strong)NSMutableArray <UIViewModel *>*dataMutArr;
@property(nonatomic,strong)NSMutableArray <BaseTableViewCell *>*tbvCellMutArr;

@end

@implementation BaiShaETProjChoiceStadiumView

@synthesize viewModel = _viewModel;

#pragma mark —— BaseProtocol
/// 单例化和销毁
+(void)destroySingleton{
    static_choiceStadiumViewOnceToken = 0;
    static_choiceStadiumView = nil;
}

static BaiShaETProjChoiceStadiumView *static_choiceStadiumView = nil;
static dispatch_once_t static_choiceStadiumViewOnceToken;
+(instancetype)sharedInstance{
    dispatch_once(&static_choiceStadiumViewOnceToken, ^{
        static_choiceStadiumView = BaiShaETProjChoiceStadiumView.new;
    });return static_choiceStadiumView;
}

-(instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = UIColor.whiteColor;
    }return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {

    }return self;
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
}

-(void)layoutSubviews{
    [super layoutSubviews];
}
#pragma mark —— BaseViewProtocol
- (instancetype)initWithSize:(CGSize)thisViewSize{
    if (self = [super init]) {
        self.backgroundColor = UIColor.whiteColor;
    }return self;
}
/// 具体由子类进行复写【数据定UI】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
-(void)richElementsInViewWithModel:(UIViewModel *_Nullable)model{
    self.viewModel = model;
    MakeDataNull
    self.tableView.alpha = 1;
}
/// 具体由子类进行复写【数据尺寸】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
+(CGSize)viewSizeWithModel:(UIViewModel *_Nullable)model{
    return CGSizeMake(JobsWidth(JobsMainScreen_WIDTH()), JobsWidth(46) * [BaiShaETProjChoiceStadiumView createDataMutArr].count + JobsWidth(44) + JobsBottomSafeAreaHeight());
}
#pragma mark —— 一些私有方法
+(NSMutableArray<UIViewModel *> *)createDataMutArr{
    NSMutableArray <UIViewModel *>*dataMutArr = NSMutableArray.array;
    {
        UIViewModel *viewModel = UIViewModel.new;
        viewModel.textModel.text = Internationalization(@"DG體育");
        viewModel.subTextModel.text = Internationalization(@"");
        [dataMutArr addObject:viewModel];
    }
    
    {
        UIViewModel *viewModel = UIViewModel.new;
        viewModel.textModel.text = Internationalization(@"DG真人");
        viewModel.subTextModel.text = Internationalization(@"");
        [dataMutArr addObject:viewModel];
    }
    
    {
        UIViewModel *viewModel = UIViewModel.new;
        viewModel.textModel.text = Internationalization(@"DG電子");
        viewModel.subTextModel.text = Internationalization(@"");
        [dataMutArr addObject:viewModel];
    }
    
    {
        UIViewModel *viewModel = UIViewModel.new;
        viewModel.textModel.text = Internationalization(@"DG彩票");
        viewModel.subTextModel.text = Internationalization(@"");
        [dataMutArr addObject:viewModel];
    }
    
    {
        UIViewModel *viewModel = UIViewModel.new;
        viewModel.textModel.text = Internationalization(@"DG棋牌");
        viewModel.subTextModel.text = Internationalization(@"");
        [dataMutArr addObject:viewModel];
    }
    
    {
        UIViewModel *viewModel = UIViewModel.new;
        viewModel.textModel.text = Internationalization(@"DA電子");
        viewModel.subTextModel.text = Internationalization(@"");
        [dataMutArr addObject:viewModel];
    }return dataMutArr;
}
///下拉刷新 （子类要进行覆写）
-(void)pullToRefresh{
    [self feedbackGenerator];//震动反馈
//    if (data.count) {
//        [self endRefreshing:self.tableView];
//    }else{
//        [self endRefreshingWithNoMoreData:self.tableView];
//    }
}
///上拉加载更多 （子类要进行覆写）
-(void)loadMoreRefresh{
    [self pullToRefresh];
}
#pragma mark —— UITableViewDelegate,UITableViewDataSource
- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    for (BaseTableViewCell *cell in self.tbvCellMutArr) {
        cell.imageView.jobsVisible = NO;
    }
    
    BaseTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.imageView.jobsVisible = !cell.imageView.jobsVisible;
    
    if (self.objectBlock) self.objectBlock(self.dataMutArr[indexPath.row]);
    [self tf_hide];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return JobsWidth(46);
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section{
    return self.dataMutArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BaseTableViewCell *cell = self.tbvCellMutArr[indexPath.row];
    [cell richElementsInCellWithModel:self.dataMutArr[indexPath.row]];
    cell.textLabel.textColor = HEXCOLOR(0x757575);
    cell.textLabel.font = notoSansRegular(16);
    cell.textLabelFrameOffsetX = JobsWidth(16);
    cell.imageViewFrameOffsetX = JobsMainScreen_WIDTH() - JobsWidth(50);
    cell.imageView.image = JobsIMG(@"红色的对勾");
    cell.imageView.jobsVisible = NO;
    
    cell.backgroundColor = cell.contentView.backgroundColor = HEXCOLOR(0xFFFCF7);
    return cell;
}
#pragma mark —— lazyLoad
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = UITableView.initWithStyleGrouped;
        _tableView.backgroundColor = AppMainCor_02;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.scrollEnabled = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = self.tbvHeaderView;/// 这里接入的就是一个UIView的派生类
        _tableView.tableFooterView = UIView.new;/// 这里接入的就是一个UIView的派生类
        _tableView.separatorColor = HEXCOLOR(0xEEEEEE);
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, JobsBottomSafeAreaHeight(), 0);
        [_tableView registerTableViewClass];
        if(@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        [self addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }return _tableView;
}

-(BaiShaETProjChoiceStadiumTBVHeaderView *)tbvHeaderView{
    if (!_tbvHeaderView) {
        _tbvHeaderView = BaiShaETProjChoiceStadiumTBVHeaderView.new;
        _tbvHeaderView.size = [BaiShaETProjChoiceStadiumTBVHeaderView viewSizeWithModel:nil];
        _tbvHeaderView.text = Internationalization(@"選擇場館");
        _tbvHeaderView.textColor = HEXCOLOR(0x3D4A58);
        _tbvHeaderView.font = notoSansBold(16);
        _tbvHeaderView.textAlignment = NSTextAlignmentCenter;
        
    }return _tbvHeaderView;
}

-(NSMutableArray<UIViewModel *> *)dataMutArr{
    if (!_dataMutArr) {
        _dataMutArr = [BaiShaETProjChoiceStadiumView createDataMutArr];
    }return _dataMutArr;
}

-(NSMutableArray<BaseTableViewCell *> *)tbvCellMutArr{
    if (!_tbvCellMutArr) {
        _tbvCellMutArr = NSMutableArray.array;
        for (UIViewModel *viewModel in self.dataMutArr) {
            [_tbvCellMutArr addObject:[BaseTableViewCell cellStyleValue1WithTableView:self.tableView]];
        }
    }return _tbvCellMutArr;
}

@end
