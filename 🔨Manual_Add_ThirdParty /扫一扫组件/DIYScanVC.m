//
//  DIYScanVC.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/6/26.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "DIYScanVC.h"

#import "ScanResultViewController.h"
#import "LBXScanVideoZoomView.h"
#import "CreateBarCodeVC.h"

@interface DIYScanVC ()

@property(nonatomic,strong)LBXScanVideoZoomView *zoomView;

@property(nonatomic,strong)id requestParams;
@property(nonatomic,copy)MKDataBlock successBlock;
@property(nonatomic,assign)BOOL isPush;
@property(nonatomic,assign)BOOL isPresent;

@end

@implementation DIYScanVC

- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}
#pragma mark - Lifecycle
-(instancetype)init{
    if (self = [super init]) {
        self.libraryType = [Global sharedManager].libraryType;
        self.scanCodeType = [Global sharedManager].scanCodeType;
        self.style = [StyleDIY qqStyle];
        //镜头拉远拉近功能
        self.isVideoZoom = YES;
    }return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = kWhiteColor;
//    self.gk_navLeftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.scanBtn];
//    self.gk_navItemLeftSpace = 20;
//    self.gk_navItemRightSpace = 20;
//    self.gk_navRightBarButtonItems = @[[[UIBarButtonItem alloc] initWithCustomView:self.msgBtn],[[UIBarButtonItem alloc] initWithCustomView:self.settingBtn]];
    self.gk_navTitle = @"";
    self.gk_statusBarHidden = NO;
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.view.backgroundColor = kBlackColor;
    
    //设置扫码后需要扫码图像
    self.isNeedScanImage = YES;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self drawBottomItems];
    [self.view bringSubviewToFront:self.topTitle];
}

- (void)drawBottomItems{
    self.bottomItemsView.alpha = 1;
    self.btnFlash.alpha = 1;
    self.btnPhoto.alpha = 1;
    self.btnMyQR.alpha = 1;
}

- (void)cameraInitOver{
    if (self.isVideoZoom) {
        [self zoomView];
    }
}

- (void)showError:(NSString*)str{
    [NSObject showSYSAlertViewTitle:@"提示"
                            message:str
                    isSeparateStyle:YES
                        btnTitleArr:@[@"知道了"]
                     alertBtnAction:@[@""]
                           targetVC:self
                       alertVCBlock:^(id data) {
        //DIY
    }];
}

- (void)scanResultWithArray:(NSArray<LBXScanResult *> *)array{
    if (array.count < 1){
        [self popAlertMsgWithScanResult:nil];
        return;
    }
    
    //经测试，可以同时识别2个二维码，不能同时识别二维码和条形码
    for (LBXScanResult *result in array) {
        NSLog(@"scanResult:%@",result.strScanned);
    }
    
    LBXScanResult *scanResult = array[0];
    NSString*strResult = scanResult.strScanned;
    self.scanImage = scanResult.imgScanned;
    if (!strResult) {
        [self popAlertMsgWithScanResult:nil];
        return;
    }
    //震动提醒
   // [LBXScanWrapper systemVibrate];
    [NSObject feedbackGenerator];
    //声音提醒
    //[LBXScanWrapper systemSound];
    [self showNextVCWithScanResult:scanResult];
}

- (void)popAlertMsgWithScanResult:(NSString *)strResult{
    if (!strResult) {
        strResult = @"识别失败";
    }
    
    [NSObject showSYSAlertViewTitle:@"扫码内容"
                            message:strResult
                    isSeparateStyle:YES
                        btnTitleArr:@[@"知道了"]
                     alertBtnAction:@[@""]
                           targetVC:self
                       alertVCBlock:^(id data) {
        //DIY
    }];
}

- (void)showNextVCWithScanResult:(LBXScanResult *)strResult{
    @weakify(self)

    [UIViewController comingFromVC:self
                              toVC:ScanResultViewController.new
                       comingStyle:ComingStyle_PUSH
                 presentationStyle:[UIDevice currentDevice].systemVersion.doubleValue >= 13.0 ? UIModalPresentationAutomatic : UIModalPresentationFullScreen
                     requestParams:nil
          hidesBottomBarWhenPushed:YES
                          animated:YES
                           success:^(id data) {
        
    }];
}

#pragma mark —— 底部功能项
//打开相册
- (void)openPhoto{
    @weakify(self)
    [self choosePic:TZImagePickerControllerType_1 imagePickerVCBlock:^(id data) {
        @strongify(self)
        //回调 这样就可以全部选择视频了
        self.imagePickerVC.allowPickingVideo = YES;
        self.imagePickerVC.allowPickingImage = NO;
        self.imagePickerVC.allowPickingOriginalPhoto = NO;
        self.imagePickerVC.allowPickingGif = NO;
        self.imagePickerVC.allowPickingMultipleVideo = NO;
    }];
    [self GettingPicBlock:^(id firstArg, ...)NS_REQUIRES_NIL_TERMINATION{
        @strongify(self)
        if (firstArg) {
            // 取出第一个参数
            NSLog(@"%@", firstArg);
            // 定义一个指向个数可变的参数列表指针；
            va_list args;
            // 用于存放取出的参数
            id arg = nil;
            // 初始化变量刚定义的va_list变量，这个宏的第二个参数是第一个可变参数的前一个参数，是一个固定的参数
            va_start(args, firstArg);
            // 遍历全部参数 va_arg返回可变的参数(a_arg的第二个参数是你要返回的参数的类型)
            if ([firstArg isKindOfClass:NSNumber.class]) {
                NSNumber *num = (NSNumber *)firstArg;
                for (int i = 0; i < num.intValue; i++) {
                    arg = va_arg(args, id);
                    NSLog(@"KKK = %@", arg);
                    if ([arg isKindOfClass:NSArray.class]) {
                        NSArray *arrData = (NSArray *)arg;
                        if (arrData.count == 1) {
                            NSLog(@"");
                            UIImage *image = arrData.firstObject;
                            @weakify(self)
                            switch (self.libraryType) {
                                    case SLT_Native:{
                            #ifdef LBXScan_Define_Native
                                        if ([[[UIDevice currentDevice]systemVersion]floatValue] >= 8.0){
                                            [LBXScanNative recognizeImage:image
                                                                  success:^(NSArray<LBXScanResult *> *array) {
                                                [weak_self scanResultWithArray:array];
                                            }];
                                        }else{
                                            [self showError:@"native低于ios8.0系统不支持识别图片条码"];
                                        }
                            #endif
                                    }
                                        break;
                                    case SLT_ZXing:{
                            #ifdef LBXScan_Define_ZXing
                                        [ZXingWrapper recognizeImage:image
                                                               block:^(ZXBarcodeFormat barcodeFormat,
                                                                       NSString *str) {
                                            LBXScanResult *result = [[LBXScanResult alloc]init];
                                            result.strScanned = str;
                                            result.imgScanned = image;
                                            result.strBarCodeType = [self convertZXBarcodeFormat:barcodeFormat];
                                            [weak_self scanResultWithArray:@[result]];
                                        }];
                            #endif
                                    }
                                        break;
                                    case SLT_ZBar:{
                            #ifdef LBXScan_Define_ZBar
                                        [LBXZBarWrapper recognizeImage:image
                                                                 block:^(NSArray<LBXZbarResult *> *result) {

                                            //测试，只使用扫码结果第一项
                                            LBXZbarResult *firstObj = result[0];
                                            LBXScanResult *scanResult = [[LBXScanResult alloc]init];
                                            scanResult.strScanned = firstObj.strScanned;
                                            scanResult.imgScanned = firstObj.imgScanned;
                                            scanResult.strBarCodeType = [LBXZBarWrapper convertFormat2String:firstObj.format];
                                            [weak_self scanResultWithArray:@[scanResult]];
                                        }];
                            #endif
                                    }
                                        break;
                                    default:
                                        break;
                                }

                        }else{
                            [NSObject showSYSAlertViewTitle:@"选择一张相片就够啦"
                                                    message:nil
                                            isSeparateStyle:YES
                                                btnTitleArr:@[@"好的"]
                                             alertBtnAction:@[@""]
                                                   targetVC:self
                                               alertVCBlock:^(id data) {
                                //DIY
                            }];
                        }
                    }
                }
            }
            // 清空参数列表，并置参数指针args无效
            va_end(args);
        }
    }];
}
//开关闪光灯
- (void)openOrCloseFlash{
    [super openOrCloseFlash];
    if (self.isOpenFlash){
        [_btnFlash setImage:[UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_btn_flash_down"]
                   forState:UIControlStateNormal];
    }else
        [_btnFlash setImage:[UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_btn_flash_nor"]
                   forState:UIControlStateNormal];
}
//我的二维码
- (void)myQRCode{
    [UIViewController comingFromVC:self
                              toVC:CreateBarCodeVC.new
                       comingStyle:ComingStyle_PUSH
                 presentationStyle:[UIDevice currentDevice].systemVersion.doubleValue >= 13.0 ? UIModalPresentationAutomatic : UIModalPresentationFullScreen
                     requestParams:nil
          hidesBottomBarWhenPushed:YES
                          animated:YES
                           success:^(id data) {
        
    }];
}

#pragma mark —— lazyLoad
-(UIView *)bottomItemsView{
    if (!_bottomItemsView) {
        _bottomItemsView = [[UIView alloc]initWithFrame:CGRectMake(0,
                                                                   CGRectGetMaxY(self.view.frame) - 164,
                                                                   CGRectGetWidth(self.view.frame),
                                                                   100)];
        _bottomItemsView.backgroundColor = [UIColor colorWithRed:0
                                                           green:0
                                                            blue:0
                                                           alpha:0.6];
        [self.view addSubview:_bottomItemsView];
    }return _bottomItemsView;
}

-(UIButton *)btnFlash{
    if (!_btnFlash) {
        _btnFlash = UIButton.new;
        [_bottomItemsView addSubview:_btnFlash];
        CGSize size = CGSizeMake(65, 87);
        _btnFlash.bounds = CGRectMake(0,
                                      0,
                                      size.width,
                                      size.height);
        _btnFlash.center = CGPointMake(CGRectGetWidth(_bottomItemsView.frame) / 2, CGRectGetHeight(_bottomItemsView.frame) / 2);
         [_btnFlash setImage:[UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_btn_flash_nor"]
                    forState:UIControlStateNormal];
        [_btnFlash addTarget:self
                      action:@selector(openOrCloseFlash)
            forControlEvents:UIControlEventTouchUpInside];
    }return _btnFlash;
}

-(UIButton *)btnPhoto{
    if (!_btnPhoto) {
        _btnPhoto = UIButton.new;
        _btnPhoto.bounds = _btnFlash.bounds;
        [_bottomItemsView addSubview:_btnPhoto];
        _btnPhoto.center = CGPointMake(CGRectGetWidth(_bottomItemsView.frame) / 4, CGRectGetHeight(_bottomItemsView.frame) / 2);
        [_btnPhoto setImage:[UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_btn_photo_nor"]
                   forState:UIControlStateNormal];
        [_btnPhoto setImage:[UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_btn_photo_down"]
                   forState:UIControlStateHighlighted];
        [_btnPhoto addTarget:self
                      action:@selector(openPhoto)
            forControlEvents:UIControlEventTouchUpInside];
    }return _btnPhoto;
}

-(UIButton *)btnMyQR{
    if (!_btnMyQR) {
        _btnMyQR = UIButton.new;
        _btnMyQR.bounds = _btnFlash.bounds;
        _btnMyQR.center = CGPointMake(CGRectGetWidth(_bottomItemsView.frame) * 3 / 4, CGRectGetHeight(_bottomItemsView.frame) / 2);
        [_bottomItemsView addSubview:_btnMyQR];
        [_btnMyQR setImage:[UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_btn_myqrcode_nor"]
                  forState:UIControlStateNormal];
        [_btnMyQR setImage:[UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_btn_myqrcode_down"]
                  forState:UIControlStateHighlighted];
        [_btnMyQR addTarget:self
                     action:@selector(myQRCode)
           forControlEvents:UIControlEventTouchUpInside];
    }return _btnMyQR;
}

- (UILabel *)topTitle{
    if (!_topTitle){
        _topTitle = UILabel.new;
        _topTitle.textAlignment = NSTextAlignmentCenter;
        _topTitle.numberOfLines = 0;
        _topTitle.text = @"将取景框对准二维码即可自动扫描";
        _topTitle.textColor = kWhiteColor;
        [self.view addSubview:_topTitle];
        [_topTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view);
            make.size.mas_equalTo(CGSizeMake(145, 60));
            make.top.equalTo(self.qRScanView);
        }];
    }return _topTitle;
}

- (LBXScanVideoZoomView *)zoomView{
    if (!_zoomView){
        CGRect frame = self.view.frame;
        int XRetangleLeft = self.style.xScanRetangleOffset;
        CGSize sizeRetangle = CGSizeMake(frame.size.width - XRetangleLeft*2, frame.size.width - XRetangleLeft*2);
        if (self.style.whRatio != 1){
            CGFloat w = sizeRetangle.width;
            CGFloat h = w / self.style.whRatio;
            NSInteger hInt = (NSInteger)h;
            h  = hInt;
            sizeRetangle = CGSizeMake(w, h);
        }
        CGFloat videoMaxScale = [self.scanObj getVideoMaxScale];
        //扫码区域Y轴最小坐标
        CGFloat YMinRetangle = frame.size.height / 2.0 - sizeRetangle.height / 2.0 - self.style.centerUpOffset;
        CGFloat YMaxRetangle = YMinRetangle + sizeRetangle.height;
        
        CGFloat zoomw = sizeRetangle.width + 40;
        _zoomView = [[LBXScanVideoZoomView alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.view.frame)-zoomw)/2,
                                                                           YMaxRetangle + 40,
                                                                           zoomw,
                                                                           18)];
        [_zoomView setMaximunValue:videoMaxScale / 4];
        @weakify(self)
        _zoomView.block= ^(float value){
            [weak_self.scanObj setVideoScale:value];
        };
        [self.view addSubview:_zoomView];
    }return _zoomView;
}

@end


