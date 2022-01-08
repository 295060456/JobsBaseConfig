//
//  CreateBarCodeVC.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/6/26.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "CreateBarCodeVC.h"
#import "ZXingWrapper.h"

@interface CreateBarCodeVC ()

@property(nonatomic,strong)id requestParams;
@property(nonatomic,copy)MKDataBlock successBlock;
@property(nonatomic,assign)BOOL isPush;
@property(nonatomic,assign)BOOL isPresent;

//二维码
@property(nonatomic,strong)UIView *qrView;
@property(nonatomic,strong)UIImageView* qrImgView;
//条形码
@property(nonatomic,strong)UIView *tView;
@property(nonatomic,strong)UIImageView *tImgView;

@property(nonatomic,assign)CGSize logoSize;
@property(nonatomic,assign)CGFloat diff;

@end

@implementation CreateBarCodeVC

- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}
#pragma mark - Lifecycle
-(instancetype)init{
    if (self = [super init]) {
        self.logoSize = CGSizeMake(30, 30);
        self.diff = 2;
    }return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kWhiteColor;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.qrView.alpha = 1;
    self.qrImgView.alpha = 1;
    self.tView.alpha = 1;
    self.tImgView.alpha = 1;

    [self.view layoutIfNeeded];
    [self createQR_logo];
    [self createCode128];
}

- (void)createQR_logo{
    switch ([Global sharedManager].libraryType) {
        case SLT_Native:
            self.qrImgView.image = [LBXScanNative createQRWithString:@"lbxia20091227@foxmail.com"
                                                          QRSize:self.qrImgView.bounds.size];
            break;
        case SLT_ZXing:
            self.qrImgView.image = [ZXingWrapper createCodeWithString:@"lbxia20091227@foxmail.com"
                                                             size:self.qrImgView.bounds.size
                                                       CodeFomart:kBarcodeFormatQRCode];
            break;
        default:
            break;
    }
}

- (void)createCode128{
    switch ([Global sharedManager].libraryType) {
        case SLT_Native:
            _tImgView.image = [LBXScanNative createBarCodeWithString:@"283657461695996598"
                                                              QRSize:_qrImgView.bounds.size];
            break;
        case SLT_ZXing:
             _tImgView.image = [ZXingWrapper createCodeWithString:@"283657461695996598"
                                                             size:_qrImgView.bounds.size
                                                       CodeFomart:kBarcodeFormatCode128];
            break;
        default:
            break;
    }
}

#pragma mark —— lazyLoad
-(UIView *)qrView{
    if (!_qrView) {
        _qrView = UIView.new;
        [self.view addSubview:_qrView];
        [_qrView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(CGRectGetWidth(self.view.frame) * 5 / 6, CGRectGetWidth(self.view.frame) * 5 / 6));
            make.top.equalTo(self.view).offset(100);
            make.left.equalTo(self.view).offset((CGRectGetWidth(self.view.frame) - CGRectGetWidth(self.view.frame) * 5 / 6 ) / 2);
        }];
        _qrView.backgroundColor = KYellowColor;//kWhiteColor;
        _qrView.layer.shadowOffset = CGSizeMake(0, 2);
        _qrView.layer.shadowRadius = 2;
        _qrView.layer.shadowColor = kBlackColor.CGColor;
        _qrView.layer.shadowOpacity = 0.5;
    }return _qrView;
}

-(UIImageView *)qrImgView{
    if (!_qrImgView) {
        _qrImgView = UIImageView.new;
        _qrImgView.backgroundColor = kRedColor;
        [self.qrView addSubview:_qrImgView];
        [_qrImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.qrView);
        }];
    }return _qrImgView;
}

-(UIView *)tView{
    if (!_tView) {
        _tView = UIView.new;
        _tView.backgroundColor = kBlueColor;
        [self.view addSubview:_tView];
        [_tView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view);
            make.size.mas_equalTo(CGSizeMake(CGRectGetWidth(self.view.frame) * 5 / 6,
                                             CGRectGetWidth(self.view.frame) * 5 / 6 * 0.5));
            make.top.equalTo(self.qrImgView.mas_bottom).offset(40);
        }];
    }return _tView;
}

-(UIImageView *)tImgView{
    if (!_tImgView) {
        _tImgView = UIImageView.new;
        [self.tView addSubview:_tImgView];
        [_tImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.tView);
        }];
    }return _tImgView;
}



@end
