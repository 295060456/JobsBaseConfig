//
//  MacroDef_App.h
//  UBallLive
//
//  Created by Jobs on 2020/10/30.
//

#ifndef MacroDef_App_h
#define MacroDef_App_h

#import <Foundation/Foundation.h>

#define debug 1//是否显示debug控件

#define NODATA Internationalization(@"No Data")

//输入原型图上的宽和高，对外输出App对应的移动设备的真实宽高
#define KWidth(width) (MIN(SCREEN_WIDTH, SCREEN_HEIGHT) / 375) * (width) //375 对应原型图的宽
#define KHeight(height) (SCREEN_HEIGHT / 743) * (height) //743 对应原型图的高

#define isiPhoneX_seriesBottom 34
#define isiPhoneX_seriesTop 44

#endif /* MacroDef_App_h */
