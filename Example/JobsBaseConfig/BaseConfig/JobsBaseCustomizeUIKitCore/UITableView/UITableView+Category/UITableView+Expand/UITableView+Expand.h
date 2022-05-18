//
//  UITableView+Expand.h
//  DouDong-II
//
//  Created by Jobs on 2021/4/10.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (Expand)
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
                          cell:(UITableViewCell *)cell;

+(instancetype)initWithStylePlain;
+(instancetype)initWithStyleGrouped;
+(instancetype)initWithStyleInsetGrouped API_AVAILABLE(ios(13.0)) API_UNAVAILABLE(tvos);

@end

NS_ASSUME_NONNULL_END


/**

 ❤️UITableViewStylePlain ❤️
 不实现footer、header设置方法，默认无header、footer；
                                        iOS 11                                                                         |                      < iOS 11
 ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    viewForHeaderInSection           |      只实现此方法header高度为系统默认                                                |   只实现此方法header设置无效
 ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    heightForHeaderInSection        |       只实现此方法header设置无效                                                          |  只实现此方法header高度设置有效
 ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
                            同时实现 viewForHeaderInSection 和 heightForHeaderInSection        |
                                    header高度设置有效                                                            |
 ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 【 footer设置同header设置】
 
 
 ❤️UITableViewStyleGrouped ❤️
 不实现footer、header设置方法，默认无header、footer；
                                        iOS 11                                                                         |                      < iOS 11
 ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    viewForHeaderInSection           |      只实现此方法header高度为系统默认                                                |   只实现此方法header高度为系统默认
 ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    heightForHeaderInSection        |       只实现此方法header高度为系统默认                                                |  实现此方法header高度设置有效，不可为0
 ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
                            同时实现 viewForHeaderInSection 和 heightForHeaderInSection        |
                                    header高度设置有效                                                            |
 ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 【 footer设置同header设置】
 
 综上所诉:
 1、iOS 11 设置 header 高度必须同时实现 viewForHeaderInSection 和 heightForHeaderInSection ；
 2、iOS 11 之前版本只设置 heightForHeaderInSection 即可设置 header 高度，只是在 UITableViewStyleGrouped 时无法设置 header 高度为0，设置0时高度为系统默认高度；

 作者：JimmyL
 链接：https://www.jianshu.com/p/65425a9d98e3
 来源：简书
 著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。

 */
