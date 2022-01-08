//
//  ScanResultViewController.m
//  LBXScanDemo
//
//  Created by lbxia on 15/11/17.
//  Copyright © 2015年 lbxia. All rights reserved.
//

#import "ScanResultViewController.h"

@interface ScanResultViewController ()

@property(nonatomic,strong)UIImage *imgScan;
@property(nonatomic,copy)NSString *strScan;
@property(nonatomic,copy)NSString *strCodeType;
@property(nonatomic,strong)LBXScanResult *scanResult;

@property(nonatomic,strong)id requestParams;
@property(nonatomic,copy)MKDataBlock successBlock;
@property(nonatomic,assign)BOOL isPush;
@property(nonatomic,assign)BOOL isPresent;

@end

@implementation ScanResultViewController

- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}
#pragma mark - Lifecycle
-(instancetype)init{
    if (self = [super init]) {
        self.imgScan = self.scanResult.imgScanned;
        self.strScan = self.scanResult.strScanned;
        self.strCodeType = self.scanResult.strBarCodeType;
    }return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    if (!_imgScan) {
//        _scanImg.backgroundColor = [UIColor grayColor];
//    }
//    _scanImg.image = _imgScan;
//    _labelScanText.text = _strScan;
//    _labelScanCodeType.text = [NSString stringWithFormat:@"码的类型:%@",_strCodeType];
    
}


@end
