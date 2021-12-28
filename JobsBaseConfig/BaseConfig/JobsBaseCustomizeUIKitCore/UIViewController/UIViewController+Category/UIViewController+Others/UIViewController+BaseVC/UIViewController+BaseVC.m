//
//  UIViewController+BaseVC.m
//  UBallLive
//
//  Created by Jobs on 2020/10/12.
//

#import "UIViewController+BaseVC.h"

@implementation UIViewController (BaseVC)

static char *UIViewController_BaseVC_requestParams = "UIViewController_BaseVC_requestParams";
@dynamic requestParams;

static char *UIViewController_BaseVC_pushOrPresent = "UIViewController_BaseVC_pushOrPresent";
@dynamic pushOrPresent;

static char *UIViewController_BaseVC_backgroundImage = "UIViewController_BaseVC_backgroundImage";
@dynamic backgroundImage;

static char *UIViewController_BaseVC_viewModel = "UIViewController_BaseVC_viewModel";
@dynamic viewModel;

static char *UIViewController_BaseVC_fromVC = "UIViewController_BaseVC_fromVC";
@dynamic fromVC;

#pragma mark —— present
/// 简洁版强制present展现一个控制器页面【不需要正向传参】
-(void)comingToPresentVC:(UIViewController *_Nonnull)viewController{
    [UIViewController comingFromVC:self
                              toVC:viewController
                       comingStyle:ComingStyle_PRESENT
                 presentationStyle:UIModalPresentationFullScreen
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
                 presentationStyle:UIModalPresentationFullScreen
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
                 presentationStyle:UIModalPresentationFullScreen
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
                 presentationStyle:UIModalPresentationFullScreen
                     requestParams:requestParams
          hidesBottomBarWhenPushed:YES
                          animated:YES
                           success:nil];
}
/**
     推控制器的一种封装，可以适配App多语言化
     
     需要在具体的VC里面做如下配置：
     -(void)loadView{
         [super loadView];
         if ([self.requestParams isKindOfClass:UIViewModel.class]) {
             self.viewModel = (UIViewModel *)self.requestParams;
         }
     }
 */
-(void)comingToPushVC:(UIViewController *)viewController
         withNavTitle:(NSString *)navTitle{
    UIViewModel *viewModel = UIViewModel.new;
    viewModel.text = navTitle;
    viewModel.cls = viewController.class;
    [self comingToPushVC:viewController
           requestParams:viewModel];
}
/// 携带一个资源推控制器
-(void)comingToPushVC:(UIViewController *)viewController
         withNavTitle:(NSString *)navTitle
        requestParams:(id _Nullable)requestParams{
    UIViewModel *viewModel = UIViewModel.new;
    viewModel.text = navTitle;
    viewModel.cls = viewController.class;
    viewModel.data = requestParams;
    [self comingToPushVC:viewController
           requestParams:viewModel];
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
                              success:(MKDataBlock _Nullable)successBlock{
    if (toVC) {
        toVC.requestParams = requestParams;

        toVC.fromVC = fromVC;// 【承上启下】下一个页面记录是从哪里来的
        
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
#pragma mark —— @property(nonatomic,strong)id requestParams;
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
#pragma mark —— @property(nonatomic,assign)ComingStyle pushOrPresent;
-(ComingStyle)pushOrPresent{
    return [objc_getAssociatedObject(self, UIViewController_BaseVC_pushOrPresent) integerValue];
}

-(void)setPushOrPresent:(ComingStyle)pushOrPresent{
    objc_setAssociatedObject(self,
                             UIViewController_BaseVC_pushOrPresent,
                             [NSNumber numberWithInteger:pushOrPresent],
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,weak)UIViewController *fromVC;
-(UIViewController *)fromVC{
    return objc_getAssociatedObject(self, UIViewController_BaseVC_fromVC);;
}

-(void)setFromVC:(UIViewController *)fromVC{
    objc_setAssociatedObject(self,
                             UIViewController_BaseVC_fromVC,
                             fromVC,
                             OBJC_ASSOCIATION_ASSIGN);
}
#pragma mark —— @property(nonatomic,strong)UIImage *backgroundImage;
-(UIImage *)backgroundImage{
    UIImage *BackgroundImage = objc_getAssociatedObject(self, UIViewController_BaseVC_backgroundImage);
    if (!BackgroundImage) {
        BackgroundImage = KIMG(@"启动页SLOGAN");
        objc_setAssociatedObject(self,
                                 UIViewController_BaseVC_backgroundImage,
                                 BackgroundImage,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return BackgroundImage;
}

-(void)setBackgroundImage:(UIImage *)backgroundImage{
    objc_setAssociatedObject(self,
                             UIViewController_BaseVC_backgroundImage,
                             backgroundImage,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,strong)UIViewModel *viewModel;
-(UIViewModel *)viewModel{
    UIViewModel *ViewModel = objc_getAssociatedObject(self, UIViewController_BaseVC_viewModel);
    if (!ViewModel) {
        ViewModel = UIViewModel.new;
        objc_setAssociatedObject(self,
                                 UIViewController_BaseVC_viewModel,
                                 ViewModel,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return ViewModel;
}

-(void)setViewModel:(UIViewModel *)viewModel{
    objc_setAssociatedObject(self,
                             UIViewController_BaseVC_viewModel,
                             viewModel,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
