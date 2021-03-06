//
//  UIButton+Timer.m
//  SelectorBlock
//
//  Created by Jobs on 2021/3/23.
//

#import "UIButton+Timer.h"

@implementation UIButton (Timer)
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-designated-initializers"
-(instancetype)initWithConfig:(nullable ButtonTimerConfigModel *)config{
    if (self = [super init]) {
        self.btnTimerConfig = config;// 为空则加载默认配置，self.btnTimerConfig 有容错机制
        [self setLayerConfigReadyPlay];
        [self setTitleReadyPlay];
        [self setTitleLabelConfigReadyPlay];
        // CountDownBtn 的点击事件回调
        @jobs_weakify(self)
        [self btnClickEventBlock:^(id data) {
            @jobs_strongify(self)
            if (self.objectBlock) self.objectBlock(self);
        }];
    }return self;
}
#pragma clang diagnostic pop
#pragma mark —— 一些私有方法
/// 当设置了圆角的时候，会造成UI的一些畸形，这个地方的补偿值正好等于按钮的高的一半
-(void)extraWidth:(CGFloat)offsetWidth{
    if (self.layer.cornerRadius) {
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(self.btnTimerConfig.jobsSize.width + (offsetWidth ? : self.btnTimerConfig.widthCompensationValue));
        }];
    }
}
#pragma mark —— UI配置 1.1、【计时器未开始】设置Layer层 和 背景颜色
-(void)setLayerConfigReadyPlay{
    self.layer.borderColor = self.btnTimerConfig.readyPlayValue.layerBorderColour.CGColor;
    self.layer.cornerRadius = self.btnTimerConfig.readyPlayValue.layerCornerRadius;
    self.layer.borderWidth = self.btnTimerConfig.readyPlayValue.layerBorderWidth;
    
    self.backgroundColor = self.btnTimerConfig.readyPlayValue.bgCor;
}
#pragma mark —— UI配置 1.2、【计时器未开始】设置文字
-(void)setTitleLabelConfigReadyPlay{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleFont = self.btnTimerConfig.readyPlayValue.font;
    self.normalTitleColor = self.btnTimerConfig.readyPlayValue.textCor;
    [self makeBtnLabelByShowingType:self.btnTimerConfig.labelShowingType];
    
    [self extraWidth:JobsWidth(8)];
}
#pragma mark —— UI配置 2.1、【计时器进行中】设置Layer层 和 背景颜色
-(void)setLayerConfigRunning{
    self.layer.borderColor = self.btnTimerConfig.runningValue.layerBorderColour.CGColor;
    self.layer.cornerRadius = self.btnTimerConfig.runningValue.layerCornerRadius;
    self.layer.borderWidth = self.btnTimerConfig.runningValue.layerBorderWidth;
    
    self.backgroundColor = self.btnTimerConfig.runningValue.bgCor;
}
#pragma mark —— UI配置 2.2、【计时器进行中】设置文字
-(void)setTitleLabelConfigRunning{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleFont = self.btnTimerConfig.runningValue.font;
    self.normalTitleColor = self.btnTimerConfig.runningValue.textCor;
    [self makeBtnLabelByShowingType:self.btnTimerConfig.labelShowingType];
    [self extraWidth:0];
}
#pragma mark —— UI配置 3.1、【计时器结束】设置Layer层 和 背景颜色
-(void)setLayerConfigEnd{
    self.layer.borderColor = self.btnTimerConfig.endValue.layerBorderColour.CGColor;
    self.layer.cornerRadius = self.btnTimerConfig.endValue.layerCornerRadius;
    self.layer.borderWidth = self.btnTimerConfig.endValue.layerBorderWidth;
    
    self.backgroundColor = self.btnTimerConfig.endValue.bgCor;
}
#pragma mark —— UI配置 3.2、【计时器结束】设置文字
-(void)setTitleLabelConfigEnd{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.numberOfLines = 1;//不加这一句会有UI异常
    self.titleFont = self.btnTimerConfig.endValue.font;
    self.normalTitleColor = self.btnTimerConfig.endValue.textCor;
    [self makeBtnLabelByShowingType:self.btnTimerConfig.labelShowingType];
    [self extraWidth:JobsWidth(8)];
}
#pragma mark —— 设置普通标题或者富文本标题【计时器未开始】
-(void)setTitleReadyPlay{
    if (self.btnTimerConfig.readyPlayValue.titleAttributedDataMutArr.count ||
        self.btnTimerConfig.readyPlayValue.attributedText) {
        //富文本
        self.normalAttributedTitle = self.btnTimerConfig.readyPlayValue.attributedText;
    }else{
        self.normalTitle = self.btnTimerConfig.readyPlayValue.text;
    }
}
#pragma mark —— 设置普通标题或者富文本标题【计时器进行中】
-(void)setTitleRunning{
    if (self.btnTimerConfig.runningValue.titleAttributedDataMutArr.count ||
        self.btnTimerConfig.runningValue.attributedText) {
        //富文本
        self.normalAttributedTitle = self.btnTimerConfig.runningValue.attributedText;
    }else{
        NSLog(@"☕️☕️☕️☕️ = %@",self.btnTimerConfig.runningValue.text);
        self.normalTitle = self.btnTimerConfig.runningValue.text;
    }
}
#pragma mark —— 设置普通标题或者富文本标题【计时器结束】
-(void)setTitleEnd{
    if (self.btnTimerConfig.endValue.titleAttributedDataMutArr.count ||
        self.btnTimerConfig.endValue.attributedText) {
        //富文本
        self.normalAttributedTitle = self.btnTimerConfig.endValue.attributedText;
    }else{
        self.normalTitle = self.btnTimerConfig.endValue.text;
    }
}
#pragma mark —— 时间相关方法【开启定时器】
/// 1、开启计时【用初始化时间】
-(void)startTimer{
    [self startTimer:self.btnTimerConfig.count];
}
/// 2、开启计时【从某个时间】
-(void)startTimer:(NSInteger)timeCount{
    [self setTitleReadyPlay];
    [self setLayerConfigReadyPlay];
    [self setTitleLabelConfigReadyPlay];
    self.btnTimerConfig.count = timeCount;
    //启动方式——1
//    [self.nsTimerManager nsTimeStartWithRunLoop:nil];
    //启动方式——2
    [self.btnTimerConfig.timerManager nsTimeStartSysAutoInRunLoop];
    [self preData];
}
/// 因为计时器要走过一个周期才开始报值
-(void)preData{
    [self timerRuning:self.btnTimerConfig.timerManager.timerProcessModel.data.anticlockwiseTime];
}
#pragma mark —— 时间相关方法【定时器运行中】❤️核心方法❤️
-(void)timerRuning:(long)currentTime{
    // 其他一些基础设置
    {
        self.enabled = self.btnTimerConfig.isCanBeClickWhenTimerCycle;//倒计时期间，默认不接受任何的点击事件
        self.backgroundColor = self.btnTimerConfig.runningValue.bgCor;
    }
    // 清除上一次拼装的数据
    if (self.btnTimerConfig.formatTimeStr.length > 0 &&
        [self.btnTimerConfig.runningValue.text containsString:self.btnTimerConfig.formatTimeStr]) {
        self.btnTimerConfig.runningValue.text = [self.btnTimerConfig.runningValue.text stringByReplacingOccurrencesOfString:self.btnTimerConfig.formatTimeStr withString:@""];
    }
    // 显示数据的二次封装
    {
        // 显示的时间格式
        switch (self.btnTimerConfig.showTimeType) {
            case ShowTimeType_SS:{
                self.btnTimerConfig.formatTimeStr = [NSString stringWithFormat:@"%ld %@",(long)currentTime,self.btnTimerConfig.secondStr];
            }break;
            case ShowTimeType_MMSS:{
                self.btnTimerConfig.formatTimeStr = [self getMMSSFromStr:[NSString stringWithFormat:@"%ld",(long)currentTime] formatTime:nil];
            }break;
            case ShowTimeType_HHMMSS:{
                self.btnTimerConfig.formatTimeStr = [self getHHMMSSFromStr:[NSString stringWithFormat:@"%ld",(long)currentTime] formatTime:nil];
            }break;
            default:
                self.btnTimerConfig.formatTimeStr = Internationalization(@"异常值");
                break;
        }
        // 字符串拼接
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
        // 富文本 每一次时间触发方法都刷新数据并赋值
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
#pragma mark —— 时间相关方法【定时器暂停】
-(void)timerSuspend{
    [self.btnTimerConfig.timerManager nsTimePause];
}
#pragma mark —— 时间相关方法【定时器继续】
-(void)timerContinue{
    [self.btnTimerConfig.timerManager nsTimecontinue];
}
#pragma mark —— 时间相关方法【定时器销毁】
-(void)timerDestroy{
    self.enabled = YES;
    NSLog(@"self.btnTimerConfig.titleEndStr = %@",self.btnTimerConfig.endValue.text);
    [self setTitleEnd];
    [self setTitleLabelConfigEnd];
    [self setLayerConfigEnd];
    self.backgroundColor = self.btnTimerConfig.endValue.bgCor;
    [self.btnTimerConfig.timerManager nsTimeDestroy];
}
#pragma mark SET | GET
static char *UIButton_Timer_btnTimerConfig = "UIButton_Timer_btnTimerConfig";
@dynamic btnTimerConfig;
#pragma mark —— @property(nonatomic,strong)ButtonTimerModel *btnTimerConfig;
-(ButtonTimerConfigModel *)btnTimerConfig{
    ButtonTimerConfigModel *BtnTimerConfig = objc_getAssociatedObject(self, UIButton_Timer_btnTimerConfig);
    if (!BtnTimerConfig) {
        BtnTimerConfig = ButtonTimerConfigModel.new;
        [self setBtnTimerConfig:BtnTimerConfig];
    }
    // 定时器运行时的Block
    @jobs_weakify(self)
    [BtnTimerConfig actionObjectBlock:^(TimerProcessModel *data) {
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
        
        if (self.objectBlock) self.objectBlock(data);
    }];return BtnTimerConfig;
}

-(void)setBtnTimerConfig:(ButtonTimerConfigModel *)btnTimerConfig{
    objc_setAssociatedObject(self,
                             UIButton_Timer_btnTimerConfig,
                             btnTimerConfig,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
