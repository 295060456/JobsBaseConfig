#  viewForHeaderInSection 的使用记录

tableView的每个Section的头部出现一个view，涉及到复用机制

定义 BaiShaETProjMembersBoardView 文件
```
BaiShaETProjMembersBoardView.h
@interface BaiShaETProjMembersBoardView : BaseTableViewHeaderView

BaiShaETProjMembersBoardView.m
#pragma mark —— BaseProtocol
/// 单例化和销毁
+(void)destroySingleton{
    static_membersBoardViewOnceToken = 0;
    static_membersBoardView = nil;
}

static BaiShaETProjMembersBoardView *static_membersBoardView = nil;
static dispatch_once_t static_membersBoardViewOnceToken;
+(instancetype)sharedInstance{
    dispatch_once(&static_membersBoardViewOnceToken, ^{
        static_membersBoardView = BaiShaETProjMembersBoardView.jobsInitWithReuseIdentifier;
    });return static_membersBoardView;
}

-(instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = UIColor.whiteColor;
    }return self;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if(self == [super initWithReuseIdentifier:reuseIdentifier]){

    }return self;
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
}

-(void)layoutSubviews{
    [super layoutSubviews];
}
#pragma mark —— BaseViewProtocol
/// 具体由子类进行复写【数据定UI】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
-(void)richElementsInViewWithModel:(UIViewModel *_Nullable)model{
    self.viewModel = model;
    MakeDataNull
}
/// 具体由子类进行复写【数据尺寸】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
+ (CGRect)viewFrameWithModel:(UIViewModel *)model{
    return CGRectMake(0, 0, JobsMainScreen_WIDTH(), JobsWidth(39 + 64));
}
#pragma mark —— lazyLoad
...
```
在使用TableView的主类,关联下列协议
```
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
```
在TableView初始化部分进行注册
```
1、[_tableView registerTableViewClass];
        
2、在UITableView+RegisterClass.m添加如下
-(void)registerTableViewClass{
    [self registerHeaderFooterViewClass:BaiShaETProjMembersBoardView.class];
}
```
