//
//  InfoTBVCell.h
//  commentList
//
//  Created by Jobs on 2020/7/14.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseCellProtocol.h"

#import "RBCLikeButton.h"

#import "JobsCommentConfig.h"
#import "JobsCommentModel.h"

#import "UIImage+YBGIF.h"

NS_ASSUME_NONNULL_BEGIN

@interface InfoTBVCell : UITableViewCell<BaseCellProtocol>

@property(nonatomic,strong)RBCLikeButton *LikeBtn;
@property(nonatomic,strong)JobsChildCommentModel *childCommentModel;

@end

NS_ASSUME_NONNULL_END
