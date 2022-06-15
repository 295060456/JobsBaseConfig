//
//  JobsVerticalMenuVC.h
//  JobsBaseConfig
//
//  Created by Jobs on 2022/6/15.
//

#import "BaseViewController.h"
#import "JobsVerticalMenuDefineHeader.h"
#import "LeftCell.h"
#import "ThreeTopBannerCell.h"
#import "ThreeClassCell.h"
#import "GoodsClassModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface JobsVerticalMenuVC : BaseViewController
<
UITableViewDelegate
,UITableViewDataSource
,UICollectionViewDelegate
,UICollectionViewDataSource
>

@end

NS_ASSUME_NONNULL_END
