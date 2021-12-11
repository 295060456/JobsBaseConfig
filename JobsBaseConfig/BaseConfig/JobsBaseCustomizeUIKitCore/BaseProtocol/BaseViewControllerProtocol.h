//
//  BaseVCProtocol.h
//  DouDong-II
//
//  Created by Jobs on 2021/3/22.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BaseProtocol.h"
#import "AABlock.h"

#if __has_include(<SPAlertController/SPAlertController.h>)
#import <SPAlertController/SPAlertController.h>
#else
#import "SPAlertController.h"
#endif

#if __has_include(<ReactiveObjC/ReactiveObjC.h>)
#import <ReactiveObjC/ReactiveObjC.h>
#else
#import "ReactiveObjC.h"
#endif

typedef enum : NSUInteger {
    ComingStyle_PUSH = 0,
    ComingStyle_PRESENT
} ComingStyle;

NS_ASSUME_NONNULL_BEGIN

@protocol BaseViewControllerProtocol <BaseProtocol>

@optional
/// UI
@property(nonatomic,weak)UIViewController *rootVC;
@property(nonatomic,strong)UIImageView *bgImageView;
@property(nonatomic,strong)SPAlertController *alertController;
/// Data
@property(nonatomic,strong)id requestParams;
@property(nonatomic,strong)RACSignal *reqSignal;
@property(nonatomic,assign)ComingStyle pushOrPresent;
@property(nonatomic,assign)BOOL setupNavigationBarHidden;
@property(nonatomic,assign)NSInteger __block currentPage;
@property(nonatomic,copy)MKDataBlock viewControllerBlock;

-(void)setGKNav;
/*
    用于以此为基类的控制器上所有数据的回调,当然也可以用NSObject分类的方法定位于：@interface NSObject (CallBackInfoByBlock)
 */
-(void)actionBlockViewController:(MKDataBlock)viewControllerBlock;

@end

NS_ASSUME_NONNULL_END
