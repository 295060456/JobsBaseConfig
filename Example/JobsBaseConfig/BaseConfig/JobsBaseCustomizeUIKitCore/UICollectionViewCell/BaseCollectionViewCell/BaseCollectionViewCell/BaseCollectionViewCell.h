//
//  CollectionViewCell.h
//  UBallLive
//
//  Created by Jobs on 2020/10/18.
//

#import <UIKit/UIKit.h>
#import "MacroDef_Func.h"
#import "UICollectionViewCellProtocol.h"
#import "UICollectionViewCell+ShakeAnimation.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseCollectionViewCell : UICollectionViewCell<UICollectionViewCellProtocol>

@property(nonatomic,assign)BOOL forceUsetextView;
@property(nonatomic,assign)BOOL forceUseBgBtn;

@end

NS_ASSUME_NONNULL_END
