//
//  BaiShaETProjMsgTBVCell.m
//  BaiShaEntertainmentProj
//
//  Created by Jobs on 2022/6/2.
//

#import "JobsMsgTBVCell.h"

@interface JobsMsgTBVCell ()
/// UI
@property(nonatomic,strong)UILabel *timeLab;
@property(nonatomic,strong)UILabel *pointLab;
@property(nonatomic,strong)UIButton *getBtn;
/// Data
@property(nonatomic,strong)JobsMsgDataModel *msgDataModel;

@end

@implementation JobsMsgTBVCell

#pragma mark —— BaseCellProtocol
/// UITableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableView{
    JobsMsgTBVCell *cell = (JobsMsgTBVCell *)[tableView tableViewCellClass:JobsMsgTBVCell.class];
    if (!cell) {
        cell = [JobsMsgTBVCell initTableViewCellWithStyle:UITableViewCellStyleSubtitle];
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
-(void)richElementsInCellWithModel:(JobsMsgDataModel *_Nullable)model{
    self.msgDataModel = model;
    switch (self.msgDataModel.msgStyle) {
        /// 通知
        case MsgStyle_Notify:{
            self.imageView.image = KIMG(@"通知");
        }break;
        /// 活动
        case MsgStyle_Activity:{
            self.imageView.image = KIMG(@"活动");
        }break;
        /// 公告
        case MsgStyle_Notice:{
            self.imageView.image = KIMG(@"公告");
        }break;
        /// 红利
        case MsgStyle_Bonus:{
            self.imageView.image = KIMG(@"红利");
        }break;
            
        default:
            break;
    }
    
    if (self.msgDataModel.textModel.attributedText) {
        self.textLabel.attributedText = self.msgDataModel.textModel.attributedText;
    }else{
        self.textLabel.text = [NSString stringWithFormat:@"%@",[self.msgDataModel.textModel.text omitByReplaceStr:nil replaceStrLenth:3 lineBreakMode:NSLineBreakByTruncatingTail limit:16]];
        self.textLabel.textColor = HEXCOLOR(0x3D4A58);
        self.textLabel.font = notoSansBold(14);
    }
    
    if (model.subTextModel.attributedText) {
        self.detailTextLabel.attributedText = self.msgDataModel.subTextModel.attributedText;
    }else{
        self.detailTextLabel.text = [NSString stringWithFormat:@"%@",[self.msgDataModel.subTextModel.text omitByReplaceStr:nil replaceStrLenth:3 lineBreakMode:NSLineBreakByTruncatingTail limit:17]];
        self.detailTextLabel.textColor = HEXCOLOR(0xB0B0B0);
        self.detailTextLabel.font = notoSansRegular(12);
    }
    
    self.timeLab.text = model.time;
    
    self.getBtn.selected = self.msgDataModel.isDraw;
    self.getBtn.backgroundColor = self.getBtn.selected ? HEXCOLOR(0xEAEBED) : HEXCOLOR(0xFFEABA);
    self.pointLab.jobsVisible = !self.msgDataModel.isRead;
}
/// 具体由子类进行复写【数据定高】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
+(CGFloat)cellHeightWithModel:(UIViewModel *_Nullable)model{
    return JobsWidth(94);
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self 自定义UITableViewCell修改模式下前面的按钮UI];
}
#pragma mark —— 一些私有方法
-(void)自定义UITableViewCell修改模式下前面的按钮UI{
    for (UIControl *control in self.subviews){
        if ([control isMemberOfClass:NSClassFromString(@"UITableViewCellEditControl")]){
            for (UIView *view in control.subviews){
                if ([view isKindOfClass:UIImageView.class]) {
                    UIImageView *img = (UIImageView *)view;
                    img.image = self.selected ? KIMG(@"按钮已选中") : KIMG(@"按钮未选中");
                }
            }
        }
    }
}
#pragma mark —— LazyLoad
-(UILabel *)timeLab{
    if (!_timeLab) {
        _timeLab = UILabel.new;
        _timeLab.textColor = HEXCOLOR(0xB0B0B0);
        _timeLab.font = notoSansRegular(12);
        [self.contentView addSubview:_timeLab];
        [_timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.contentView).offset(JobsWidth(-16));
            make.left.equalTo(self.textLabel);
        }];
        [_timeLab makeLabelByShowingType:UILabelShowingType_03];
    }return _timeLab;
}

-(UIButton *)getBtn{
    if (!_getBtn) {
        _getBtn = UIButton.new;
        _getBtn.normalTitle = Internationalization(@"  领取  ");
        _getBtn.selectedTitle = Internationalization(@"  已领取  ");
        _getBtn.titleFont = notoSansRegular(12);
        _getBtn.normalTitleColor = HEXCOLOR(0xAE8330);
        _getBtn.selectedTitleColor = HEXCOLOR(0x757575);
        
        [self.contentView addSubview:_getBtn];
        [_getBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(JobsWidth(20));
            make.top.equalTo(self.contentView).offset(JobsWidth(13));
            make.right.equalTo(self.contentView).offset(JobsWidth(-16));
        }];
        [_getBtn makeBtnLabelByShowingType:UILabelShowingType_03];
        BtnClickEvent(_getBtn, {
            if (!x.selected) {
                JobsPopupView02 *popView = (JobsPopupView02 *)[self jobsPopView:JobsPopupView02.class viewModel:UIViewModel.new];
                [popView actionObjectBlock:^(id data) {
                    if ([data isKindOfClass:UIButton.class]) {
                        UIButton *btn = (UIButton *)data;
                        if ([btn.normalTitle isEqualToString:Internationalization(@"立即領取")]) {
                            /// 发送网络请求
                            x.selected = !x.selected;
                            x.backgroundColor = x.selected ? HEXCOLOR(0xEAEBED) : HEXCOLOR(0xFFEABA);
                            /// 本地数据同步
                            self.msgDataModel.isDraw = x.selected;
                            self.pointLab.jobsVisible = !self.msgDataModel.isDraw;
                        }else if ([btn.normalTitle isEqualToString:Internationalization(@"取消")]){
        
                        }else if ([btn.normalTitle isEqualToString:Internationalization(@"本次登入不再提示")]){
                            
                        }else{}
                    }
                    
                }];
                
                if (self.objectBlock) self.objectBlock(popView);
            }
        });
        [_getBtn cornerCutToCircleWithCornerRadius:JobsWidth(10)];
    }return _getBtn;
}

-(UILabel *)pointLab{
    if (!_pointLab) {
        _pointLab = UILabel.new;
        _pointLab.backgroundColor = HEXCOLOR(0xAE8330);
        [self.contentView addSubview:_pointLab];
        [_pointLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(JobsWidth(8), JobsWidth(8)));
            make.right.equalTo(self.getBtn);
            make.top.equalTo(self.getBtn.mas_bottom).offset(JobsWidth(10));
        }];
        [self.pointLab cornerCutToCircleWithCornerRadius:JobsWidth(4)];
    }return _pointLab;
}

@end
