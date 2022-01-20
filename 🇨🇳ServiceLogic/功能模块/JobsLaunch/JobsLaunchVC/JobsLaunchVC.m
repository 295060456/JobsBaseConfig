//
//  JobsLaunchVC.m
//  JobsBaseConfig
//
//  Created by Jobs on 2022/1/19.
//

#import "JobsLaunchVC.h"

@interface JobsLaunchVC ()

@property(nonatomic,strong,nullable)UIButton *skipBtn;
@property(nonatomic,strong,nullable)UIImageView *bgImgV;
@property(nonatomic,strong,nullable)ZFPlayerController *player;
@property(nonatomic,strong,nullable)ZFAVPlayerManager *playerManager;
@property(nonatomic,strong,nullable)CustomZFPlayerControlView *customPlayerControlView;

@end

@implementation JobsLaunchVC

- (void)dealloc{
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
    //    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

+(void)destroyAppDoorSingleton{
    static_launchVCOnceToken = 0;
    static_launchVC = nil;
}
static JobsLaunchVC *static_launchVC = nil;
static dispatch_once_t static_launchVCOnceToken;
+(instancetype)sharedInstance{
    dispatch_once(&static_launchVCOnceToken, ^{
        static_launchVC = JobsLaunchVC.new;
    });return static_launchVC;
}

-(void)loadView{
    [super loadView];
    
    self.bgImage = nil;
    if ([self.requestParams isKindOfClass:UIViewModel.class]) {
        self.viewModel = (UIViewModel *)self.requestParams;
        if ([self.viewModel.requestParams integerValue] == JobsLaunchBgType_Image) {
            self.view = self.bgImgV;
        }else if ([self.viewModel.requestParams integerValue] == JobsLaunchBgType_video){
            [self.player.currentPlayerManager play];
        }else{}
    }
    
    self.setupNavigationBarHidden = YES;//禁用系统的导航栏
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = KYellowColor;
    self.skipBtn.alpha = 1;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}
#pragma mark —— lazyLoad
-(ZFAVPlayerManager *)playerManager{
    if (!_playerManager) {
        _playerManager = ZFAVPlayerManager.new;
        _playerManager.shouldAutoPlay = YES;

        if (isiPhoneX_series()) {
            _playerManager.assetURL = [NSURL fileURLWithPath:[NSBundle.mainBundle pathForResource:@"iph_X"
                                                                                           ofType:@"mp4"]];
        }else{
            _playerManager.assetURL = [NSURL fileURLWithPath:[NSBundle.mainBundle pathForResource:@"非iph_X"
                                                                                           ofType:@"mp4"]];
        }
    }return _playerManager;
}

-(ZFPlayerController *)player{
    if (!_player) {
        @jobs_weakify(self)
        _player = [ZFPlayerController.alloc initWithPlayerManager:self.playerManager
                                                    containerView:self.view];
        _player.controlView = self.customPlayerControlView;
//        ZFPlayer_DoorVC = _player;
        [_player setPlayerDidToEnd:^(id<ZFPlayerMediaPlayback>  _Nonnull asset) {
            @jobs_strongify(self)
            [self.playerManager replay];//设置循环播放
        }];
    }return _player;
}

-(CustomZFPlayerControlView *)customPlayerControlView{
    if (!_customPlayerControlView) {
        _customPlayerControlView = CustomZFPlayerControlView.new;
        @jobs_weakify(self)
        [_customPlayerControlView actionCustomZFPlayerControlViewBlock:^(id data, id data2) {
            @jobs_strongify(self)
            [self.view endEditing:YES];
        }];
    }return _customPlayerControlView;
}

-(UIImageView *)bgImgV{
    if (!_bgImgV) {
        _bgImgV = UIImageView.new;
        _bgImgV.image = KIMG(@"AppDoorBgImage");
        _bgImgV.userInteractionEnabled = YES;
    }return _bgImgV;
}

-(UIButton *)skipBtn{
    if (!_skipBtn) {
        _skipBtn = UIButton.new;

        /// 普通文本
        [_skipBtn normalTitle:LaunchConfig.text];
        [_skipBtn normalTitleColor:LaunchConfig.textCor];
        [_skipBtn titleFont:LaunchConfig.font];
        /// 富文本
        [_skipBtn normalAttributedTitle:LaunchConfig.attributedText];
        /// 未选中状态
        [_skipBtn sd_setImageWithURL:[NSURL URLWithString:LaunchConfig.imageURLString]
                            forState:UIControlStateNormal
                    placeholderImage:LaunchConfig.image];
        [_skipBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:LaunchConfig.bgImageURLString]
                                      forState:UIControlStateNormal
                              placeholderImage:LaunchConfig.bgImage];
        /// 选中状态
        [_skipBtn sd_setImageWithURL:[NSURL URLWithString:LaunchConfig.selectedImageURLString]
                            forState:UIControlStateSelected
                    placeholderImage:LaunchConfig.selectedImage];
        [_skipBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:LaunchConfig.bgSelectedImageURLString]
                                      forState:UIControlStateSelected
                              placeholderImage:LaunchConfig.bgSelectedImage];
        /// 其他
        _skipBtn.backgroundColor = UIColor.redColor;//LaunchConfig.bgCor;
        
        BtnClickEvent(_skipBtn, {
            [self backItemClick:x];
        });
        
        [self.view addSubview:_skipBtn];
        [_skipBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(JobsWidth(80), JobsWidth(25)));
            make.top.equalTo(self.view).offset(JobsRectOfStatusbar());
            make.right.equalTo(self.view).offset(-JobsWidth(25));
        }];
        [self.view bringSubviewToFront:_skipBtn];
       
        [_skipBtn makeBtnLabelByShowingType:LaunchConfig.labelShowingType];
        [self.view layoutIfNeeded];
        [_skipBtn cornerCutToCircleWithCornerRadius:LaunchConfig.cornerRadius ? : (_skipBtn.height / 2)];
        [_skipBtn layerBorderColour:LaunchConfig.layerBorderColour
                     andBorderWidth:LaunchConfig.layerBorderWidth];
    }return _skipBtn;
}

@end
