//
//  CoreTextLearningVC.m
//  JobsBaseConfig
//
//  Created by Jobs on 2022/2/19.
//

#import "CoreTextLearningVC.h"

@interface CoreTextLearningVC ()

@end

@implementation CoreTextLearningVC

- (void)dealloc{
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
    //    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)loadView{
    [super loadView];
    
    if ([self.requestParams isKindOfClass:UIViewModel.class]) {
        self.viewModel = (UIViewModel *)self.requestParams;
    }
    self.setupNavigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = KYellowColor;
    [self setGKNav];
    [self setGKNavBackBtn];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self makeIt];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}
#pragma mark —— 一些私有化方法
- (NotifiView *)_createNotifiViewWithIndex:(int)index{
    CGFloat PADDING = 20;
    CGFloat WIDTH = 200;
    CGFloat HEIGHT = 50;
    CGFloat TOP = 100;
    CGFloat X = 30;
    NotifiView* nView = [[NotifiView alloc] initWithFrame:CGRectMake(X,
                                                                     TOP + (HEIGHT + PADDING) * index,
                                                                     WIDTH,
                                                                     HEIGHT)];
    nView.backgroundColor = [UIColor linkColor];
    nView.layer.cornerRadius = 5;
    nView.duration = 5;
    return nView;
}

-(void)makeIt{
    //设置notifiViews
    NSMutableArray* notifiViews = NSMutableArray.array;
    for (int i = 0; i < 4; i++) {
        NotifiView *nView = [self _createNotifiViewWithIndex:i];
        [notifiViews addObject:nView];
    }
    [[NotifiViewFactory shared] setNotifiViews:notifiViews];
    
    //设置队列的并发线程数量
    [[NotifiManager shared] setQueueNaxConcurrentOperationCount:notifiViews.count];
    
    [[NotifiManager shared] showNotifiWithData:@{@"key": @"111", @"content" : @"key:111"}
                                        onView:self.view
                                   finishBlock:^(NSString *key) {
        NSLog(@"key为%@的NotifiView 显示完成！", key);
    }];
    
    for (int i = 0; i < 20; i++) {
        int random = arc4random() % 10 + 1;
        NSLog(@"random ------------>%d, index:%d", random, i);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW,
                                     (int64_t)((random) * NSEC_PER_SEC)),
                       dispatch_get_main_queue(),
                       ^{
            NSString* key = [NSString stringWithFormat:@"%d", i];
            [[NotifiManager shared] showNotifiWithData:@{@"key": key, @"content" : [NSString stringWithFormat:@"key:%@", key]}
                                                onView:self.view
                                           finishBlock:^(NSString *key) {
                NSLog(@"key为%@的NotifiView 显示完成！", key);
            }];
        });
    }
    //更新测试
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW,
                                 (int64_t)((3) * NSEC_PER_SEC)),
                   dispatch_get_main_queue(), ^{
        
        [[NotifiManager shared] updateNotifiWithData:@{@"key" : @"111", @"content" : @"key:X222"}
                                         finishBlock:^(NSString *key) {
            NSLog(@"完成更新！！！key => %@", key);
        }];
        
    });
}
#pragma mark —— lazyLoad

@end
