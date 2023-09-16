//
//  BaseViewController.m
//  JobsSearch
//
//  Created by Jobs on 2020/12/1.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController
#pragma mark —— UIViewModelProtocol
UIViewModelProtocol_synthesize
#pragma mark —— BaseViewControllerProtocol
BaseViewControllerProtocol_synthesize

- (void)dealloc{
    [NSNotificationCenter.defaultCenter removeObserver:self];
    [self.view endEditing:YES];
    if (JobsDebug) {
        toast([NSString stringWithFormat:@"%@%@",Internationalization(@"成功销毁了控制器"),NSStringFromClass(self.class)]);
        NSLog(@"%@",JobsLocalFunc);
        PrintRetainCount(self)
    }
}

- (instancetype)init{
    if (self = [super init]) {
        
    }return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil
                         bundle:(NSBundle *)nibBundleOrNil {
    if(self = [super initWithNibName:nibNameOrNil
                              bundle:nibBundleOrNil]) {

    }return self;
}

-(void)loadView{
    [super loadView];
    self.isHiddenNavigationBar = YES;
    self.setupNavigationBarHidden = YES;
    self.currentPage = 1;
    self.modalInPresentation = NO;/// 禁用下拉手势dismiss画面需要将此属性设置为YES
    if (self.vcLifeCycleBlock) self.vcLifeCycleBlock(JobsLocalFunc,nil);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBackGround];
    self.gk_statusBarHidden = NO;
    /*
     *  #pragma mark —— 全局配置 GKNavigationBar -(void)makeGKNavigationBarConfigure
     */
//    {
//        self.gk_navBackgroundColor = JobsWhiteColor;
//        self.gk_navTitleFont = [UIFont systemFontOfSize:18 weight:UIFontWeightMedium];
//        self.gk_navTitleColor = AppMainCor_01;
//        self.gk_backStyle = GKNavigationBarBackStyleBlack;
//        self.gk_navLineHidden = YES;
//    }
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    NotificationAdd(self,
                    @selector(languageSwitchNotification:),
                    LanguageSwitchNotification,
                    nil);
    if (self.vcLifeCycleBlock) self.vcLifeCycleBlock(JobsLocalFunc,nil);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"%d",self.setupNavigationBarHidden);
    self.isHiddenNavigationBar = self.setupNavigationBarHidden;
    [self.navigationController setNavigationBarHidden:self.setupNavigationBarHidden animated:animated];
    if (self.vcLifeCycleBlock) self.vcLifeCycleBlock(JobsLocalFunc,nil);
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    /// 只有是在Tabbar管理的，不含导航的根控制器才开启手势
    self.isRootVC ? [self tabBarOpenPan] : [self tabBarClosePan];
    if (self.vcLifeCycleBlock) self.vcLifeCycleBlock(JobsLocalFunc,nil);
#ifdef DEBUG
    /// 网络异步数据刷新UI会在viewDidAppear以后执行viewWillLayoutSubviews、viewDidLayoutSubviews
//    [self ifEmptyData];
#endif
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (self.vcLifeCycleBlock) self.vcLifeCycleBlock(JobsLocalFunc,nil);
    NSLog(@"%d",self.setupNavigationBarHidden);
    self.isHiddenNavigationBar = self.setupNavigationBarHidden;
    [self.navigationController setNavigationBarHidden:self.setupNavigationBarHidden animated:animated];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    if (self.vcLifeCycleBlock) self.vcLifeCycleBlock(JobsLocalFunc,nil);
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    if (self.vcLifeCycleBlock) self.vcLifeCycleBlock(JobsLocalFunc,nil);
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.view.mjRefreshTargetView.mj_footer.y = self.view.mjRefreshTargetView.contentSize.height;
    if (self.vcLifeCycleBlock) self.vcLifeCycleBlock(JobsLocalFunc,nil);
}
/**
 #  iOS 状态栏颜色的修改
 【全局修改】
  1、在Info.plist里面加入如下键值对：
     1.1、View controller-based status bar appearance : NO
     1.2、Status bar style : Light Content

  2、[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;// iOS 13 后方法被标注废弃

  1.2 和 2 任意选一个即可

 【局部修改】
  1、在Info.plist里面加入如下键值对：
  View controller-based status bar appearance ： YES //全局是NO、局部是YES
  2、@ interface BaseNavigationVC : UINavigationController
     2.1、在 BaseNavigationVC.m里面写入：
     - (UIViewController *)childViewControllerForStatusBarStyle {
             return self.topViewController;
     }
     2.2、在具体的需要修改的VC.m里面写入：
     -(UIStatusBarStyle)preferredStatusBarStyle{
         return UIStatusBarStyleLightContent;
     }
 */
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
#pragma mark —— 一些私有方法
/// 在loadView或者之前的生命周期中定义背景图片或者底色
-(void)setBackGround{
    /// 底图没有 + 底色没有
    if(!self.viewModel.bgImage && !self.viewModel.bgCor){
        self.view.backgroundColor = HEXCOLOR(0xFCFBFB);
//        NSString *corStr = self.view.backgroundColor.rgbCorStr;
        return;
    }
    /// 底图有 + 底色没有
    if(self.viewModel.bgImage && !self.viewModel.bgCor){
        self.bgImageView.alpha = 1;
        return;
    }
    /// 底图没有 + 底色有
    if(!self.viewModel.bgImage && self.viewModel.bgCor){
        self.view.backgroundColor = self.viewModel.bgCor;
//        NSString *corStr = self.view.backgroundColor.rgbCorStr;
        return;
    }
    /// 底图有 + 底色有 = 优先使用底图数据
    if(self.viewModel.bgImage && self.viewModel.bgCor){
        self.bgImageView.alpha = 1;
        return;
    }
}
#pragma mark —— UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}
#pragma mark —— BaseProtocol
/// 接收通知相应的方法【在分类或者基类中实现会屏蔽具体子类的相关实现】
-(void)languageSwitchNotification:(nonnull NSNotification *)notification{
    NSLog(@"通知传递过来的 = %@",notification.object);
}
#pragma mark —— BaseViewControllerProtocol
-(void)actionVCLifeCycleBlock:(JobsViewControllerLifeCycleBlock)vcLifeCycleBlock{
    self.vcLifeCycleBlock = vcLifeCycleBlock;
}
#pragma mark —— Set方法
@synthesize modalPresentationStyle = _modalPresentationStyle;
-(void)setModalPresentationStyle:(UIModalPresentationStyle)modalPresentationStyle{
    _modalPresentationStyle = UIModalPresentationPopover;
}
#pragma mark —— lazyLoad
-(UIImageView *)bgImageView{
    if (!_bgImageView) {
        _bgImageView = UIImageView.new;
        _bgImageView.frame = self.view.bounds;
        _bgImageView.image = self.bgImage;
        _bgImageView.userInteractionEnabled = YES;
//        self.view = _bgImageView; // 有时候不正确
        [self.view insertSubview:_bgImageView atIndex:0];
    }return _bgImageView;
}

-(UIViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = UIViewModel.new;
        _viewModel.textModel.textCor = HEXCOLOR(0x3D4A58);
        _viewModel.textModel.font = UIFontWeightRegularSize(JobsWidth(16));
    }return _viewModel;
}

@end
