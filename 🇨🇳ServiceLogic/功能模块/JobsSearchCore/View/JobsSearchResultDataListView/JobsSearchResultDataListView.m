//
//  JobsSearchResultDataListView.m
//  JobsSearch
//
//  Created by Jobs on 2020/10/6.
//

#import "JobsSearchResultDataListView.h"

@interface JobsSearchResultDataListView ()

@end

@implementation JobsSearchResultDataListView

-(void)dealloc{
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

-(instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = kBlueColor;
    }return self;
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
}
#pragma mark —— BaseViewProtocol
/// 具体由子类进行复写【数据定UI】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
-(void)richElementsInViewWithModel:(id _Nullable)model{
    self.tableView.alpha = 1;
}
#pragma mark —— UIScrollViewDelegate
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    self.isEndScroll = YES;
    @jobs_weakify(self)
    if (self.viewBlock) self.viewBlock(weak_self);
}
//UIScrollView滚动停止监测 https://muscliy.github.io/2015/07/07/UIScrollView%E6%BB%9A%E5%8A%A8%E5%81%9C%E6%AD%A2%E7%9B%91%E6%B5%8B/
-(void)scrollViewDidScroll:(UIScrollView *)sender{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [self performSelector:@selector(scrollViewDidEndScrollingAnimation:)
               withObject:nil
               afterDelay:0.1];
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    NSLog(@"这里是完全停止滚动触发事件原点");
    self.isEndScroll = NO;
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    if (self.viewBlock) self.viewBlock(scrollView);//scrollView
}
#pragma mark —— UITableViewDelegate,UITableViewDataSource
-(CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [JobsSearchResultDataListTBVCell cellHeightWithModel:nil];
}
/*  主承载view实现了 touchesBegan 或者手势响应
 *  那么 手势响应优先执行touchesBegan 或者手势响应 而跳过代理方法导致 didSelectRowAtIndexPath 失效
 *  此时需要在cell子类里面重写touchesBegan 或者手势响应 方法以便触发
 */
-(void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"此时是失效的,cell的点击事件参见JobsSearchResultDataListTBVCell——touchesBegan");
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section{
    return self.searchResDataMutArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JobsSearchResultDataListTBVCell *cell = [JobsSearchResultDataListTBVCell cellWithTableView:tableView];
    [cell richElementsInCellWithModel:self.searchResDataMutArr[indexPath.row]];
    @jobs_weakify(self)
    [cell actionViewBlock:^(id data) {
        @jobs_strongify(self)
        if (self.viewBlock) self.viewBlock(data);//textLabel.text
    }];return cell;
}
#pragma mark —— lazyLoad
-(JobsSearchTableView *)tableView{
    if (!_tableView) {
        _tableView = JobsSearchTableView.new;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = UIView.new;
        _tableView.ly_emptyView = [LYEmptyView emptyViewWithImageStr:@"noData"
                                                            titleStr:@"暂无数据"
                                                           detailStr:@""];
        @jobs_weakify(self)
        [_tableView actionViewBlock:^(id data) {
            @jobs_strongify(self)
            if (self.viewBlock) self.viewBlock(data);//UITapGestureRecognizer
        }];
        [self addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }return _tableView;
}

-(NSMutableArray<UIViewModel *> *)searchResDataMutArr{
    if (!_searchResDataMutArr) {
        _searchResDataMutArr = NSMutableArray.array;
    }return _searchResDataMutArr;
}


@end
