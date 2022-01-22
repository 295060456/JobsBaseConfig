//
//  UIControl+XY.h
//  JinXian Finance
//
//  Created by 刘赓 on 2017/7/17.
//  Copyright © 2017年 刘赓. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import "NSObject+Swizzling.h"

NS_ASSUME_NONNULL_BEGIN
/**
 参考资料：http://www.jianshu.com/p/a830d0a57378
 */
@interface UIControl (XY)

@property(nonatomic,assign)NSTimeInterval uxy_acceptEventInterval;//可以用这个给重复点击加间隔

@end

NS_ASSUME_NONNULL_END
