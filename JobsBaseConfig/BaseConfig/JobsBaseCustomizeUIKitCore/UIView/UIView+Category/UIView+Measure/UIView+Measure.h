//
//  UIView+Measure.h
//  My_BaseProj
//
//  Created by Jobs on 2020/9/1.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewProtocol.h"
@class UIViewModel;

NS_ASSUME_NONNULL_BEGIN

/* ❤️【优先级】 @implementation UIView (Measure) > Masonry,因为Masonry刷新后才有frame ❤️*/
@interface UIView (Measure)<BaseViewProtocol>

@property(nonatomic,assign)CGFloat x;
@property(nonatomic,assign)CGFloat y;
@property(nonatomic,assign,readonly) CGFloat maxX;
@property(nonatomic,assign,readonly) CGFloat maxY;
@property(nonatomic,assign)CGFloat width;
@property(nonatomic,assign)CGFloat height;
@property(nonatomic,assign)CGFloat centerX;
@property(nonatomic,assign)CGFloat centerY;
@property(nonatomic,assign)CGSize size;
@property(nonatomic,assign)CGPoint origin;
@property(nonatomic,assign)CGFloat left;
@property(nonatomic,assign)CGFloat right;
@property(nonatomic,assign)CGFloat top;
@property(nonatomic,assign)CGFloat bottom;

@end

NS_ASSUME_NONNULL_END
