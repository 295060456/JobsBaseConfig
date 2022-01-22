//
//  JobsSearchResultDataListView.h
//  JobsSearch
//
//  Created by Jobs on 2020/10/6.
//

#import <UIKit/UIKit.h>
#import "MacroDef_Func.h"
#import "BaseView.h"
#import "BaseTableView.h"
#import "JobsSearchResultDataListTBVCell.h"

#if __has_include(<LYEmptyView/LYEmptyViewHeader.h>)
#import <LYEmptyView/LYEmptyViewHeader.h>
#else
#import "LYEmptyViewHeader.h"
#endif

NS_ASSUME_NONNULL_BEGIN

@interface JobsSearchResultDataListView : BaseView
<
UITableViewDelegate
,UITableViewDataSource
>

@property(nonatomic,strong)BaseTableView *tableView;
@property(nonatomic,strong)NSMutableArray <UIViewModel *>*searchResDataMutArr;
@property(nonatomic,assign)BOOL isEndScroll;//是否停止滚动

@end

NS_ASSUME_NONNULL_END
