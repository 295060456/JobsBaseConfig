//
//  UICollectionViewCell+Default.m
//  DouDong-II
//
//  Created by Jobs on 2021/3/11.
//

#import "UICollectionViewCell+Default.h"

@implementation UICollectionViewCell (Default)
#pragma mark —— UICollectionViewCellProtocol
+(instancetype)cellWithCollectionView:(nonnull UICollectionView *)collectionView
                         forIndexPath:(nonnull NSIndexPath *)indexPath{
    id cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier(self.class)
                                                        forIndexPath:indexPath];
    if (!cell) {
        [collectionView registerClass:self.class
           forCellWithReuseIdentifier:reuseIdentifier(self.class)];
        [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier(self.class)
                                                  forIndexPath:indexPath];
    }return cell;
}

@end
