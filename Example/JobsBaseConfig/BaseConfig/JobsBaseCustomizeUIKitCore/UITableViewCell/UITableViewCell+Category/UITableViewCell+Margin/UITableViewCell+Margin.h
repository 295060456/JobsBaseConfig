//
//  UITableViewCell+Margin.h
//  JobsIM
//
//  Created by Jobs on 2020/11/13.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import "BaseCellProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface UITableViewCell (Margin)
<
BaseCellProtocol
,UIViewModelProtocol
>
#pragma mark —— 功能方法
/// iOS UITableViewCell 第一行和最后一行圆角设置
/// @param tableView 作用对象tableView
/// @param cell 作用对象Tableviewcell
/// @param radius 切角弧度
/// @param dx 内有介绍
/// @param dy 内有介绍
/// @param indexPath indexPath
+(void)tableView:(UITableView *)tableView
makeFirstAndLastCell:(nonnull UITableViewCell *)cell
     roundCorner:(CGFloat)radius
              dx:(CGFloat)dx
              dy:(CGFloat)dy
     atIndexPath:(nonnull NSIndexPath *)indexPath;
/// 以section为单位，每个section的第一行和最后一行的cell圆角化处理
/// @param tableView 作用对象tableView
/// @param cell 作用对象Tableviewcell
/// @param radius 切角弧度
/// @param dx 内有介绍
/// @param dy 内有介绍
/// @param indexPath indexPath
+(void)tableView:(UITableView *)tableView
makeSectionFirstAndLastCell:(nonnull UITableViewCell *)cell
     roundCorner:(CGFloat)radius
              dx:(CGFloat)dx
              dy:(CGFloat)dy
     atIndexPath:(nonnull NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
/**
 
 示例代码：
 
 - (void)tableView:(UITableView *)tableView
   willDisplayCell:(nonnull UITableViewCell *)cell
 forRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
     ///  UITableViewCell 第一行和最后一行圆角设置
     [UITableViewCell tableView:tableView
           makeFirstAndLastCell:cell
                    roundCorner:6
                             dx:JobsWidth(16)
                             dy:0
                    atIndexPath:indexPath];
 
 或者是
     /// 以section为单位，每个section的第一行和最后一行的cell圆角化处理
     [UITableViewCell tableView:tableView
    makeSectionFirstAndLastCell:cell
                    roundCorner:JobsWidth(8)
                             dx:JobsWidth(1)
                             dy:0
                    atIndexPath:indexPath];
 }
 **/

