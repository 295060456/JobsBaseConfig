//
//  ZFDouYinCell.m
//  DouYin
//
//  Created by Jobs on 2020/9/28.
//

#import "ZFDouYinCell.h"

@interface ZFDouYinCell ()
/// UI
@property(nonatomic,strong)UILabel *label;
@property(nonatomic,strong)UIImageView *coverImageView;
@property(nonatomic,strong)JobsRightBtnsView *rbView;
@property(nonatomic,strong)UIButton *rotation;
/// Data
@property(nonatomic,strong)VideoModel_Core *data;

@end

@implementation ZFDouYinCell
@synthesize index = _index;
+(instancetype)cellStyleValue1WithTableView:(UITableView *)tableView{
    ZFDouYinCell *cell = (ZFDouYinCell *)[tableView tableViewCellClass:ZFDouYinCell.class];
    if (!cell) {
        cell = [ZFDouYinCell initTableViewCellWithStyle:UITableViewCellStyleSubtitle];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.contentView.backgroundColor = JobsRandomColor;
    }return cell;
}

+(CGFloat)cellHeightWithModel:(id _Nullable)model{
    if ([model isKindOfClass:UITableView.class]) {
        UITableView *tbv = (UITableView *)model;
        return tbv.mj_h;
    }return JobsMainScreen_HEIGHT();
}

-(void)richElementsInCellWithModel:(VideoModel_Core *_Nullable)model{
    if ([model isKindOfClass:VideoModel_Core.class]) {
        self.data = (VideoModel_Core *)model;
        self.label.text = [NSString stringWithFormat:@"%ld",(long)self.index];
        self.rotation.alpha = 1;
        [self.coverImageView setImageWithURLString:self.data.videoImg
                                       placeholder:JobsBuddleIMG(@"bundle",@"Others", nil, @"loading_bgView")];
        self.rbView.alpha = 1;
//        self.titleLabel.text = data.title;
//        self.rotation.hidden;// 宽大于高 = 横屏视频，才支持旋转
    }
}
#pragma mark —— lazyLoad
-(UIImageView *)coverImageView{
    if (!_coverImageView) {
        _coverImageView = UIImageView.new;
        _coverImageView.userInteractionEnabled = YES;
        _coverImageView.tag = 100;//不写这个光有声音没有图像
        _coverImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_coverImageView];
        [_coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
    }return _coverImageView;
}

-(JobsRightBtnsView *)rbView{
    if (!_rbView) {
        _rbView = JobsRightBtnsView.new;
        _rbView.offset = JobsWidth(15);
        [_rbView richElementsInViewWithModel:nil];
//        @jobs_weakify(self)
        [_rbView actionObjectBlock:^(id data) {
//            @jobs_strongify(self)
        }];
        [self.contentView addSubview:_rbView];
        [_rbView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.bottom.equalTo(self.contentView);
            make.size.mas_equalTo([JobsRightBtnsView viewSizeWithModel:nil]);
        }];
    }return _rbView;
}

-(UIButton *)rotation{
    if (!_rotation){
        _rotation = [UIButton buttonWithType:UIButtonTypeCustom];
        _rotation.normalImage = JobsIMG(@"zfplayer_rotaiton");
        @jobs_weakify(self)
        [_rotation jobsBtnClickEventBlock:^(__kindof UIControl * _Nullable x) {
            @jobs_strongify(self)
            if ([self.delegate respondsToSelector:@selector(zf_douyinRotation)]) [self.delegate zf_douyinRotation];
        }];
        [self.contentView addSubview:_rotation];
        [_rotation mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(JobsWidth(50), JobsWidth(50)));
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(self.contentView);
        }];
    }return _rotation;
}

@end
