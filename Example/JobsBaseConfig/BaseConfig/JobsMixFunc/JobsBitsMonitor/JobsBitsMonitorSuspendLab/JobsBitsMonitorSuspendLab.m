//
//  JobsBitsMonitorSuspendLab.m
//  JobsBitsMonitor
//
//  Created by Jobs on 2020/12/13.
//

#import "JobsBitsMonitorSuspendLab.h"

extern NetworkingEnvir networkingEnvir;

@interface JobsBitsMonitorSuspendLab ()

@property(nonatomic,strong)NSMutableArray <NSString *>*operationEnvironMutArr;

@end

@implementation JobsBitsMonitorSuspendLab

-(void)dealloc{
    [NSNotificationCenter.defaultCenter removeObserver:self];
}

-(instancetype)init{
    if (self = [super init]) {
//        [NSNotificationCenter.defaultCenter addObserver:self
//                                               selector:@selector(download:)
//                                                   name:GSDownloadNetworkSpeedNotificationKey
//                                                 object:nil];
//        [NSNotificationCenter.defaultCenter addObserver:self
//                                               selector:@selector(upload:)
//                                                   name:GSUploadNetworkSpeedNotificationKey
//                                                 object:nil];
        [NSNotificationCenter.defaultCenter addObserver:self
                                               selector:@selector(uploadAndDownload:)
                                                   name:GSUploadAndDownloadNetworkSpeedNotificationKey
                                                 object:nil];
        
        {
            self.numberOfTouchesRequired = 1;
            self.numberOfTapsRequired = 1;/// ⚠️注意：如果要设置长按手势，此属性必须设置为0⚠️
            self.minimumPressDuration = 0.1;
            self.numberOfTouchesRequired = 1;
            self.allowableMovement = 1;
            self.userInteractionEnabled = YES;
            @jobs_weakify(self)
            self.target = weak_self;
            self.tapGR_SelImp.selector = [self jobsSelectorBlock:^(id _Nullable target, UITapGestureRecognizer *_Nullable arg) {
                @jobs_strongify(self)
                [self showMenu];
            }];
            self.tapGR.enabled = YES;/// 必须在设置完Target和selector以后方可开启执行
        }
        
    }return self;
}
#pragma mark —— 一些私有方法
-(void)showMenu{
    ZWPullMenuView *menuView = [ZWPullMenuView pullMenuAnchorView:self
                                                       titleArray:self.operationEnvironMutArr];
    @jobs_weakify(self)
    menuView.blockSelectedMenu = ^(NSInteger menuRow) {
        @jobs_strongify(self)
        NSLog(@"action----->%ld",(long)menuRow);
        networkingEnvir = menuRow;
        if (menuRow + 1 <= self.operationEnvironMutArr.count) {
            [WHToast toastMsg:[@"当前环境" stringByAppendingString:self.operationEnvironMutArr[menuRow]]];
        }else{
            [WHToast toastErrMsg:@"切换环境出现错误"];
        }
    };
}

-(void)uploadAndDownload:(NSNotification *)noti{
    NSLog(@"%@",noti.object);
    self.text = noti.object;
    [self makeLabelByShowingType:UILabelShowingType_03];
}

//-(void)download:(NSNotification *)noti{
//    noti.object;
//
//}
//
//-(void)upload:(NSNotification *)noti{
//    noti.object;
//}
#pragma mark —— lazyLoad
-(NSMutableArray<NSString *> *)operationEnvironMutArr{
    if (!_operationEnvironMutArr) {
        _operationEnvironMutArr = NSMutableArray.array;
        [_operationEnvironMutArr addObject:Internationalization(@"开发环境_01")];
        [_operationEnvironMutArr addObject:Internationalization(@"开发环境_02")];
        [_operationEnvironMutArr addObject:Internationalization(@"开发环境_03")];
        [_operationEnvironMutArr addObject:Internationalization(@"开发环境_04")];
        [_operationEnvironMutArr addObject:Internationalization(@"测试环境")];
        [_operationEnvironMutArr addObject:Internationalization(@"UAT环境")];
        [_operationEnvironMutArr addObject:Internationalization(@"生产环境")];
    }return _operationEnvironMutArr;
}

@end
