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
#pragma mark —— 一些公共方法
+(NSArray <UIView *> * _Nullable)cellsWithScrollView:(nonnull UIScrollView *)scrollView{
    NSArray <UIView *>*cells = nil;
    if ([scrollView isKindOfClass:UICollectionView.class]) {
        UICollectionView *collectionView = (UICollectionView *)scrollView;
        cells = collectionView.visibleCells;
    }else if ([scrollView isKindOfClass:UITableView.class]){
        UITableView *tableView = (UITableView *)scrollView;
        cells = tableView.visibleCells;
    }else{}
    return cells;
}

+(UIView * _Nullable)cellWithScrollView:(nonnull UIScrollView *)scrollView
                                atIndex:(int)index{
    UIView *cell = nil;
    if ([scrollView isKindOfClass:UICollectionView.class]) {
        UICollectionView *collectionView = (UICollectionView *)scrollView;
        cell = [collectionView.visibleCells objectAtIndex:index];
    }else if ([scrollView isKindOfClass:UITableView.class]){
        UITableView *tableView = (UITableView *)scrollView;
        cell = [tableView.visibleCells objectAtIndex:index];
    }else{}
    return cell;
}

@end
