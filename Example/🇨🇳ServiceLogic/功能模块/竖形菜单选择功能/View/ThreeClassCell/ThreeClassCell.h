//
//  ThreeClassCell.h
//  MPMALL
//
//  Created by xixi_wen on 2019/7/4.
//  Copyright © 2019 panduola. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JobsVerticalMenuDefineHeader.h"
#import "TreeClassItemCell.h"
#import "GoodsClassModel.h"
#import "BaseCollectionViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface ThreeClassCell : BaseCollectionViewCell
<
UICollectionViewDelegate
,UICollectionViewDataSource
>
#pragma mark —— 一些公有方法
-(CGFloat)getCollectionHeight:(NSMutableArray *)dataArray;
-(void)reloadData;

@end

NS_ASSUME_NONNULL_END
