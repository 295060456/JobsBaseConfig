//
//  JobsSearchShowHistoryDataTBVCell.m
//  JobsSearch
//
//  Created by Jobs on 2020/10/2.
//

#import "JobsSearchShowHistoryDataTBVCell.h"
#import "UITableViewCell+WhiteArrows.h"

@interface JobsSearchShowHistoryDataTBVCell ()

@end

@implementation JobsSearchShowHistoryDataTBVCell
#pragma mark ββ BaseCellProtocol
+(instancetype)cellStyleValue1WithTableView:(UITableView *)tableView{
    JobsSearchShowHistoryDataTBVCell *cell = (JobsSearchShowHistoryDataTBVCell *)[tableView tableViewCellClass:JobsSearchShowHistoryDataTBVCell.class];
    if (!cell) {
        cell = [JobsSearchShowHistoryDataTBVCell initTableViewCellWithStyle:UITableViewCellStyleDefault];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//        cell.contentView.backgroundColor = RandomColor;
        cell.imageView.image = JobsIMG(@"ζΆι");
    }return cell;
}

+(CGFloat)cellHeightWithModel:(id _Nullable)model{
    return 50;
}

-(void)richElementsInCellWithModel:(id _Nullable)model{
    self.textLabel.text = model;
}

@end
