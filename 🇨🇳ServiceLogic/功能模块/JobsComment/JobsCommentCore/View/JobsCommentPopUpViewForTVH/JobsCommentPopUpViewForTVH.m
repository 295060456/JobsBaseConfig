//
//  CommentPopUpNonHoveringHeaderView.m
//  My_BaseProj
//
//  Created by Jobs on 2020/10/2.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "JobsCommentPopUpViewForTVH.h"

@interface JobsCommentPopUpViewForTVH ()
/// UI
@property(nonatomic,strong)UIImageView *headerIMGV;
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UILabel *contentLab;
@property(nonatomic,strong)RBCLikeButton *LikeBtn;
/// Data
@property(nonatomic,strong)NSString *titleStr;
@property(nonatomic,strong)NSString *contentStr;
@property(nonatomic,strong)JobsFirstCommentModel *firstCommentModel;

@end

@implementation JobsCommentPopUpViewForTVH

-(instancetype)initWithReuseIdentifier:(nullable NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = JobsCommentConfig.sharedInstance.bgCor;
    }return self;
}
#pragma mark —— BaseViewProtocol
/// 具体由子类进行复写【数据定高】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
+(CGFloat)viewHeightWithModel:(id _Nullable)model{
    return JobsCommentConfig.sharedInstance.cellHeight;
}
/// 具体由子类进行复写【数据定UI】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
-(void)richElementsInViewWithModel:(id _Nullable)model{
    self.firstCommentModel = model;
    [self.headerIMGV sd_setImageWithURL:[NSURL URLWithString:self.firstCommentModel.headImg]
                       placeholderImage:[UIImage animatedGIFNamed:@"动态头像 尺寸126"]];
    self.titleStr = self.firstCommentModel.nickname;
    self.contentStr = self.firstCommentModel.content;
    self.titleLab.alpha = 1;
    self.contentLab.alpha = 1;
    self.LikeBtn.selected = self.firstCommentModel.isPraise;
}
#pragma mark —— lazyLoad
-(UIImageView *)headerIMGV{
    if (!_headerIMGV) {
        _headerIMGV = UIImageView.new;
        [self.contentView addSubview:_headerIMGV];
        [_headerIMGV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(JobsCommentConfig.sharedInstance.headerImageViewSize);
            make.left.equalTo(self.contentView).offset(16);
            make.centerY.equalTo(self.contentView);
        }];
    }return _headerIMGV;
}

-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = UILabel.new;
        _titleLab.text = self.titleStr;
        _titleLab.attributedText = [NSMutableAttributedString.alloc initWithString:self.titleStr
                                                                        attributes:@{NSFontAttributeName: JobsCommentConfig.sharedInstance.titleFont,
                                                                                     NSForegroundColorAttributeName: JobsCommentConfig.sharedInstance.titleCor}];
        [self.contentView addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView);
            make.bottom.equalTo(self.headerIMGV.mas_centerY);
            make.left.equalTo(self.headerIMGV.mas_right).offset(10);
        }];
    }return _titleLab;
}

-(UILabel *)contentLab{
    if (!_contentLab) {
        _contentLab = UILabel.new;
        _contentLab.text = self.contentStr;
        _contentLab.attributedText = [[NSMutableAttributedString alloc] initWithString:self.contentStr
                                                                            attributes:@{NSFontAttributeName: JobsCommentConfig.sharedInstance.subTitleFont,
                                                                                         NSForegroundColorAttributeName: JobsCommentConfig.sharedInstance.subTitleCor}];
        [self.contentView addSubview:_contentLab];
        [_contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_centerY);
            make.bottom.equalTo(self.contentView);
            make.left.equalTo(self.headerIMGV.mas_right).offset(10);
        }];
    }return _contentLab;
}

-(RBCLikeButton *)LikeBtn{
    if (!_LikeBtn) {
        _LikeBtn = RBCLikeButton.new;
        [_LikeBtn normalImage:KBuddleIMG(nil, @"RBCLikeButton", nil, @"day_like")];
        [_LikeBtn selectedImage:KBuddleIMG(nil, @"RBCLikeButton", nil, @"day_like_red")];
//        _LikeBtn.layer.cornerRadius = SCALING_RATIO(55 / 4);
//        _LikeBtn.layer.borderColor = kGrayColor.CGColor;
//        _LikeBtn.layer.borderWidth = 1;
        _LikeBtn.thumpNum = 0;
        
        BtnClickEvent(_LikeBtn, {
            if (self.viewBlock) self.viewBlock(x);
            if (self->_LikeBtn.selected) {
                [self->_LikeBtn setThumbWithSelected:NO
                                            thumbNum:self->_LikeBtn.thumpNum - 1
                                     animation:YES];
            }else{
                [self->_LikeBtn setThumbWithSelected:YES
                                            thumbNum:self->_LikeBtn.thumpNum + 1
                                     animation:YES];
            }
        });
        
        [self.contentView addSubview:_LikeBtn];
        [_LikeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(JobsCommentConfig.sharedInstance.cellHeight / 2, JobsCommentConfig.sharedInstance.cellHeight / 2));
            make.right.equalTo(self.contentView).offset(-13);
            make.centerY.equalTo(self.contentView);
        }];
    }return _LikeBtn;
}

@end
