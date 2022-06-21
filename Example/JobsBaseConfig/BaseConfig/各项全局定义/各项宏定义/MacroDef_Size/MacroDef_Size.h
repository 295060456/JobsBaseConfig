//
//  MacroDef_Size.h
//  UBallLive
//
//  Created by Jobs on 2020/10/9.
//

#ifndef MacroDef_Size_h
#define MacroDef_Size_h

#import <UIKit/UIKit.h>
#import "MacroDef_SysWarning.h"
#import "MacroDef_AppDeviceScreenSize.h"

static inline CGSize JobsMainScreen(){
    return UIScreen.mainScreen.bounds.size;
}

static inline CGFloat JobsMainScreen_WIDTH(){
    return JobsMainScreen().width;
}

static inline CGFloat JobsMainScreen_HEIGHT(){
    return JobsMainScreen().height;
}

static inline CGFloat SCREEN_MAX_LENGTH(){
    return MAX(JobsMainScreen_WIDTH(), JobsMainScreen_HEIGHT());
}

static inline CGFloat SCREEN_MIN_LENGTH(){
    return MIN(JobsMainScreen_WIDTH(), JobsMainScreen_HEIGHT());
}
/// 输入原型图上的宽和高，对外输出App对应的移动设备的真实宽高
static inline CGFloat JobsWidth(CGFloat width){
    return (MIN(JobsMainScreen_WIDTH(), JobsMainScreen_HEIGHT()) / 375) * width; //375 对应原型图的宽 在iph 12 pro max 此系数 = 1.1413333333333333
}

static inline CGFloat JobsHeight(CGFloat height){
    return (JobsMainScreen_HEIGHT() / 743) * height; //743 对应原型图的高
}
#import "MacroDef_Func.h"/// 提到最前面，就会因为编译顺序的问题报错
#pragma mark —— 安全区域
/// 顶部的安全距离
static inline CGFloat JobsTopSafeAreaHeight(){
    if (@available(iOS 11.0, *)) {
        return getMainWindow().safeAreaInsets.top;
    } else return 0.f;
}
/// 底部的安全距离，全面屏手机为34pt，非全面屏手机为0pt
static inline CGFloat JobsBottomSafeAreaHeight(){
    if (@available(iOS 11.0, *)) {
        return getMainWindow().safeAreaInsets.bottom;
    } else return 0.f;
}
#pragma mark —— 状态栏高度：全面屏手机的状态栏高度为44pt，非全面屏手机的状态栏高度为20pt
/// 方法一：状态栏高度
static inline CGFloat JobsRectOfStatusbar(){
    SuppressWdeprecatedDeclarationsWarning(
        if (@available(iOS 13.0, *)){
            UIStatusBarManager *statusBarManager = getMainWindow().windowScene.statusBarManager;
            return statusBarManager.statusBarHidden ? 0 : statusBarManager.statusBarFrame.size.height;
        }else return UIApplication.sharedApplication.statusBarFrame.size.height;);
}
/// 方法二：状态栏高度
static inline CGFloat JobsStatusBarHeight(){
    if (@available(iOS 11.0, *)) {
        return getMainWindow().safeAreaInsets.top;
    } else return JobsRectOfStatusbar();
}
/// 导航栏高度
/// @param navigationController 传nil为系统默认navigationController高度；因为navigationController可以自定义高度，传自定义navigationController返回自定义的navigationController的高度
static inline CGFloat JobsNavigationHeight(UINavigationController * _Nullable navigationController){
    if (navigationController) {
        return navigationController.navigationBar.frame.size.height;
    }else return 44.f;
}
/// 状态栏 + 导航栏高度
/// 非刘海屏：状态栏高度(20.f) + 导航栏高度(44.f) = 64.f
/// 刘海屏系列：状态栏高度(44.f) + 导航栏高度(44.f) = 88.f
static inline CGFloat JobsNavigationBarAndStatusBarHeight(UINavigationController * _Nullable navigationController){
    return JobsStatusBarHeight() + JobsNavigationHeight(navigationController);
}
/// tabbar高度：全面屏手机比普通手机多34的安全区域
/// @param tabBarController 传nil为系统默认tabbar高度；因为tabBarController可以自定义高度，传自定义tabBarController返回自定义的tabBarController的高度
static inline CGFloat JobsTabBarHeight(UITabBarController * _Nullable tabBarController){
    //因为tabbar可以自定义高度，所以这个地方返回系统默认的49像素的高度
    if (tabBarController) {
        return tabBarController.tabBar.frame.size.height;
    }else return 49.f;
}
/// tabbar高度：【包括了底部安全区域的TabBar高度，一般用这个】
static inline CGFloat JobsTabBarHeightByBottomSafeArea(UITabBarController * _Nullable tabBarController){
    return JobsTabBarHeight(tabBarController) + JobsBottomSafeAreaHeight();
}
/// 除开 tabBarController 和 navigationController 的内容可用区域的大小
static inline CGFloat JobsContentAreaHeight(UITabBarController * _Nullable tabBarController,
                                            UINavigationController * _Nullable navigationController){
    CGFloat tabBarHeightByBottomSafeArea = JobsTabBarHeightByBottomSafeArea(tabBarController);
    CGFloat navigationBarAndStatusBarHeight = JobsNavigationBarAndStatusBarHeight(navigationController);
    return JobsMainScreen_HEIGHT() - tabBarHeightByBottomSafeArea - navigationBarAndStatusBarHeight;
}
/// 结构体虽然分配了空间，但是里面的成员的值是随机的，特别是如果里面有指针的话，如果不初始化而直接访问，则会造成读取非法的内存地址的错误。
/// 判定一个Size是否是CGSizeZero
static inline BOOL zeroSizeValue(CGSize sizeValue){
    return CGSizeEqualToSize(CGSizeZero, sizeValue);
}
/// 判定一个CGRect是否是CGRectZero
static inline BOOL zeroRectValue(CGRect rectValue){
    return CGRectEqualToRect(CGRectZero, rectValue);
}
/// 判定一个CGPoint是否是CGPointZero
static inline BOOL zeroPointValue(CGPoint pointValue){
    return CGPointEqualToPoint(CGPointZero, pointValue);
}
/// 构建一个四边距离相等的 UIEdgeInsets
static inline UIEdgeInsets jobsSameEdgeInset(CGFloat insets){
    return (UIEdgeInsetsMake(JobsWidth(insets),
                             JobsWidth(insets),
                             JobsWidth(insets),
                             JobsWidth(insets)));
}
/// 构建一个宽高相等的 CGSize
static inline CGSize jobsSameSize(CGFloat x){
    return CGSizeMake(JobsWidth(x), JobsWidth(x));
}
/// 构建一个XY相等的 CGPoint
static inline CGPoint jobsSamePoint(CGFloat x){
    return CGPointMake(JobsWidth(x), JobsWidth(x));
}

#endif /* MacroDef_Size_h */
