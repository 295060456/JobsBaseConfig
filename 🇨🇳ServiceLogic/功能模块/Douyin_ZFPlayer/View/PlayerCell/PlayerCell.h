//
//  PlayerCell.h
//  DouYin
//
//  Created by Jobs on 2020/9/23.
//

#import <UIKit/UIKit.h>
#import "VideoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PlayerCell : UITableViewCell<BaseCellProtocol>

@property(nonatomic,strong,nullable)ZFPlayerController *player;

-(void)actionBlockPlayerCell:(TwoDataBlock _Nullable)playerCellBlock;

@end

NS_ASSUME_NONNULL_END
