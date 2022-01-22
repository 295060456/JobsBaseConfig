//
//  ButtonTimerModel.m
//  SelectorBlock
//
//  Created by Jobs on 2021/3/23.
//

#import "ButtonTimerConfigModel.h"

@implementation ButtonTimerProcessValueModel
UIPictureAndBackGroundCorProtocol_synthesize
UITextModelProtocol_synthesize

@end

@interface ButtonTimerConfigModel ()

@property(nonatomic,copy)MKDataBlock timerWorkingBlock;

@end

@implementation ButtonTimerConfigModel
#pragma mark —— 一些私有方法
-(void)actionBlocktimerWorking:(MKDataBlock)timerWorkingBlock{
    self.timerWorkingBlock = timerWorkingBlock;
}
#pragma mark —— 重写set方法
@synthesize countDownBtnType = _countDownBtnType;
-(void)setCountDownBtnType:(TimerStyle)countDownBtnType{
    _countDownBtnType = countDownBtnType;
    _timerManager.timerStyle = _countDownBtnType;
}
@synthesize count = _count;
-(void)setCount:(long)count{
    _count = count;
    _timerManager.anticlockwiseTime = _count;//逆时针模式（倒计时）的顶点时间
}
#pragma mark —— lazyLoad【配置默认值】
-(NSTimerManager *)timerManager{
    if (!_timerManager) {
        _timerManager = NSTimerManager.new;
        _timerManager.timerStyle = self.countDownBtnType;
        _timerManager.anticlockwiseTime = self.count;//【逆时针模式：到这个时间点结束】、【顺时针模式：从这个时间点开始】
        @jobs_weakify(self)
        //倒计时启动
        [_timerManager actionNSTimerManagerRunningBlock:^(TimerProcessModel *data) {
            @jobs_strongify(self)
            NSLog(@"正在倒计时...");
            if (self.timerWorkingBlock) self.timerWorkingBlock(data);
        }];

    }return _timerManager;
}
/// 根据ShowTimeType格式化以后的时间【内部使用】
-(NSString *)formatTimeStr{
    if (self.labelShowingType == UILabelShowingType_05) {//提行模式
        if (![_formatTimeStr containsString:@"\n"] && _formatTimeStr) {
            if (self.cequenceForShowTitleRuningStrType == CequenceForShowTitleRuningStrType_front) {
                _formatTimeStr = [@"\n" stringByAppendingString:_formatTimeStr];
            }else if (self.cequenceForShowTitleRuningStrType == CequenceForShowTitleRuningStrType_tail){
                _formatTimeStr = [_formatTimeStr stringByAppendingString:@"\n"];
            }else{}
        }
    }return _formatTimeStr;
}
/// 计时器未开始
-(ButtonTimerProcessValueModel *)readyPlayValue{
    if (!_readyPlayValue) {
        _readyPlayValue = ButtonTimerProcessValueModel.new;
        
        _readyPlayValue.layerBorderColour = UIColor.whiteColor;
        _readyPlayValue.textCor = UIColor.whiteColor;
        _readyPlayValue.font = [UIFont systemFontOfSize:JobsWidth(12) weight:UIFontWeightRegular];
        _readyPlayValue.bgCor = UIColor.lightGrayColor;
        _readyPlayValue.layerCornerRadius = JobsWidth(8);
        _readyPlayValue.layerBorderWidth = 0.5f;

        
        _readyPlayValue.labelShowingType = UILabelShowingType_01;
        /// 普通文本
        _readyPlayValue.text = Internationalization(@"准备开始");
        /// 富文本相关
        // _readyPlayValue.titleAttributedDataMutArr =
        if (_readyPlayValue.titleAttributedDataMutArr.count) {
            _readyPlayValue.attributedText = [self richTextWithDataConfigMutArr:_readyPlayValue.titleAttributedDataMutArr];
        }else{
            //_readyPlayValue.titleAttributedStr =
        }
        
    }return _readyPlayValue;
}
/// 计时器进行中
-(ButtonTimerProcessValueModel *)runningValue{
    if (!_runningValue) {
        _runningValue = ButtonTimerProcessValueModel.new;
        
        _runningValue.layerBorderColour = UIColor.redColor;
        _runningValue.textCor = UIColor.greenColor;
        _runningValue.font = [UIFont systemFontOfSize:JobsWidth(15) weight:UIFontWeightRegular];
        _runningValue.bgCor = UIColor.cyanColor;
        _runningValue.layerCornerRadius = JobsWidth(12);
        _runningValue.layerBorderWidth = 1;
        _runningValue.labelShowingType = UILabelShowingType_01;
        /// 普通文本
        _runningValue.text = Internationalization(@"    重新开始    ");
        /// 富文本相关
        // _runningValue.titleAttributedDataMutArr =
        if (_runningValue.titleAttributedDataMutArr.count) {
            _runningValue.attributedText = [self richTextWithDataConfigMutArr:_runningValue.titleAttributedDataMutArr];
        }else{
            //_runningValue.titleAttributedStr =
        }
    }return _runningValue;
}
/// 计时器结束
-(ButtonTimerProcessValueModel *)endValue{
    if (!_endValue) {
        _endValue = ButtonTimerProcessValueModel.new;
        
        _endValue.layerBorderColour = self.readyPlayValue.layerBorderColour;
        _endValue.textCor = self.readyPlayValue.textCor;
        _endValue.font = self.readyPlayValue.font;
        _endValue.bgCor = self.readyPlayValue.bgCor;
        _endValue.layerCornerRadius = self.readyPlayValue.layerCornerRadius;
        _endValue.layerBorderWidth = self.readyPlayValue.layerBorderWidth;
        
        _endValue.labelShowingType = UILabelShowingType_01;
        /// 普通文本
        _endValue.text = Internationalization(@"    重新开始    ");
        /// 富文本相关
        // _endValue.titleAttributedDataMutArr =
        if (_endValue.titleAttributedDataMutArr.count) {
            _endValue.attributedText = [self richTextWithDataConfigMutArr:_endValue.titleAttributedDataMutArr];
        }else{
            //_endValue.titleAttributedStr =
        }
        
    }return _endValue;
}

-(NSInteger)count{
    if (!_count) {
        _count = 60;
    }return _count;
}

@end
