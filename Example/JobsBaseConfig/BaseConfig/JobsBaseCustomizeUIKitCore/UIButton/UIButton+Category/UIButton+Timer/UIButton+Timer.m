//
//  UIButton+Timer.m
//  SelectorBlock
//
//  Created by Jobs on 2021/3/23.
//

#import "UIButton+Timer.h"

@implementation UIButton (Timer)

static char *UIButton_Timer_btnTimerConfig = "UIButton_Timer_btnTimerConfig";
@dynamic btnTimerConfig;

static char *UIButton_CountDownBtn_countDownClickEventBlock = "UIButton_CountDownBtn_countDownClickEventBlock";
@dynamic countDownClickEventBlock;

static char *UIButton_CountDownBtn_timerRunningBlock = "UIButton_CountDownBtn_timerRunningBlock";
@dynamic timerRunningBlock;

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-designated-initializers"
-(instancetype)initWithConfig:(nullable ButtonTimerConfigModel *)config{
    if (self = [super init]) {
        self.btnTimerConfig = config;//为空则加载默认配置，self.btnTimerConfig 有容错机制
        [self setLayerConfigReadyPlay];
        [self setTitleReadyPlay];
        [self setTitleLabelConfigReadyPlay];
        // CountDownBtn 的点击事件回调
        BtnClickEvent(self,if (self.countDownClickEventBlock) self.countDownClickEventBlock(self););
    }return self;
}
#pragma clang diagnostic pop
#pragma mark —— UI配置
/// 计时器未开始
-(void)setLayerConfigReadyPlay{
    self.layer.borderColor = self.btnTimerConfig.readyPlayValue.layerBorderColour.CGColor;
    self.layer.cornerRadius = self.btnTimerConfig.readyPlayValue.layerCornerRadius;
    self.layer.borderWidth = self.btnTimerConfig.readyPlayValue.layerBorderWidth;
    self.backgroundColor = self.btnTimerConfig.readyPlayValue.bgCor;
}

-(void)setTitleLabelConfigReadyPlay{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self titleFont:self.btnTimerConfig.readyPlayValue.font];
    [self normalTitleColor:self.btnTimerConfig.readyPlayValue.textCor];
    [self makeBtnLabelByShowingType:self.btnTimerConfig.labelShowingType];
}
/// 计时器进行中设置Layer层
-(void)setLayerConfigRunning{
    self.layer.borderColor = self.btnTimerConfig.runningValue.layerBorderColour.CGColor;
    self.layer.cornerRadius = self.btnTimerConfig.runningValue.layerCornerRadius;
    self.layer.borderWidth = self.btnTimerConfig.runningValue.layerBorderWidth;
}
/// 计时器进行中设置TitleLabel
-(void)setTitleLabelConfigRunning{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self titleFont:self.btnTimerConfig.runningValue.font];
    [self normalTitleColor:self.btnTimerConfig.runningValue.textCor];
    [self makeBtnLabelByShowingType:self.btnTimerConfig.labelShowingType];
}
/// 计时器结束
-(void)setLayerConfigEnd{
    self.layer.borderColor = self.btnTimerConfig.endValue.layerBorderColour.CGColor;
    self.layer.cornerRadius = self.btnTimerConfig.endValue.layerCornerRadius;
    self.layer.borderWidth = self.btnTimerConfig.endValue.layerBorderWidth;
}

-(void)setTitleLabelConfigEnd{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.numberOfLines = 1;//不加这一句会有UI异常
    [self titleFont:self.btnTimerConfig.endValue.font];
    [self normalTitleColor:self.btnTimerConfig.endValue.textCor];
    [self makeBtnLabelByShowingType:self.btnTimerConfig.labelShowingType];
}
#pragma mark —— 设置普通标题或者富文本标题
/// 计时器未开始
-(void)setTitleReadyPlay{
    if (self.btnTimerConfig.readyPlayValue.titleAttributedDataMutArr.count ||
        self.btnTimerConfig.readyPlayValue.attributedText) {
        //富文本
        [self normalAttributedTitle:self.btnTimerConfig.readyPlayValue.attributedText];
    }else{
        [self normalTitle:self.btnTimerConfig.readyPlayValue.text];
    }
}
/// 计时器进行中
-(void)setTitleRunning{
    if (self.btnTimerConfig.runningValue.titleAttributedDataMutArr.count ||
        self.btnTimerConfig.runningValue.attributedText) {
        //富文本
        [self normalAttributedTitle:self.btnTimerConfig.runningValue.attributedText];
    }else{
        [self normalTitle:self.btnTimerConfig.runningValue.text];
    }
    NSLog(@"☕️☕️☕️☕️ = %@",self.btnTimerConfig.runningValue.text);
}
/// 计时器结束
-(void)setTitleEnd{
    if (self.btnTimerConfig.endValue.titleAttributedDataMutArr.count ||
        self.btnTimerConfig.endValue.attributedText) {
        //富文本
        [self normalAttributedTitle:self.btnTimerConfig.endValue.attributedText];
    }else{
        [self normalTitle:self.btnTimerConfig.endValue.text];
    }
}
#pragma mark —— 时间方法
/// 开启计时【用初始化时间】
-(void)startTimer{
    [self startTimer:self.btnTimerConfig.count];
}
/// 开启计时【从某个时间】
-(void)startTimer:(NSInteger)timeCount{
    [self setTitleReadyPlay];
    [self setLayerConfigReadyPlay];
    [self setTitleLabelConfigReadyPlay];
    self.btnTimerConfig.count = timeCount;
    //启动方式——1
//    [NSTimerManager nsTimeStart:self.nsTimerManager
//                    withRunLoop:nil];
    //启动方式——2
    [self.btnTimerConfig.timerManager nsTimeStartSysAutoInRunLoop];
}
/// 核心方法
-(void)timerRuning:(long)currentTime {
    //其他一些基础设置
    {
        self.enabled = self.btnTimerConfig.isCanBeClickWhenTimerCycle;//倒计时期间，默认不接受任何的点击事件
        self.backgroundColor = self.btnTimerConfig.runningValue.bgCor;
    }

    // 清除上一次拼装的数据
    if (self.btnTimerConfig.formatTimeStr.length > 0 &&
        [self.btnTimerConfig.runningValue.text containsString:self.btnTimerConfig.formatTimeStr]) {
        self.btnTimerConfig.runningValue.text = [self.btnTimerConfig.runningValue.text stringByReplacingOccurrencesOfString:self.btnTimerConfig.formatTimeStr withString:@""];
    }
    //显示数据的二次封装
    {
        // 显示的时间格式
        switch (self.btnTimerConfig.showTimeType) {
            case ShowTimeType_SS:{
                self.btnTimerConfig.formatTimeStr = [NSString stringWithFormat:@"%ld %@",(long)currentTime,Internationalization(@"Sec")];
            }break;
            case ShowTimeType_MMSS:{
                self.btnTimerConfig.formatTimeStr = [NSObject getMMSSFromStr:[NSString stringWithFormat:@"%ld",(long)currentTime]];
            }break;
            case ShowTimeType_HHMMSS:{
                self.btnTimerConfig.formatTimeStr = [NSObject getHHMMSSFromStr:[NSString stringWithFormat:@"%ld",(long)currentTime]];
            }break;
            default:
                self.btnTimerConfig.formatTimeStr = Internationalization(@"异常值");
                break;
        }
        //字符串拼接
        switch (self.btnTimerConfig.cequenceForShowTitleRuningStrType) {
            case CequenceForShowTitleRuningStrType_front:{//首在前
                self.btnTimerConfig.runningValue.text = [self.btnTimerConfig.runningValue.text stringByAppendingString:self.btnTimerConfig.formatTimeStr];
            }break;
            case CequenceForShowTitleRuningStrType_tail:{//首在后
                self.btnTimerConfig.runningValue.text = [self.btnTimerConfig.formatTimeStr stringByAppendingString:self.btnTimerConfig.runningValue.text];
            }break;
            default:
                self.btnTimerConfig.runningValue.text = Internationalization(@"异常值");
                break;
        }
    }
    // 富文本：锚定 titleRunningStr 和 formatTimeStr
    if(self.btnTimerConfig.runningValue.titleAttributedDataMutArr.count ||
       self.btnTimerConfig.runningValue.attributedText){
        //富文本 每一次时间触发方法都刷新数据并赋值
        NSMutableArray *tempDataMutArr = NSMutableArray.array;
        
        // 亟待补充 见 RichTextConfig 的使用示例
        
        switch (self.btnTimerConfig.cequenceForShowTitleRuningStrType) {
            case CequenceForShowTitleRuningStrType_front:{
                
            }break;
            case CequenceForShowTitleRuningStrType_tail:{
                
            }break;
            default:
                break;
        }
        self.btnTimerConfig.runningValue.attributedText = [self richTextWithDataConfigMutArr:tempDataMutArr];
    }
    
    [self setTitleRunning];// 核心方法
    [self setLayerConfigRunning];
    [self setTitleLabelConfigRunning];
}

-(void)timerDestroy{
    self.enabled = YES;
    NSLog(@"self.btnTimerConfig.titleEndStr = %@",self.btnTimerConfig.endValue.text);
    [self setTitleEnd];
    [self setTitleLabelConfigEnd];
    [self setLayerConfigEnd];
    self.backgroundColor = self.btnTimerConfig.endValue.bgCor;
    [self.btnTimerConfig.timerManager nsTimeDestroy];
}
#pragma mark —— Block
/// 点击事件回调，就不要用系统的addTarget/action/forControlEvents
-(void)actionCountDownClickEventBlock:(MKDataBlock _Nullable)countDownClickEventBlock{
    self.countDownClickEventBlock = countDownClickEventBlock;
}
/// 定时器运行时的Block
-(void)actionBlockTimerRunning:(MKDataBlock _Nullable)timerRunningBlock{
    self.timerRunningBlock = timerRunningBlock;
}
#pragma mark SET | GET
#pragma mark —— @property(nonatomic,strong)ButtonTimerModel *btnTimerConfig;
-(ButtonTimerConfigModel *)btnTimerConfig{
    ButtonTimerConfigModel *BtnTimerConfig = objc_getAssociatedObject(self, UIButton_Timer_btnTimerConfig);
    if (!BtnTimerConfig) {
        BtnTimerConfig = ButtonTimerConfigModel.new;
        // 这里添加默认配置
//        BtnTimerConfig.
        objc_setAssociatedObject(self,
                                 UIButton_Timer_btnTimerConfig,
                                 BtnTimerConfig,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    // 定时器运行时的Block
    @jobs_weakify(self)
    [BtnTimerConfig actionBlocktimerWorking:^(TimerProcessModel *data) {
        @jobs_strongify(self)
        switch (data.timerProcessType) {
            case TimerProcessType_ready:{
                
            }break;
            case TimerProcessType_running:{
                data.data.timerStyle = BtnTimerConfig.countDownBtnType;
                NSLog(@"DDD = %f",data.data.anticlockwiseTime);
                [self timerRuning:(long)data.data.anticlockwiseTime];//倒计时方法
            }break;
            case TimerProcessType_end:{
                [self timerDestroy];
            }break;
            default:
                break;
        }
        
        if (self.timerRunningBlock) self.timerRunningBlock(data);
    }];return BtnTimerConfig;
}

-(void)setBtnTimerConfig:(ButtonTimerConfigModel *)btnTimerConfig{
    objc_setAssociatedObject(self,
                             UIButton_Timer_btnTimerConfig,
                             btnTimerConfig,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,copy)MKDataBlock countDownClickEventBlock;
-(MKDataBlock)countDownClickEventBlock{
    return objc_getAssociatedObject(self, UIButton_CountDownBtn_countDownClickEventBlock);
}

-(void)setCountDownClickEventBlock:(MKDataBlock)countDownClickEventBlock{
    objc_setAssociatedObject(self,
                             UIButton_CountDownBtn_countDownClickEventBlock,
                             countDownClickEventBlock,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}
#pragma mark —— @property(nonatomic,copy)MKDataBlock timerRunningBlock;// 定时器运行时的Block
-(MKDataBlock)timerRunningBlock{
    return objc_getAssociatedObject(self, UIButton_CountDownBtn_timerRunningBlock);
}

-(void)setTimerRunningBlock:(MKDataBlock)timerRunningBlock{
    objc_setAssociatedObject(self,
                             UIButton_CountDownBtn_timerRunningBlock,
                             timerRunningBlock,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end
