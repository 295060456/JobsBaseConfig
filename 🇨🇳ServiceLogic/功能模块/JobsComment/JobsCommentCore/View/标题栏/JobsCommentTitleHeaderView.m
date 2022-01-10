//
//  JobsCommentTitleHeaderView.m
//  JobsComment
//
//  Created by Jobs on 2020/11/17.
//

#import "JobsCommentTitleHeaderView.h"

@interface JobsCommentTitleHeaderView ()

@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UIButton *cancelBtn;
@property(nonatomic,copy)MKDataBlock jobsCommentTitleHeaderViewBlock;

@end

@implementation JobsCommentTitleHeaderView

static dispatch_once_t dispatchOnce;
-(instancetype)init{
    if (self = [super init]) {
        dispatchOnce = 0;
    }return self;
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    dispatch_once(&dispatchOnce, ^{
        self.titleLab.alpha = 1;
        self.cancelBtn.alpha = 1;
    });
}

-(void)actionBlockJobsCommentTitleHeaderViewBlock:(MKDataBlock)jobsCommentTitleHeaderViewBlock{
    self.jobsCommentTitleHeaderViewBlock = jobsCommentTitleHeaderViewBlock;
}

#pragma mark —— lazyLoad
-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = UILabel.new;
        _titleLab.text = @"评论";
        _titleLab.textColor = kRedColor;
        _titleLab.font = [UIFont systemFontOfSize:18 weight:UIFontWeightRegular];
        [_titleLab sizeToFit];
        [self addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
        }];
    }return _titleLab;
}

-(UIButton *)cancelBtn{
    if (!_cancelBtn) {
        _cancelBtn = UIButton.new;
        [_cancelBtn setImage:KBuddleIMG(@"bundle", @"Others", nil, @"删除")
                    forState:UIControlStateNormal];
        @weakify(self)
        [[_cancelBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            NSLog(@"点击了删除按钮");
            if (self.jobsCommentTitleHeaderViewBlock) {
                self.jobsCommentTitleHeaderViewBlock(x);
            }
        }];
        [self addSubview:_cancelBtn];
        [_cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.right.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(40, 40));
        }];
    }return _cancelBtn;
}

@end
