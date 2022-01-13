//
//  JobsAppDoorVC_Style2.m
//  JobsAppDoor
//
//  Created by Jobs on 2020/12/7.
//

#import "JobsAppDoorVC_Style2.h"

@interface JobsAppDoorVC_Style2 ()
//UI
@property(nonatomic,strong)UIImageView *bgImgV;
@property(nonatomic,strong)UIButton *customerServiceBtn;
@property(nonatomic,strong)ZFPlayerController *player;
@property(nonatomic,strong)ZFAVPlayerManager *playerManager;
@property(nonatomic,strong,nullable)CustomZFPlayerControlView *customPlayerControlView;
@property(nonatomic,strong,nullable)JobsAppDoorLoginContentView *loginContentView;//登录页面
@property(nonatomic,strong,nullable)JobsAppDoorRegisterContentView *registerContentView;//注册页面
@property(nonatomic,strong,nullable)JobsAppDoorForgotCodeContentView *forgotCodeContentView;//忘记密码
@property(nonatomic,strong,nullable)JobsAppDoorLogoContentView *logoContentView;
//Data
@property(nonatomic,assign)CGFloat logoContentViewY;//初始高度
@property(nonatomic,assign)CGFloat loginContentViewY;//初始高度
@property(nonatomic,assign)CGFloat registerContentViewY;//初始高度
@property(nonatomic,assign)CGFloat forgotCodeContentViewY;//初始高度
@property(nonatomic,assign)CGFloat loginCustomerServiceBtnY;//在登录页面的初始高度
@property(nonatomic,assign)CGFloat registerCustomerServiceBtnY;//在注册页面的初始高度
@property(nonatomic,assign)BOOL loginDoorInputEditing;//只要有一个TF还在编辑那么就是在编辑
@property(nonatomic,assign)NSInteger lastTimeActivateTFIndex;//上一时刻被激活的输入框的序列号
@property(nonatomic,assign)NSInteger currentActivateTFIndex;//当前被激活的输入框的序列号

@end

@implementation JobsAppDoorVC_Style2

-(void)loadView{
    [super loadView];
    if ([self.requestParams integerValue] == JobsAppDoorBgType_Image) {
        self.view = self.bgImgV;
    }else if ([self.requestParams integerValue] == JobsAppDoorBgType_video){
        [self.player.currentPlayerManager play];
    }else{}
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kBlueColor;

    //标的值初始化
    self.logoContentViewY = 0;
    self.loginContentViewY = 0;
    self.registerContentViewY = 0;
    self.loginCustomerServiceBtnY = 0;
    self.registerCustomerServiceBtnY = 0;
    self.currentPage = CurrentPage_login;//默认页面是登录
    self.loginDoorInputEditing = NO;
    
    if ([self.requestParams integerValue] == JobsAppDoorBgType_Image) {
        self.view = self.bgImgV;
    }else if ([self.requestParams integerValue] == JobsAppDoorBgType_video){
        [self.player.currentPlayerManager play];
    }else{}
    
    [self keyboard];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.loginContentView animationAlert];
    [self.registerContentView animationAlert];
    [self.logoContentView animationAlert];
    [self.customerServiceBtn animationAlert];
    
    if ([self.requestParams integerValue] == JobsAppDoorBgType_Image) {
        
    }else if ([self.requestParams integerValue] == JobsAppDoorBgType_video){
        if (!self.player.currentPlayerManager.isPlaying) {
            [self.player.currentPlayerManager play];
        }
    }else{}
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
//键盘 弹出 和 收回 走这个方法
-(void)keyboardWillChangeFrameNotification:(NSNotification *)notification{}

-(void)keyboardDidChangeFrameNotification:(NSNotification *)notification{
//    NSDictionary *userInfo = notification.userInfo;
//    CGRect beginFrame = [userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
//    CGRect endFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
//    CGFloat KeyboardOffsetY = beginFrame.origin.y - endFrame.origin.y;

    NSMutableArray * (^currentPageDataMutArr)(CurrentPage currentPage) = ^(CurrentPage currentPage){
        if (currentPage == CurrentPage_login) {
            return self.loginContentView.loginDoorInputViewBaseStyleMutArr;
        }else{
            return self.registerContentView.registerDoorInputViewBaseStyleMutArr;
        }
    };

    NSInteger index = 0;
    for (JobsAppDoorInputViewBaseStyle *inputView in currentPageDataMutArr(self.currentPage)) {
        Ivar ivar = nil;
        if (index == 0) {
            ivar = class_getInstanceVariable([JobsAppDoorInputViewBaseStyle_3 class], "_tf");//必须是下划线接属性
        }else if (index == 1){
            ivar = class_getInstanceVariable([JobsAppDoorInputViewBaseStyle_3 class], "_tf");//必须是下划线接属性
        }else if (index == 2){
            ivar = class_getInstanceVariable([JobsAppDoorInputViewBaseStyle_3 class], "_tf");//必须是下划线接属性
        }else if (index == 3){
            ivar = class_getInstanceVariable([JobsAppDoorInputViewBaseStyle_1 class], "_tf");//必须是下划线接属性
        }else if (index == 4){
            ivar = class_getInstanceVariable([JobsAppDoorInputViewBaseStyle_4 class], "_tf");//必须是下划线接属性
        }else{}

        if (ivar) {
            JobsMagicTextField *tf = object_getIvar(inputView, ivar);
            self.loginDoorInputEditing |= tf.editing;
            if (tf.editing) {
                NSLog(@"FFF = %ld",index);//当前被激活的idx
                self.lastTimeActivateTFIndex = self.currentActivateTFIndex;
                self.currentActivateTFIndex = index;//赋予新值。因为同一时刻，textField有且只有一个被激活
            }
        }
        index += 1;
    }

    if (!self.loginDoorInputEditing) {
        NSLog(@"没有在编辑");
        self.logoContentView.y = self.logoContentViewY;
        self.loginContentView.y = self.loginContentViewY;
        self.registerContentView.y = self.registerContentViewY;
        
        if (self.currentPage == CurrentPage_login) {
            self.customerServiceBtn.y = self.loginCustomerServiceBtnY;
        }else if (self.currentPage == CurrentPage_register){
            self.customerServiceBtn.y = self.registerCustomerServiceBtnY;
        }else{}
        
    }else{
        NSLog(@"在编辑");
        NSInteger offsetIdx = self.currentActivateTFIndex - self.lastTimeActivateTFIndex;
        self.logoContentView.y -= 40 * (offsetIdx + 0);
        self.loginContentView.y -= 40 * (offsetIdx + 0);
        self.registerContentView.y -= 40 * (offsetIdx + 0);
        self.customerServiceBtn.y -= 40 * (offsetIdx + 0);
    }

    self.loginDoorInputEditing = NO;//置空状态
}
#pragma mark —— lazyLoad
-(JobsAppDoorLoginContentView *)loginContentView{
    if (!_loginContentView) {
        _loginContentView = JobsAppDoorLoginContentView.new;
        
        _loginContentView.x = 20;
        _loginContentView.y = JobsSCREEN_HEIGHT / 4;
        _loginContentView.height = JobsAppDoorContentViewLoginHeight;
        _loginContentView.width = JobsSCREEN_WIDTH - 40;
        self.loginContentViewY = _loginContentView.y;
        [self.view addSubview:_loginContentView];

        [_loginContentView richElementsInViewWithModel:nil];
        @weakify(self)
        [_loginContentView actionViewBlock:^(id data) {
            @strongify(self)
            if ([data isKindOfClass:UIButton.class]) {
                UIButton *btn = (UIButton *)data;
                if ([btn.titleLabel.text isEqualToString:Title2]) {
                    self.currentPage = CurrentPage_register;
                    [self->_loginContentView removeContentViewWithOffsetY:0];
                    [self.registerContentView showContentViewWithOffsetY:0];
                    @weakify(self)
                    [UIView animateWithDuration:2
                                          delay:0.1
                         usingSpringWithDamping:0.3
                          initialSpringVelocity:10
                                        options:UIViewAnimationOptionCurveEaseInOut
                                     animations:^{
                        @strongify(self)
                        if (!self.registerCustomerServiceBtnY) {
                            self.registerCustomerServiceBtnY = self.registerContentView.top + self.registerContentView.height + 20;
                        }
                        self.customerServiceBtn.y = self.registerCustomerServiceBtnY;
                        
                    } completion:nil];
                }else if([btn.titleLabel.text isEqualToString:Title3]){
                   
                    self.currentPage = CurrentPage_forgotCode;
                    [self->_loginContentView removeContentViewWithOffsetY:0];
                    [self.forgotCodeContentView showContentViewWithOffsetY:0];
                    self.customerServiceBtn.alpha = 0;
                    
                }else if([btn.titleLabel.text isEqualToString:Title4]){
                    [self backBtnClickEvent:btn];
                }else if([btn.titleLabel.text isEqualToString:Title3]){
                    // 忘记密码
                    [UIViewController comingFromVC:self
                                              toVC:DDForgetCodeVC.new
                                       comingStyle:ComingStyle_PUSH
                                 presentationStyle:UIModalPresentationFullScreen//[UIDevice currentDevice].systemVersion.doubleValue >= 13.0 ? UIModalPresentationAutomatic : UIModalPresentationFullScreen
                                     requestParams:nil
                          hidesBottomBarWhenPushed:YES
                                          animated:YES
                                           success:nil];
                }else{}
            }else if ([data isKindOfClass:JobsMagicTextField.class]){
                
            }else if ([data isKindOfClass:NSString.class]){
                
            }else{}
        }];
        [UIView cornerCutToCircleWithView:_loginContentView
                          andCornerRadius:8];
    }return _loginContentView;
}

-(JobsAppDoorRegisterContentView *)registerContentView{
    if (!_registerContentView) {
        _registerContentView = JobsAppDoorRegisterContentView.new;
        
        _registerContentView.x = JobsSCREEN_WIDTH + 20;
        _registerContentView.y = JobsSCREEN_HEIGHT / 4;
        _registerContentView.height = JobsAppDoorContentViewRegisterHeight;
        _registerContentView.width = JobsSCREEN_WIDTH - 40;
        self.registerContentViewY = _registerContentView.y;
        [self.view addSubview:_registerContentView];
        [_registerContentView richElementsInViewWithModel:nil];
        @weakify(self)
        [_registerContentView actionViewBlock:^(id data) {
            @strongify(self)
            if ([data isKindOfClass:UIButton.class]) {
                UIButton *btn = (UIButton *)data;
                if ([btn.titleLabel.text isEqualToString:Title1]){
                    self.currentPage = CurrentPage_login;
                    [self.registerContentView removeContentViewWithOffsetY:0];
                    [self->_loginContentView showContentViewWithOffsetY:0];
                    @weakify(self)
                    [UIView animateWithDuration:2
                                          delay:0.1
                         usingSpringWithDamping:0.3
                          initialSpringVelocity:10
                                        options:UIViewAnimationOptionCurveEaseInOut
                                     animations:^{
                        @strongify(self)
                        self.customerServiceBtn.y = self.loginCustomerServiceBtnY;
                    } completion:nil];
                }else{}
            }
        }];
        [UIView cornerCutToCircleWithView:_registerContentView andCornerRadius:8];
    }return _registerContentView;
}

-(JobsAppDoorForgotCodeContentView *)forgotCodeContentView{
    if (!_forgotCodeContentView) {
        _forgotCodeContentView = JobsAppDoorForgotCodeContentView.new;
        
        _forgotCodeContentView.x = JobsSCREEN_WIDTH + 20;
        _forgotCodeContentView.y = JobsSCREEN_HEIGHT / 4;
        _forgotCodeContentView.height = JobsAppDoorContentViewFindPasswordHeight;
        _forgotCodeContentView.width = JobsSCREEN_WIDTH - 40;
        self.forgotCodeContentViewY = _forgotCodeContentView.y;
        [self.view addSubview:_forgotCodeContentView];
        [_forgotCodeContentView richElementsInViewWithModel:nil];
        @weakify(self)
        [_forgotCodeContentView actionViewBlock:^(id data) {
            @strongify(self)
            if ([data isKindOfClass:UIButton.class]) {
                UIButton *btn = (UIButton *)data;
                if ([btn.titleLabel.text isEqualToString:Title1]){
                    self.currentPage = CurrentPage_login;
                    [self.forgotCodeContentView removeContentViewWithOffsetY:0];
                    [self->_loginContentView showContentViewWithOffsetY:0];
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

-(JobsAppDoorLogoContentView *)logoContentView{
    if (!_logoContentView) {
        _logoContentView = JobsAppDoorLogoContentView.new;
        [self.view addSubview:_logoContentView];
        [_logoContentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(JobsWidth(150), JobsWidth(50)));
            make.bottom.equalTo(self.loginContentView.mas_top).offset(-JobsWidth(50));
            make.centerX.equalTo(self.view);
        }];
        [self.view layoutIfNeeded];
        self.logoContentViewY = self.logoContentView.y;
    }return _logoContentView;
}

-(UIButton *)customerServiceBtn{
    if (!_customerServiceBtn) {
        _customerServiceBtn = UIButton.new;
        [_customerServiceBtn setTitle:Title8
                             forState:UIControlStateNormal];
        [_customerServiceBtn setImage:KIMG(@"客服")
                             forState:UIControlStateNormal];
        [self.view addSubview:_customerServiceBtn];
        _customerServiceBtn.size = CGSizeMake(JobsSCREEN_WIDTH / 3, JobsSCREEN_WIDTH / 9);
        _customerServiceBtn.centerX = JobsSCREEN_WIDTH / 2;
        _customerServiceBtn.top = self.loginContentView.top + self.loginContentView.height + 20;
        self.loginCustomerServiceBtnY = _customerServiceBtn.y;
        @weakify(self)
        [[_customerServiceBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            //点击事件
            @strongify(self)
        }];
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
            _playerManager.assetURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"iph_X"
                                                                                             ofType:@"mp4"]];
        }else{
            _playerManager.assetURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"非iph_X"
                                                                                             ofType:@"mp4"]];
        }
    }return _playerManager;
}

-(ZFPlayerController *)player{
    if (!_player) {
        @weakify(self)
        _player = [[ZFPlayerController alloc] initWithPlayerManager:self.playerManager
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
