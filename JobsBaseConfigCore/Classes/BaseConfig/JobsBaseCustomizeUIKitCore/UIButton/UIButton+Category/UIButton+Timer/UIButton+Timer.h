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

/** 示例代码
 
 -(UIButton *)skipBtn{
     if (!_skipBtn) {
         _skipBtn = [UIButton.alloc initWithConfig:self.btnTimerConfigModel];

         BtnClickEvent(_skipBtn, {
             [x timerDestroy];
             [self backItemClick:x];
         });
         
         [_skipBtn actionBlockTimerRunning:^(TimerProcessModel *data) {
             @jobs_strongify(self)
             NSLog(@"❤️❤️❤️❤️❤️%f",data.data.anticlockwiseTime);
         }];
         
         [self.view addSubview:_skipBtn];
         [_skipBtn mas_makeConstraints:^(MASConstraintMaker *make) {
             make.size.mas_equalTo(CGSizeMake(JobsWidth(80), JobsWidth(25)));
             make.top.equalTo(self.view).offset(JobsRectOfStatusbar());
             make.right.equalTo(self.view).offset(-JobsWidth(25));
         }];
         [self.view bringSubviewToFront:_skipBtn];
     }return _skipBtn;
 }

 -(ButtonTimerConfigModel *)btnTimerConfigModel{
     if (!_btnTimerConfigModel) {
         _btnTimerConfigModel = ButtonTimerConfigModel.new;
         
         /// 未选中状态
         [_skipBtn sd_setImageWithURL:[NSURL URLWithString:LaunchConfig.imageURLString]
                             forState:UIControlStateNormal
                     placeholderImage:LaunchConfig.image];
         [_skipBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:LaunchConfig.bgImageURLString]
                                       forState:UIControlStateNormal
                               placeholderImage:LaunchConfig.bgImage];
         /// 选中状态
         [_skipBtn sd_setImageWithURL:[NSURL URLWithString:LaunchConfig.selectedImageURLString]
                             forState:UIControlStateSelected
                     placeholderImage:LaunchConfig.selectedImage];
         [_skipBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:LaunchConfig.bgSelectedImageURLString]
                                       forState:UIControlStateSelected
                               placeholderImage:LaunchConfig.bgSelectedImage];
         /// 一些通用的设置
         _btnTimerConfigModel.count = 5;
         _btnTimerConfigModel.showTimeType = ShowTimeType_SS;//时间显示风格
         _btnTimerConfigModel.countDownBtnType = TimerStyle_anticlockwise;// 时间方向
         _btnTimerConfigModel.cequenceForShowTitleRuningStrType = CequenceForShowTitleRuningStrType_tail;//
         _btnTimerConfigModel.labelShowingType = LaunchConfig.labelShowingType;//【换行模式】
         
         /// 计时器未开始【静态值】
         _btnTimerConfigModel.readyPlayValue.layerBorderWidth = LaunchConfig.layerBorderWidth;
         _btnTimerConfigModel.readyPlayValue.layerCornerRadius = JobsWidth(25 / 2);
         _btnTimerConfigModel.readyPlayValue.bgCor = LaunchConfig.bgCor;
         _btnTimerConfigModel.readyPlayValue.layerBorderColour = LaunchConfig.layerBorderColour;
         _btnTimerConfigModel.readyPlayValue.textCor = LaunchConfig.textCor;
         _btnTimerConfigModel.readyPlayValue.text = LaunchConfig.text;
         _btnTimerConfigModel.readyPlayValue.font = LaunchConfig.font;
         _btnTimerConfigModel.readyPlayValue.attributedText = LaunchConfig.attributedText;
         /// 计时器进行中【动态值】
         _btnTimerConfigModel.runningValue.bgCor = UIColor.cyanColor;
         _btnTimerConfigModel.runningValue.text = Internationalization(Title12);
         _btnTimerConfigModel.runningValue.layerBorderColour = UIColor.redColor;
         _btnTimerConfigModel.runningValue.textCor = UIColor.blackColor;
         /// 计时器结束【静态值】
         _btnTimerConfigModel.endValue.bgCor = UIColor.yellowColor;;
         _btnTimerConfigModel.endValue.text = Internationalization(@"哈哈哈哈");
         _btnTimerConfigModel.endValue.layerBorderColour = UIColor.purpleColor;
         _btnTimerConfigModel.endValue.textCor = UIColor.blackColor;
         
     }return _btnTimerConfigModel;
 }

 
 
 */
