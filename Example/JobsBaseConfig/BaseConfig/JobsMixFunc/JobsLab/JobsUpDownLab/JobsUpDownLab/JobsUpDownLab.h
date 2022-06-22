//
//  JobsUpDownLab.h
//  Casino
//
//  Created by Jobs on 2021/12/6.
//

#import "BaseView.h"
#import "JobsUpDownLabModel.h"

NS_ASSUME_NONNULL_BEGIN
/// 接受外界的数据模型对象要求是：JobsUpDownLabModel 类型
@interface JobsUpDownLab : BaseView

-(UIButton *)getUpBtn;
-(UIButton *)getDownBtn;

@end

NS_ASSUME_NONNULL_END
/**
 
 -(JobsUpDownLab *)titleLab{
     if (!_titleLab) {
         _titleLab = JobsUpDownLab.new;
         [self addSubview:_titleLab];
         [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
             make.centerY.equalTo(self);
             make.size.mas_equalTo(CGSizeMake(JobsWidth(103), JobsWidth(50)));
             make.left.equalTo(self).offset(JobsWidth(12));
         }];
     }
     [_titleLab richElementsInViewWithModel:self.upDownLabModel];
     [_titleLab.getUpBtn layoutButtonWithEdgeInsetsStyle:GLButtonEdgeInsetsStyleRight imageTitleSpace:JobsWidth(3)];
     return _titleLab;
 }
 
 {
    JobsUpDownLabModel *upDownLabModel = JobsUpDownLabModel.new;
    upDownLabModel.upLabText = @"2.2";
    upDownLabModel.upLabTextAlignment = NSTextAlignmentCenter;
    upDownLabModel.upLabFont = [UIFont systemFontOfSize:JobsWidth(14) weight:UIFontWeightRegular];
    upDownLabModel.upLabTextCor = UIColor.blackColor;
    upDownLabModel.upLabBgCor = UIColor.clearColor;

    upDownLabModel.downLabText = Internationalization(@"Estimated yesterday");
    upDownLabModel.downLabTextAlignment = NSTextAlignmentCenter;
    upDownLabModel.downLabFont = [UIFont systemFontOfSize:JobsWidth(14) weight:UIFontWeightRegular];
    upDownLabModel.downLabTextCor = HEXCOLOR(0x524740);
    upDownLabModel.downLabBgCor = UIColor.clearColor;

    upDownLabModel.upLabVerticalAlign = JobsUpDownLabAlign_TopLeft;
    upDownLabModel.upLabLevelAlign = JobsUpDownLabAlign_TopLeft;
    upDownLabModel.downLabVerticalAlign = JobsUpDownLabAlign_TopLeft;
    upDownLabModel.downLabLevelAlign = JobsUpDownLabAlign_TopLeft;

    upDownLabModel.space = JobsWidth(12);

    [_yesterdayLab richElementsInViewWithModel:upDownLabModel];
 }
 
 */
