//
//  ButtonTimerModel.h
//  SelectorBlock
//
//  Created by Jobs on 2021/3/23.
//

#import <Foundation/Foundation.h>
#import "UIPictureAndBackGroundCorProtocol.h"
#import "UITextModelProtocol.h"
#import "UIViewModelOthersProtocol.h"

#import "JobsBlock.h"
#import "JobsTimerManager.h"//时间管理
#import "NSObject+RichText.h"//富文本
#import "ButtonTimerDefStructure.h"
#import "MacroDef_App.h"
#import "MacroDef_Size.h"

#if __has_include(<ReactiveObjC/RACmetamacros.h>)
#import <ReactiveObjC/RACmetamacros.h>
#else
#import "RACmetamacros.h"
#endif

#if __has_include(<ReactiveObjC/RACEXTScope.h>)
#import <ReactiveObjC/RACEXTScope.h>
#else
#import "RACEXTScope.h"
#endif

#if __has_include(<ReactiveObjC/RACEXTKeyPathCoding.h>)
#import <ReactiveObjC/RACEXTKeyPathCoding.h>
#else
#import "RACEXTKeyPathCoding.h"
#endif

//#if __has_include(<ReactiveObjC/RACEXTRuntimeExtensions.h>)
//#import <ReactiveObjC/RACEXTRuntimeExtensions.h>
//#else
//#import "RACEXTRuntimeExtensions.h"
//#endif

NS_ASSUME_NONNULL_BEGIN

/// 记录过程值
@interface ButtonTimerProcessValueModel : NSObject
<
UIPictureAndBackGroundCorProtocol
,UITextModelProtocol
,UIViewModelOthersProtocol
>

@property(nonatomic,assign)TimerProcessType timerProcessType;

@end

@interface ButtonTimerConfigModel : NSObject
/**
    ❤️如果配置了富文本，则优先显示富文本属性
 **/
#pragma mark —— 一些通用的设置
//倒计时开始前的背景色直接对此控件进行赋值 backgroundColor
@property(nonatomic,strong)NSTimerManager *timerManager;
@property(nonatomic,assign)NSInteger count;// 【逆时针模式：到这个时间点结束】、【顺时针模式：从这个时间点开始】❤️默认60秒
@property(nonatomic,assign)ShowTimeType showTimeType;//时间显示风格
@property(nonatomic,assign)TimerStyle countDownBtnType;// 时间方向
@property(nonatomic,assign)CequenceForShowTitleRuningStrType cequenceForShowTitleRuningStrType;// 文本显示类型
@property(nonatomic,assign)UILabelShowingType labelShowingType;
@property(nonatomic,assign)BOOL isCanBeClickWhenTimerCycle;// 倒计时期间，默认不接受任何的点击事件
#pragma mark —— 计时器未开始【静态值】Ready
@property(nonatomic,strong)ButtonTimerProcessValueModel *readyPlayValue;
#pragma mark —— 计时器进行中【动态值】Running
@property(nonatomic,strong)ButtonTimerProcessValueModel *runningValue;
#pragma mark —— 计时器结束【静态值】End
@property(nonatomic,strong)ButtonTimerProcessValueModel *endValue;
#pragma mark —— 其他
@property(nonatomic,strong)NSString *formatTimeStr;//根据ShowTimeType格式化以后的时间【内部使用】
@property(nonatomic,strong)NSString *appendingStrByFormatTimeStr;//formatTimeStr后缀拼接的字符串。因为formatTimeStr是内部使用
/// 【Button内部使用】不要直接调用
-(void)actionBlocktimerWorking:(MKDataBlock)timerWorkingBlock;

@end

NS_ASSUME_NONNULL_END
