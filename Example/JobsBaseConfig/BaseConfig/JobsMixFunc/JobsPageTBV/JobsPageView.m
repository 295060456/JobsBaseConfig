//
//  JobsPageView.m
//  Casino
//
//  Created by Jobs on 2021/11/24.
//

#import "JobsPageView.h"

@interface JobsPageView ()
/// UI
@property(nonatomic,strong)UITableView *tableView;
/// Data
@property(nonatomic,strong)NSArray <UIViewModel *>*dataArr;

@end

@implementation JobsPageView
@synthesize cellHeight = _cellHeight;
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
    }return self;
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    self.cellHeight = self.height;//16
    [self.tableView reloadData];
}
#pragma mark —— BaseViewProtocol
//具体由子类进行复写【数据定UI】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
-(void)richElementsInViewWithModel:(NSArray <UIViewModel *>*_Nullable)model{
    self.dataArr = model;
    self.tableView.alpha = 1;
//    self.backgroundImageView.image = JobsIMG(@"抖动钱包抖币用途");
//    self.imageView_1.alpha = 1;
//    self.imageView_2.alpha = 1;
//    self.valueLab.text = model.goldNumber;
//    self.btn.alpha = 1;
}
#pragma mark —— UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [JobsPageTBVCell cellHeightWithModel:Nil] ? : self.cellHeight;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JobsPageTBVCell *cell = [JobsPageTBVCell cellStyleSubtitleWithTableView:tableView];
    [cell richElementsInCellWithModel:self.dataArr[indexPath.row]];
#warning 这里需要被修改
//    UIViewModel *viewModel = self.dataArr[indexPath.row];
//    viewModel.jobsWidth = [JobsPageTBVCell cellHeightWithModel:Nil] ? : self.cellHeight;
//    [UIView widthByData:viewModel];
    return cell;
}
#pragma mark —— lazyLoad
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = UITableView.new;
        _tableView.backgroundColor = JobsClearColor;
        _tableView.pagingEnabled = YES;
//        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.scrollEnabled = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        [self dataLinkByTableView:_tableView];
        _tableView.tableFooterView = UIView.new;
        _tableView.separatorColor = HEXCOLOR(0xEEEEEE);
        
        [self addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }return _tableView;
}

@end
