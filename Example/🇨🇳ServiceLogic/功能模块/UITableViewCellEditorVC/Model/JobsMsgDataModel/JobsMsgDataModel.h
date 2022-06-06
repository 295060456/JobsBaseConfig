//
//  JobsMsgDataModel.h
//  BaiShaEntertainmentProj
//
//  Created by Jobs on 2022/6/2.
//

#import "UIViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface JobsMsgDataModel : UIViewModel

@property(nonatomic,assign)MsgStyle msgStyle;
@property(nonatomic,copy)NSString *time;
@property(nonatomic,assign)BOOL isDraw;/// 是否已经被领取？

@end

NS_ASSUME_NONNULL_END
