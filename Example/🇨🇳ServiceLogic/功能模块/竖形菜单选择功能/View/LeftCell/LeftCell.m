//
//  LeftCell.m
//  MPMALL
//
//  Created by xixi_wen on 2019/7/4.
//  Copyright © 2019 panduola. All rights reserved.
//

#import "LeftCell.h"

@interface LeftCell()

@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,strong)UIView *flagView;

@property(nonatomic,strong)UIImageView *logoImgView;
@property(nonatomic,strong)UILabel *titleLabel;

@end

@implementation LeftCell

#pragma mark —— BaseCellProtocol
/// UITableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableView{
    LeftCell *cell = (LeftCell *)[tableView tableViewCellClass:LeftCell.class];
    if (!cell) {
        cell = [LeftCell initTableViewCellWithStyle:UITableViewCellStyleDefault];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }return cell;
}
/// 具体由子类进行复写【数据定UI】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
-(void)richElementsInCellWithModel:(JobsMsgDataModel *_Nullable)model{
    self.bgView.alpha = 1;
    self.logoImgView.alpha = 1;
    self.titleLabel.text = model.textModel.text;
    self.flagView.alpha = 1;
}
/// 具体由子类进行复写【数据定高】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
+(CGFloat)cellHeightWithModel:(UIViewModel *_Nullable)model{
    return LeftCell_Height;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style
                    reuseIdentifier:reuseIdentifier]){
    }return self;
}
#pragma mark —— 一些私有方法
- (void)setSelected:(BOOL)selected
           animated:(BOOL)animated{
    [super setSelected:selected
              animated:animated];
    if (selected){
        self.bgView.backgroundColor = UIColor.whiteColor;
        self.flagView.backgroundColor = UIColor.redColor;
        self.titleLabel.textColor = UIColor.blackColor;
        self.titleLabel.font = [UIFont boldSystemFontOfSize:12.f];
        self.logoImgView.backgroundColor = UIColor.orangeColor;
    }else{
        self.bgView.backgroundColor = UIColor.grayColor;
        self.flagView.backgroundColor = UIColor.grayColor;
        self.titleLabel.textColor = UIColor.blackColor;
        self.titleLabel.font = [UIFont systemFontOfSize:12.f];
    }
}

- (void)setHighlighted:(BOOL)highlighted
              animated:(BOOL)animated{
    if (highlighted){
        self.bgView.backgroundColor = UIColor.whiteColor;
        self.flagView.backgroundColor = UIColor.redColor;
        self.titleLabel.textColor = UIColor.blackColor;
        self.titleLabel.font = [UIFont boldSystemFontOfSize:12.f];
        self.logoImgView.backgroundColor = UIColor.orangeColor;
    }else{
        self.bgView.backgroundColor = UIColor.grayColor;
        self.flagView.backgroundColor = UIColor.grayColor;
        self.titleLabel.textColor = UIColor.blackColor;
        self.titleLabel.font = [UIFont systemFontOfSize:12.f];
    }
    
}
#pragma mark —— lazyLoad
-(UIView *)bgView{
    if (!_bgView) {
        _bgView = UIView.new;
        _bgView.frame = CGRectMake(0,
                                   0,
                                   LeftCell_Width,
                                   LeftCell_Height);
        _bgView.backgroundColor = UIColor.grayColor;
        [self.contentView addSubview:_bgView];
    }return _bgView;
}

-(UIImageView *)logoImgView{
    if (!_logoImgView) {
        _logoImgView = UIImageView.new;
        
        _logoImgView.size = CGSizeMake(40.f, 40.f);
        _logoImgView.top = 14.f;
        _logoImgView.left = (LeftCell_Width - self.logoImgView.width) * 0.5;
        _logoImgView.contentMode = UIViewContentModeScaleAspectFill;
        _logoImgView.clipsToBounds = YES;
        _logoImgView.backgroundColor = UIColor.orangeColor;
        [self.contentView addSubview:_logoImgView];
        
    }return _logoImgView;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = UILabel.new;
        _titleLabel.frame = CGRectMake(5,
                                       self.logoImgView.bottom + 5.f,
                                       LeftCell_Width - 10.f,
                                       17.f);
        _titleLabel.textColor = UIColor.blackColor;
        _titleLabel.font = [UIFont systemFontOfSize:12.f];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_titleLabel];
    }return _titleLabel;
}

-(UIView *)flagView{
    if (!_flagView) {
        _flagView = UIView.new;
        _flagView.frame = CGRectMake(0, 0, 3, LeftCell_Height);
        _flagView.backgroundColor = UIColor.redColor;
        [self.contentView addSubview:_flagView];
    }return _flagView;
}


@end
