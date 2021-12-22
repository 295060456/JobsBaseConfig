//
//  UICollectionView+RegisterClass.h
//  UBallLive
//
//  Created by Jobs on 2020/10/31.
//

#import <UIKit/UIKit.h>

//#import "BaseCollectionViewCell.h"
//#import "CasinoTopCVCell.h"
//#import "CasinoBannerCVCell.h"
//#import "CasinoMarqueeCVCell.h"
//#import "CasinoGameCVCell.h"
//#import "CasinoGameCell.h"
//#import "CasinoNoAddBankCardCVCell.h"
//#import "CasinoHasAddedBankCardCVCell.h"
//#import "JobsImageNumberViewCVCell.h"
//#import "CasinoAgencyRecommendCVCell.h"
//#import "CasinoAgencyRecommendTopCVCell.h"
//
//#import "CasinoAgencyRecommendCRView.h"
//#import "CasinoGameCollectionReusableView.h"
//#import "CasinoAgencyRecommendTipsCRView.h"

NS_ASSUME_NONNULL_BEGIN

@interface UICollectionView (RegisterClass)
//注册的时候不开辟内存，只有当用字符串进行取值的时候才开辟内存
-(void)registerCollectionViewClass;

@end

NS_ASSUME_NONNULL_END
