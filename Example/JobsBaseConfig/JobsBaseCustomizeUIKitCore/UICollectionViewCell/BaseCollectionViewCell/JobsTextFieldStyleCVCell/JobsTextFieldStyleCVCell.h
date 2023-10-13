//
//  JobsTextFieldStyleCVCell.h
//  MataShop
//
//  Created by Jobs Hi on 10/13/23.
//

#import "BaseCollectionViewCell.h"

NS_ASSUME_NONNULL_BEGIN
/// 只在BaseCollectionViewCell完整的盖一个TextField
@interface JobsTextFieldStyleCVCell : BaseCollectionViewCell<UITextFieldDelegate>

-(ZYTextField *)getTextField;

@end

NS_ASSUME_NONNULL_END
