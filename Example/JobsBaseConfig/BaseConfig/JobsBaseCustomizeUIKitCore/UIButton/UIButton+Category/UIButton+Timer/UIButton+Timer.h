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

#if __has_include(<Masonry/Masonry.h>)
#import <Masonry/Masonry.h>
#else
#import "Masonry.h"
#endif

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (Timer)

@property(nonatomic,strong)ButtonTimerConfigModel *btnTimerConfig;

#pragma mark —— 时间相关方法【开启定时器】
-(void)startTimer;/// 开启计时【用初始化时间】
-(void)startTimer:(NSInteger)timeCount;/// 开启计时【从某个时间】
#pragma mark —— 时间相关方法【定时器暂停】
-(void)timerSuspend;
#pragma mark —— 时间相关方法【定时器继续】
-(void)timerContinue;
#pragma mark —— 时间相关方法【定时器销毁】
-(void)timerDestroy;/// 可以不结束直接掐死

-(instancetype)initWithConfig:(nullable ButtonTimerConfigModel *)config;

@end

NS_ASSUME_NONNULL_END

/** 示例代码
 
 -(UIButton *)countDownBtn{
     if (!_countDownBtn) {
         _countDownBtn = [UIButton.alloc initWithConfig:self.btnTimerConfigModel];
         [self.view addSubview:_countDownBtn];
         [_countDownBtn mas_makeConstraints:^(MASConstraintMaker *make) {
             make.height.mas_equalTo(JobsWidth(25));
             make.center.equalTo(self.view);
         }];
         [_countDownBtn makeBtnLabelByShowingType:UILabelShowingType_03];
         
         BtnClickEvent(_countDownBtn, {
             [x startTimer];//选择时机、触发启动
             NSLog(@"🪓🪓🪓🪓🪓 = 获取验证码");
         })
         
         [_countDownBtn actionObjectBlock:^(id data) {
 //            @jobs_strongify(self)
             if ([data isKindOfClass:TimerProcessModel.class]) {
                 TimerProcessModel *model = (TimerProcessModel *)data;
                 NSLog(@"❤️❤️❤️❤️❤️%f",model.data.anticlockwiseTime);
             }
         }];
     }return _countDownBtn;
 }

 -(ButtonTimerConfigModel *)btnTimerConfigModel{
     if (!_btnTimerConfigModel) {
         _btnTimerConfigModel = ButtonTimerConfigModel.new;
         
         /// 一些通用的设置
         _btnTimerConfigModel.jobsSize = CGSizeMake(JobsWidth(100), JobsWidth(25));
         _btnTimerConfigModel.count = 5;
         _btnTimerConfigModel.showTimeType = ShowTimeType_SS;//时间显示风格
         _btnTimerConfigModel.countDownBtnType = TimerStyle_anticlockwise;/// 逆时针模式（倒计时模式）
         _btnTimerConfigModel.cequenceForShowTitleRuningStrType = CequenceForShowTitleRuningStrType_tail;
         _btnTimerConfigModel.labelShowingType = UILabelShowingType_03;/// 一行显示。不定宽、定高、定字体。宽度自适应 【单行：ByFont】
         /// 计时器未开始【静态值】
         _btnTimerConfigModel.readyPlayValue.layerBorderWidth = 0.1;
         _btnTimerConfigModel.readyPlayValue.layerCornerRadius = JobsWidth(8);
         _btnTimerConfigModel.readyPlayValue.bgCor = JobsYellowColor;
         _btnTimerConfigModel.readyPlayValue.layerBorderCor = JobsBrownColor;
         _btnTimerConfigModel.readyPlayValue.textCor = JobsBlueColor;
         _btnTimerConfigModel.readyPlayValue.text = Internationalization(@"      获取验证码       ");
         _btnTimerConfigModel.readyPlayValue.font = UIFontWeightMediumSize(13);
         /// 计时器进行中【动态值】
         _btnTimerConfigModel.runningValue.bgCor = JobsCyanColor;
         _btnTimerConfigModel.runningValue.text = Internationalization(Title12);
         _btnTimerConfigModel.runningValue.layerBorderCor = JobsRedColor;
         _btnTimerConfigModel.runningValue.textCor = JobsBlackColor;
         /// 计时器结束【静态值】
         _btnTimerConfigModel.endValue.bgCor = JobsYellowColor;
         _btnTimerConfigModel.endValue.text = Internationalization(@"    哈哈哈哈    ");
         _btnTimerConfigModel.endValue.layerBorderCor = JobsPurpleColor;
         _btnTimerConfigModel.endValue.textCor = JobsBlackColor;
         
     }return _btnTimerConfigModel;
 }
 
 /// 开始   [self.countDownBtn startTimer];
 /// 暂停 [self.countDownBtn timerSuspend];
 /// 继续 [self.countDownBtn timerContinue];
 /// 结束 [self.countDownBtn timerDestroy];

 */
