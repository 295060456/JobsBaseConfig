//
//  UICollectionView+RegisterClass.m
//  UBallLive
//
//  Created by Jobs on 2020/10/31.
//

#import "UICollectionView+RegisterClass.h"

@implementation UICollectionView (RegisterClass)

-(void)registerCollectionViewClass{
    // CollectionReusableView
    /// Header
    //[self registerCollectionElementKindSectionHeaderClass:CasinoGameCollectionReusableView.class];
    /// Footer
    //[self registerCollectionElementKindSectionFooterClass:CasinoAgencyRecommendTipsCRView.class];
    // CollectionViewCell
    [self registerCollectionViewCellClass:UICollectionViewCell.class];
    [self registerCollectionViewCellClass:BaseCollectionViewCell.class];
    [self registerCollectionViewCellClass:JobsHotLabelWithMultiLineCVCell.class];
    [self registerCollectionViewCellClass:JobsSearchDataCVCell.class];
}
/// 注册 UICollectionViewCell 及其子类
-(void)registerCollectionViewCellClass:(Class)cls{
    [self registerClass:cls forCellWithReuseIdentifier:cls.description];
}
/// 注册 UICollectionElementKindSectionFooter 及其子类
-(void)registerCollectionElementKindSectionFooterClass:(Class)cls{
    [self registerClass:cls
    forSupplementaryViewOfKind:UICollectionElementKindSectionFooter
    withReuseIdentifier:cls.description];
}
/// 注册 UICollectionElementKindSectionHeader 及其子类
-(void)registerCollectionElementKindSectionHeaderClass:(Class)cls{
    [self registerClass:cls
    forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
    withReuseIdentifier:cls.description];
}

@end
