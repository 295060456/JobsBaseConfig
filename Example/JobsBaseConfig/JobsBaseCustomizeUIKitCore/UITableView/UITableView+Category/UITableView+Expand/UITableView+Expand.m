//
//  UITableView+Expand.m
//  DouDong-II
//
//  Created by Jobs on 2021/4/10.
//

#import "UITableView+Expand.h"

@implementation UITableView (Expand)
/**
 隐藏每个分区最后一个cell的分割线:系统分割线,移到屏幕外
 在此方法内调用：
 - (void)tableView:(UITableView *)tableView
   willDisplayCell:(UITableViewCell *)cell
 forRowAtIndexPath:(NSIndexPath *)indexPath；
 
    _tableView.separatorColor = HEXCOLOR(0xeeeeee);//改变分割线颜色
    cell.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);//改变分割线长度

 */
-(void)hideSeparatorLineAtLast:(NSIndexPath *)indexPath
                          cell:(UITableViewCell *)cell{
    if (indexPath.row == [self numberOfRowsInSection:indexPath.section] - 1){
        cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, cell.bounds.size.width);
    }
}

-(UITableViewCell *)didSelectRowAtIndexPath:(NSIndexPath *)indexPath
                         tableViewCellClass:(Class _Nullable)tableViewCellClass{
    NSLog(@"%s", __FUNCTION__);
    if (tableViewCellClass) {
        for (UITableViewCell *cell in self.visibleCells) {
            if ([cell isKindOfClass:tableViewCellClass]) {
                cell.selected = NO;
                cell.getViewModel.jobsSelected = NO;
            }
        }
    }
    UITableViewCell *cell = (UITableViewCell *)[self cellForRowAtIndexPath:indexPath];
//
    cell.selected = !cell.selected;// 当程序运行到cellForRowAtIndexPath，赋值失效
    cell.jobsSelected = !cell.jobsSelected;// 当程序运行到cellForRowAtIndexPath，赋值失效
    cell.getViewModel.jobsSelected = !cell.getViewModel.jobsSelected;/// 建议用model来修改
    return cell;
}

-(UITableViewCell *)didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
                           tableViewCellClass:(Class _Nullable)tableViewCellClass{
    NSLog(@"%s", __FUNCTION__);
    UITableViewCell *cell = (UITableViewCell *)[self cellForRowAtIndexPath:indexPath];
    cell.selected = !cell.selected;
    cell.getViewModel.jobsSelected = !cell.getViewModel.jobsSelected;
    return cell;
}

+(instancetype)initWithStylePlain{
    return [UITableView.alloc initWithFrame:CGRectZero style:UITableViewStylePlain];
}

+(instancetype)initWithStyleGrouped{
    return [UITableView.alloc initWithFrame:CGRectZero style:UITableViewStyleGrouped];
}

+(instancetype)initWithStyleInsetGrouped{
    return [UITableView.alloc initWithFrame:CGRectZero style:UITableViewStyleInsetGrouped];
}

@end
