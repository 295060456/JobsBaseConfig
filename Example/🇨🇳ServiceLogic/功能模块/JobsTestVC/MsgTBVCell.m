//
//  BaiShaETProjMsgTBVCell.m
//  BaiShaEntertainmentProj
//
//  Created by Jobs on 2022/6/2.
//

#import "MsgTBVCell.h"

@interface MsgTBVCell ()
/// UI
@property(nonatomic,strong)UILabel *timeLab;
/// Data
@property(nonatomic,strong)UIViewModel *msgDataModel;

@end

@implementation MsgTBVCell

#pragma mark —— BaseCellProtocol
/// UITableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableView{
    MsgTBVCell *cell = (MsgTBVCell *)[tableView tableViewCellClass:MsgTBVCell.class];
    if (!cell) {
        cell = [MsgTBVCell initTableViewCellWithStyle:UITableViewCellStyleSubtitle];
        cell.imageViewFrameOffsetY = JobsWidth(-10);
        cell.textLabelFrameOffsetY = JobsWidth(-10);
        cell.detailTextLabelOffsetY = JobsWidth(-10);
        cell.textLabelWidth = JobsWidth(217);
        cell.detailTextLabelWidth = JobsWidth(250);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell cornerCutToCircleWithCornerRadius:JobsWidth(8)];
    }return cell;
}
/// 具体由子类进行复写【数据定UI】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
-(void)richElementsInCellWithModel:(UIViewModel *_Nullable)model{
    self.msgDataModel = model;
    
    self.imageView.image = KIMG(@"通知");

    if (self.msgDataModel.textModel.attributedText) {
        self.textLabel.attributedText = self.msgDataModel.textModel.attributedText;
    }else{
        self.textLabel.text = @"哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈";
//        self.textLabel.backgroundColor = kRedColor;
        /// Internationalization(@"哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈");
        //[NSString stringWithFormat:@"%@",self.msgDataModel.textModel.text];
        self.textLabel.textColor = HEXCOLOR(0x3D4A58);
//        self.textLabel.font = notoSansBold(14);
        self.textLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    
    if (model.subTextModel.attributedText) {
        self.detailTextLabel.attributedText = self.msgDataModel.subTextModel.attributedText;
    }else{
        self.detailTextLabel.text = [NSString stringWithFormat:@"%@",self.msgDataModel.subTextModel.text];
        self.detailTextLabel.textColor = HEXCOLOR(0xB0B0B0);
//        self.detailTextLabel.font = notoSansRegular(12);
    }
    
    self.timeLab.text = @"we3rt";
}
/// 具体由子类进行复写【数据定高】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
+(CGFloat)cellHeightWithModel:(UIViewModel *_Nullable)model{
    return JobsWidth(94);
}
#pragma mark —— LazyLoad
-(UILabel *)timeLab{
    if (!_timeLab) {
        _timeLab = UILabel.new;
        _timeLab.textColor = HEXCOLOR(0xB0B0B0);
//        _timeLab.font = notoSansRegular(12);
        [self.contentView addSubview:_timeLab];
        [_timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.contentView).offset(JobsWidth(-16));
            make.left.equalTo(self.textLabel);
        }];
        [_timeLab makeLabelByShowingType:UILabelShowingType_03];
    }return _timeLab;
}

@end
