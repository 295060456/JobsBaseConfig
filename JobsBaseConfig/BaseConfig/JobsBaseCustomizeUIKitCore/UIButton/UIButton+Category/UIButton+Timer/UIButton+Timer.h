//
//  UIButton+Timer.h
//  SelectorBlock
//
//  Created by Jobs on 2021/3/23.
//

#import <UIKit/UIKit.h>
#import "JobsBlock.h"
#import "NSObject+Time.h"
#import "NSObject+RichText.h"//富文本
#import "NSObject+Extras.h"
#import "JobsTimerManager.h"//时间管理
#import "ButtonTimerDefStructure.h"
#import "ButtonTimerConfigModel.h"
#import "MacroDef_Func.h"
#import "UIButton+UI.h"

#if __has_include(<ReactiveObjC/ReactiveObjC.h>)
#import <ReactiveObjC/ReactiveObjC.h>
#else
#import "ReactiveObjC.h"
#endif

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (Timer)

@property(nonatomic,copy)MKDataBlock countDownClickEventBlock;//点击事件回调，就不要用系统的addTarget/action/forControlEvents
@property(nonatomic,copy)MKDataBlock timerRunningBlock;// 定时器运行时的Block
@property(nonatomic,strong)ButtonTimerConfigModel *btnTimerConfig;

// 定时器运行时的Block
-(void)actionBlockTimerRunning:(MKDataBlock _Nullable)timerRunningBlock;
// 点击事件回调，就不要用系统的addTarget/action/forControlEvents
-(void)actionCountDownClickEventBlock:(MKDataBlock _Nullable)countDownClickEventBlock;

-(void)startTimer:(NSInteger)timeCount;//开启计时【从某个时间】
-(void)startTimer;//开启计时【用初始化时间】
-(void)timerDestroy;//可以不结束直接掐死

-(instancetype)initWithConfig:(nullable ButtonTimerConfigModel *)config;

@end

NS_ASSUME_NONNULL_END
