//
//  JobsAppDoor.m
//  My_BaseProj
//
//  Created by Jobs on 2020/12/3.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "JobsAppDoorVC.h"

//ZFPlayerController *ZFPlayer_DoorVC;
@interface JobsAppDoorVC (){
    NSInteger index;// 当前被激活的TextField的序号，从1开始
    UIButton *toRegisterBtn;
    UITextField *lastEditTextField;// 上一次处于编辑状态的TextField
}
//UI
@property(nonatomic,strong)JobsAppDoorLogoContentView *logoContentView;
@property(nonatomic,strong)JobsAppDoorContentView *jobsAppDoorContentView;/// 登录和注册
@property(nonatomic,strong,nullable)JobsAppDoorForgotCodeContentView *forgotCodeContentView;/// 忘记密码
@property(nonatomic,strong)UIButton *customerServiceBtn;
@property(nonatomic,strong)UIImageView *bgImgV;
@property(nonatomic,strong)ZFPlayerController *player;
@property(nonatomic,strong)ZFAVPlayerManager *playerManager;
@property(nonatomic,strong,nullable)CustomZFPlayerControlView *customPlayerControlView;
//Data
@property(nonatomic,assign)BOOL registerDoorInputEditing;
@property(nonatomic,assign)CGFloat logoContentViewY;/// 初始高度
@property(nonatomic,assign)CGFloat forgotCodeContentViewY;/// 初始高度
@property(nonatomic,assign)CGFloat jobsAppDoorContentViewY;/// 初始高度
@property(nonatomic,assign)CGFloat customerServiceBtnY;/// 初始高度
@property(nonatomic,assign)NSInteger currentActivateTFIndex;/// 当前被激活的输入框的序列号
@property(nonatomic,assign)NSInteger lastTimeActivateTFIndex;/// 上一时刻被激活的输入框的序列号
@property(nonatomic,strong)JobsAppDoorModel *appDoorModel;

@end

@implementation JobsAppDoorVC

- (void)dealloc{
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

+(void)destroyAppDoorSingleton{
    static_jobsAppDoorOnceToken = 0;
    static_appDoorVC = nil;
}
static JobsAppDoorVC *static_appDoorVC = nil;
static dispatch_once_t static_jobsAppDoorOnceToken;
+(instancetype)sharedInstance{
    dispatch_once(&static_jobsAppDoorOnceToken, ^{
        static_appDoorVC = JobsAppDoorVC.new;
    });return static_appDoorVC;
}

-(instancetype)init{
    if (self = [super init]) {

    }return self;
}

-(void)loadView{
    [super loadView];
    self.bgImage = nil;
    if ([self.requestParams integerValue] == JobsAppDoorBgType_Image) {
        self.view = self.bgImgV;
    }else if ([self.requestParams integerValue] == JobsAppDoorBgType_video){
        [self.player.currentPlayerManager play];
    }else{}
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.setupNavigationBarHidden = YES;//禁用系统的导航栏
    self.currentPage = CurrentPage_login;//默认页面是登录
    [self keyboard];
    self.view.backgroundColor = kBlueColor;
//    self.setupNavigationBarHidden = YES;
    //标的值初始化
    self.logoContentViewY = 0;
    self.jobsAppDoorContentViewY = 0;
    self.customerServiceBtnY = 0;
    
    [UIView animationAlert:self.jobsAppDoorContentView];
    [UIView animationAlert:self.logoContentView];
    [UIView animationAlert:self.customerServiceBtn];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if ([self.objBindingParams integerValue] == CurrentPage_register) {
//        [self.jobsAppDoorContentView animationToLogin];
        [self.jobsAppDoorContentView animationToRegister];
    }
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if ([self.requestParams integerValue] == JobsAppDoorBgType_Image) {
        
    }else if ([self.requestParams integerValue] == JobsAppDoorBgType_video){
        if (self.player.currentPlayerManager.isPlaying) {
            [self.player.currentPlayerManager pause];
        }
    }else{}
}
#pragma mark —— 一些私有方法
-(void)竖形按钮在左边{
    index = 0;
    self->_jobsAppDoorContentView.backgroundColor = Cor2;
    Ivar ivar = class_getInstanceVariable(JobsAppDoorContentView.class, "_toRegisterBtn");//必须是下划线接属性
    UIButton *toRegisterBtn = object_getIvar(self->_jobsAppDoorContentView, ivar);
    toRegisterBtn.backgroundColor = Cor4;
    [toRegisterBtn normalTitleColor:Cor1];
    
    self.currentPage = CurrentPage_register;//注册页面
    self->_jobsAppDoorContentView.frame = CGRectMake(JobsAppDoorContentViewRegisterX,
                                                     JobsAppDoorContentViewRegisterY,
                                                     JobsAppDoorContentViewRegisterWidth,
                                                     JobsAppDoorContentViewRegisterHeight);
    toRegisterBtn.frame = CGRectMake(0,
                                     0,
                                     JobsWidth(64),
                                     self->_jobsAppDoorContentView.height);
}

-(void)竖形按钮在右边{
    index = 0;
    self->_jobsAppDoorContentView.backgroundColor = Cor2;
    Ivar ivar = class_getInstanceVariable([JobsAppDoorContentView class], "_toRegisterBtn");//必须是下划线接属性
    UIButton *toRegisterBtn = object_getIvar(self->_jobsAppDoorContentView, ivar);
    toRegisterBtn.backgroundColor = Cor1;
    [toRegisterBtn setTitleColor:Cor3
                        forState:UIControlStateNormal];

    self.currentPage = CurrentPage_login;//登录页面
    self->_jobsAppDoorContentView.frame = CGRectMake(JobsAppDoorContentViewLoginX,
                                                     JobsAppDoorContentViewLoginY,
                                                     JobsAppDoorContentViewLoginWidth,
                                                     JobsAppDoorContentViewLoginHeight);
    toRegisterBtn.frame = CGRectMake(self->_jobsAppDoorContentView.width - 64,
                                     0,
                                     64,
                                     self->_jobsAppDoorContentView.height);
}
/// 进此页面先自动跳转到注册页面
-(void)toRegister{
    [self.jobsAppDoorContentView animationToRegister];
}
#pragma mark —— 网络请求
/// 注册网络请求
-(void)authRegisterByAccount:(NSString *_Nullable)account
                     country:(NSString *_Nullable)country
                  inviteCode:(NSString *_Nullable)inviteCode
                    password:(NSString *_Nullable)password
                       phone:(NSString *_Nullable)phone
                   phoneCode:(NSString *_Nullable)phoneCode
                    validate:(NSString *_Nullable)validate{
    
    [self->toRegisterBtn sendActionsForControlEvents:UIControlEventTouchUpInside];
}
/// 登录网络请求
-(void)authLoginByAccount:(NSString *_Nullable)account
                 deviceId:(NSString *_Nullable)deviceId
                 password:(NSString *_Nullable)password
                 validate:(NSString *_Nullable)validate{
    
}
/// 网易云盾验证
-(void)NTESVerifyCodeWithBlock:(MKDataBlock)block{
    [self openVerifyCodeView:self.view];
    @jobs_weakify(self)
    [self setViewBlock:^(UIViewModel *data) {
        @jobs_strongify(self)
        if ([data isKindOfClass:UIViewModel.class]) {
            UIViewModel *vm = (UIViewModel *)data;
            if (vm.ntesVerifyCodeFinishResult) {
                // TODO
                if (block) block(data);
            }
            
            if (vm.ntesVerifyCodeManagerStyle == VerifyCodeInitFinish) {
                self.NTESVerifyCodeCloseBtn.visible = YES;
            }
        }
    }];
}
//键盘 弹出 和 收回 走这个方法
-(void)keyboardWillChangeFrameNotification:(NSNotification *)notification{}

-(void)keyboardDidChangeFrameNotification:(NSNotification *)notification{
//    NSDictionary *userInfo = notification.userInfo;
//    CGRect beginFrame = [userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
//    CGRect endFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
//    CGFloat KeyboardOffsetY = beginFrame.origin.y - endFrame.origin.y;
    @jobs_weakify(self)
    NSMutableArray * (^currentPageDataMutArr)(CurrentPage currentPage) = ^(CurrentPage currentPage){
        @jobs_strongify(self)
        if (currentPage == CurrentPage_login) {
            return self.jobsAppDoorContentView.loginDoorInputViewBaseStyleMutArr;
        }else{
            return self.jobsAppDoorContentView.registerDoorInputViewBaseStyleMutArr;
        }
    };
    
    index = 0;
    
    for (JobsAppDoorInputViewBaseStyle *inputView in currentPageDataMutArr(self.currentPage)) {
        UITextField *textField = inputView.getTextField;
        if (textField.isEditing) {
            NSLog(@"当前被激活的输入框的index = %ld",index);
            self.lastTimeActivateTFIndex = self.currentActivateTFIndex;
            self.currentActivateTFIndex = index;//赋予新值。因为同一时刻，textField有且只有一个被激活
            
            NSLog(@"在编辑");
            NSInteger offsetIdx = self.currentActivateTFIndex - self.lastTimeActivateTFIndex;
            self.jobsAppDoorContentView.y -= JobsWidth(40) * (offsetIdx + 0);
            self.logoContentView.y -= JobsWidth(40) * (offsetIdx + 0);
            self.customerServiceBtn.y -= JobsWidth(40) * (offsetIdx + 0);
            
            lastEditTextField = textField;
            index++;
            break;
        }else{
            NSLog(@"没有在编辑");
            self.jobsAppDoorContentView.y = self.jobsAppDoorContentViewY;
            self.logoContentView.y = self.logoContentViewY;
            self.customerServiceBtn.y = self.customerServiceBtnY;
            index++;
        }
    }
    NSLog(@"");
}
#pragma mark —— lazyLoad
-(JobsAppDoorLogoContentView *)logoContentView{
    if (!_logoContentView) {
        _logoContentView = JobsAppDoorLogoContentView.new;
        [self.view addSubview:_logoContentView];
        [_logoContentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(JobsWidth(150), JobsWidth(150)));
            make.bottom.equalTo(self.jobsAppDoorContentView.mas_top).offset(-JobsWidth(50));
            make.centerX.equalTo(self.view);
        }];
        [self.view layoutIfNeeded];
        self.logoContentViewY = self.logoContentView.y;
    }return _logoContentView;
}

-(JobsAppDoorForgotCodeContentView *)forgotCodeContentView{
    if (!_forgotCodeContentView) {
        _forgotCodeContentView = JobsAppDoorForgotCodeContentView.new;
        _forgotCodeContentView.x = JobsAppDoorContentViewFindPasswordX;
        _forgotCodeContentView.y = JobsAppDoorContentViewFindPasswordY;
        _forgotCodeContentView.width = JobsAppDoorContentViewFindPasswordWidth;
        _forgotCodeContentView.height = JobsAppDoorContentViewFindPasswordHeight;
        self.forgotCodeContentViewY = _forgotCodeContentView.y;
        [self.view addSubview:_forgotCodeContentView];
        [_forgotCodeContentView richElementsInViewWithModel:UIViewModel.new];
        @weakify(self)
        [_forgotCodeContentView actionViewBlock:^(id data) {
            @strongify(self)
            if ([data isKindOfClass:UIButton.class]) {
                UIButton *btn = (UIButton *)data;
                if ([btn.titleLabel.text isEqualToString:Title1]){
                    self.currentPage = CurrentPage_login;
                    [self.forgotCodeContentView removeContentViewWithOffsetY:0];
                    [self.jobsAppDoorContentView showContentViewWithOffsetY:0];
                    @weakify(self)
                    [UIView animateWithDuration:2
                                          delay:0.1
                         usingSpringWithDamping:0.3
                          initialSpringVelocity:10
                                        options:UIViewAnimationOptionCurveEaseInOut
                                     animations:^{
                        @strongify(self)
                        self.customerServiceBtn.alpha = 1;
                    } completion:nil];
                }else{}
            }
        }];
        [UIView cornerCutToCircleWithView:_forgotCodeContentView andCornerRadius:8];
    }return _forgotCodeContentView;
}

-(JobsAppDoorContentView *)jobsAppDoorContentView{
    if (!_jobsAppDoorContentView) {
        _jobsAppDoorContentView = JobsAppDoorContentView.new;
        /// 初始进的是登录页面
        _jobsAppDoorContentView.frame = CGRectMake(JobsAppDoorContentViewLoginX,
                                                   JobsAppDoorContentViewLoginY,
                                                   JobsAppDoorContentViewLoginWidth,
                                                   JobsAppDoorContentViewLoginHeight);
        self.jobsAppDoorContentViewY = _jobsAppDoorContentView.y;
        _jobsAppDoorContentView.backgroundColor = Cor2;
        @weakify(self)
        //监测输入字符回调 和 激活的textField 和 toRegisterBtn/abandonLoginBtn点击事件
        [_jobsAppDoorContentView actionViewBlock:^(id data) {
            @strongify(self)
            if ([data isKindOfClass:UIButton.class]) {
                [self.view endEditing:YES];
                UIButton *btn = (UIButton *)data;
                if ([btn.titleLabel.text isEqualToString:Title2] ||// Title2 Internationalization(@"L\no\ng\ni\nn")
                    [btn.titleLabel.text isEqualToString:Title1]) {// Title1 Internationalization(@"B\na\nc\nk\nT\no\nL\no\ng\ni\nn")
                    self->toRegisterBtn = (UIButton *)data;
                    //状态置空
                    self.currentActivateTFIndex = 0;
                    self.lastTimeActivateTFIndex = 0;
                    
                    if (self->toRegisterBtn.selected) {
                        [self 竖形按钮在左边];
                    }else{
                        [self 竖形按钮在右边];
                    }
                    self.customerServiceBtn.top = self.jobsAppDoorContentView.top + self.jobsAppDoorContentView.height + JobsWidth(20);
                    self.customerServiceBtnY =  self.customerServiceBtn.y;
                }
                else if ([btn.titleLabel.text isEqualToString:Title6]){// Title6 Internationalization(@"Register")
                    if ([self checkRegisterData:self.appDoorModel]) {
                        @weakify(self)
                        [self NTESVerifyCodeWithBlock:^(UIViewModel *data) {
                            @strongify(self)
                            NSLog(@"网易云盾验证注册成功");
                            [self authRegisterByAccount:self.appDoorModel.userName
                                                country:nil
                                             inviteCode:nil
                                               password:self.appDoorModel.password
                                                  phone:self.appDoorModel.tel
                                              phoneCode:self.appDoorModel.verificationCode
                                               validate:data.ntesVerifyCodeValidate];
                        }];
                    }
                }
                else if ([btn.titleLabel.text isEqualToString:Title7]){// Internationalization(@"Login")
                    if ([self checkLoginData:self.appDoorModel]) {
                        @weakify(self)
                        [self NTESVerifyCodeWithBlock:^(UIViewModel *data) {
                            @strongify(self)
                            NSLog(@"网易云盾验证登陆成功");
                            [self authLoginByAccount:self.appDoorModel.userName
                                            deviceId:nil
                                            password:self.appDoorModel.password
                                            validate:data.ntesVerifyCodeValidate];
                        }];
                    }
                }
                else if ([btn.titleLabel.text isEqualToString:Title4]){// Title4 Internationalization(@"Back to HomePage")
                    UIButton *abandonLoginBtn = (UIButton *)data;
                    [self backBtnClickEvent:abandonLoginBtn];
                    [JobsAppDoorVC destroyAppDoorSingleton];
                }
                else if ([btn.titleLabel.text isEqualToString:Title5]){// Title5 Internationalization(@"Save the user name")
                    
                }
                else if ([btn.titleLabel.text isEqualToString:Title3]){// Title3 Internationalization(@"Forgot code")
                    
                    {//本页动效实现的
                        self.currentPage = CurrentPage_forgotCode;
                        [self->_jobsAppDoorContentView removeContentViewWithOffsetY:0];
                        [self.forgotCodeContentView showContentViewWithOffsetY:0];
                        self.customerServiceBtn.alpha = 0;
                    }

                }else{}
            }else if ([data isKindOfClass:JobsAppDoorModel.class]){
                self.appDoorModel = (JobsAppDoorModel *)data;
            }else{}
        }];
        [self.view addSubview:_jobsAppDoorContentView];
        [UIView cornerCutToCircleWithView:_jobsAppDoorContentView
                          andCornerRadius:8];
        [_jobsAppDoorContentView richElementsInViewWithModel:nil];
    }return _jobsAppDoorContentView;
}

-(UIButton *)customerServiceBtn{
    if (!_customerServiceBtn) {
        _customerServiceBtn = UIButton.new;
        
        _customerServiceBtn.hidden = YES;//本版本需要进行屏蔽
        
        [_customerServiceBtn setTitle:Title8
                             forState:UIControlStateNormal];
        [_customerServiceBtn setImage:KIMG(@"客服")
                             forState:UIControlStateNormal];
        [self.view addSubview:_customerServiceBtn];
        _customerServiceBtn.size = CGSizeMake(JobsSCREEN_WIDTH / 3, JobsSCREEN_WIDTH / 9);
        _customerServiceBtn.centerX = JobsSCREEN_WIDTH / 2;
        _customerServiceBtn.top = self.jobsAppDoorContentView.top + self.jobsAppDoorContentView.height + 20;
        self.customerServiceBtnY = _customerServiceBtn.y;
        BtnClickEvent(_customerServiceBtn, NSLog(@"点击客服按钮"););
        [UIView cornerCutToCircleWithView:_customerServiceBtn
                          andCornerRadius:_customerServiceBtn.height / 2];
        [UIView colourToLayerOfView:_customerServiceBtn
                         withColour:kWhiteColor
                     andBorderWidth:2];
    }return _customerServiceBtn;
}

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
        @weakify(self)
        _player = [ZFPlayerController.alloc initWithPlayerManager:self.playerManager
                                                    containerView:self.view];
        _player.controlView = self.customPlayerControlView;
//        ZFPlayer_DoorVC = _player;
        [_player setPlayerDidToEnd:^(id<ZFPlayerMediaPlayback>  _Nonnull asset) {
            @strongify(self)
            [self.playerManager replay];//设置循环播放
        }];
    }return _player;
}

-(CustomZFPlayerControlView *)customPlayerControlView{
    if (!_customPlayerControlView) {
        _customPlayerControlView = CustomZFPlayerControlView.new;
        @weakify(self)
        [_customPlayerControlView actionCustomZFPlayerControlViewBlock:^(id data, id data2) {
            @strongify(self)
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

@end
