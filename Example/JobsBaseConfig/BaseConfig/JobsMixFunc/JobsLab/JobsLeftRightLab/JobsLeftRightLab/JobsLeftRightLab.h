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
     JobsLeftRightLabModel *model = JobsLeftRightLabModel.new;
     model.upLabText = Internationalization(@"Amount payable");
     model.upLabTextAlignment = NSTextAlignmentCenter;
     model.upLabFont = [UIFont systemFontOfSize:JobsWidth(14) weight:UIFontWeightRegular];
     model.upLabTextCor = UIColor.blackColor;
     model.upLabBgCor = UIColor.clearColor;
     
     model.downLabText = @"2.99";
     model.downLabTextAlignment = NSTextAlignmentCenter;
     model.downLabFont = [UIFont systemFontOfSize:JobsWidth(14) weight:UIFontWeightBold];
     model.downLabTextCor = HEXCOLOR(0x524740);
     model.downLabBgCor = UIColor.clearColor;
     
     model.space = JobsWidth(12);
     
     [_leftRightLab richElementsInViewWithModel:model];
 }
 
 */
