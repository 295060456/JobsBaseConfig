//
//  NSObject+JobsDeployCellConfig.m
//  BaiShaEntertainmentProj
//
//  Created by Jobs on 2022/6/23.
//

#import "NSObject+JobsDeployCellConfig.h"

@implementation NSObject (JobsDeployCellConfig)
#pragma mark —— Cell 部署策略
/// 4 个 Cell
/// block5 为保留位，处理异常
-(UICollectionViewCell *)planAtIndexPath:(nonnull NSIndexPath *)indexPath
                                  block1:(JobsReturnIDByVoidBlock)block1
                                  block2:(JobsReturnIDByVoidBlock)block2
                                  block3:(JobsReturnIDByVoidBlock)block3
                                  block4:(JobsReturnIDByVoidBlock)block4
                                  block5:(JobsReturnIDByVoidBlock)block5{
    JobsDeployCellByIndexPathSection4Block
    return nil;
}
/// block5 为保留位，处理异常
-(CGSize)planSizeAtIndexPath:(nonnull NSIndexPath *)indexPath
                      block1:(JobsReturnCGSizeByVoidBlock)block1
                      block2:(JobsReturnCGSizeByVoidBlock)block2
                      block3:(JobsReturnCGSizeByVoidBlock)block3
                      block4:(JobsReturnCGSizeByVoidBlock)block4
                      block5:(JobsReturnCGSizeByVoidBlock)block5{
    JobsDeployCellByIndexPathSection4Block
    return CGSizeZero;
}

-(CGSize)planSizeForSectionAtIndexPath:(NSInteger)section
                                block1:(JobsReturnCGSizeByVoidBlock)block1
                                block2:(JobsReturnCGSizeByVoidBlock)block2
                                block3:(JobsReturnCGSizeByVoidBlock)block3
                                block4:(JobsReturnCGSizeByVoidBlock)block4
                                block5:(JobsReturnCGSizeByVoidBlock)block5{
    JobsDeployCellBySection4Block
    return CGSizeZero;
}
/// minimumInteritemSpacingForSectionAtIndex & minimumLineSpacingForSectionAtIndex
-(CGFloat)planSpacingForSectionAtIndex:(NSInteger)section
                                block1:(JobsReturnCGFloatByVoidBlock)block1
                                block2:(JobsReturnCGFloatByVoidBlock)block2
                                block3:(JobsReturnCGFloatByVoidBlock)block3
                                block4:(JobsReturnCGFloatByVoidBlock)block4
                                block5:(JobsReturnCGFloatByVoidBlock)block5{
    JobsDeployCellBySection4Block
    return 0.f;
}
/// insetForSectionAtIndex
-(UIEdgeInsets)planinsetForSectionAtIndex:(NSInteger)section
                                   block1:(JobsReturnUIEdgeInsetsByVoidBlock)block1
                                   block2:(JobsReturnUIEdgeInsetsByVoidBlock)block2
                                   block3:(JobsReturnUIEdgeInsetsByVoidBlock)block3
                                   block4:(JobsReturnUIEdgeInsetsByVoidBlock)block4
                                   block5:(JobsReturnUIEdgeInsetsByVoidBlock)block5{
    JobsDeployCellBySection4Block
    return UIEdgeInsetsZero;
}

@end
