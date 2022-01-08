//
//  PopUpVC.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/7/6.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "PopUpVC.h"

@interface PopUpVC ()<UIGestureRecognizerDelegate>

@property(nonatomic,copy)MKDataBlock popUpVCBlock;


@end

@implementation PopUpVC

- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}
#pragma mark - Lifecycle
-(instancetype)init{
    if (self = [super init]) {
        
    }return self;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = kRedColor;
    self.isHiddenNavigationBar = YES;//禁用系统的导航栏
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    self.view.mj_y = self.popUpHeight;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches
          withEvent:(UIEvent *)event{
}

-(void)actionBlockPopUpVC:(MKDataBlock)popUpVCBlock{
    self.popUpVCBlock = popUpVCBlock;
}
#pragma mark —— lazyLoad
-(CGFloat)popUpHeight{
    if (_popUpHeight == 0) {
        _popUpHeight = 200;//默认弹出高度300
    }return _popUpHeight;
}

@end
