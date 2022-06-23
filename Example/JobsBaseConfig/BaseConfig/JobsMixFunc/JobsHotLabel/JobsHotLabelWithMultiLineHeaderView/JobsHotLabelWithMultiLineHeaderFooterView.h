//
//  JobsHotLabelWithMultiLineCollectionReusableView.h
//  BaiShaEntertainmentProj
//
//  Created by Jobs on 2022/5/25.
//

#import "BaseCollectionReusableView.h"
#import "BaseButton.h"

NS_ASSUME_NONNULL_BEGIN

@interface JobsHotLabelWithMultiLineHeaderFooterView : BaseCollectionReusableView

-(UILabel *)getTitleLab;
-(BaseButton *)getSubTitleBtn;

@end

NS_ASSUME_NONNULL_END
