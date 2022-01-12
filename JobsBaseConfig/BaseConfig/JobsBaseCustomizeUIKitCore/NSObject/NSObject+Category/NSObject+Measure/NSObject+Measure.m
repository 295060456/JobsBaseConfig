//
//  NSObject+Measure.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/8/18.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "NSObject+Measure.h"

@implementation NSObject (Measure)

#pragma mark —— UIViewModelProtocol
/// 方位
@dynamic cornerRadius;
@dynamic jobsWidth;
@dynamic jobsHeight;
@dynamic jobsTop;
@dynamic jobsLeft;
@dynamic jobsRight;
@dynamic jobsBottom;
@dynamic jobsSize;
@dynamic jobsRect;
@dynamic jobsPoint;
@dynamic offsetXForEach;
@dynamic offsetYForEach;
@dynamic offsetHeight;
@dynamic offsetWidth;
/// 标记📌
@dynamic indexPath;
@dynamic section;
@dynamic row;
@dynamic item;
@dynamic lastPoint;
@dynamic index;
@dynamic currentPage;
@dynamic pageSize;

/// 已知父控件和子控件的宽度或者高度，当父控件为X轴或者Y轴中心的时候，子控件的X 和 Y 是多少？
/// @param subview 子控件的宽 或者 高
/// @param superview 父控件的宽 或者 高
+(CGFloat)measureSubview:(CGFloat)subview
               superview:(CGFloat)superview{
    return (superview - subview) / 2;
}
#pragma mark —— 几何数据类型的比较
/// 比较 size ？= CGSizeZero
+(BOOL)isSizeZero:(CGSize)size{
    return CGSizeEqualToSize(size, CGSizeZero);
}
/// 比较 point ？= CGPointZero
+(BOOL)isPointZero:(CGPoint)point{
    return CGPointEqualToPoint(point, CGPointZero);
}
/// 比较 rect ？= CGRectZero
+(BOOL)isRectZero:(CGRect)rect{
    return CGRectEqualToRect(rect, CGRectZero);
}
/// 比较 rect1 ？= rect2
+(BOOL)rect1:(CGRect)rect1
isEqualToRect2:(CGRect)rect2{
    return CGRectEqualToRect(rect1, rect2);
}
/// 比较 point1 ？= point2
+(BOOL)point1:(CGPoint)point1
isEqualToPoint2:(CGPoint)point2{
    return CGPointEqualToPoint(point1, point2);
}
/// 比较 size1 ？= size2
+(BOOL)size1:(CGSize)size1
isEqualToSize2:(CGSize)size2{
    return CGSizeEqualToSize(size1, size2);
}

@end
