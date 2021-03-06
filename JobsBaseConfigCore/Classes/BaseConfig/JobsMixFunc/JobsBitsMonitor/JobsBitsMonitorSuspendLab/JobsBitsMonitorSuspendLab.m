//
//  JobsBitsMonitorSuspendLab.m
//  JobsBitsMonitor
//
//  Created by Jobs on 2020/12/13.
//

#import "JobsBitsMonitorSuspendLab.h"
#import "DefineStructure.h"

extern NetworkingEnvir networkingEnvir;

@interface JobsBitsMonitorSuspendLab ()

@property(nonatomic,strong)NSMutableArray *operationEnvironMutArr;

@end

@implementation JobsBitsMonitorSuspendLab

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(instancetype)init{
    if (self = [super init]) {
//        [[NSNotificationCenter defaultCenter] addObserver:self
//                                                 selector:@selector(download:)
//                                                     name:GSDownloadNetworkSpeedNotificationKey
//                                                   object:nil];
//        [[NSNotificationCenter defaultCenter] addObserver:self
//                                                 selector:@selector(upload:)
//                                                     name:GSUploadNetworkSpeedNotificationKey
//                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(uploadAndDownload:)
                                                     name:GSUploadAndDownloadNetworkSpeedNotificationKey
                                                   object:nil];
        {// A
            self.userInteractionEnabled = YES;
            self.target = self;
            self.numberOfTouchesRequired = 1;
            self.numberOfTapsRequired = 1;
            self.tapGR.enabled = YES;
            
//            @jobs_weakify(self)
            self.callbackBlock = ^(id weakSelf, id arg, UIGestureRecognizer *data3) {
//                @jobs_strongify(self)
                [weakSelf showMenu];
            };
        }
    }return self;
}

//-(void)download:(NSNotification *)noti{
//    noti.object;
//
//}
//
//-(void)upload:(NSNotification *)noti{
//    noti.object;
//}

-(void)uploadAndDownload:(NSNotification *)noti{
    NSLog(@"%@",noti.object);
    self.text = noti.object;
    [self sizeToFit];
    [self adjustsFontSizeToFitWidth];
    self.height = 30;
}

-(void)showMenu{
    ZWPullMenuView *menuView = [ZWPullMenuView pullMenuAnchorView:self
                                                       titleArray:self.operationEnvironMutArr];
    @jobs_weakify(self)
    menuView.blockSelectedMenu = ^(NSInteger menuRow) {
        @jobs_strongify(self)
        NSLog(@"action----->%ld",(long)menuRow);
        networkingEnvir = menuRow;
        if (menuRow + 1 <= self.operationEnvironMutArr.count) {
            [WHToast toastMsg:[@"????????????" stringByAppendingString:self.operationEnvironMutArr[menuRow]]];
        }else{
            [WHToast toastErrMsg:@"????????????????????????"];
        }
    };
}
#pragma mark ?????? lazyLoad
-(NSMutableArray *)operationEnvironMutArr{
    if (!_operationEnvironMutArr) {
        _operationEnvironMutArr = NSMutableArray.array;
        [_operationEnvironMutArr addObject:@"????????????_01"];
        [_operationEnvironMutArr addObject:@"????????????_02"];
        [_operationEnvironMutArr addObject:@"????????????_03"];
        [_operationEnvironMutArr addObject:@"????????????_04"];
        [_operationEnvironMutArr addObject:@"????????????"];
        [_operationEnvironMutArr addObject:@"UAT??????"];
        [_operationEnvironMutArr addObject:@"????????????"];
    }return _operationEnvironMutArr;
}

@end
