//
//  JobsImageViewStyleCVCell.h
//  MataShop
//
//  Created by Jobs Hi on 9/23/23.
//

#import "BaseCollectionViewCell.h"

NS_ASSUME_NONNULL_BEGIN
/// 只在BaseCollectionViewCell完整的盖一个ImageView
@interface JobsImageViewStyleCVCell : BaseCollectionViewCell

#pragma mark —— 一些公有方法
-(UIImageView *)getImageView;

@end

NS_ASSUME_NONNULL_END
