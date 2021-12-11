//
//  UICollectionView+RegisterClass.m
//  UBallLive
//
//  Created by Jobs on 2020/10/31.
//

#import "UICollectionView+RegisterClass.h"

@implementation UICollectionView (RegisterClass)

-(void)registerCollectionViewClass{
    
//    [self registerClass:CasinoGameCollectionReusableView.class
//    forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
//    withReuseIdentifier:reuseIdentifier(CasinoGameCollectionReusableView)];
    
    [self registerClass:UICollectionViewCell.class
        forCellWithReuseIdentifier:reuseIdentifier(UICollectionViewCell)];
    [self registerClass:BaseCollectionViewCell.class
        forCellWithReuseIdentifier:reuseIdentifier(BaseCollectionViewCell)];
    [self registerClass:JobsImageNumberViewCVCell.class
        forCellWithReuseIdentifier:reuseIdentifier(JobsImageNumberViewCVCell)];
}

@end
