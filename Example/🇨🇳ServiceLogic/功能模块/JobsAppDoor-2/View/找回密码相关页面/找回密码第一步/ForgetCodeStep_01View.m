//
//  ForgetCodeStep_01.m
//  Shooting
//
//  Created by Jobs on 2020/9/6.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "ForgetCodeStep_01View.h"

@interface ForgetCodeStep_01View ()

@end

@implementation ForgetCodeStep_01View
/**
 BaseViewProtocol
 
 /// 具体由子类进行复写【数据定UI】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
 -(void)richElementsInViewWithModel:(id _Nullable)model;
 /// 具体由子类进行复写【数据定宽】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
 +(CGFloat)viewWidthWithModel:(id _Nullable)model;
 /// 具体由子类进行复写【数据定高】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
 +(CGFloat)viewHeightWithModel:(id _Nullable)model;
 /// 具体由子类进行复写【数据尺寸】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
 +(CGSize)viewSizeWithModel:(id _Nullable)model;
 /// 具体由子类进行复写【数据Frame】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
 +(CGRect)viewFrameWithModel:(id _Nullable)model;
 /// 数据（字符串）定宽
 +(CGFloat)widthByData:(UIViewModel *_Nonnull)data;
 /// 数据（字符串）定高
 +(CGFloat)heightByData:(UIViewModel *_Nonnull)data;
 /// 下拉刷新 （子类要进行覆写）
 -(void)pullToRefresh;
 /// 上拉加载更多 （子类要进行覆写）
 -(void)loadMoreRefresh;
 */

@end
