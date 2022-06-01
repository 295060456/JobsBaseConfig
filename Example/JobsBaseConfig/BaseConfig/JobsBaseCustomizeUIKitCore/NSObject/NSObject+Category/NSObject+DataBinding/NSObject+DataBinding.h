//
//  NSObject+DataBinding.h
//  DouDong-II
//
//  Created by Jobs on 2021/4/22.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

NS_ASSUME_NONNULL_BEGIN
/**
    数据绑定专用参数
 */
@interface NSObject (DataBinding)
<
UITableViewDelegate
,UITableViewDataSource
>

@property(nonatomic,strong)id objBindingParams;
-(void)dataLinkByTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
