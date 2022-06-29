//
//  TabbarVC.m
//  TabbarItemLottie
//
//  Created by 叶晓倩 on 2017/9/29.
//  Copyright © 2017年 xa. All rights reserved.
//

#import "JobsTabbarVC.h"

@interface JobsTabbarVC (){
    BOOL A;
}
/// UI
@property(nonatomic,strong,readwrite)JobsTabBar *myTabBar;//myTabBar.humpOffsetY 凸起的高度自定义，默认值30  offsetHeight
/// Data
@property(nonatomic,assign)BOOL isOpenPPBadge;
@property(nonatomic,assign)NSInteger subViewControllerCount;
@property(nonatomic,strong)NSMutableArray <UIView *>*UITabBarButtonMutArr;//UITabBarButton 是内部类 直接获取不到，需要间接获取
@property(nonatomic,strong)NSMutableArray <UIViewModel *>*pullListAutoSizeViewMutArr;

@end

@implementation JobsTabbarVC

- (void)dealloc{
    NSLog(@"%@",JobsLocalFunc);
    [NSNotificationCenter.defaultCenter removeObserver:self];
}
#pragma mark —— 初始化方法
static JobsTabbarVC *static_tabbarVC = nil;
///【单例模式】使用内置默认的JobsTabBar
+(instancetype)sharedInstance{
    @synchronized(self){
        if (!static_tabbarVC) {
            static_tabbarVC = JobsTabbarVC.new;
        }
    }return static_tabbarVC;
}
///【单例模式】使用外界自定义的JobsTabBar
+(instancetype)sharedInstanceWithJobsTabBar:(JobsTabBar *)tabBar{
    @synchronized(self){
        if (!static_tabbarVC) {
            static_tabbarVC = JobsTabbarVC.new;
            static_tabbarVC.myTabBar = tabBar;
        }
    }return static_tabbarVC;
}
/// 一般的初始化模式
-(instancetype)initWithJobsTabBar:(JobsTabBar *)tabBar{
    if (self = [super init]) {
        self.myTabBar = tabBar;
    }return self;
}
#pragma mark —— ViewController的生命周期
-(void)loadView{
    [super loadView];
    
    if ([self.requestParams isKindOfClass:UIViewModel.class]) {
        self.viewModel = (UIViewModel *)self.requestParams;
    }
    A = YES;
    self.delegate = self;
    self.isOpenScrollTabbar = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    /// 手势左右滑动以切换TabbarControl挂载的ViewController
    if (self.isOpenScrollTabbar) {
        [self openPan];
        self.view.panGR.enabled = self.isOpenScrollTabbar;
    }
    self.myTabBar.alpha = 1;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.isHiddenNavigationBar = YES;

    static dispatch_once_t JobsTabbarVC_viewWillAppear_onceToken;
    @jobs_weakify(self)
    dispatch_once(&JobsTabbarVC_viewWillAppear_onceToken, ^{
        @jobs_strongify(self)
        [self UISetting];//最高只能在viewWillAppear，在viewDidLoad不出效果 self.tabBar.subviews为空
        [self 添加长按手势];
    });
}

-(void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    self.myTabBar.height += self.myTabBar.customTabBarOffsetHeight;
    self.myTabBar.y = self.view.height - self.myTabBar.height;

//    [self ppBadge:YES];
}
#pragma mark —— 一些公有方法
/// 关闭手势
-(void)closePan{
    self.view.panGR.enabled = NO;
}
/// 打开手势
-(void)openPan{
    
    self.view.numberOfTouchesRequired = 1;
    self.view.numberOfTapsRequired = 1;/// ⚠️注意：如果要设置长按手势，此属性必须设置为0⚠️
    self.view.minimumPressDuration = 0.1;
    self.view.numberOfTouchesRequired = 1;
    self.view.allowableMovement = 1;
    self.view.userInteractionEnabled = YES;
    self.view.target = self;
    @jobs_weakify(self)
    self.view.panGR_SelImp.selector = [self jobsSelectorBlock:^(id  _Nullable target, UIPanGestureRecognizer *_Nullable arg) {
        @jobs_strongify(self)
        [self panGestureRecognizer:arg];
    }];
    self.view.panGR.enabled = YES;/// 必须在设置完Target和selector以后方可开启执行
}
/// 开启/关闭 PPBadgeView的效果,至少在viewDidLayoutSubviews后有效
-(void)ppBadge:(BOOL)open{
    self.isOpenPPBadge = open;
    if (open) {
        for (UITabBarItem *item in self.tabBar.items) {
            if ([item.title isEqualToString:@"首页"]) {
                [item pp_addBadgeWithText:@"919+"];
    #pragma mark —— 动画
                [item.badgeView animationAlert];//图片从小放大
                [item.badgeView shakerAnimationWithDuration:2 height:20];//重力弹跳动画效果
    //            [UIView 视图上下一直来回跳动的动画:item.badgeView];
            }
        }
    }
}
#pragma mark —— 一些私有方法
/// 需要强制跳转登录的index。点击和手势滑动都需要共同调用
-(BOOL)forcedLoginIndex:(NSUInteger)index{
    if ([self.needLoginArr containsObject:@(index)]) {
        [self forcedLogin];
        return YES;
    }return NO;
}
/// 判别是否有Lottie
/// @param index index
-(BOOL)judgeLottieWithIndex:(NSInteger)index{
    JobsTabBarControllerConfig *config = (JobsTabBarControllerConfig *)self.tabBarControllerConfigMutArr[index];
    return ![NSString isNullString:config.lottieName];
}

-(void)UISetting{
    for (int i = 0; i < self.tabBarControllerConfigMutArr.count; i++) {
        
        JobsTabBarControllerConfig *config = (JobsTabBarControllerConfig *)self.tabBarControllerConfigMutArr[i];
        // For Test
//        if ([self judgeLottieWithIndex:i]) {
//            [self addLottieImage:config.lottieName];// 有Lottie动画名，则优先创建Lottie动画
//        }
        
        UIViewController *viewController = self.childVCMutArr[i];
        viewController.title = config.title;
        viewController.tabBarItem = [JobsTabBarItem.alloc initWithConfig:config];
        
        if (config.humpOffsetY != 0) {
            //一般的图片
            [viewController.tabBarItem setImageInsets:UIEdgeInsetsMake(-config.humpOffsetY,
                                                                       0,
                                                                       -config.humpOffsetY / 2,
                                                                       0)];//修改图片偏移量，上下，左右必须为相反数，否则图片会被压缩
            [viewController.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, 0)];//修改文字偏移量
        }

        if (![viewController isKindOfClass:UINavigationController.class]) {//防止UIImagePickerController崩
            BaseNavigationVC *nav = [BaseNavigationVC.alloc initWithRootViewController:viewController];
            nav.title = config.title;
            [self.childVCMutArr replaceObjectAtIndex:i withObject:nav];//替换元素，每个VC加Navigation
        }
    }
    /// ❤️这句话走了以后 才会有self.tabBar
    self.viewControllers = self.childVCMutArr;
    
    for (UIView *subView in self.tabBar.subviews) {
        if ([subView isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [subView animationAlert];//图片从小放大
            [self.UITabBarButtonMutArr addObject:subView];
        }
    }
    /// 根据config.lottieName 方法-config.lottieName:offsetY:lottieName:内部做了判空处理
    for (int i = 0; i < self.childVCMutArr.count; i++) {
        JobsTabBarControllerConfig *config = (JobsTabBarControllerConfig *)self.tabBarControllerConfigMutArr[i];
        [self.tabBar addLottieImage:i
                            offsetY:-config.humpOffsetY / 2
                         lottieName:config.lottieName];
    }
    
    //初始显示【具备Lottie播放条件才进行相关初始化操作】
    if (self.firstUI_selectedIndex < self.viewControllers.count) {
        self.selectedIndex = self.firstUI_selectedIndex;//初始显示哪个
        if ([self judgeLottieWithIndex:self.selectedIndex]) {
            [self.childVCMutArr[self.firstUI_selectedIndex] lottieImagePlay];
            [self.tabBar animationLottieImage:self.firstUI_selectedIndex];
        }
    }
}
#pragma mark —— 手势左右滑动以切换TabbarControl挂载的ViewController
- (void)panGestureRecognizer:(UIPanGestureRecognizer *)pan{
    if (self.transitionCoordinator) {
        return;
    }
    
    if (pan.state == UIGestureRecognizerStateBegan ||
        pan.state == UIGestureRecognizerStateChanged){
        [self beginInteractiveTransitionIfPossible:pan];
    }
}

-(void)beginInteractiveTransitionIfPossible:(UIPanGestureRecognizer *)sender{
    CGPoint translation = [sender translationInView:self.view];

    NSLog(@"FromIndex = %lu",(unsigned long)self.selectedIndex);
    /// ❤️需要被跳开的item的逻辑❤️
    for (NSNumber *indexNUM in self.jumpIndexArr) {
        if (indexNUM.integerValue >= 0 ||
            indexNUM.integerValue <= self.tabBar.items.count - 1) {
            
            {// 手势从左到右 和 手势从右到左 的两种触发方式
                // 手势从左到右
                if (self.selectedIndex == indexNUM.integerValue - 1) {
                    if (translation.x > 0.f && self.selectedIndex > 0) {
                        self.selectedIndex --;
                    }else{
                        if (self.isJumpToNextVC) {
                            self.selectedIndex += 2;
                        }
                        // 向外回调需要做的事
                        if (self.returnObjectBlock) A = [self.returnObjectBlock(indexNUM) boolValue];
                    }return;
                }
                // 手势从右到左
                if (self.selectedIndex == indexNUM.integerValue + 1) {
                    if (translation.x < 0.f && self.selectedIndex + 1 < self.viewControllers.count) {
                        self.selectedIndex ++;
                    }else{
                        if (self.isJumpToNextVC) {
                            self.selectedIndex -= 2;
                        }
                        // 向外回调需要做的事
                        if (self.returnObjectBlock) A = [self.returnObjectBlock(indexNUM) boolValue];
                    }return;
                }
            }
        }
    }
    
    if (translation.x > 0.f && self.selectedIndex > 0) {
        self.selectedIndex --;
    }else if (translation.x < 0.f && self.selectedIndex + 1 < self.viewControllers.count) {
        self.selectedIndex ++;
    }else{}
    
    [self forcedLoginIndex:self.selectedIndex];
    
    NSLog(@"ToIndex = %lu",(unsigned long)self.selectedIndex);
}
#pragma mark —— TabBarItem的相关手势
-(void)长按手势做什么:(UILongPressGestureRecognizer *)longPressGR{
    if (self.isFeedbackGenerator) {
        [NSObject feedbackGenerator];//震动反馈
    }

    [JobsPullListAutoSizeView initWithTargetView:self.UITabBarButtonMutArr[longPressGR.view.tag]
                                      dataMutArr:self.pullListAutoSizeViewMutArr];
}

-(void)添加长按手势{
    for (UIView *subView in self.UITabBarButtonMutArr) {
        subView.tag = [self.UITabBarButtonMutArr indexOfObject:subView];
        
        subView.numberOfTouchesRequired = 1;
        subView.numberOfTapsRequired = 1;/// ⚠️注意：如果要设置长按手势，此属性必须设置为0⚠️
        subView.minimumPressDuration = 0.1;
        subView.numberOfTouchesRequired = 1;
        subView.allowableMovement = 1;
        subView.userInteractionEnabled = YES;
        subView.target = self;
        subView.longPressGR_SelImp.selector = [self jobsSelectorBlock:^(id _Nullable target, UILongPressGestureRecognizer *_Nullable longPressGR) {
            NSLog(@"");
            switch (longPressGR.state) {
                case UIGestureRecognizerStatePossible:{
                    NSLog(@"没有触摸事件发生，所有手势识别的默认状态");
                }break;
                case UIGestureRecognizerStateBegan:{
                    //长按手势
                    [self 长按手势做什么:longPressGR];
                    NSLog(@"一个手势已经开始  但尚未改变或者完成时");
                }break;
                case UIGestureRecognizerStateChanged:{
                    NSLog(@"手势状态改变");
                }break;
                case UIGestureRecognizerStateEnded:{// = UIGestureRecognizerStateRecognized
                    NSLog(@"手势完成");
                }break;
                case UIGestureRecognizerStateCancelled:{
                    NSLog(@"手势取消，恢复至Possible状态");
                }break;
                case UIGestureRecognizerStateFailed:{
                    NSLog(@"手势失败，恢复至Possible状态");
                }break;
                default:
                    break;
            }
        }];
        subView.longPressGR.enabled = YES;/// 必须在设置完Target和selector以后方可开启执行
    }
}
#pragma mark —— UITabBarDelegate
/// 监听TabBarItem点击事件
- (void)tabBar:(UITabBar *)tabBar
 didSelectItem:(UITabBarItem *)item {

    if ([tabBar.items containsObject:item]) {
        
        NSUInteger index = [self.tabBar.items indexOfObject:item];
        NSLog(@"当前点击：%ld",(long)index);
        for (NSNumber *indexNUM in self.jumpIndexArr) {
            if (indexNUM.unsignedIntegerValue != index) {
                if (![self forcedLoginIndex:index]) {
                    /// 不需要进行强制登录的时候，才重新赋值刷新self.selectedIndex
                    self.selectedIndex = index;
                }
            }
        }
        // Lottie 动画
        if ([self judgeLottieWithIndex:self.selectedIndex]) {
            [self.tabBar animationLottieImage:(int)index];
        }
        // 震动反馈
        if (self.isFeedbackGenerator) {
            [self feedbackGenerator];
        }
        // 点击声音
        if (self.isPlaySound) {
            [self playSoundWithFileName:@"Sound.wav"];
        }
        // 重力弹跳动画效果
        if (self.isShakerAnimation) {
            [item.badgeView shakerAnimationWithDuration:2 height:20];
        }
        // 点击增加标数
        if (self.isOpenPPBadge) {
            [item pp_increase];
        }
        // 图片从小放大
        if (self.isAnimationAlert) {
            [self.UITabBarButtonMutArr[index] animationAlert];
        }
    }
}
#pragma mark - UITabBarControllerDelegate
/**
 【点击TabBarItem进行切换】return YES可以切换 | return NO 不可切换
 
 【调用先后次序】
    ①- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item；
 
    ②- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController；
 
 【📢注意】在①中，如果对self.selectedIndex进行修改，那么在②中，设置返回值为NO无效
 */
- (BOOL)tabBarController:(UITabBarController *)tabBarController
shouldSelectViewController:(UIViewController *)viewController {

    NSInteger index = [self.childVCMutArr indexOfObject:viewController];
    
    if ([viewController isKindOfClass:UIViewController.class] &&
        [self judgeLottieWithIndex:index]) {
        [viewController lottieImagePlay];
    }
    
    if (self.returnObjectBlock) A = [self.returnObjectBlock(@(index)) boolValue];
    return [self forcedLoginIndex:index] ? (A && self.isLogin) : A;
}

- (id<UIViewControllerAnimatedTransitioning>)tabBarController:(UITabBarController *)tabBarController
           animationControllerForTransitionFromViewController:(UIViewController *)fromVC
                                             toViewController:(UIViewController *)toVC{
    // 打开注释 可以屏蔽点击item时的动画效果
//    if (self.panGestureRecognizer.state == UIGestureRecognizerStateBegan || self.panGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        NSArray *viewControllers = tabBarController.viewControllers;
        return [TransitionAnimation.alloc initWithTargetEdge: [viewControllers indexOfObject:toVC] > [viewControllers indexOfObject:fromVC] ? UIRectEdgeLeft : UIRectEdgeRight];
//    }
//    else{
//        return nil;
//    }
}

- (id<UIViewControllerInteractiveTransitioning>)tabBarController:(UITabBarController *)tabBarController
                     interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController{
    if (self.view.panGR.state == UIGestureRecognizerStateBegan ||
        self.view.panGR.state == UIGestureRecognizerStateChanged) {
        return [TransitionController.alloc initWithGestureRecognizer:self.view.panGR];
    }else {
        return nil;
    }
}
#pragma mark —— lazyLoad
@synthesize viewModel = _viewModel;
-(UIViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = UIViewModel.new;
        _viewModel.bgCor = JobsWhiteColor;
        _viewModel.bgImage = isiPhoneX_series() ? JobsIMG(@"底部导航栏背景(刘海屏)") : JobsIMG(@"底部导航栏背景(非刘海屏)");
        _viewModel.isTranslucent = NO;
        _viewModel.offsetHeight = JobsWidth(5);
    }return _viewModel;
}
@synthesize myTabBar = _myTabBar;
-(void)setMyTabBar:(JobsTabBar *)myTabBar{
    _myTabBar = myTabBar;
}

-(JobsTabBar *)myTabBar{
    if (!_myTabBar) {
        _myTabBar = JobsTabBar.new;
        _myTabBar.backgroundImage = JobsIMG(@"底部导航栏背景(刘海屏)");
        _myTabBar.backgroundColor = UIColor.yellowColor;
        [_myTabBar richElementsInViewWithModel:self.viewModel];
        [self setValue:_myTabBar
                forKey:@"tabBar"];//KVC 进行替换
    }return _myTabBar;
}

-(NSMutableArray<UIView *> *)UITabBarButtonMutArr{
    if (!_UITabBarButtonMutArr) {
        _UITabBarButtonMutArr = NSMutableArray.array;
    }return _UITabBarButtonMutArr;
}

-(NSMutableArray<UIViewController *> *)childVCMutArr{
    if (!_childVCMutArr) {
        _childVCMutArr = NSMutableArray.array;
    }return _childVCMutArr;
}

-(NSMutableArray<JobsTabBarControllerConfig *> *)tabBarControllerConfigMutArr{
    if (!_tabBarControllerConfigMutArr) {
        _tabBarControllerConfigMutArr = NSMutableArray.array;
    }return _tabBarControllerConfigMutArr;
}

-(NSMutableArray<UIViewModel *> *)pullListAutoSizeViewMutArr{
    if (!_pullListAutoSizeViewMutArr) {
        _pullListAutoSizeViewMutArr = NSMutableArray.array;
        
        {
            UIViewModel *viewModel = UIViewModel.new;
            viewModel.image = JobsIMG(@"");
            viewModel.textModel.text = @"111";
            [_pullListAutoSizeViewMutArr addObject:viewModel];
        }
        
        {
            UIViewModel *viewModel = UIViewModel.new;
            viewModel.image = JobsIMG(@"");
            viewModel.textModel.text = @"222";
            [_pullListAutoSizeViewMutArr addObject:viewModel];
        }
        
        {
            UIViewModel *viewModel = UIViewModel.new;
            viewModel.image = JobsIMG(@"");
            viewModel.textModel.text = @"333";
            [_pullListAutoSizeViewMutArr addObject:viewModel];
        }
        
    }return _pullListAutoSizeViewMutArr;
}

@end
