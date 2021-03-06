//
//  UITableViewCell+WhiteArrows.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/7/26.
//  Copyright © 2020 Jobs. All rights reserved.
//

//UITableViewCell 右侧的小箭头 白色

#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import "JobsBlock.h"
#import "UIView+Measure.h"
#import "LoadingImage.h"

#if __has_include(<ReactiveObjC/ReactiveObjC.h>)
#import <ReactiveObjC/ReactiveObjC.h>
#else
#import "ReactiveObjC.h"
#endif

NS_ASSUME_NONNULL_BEGIN

@interface UITableViewCell (WhiteArrows)

@property(nonatomic,strong)UIImage *img;
@property(nonatomic,assign)CGSize size;
/// 必须 self.accessoryType = UITableViewCellAccessoryDisclosureIndicator; 打开后才可以启用
-(void)customAccessoryView:(MKDataBlock)customAccessoryViewBlock;

@end

NS_ASSUME_NONNULL_END

/*
 
//实现以下方法
- (void)tableView:(UITableView *)tableView
  willDisplayCell:(UITableViewCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.img = KIMG(@"删除");
    @jobs_weakify(self)
    [cell customAccessoryView:^(id data) {
        @jobs_strongify(self)
        JobsSearchShowHistoryDataTBVCell *cell = (JobsSearchShowHistoryDataTBVCell *)data;
        NSLog(@"MMM - %ld",cell.index);
    }];
}
 
*/
