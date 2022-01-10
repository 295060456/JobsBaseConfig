//
//  CommentPopUpNonHoveringHeaderView.h
//  My_BaseProj
//
//  Created by Jobs on 2020/10/2.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "BaseTableViewHeaderView.h"
#import "RBCLikeButton.h"
#import "UIImage+YBGIF.h"
#import "JobsCommentConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface JobsCommentPopUpViewForTVH : BaseTableViewHeaderView
<
BaseProtocol,
BaseViewProtocol
>

-(instancetype)initWithReuseIdentifier:(nullable NSString *)reuseIdentifier
                              withData:(id)data;
+(CGFloat)viewForTableViewHeaderHeightWithModel:(id _Nullable)model;

@end

NS_ASSUME_NONNULL_END
