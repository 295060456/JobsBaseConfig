//
//  InfoTBVCell.m
//  commentList
//
//  Created by Jobs on 2020/7/14.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "JobsInfoTBVCell.h"

@interface JobsInfoTBVCell ()
/// UI
@property(nonatomic,strong)RBCLikeButton *LikeBtn;
/// Data
@property(nonatomic,strong)JobsChildCommentModel *childCommentModel;

@end

@implementation JobsInfoTBVCell

#pragma mark —— BaseCellProtocol
+(instancetype)cellStyleValue1WithTableView:(UITableView *)tableView{
    JobsInfoTBVCell *cell = (JobsInfoTBVCell *)[tableView tableViewCellClass:JobsInfoTBVCell.class];
    if (!cell) {
        cell = [JobsInfoTBVCell initTableViewCellWithStyle:UITableViewCellStyleSubtitle];;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.contentView.backgroundColor = JobsCommentConfig.sharedInstance.bgCor;
    }return cell;
}

+(CGFloat)cellHeightWithModel:(id _Nullable)model{
    return JobsCommentConfig.sharedInstance.cellHeight;
}

- (void)richElementsInCellWithModel:(id _Nullable)model{
    if ([model isKindOfClass:JobsChildCommentModel.class]) {
        self.childCommentModel = (JobsChildCommentModel *)model;
        self.LikeBtn.selected = self.childCommentModel.isPraise.boolValue;
        self.LikeBtn.thumpNum = self.childCommentModel.praiseNum;
        self.textLabel.text = self.childCommentModel.nickname;
        self.detailTextLabel.text = self.childCommentModel.content;
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.childCommentModel.headImg]
                          placeholderImage:[UIImage animatedGIFNamed:@"动态头像 尺寸126"]];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.imageView.size = JobsCommentConfig.sharedInstance.headerImageViewSize;//subTitleOffset
    [self.imageView cornerCutToCircleWithCornerRadius:self.imageView.mj_h / 2];
    self.textLabel.font = JobsCommentConfig.sharedInstance.titleFont;
    self.detailTextLabel.font = JobsCommentConfig.sharedInstance.subTitleFont;
    self.textLabel.textColor = JobsCommentConfig.sharedInstance.titleCor;
    self.detailTextLabel.textColor = JobsCommentConfig.sharedInstance.subTitleCor;
    
    //因为二级评论和一级评论的控件之间存在一定的offset(向右偏)，故这里进行重写约束
    self.imageView.mj_x += JobsCommentConfig.sharedInstance.secondLevelCommentOffset;
    self.textLabel.mj_x += JobsCommentConfig.sharedInstance.secondLevelCommentOffset;
    self.detailTextLabel.mj_x += JobsCommentConfig.sharedInstance.secondLevelCommentOffset;
}

-(RBCLikeButton *)getLikeBtn{
    return _LikeBtn;
}
#pragma mark —— lazyLoad
-(RBCLikeButton *)LikeBtn{
    if (!_LikeBtn) {
        _LikeBtn = RBCLikeButton.new;
        
        _LikeBtn.normalImage = JobsBuddleIMG(nil, @"RBCLikeButton", nil, @"day_like");
        _LikeBtn.selectedImage = JobsBuddleIMG(nil, @"RBCLikeButton", nil, @"day_like_red");
        
//        _LikeBtn.layer.cornerRadius = SCALING_RATIO(55 / 4);
//        _LikeBtn.layer.borderColor = kGrayColor.CGColor;
//        _LikeBtn.layer.borderWidth = 1;
        _LikeBtn.thumpNum = 0;
        @jobs_weakify(self)
        [_LikeBtn btnClickEventBlock:^(UIButton *x) {
            @jobs_strongify(self)
            if (self.objectBlock) self.objectBlock(x);
            if (self->_LikeBtn.selected) {
                [self->_LikeBtn setThumbWithSelected:NO
                                            thumbNum:self->_LikeBtn.thumpNum - 1
                                     animation:YES];
            }else{
                [self->_LikeBtn setThumbWithSelected:YES
                                            thumbNum:self->_LikeBtn.thumpNum + 1
                                     animation:YES];
            }
        }];
        
        [self.contentView addSubview:_LikeBtn];
        [_LikeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(55 / 2, 55 / 2));
            make.right.equalTo(self.contentView).offset(-13);
            make.centerY.equalTo(self.contentView);
        }];
    }return _LikeBtn;
}

@end
