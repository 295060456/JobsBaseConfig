//
//  WaterMark.h
//  My_BaseProj
//
//  Created by Administrator on 07/06/2019.
//  Copyright © 2019 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WaterMark : UIView

-(instancetype)initWithLableWidth:(CGFloat)lableWidth
                      LableHeight:(CGFloat)lableHeight
                LableOffset_level:(CGFloat)lableOffset_level
             LableOffset_vertical:(CGFloat)lableOffset_vertical;

@end

NS_ASSUME_NONNULL_END

/*
 *  1、子视图超出父视图，超出部分裁剪掉;
 *  2、使用的时候必须先给WaterMark的子类一个frame;
 */
