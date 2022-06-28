//
//  NavigationViewController.m
//  ShengAi
//
//  Created by 刘赓 on 2018/10/29.
//  Copyright © 2018年 刘赓. All rights reserved.
//

#import "BaseNavigationVC.h"

@interface BaseNavigationVC ()

@property(nonatomic,strong)NSShadow *shadow;

@end

@implementation BaseNavigationVC

- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    if (self = [super initWithRootViewController:rootViewController]) {
        //如果用系统的navigationBar，而并非自定义👇
//        {
//            self.navigationBar.translucent = NO;
//            [self.navigationBar setBackgroundImage:JobsIMG(@"启动页SLOGAN")
//                                     forBarMetrics:UIBarMetricsDefault];//仅仅是 navigationBar 背景
//        //    [self.navigationBar setShadowImage:JobsIMG(@"启动页SLOGAN")];// 图片大了会全屏
//        }
//
//        {
//            if ([self.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]) {//设置NavgationBar的背景图片
//                [self.navigationBar setBarTintColor:JobsRedColor];//一般的业务是全局设置，因为一个App里面只有一个主题
//                self.navigationBar.tintColor = JobsBlackColor;//系统的组件着色（返回按钮——箭头图标 和 上面的字）
//            }
//        }
//
//        {
//            self.navigationBar.titleTextAttributes = @{
//                NSForegroundColorAttributeName:JobsBlackColor,
//                NSShadowAttributeName:self.shadow,
//                NSFontAttributeName:JobsFontRegular(18)
//            };//设置导航上的title显示样式
//        }
    }return self;
}

-(void)loadView{
    [super loadView];
    self.delegate = self;
}

-(void)viewDidLoad{
    [super viewDidLoad];
//    self.navigationBar.hidden = YES;// [self setNavigationBarHidden:YES animated:YES]; 这么写不行
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    self.navigationBar.hidden = YES;// [self setNavigationBarHidden:YES animated:YES]; 这么写不行
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
}
//在指定的单独的控制器里面更改状态栏的颜色（不是全局统一样式的批量改）
/** 同时在指定的控制器里面实现此方法
 *  资料来源：https://www.jianshu.com/p/25e9c1a864be
 *  - (UIStatusBarStyle)preferredStatusBarStyle {
        return UIStatusBarStyleLightContent;
    }
 */
- (UIViewController *)childViewControllerForStatusBarStyle {
    return self.topViewController;
}

- (void)setViewControllers:(NSArray<__kindof UIViewController *> *)viewControllers{
    [self setViewControllers:viewControllers
                    animated:YES];
}

- (void)setViewControllers:(NSArray<UIViewController *> *)viewControllers
                  animated:(BOOL)animated{
    for(NSInteger index = 1; index < viewControllers.count; index ++){
        viewControllers[index].hidesBottomBarWhenPushed = YES;
    }
    [super setViewControllers:viewControllers
                     animated:animated];
}

- (void)pushViewController:(UIViewController *)viewController
                  animated:(BOOL)animated{
    viewController.hidesBottomBarWhenPushed = self.viewControllers.count;//push 的时候把 tabBar 隐藏了
    [super pushViewController:viewController animated:animated];
}
#pragma mark —— UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController
      willShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated{
    self.navigationBar.hidden = YES;//全局隐藏系统的导航栏，这一句是手势返回的时候，再次隐藏
}

- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated{
    self.interactivePopGestureRecognizer.delegate = (id)viewController;
}

-(void)setupBarButtonItem:(UIViewController * __nonnull)vc
                    title:(NSString * __nullable)title
                 selector:(SEL __nonnull)selector{
    if (vc && selector) {
        UIBarButtonItem *editBarBtnItems = [[UIBarButtonItem alloc] initWithTitle:title
                                                                            style:UIBarButtonItemStylePlain
                                                                           target:self
                                                                           action:@selector(selector)];
        vc.navigationItem.rightBarButtonItem = editBarBtnItems;
    }
}
#pragma mark —— lazyLoad
-(NSShadow *)shadow{
    if (!_shadow) {
        _shadow = NSShadow.new;
        _shadow.shadowColor = RGBA_COLOR(0,
                                         0,
                                         0,
                                         0.8);
        _shadow.shadowOffset = CGSizeZero;
    }return _shadow;
}

@end

/*
 
 -(void)setSYSNavigationBar{
     //1.设置导航栏背景颜色
     [[UINavigationBar appearance] setBarTintColor:[UIColor orangeColor]];
     //2.设置导航栏背景图片
     [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navigationBarImg"]
                                        forBarMetrics:UIBarMetricsDefault];
     //3.设置导航栏标题样式
     [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                                [UIColor purpleColor], NSForegroundColorAttributeName,
                                                                [UIFont boldSystemFontOfSize:25], NSFontAttributeName, nil]];

 //    //4.设置导航栏返回按钮的颜色
     [[UINavigationBar appearance] setTintColor:[UIColor greenColor]];
     //5.设置导航栏隐藏
     [[UINavigationBar appearance] setHidden:YES];
 }
 
 
 */
