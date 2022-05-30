//
//  UITableView+RegisterClass.h
//  JobsBaseConfig
//
//  Created by Jobs on 2022/1/26.
//

#import <UIKit/UIKit.h>
#import "JobsSearchTableViewHeaderView.h"

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (RegisterClass)

-(void)registerTableViewClass;
/// 注册 HeaderFooterView 及其子类
-(void)registerHeaderFooterViewClass:(Class)cls;
/// 注册 UITableViewCell 及其子类
-(void)registerTableViewCellClass:(Class)cls;
/// 一种用字符串取UITableViewCell及其子类的方法❤️复用字符串是目标类的类名❤️
-(__kindof UITableViewCell *)tableViewCellClass:(Class)cls;
/// 一种用字符串 和 indexPath 取UITableViewCell及其子类的方法❤️复用字符串是目标类的类名❤️
-(__kindof UITableViewCell *)tableViewCellClass:(Class)cls forIndexPath:(NSIndexPath *)indexPath;
/// 一种用字符串取UITableViewHeaderFooterView及其子类的方法❤️复用字符串是目标类的类名❤️
-(__kindof UITableViewHeaderFooterView *)tableViewHeaderFooterView:(Class)cls;

@end

NS_ASSUME_NONNULL_END
