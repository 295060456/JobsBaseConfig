//
//  ZFDouYinCell.h
//  DouYin
//
//  Created by Jobs on 2020/9/28.
//

#import <UIKit/UIKit.h>

#import "ZFDouYinCellDelegate.h"
#import "ZFTableData.h"
#import "VideoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZFDouYinCell : UITableViewCell<BaseCellProtocol>

@property(nonatomic,assign)long index;
@property(nonatomic,strong)VideoModel_Core *data;
@property(nonatomic,weak)id<ZFDouYinCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
