//
//  Douyin_ZFPlayerVC@2.h
//  JobsBaseConfig
//
//  Created by Jobs on 2022/1/8.
//

#import "BaseViewController.h"
#import "MacroDef_Func.h"

#import "ZFCustomControlView.h"
#import "ZFDouYinControlView.h"
#import "ZFDouYinCell.h"

#import "VideoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface Douyin_ZFPlayerVC_2 : BaseViewController
<
UITableViewDelegate,
UITableViewDataSource,
ZFDouYinCellDelegate
>

-(void)playTheIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
