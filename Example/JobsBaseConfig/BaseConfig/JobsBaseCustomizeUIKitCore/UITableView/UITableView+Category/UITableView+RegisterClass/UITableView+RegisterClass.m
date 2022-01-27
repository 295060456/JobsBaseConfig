//
//  UITableView+RegisterClass.m
//  JobsBaseConfig
//
//  Created by Jobs on 2022/1/26.
//

#import "UITableView+RegisterClass.h"

@implementation UITableView (RegisterClass)

-(void)registerTableViewClass{
    [self registerHeaderFooterViewClass:JobsSearchTableViewHeaderView.class];
}
/// 注册 HeaderFooterView 及其子类
-(void)registerHeaderFooterViewClass:(Class)cls{
    [self registerClass:cls forHeaderFooterViewReuseIdentifier:cls.description];
}
/// 注册 UITableViewCell 及其子类
-(void)registerTableViewCellClass:(Class)cls{
    [self registerClass:cls forCellReuseIdentifier:cls.description];
}
/// 一种用字符串取UITableViewCell及其子类的方法❤️复用字符串是目标类的类名❤️
-(__kindof UITableViewCell *)tableViewCellClass:(Class)cls{
    return [self dequeueReusableCellWithIdentifier:cls.description];
}
/// 一种用字符串 和 indexPath 取UITableViewCell及其子类的方法❤️复用字符串是目标类的类名❤️
-(__kindof UITableViewCell *)collectionViewCellClass:(Class)cls forIndexPath:(NSIndexPath *)indexPath{
    return [self dequeueReusableCellWithIdentifier:cls.description forIndexPath:indexPath];
}
/// 一种用字符串取UITableViewHeaderFooterView及其子类的方法❤️复用字符串是目标类的类名❤️
-(__kindof UITableViewHeaderFooterView *)tableViewHeaderFooterView:(Class)cls{
    return [self dequeueReusableHeaderFooterViewWithIdentifier:cls.description];
}

@end
