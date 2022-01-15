//
//  JobsSearchShowHotwordsTBVCell.m
//  JobsSearch
//
//  Created by Jobs on 2020/10/4.
//

#import "JobsSearchShowHotwordsTBVCell.h"

@interface JobsSearchShowHotwordsTBVCell ()

@property(nonatomic,strong)JobsHotLabelWithMultiLine *jobsHotLabel;

@end

@implementation JobsSearchShowHotwordsTBVCell

#pragma mark —— BaseCellProtocol
+(instancetype)cellWithTableView:(UITableView *)tableView{
    JobsSearchShowHotwordsTBVCell *cell = (JobsSearchShowHotwordsTBVCell *)[tableView dequeueReusableCellWithIdentifier:ReuseIdentifier];
    if (!cell) {
        cell = [JobsSearchShowHotwordsTBVCell.alloc initWithStyle:UITableViewCellStyleDefault
                                                  reuseIdentifier:ReuseIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }return cell;
}

+(CGFloat)cellHeightWithModel:(NSMutableArray <UIViewModel *>* _Nullable)model{
    CGFloat width = hotLabLeft + hotLabRight;
    CGFloat height = 0;
    int row = 1;
    for (UIViewModel *viewModel in model) {
        CGSize size = [UILabel sizeWithText:viewModel.text
                                       font:[UIFont systemFontOfSize:JobsWidth(14) weight:UIFontWeightRegular]
                                    maxSize:CGSizeZero];
        width += size.width + hotLabOffsetX;
        height = size.height;
        if (width >= JobsSearchShowHotwordsTBVCellWidth) {
            width = hotLabLeft + hotLabRight;
            row += 1;
        }
    }
    CGFloat offset = JobsWidth(3);// 从何而来？
    return (height + hotLabOffsetY) * row + (hotLabTop + hotLabBottom) + offset;
}

-(void)richElementsInCellWithModel:(NSMutableArray <UIViewModel *>* _Nullable)model{
    self.viewModelMutArr = model;
    if (self.viewModelMutArr.count) {
        [self.jobsHotLabel richElementsInViewWithModel:self.viewModelMutArr];
    }
}
#pragma mark —— lazyLoad
-(JobsHotLabelWithMultiLine *)jobsHotLabel{
    if (!_jobsHotLabel) {
        _jobsHotLabel = JobsHotLabelWithMultiLine.new;
        @jobs_weakify(self)
        [_jobsHotLabel actionViewBlock:^(UIViewModel *data) {
            @jobs_strongify(self)
            if (self.viewBlock) self.viewBlock(data);
        }];
        [self.contentView addSubview:_jobsHotLabel];
        [_jobsHotLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
    }return _jobsHotLabel;
}

@end
