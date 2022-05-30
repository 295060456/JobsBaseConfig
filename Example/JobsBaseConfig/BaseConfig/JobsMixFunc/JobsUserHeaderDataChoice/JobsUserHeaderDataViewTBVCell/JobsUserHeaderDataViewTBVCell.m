//
//  JobsUserHeaderDataViewTBVCell.m
//  BaiShaEntertainmentProj
//
//  Created by Jobs on 2022/5/19.
//

#import "JobsUserHeaderDataViewTBVCell.h"

@interface JobsUserHeaderDataViewTBVCell ()

@property(nonatomic,strong)UILabel *titleLab;

@end

@implementation JobsUserHeaderDataViewTBVCell

@synthesize viewModel = _viewModel;

#pragma mark —— UITableViewCellProtocol
/// UITableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableView{
    JobsUserHeaderDataViewTBVCell *cell = (JobsUserHeaderDataViewTBVCell *)[tableView tableViewCellClass:JobsUserHeaderDataViewTBVCell.class];
    if (!cell) {
        cell = [JobsUserHeaderDataViewTBVCell initTableViewCellWithStyle:UITableViewCellStyleDefault];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = HEXCOLOR(0xFFFFFF);
    }return cell;
}
/// 具体由子类进行复写【数据定UI】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
-(void)richElementsInCellWithModel:(UIViewModel *_Nullable)model{
    self.viewModel = model;
    self.titleLab.alpha = 1;
}
/// 具体由子类进行复写【数据定高】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
+(CGFloat)cellHeightWithModel:(UIViewModel *_Nullable)model{
    return JobsWidth(46);
}

-(NSString *)getTitleValue{
    return self.titleLab.text;
}
#pragma mark —— lazyLoad
-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = UILabel.new;
        _titleLab.text = [NSString isNullString:self.viewModel.textModel.text] ? Internationalization(@"请设置标题") : self.viewModel.textModel.text;
        _titleLab.textColor = self.viewModel.textModel.textCor;
        _titleLab.font = self.viewModel.textModel.font;
        _titleLab.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
    }return _titleLab;
}

@end
