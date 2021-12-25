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
#import "AppInternationalizationVC.h"
#import "CasinoUpgradePopupView.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (AppTools)<AppToolsProtocol>
/// App 升级弹窗：在根控制器下实现，做到覆盖全局的统一
-(void)appUpdateWithSureBlock:(MKDataBlock _Nullable)sureBlock
                  cancelBlock:(MKDataBlock _Nullable)cancelBlock;

@end

NS_ASSUME_NONNULL_END
