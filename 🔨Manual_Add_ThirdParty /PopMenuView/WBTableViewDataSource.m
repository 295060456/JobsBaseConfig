//
//  WBTableViewDataSource.m
//
//  Created by Transuner on 16/3/9.
//  Copyright © 2016年 吴冰. All rights reserved.
//

#import "WBTableViewDataSource.h"
#import "WBTableViewCell.h"

@interface WBTableViewDataSource ()

@property(nonatomic,copy)TableViewCellConfigureBlock configureCellBlock;
@property(nonatomic,strong)Class Cellclass;
@property(nonatomic,strong) NSArray *modelArray;

@end

@implementation WBTableViewDataSource

- (instancetype) initWithItems:(NSArray *)anItems
                     cellClass:(Class)cellClass
            configureCellBlock:(TableViewCellConfigureBlock)aConfigureCellBlock {
    if (self = [super init]) {
        self.modelArray = anItems;
        self.configureCellBlock = [aConfigureCellBlock copy];
        self.Cellclass = cellClass;
    }return self;
}

- (NSInteger) tableView:(UITableView *)tableView
  numberOfRowsInSection:(NSInteger)section {
    return self.modelArray.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView
          cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WBTableViewCell * cell = [[self.Cellclass class]cellAllocWithTableView:tableView];
    self.configureCellBlock(cell,self.modelArray[indexPath.row]);
    return cell;
}

@end
