//
//  UICollectionView+RegisterClass.m
//  UBallLive
//
//  Created by Jobs on 2020/10/31.
//

#import "UICollectionView+RegisterClass.h"

@implementation UICollectionView (RegisterClass)
/// 注册的时候不开辟内存，只有当用字符串进行取值的时候才开辟内存
-(void)registerCollectionViewClass{
    // CollectionReusableView
    /// Header
    [self registerCollectionElementKindSectionHeaderClass:JobsHotLabelWithMultiLineHeaderView.class];
    /// Footer
    [self registerCollectionElementKindSectionFooterClass:JobsHotLabelWithMultiLineFooterView.class];
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
/// 注册 UICollectionElementKindSectionHeader 及其子类
-(void)registerCollectionElementKindSectionHeaderClass:(Class)cls{
    [self registerClass:cls
    forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
    withReuseIdentifier:cls.description];
}
/// 注册 UICollectionElementKindSectionFooter 及其子类
-(void)registerCollectionElementKindSectionFooterClass:(Class)cls{
    [self registerClass:cls
    forSupplementaryViewOfKind:UICollectionElementKindSectionFooter
    withReuseIdentifier:cls.description];
}
/// 依据字符串取UICollectionElementKindSectionFooter
-(__kindof UICollectionReusableView *)UICollectionElementKindSectionFooterClass:(Class)cls
                                                                   forIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *collectionReusableView = [self dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                                                                                withReuseIdentifier:cls.description
                                                                                       forIndexPath:indexPath];
    if (!collectionReusableView) {
        [self registerCollectionElementKindSectionFooterClass:cls];
        collectionReusableView = [self dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                                                          withReuseIdentifier:cls.description
                                                                 forIndexPath:indexPath];
    }return collectionReusableView;
}
/// 依据字符串取UICollectionElementKindSectionHeader
-(__kindof UICollectionReusableView *)UICollectionElementKindSectionHeaderClass:(Class)cls
                                                                   forIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionReusableView *collectionReusableView = [self dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                                                withReuseIdentifier:cls.description
                                                                                       forIndexPath:indexPath];
    if (!collectionReusableView) {
        [self registerCollectionElementKindSectionHeaderClass:cls];
        collectionReusableView = [self dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                          withReuseIdentifier:cls.description
                                                                 forIndexPath:indexPath];
    }return collectionReusableView;
}
/// 先用UICollectionViewLayout生成CollectionView。frame后面设置
+(instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout{
    return [self.alloc initWithFrame:CGRectZero
                collectionViewLayout:layout];
}
/// 一种用字符串取UICollectionViewCell及其子类的方法❤️复用字符串是目标类的类名❤️
-(UICollectionViewCell *)collectionViewCellClass:(Class)cls
                                    forIndexPath:(NSIndexPath *)indexPath{
    return [self dequeueReusableCellWithReuseIdentifier:cls.description
                                           forIndexPath:indexPath];
}

@end
