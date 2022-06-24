//
//  UICollectionViewCellProtocol.h
//  BaiShaEntertainmentProj
//
//  Created by Jobs on 2022/5/30.
//

#import <Foundation/Foundation.h>
#import "BaseCellProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@protocol UICollectionViewCellProtocol <BaseCellProtocol>

+(instancetype)cellWithCollectionView:(nonnull UICollectionView *)collectionView
                         forIndexPath:(nonnull NSIndexPath *)indexPath;
-(UITextView *)getTextView;
-(UIButton *)getBgBtn;

@end

NS_ASSUME_NONNULL_END
