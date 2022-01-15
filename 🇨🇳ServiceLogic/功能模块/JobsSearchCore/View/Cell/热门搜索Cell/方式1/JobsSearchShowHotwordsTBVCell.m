//
//  JobsSearchShowHotwordsTBVCell.m
//  JobsSearch
//
//  Created by Jobs on 2020/10/4.
//

#import "JobsSearchShowHotwordsTBVCell.h"

@interface JobsSearchShowHotwordsTBVCell ()

@property(nonatomic,strong)JobsHotLabel *jobsHotLabel;

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

+(CGFloat)cellHeightWithModel:(id _Nullable)model{
    return 170;
}

-(void)richElementsInCellWithModel:(id _Nullable)model{
    NSLog(@"");
//    self.jobsHotLabel.viewModelDataArr = (NSArray *)model;
}
#pragma mark —— lazyLoad
-(JobsHotLabel *)jobsHotLabel{
    if (!_jobsHotLabel) {
        _jobsHotLabel = JobsHotLabel.new;
        @jobs_weakify(self)
        [_jobsHotLabel actionViewBlock:^(id data) {//点击了哪个Btn？
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
