//
//  JobsDropDownListView.m
//  Casino
//
//  Created by Jobs on 2021/12/21.
//

#import "JobsDropDownListView.h"

@interface JobsDropDownListView (){
    CGFloat CellHeight;
}
/// UI
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)Class <BaseCellProtocol>tbvCell_cls;
/// Data
@property(nonatomic,strong)NSMutableArray <UITableViewCell *>*tbvCellMutArr;
@property(nonatomic,strong)NSMutableArray <UIViewModel *>*dataMutArr;

@end

@implementation JobsDropDownListView

- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

-(instancetype)init{
    if (self = [super init]) {
        self.tableView.alpha = 1;
        self.backgroundColor = UIColor.clearColor;
    }return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.tableView.alpha = 1;
        self.backgroundColor = UIColor.clearColor;
    }return self;
}

-(instancetype)initWithTableViewClass:(Class <BaseCellProtocol>_Nonnull)tableViewClass{
    if (self = [super init]) {
        self.tbvCell_cls = tableViewClass;
        self.tableView.alpha = 1;
        self.backgroundColor = UIColor.clearColor;
    }return self;
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    self.tableView.contentInset = UIEdgeInsetsMake(0,
                                                   0,
                                                   [JobsDropDownListView getWindowFrameByView:self].origin.y,
                                                   0);
    [UIScrollViewAnimationKit showWithAnimationType:XSScrollViewAnimationTypeAlpha
                                         scrollView:self.tableView];
}

-(void)dropDownListViewDisappear{
    [_tableView removeFromSuperview];
    _tableView = nil;
    [self removeFromSuperview];
    NSLog(@"");
}

-(void)richElementsInViewWithModel:(NSMutableArray <UIViewModel *>*_Nullable)model{
    if ([model isKindOfClass:NSArray.class]) {
        self.dataMutArr = model;
        self.tableView.alpha = 1;
    }
}
#pragma mark —— UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    /// self.tbvCell_cls没有值的时候等于调用 [JobsDropDownListTBVCell cellHeightWithModel:Nil];
    @jobs_weakify(self)
    NSNumber *d = [NSObject methodName:@"cellHeightWithModel:"
                             targetObj:weak_self.tbvCell_cls ? weak_self.tbvCell_cls.class : JobsDropDownListTBVCell.class
                           paramarrays:nil];
    return d.floatValue;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.viewBlock) self.viewBlock(self.dataMutArr[indexPath.row]);
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section{
    return self.dataMutArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BaseTableViewCell *cell = (BaseTableViewCell *)self.tbvCellMutArr[indexPath.row];
    [cell richElementsInCellWithModel:self.dataMutArr[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView
  willDisplayCell:(UITableViewCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView hideSeparatorLineAtLast:indexPath
                                  cell:cell];
}
#pragma mark —— lazyLoad
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = UITableView.new;
        _tableView.backgroundColor = UIColor.clearColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = UIView.new;
        _tableView.tableFooterView = UIView.new;
        _tableView.separatorColor = HEXCOLOR(0xEEEEEE);
        [self addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }return _tableView;
}

-(NSMutableArray<UITableViewCell *> *)tbvCellMutArr{
    if (!_tbvCellMutArr) {
        _tbvCellMutArr = NSMutableArray.array;
        NSInteger dataMutArrCount = self.dataMutArr.count;
        @jobs_weakify(self)
        do {
            UITableViewCell *tableViewCell = (UITableViewCell *)[NSObject methodName:@"cellWithTableView:"
                                                                           targetObj:weak_self.tbvCell_cls ? weak_self.tbvCell_cls.class : JobsDropDownListTBVCell.class
                                                                         paramarrays:@[self.tableView]];
            [_tbvCellMutArr addObject:tableViewCell];
            dataMutArrCount -= 1;
        } while (dataMutArrCount);
    }return _tbvCellMutArr;
}

@end
