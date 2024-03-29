//
//  ThreeClassCell.h
//  JobsBaseConfig
//
//  Created by Jobs on 2022/6/15.
//

#import <UIKit/UIKit.h>
#import "JobsVerticalMenuDefineHeader.h"
#import "TreeClassItemCell.h"
#import "GoodsClassModel.h"
#import "JobsBaseCollectionViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface ThreeClassCell : JobsBaseCollectionViewCell
<
UICollectionViewDelegate
,UICollectionViewDataSource
>
#pragma mark —— 一些公有方法
-(CGFloat)getCollectionHeight:(NSMutableArray *)dataArray;
-(void)reloadData;

@end

NS_ASSUME_NONNULL_END
