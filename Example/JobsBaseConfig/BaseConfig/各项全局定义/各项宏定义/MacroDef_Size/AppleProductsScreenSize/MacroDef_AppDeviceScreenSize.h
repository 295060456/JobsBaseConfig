//
//  MacroDef_AppDeviceScreenSize.h
//  DouDong-II
//
//  Created by Jobs on 2021/3/20.
//

#ifndef MacroDef_AppDeviceScreenSize_h
#define MacroDef_AppDeviceScreenSize_h

/**
    【资料来源】
    https://developer.apple.com/documentation/uikit/uiscreenmode?language=objc
    https://www.jianshu.com/p/c972224a733d
    https://cxybb.com/article/jifaliwo123/79271618
    [UIScreen mainScreen].bounds取出的值和预想的不一样；
    因为当前手机使用的放大模式（设置->显示与亮度->放大标准，4.7寸及以上才可以设置）
    使用了放大模式之后[UIScreen mainScreen].bounds取出的值就有问题了

    iOS里面对于缩放因子有2个不同的概念：
    一个是其实际的缩放因子（Native Scale factor），一个是UIKit上所表示的逻辑缩放因子（UIKit Scale factor）。
    当UIKit Scale factor和Native Scale factor不相等的时候，系统会先使用逻辑上的factor（即UIKit Scale factor）来渲染，渲染之后再把结果进行缩放，使之符合Native Scale factor下渲染的样子。
    在一些UI渲染计算量大的应用（如游戏），这类多余的渲染是很耗费资源的，应该在渲染这类UI的时候指定使用Native Scale factor来做渲染。
    MetalKit（新的系统接口，支持GPU加速3D绘图的API。）里面有这个用法。

    UIScreen.mainScreen.scale/// 逻辑缩放因子
    UIScreen.mainScreen.bounds/// 逻辑屏幕宽度
    UIScreen.mainScreen.nativeScale/// 实际/物理缩放因子
    UIScreen.mainScreen.nativeBounds/// 实际/物理屏幕宽度

    【结论】
    在平时开发的过程当中，这些因素可以基本忽略不计，官方文档也是不鼓励去纠结这些。
    不过也要注意一下，如果你的代码中有通过[UIScreen mainScreen].bounds.size.height 的值去判断当前屏幕尺寸的代码，这是不可取的，应该用nativeBounds去代替这个值。

 */
/// TODO : 👇🏻下列数据还是依赖currentMode来进行判定的，需要将其更改为nativeBounds
#define CurrentModeSize UIScreen.mainScreen.currentMode.size
#define CurrentModeRespondSelector [UIScreen instancesRespondToSelector:@selector(currentMode)]
#pragma mark —— 判断iPhone 使用currentMode的标准值
// 判断 【iPhone 6】、【iPhone 6s】、【iPhone 7】、【iPhone 8】
#define iPh6_6s_7_8 (CurrentModeRespondSelector ? CGSizeEqualToSize(CGSizeMake(750, 1334), CurrentModeSize) && !isPad : NO)
// 判断 【iPhone 6Plus】、【iPhone 6sPlus】、【iPhone 7Plus】、【iPhone 8Plus】
#define iPh6_6s_7_8PlusSeries (CurrentModeRespondSelector ? CGSizeEqualToSize(CGSizeMake(1242, 2208), CurrentModeSize) && !isPad : NO)
// 判断 【iPhone X】
#define iPhX (CurrentModeRespondSelector ? CGSizeEqualToSize(CGSizeMake(1125, 2436), CurrentModeSize) && !isPad : NO)
// 判断 【iPhone XR】
#define iPhXR (CurrentModeRespondSelector ? CGSizeEqualToSize(CGSizeMake(828, 1792), CurrentModeSize) && !isPad : NO)
// 判断 【iPhone XS】
#define iPhXS (CurrentModeRespondSelector ? CGSizeEqualToSize(CGSizeMake(1125, 2436), CurrentModeSize) && !isPad : NO)
// 判断 【iPhoneXS_Max】
#define iPhXS_Max (CurrentModeRespondSelector ? CGSizeEqualToSize(CGSizeMake(1242, 2688), CurrentModeSize) && !isPad : NO)
// 判断 【iPhoneSE (第一代)】
#define iPhSE_1 (CurrentModeRespondSelector ? CGSizeEqualToSize(CGSizeMake(640, 1136), CurrentModeSize) && !isPad : NO)
// 判断 【iPhoneSE (第二代)】
#define iPhSE_2 (CurrentModeRespondSelector ? CGSizeEqualToSize(CGSizeMake(750, 1334), CurrentModeSize) && !isPad : NO)
// 判断 【iPhone 11】
#define iPh11 (CurrentModeRespondSelector ? CGSizeEqualToSize(CGSizeMake(828, 1792), CurrentModeSize) && !isPad : NO)
// 判断 【iPhone 11 Pro】
#define iPh11Pro (CurrentModeRespondSelector ? CGSizeEqualToSize(CGSizeMake(1125, 2436), CurrentModeSize) && !isPad : NO)
// 判断 【iPhone 11 Pro Max】
#define iPh11ProMax (CurrentModeRespondSelector ? CGSizeEqualToSize(CGSizeMake(1242, 2688), CurrentModeSize) && !isPad : NO)
// 判断 【iPhone 12 Mini】
#define iPh12Mini (CurrentModeRespondSelector ? CGSizeEqualToSize(CGSizeMake(1080, 2340), CurrentModeSize) && !isPad : NO)
// 判断 【iPhone 12】
#define iPh12 (CurrentModeRespondSelector ? CGSizeEqualToSize(CGSizeMake(1170, 2532), CurrentModeSize) && !isPad : NO)
// 判断 【iPhone 12 Pro】
#define iPh12Pro (CurrentModeRespondSelector ? CGSizeEqualToSize(CGSizeMake(1170, 2532), CurrentModeSize) && !isPad : NO)
// 判断 【iPhone 12 Pro Max】
#define iPh12ProMax (CurrentModeRespondSelector ? CGSizeEqualToSize(CGSizeMake(1284, 2778), CurrentModeSize) && !isPad : NO)
#pragma mark —— 判断iPad
// 判断 【iPad mini 7.9】、【iPad 9.7】
#define iPadMini7_9Or9_7 (CurrentModeRespondSelector ? CGSizeEqualToSize(CGSizeMake(2048, 1536), CurrentModeSize) && !isiPhone : NO)
// 判断 【iPad Pro 10.2】
#define iPadPro10_2 (CurrentModeRespondSelector ? CGSizeEqualToSize(CGSizeMake(2160, 1620), CurrentModeSize) && !isiPhone : NO)
// 判断 【iPad Pro 10.5】
#define iPadPro10_5 (CurrentModeRespondSelector ? CGSizeEqualToSize(CGSizeMake(2224, 1668), CurrentModeSize) && !isiPhone : NO)
// 判断 【iPad Pro 11】
#define iPadPro11 (CurrentModeRespondSelector ? CGSizeEqualToSize(CGSizeMake(2388, 1668), CurrentModeSize) && !isiPhone : NO)
// 判断 【iPad Pro 12.9】
#define iPadPro12_9 (CurrentModeRespondSelector ? CGSizeEqualToSize(CGSizeMake(2732, 2048), CurrentModeSize) && !isiPhone : NO)

#endif /* MacroDef_AppDeviceScreenSize_h */
