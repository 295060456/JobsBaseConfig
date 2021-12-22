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
/// Data
@property(nonatomic,strong)NSMutableArray <UITableViewCell *>*tbvCellMutArr;
@property(nonatomic,strong)NSMutableArray <UIViewModel *>*dataMutArr;

@end

@implementation JobsDropDownListView

-(instancetype)init{
    if (self = [super init]) {
        self.tableView.alpha = 1;
        self.backgroundColor = UIColor.clearColor;
    }return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
    }return self;
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    [TableViewAnimationKit showWithAnimationType:XSTableViewAnimationTypeFall
                                       tableView:self.tableView];
}

-(void)dropDownListViewDisappear{
    [self removeFromSuperview];
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
    return [BaseTableViewCell cellHeightWithModel:Nil];
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
        _tableView.backgroundColor = AppMainCor_02;
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
        do {
            [_tbvCellMutArr addObject:[BaseTableViewCell cellWithTableView:self.tableView]];
            dataMutArrCount -= 1;
        } while (dataMutArrCount);
    }return _tbvCellMutArr;
}

@end
