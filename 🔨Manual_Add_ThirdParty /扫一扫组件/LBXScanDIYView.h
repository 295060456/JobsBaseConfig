//
//  LBXScanDIYView.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/7/2.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LBXScanLineAnimation.h"
#import "LBXScanNetAnimation.h"
#import "LBXScanViewStyle.h"

#define LBXScan_Define_UI

NS_ASSUME_NONNULL_BEGIN
/**
 扫码区域显示效果
 */
@interface LBXScanDIYView : UIView
/**
 @brief  初始化
 @param frame 位置大小
 @param style 类型
 @return instancetype
 */
-(id)initWithFrame:(CGRect)frame
             style:(LBXScanViewStyle*)style;
/**
 *  设备启动中文字提示
 */
- (void)startDeviceReadyingWithText:(NSString*)text;
/**
 *  设备启动完成
 */
- (void)stopDeviceReadying;
/**
 *  开始扫描动画
 */
- (void)startScanAnimation;
/**
 *  结束扫描动画
 */
- (void)stopScanAnimation;
/**
 @brief  根据矩形区域，获取Native扫码识别兴趣区域
 @param view  视频流显示UIView
 @param style 效果界面参数
 @return 识别区域
 */
+ (CGRect)getScanRectWithPreView:(UIView*)view
                           style:(LBXScanViewStyle*)style;
/**
 根据矩形区域，获取ZXing库扫码识别兴趣区域

 @param view 视频流显示视图
 @param style 效果界面参数
 @return 识别区域
 */
+ (CGRect)getZXingScanRectWithPreView:(UIView*)view
                                style:(LBXScanViewStyle*)style;

@end

NS_ASSUME_NONNULL_END


