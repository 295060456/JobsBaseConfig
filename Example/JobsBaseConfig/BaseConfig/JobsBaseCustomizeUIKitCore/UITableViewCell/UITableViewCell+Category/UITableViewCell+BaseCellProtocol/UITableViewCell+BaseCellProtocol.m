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

+(instancetype)cellWithTableView:(UITableView *)tableView{
    UITableViewCell *cell = (UITableViewCell *)[tableView tableViewCellClass:UITableViewCell.class];
    if (!cell) {
        cell = [UITableViewCell initTableViewCellWithStyle:UITableViewCellStyleSubtitle];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
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

@end
