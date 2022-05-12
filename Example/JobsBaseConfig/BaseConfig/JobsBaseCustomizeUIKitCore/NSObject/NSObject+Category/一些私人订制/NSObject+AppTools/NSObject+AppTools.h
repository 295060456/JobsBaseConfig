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
#import "JobsUpDownLab.h"

#import "UIViewModel.h"
#import "CasinoCustomerContactModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (AppTools)<AppToolsProtocol>
// UI
@property(nonatomic,strong)JobsUpDownLab *titleLab;
@property(nonatomic,strong)UIButton *联系客服;
@property(nonatomic,strong)UIButton *立即注册;
@property(nonatomic,strong)UILabel *separateLab;/// 分割线
// Data
@property(nonatomic,strong)CasinoCustomerContactModel *customerContactModel;
@property(nonatomic,strong)NSMutableArray<UIViewModel *> *hotLabelDataMutArr;
#pragma mark —— 弹出框。为了防止业务层的变化，弹出框定义在NSObject层
/// Debug模式下的弹出框 及其相关的数据封装
-(void)jobsTestPopView:(UIViewModel *_Nullable)viewModel;
/// 测试和业务密切相关的弹窗
/// @param popViewClass 被测试的弹窗视图
/// @param viewModel 此视图所绑定的数据。传nil则使用testPopViewData的数据、传UIViewModel.new则使用popViewClass预埋的数据
-(void)jobsPopView:(Class<BaseViewProtocol> _Nullable)popViewClass
         viewModel:(UIViewModel *_Nullable)viewModel;
#pragma mark —— 网络通讯方面的

@end

NS_ASSUME_NONNULL_END
