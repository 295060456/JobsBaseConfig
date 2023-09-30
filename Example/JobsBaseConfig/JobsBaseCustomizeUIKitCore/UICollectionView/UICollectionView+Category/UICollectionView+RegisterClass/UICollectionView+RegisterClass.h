//
//  UICollectionView+RegisterClass.h
//  UBallLive
//
//  Created by Jobs on 2020/10/31.
//

#import <UIKit/UIKit.h>

#import "JobsHotLabelWithMultiLineHeaderFooterView.h"
//#import "BaiShaETProjTopupTipsVIew.h"
//#import "BaiShaETProjUSDTWithdrawalCRView.h"

#import "JobsHotLabelWithMultiLineCVCell.h"
#import "JobsBtnStyleCVCell.h"
#import "JobsImageViewStyleCVCell.h"
#import "MSMineView6CVCell.h"
//#import "BaiShaETProjMywalletCRView.h"
//#import "BaiShaETProjCVCellStyle1.h"
//#import "BaseCollectionViewCell.h"

#import "BaiShaETProjHeaderIconCVCell.h"

//#import "BaiShaETProjVIPSubCVCell_02.h"
//#import "BaiShaETProjVIPSubCVCell_03.h"
//#import "BaiShaETProjVIPSubCVCell_04.h"
//#import "BaiShaETProjVIPSubCVCell_05.h"
//
//#import "BaiShaETProjFirstGiftVCVCell_01.h"
//#import "BaiShaETProjFirstGiftVCVCell_02.h"
//#import "BaiShaETProjFirstGiftVCVCell_03.h"
//
//#import "BaiShaETProjAmountDepositInputCVCell.h"
//#import "BaiShaETProjDealProtocalCVCell.h"
//#import "BaiShaETProjCoinSpeciesCVCell.h"
//#import "BaiShaETProjPaymentWayCVCell.h"
//
//#import "BaiShaETProjCountdownCVCell.h"
//#import "BaiShaETProjOrderDetailsCVCell.h"
//#import "BaiShaETProjAmountDepositClickCVCell.h"
//
//#import "BaiShaETProjUSDTWithdrawalCVCell.h"

#import "MSTransactionRecordCVCell.h"// 储宝-交易记录子控件UI
#import "MSPromotionIncentiveCVCell.h"// 储宝-推广奖励子控件UI
#import "MSInterestSettleRecordCVCell.h"// 储宝-结息记录子控件UI
#import "MSProdSelectCVCell.h"// 储宝-产品选购子控件UI
#import "MSProdShowCVCell.h"// 商品展示UI
#import "MSHomeCollectionReusableView.h"
#import "MSInternalRecruitmentCVCell1.h"// 内部招聘Cell1
#import "MSInternalRecruitmentCVCell2.h"// 内部招聘Cell2

NS_ASSUME_NONNULL_BEGIN

@interface UICollectionView (RegisterClass)
/// 注册的时候不开辟内存，只有当用字符串进行取值的时候才开辟内存
-(void)registerCollectionViewClass;
/// 注册 UICollectionViewCell 及其子类
-(void)registerCollectionViewCellClass:(Class)cls;
/// 注册 UICollectionElementKindSectionHeader 及其子类
-(void)registerCollectionElementKindSectionHeaderClass:(Class)cls;
/// 注册 UICollectionElementKindSectionFooter 及其子类
-(void)registerCollectionElementKindSectionFooterClass:(Class)cls;
/// 依据字符串取UICollectionElementKindSectionHeader
-(__kindof UICollectionReusableView *)UICollectionElementKindSectionHeaderClass:(Class)cls
                                                                   forIndexPath:(NSIndexPath *)indexPath;
/// 依据字符串取UICollectionElementKindSectionFooter
-(__kindof UICollectionReusableView *)UICollectionElementKindSectionFooterClass:(Class)cls
                                                                   forIndexPath:(NSIndexPath *)indexPath;
/// 先用UICollectionViewLayout生成CollectionView。frame后面设置
+(instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout;
/// 一种用字符串取UICollectionViewCell及其子类的方法❤️复用字符串是目标类的类名❤️
-(__kindof UICollectionViewCell *)collectionViewCellClass:(Class)cls
                                             forIndexPath:(NSIndexPath *)indexPath;
@end

NS_ASSUME_NONNULL_END
