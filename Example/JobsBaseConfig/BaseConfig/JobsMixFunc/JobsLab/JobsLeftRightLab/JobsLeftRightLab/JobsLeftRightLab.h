//
//  JobsLeftRightLab.h
//  Casino
//
//  Created by Jobs on 2021/12/6.
//

#import "BaseView.h"
#import "JobsLeftRightLabModel.h"

NS_ASSUME_NONNULL_BEGIN
/// 接受外界的数据模型对象要求是：JobsLeftRightLabModel 类型
@interface JobsLeftRightLab : BaseView

@end

NS_ASSUME_NONNULL_END
/**
 
 -(JobsLeftRightLab *)amountValueLab{
     if (!_amountValueLab) {
         _amountValueLab = JobsLeftRightLab.new;
         [self addSubview:_amountValueLab];
         [_amountValueLab mas_makeConstraints:^(MASConstraintMaker *make) {
             make.centerY.equalTo(self);
             make.left.equalTo(self).offset(JobsWidth(16));
             {
                 UIViewModel *vm = UIViewModel.new;
                 
                 vm.textModel.textLineSpacing = 0;
                 vm.textModel.font = UIFontWeightRegularSize(14);
                 vm.textModel.jobsHeight = JobsWidth(20);
                 vm.textModel.text = Internationalization([@"投注额" stringByAppendingString:@"2.99"]);
                 vm.textModel.textCor = HEXCOLOR(0x757575);
                 
                 CGFloat width = [UIView widthByData:vm];
                 width += self.amountValueModel.space + JobsWidth(5);// JobsWidth(5) 是补偿值
                 
                 make.size.mas_equalTo(CGSizeMake(width, JobsWidth(20)));
             }
         }];
         [_amountValueLab richElementsInViewWithModel:self.amountValueModel];
     }return _amountValueLab;
 }
 
 
 -(JobsLeftRightLabModel *)amountValueModel{
     if (!_amountValueModel) {
         _amountValueModel = JobsLeftRightLabModel.new;
         _amountValueModel.upLabText = Internationalization(@"投注额");
         _amountValueModel.upLabTextAlignment = NSTextAlignmentCenter;
         _amountValueModel.upLabFont = [UIFont systemFontOfSize:JobsWidth(14) weight:UIFontWeightRegular];
         _amountValueModel.upLabTextCor = HEXCOLOR(0x757575);
         _amountValueModel.upLabBgCor = UIColor.clearColor;

         _amountValueModel.downLabText = @"2.99";
         _amountValueModel.downLabTextAlignment = NSTextAlignmentCenter;
         _amountValueModel.downLabFont = [UIFont systemFontOfSize:JobsWidth(14) weight:UIFontWeightBold];
         _amountValueModel.downLabTextCor = HEXCOLOR(0x757575);
         _amountValueModel.downLabBgCor = UIColor.clearColor;

         _amountValueModel.upLabVerticalAlign = JobsUpDownLabAlign_TopLeft;
         _amountValueModel.upLabLevelAlign = JobsUpDownLabAlign_TopLeft;
         _amountValueModel.downLabVerticalAlign = JobsUpDownLabAlign_TopLeft;
         _amountValueModel.downLabLevelAlign = JobsUpDownLabAlign_TopLeft;

         _amountValueModel.space = JobsWidth(12);
         _amountValueModel.labelShowingType = UILabelShowingType_03;
     }return _amountValueModel;
 }
 
 */
