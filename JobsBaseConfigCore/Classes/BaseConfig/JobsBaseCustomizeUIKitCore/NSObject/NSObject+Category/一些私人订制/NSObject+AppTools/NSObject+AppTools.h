//
//  NSObject+AppTools.h
//  DouYin
//
//  Created by Jobs on 2021/4/6.
//

#import <Foundation/Foundation.h>

#import "AppToolsProtocol.h"
#import "NSObject+UserInfo.h"
#import "NSObject+Extras.h"

#import "AppDelegate.h"
#import "JobsAppDoorVC.h"
#import "AppInternationalizationVC.h"
#import "CasinoUpgradePopupView.h"
#import "JobsHotLabelWithSingleLine.h"

#import "UIViewModel.h"
#import "CasinoCustomerContactModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (AppTools)<AppToolsProtocol>

@property(nonatomic,strong)CasinoCustomerContactModel *customerContactModel;
@property(nonatomic,strong)NSMutableArray<UIViewModel *> *hotLabelDataMutArr;

@end

NS_ASSUME_NONNULL_END
