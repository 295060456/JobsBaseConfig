//
//  UICollectionView+RegisterClass.m
//  UBallLive
//
//  Created by Jobs on 2020/10/31.
//

#import "UICollectionView+RegisterClass.h"
#import "JobsHotLabelWithMultiLineCVCell.h"

@implementation UICollectionView (RegisterClass)

-(void)registerCollectionViewClass{
    // CollectionReusableView
    /// Header
//    [self registerClass:CasinoGameCollectionReusableView.class
//    forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
//    withReuseIdentifier:reuseIdentifier(CasinoGameCollectionReusableView)];
//    [self registerClass:CasinoAgencyRecommendCRView.class
//    forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
//    withReuseIdentifier:reuseIdentifier(CasinoAgencyRecommendCRView)];
//    /// Footer
//    [self registerClass:CasinoAgencyRecommendTipsCRView.class
//    forSupplementaryViewOfKind:UICollectionElementKindSectionFooter
//    withReuseIdentifier:reuseIdentifier(CasinoAgencyRecommendTipsCRView)];
    // CollectionViewCell
    [self registerClass:UICollectionViewCell.class
        forCellWithReuseIdentifier:reuseIdentifier(UICollectionViewCell)];
    [self registerClass:BaseCollectionViewCell.class
        forCellWithReuseIdentifier:reuseIdentifier(BaseCollectionViewCell)];
    [self registerClass:JobsHotLabelWithMultiLineCVCell.class
        forCellWithReuseIdentifier:reuseIdentifier(JobsHotLabelWithMultiLineCVCell)];
    [self registerClass:JobsSearchDataCVCell.class
        forCellWithReuseIdentifier:reuseIdentifier(JobsSearchDataCVCell)];
}

@end
