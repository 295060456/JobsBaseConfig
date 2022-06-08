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

#pragma mark —— 一些公有的功能方法
/// 以section为单位，UITableViewCell 第一行和最后一行圆角设置
/// @param tableView 作用对象tableView
/// @param cell 作用对象Tableviewcell
/// @param indexPath indexPath
/// @param strokeColor strokeColor
/// @param fillColor fillColor
/// @param radius 切角弧度
/// @param borderWidth 线宽
/// @param dx 内有介绍
/// @param dy 内有介绍
+(void)tableView:(UITableView *_Nonnull)tableView
makeFirstAndLastCell:(UITableViewCell *_Nonnull)cell
     atIndexPath:(NSIndexPath *_Nonnull)indexPath
     strokeColor:(UIColor *_Nullable)strokeColor
       fillColor:(UIColor *_Nullable)fillColor
     roundCorner:(CGFloat)radius
     borderWidth:(CGFloat)borderWidth
              dx:(CGFloat)dx
              dy:(CGFloat)dy;
/// 以section为单位，每个section的第一行和最后一行的cell圆角化处理
/// @param tableView 作用对象tableView
/// @param cell 作用对象Tableviewcell
/// @param radius 切角弧度
/// @param borderWidth 线宽
/// @param dx 内有介绍
/// @param dy 内有介绍
/// @param indexPath indexPath
+(void)tableView:(UITableView *_Nonnull)tableView
makeSectionFirstAndLastCell:(UITableViewCell *_Nonnull)cell
     atIndexPath:(NSIndexPath *_Nonnull)indexPath
       cellBgCor:(UIColor *_Nullable)cellBgCor
   bottomLineCor:(UIColor *_Nullable)bottomLineCor
  cellOutLineCor:(UIColor *_Nullable)cellOutLineCor
     roundCorner:(CGFloat)radius
     borderWidth:(CGFloat)borderWidth
              dx:(CGFloat)dx
              dy:(CGFloat)dy;
/// 除了最后一行以外，所有的cell的最下面的线的颜色为bottomLineCor
+(void)tableView:(UITableView *_Nonnull)tableView
 makeLastRowCell:(UITableViewCell *_Nonnull)cell
     atIndexPath:(NSIndexPath *_Nonnull)indexPath
   bottomLineCor:(UIColor *_Nullable)bottomLineCor
     borderWidth:(CGFloat)borderWidth
              dx:(CGFloat)dx
              dy:(CGFloat)dy;

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
                    atIndexPath:indexPath
                    roundCorner:JobsWidth(8)
                    borderWidth:JobsWidth(1)
                             dx:JobsWidth(1)
                             dy:0];
 
 或者是
     /// 以section为单位，每个section的第一行和最后一行的cell圆角化处理
     [UITableViewCell tableView:tableView
    makeSectionFirstAndLastCell:cell
                    atIndexPath:indexPath
                      cellBgCor:UIColor.whiteColor
                  bottomLineCor:UIColor.whiteColor
                 cellOutLineCor:HEXCOLOR(0xEEE2C8)
                    roundCorner:JobsWidth(8)
                     borderWidth:JobsWidth(1)
                             dx:JobsWidth(1)
                             dy:0];
 }
 **/

