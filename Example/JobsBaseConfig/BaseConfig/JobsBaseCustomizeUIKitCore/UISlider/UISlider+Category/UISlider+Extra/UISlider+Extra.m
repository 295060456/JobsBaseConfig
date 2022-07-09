//
//  UISlider+Extra.m
//  BaiShaEntertainmentProj
//
//  Created by Jobs on 2022/7/9.
//

#import "UISlider+Extra.h"

@implementation UISlider (Extra)

-(RACDisposable *)sliderAllTouchEventBlock:(jobsByIDBlock)subscribeNextBlock{
    self.racDisposable = [[self rac_signalForControlEvents:UIControlEventAllTouchEvents] subscribeNext:^(__kindof UISlider * _Nullable x) {
        if(subscribeNextBlock) subscribeNextBlock(x);
    }];return self.racDisposable;
}

-(RACDisposable *)sliderValueChangedEventBlock:(jobsByIDBlock)subscribeNextBlock{
    self.racDisposable = [[self rac_signalForControlEvents:UIControlEventValueChanged] subscribeNext:^(__kindof UISlider * _Nullable x) {
        if(subscribeNextBlock) subscribeNextBlock(x);
    }];return self.racDisposable;
}



@end
