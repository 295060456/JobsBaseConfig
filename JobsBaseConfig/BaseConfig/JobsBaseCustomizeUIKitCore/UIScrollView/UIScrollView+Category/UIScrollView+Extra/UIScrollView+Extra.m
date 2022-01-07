//
//  UIScrollView+Extra.m
//  Casino
//
//  Created by Jobs on 2021/12/22.
//

#import "UIScrollView+Extra.h"

@implementation UIScrollView (Extra)
/// 在 UIScrollViewDelegate协议方法 -(void)scrollViewDidScroll:(UIScrollView *)scrollView里进行调用
-(ScrollDirection)scrolldirectionWhenScrollViewDidScroll{
    return [self judgementScrollDirectionByPoint:self.contentOffset];
}

@end
