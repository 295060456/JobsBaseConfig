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
    return [self.alloc initWithStyle:style
                     reuseIdentifier:self.class.description];
}

+(instancetype)initTableViewCell:(Class)tableViewCellClass
                       withStyle:(UITableViewCellStyle)style{
    return [tableViewCellClass.alloc initWithStyle:style
                                   reuseIdentifier:tableViewCellClass.class.description];
}
/// 4种UITableViewCell系统样式类型
/// UITableViewCellStyleDefault = 左边：imageView＋textLabel
+(instancetype)cellStyleDefaultWithTableView:(UITableView *)tableView{
    UITableViewCell *cell = (UITableViewCell *)[tableView tableViewCellClass:self.class];
    if (!cell) {
        cell = [self initTableViewCell:self
                             withStyle:UITableViewCellStyleDefault];
        [self settingForTableViewCell:cell];
    }return cell;
}
/// UITableViewCellStyleValue1 = 左边：imageView＋textLabel；右边：detailTextLabel
+(instancetype)cellStyleValue1WithTableView:(UITableView *)tableView{
    UITableViewCell *cell = (UITableViewCell *)[tableView tableViewCellClass:self.class];
    if (!cell) {
        cell = [self initTableViewCell:self
                             withStyle:UITableViewCellStyleValue1];
        [self settingForTableViewCell:cell];
    }return cell;
}
/// UITableViewCellStyleValue2 = 左边：textLabel字体偏小；右边：detailTextLabel。imageView可选（显示在最左边）
+(instancetype)cellStyleValue2WithTableView:(UITableView *)tableView{
    UITableViewCell *cell = (UITableViewCell *)[tableView tableViewCellClass:self.class];
    if (!cell) {
        cell = [self initTableViewCell:self
                             withStyle:UITableViewCellStyleValue2];
        [self settingForTableViewCell:cell];
    }return cell;
}
/// UITableViewCellStyleSubtitle = 左边：textLabel字体偏小；右边：detailTextLabel。imageView可选（显示在最左边）
+(instancetype)cellStyleSubtitleWithTableView:(UITableView *)tableView{
    UITableViewCell *cell = (UITableViewCell *)[tableView tableViewCellClass:self.class];
    if (!cell) {
        cell = [self initTableViewCell:self
                             withStyle:UITableViewCellStyleSubtitle];
        [self settingForTableViewCell:cell];
    }return cell;
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
#pragma mark —— 一些私有方法
+(void)settingForTableViewCell:(UITableViewCell *)tableViewCell{
    tableViewCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    tableViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
    /// 适配iOS 13夜间模式/深色外观(Dark Mode)
    tableViewCell.backgroundColor = [UIColor xy_createWithLightColor:UIColor.whiteColor darkColor:UIColor.whiteColor];
    tableViewCell.detailTextLabel.textColor = UIColor.brownColor;
    tableViewCell.textLabel.textColor = UIColor.blackColor;
}

@end
