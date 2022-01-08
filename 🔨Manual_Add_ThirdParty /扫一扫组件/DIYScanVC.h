//
//  DIYScanVC.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/6/26.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LBXScanDIYViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface DIYScanVC : LBXScanDIYViewController
/**
 @brief  扫码区域上方提示文字
 */
@property(nonatomic,strong)UILabel *topTitle;

#pragma mark --增加拉近/远视频界面
@property(nonatomic,assign)BOOL isVideoZoom;

#pragma mark - 底部几个功能：开启闪光灯、相册、我的二维码
//底部显示的功能项
@property(nonatomic,strong)UIView *bottomItemsView;
//相册
@property(nonatomic,strong)UIButton *btnPhoto;
//闪光灯
@property(nonatomic,strong)UIButton *btnFlash;
//我的二维码
@property(nonatomic,strong)UIButton *btnMyQR;

@end

NS_ASSUME_NONNULL_END
