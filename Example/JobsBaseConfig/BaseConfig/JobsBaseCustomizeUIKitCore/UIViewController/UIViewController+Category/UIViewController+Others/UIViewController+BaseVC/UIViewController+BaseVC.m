//
//  UIViewController+BaseVC.m
//  UBallLive
//
//  Created by Jobs on 2020/10/12.
//

#import "UIViewController+BaseVC.h"

@implementation UIViewController (BaseVC)
// BaseViewControllerProtocol_dynamic
#pragma mark —— 一些功能性
-(void)showUserInfo{
    if (JobsDebug) {
        UIViewModel *viewModel = [self configViewModelWithTitle:@"用户信息展示(开发测试专用)" subTitle:nil];
        viewModel.cls = JobsShowObjInfoVC.class;
        viewModel.requestParams = self.readUserInfo;
        
        [self forceComingToPushVC:viewModel.cls.new
                    requestParams:viewModel];// 测试专用
    }
}
/// 配置GKNavigationBar
-(void)setGKNav{
    self.gk_navTitle = self.viewModel.textModel.text;
    self.gk_navTitleColor = self.viewModel.textModel.textCor ? : HEXCOLOR(0xD3B698);
    self.gk_navTitleFont = self.viewModel.textModel.font ? : UIFontWeightRegularSize(JobsWidth(18));
    self.gk_navBackgroundColor = self.viewModel.bgCor;
    self.gk_navBackgroundImage = self.viewModel.bgImage;
    self.gk_navLineHidden = YES;
    self.gk_navItemLeftSpace = 20;
    [self hideNavLine];
}
/// 配置GKNavigationBar的返回按钮
-(void)setGKNavBackBtn{
    if (self.navigationController.viewControllers.count - 1) {//从上个页面推过来才有返回键，直接的个人中心是没有的
        self.gk_backImage = JobsIMG(@"全局返回箭头");/// 设置返回按钮图片（优先级高于gk_backStyle）
        self.gk_backStyle = GKNavigationBarBackStyleBlack;
        self.gk_navLeftBarButtonItem = [UIBarButtonItem.alloc initWithCustomView:self.backBtnCategory];
    }
}
/// 铺满全屏展示的策略
-(void)fullScreenConstraintTargetView:(nonnull __kindof UIView *)view
                        topViewOffset:(CGFloat)topViewOffset{
    /// 防止调用崩溃
    if (![self.view.subviews containsObject:view]) {
        [self.view addSubview:view];
    }
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        if (self.setupNavigationBarHidden &&
            (!self.gk_navBarAlpha || self.gk_navigationBar.hidden || !self.gk_navigationBar.alpha)) {// 系统、GK均隐藏
            make.top.equalTo(self.view).offset(topViewOffset);
        }else{
            if (!self.setupNavigationBarHidden && (!self.gk_navBarAlpha || self.gk_navigationBar.hidden || !self.gk_navigationBar.alpha) ) {// 用系统的导航栏
                make.top.equalTo(self.view).offset(JobsNavigationBarAndStatusBarHeight(nil) + topViewOffset);
            }else if (self.setupNavigationBarHidden && (self.gk_navBarAlpha || !self.gk_navigationBar.hidden || self.gk_navigationBar.alpha)) {// 用GK的导航栏
                make.top.equalTo(self.gk_navigationBar.mas_bottom).offset(topViewOffset);
            }else{
                make.top.equalTo(self.view).offset(topViewOffset);
            }
        }
        make.left.right.bottom.equalTo(self.view);
    }];
}
#pragma mark —— present
/// 简洁版强制present展现一个控制器页面【不需要正向传参】
-(void)comingToPresentVC:(UIViewController *_Nonnull)viewController{
    [UIViewController comingFromVC:self
                              toVC:viewController
                       comingStyle:ComingStyle_PRESENT
                 presentationStyle:UIDevice.currentDevice.systemVersion.doubleValue >= 13.0 ? UIModalPresentationAutomatic : UIModalPresentationFullScreen
                     requestParams:nil
          hidesBottomBarWhenPushed:YES
                          animated:YES
                           success:nil];
}
/// 简洁版强制present展现一个控制器页面【需要正向传参】
-(void)comingToPresentVC:(UIViewController *_Nonnull)viewController
           requestParams:(id _Nullable)requestParams{
    [UIViewController comingFromVC:self
                              toVC:viewController
                       comingStyle:ComingStyle_PRESENT
                 presentationStyle:UIDevice.currentDevice.systemVersion.doubleValue >= 13.0 ? UIModalPresentationAutomatic : UIModalPresentationFullScreen
                     requestParams:requestParams
          hidesBottomBarWhenPushed:YES
                          animated:YES
                           success:nil];
}
#pragma mark —— push
/// 简洁版强制push展现一个控制器页面【不需要正向传参】
-(void)comingToPushVC:(UIViewController *_Nonnull)viewController{
    [UIViewController comingFromVC:self
                              toVC:viewController
                       comingStyle:ComingStyle_PUSH
                 presentationStyle:UIDevice.currentDevice.systemVersion.doubleValue >= 13.0 ? UIModalPresentationAutomatic : UIModalPresentationFullScreen
                     requestParams:nil
          hidesBottomBarWhenPushed:YES
                          animated:YES
                           success:nil];
}
/// 简洁版强制push展现一个控制器页面【需要正向传参】
-(void)comingToPushVC:(UIViewController *_Nonnull)viewController
        requestParams:(id _Nullable)requestParams{
    [UIViewController comingFromVC:self
                              toVC:viewController
                       comingStyle:ComingStyle_PUSH
                 presentationStyle:UIDevice.currentDevice.systemVersion.doubleValue >= 13.0 ? UIModalPresentationAutomatic : UIModalPresentationFullScreen
                     requestParams:requestParams
          hidesBottomBarWhenPushed:YES
                          animated:YES
                           success:nil];
}
/**
 ❤️【强制推控制器】❤️
 1、自定义是PUSH还是PRESENT展现控制器，如果自定义PUSH但是navigationController不存在，则换用PRESENT展现控制器
 2、定位于@implementation UINavigationController (SafeTransition)，交换系统的push方法，防止某些情况下系统资源紧张导致的多次推控制器
 @param fromVC 从A控制器（上一个页面）
 @param toVC  推到B控制器 （下一个页面）
 @param comingStyle 自定义展现的方式
 @param presentationStyle  如果是PRESENT情况下的一个系统参数设定
 @param requestParams  A控制器—>B控制器，正向传值
 @param hidesBottomBarWhenPushed 跳转子页面的时候隐藏tabbar
 @param animated  是否动画展现
 @param successBlock 在推控制器之前，反向block(B控制器），以便对B控制器的一些自定义修改
 */
+(instancetype _Nullable)comingFromVC:(UIViewController *_Nonnull)fromVC // 上一个页面
                                 toVC:(UIViewController *_Nonnull)toVC // 下一个页面
                          comingStyle:(ComingStyle)comingStyle
                    presentationStyle:(UIModalPresentationStyle)presentationStyle
                        requestParams:(id _Nullable)requestParams
             hidesBottomBarWhenPushed:(BOOL)hidesBottomBarWhenPushed
                             animated:(BOOL)animated
                              success:(jobsByIDBlock _Nullable)successBlock{
    if (toVC) {
        if([toVC isKindOfClass:UINavigationController.class]){
            UINavigationController *navVC = (UINavigationController *)toVC;
            navVC.rootViewController.requestParams = requestParams;
            navVC.rootViewController.fromVC = fromVC;// 【承上启下】下一个页面记录是从哪里来的
        }else{
            toVC.requestParams = requestParams;
            NSLog(@"%@",toVC.requestParams);
            toVC.fromVC = fromVC;// 【承上启下】下一个页面记录是从哪里来的
        }
        @jobs_weakify(fromVC)
        switch (comingStyle) {
            case ComingStyle_PUSH:{
                if (fromVC.navigationController) {
                    toVC.pushOrPresent = ComingStyle_PUSH;
                    if (successBlock) successBlock(toVC);
                    toVC.hidesBottomBarWhenPushed = hidesBottomBarWhenPushed;//下面有黑条
                    [weak_fromVC.navigationController pushViewController:toVC
                                                                animated:animated];
                }else{
                    toVC.pushOrPresent = ComingStyle_PRESENT;
                    //iOS_13中modalPresentationStyle的默认改为UIModalPresentationAutomatic,而在之前默认是UIModalPresentationFullScreen
                    toVC.modalPresentationStyle = presentationStyle;
                    if (successBlock) successBlock(toVC);
                    [weak_fromVC presentViewController:toVC
                                              animated:animated
                                            completion:^{}];
                }
            }break;
            case ComingStyle_PRESENT:{
                toVC.pushOrPresent = ComingStyle_PRESENT;
                //iOS_13中modalPresentationStyle的默认改为UIModalPresentationAutomatic,而在之前默认是UIModalPresentationFullScreen
                toVC.modalPresentationStyle = presentationStyle;
                if (successBlock) successBlock(toVC);
                [weak_fromVC presentViewController:toVC
                                          animated:animated
                                        completion:^{}];
            }break;
            default:
                NSLog(@"错误的推进方式");
                break;
        }return toVC;
    }else{
        return nil;// 为了防止多次推VC
    }
}
/// BaseViewControllerProtocol
static char *UIViewController_BaseVC_fromVC = "UIViewController_BaseVC_fromVC";
@dynamic fromVC;
#pragma mark —— <BaseViewControllerProtocol> @property(nonatomic,weak)UIViewController *fromVC;
-(UIViewController *)fromVC{
    return objc_getAssociatedObject(self, UIViewController_BaseVC_fromVC);
}

-(void)setFromVC:(UIViewController *)fromVC{
    objc_setAssociatedObject(self,
                             UIViewController_BaseVC_fromVC,
                             fromVC,
                             OBJC_ASSOCIATION_ASSIGN);
}
static char *UIViewController_BaseVC_pushOrPresent = "UIViewController_BaseVC_pushOrPresent";
@dynamic pushOrPresent;
#pragma mark —— <BaseViewControllerProtocol> @property(nonatomic,assign)ComingStyle pushOrPresent;
-(ComingStyle)pushOrPresent{
    return [objc_getAssociatedObject(self, UIViewController_BaseVC_pushOrPresent) integerValue];
}

-(void)setPushOrPresent:(ComingStyle)pushOrPresent{
    objc_setAssociatedObject(self,
                             UIViewController_BaseVC_pushOrPresent,
                             [NSNumber numberWithInteger:pushOrPresent],
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
/// UIViewModelProtocol
static char *UIViewController_BaseVC_requestParams = "UIViewController_BaseVC_requestParams";
@dynamic requestParams;
#pragma mark —— <UIViewModelProtocol> @property(nonatomic,strong)id requestParams;
-(id)requestParams{
    id RequestParams = objc_getAssociatedObject(self, UIViewController_BaseVC_requestParams);
    return RequestParams;
}

-(void)setRequestParams:(id)requestParams{
    objc_setAssociatedObject(self,
                             UIViewController_BaseVC_requestParams,
                             requestParams,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
static char *UIViewController_BaseVC_bgImage = "UIViewController_BaseVC_bgImage";
@dynamic bgImage;
#pragma mark —— <UIViewModelProtocol> @property(nonatomic,strong)UIImage *bgImage;
-(UIImage *)bgImage{
    UIImage *BgImage = objc_getAssociatedObject(self, UIViewController_BaseVC_bgImage);
    if (!BgImage) {
        BgImage = JobsIMG(@"启动页SLOGAN");
        objc_setAssociatedObject(self,
                                 UIViewController_BaseVC_bgImage,
                                 BgImage,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return BgImage;
}

-(void)setBgImage:(UIImage *)bgImage{
    objc_setAssociatedObject(self,
                             UIViewController_BaseVC_bgImage,
                             bgImage,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
static char *UIViewController_BaseVC_setupNavigationBarHidden = "UIViewController_BaseVC_setupNavigationBarHidden";
@dynamic setupNavigationBarHidden;
#pragma mark —— @property(nonatomic,assign)BOOL setupNavigationBarHidden;
-(BOOL)setupNavigationBarHidden{
    BOOL SetupNavigationBarHidden = [objc_getAssociatedObject(self, UIViewController_BaseVC_setupNavigationBarHidden) boolValue];
    return SetupNavigationBarHidden;
}

-(void)setSetupNavigationBarHidden:(BOOL)setupNavigationBarHidden{
    objc_setAssociatedObject(self,
                             UIViewController_BaseVC_setupNavigationBarHidden,
                             [NSNumber numberWithBool:setupNavigationBarHidden],
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
static char *UIViewController_BaseVC_jobsTag = "UIViewController_BaseVC_jobsTag";
@dynamic jobsTag;
#pragma mark —— @property(nonatomic,assign)NSUInteger __block jobsTag;
-(NSUInteger)jobsTag{
    return [objc_getAssociatedObject(self, UIViewController_BaseVC_jobsTag) unsignedIntegerValue];
}

-(void)setJobsTag:(NSUInteger)jobsTag{
    objc_setAssociatedObject(self,
                             UIViewController_BaseVC_jobsTag,
                             [NSNumber numberWithBool:jobsTag],
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
static char *UIViewController_BaseVC_vcLifeCycleBlock = "UIViewController_BaseVC_vcLifeCycleBlock";
@dynamic vcLifeCycleBlock;
#pragma mark —— @property(nonatomic,copy)JobsViewControllerLifeCycleBlock vcLifeCycleBlock;/// 用于检测生命周期
-(JobsViewControllerLifeCycleBlock)vcLifeCycleBlock{
    return objc_getAssociatedObject(self, UIViewController_BaseVC_vcLifeCycleBlock);
}

-(void)setVcLifeCycleBlock:(JobsViewControllerLifeCycleBlock)vcLifeCycleBlock{
    objc_setAssociatedObject(self,
                             UIViewController_BaseVC_vcLifeCycleBlock,
                             vcLifeCycleBlock,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end
