//
//  UIButton+Animation.h
//  Casino
//
//  Created by Jobs on 2021/12/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (Animation)

/// 点击按钮，按钮的imageView旋转360°
-(CABasicAnimation *)revolution;
/// 停止旋转360
-(void)stopRevolution;
/// 点击时旋转180°，再点击时再转回来
-(void)rotateHalfCycle;

@end

NS_ASSUME_NONNULL_END
