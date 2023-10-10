//
//  NSObject+JobsDeployCellConfig.h
//  BaiShaEntertainmentProj
//
//  Created by Jobs on 2022/6/23.
//

#import <Foundation/Foundation.h>
#import "JobsDeployDataForCellHeader.h"

NS_ASSUME_NONNULL_BEGIN

#define ReturnRichBaseCollectionViewCell BaseCollectionViewCell *cell = [BaseCollectionViewCell cellWithCollectionView:collectionView forIndexPath:indexPath];\
[cell richElementsInCellWithModel:nil];\
return cell;\

#define ReturnBaseCollectionViewCell return [BaseCollectionViewCell cellWithCollectionView:collectionView forIndexPath:indexPath];
#define ReturnBaseCollectionReusableHeaderView return [collectionView UICollectionElementKindSectionHeaderClass:BaseCollectionReusableView.class forIndexPath:indexPath];
#define ReturnBaseCollectionReusableFooterView return [collectionView UICollectionElementKindSectionFooterClass:BaseCollectionReusableView.class forIndexPath:indexPath];

@interface NSObject (JobsDeployCellConfig)
#pragma mark —— Cell 部署策略
/// 4 个 Cell
/// block5 为保留位，处理异常
-(UICollectionViewCell *)planAtIndexPath:(nonnull NSIndexPath *)indexPath
                                  block1:(JobsReturnIDByVoidBlock)block1
                                  block2:(JobsReturnIDByVoidBlock)block2
                                  block3:(JobsReturnIDByVoidBlock)block3
                                  block4:(JobsReturnIDByVoidBlock)block4
                                  block5:(JobsReturnIDByVoidBlock)block5;
/// block5 为保留位，处理异常
-(CGSize)planSizeAtIndexPath:(nonnull NSIndexPath *)indexPath
                      block1:(JobsReturnCGSizeByVoidBlock)block1
                      block2:(JobsReturnCGSizeByVoidBlock)block2
                      block3:(JobsReturnCGSizeByVoidBlock)block3
                      block4:(JobsReturnCGSizeByVoidBlock)block4
                      block5:(JobsReturnCGSizeByVoidBlock)block5;

-(CGSize)planSizeForSectionAtIndexPath:(NSInteger)section
                                block1:(JobsReturnCGSizeByVoidBlock)block1
                                block2:(JobsReturnCGSizeByVoidBlock)block2
                                block3:(JobsReturnCGSizeByVoidBlock)block3
                                block4:(JobsReturnCGSizeByVoidBlock)block4
                                block5:(JobsReturnCGSizeByVoidBlock)block5;
/// minimumInteritemSpacingForSectionAtIndex & minimumLineSpacingForSectionAtIndex
-(CGFloat)planSpacingForSectionAtIndex:(NSInteger)section
                                block1:(JobsReturnCGFloatByVoidBlock)block1
                                block2:(JobsReturnCGFloatByVoidBlock)block2
                                block3:(JobsReturnCGFloatByVoidBlock)block3
                                block4:(JobsReturnCGFloatByVoidBlock)block4
                                block5:(JobsReturnCGFloatByVoidBlock)block5;
/// insetForSectionAtIndex
-(UIEdgeInsets)planinsetForSectionAtIndex:(NSInteger)section
                                   block1:(JobsReturnUIEdgeInsetsByVoidBlock)block1
                                   block2:(JobsReturnUIEdgeInsetsByVoidBlock)block2
                                   block3:(JobsReturnUIEdgeInsetsByVoidBlock)block3
                                   block4:(JobsReturnUIEdgeInsetsByVoidBlock)block4
                                   block5:(JobsReturnUIEdgeInsetsByVoidBlock)block5;

@end

NS_ASSUME_NONNULL_END
