//
//  BaiShaETProjMembersTBVCell.m
//  BaiShaEntertainmentProj
//
//  Created by Jobs on 2022/5/16.
//

#import "BaiShaETProjMembersTBVCell1.h"

@interface BaiShaETProjMembersTBVCell1 ()

@end

@implementation BaiShaETProjMembersTBVCell1
#pragma mark —— @synthesize UITableViewCellProtocol
UITableViewCellProtocol_synthesize
#pragma mark —— UITableViewCellProtocol
+(instancetype)cellStyleValue1WithTableView:(UITableView *)tableView{
    BaiShaETProjMembersTBVCell1 *cell = (BaiShaETProjMembersTBVCell1 *)[tableView tableViewCellClass:BaiShaETProjMembersTBVCell1.class];
    if (!cell) {
        cell = [BaiShaETProjMembersTBVCell1 initTableViewCellWithStyle:UITableViewCellStyleDefault];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.offsetXForEach = JobsWidth(8);
    }return cell;
}
#pragma mark —— BaseCellProtocol
/// 具体由子类进行复写【数据定UI】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
-(void)richElementsInCellWithModel:(UIViewModel *_Nullable)model{
    self.textLabel.text = model.textModel.text;
    self.imageView.image = model.image;
}
/// 具体由子类进行复写【数据定高】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
+(CGFloat)cellHeightWithModel:(UIViewModel *_Nullable)model{
    return JobsWidth(224 / 4);
}
#pragma mark —— 子类重写父类方法
-(void)setFrame:(CGRect)frame{
    NSLog(@"self.offsetXForEach = %f",self.offsetXForEach);
    NSLog(@"self.offsetYForEach = %f",self.offsetYForEach);
    frame.origin.x += self.offsetXForEach;
    frame.origin.y += self.offsetYForEach;
    frame.size.height -= self.offsetYForEach * 2;
    frame.size.width -= self.offsetXForEach * 2;
    [super setFrame:frame];
}

@end
