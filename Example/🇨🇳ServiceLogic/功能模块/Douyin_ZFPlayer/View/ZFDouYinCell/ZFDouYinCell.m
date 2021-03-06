//
//  ZFDouYinCell.m
//  DouYin
//
//  Created by Jobs on 2020/9/28.
//

#import "ZFDouYinCell.h"
#import "MKRightBtnView.h"

@interface ZFDouYinCell ()

@property(nonatomic,strong)UILabel *label;
@property(nonatomic,strong)UIImageView *coverImageView;
@property(nonatomic,strong)MKRightBtnView *rbView;
@property(nonatomic,strong)UIButton *rotation;

@end

@implementation ZFDouYinCell

+(instancetype)cellStyleValue1WithTableView:(UITableView *)tableView{
    ZFDouYinCell *cell = (ZFDouYinCell *)[tableView tableViewCellClass:ZFDouYinCell.class];
    if (!cell) {
        cell = [ZFDouYinCell initTableViewCellWithStyle:UITableViewCellStyleSubtitle];;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.contentView.backgroundColor = RandomColor;
    }return cell;
}

+(CGFloat)cellHeightWithModel:(id _Nullable)model{
    if ([model isKindOfClass:NSDictionary.class]) {//
        NSDictionary *dic = (NSDictionary *)model;
        UITableView *tbv = (UITableView *)dic[@"tableView"];
        return tbv.mj_h;
    }return JobsMainScreen_HEIGHT();
}

-(void)richElementsInCellWithModel:(id _Nullable)model{
    if ([model isKindOfClass:NSDictionary.class]) {
        NSDictionary *dic = (NSDictionary *)model;
        self.label.text = [NSString stringWithFormat:@"%d",[dic[@"index"] intValue]];
        self.data = (VideoModel_Core *)dic[@"res"];
        self.rotation.alpha = 1;
        [self.coverImageView setImageWithURLString:self.data.videoImg
                                       placeholder:JobsBuddleIMG(@"bundle",@"Others", nil, @"loading_bgView")];
//        self.titleLabel.text = data.title;
        self.rbView.alpha = 1;
//        if (self.data.video_width > self.data.video_height) { /// 横屏视频才支持旋转
//            self.rotation.hidden = NO;
//        }else{
//            self.rotation.hidden = YES;
//        }
    }
}

-(void)rotationClick:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(zf_douyinRotation)]) {
        [self.delegate zf_douyinRotation];
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

-(MKRightBtnView *)rbView{
    if (!_rbView) {
        _rbView = MKRightBtnView.new;
        _rbView.MKRightBtnViewSize = CGSizeMake(50, JobsMainScreen_HEIGHT()/ 4);
        _rbView.offset = 15;
        [self.contentView addSubview:_rbView];
        [_rbView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.bottom.equalTo(self.contentView);
            make.size.mas_equalTo(CGSizeMake(50, JobsMainScreen_HEIGHT()/ 4));
        }];
    }return _rbView;
}

-(UIButton *)rotation{
    if (!_rotation){
        _rotation = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rotation setImage:JobsIMG(@"zfplayer_rotaiton")
                   forState:UIControlStateNormal];
        @jobs_weakify(self)
        [[_rotation rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @jobs_strongify(self)
            [self rotationClick:x];
        }];
        [self.contentView addSubview:_rotation];
        [_rotation mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(50, 50));
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(self.contentView);
        }];
    }return _rotation;
}

@end
