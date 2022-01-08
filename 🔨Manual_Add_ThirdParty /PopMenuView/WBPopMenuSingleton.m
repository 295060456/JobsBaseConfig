//
//  WBPopMenuSingleton.m
//  QQ_PopMenu_Demo
//
//  Created by Transuner on 16/3/17.
//  Copyright © 2016年 吴冰. All rights reserved.
//

#import "WBPopMenuSingleton.h"
#import "WBPopMenuView.h"

@interface WBPopMenuSingleton ()

@property(nonatomic,strong)WBPopMenuView * popMenuView;
@property(nonatomic,assign)CGRect framer;
@property(nonatomic,assign)CGFloat width;
@property(nonatomic,strong)NSArray *item;
@property(nonatomic,copy)void (^action)(NSInteger);

@end

@implementation WBPopMenuSingleton

+ (WBPopMenuSingleton *) shareManager {
    static WBPopMenuSingleton *popMenuSingleton;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!popMenuSingleton) {
            popMenuSingleton = WBPopMenuSingleton.new;
        }
    });return popMenuSingleton;
}

- (void)showPopMenuSelecteWithFrame:(CGRect)frame
                          menuWidth:(CGFloat)width
                                item:(NSArray *)item
                              action:(void (^)(NSInteger))action {
    @jobs_weakify(self)
    self.framer = frame;
    self.width = width;
    self.item = item;
    self.action = [action copy];
    if (_popMenuView) {
        [weak_self hideMenu];
    }
    [UIView animateWithDuration:0.3f
                     animations:^{
        @jobs_strongify(self)
        self.popMenuView.tableView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    }];
}

- (void)hideMenu {
    @weakify(self)
    [UIView animateWithDuration:0.15
                     animations:^{
        @strongify(self)
        self.popMenuView.tableView.transform = CGAffineTransformMakeScale(0.0001, 0.0001);
    } completion:^(BOOL finished) {
        @strongify(self)
        [self.popMenuView.tableView removeFromSuperview];
        [self.popMenuView removeFromSuperview];
        self.popMenuView.tableView = nil;
        self.popMenuView = nil;
    }];
}

#pragma mark —— lazyLoad
-(WBPopMenuView *)popMenuView{
    if (!_popMenuView) {
         @weakify(self)
        _popMenuView = [[WBPopMenuView alloc] initWithFrame:[[UIApplication sharedApplication] windows].firstObject.bounds
                                                  QPetFrame:self.framer
                                             menuCellHeight:40
                                                  menuWidth:self.width
                                                      items:self.item
                                                     action:^(NSInteger index) {
        @strongify(self)
        self.action(index);
        [self hideMenu];
    }];
    _popMenuView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.1];
    [[[UIApplication sharedApplication] windows].firstObject addSubview:_popMenuView];
    }return _popMenuView;
}


@end
