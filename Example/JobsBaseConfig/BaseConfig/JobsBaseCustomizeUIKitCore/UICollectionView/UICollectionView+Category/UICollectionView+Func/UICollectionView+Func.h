//
//  UICollectionView+Func.h
//  BaiShaEntertainmentProj
//
//  Created by Jobs on 2022/6/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UICollectionView (Func)

-(void)didSelectItemAtIndexPath:(NSIndexPath *)indexPath
        collectionViewCellClass:(Class _Nullable)collectionViewCellClass;
-(void)didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
          collectionViewCellClass:(Class _Nullable)collectionViewCellClass;

@end

NS_ASSUME_NONNULL_END
