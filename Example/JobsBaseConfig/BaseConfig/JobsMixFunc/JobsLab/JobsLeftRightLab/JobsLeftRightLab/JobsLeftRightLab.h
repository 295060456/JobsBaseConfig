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
 
 {
    JobsLeftRightLabModel *upDownLabModel = JobsLeftRightLabModel.new;
    upDownLabModel.upLabText = Internationalization(@"Amount payable");
    upDownLabModel.upLabTextAlignment = NSTextAlignmentCenter;
    upDownLabModel.upLabFont = [UIFont systemFontOfSize:JobsWidth(14) weight:UIFontWeightRegular];
    upDownLabModel.upLabTextCor = UIColor.blackColor;
    upDownLabModel.upLabBgCor = UIColor.clearColor;

    upDownLabModel.downLabText = @"2.99";
    upDownLabModel.downLabTextAlignment = NSTextAlignmentCenter;
    upDownLabModel.downLabFont = [UIFont systemFontOfSize:JobsWidth(14) weight:UIFontWeightBold];
    upDownLabModel.downLabTextCor = HEXCOLOR(0x524740);
    upDownLabModel.downLabBgCor = UIColor.clearColor;

    upDownLabModel.upLabVerticalAlign = JobsUpDownLabAlign_TopLeft;
    upDownLabModel.upLabLevelAlign = JobsUpDownLabAlign_TopLeft;
    upDownLabModel.downLabVerticalAlign = JobsUpDownLabAlign_TopLeft;
    upDownLabModel.downLabLevelAlign = JobsUpDownLabAlign_TopLeft;

    upDownLabModel.space = JobsWidth(12);

    [_leftRightLab richElementsInViewWithModel:upDownLabModel];
 }
 
 */
