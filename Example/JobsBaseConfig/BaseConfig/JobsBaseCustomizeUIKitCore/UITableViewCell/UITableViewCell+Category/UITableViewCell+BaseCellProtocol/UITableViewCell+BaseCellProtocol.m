//
//  UITableViewCell+BaseCellProtocol.m
//  DouDong-II
//
//  Created by Jobs on 2021/11/19.
//

#import "UITableViewCell+BaseCellProtocol.h"

@implementation UITableViewCell (BaseCellProtocol)
#pragma mark —— @dynamic UITableViewCellProtocol
UITableViewCellProtocol_dynamic
#pragma mark —— UITableViewCellProtocol
+(instancetype)initTableViewCellWithStyle:(UITableViewCellStyle)style{
    return [self.alloc initWithStyle:style reuseIdentifier:self.class.description];
}
/// 左边：imageView＋textLabel
+(instancetype)cellStyleDefaultWithTableView:(UITableView *)tableView{
    BaseTableViewCell *cell = (BaseTableViewCell *)[tableView tableViewCellClass:BaseTableViewCell.class];
    if (!cell) {
        cell = [BaseTableViewCell initTableViewCellWithStyle:UITableViewCellStyleDefault];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }return cell;
}
/// 左边：imageView＋textLabel；右边：detailTextLabel。
+(instancetype)cellStyleValue1WithTableView:(UITableView *)tableView{
    BaseTableViewCell *cell = (BaseTableViewCell *)[tableView tableViewCellClass:BaseTableViewCell.class];
    if (!cell) {
        cell = [BaseTableViewCell initTableViewCellWithStyle:UITableViewCellStyleValue1];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }return cell;
}
/// 左边：textLabel字体偏小；右边：detailTextLabel。imageView可选（显示在最左边）
+(instancetype)cellStyleValue2WithTableView:(UITableView *)tableView{
    BaseTableViewCell *cell = (BaseTableViewCell *)[tableView tableViewCellClass:BaseTableViewCell.class];
    if (!cell) {
        cell = [BaseTableViewCell initTableViewCellWithStyle:UITableViewCellStyleValue2];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }return cell;
}
/// 左边：imageView；左上：textLabel；左下：detailTextLabel。主标题字体大且加黑，副标题字体小在主标题下边。
+(instancetype)cellStyleSubtitleWithTableView:(UITableView *)tableView{
    BaseTableViewCell *cell = (BaseTableViewCell *)[tableView tableViewCellClass:BaseTableViewCell.class];
    if (!cell) {
        cell = [BaseTableViewCell initTableViewCellWithStyle:UITableViewCellStyleSubtitle];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }return cell;
}

+(instancetype)cellStyleDefaultWithTableView:(UITableView *)tableView
                       cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BaseTableViewCell *cell = [BaseTableViewCell cellStyleDefaultWithTableView:tableView];
    cell.indexPath = indexPath;
    return cell;
}

+(instancetype)cellStyleValue1WithTableView:(UITableView *)tableView
                      cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BaseTableViewCell *cell = [BaseTableViewCell cellStyleValue1WithTableView:tableView];
    cell.indexPath = indexPath;
    return cell;
}

+(instancetype)cellStyleValue2WithTableView:(UITableView *)tableView
                      cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BaseTableViewCell *cell = [BaseTableViewCell cellStyleValue2WithTableView:tableView];
    cell.indexPath = indexPath;
    return cell;
}

+(instancetype)cellStyleSubtitleWithTableView:(UITableView *)tableView
                        cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BaseTableViewCell *cell = [BaseTableViewCell cellStyleSubtitleWithTableView:tableView];
    cell.indexPath = indexPath;
    return cell;
}
#pragma mark —— BaseCellProtocol
-(void)richElementsInCellWithModel:(UIViewModel *_Nullable)model{
    if ([model isKindOfClass:UIViewModel.class]) {
        self.textLabel.textColor = model.textModel.textCor;
        self.textLabel.font = model.textModel.font;
        self.textLabel.text = model.textModel.text;
        self.imageView.image = model.image;
    }
}

-(void)setCellBgImage:(UIImage *)bgImage{
    self.backgroundColor = self.contentView.backgroundColor = UIColor.clearColor;
    self.backgroundImageView.image = bgImage;
}

+(CGFloat)cellHeightWithModel:(id _Nullable)model{
    return JobsWidth(44);
}

@end
