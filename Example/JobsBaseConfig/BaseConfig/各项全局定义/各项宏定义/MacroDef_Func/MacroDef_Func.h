//
//  MacroDef_Func.h
//  UBallLive
//
//  Created by Jobs on 2020/10/9.
//

#ifndef MacroDef_Func_h
#define MacroDef_Func_h

#import <UIKit/UIKit.h>
#import "MacroDef_SysWarning.h"
#import "MacroDef_Print.h"
#import "MacroDef_Notification.h"
#import "MacroDef_QUEUE.h"
#import "MacroDef_String.h"
#import "MacroDef_UserDefault.h"
#import "MacroDef_Strong@Weak.h"
#import "MacroDef_Time.h"
#import "MacroDef_Singleton.h"
#import "NSObject+WHToast.h"

#if __has_include(<WHToast/WHToast.h>)
#import <WHToast/WHToast.h>
#else
#import "WHToast.h"
#endif

static inline UIWindow *getMainWindow(){
    UIWindow *window = nil;
    //以下方法有时候会拿不到window
    if (@available(iOS 13.0, *)) {
        for (UIWindowScene* windowScene in UIApplication.sharedApplication.connectedScenes){
            if (windowScene.activationState == UISceneActivationStateForegroundActive){
                window = windowScene.windows.firstObject;
                return window;
            }
        }
    }

    if (UIApplication.sharedApplication.delegate.window) {
        window = UIApplication.sharedApplication.delegate.window;
        return window;
    }
    
    SuppressWdeprecatedDeclarationsWarning(
        if (UIApplication.sharedApplication.keyWindow) {
        window = UIApplication.sharedApplication.keyWindow;
        return window;
    });
    
    return window;
}
/**
 是否是iPhone刘海屏系列：   X系列（X/XS/XR/XS Max)、11系列（11、pro、pro max）
 @return YES 是该系列 NO 不是该系列
 */
static inline BOOL isiPhoneX_series() {
    BOOL iPhoneXSeries = NO;
    if (UIDevice.currentDevice.userInterfaceIdiom != UIUserInterfaceIdiomPhone) {
        return iPhoneXSeries;
    }
    if (@available(iOS 11.0, *)) {
        UIWindow *mainWindow = getMainWindow();
        if (mainWindow.safeAreaInsets.bottom > 0.0) {
            iPhoneXSeries = YES;
        }
    }return iPhoneXSeries;
}
/**
    1、该方法只能获取系统默认的AppDelegate；
    2、如果要获取自定义的appDelegate，则需要：
 
     AppDelegate *appDelegate;//在类定义域和实现域之外暴露
     
     -(instancetype)init{
         if (self = [super init]) {
             appDelegate = self;
         }return self;
     }
     
     获取方式：extern AppDelegate *appDelegate;
 */
static inline id getSysAppDelegate(){
    return UIApplication.sharedApplication.delegate;
}
/**
    1、该方法只能获取系统默认的SceneDelegate；
    2、如果要获取自定义的sceneDelegate，则需要：
 
     SceneDelegate *sceneDelegate;//在类定义域和实现域之外暴露
         
     -(instancetype)init{
         if (self = [super init]) {
             sceneDelegate = self;
         }return self;
     }
     
     获取方式：extern SceneDelegate *sceneDelegate;
 */
static inline id getSysSceneDelegate(){
    id sceneDelegate = nil;
    if (@available(iOS 13.0, *)) {
        sceneDelegate = UIApplication.sharedApplication.connectedScenes.allObjects.firstObject.delegate;
    }return sceneDelegate;
}
/// 弹出提示
static inline void toast(NSString *msg){
    [WHToast toastMsg:Internationalization(msg)];
}

static inline void toastErr(NSString *msg){
    [WHToast toastErrMsg:Internationalization(msg)];
}
/// 定义一些默认值
#ifndef listContainerViewDefaultOffset
#define listContainerViewDefaultOffset JobsWidth(50)
#endif

#ifndef JobsDefaultValue
#define JobsDefaultValue 0
#endif

#ifndef JobsDefaultObj
#define JobsDefaultObj Nil
#endif

#ifndef JobsDefaultSize
#define JobsDefaultSize CGSizeZero
#endif
/// 其他
#ifndef ReuseIdentifier
#define ReuseIdentifier self.class.description
#endif

#ifndef reuseIdentifier
#define reuseIdentifier(Class) Class.class.description
#endif

#ifndef AvailableSysVersion
#define AvailableSysVersion(version) @available(iOS version, *)
#endif

#ifndef JobsCellRandomCor
#define JobsCellRandomCor cell.backgroundColor = cell.contentView.backgroundColor = RandomColor;
#endif

#ifndef JobsCellCor
#define JobsCellCor(cor) cell.backgroundColor = cell.contentView.backgroundColor = cor;
#endif

#ifndef JobsCellSelfCor
#define JobsCellSelfCor(cor) self.backgroundColor = self.contentView.backgroundColor = cor;
#endif

#endif /* MacroDef_Func_h */
