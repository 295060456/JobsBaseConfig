//
//  CommentPopUpNonHoveringHeaderView.m
//  My_BaseProj
//
//  Created by Jobs on 2020/10/2.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "JobsCommentPopUpView_viewForHeaderInSection.h"

@interface JobsCommentPopUpView_viewForHeaderInSection ()
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

@implementation JobsCommentPopUpView_viewForHeaderInSection

-(instancetype)init{
    if (self = [super init]) {
        
    }return self;
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches
          withEvent:(UIEvent *)event{
    if (self.objectBlock) self.objectBlock(@1);
}
#pragma mark —— BaseViewProtocol
/// 具体由子类进行复写【数据定高】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
+(CGFloat)viewHeightWithModel:(id _Nullable)model{
    return JobsCommentConfig.sharedInstance.cellHeight;
}
/// 具体由子类进行复写【数据定UI】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
-(void)richElementsInViewWithModel:(id _Nullable)model{
    self.backgroundColor = UIColor.whiteColor;
    if ([model isKindOfClass:JobsFirstCommentModel.class]) {
        self.firstCommentModel = model;
        [self.headerIMGV sd_setImageWithURL:[NSURL URLWithString:self.firstCommentModel.headImg]
                           placeholderImage:[UIImage animatedGIFNamed:@"动态头像 尺寸126"]];
        self.titleStr = self.firstCommentModel.nickname;
        self.contentStr = self.firstCommentModel.content;
        self.titleLab.alpha = 1;
        self.contentLab.alpha = 1;
        self.LikeBtn.selected = self.firstCommentModel.isPraise;
    }
}
#pragma mark —— lazyLoad
-(UIImageView *)headerIMGV{
    if (!_headerIMGV) {
        _headerIMGV = UIImageView.new;
        [self addSubview:_headerIMGV];
        [_headerIMGV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(JobsCommentConfig.sharedInstance.headerImageViewSize);
            make.left.equalTo(self).offset(16);
            make.centerY.equalTo(self);
        }];
    }return _headerIMGV;
}

-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = UILabel.new;
        _titleLab.text = self.titleStr;
        _titleLab.attributedText = [NSMutableAttributedString.alloc initWithString:self.titleStr ? : @""
                                                                        attributes:@{NSFontAttributeName: JobsCommentConfig.sharedInstance.titleFont,
                                                                                     NSForegroundColorAttributeName: JobsCommentConfig.sharedInstance.titleCor}];
        [self addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
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
        [self addSubview:_contentLab];
        [_contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_centerY);
            make.bottom.equalTo(self);
            make.left.equalTo(self.headerIMGV.mas_right).offset(10);
        }];
    }return _contentLab;
}

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
        
        [self addSubview:_LikeBtn];
        [_LikeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(JobsCommentConfig.sharedInstance.cellHeight / 2, JobsCommentConfig.sharedInstance.cellHeight / 2));
            make.right.equalTo(self).offset(-13);
            make.centerY.equalTo(self);
        }];
    }return _LikeBtn;
}

@end
