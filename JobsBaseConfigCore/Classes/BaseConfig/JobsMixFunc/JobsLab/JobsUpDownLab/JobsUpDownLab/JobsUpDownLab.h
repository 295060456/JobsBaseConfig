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
 
 {
     JobsUpDownLabModel *model = JobsUpDownLabModel.new;
     model.upLabText = @"2.2";
     model.upLabTextAlignment = NSTextAlignmentCenter;
     model.upLabFont = [UIFont systemFontOfSize:JobsWidth(14) weight:UIFontWeightRegular];
     model.upLabTextCor = UIColor.blackColor;
     model.upLabBgCor = UIColor.clearColor;
     
     model.downLabText = Internationalization(@"Estimated yesterday");
     model.downLabTextAlignment = NSTextAlignmentCenter;
     model.downLabFont = [UIFont systemFontOfSize:JobsWidth(14) weight:UIFontWeightRegular];
     model.downLabTextCor = HEXCOLOR(0x524740);
     model.downLabBgCor = UIColor.clearColor;
     
     model.space = JobsWidth(12);
     
     [_yesterdayLab richElementsInViewWithModel:model];
 }
 
 */
