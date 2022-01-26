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

@end
