//
//  UICollectionView+Func.m
//  BaiShaEntertainmentProj
//
//  Created by Jobs on 2022/6/24.
//

#import "UICollectionView+Func.h"

@implementation UICollectionView (Func)

-(void)didSelectItemAtIndexPath:(NSIndexPath *)indexPath
        collectionViewCellClass:(Class _Nullable)collectionViewCellClass{
    NSLog(@"%s", __FUNCTION__);
    if (collectionViewCellClass) {
        for (UICollectionViewCell *cell in self.visibleCells) {
            if ([cell isKindOfClass:collectionViewCellClass]) {
                cell.selected = NO;
            }
        }
    }
    UICollectionViewCell *cell = (UICollectionViewCell *)[self cellForItemAtIndexPath:indexPath];
    cell.selected = YES;
}

-(void)didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
          collectionViewCellClass:(Class _Nullable)collectionViewCellClass{
    NSLog(@"%s", __FUNCTION__);
    UICollectionViewCell *cell = (UICollectionViewCell *)[self cellForItemAtIndexPath:indexPath];
    cell.selected = YES;
}

@end
