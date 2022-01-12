//
//  BaseVCProtocol.h
//  DouDong-II
//
//  Created by Jobs on 2021/3/22.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BaseViewProtocol.h"
#import "JobsBlock.h"

#if __has_include(<SPAlertController/SPAlertController.h>)
#import <SPAlertController/SPAlertController.h>
#else
#import "SPAlertController.h"
#endif

@class JobsBasePopupView;

typedef enum : NSUInteger {
    ComingStyle_PUSH = 0,
    ComingStyle_PRESENT
} ComingStyle;

NS_ASSUME_NONNULL_BEGIN

@protocol BaseViewControllerProtocol<BaseViewProtocol>

@optional
/// UI
@property(nonatomic,weak)UIViewController *fromVC;
@property(nonatomic,strong,nullable)SPAlertController *alertController;
@property(nonatomic,assign)ComingStyle pushOrPresent;
@property(nonatomic,assign)BOOL setupNavigationBarHidden;
/// 设置GKNavigationBar
-(void)setGKNav;

@end

NS_ASSUME_NONNULL_END
