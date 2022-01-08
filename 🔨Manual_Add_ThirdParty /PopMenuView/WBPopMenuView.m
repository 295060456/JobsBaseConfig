//
//  WBPopMenuView.m
//  QQ_PopMenu_Demo
//
//  Created by Transuner on 16/3/17.
//  Copyright © 2016年 吴冰. All rights reserved.
//

#import "WBPopMenuView.h"
#import "WBTableViewDataSource.h"
#import "WBTableViewDelegate.h"
#import "WBTableViewCell.h"
#import "WBPopMenuModel.h"
#import "WBPopMenuSingleton.h"

@interface WBPopMenuView ()

@property(nonatomic,strong)WBTableViewDataSource *tableViewDataSource;
@property(nonatomic,strong)WBTableViewDelegate *tableViewDelegate;
@property(nonatomic,assign)CGRect QPetFrame;
@property(nonatomic,assign)CGFloat menuCellHeight;

@end

@implementation WBPopMenuView

- (instancetype) initWithFrame:(CGRect)frame
                     QPetFrame:(CGRect)QPetFrame
                menuCellHeight:(CGFloat)menuCellHeight
                     menuWidth:(CGFloat)menuWidth
                         items:(NSArray *)items
                        action:(void(^)(NSInteger index))action {
    if (self = [super initWithFrame:frame]) {
        self.QPetFrame = QPetFrame;
        self.menuCellHeight = menuCellHeight;
        self.menuWidth = menuWidth;
        self.menuItem = items;
        self.action = [action copy];
        self.tableView.alpha = 1;
    }return self;
}

- (CGRect)menuFrame {
    //因为是靠边停靠模式，所以x只有两个值
    CGFloat menuX = 0.f;
    CGFloat menuY = 0.f;
    CGFloat width = self.menuWidth;
    CGFloat heigh = self.menuCellHeight * self.menuItem.count;
    if (self.QPetFrame.origin.x == 0) {//Q宠在左边
        menuX = self.menuWidth;

        if (self.QPetFrame.origin.y < SCREEN_HEIGHT / 2) {//菜单出现在下边 OK
            menuY = self.QPetFrame.size.height;
        }else{//菜单出现在上边
            menuY = self.QPetFrame.origin.y - self.QPetFrame.size.height - self.menuItem.count * self.menuCellHeight;
        }
    }else{//Q宠在右边
        menuX = SCREEN_WIDTH - self.menuWidth;
        if (self.QPetFrame.origin.y < SCREEN_HEIGHT / 2) {//菜单出现在下边
            menuY = self.QPetFrame.size.height;
        }else{//菜单出现在上边
            menuY = self.QPetFrame.origin.y - self.QPetFrame.size.height - self.menuItem.count * self.menuCellHeight;
        }
    }return (CGRect){
        menuX,
        menuY,
        width,
        heigh
    };
}

- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [[WBPopMenuSingleton shareManager]hideMenu];
}
#pragma mark —— lazyLoad
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:[self menuFrame]
                                                 style:UITableViewStylePlain];
//        _tableView.backgroundColor = kRedColor;
        _tableView.dataSource = self.tableViewDataSource;
        _tableView.delegate = self.tableViewDelegate;
        _tableView.layer.cornerRadius = 10.0f;
        _tableView.layer.anchorPoint = CGPointMake(1.0, 0);
        _tableView.transform = CGAffineTransformMakeScale(0.0001, 0.0001);
        _tableView.rowHeight = 40;
        [self addSubview:_tableView];
        if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
            [_tableView setSeparatorInset:UIEdgeInsetsZero];
        }
        if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
            [_tableView setLayoutMargins:UIEdgeInsetsZero];
        }
    }return _tableView;
}

-(WBTableViewDataSource *)tableViewDataSource{
    if (!_tableViewDataSource) {
        _tableViewDataSource = [[WBTableViewDataSource alloc]initWithItems:self.menuItem
                                                                 cellClass:[WBTableViewCell class]
                                                        configureCellBlock:^(WBTableViewCell *cell,
                                                                             WBPopMenuModel *model) {
            WBTableViewCell *tableViewCell = (WBTableViewCell *)cell;
            tableViewCell.textLabel.text = model.title;
            tableViewCell.imageView.image = [UIImage imageNamed:model.image];
        }];
    }return _tableViewDataSource;
}

-(WBTableViewDelegate *)tableViewDelegate{
    if (!_tableViewDelegate) {
        @weakify(self)
        _tableViewDelegate = [[WBTableViewDelegate alloc] initWithDidSelectRowAtIndexPath:^(NSInteger indexRow) {
            @strongify(self)
            if (self.action) {
                self.action(indexRow);
            }
        }];
    }return _tableViewDelegate;
}

@end
