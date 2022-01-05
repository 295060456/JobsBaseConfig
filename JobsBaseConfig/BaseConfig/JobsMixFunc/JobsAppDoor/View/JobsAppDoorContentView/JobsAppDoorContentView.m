//
//  JobsAppDoorContentView.m
//  My_BaseProj
//
//  Created by Jobs on 2020/12/3.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "JobsAppDoorContentView.h"

// 可以发现：（animateWithDuration + Masonry，动画参数设置无效）
// 用户名 和 密码 ，登录注册两个界面共用，只不过frame不一样
UIButton *appDoorStoreCodeBtn;
@interface JobsAppDoorContentView ()
// UI
@property(nonatomic,strong)UILabel *titleLab;//标题
@property(nonatomic,strong)UIButton *abandonLoginBtn;//返回首页按钮
@property(nonatomic,strong)UIButton *toRegisterBtn;//去注册
@property(nonatomic,strong)UIButton *sendBtn;//登录 & 注册按钮 （本页面请求可以不用jobsAppDoorContentViewBlock回调）
@property(nonatomic,strong)UIButton *storeCodeBtn;//记住密码
@property(nonatomic,strong)UIButton *findCodeBtn;//忘记密码
// Data
@property(nonatomic,strong)NSMutableArray <JobsAppDoorInputViewBaseStyleModel *>*loginDoorInputViewBaseStyleModelMutArr;
@property(nonatomic,strong)NSMutableArray <JobsAppDoorInputViewBaseStyleModel *>*registerDoorInputViewBaseStyleModelMutArr;
@property(nonatomic,strong)NSMutableArray <JobsAppDoorInputViewBaseStyle *>*inputViewMutArr;
@property(nonatomic,strong)NSMutableDictionary *loginInputTFValueMutDic;
@property(nonatomic,strong)NSMutableDictionary *registerInputTFValueMutDic;
@property(nonatomic,strong)JobsAppDoorModel *appDoorModel;

@end

@implementation JobsAppDoorContentView

static dispatch_once_t JobsAppDoorContentViewDispatchOnce;
-(instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = Cor2;
        JobsAppDoorContentViewDispatchOnce = 0;
    }return self;
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    dispatch_once(&JobsAppDoorContentViewDispatchOnce, ^{
        //进页面最初是登录
        [self initialToRegisterBtn];
        [self initialTitleLab];
        [self makeInputView];
        [self initialSendBtn];
        [self initialAbandonLoginBtn];
        [self initialOthers];
    });
}
#pragma mark —— BaseViewProtocol
-(void)richElementsInViewWithModel:(id _Nullable)contentViewModel{}
#pragma mark —— 网络请求
/// 获取手机验证码网络请求
-(void)getCellPhoneVerificationCodeWithCountry:(NSString *)country
                                         phone:(NSString *)phone{
    [self delay:5
          doSth:^(id data) {
//        [WHToast toastSuccessMsg:Internationalization(@"Verification send success")];
//        [WHToast toastErrMsg:Internationalization(@"TelePhone Number Error")];
        
        extern UIButton *appDoorCountDownBtn;
        [appDoorCountDownBtn timerDestroy];
    }];
}
#pragma mark —— 一些外部调用的方法
/// 去登录【外部调用】
-(void)animationToLogin{
    if (![NSString isNullString:self.registerInputTFValueMutDic[@"用户名"]] &&
        [NSString isNullString:self.loginInputTFValueMutDic[@"用户名"]]) {
        [self.loginInputTFValueMutDic setValue:self.registerInputTFValueMutDic[@"用户名"] forKey:@"用户名"];
    }else{
        [self.loginInputTFValueMutDic setValue:@"" forKey:@"用户名"];
    }
    
    if (![NSString isNullString:self.registerInputTFValueMutDic[@"密码"]] &&
        [NSString isNullString:self.loginInputTFValueMutDic[@"密码"]]) {
        [self.loginInputTFValueMutDic setValue:self.registerInputTFValueMutDic[@"密码"] forKey:@"密码"];
    }else{
        [self.loginInputTFValueMutDic setValue:@"" forKey:@"密码"];
    }
    
    [self sendBtnCheckWithDic:self.loginInputTFValueMutDic
       userInteractionEnabled:@selector(checkLoginBtnCanBeUsed)
                         data:nil];
    
    [self 一些UI的初始状态];
    
    for (int i = 0; i < self.loginDoorInputViewBaseStyleMutArr.count; i++) {
        JobsAppDoorInputViewBaseStyle *inputView = self.loginDoorInputViewBaseStyleMutArr[i];
        inputView.x = JobsWidth(20);
    }
    
    for (long i = self.loginDoorInputViewBaseStyleMutArr.count;
         i < self.registerDoorInputViewBaseStyleModelMutArr.count;
         i++) {
        if (self.registerDoorInputViewBaseStyleMutArr.count > i) {
            JobsAppDoorInputViewBaseStyle *inputView = self.registerDoorInputViewBaseStyleMutArr[i];
            inputView.alpha = 0;
        }
    }
}
/// 去注册【外部调用】
-(void)animationToRegister{
    self.toRegisterBtn.selected = YES;
    [self animationChangeRegisterBtnFrame];
}
#pragma mark —— 一些私有方法
/// 手机验证码验证
-(BOOL)checkTelePhoneNum:(NSString *)phone{
    /// 不为空且全为整数
    if (![NSString isNullString:phone] &&
        [phone judgeiphoneNumberInt]) {
        return YES;
    }return NO;
}
/// 登录过滤
-(BOOL)loginCheck{
    
    JobsAppDoorInputViewBaseStyle_3 *用户名 = nil;
    JobsAppDoorInputViewBaseStyle_3 *密码 = nil;

    if (self.loginDoorInputViewBaseStyleMutArr.count >= 2) {
        用户名 = (JobsAppDoorInputViewBaseStyle_3 *)self.loginDoorInputViewBaseStyleMutArr[0];
        密码 = (JobsAppDoorInputViewBaseStyle_3 *)self.loginDoorInputViewBaseStyleMutArr[1];
    }

    if ([NSString isNullString:用户名.getTextFieldValue] && [NSString isNullString:密码.getTextFieldValue]){
        [WHToast toastErrMsg:Internationalization(@"Please complete the login information")];
        return NO;
    }
    
    if ([NSString isNullString:用户名.getTextFieldValue]) {
        [WHToast toastErrMsg:Internationalization(@"Please enter a user name")];
        return NO;
    }else if ([NSString isNullString:密码.getTextFieldValue]){
        [WHToast toastErrMsg:Internationalization(@"Please enter your password")];
        return NO;
    }else{
        self.appDoorModel.userName = 用户名.getTextFieldValue;
        self.appDoorModel.password = 密码.getTextFieldValue;
        return YES;
    }
}
/// 注册过滤
-(BOOL)registerCheck{
    JobsAppDoorInputViewBaseStyle_3 *用户名 = nil;
    JobsAppDoorInputViewBaseStyle_3 *密码 = nil;
    JobsAppDoorInputViewBaseStyle_3 *确认密码 = nil;
    JobsAppDoorInputViewBaseStyle_7 *手机号码 = nil;
    JobsAppDoorInputViewBaseStyle_1 *手机验证码 = nil;
    
    if (self.registerDoorInputViewBaseStyleMutArr.count == 5) {
        用户名 = (JobsAppDoorInputViewBaseStyle_3 *)self.registerDoorInputViewBaseStyleMutArr[0];
        密码 = (JobsAppDoorInputViewBaseStyle_3 *)self.registerDoorInputViewBaseStyleMutArr[1];
        确认密码 = (JobsAppDoorInputViewBaseStyle_3 *)self.registerDoorInputViewBaseStyleMutArr[2];
        手机号码 = (JobsAppDoorInputViewBaseStyle_7 *)self.registerDoorInputViewBaseStyleMutArr[3];
        手机验证码 = (JobsAppDoorInputViewBaseStyle_1 *)self.registerDoorInputViewBaseStyleMutArr[4];
    }
    
    if ([NSString isNullString:用户名.getTextFieldValue] ||
        [NSString isNullString:密码.getTextFieldValue] ||
        [NSString isNullString:确认密码.getTextFieldValue] ||
        [NSString isNullString:手机号码.getTextFieldValue] ||
        [NSString isNullString:手机验证码.getTextFieldValue]){
        [WHToast toastErrMsg:Internationalization(@"Please complete the registration information")];
        return NO;
    }
    
    if (![NSString isNullString:用户名.getTextFieldValue] &&
        ![NSString isNullString:密码.getTextFieldValue] &&
        ![NSString isNullString:确认密码.getTextFieldValue] &&
        ![NSString isNullString:手机号码.getTextFieldValue] &&
        ![NSString isNullString:手机验证码.getTextFieldValue]){
        
        self.appDoorModel.userName = 用户名.getTextFieldValue;
        self.appDoorModel.password = 密码.getTextFieldValue;
        self.appDoorModel.confirmPassword = 确认密码.getTextFieldValue;
        self.appDoorModel.tel = 手机号码.getTextFieldValue;
        self.appDoorModel.verificationCode = 手机验证码.getTextFieldValue;
        
        return YES;
    }return NO;
    
    {
        //    if ([NSString isNullString:用户名.getTextFieldValue]) {
        //        [WHToast toastErrMsg:Internationalization(@"Please enter a user name")];
        //        return NO;
        //    }else if ([NSString isNullString:密码.getTextFieldValue]){
        //        [WHToast toastErrMsg:Internationalization(@"Please enter your password")];
        //        return NO;
        //    }else if ([NSString isNullString:确认密码.getTextFieldValue]){
        //        [WHToast toastErrMsg:Internationalization(@"Please confirm your password")];
        //        return NO;
        //    }else if ([NSString isNullString:手机号码.getTextFieldValue]){
        //        [WHToast toastErrMsg:Internationalization(@"Please enter your mobile phone number")];
        //        return NO;
        //    }else if ([NSString isNullString:手机验证码.getTextFieldValue]){
        //        [WHToast toastErrMsg:Internationalization(@"Please enter the verification code")];
        //        return NO;
        //    }else{
        //        return YES;
        //    }
    }
}
/// sendBtn的状态
-(void)sendBtnCheckWithDic:(NSMutableDictionary *)inputTFValueMutDic
    userInteractionEnabled:(SEL)checkSendBtnCanBeUsed
                      data:(id _Nullable)data{
    if ([data isKindOfClass:NSDictionary.class]) {
        NSDictionary *dataDic = (NSDictionary *)data;
        JobsAppDoorInputViewTFModel *inputViewTFModel = dataDic[@"TFResModel"];
        [inputTFValueMutDic setValue:inputViewTFModel.resString
                              forKey:inputViewTFModel.PlaceHolder];
    }
    
//    SuppressWarcPerformSelectorLeaksWarning(self.sendBtn.userInteractionEnabled = [self performSelector:checkSendBtnCanBeUsed]);
//    if (self.sendBtn.userInteractionEnabled) {
//        self.sendBtn.backgroundColor = [KSystemPinkColor colorWithAlphaComponent:0.7];
//    }else{
//        self.sendBtn.backgroundColor = [KSystemPinkColor colorWithAlphaComponent:0.3];
//    }
}
/// Core
-(void)makeInputView{
    for (int i = 0; i < self.loginDoorInputViewBaseStyleModelMutArr.count; i++) {
        JobsAppDoorInputViewBaseStyle_3 *inputView = JobsAppDoorInputViewBaseStyle_3.new;
        [self.inputViewMutArr addObject:inputView];
        [self.loginDoorInputViewBaseStyleMutArr addObject:inputView];
        [inputView richElementsInViewWithModel:self.loginDoorInputViewBaseStyleModelMutArr[i]];
        @weakify(self)
        //【用户名 & 密码 输入回调，共享注册与登录两个界面】
        [inputView actionViewBlock:^(id data) {
            @strongify(self)
            if ([self.sendBtn.titleLabel.text isEqualToString:Title7]) {
                [self sendBtnCheckWithDic:self.loginInputTFValueMutDic
                   userInteractionEnabled:@selector(checkLoginBtnCanBeUsed)
                                     data:data];
            }else if([self.sendBtn.titleLabel.text isEqualToString:Title6]){
                [self sendBtnCheckWithDic:self.registerInputTFValueMutDic
                   userInteractionEnabled:@selector(checkRegisterBtnCanBeUsed)
                                     data:data];
            }else{}
            // 回调到外层，如果外层需要用的话
            if (self.viewBlock) self.viewBlock(data);//data：监测输入字符回调 和 激活的textField
        }];
        [self addSubview:inputView];
        inputView.size = CGSizeMake(self.width - self.toRegisterBtn.width - JobsWidth(40), ThingsHeight);
        inputView.x = JobsWidth(20);
        if (i == 0) {
            inputView.top = self.titleLab.bottom + JobsWidth(20);//20是偏移量
        }else if(i == 1){
            JobsAppDoorInputViewBaseStyle_3 *lastObj = (JobsAppDoorInputViewBaseStyle_3 *)self.loginDoorInputViewBaseStyleMutArr[i - 1];
            inputView.top = lastObj.bottom + InputViewOffset;
        }else{}
        inputView.layer.cornerRadius = ThingsHeight / 2;
        [self layoutIfNeeded];// 这句话不加，不刷新界面，placeHolder会出现异常
    }
}
/// 返回NO 登录按钮不可点击
-(BOOL)checkLoginBtnCanBeUsed{
    NSLog(@"self.inputTFValueMutDic = %@",self.loginInputTFValueMutDic);
    if (self.loginInputTFValueMutDic.count == self.loginDoorInputViewBaseStyleModelMutArr.count) {
        BOOL r = YES;
        for (JobsAppDoorInputViewBaseStyleModel *inputViewBaseStyleModel in self.loginDoorInputViewBaseStyleModelMutArr) {
            r &= ![NSString isNullString:(NSString *)self.loginInputTFValueMutDic[inputViewBaseStyleModel.placeHolderStr]];
        }return r;
    }else{
        return NO;
    }
}
/// 返回NO 注册按钮不可点击
-(BOOL)checkRegisterBtnCanBeUsed{
    if (self.registerInputTFValueMutDic.count == self.registerDoorInputViewBaseStyleModelMutArr.count) {
        BOOL r = YES;
        for (JobsAppDoorInputViewBaseStyleModel *inputViewBaseStyleModel in self.registerDoorInputViewBaseStyleModelMutArr) {
            r &= ![NSString isNullString:(NSString *)self.registerInputTFValueMutDic[inputViewBaseStyleModel.placeHolderStr]];
        }return r;
    }else{
        return NO;
    }
}
/// 一些需要通过点击状态改变状态的控件
/// 一些需要通过点击状态改变状态的控件【初始状态】
-(void)initialTitleLab{
    self.titleLab.text = Title7;
    self.titleLab.font = [UIFont systemFontOfSize:JobsWidth(20)
                                           weight:UIFontWeightRegular];
    self.titleLab.textColor = Cor4;
    [self.titleLab sizeToFit];//sizeToFit也会刷新UI造成UI错位，所以需要提前写
    self.titleLab.top = JobsWidth(20);
    self.titleLab.centerX = (self.width - self.toRegisterBtn.width) / 2;
}

-(void)initialSendBtn{
//        _sendBtn.backgroundColor = [KSystemPinkColor colorWithAlphaComponent:0.3];
    
    self.sendBtn.size = CGSizeMake(self.width - self.toRegisterBtn.width - JobsWidth(40), ThingsHeight);
    [self.sendBtn setBackgroundImage:KIMG(@"登录注册按钮背景图") forState:UIControlStateNormal];
    [self.sendBtn setBackgroundImage:KIMG(@"登录注册按钮背景图") forState:UIControlStateSelected];
    [self.sendBtn setTitleColor:Cor5
                       forState:UIControlStateNormal];
    [self.sendBtn setTitle:Title7
                  forState:UIControlStateNormal];
    self.sendBtn.titleLabel.font = [UIFont systemFontOfSize:JobsWidth(16)
                                                     weight:UIFontWeightRegular];
    [self.sendBtn.titleLabel sizeToFit];//必须先定Size，在依据Size刷新内部控件约束
    
    self.sendBtn.centerX = self.titleLab.centerX;
    self.sendBtn.bottom = JobsAppDoorContentViewLoginHeight - JobsWidth(50);

}
/// 返回首页
-(void)initialAbandonLoginBtn{
    
    self.abandonLoginBtn.height = JobsWidth(10);
    [self.abandonLoginBtn setTitle:Title4
                          forState:UIControlStateNormal];
    [self.abandonLoginBtn setTitleColor:Cor3
                               forState:UIControlStateNormal];
    self.abandonLoginBtn.titleLabel.font = [UIFont systemFontOfSize:JobsWidth(12)
                                                             weight:UIFontWeightSemibold];
    [self.abandonLoginBtn.titleLabel sizeToFit];
    self.abandonLoginBtn.adjustsImageSizeForAccessibilityContentSizeCategory = YES;
    
    self.abandonLoginBtn.bottom = JobsAppDoorContentViewLoginHeight - JobsWidth(20);
    self.abandonLoginBtn.centerX = self.sendBtn.centerX;
}

-(void)initialOthers{
    self.storeCodeBtn.alpha = 1;//存储登录信息
    self.findCodeBtn.alpha = 1;//找回密码
}

-(void)initialToRegisterBtn{
    [self.toRegisterBtn setTitle:Title2
                        forState:UIControlStateNormal];
    [self.toRegisterBtn layoutButtonWithEdgeInsetsStyle:GLButtonEdgeInsetsStyleTop
                                        imageTitleSpace:JobsWidth(20)];
}
/// 一些需要通过点击状态改变状态的控件【被选中状态】
-(void)selectTitleLab{
    self.titleLab.text = Title6;
    self.titleLab.centerX = (self.width + self.toRegisterBtn.width) / 2;
    [self.titleLab labelAutoWidthByFont];
}

-(void)selectSendBtn{
    self.sendBtn.centerX = self.titleLab.centerX;
    self.sendBtn.bottom = JobsAppDoorContentViewRegisterHeight - JobsWidth(50);
    [self.sendBtn setTitle:Title6
                  forState:UIControlStateNormal];
    [self.sendBtn buttonAutoWidthByFont];
}

-(void)selectAbandonLoginBtn{
    self.abandonLoginBtn.centerX = self.sendBtn.centerX;
    self.abandonLoginBtn.bottom = JobsAppDoorContentViewRegisterHeight - JobsWidth(20);
    self.abandonLoginBtn.alpha = 1;//返回首页
}

-(void)selectOthers{
    self.storeCodeBtn.alpha = 0;//存储登录信息
    self.findCodeBtn.alpha = 0;//找回密码
}

-(void)selectToRegisterBtn{
    [self.toRegisterBtn setTitle:Title1
                        forState:UIControlStateNormal];
}

-(void)一些UI的初始状态{
    [self initialTitleLab];
    [self initialSendBtn];
    [self initialAbandonLoginBtn];
    [self initialOthers];
    [self initialToRegisterBtn];
}

-(void)一些UI点击以后的状态{
    [self selectTitleLab];
    [self selectSendBtn];
    [self selectAbandonLoginBtn];
    [self selectOthers];
    [self selectToRegisterBtn];
}
/// 去注册【内部调用】
-(void)p_animationToRegister{
    [self 一些UI点击以后的状态];
    for (int i = 0;
         i < self.loginDoorInputViewBaseStyleMutArr.count;
         i++) {
        JobsAppDoorInputViewBaseStyle_3 *inputView = (JobsAppDoorInputViewBaseStyle_3 *)self.loginDoorInputViewBaseStyleMutArr[i];
        inputView.x += RegisterBtnWidth;
    }
    
    if (self.registerDoorInputViewBaseStyleMutArr.count) {//不是第一次
        [self sendBtnCheckWithDic:self.registerInputTFValueMutDic
           userInteractionEnabled:@selector(checkRegisterBtnCanBeUsed)
                             data:nil];
        for (long i = self.loginDoorInputViewBaseStyleMutArr.count;
             i < self.registerDoorInputViewBaseStyleModelMutArr.count;
             i++) {
            JobsAppDoorInputViewBaseStyle *inputView = (JobsAppDoorInputViewBaseStyle *)self.registerDoorInputViewBaseStyleMutArr[i];
            inputView.alpha = 1;
        }return;
    }
    
    [self.registerDoorInputViewBaseStyleMutArr addObjectsFromArray:self.loginDoorInputViewBaseStyleMutArr];
    for (long i = self.loginDoorInputViewBaseStyleMutArr.count;
         i < self.registerDoorInputViewBaseStyleModelMutArr.count;
         i++) {

        JobsAppDoorInputViewBaseStyle *doorInputViewBaseStyle = nil;
        if (i == self.loginDoorInputViewBaseStyleMutArr.count) {// 确认密码
            JobsAppDoorInputViewBaseStyle_3 *inputView = JobsAppDoorInputViewBaseStyle_3.new;
            doorInputViewBaseStyle = (JobsAppDoorInputViewBaseStyle *)inputView;
            [self addSubview:inputView];
            [self.registerDoorInputViewBaseStyleMutArr addObject:inputView];
            [inputView richElementsInViewWithModel:self.registerDoorInputViewBaseStyleModelMutArr[i]];
            @weakify(self)
            //监测输入字符回调 和 激活的textField【确认密码输入回调】
            [inputView actionViewBlock:^(id data) {
                @strongify(self)
                [self sendBtnCheckWithDic:self.registerInputTFValueMutDic
                   userInteractionEnabled:@selector(checkRegisterBtnCanBeUsed)
                                     data:data];
            }];
        }else if (i == self.loginDoorInputViewBaseStyleMutArr.count + 1){// 手机号码
            JobsAppDoorInputViewBaseStyle_7 *inputView = JobsAppDoorInputViewBaseStyle_7.new;
            doorInputViewBaseStyle = (JobsAppDoorInputViewBaseStyle *)inputView;
            [self addSubview:inputView];
            [self.registerDoorInputViewBaseStyleMutArr addObject:inputView];
            [inputView richElementsInViewWithModel:self.registerDoorInputViewBaseStyleModelMutArr[i]];
            @weakify(self)
            //监测输入字符回调 和 激活的textField 【手机号码输入回调】
            [inputView actionViewBlock:^(id data) {
                @strongify(self)
                [self sendBtnCheckWithDic:self.registerInputTFValueMutDic
                   userInteractionEnabled:@selector(checkRegisterBtnCanBeUsed)
                                     data:data];
            }];
        }else if (i == self.loginDoorInputViewBaseStyleMutArr.count + 2){// 手机验证码
            JobsAppDoorInputViewBaseStyle_1 *inputView = JobsAppDoorInputViewBaseStyle_1.new;
            doorInputViewBaseStyle = (JobsAppDoorInputViewBaseStyle *)inputView;
            [self addSubview:inputView];
            [self.registerDoorInputViewBaseStyleMutArr addObject:inputView];
            [inputView richElementsInViewWithModel:self.registerDoorInputViewBaseStyleModelMutArr[i]];
            @weakify(self)
            //监测输入字符回调 和 激活的textField 【手机验证码 输入回调】
            [inputView actionViewBlock:^(id data) {
                @strongify(self)
                [self sendBtnCheckWithDic:self.registerInputTFValueMutDic
                   userInteractionEnabled:@selector(checkRegisterBtnCanBeUsed)
                                     data:data];
            }];
        }else{}
        
        JobsAppDoorInputViewBaseStyle *lastObj = (JobsAppDoorInputViewBaseStyle *)self.registerDoorInputViewBaseStyleMutArr[i - 1];
        doorInputViewBaseStyle.top = lastObj.bottom + InputViewOffset;
        doorInputViewBaseStyle.size = CGSizeMake(self.width - self.toRegisterBtn.width - JobsWidth(40), ThingsHeight);
        doorInputViewBaseStyle.x = JobsWidth(20) + RegisterBtnWidth;
        doorInputViewBaseStyle.layer.cornerRadius = ThingsHeight / 2;
    }
}
/// 公共方法
-(void)animationCommon{
    if (self.viewBlock) self.viewBlock(self.toRegisterBtn);
    
    [self.toRegisterBtn layoutButtonWithEdgeInsetsStyle:GLButtonEdgeInsetsStyleTop
                                     imageTitleSpace:8];
    // 一些UI逻辑
    if (self.registerDoorInputViewBaseStyleMutArr.count == 5) {
        JobsAppDoorInputViewBaseStyle_3 *用户名 = (JobsAppDoorInputViewBaseStyle_3 *)self.registerDoorInputViewBaseStyleMutArr[0];
        JobsAppDoorInputViewBaseStyle_3 *密码 = (JobsAppDoorInputViewBaseStyle_3 *)self.registerDoorInputViewBaseStyleMutArr[1];
        JobsAppDoorInputViewBaseStyle_3 *确认密码 = (JobsAppDoorInputViewBaseStyle_3 *)self.registerDoorInputViewBaseStyleMutArr[2];
        JobsAppDoorInputViewBaseStyle_7 *手机号码 = (JobsAppDoorInputViewBaseStyle_7 *)self.registerDoorInputViewBaseStyleMutArr[3];
        JobsAppDoorInputViewBaseStyle_1 *手机验证码 = (JobsAppDoorInputViewBaseStyle_1 *)self.registerDoorInputViewBaseStyleMutArr[4];
        
        [用户名 changeTextFieldAnimationColor:self.toRegisterBtn.selected];
        [密码 changeTextFieldAnimationColor:self.toRegisterBtn.selected];
        [确认密码 changeTextFieldAnimationColor:self.toRegisterBtn.selected];
        [手机号码 changeTextFieldAnimationColor:self.toRegisterBtn.selected];
        [手机验证码 changeTextFieldAnimationColor:self.toRegisterBtn.selected];
        
        [UIView colourToLayerOfView:用户名
                         withColour:Cor4//self.toRegisterBtn.selected ? Cor2 : Cor1
                     andBorderWidth:1];
        
        [UIView colourToLayerOfView:密码
                         withColour:Cor4//self.toRegisterBtn.selected ? Cor2 : Cor1
                     andBorderWidth:1];
        
        [UIView colourToLayerOfView:确认密码
                         withColour:Cor4
                     andBorderWidth:1];
        @jobs_weakify(手机号码)
        @jobs_weakify(self)
        [手机验证码 actionViewBlock:^(id data) {
            @jobs_strongify(手机号码)
            @jobs_strongify(self)
            if ([data isKindOfClass:UIButton.class]) {
                NSLog(@"获取验证码");
                [self getCellPhoneVerificationCodeWithCountry:nil
                                                        phone:手机号码.getTextFieldValue];
            }
        }];
    }
}
/// 核心方法
-(void)animationChangeRegisterBtnFrame{
    /*
     *    使用弹簧的描述时间曲线来执行动画 ,当dampingRatio == 1 时,动画会平稳的减速到最终的模型值,而不会震荡.
     *    小于1的阻尼比在达到完全停止之前会震荡的越来越多.
     *    如果你可以使用初始的 spring velocity 来 指定模拟弹簧末端的对象在加载之前移动的速度.
     *    他是一个单位坐标系统,其中2被定义为在一秒内移动整个动画距离.
     *    如果你在动画中改变一个物体的位置,你想在动画开始前移动到 100 pt/s 你会超过0.5,
     *    dampingRatio 阻尼
     *    velocity 速度
     */
    @weakify(self)
    [UIView animateWithDuration:0.7f
                          delay:0.1f
         usingSpringWithDamping:1
          initialSpringVelocity:0.1f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
        @strongify(self)
        if (self.toRegisterBtn.selected) {//点击了“新用户注册”按钮，正在进入注册页面
            [self p_animationToRegister];
        }else{//点击了“返回登录”按钮，正在进入登录页面 初始状态
            [self animationToLogin];
        }
        [self animationCommon];
    } completion:nil];
}
#pragma mark —— lazyLoad
-(UIButton *)toRegisterBtn{
    if (!_toRegisterBtn) {
        _toRegisterBtn = UIButton.new;
        _toRegisterBtn.frame = CGRectMake(self.width - RegisterBtnWidth,
                                          0,
                                          RegisterBtnWidth,
                                          self.height);
        [_toRegisterBtn setImage:KIMG(@"用户名称")
                        forState:UIControlStateNormal];
        _toRegisterBtn.titleLabel.numberOfLines = 0;
        _toRegisterBtn.backgroundColor = Cor1;
        [_toRegisterBtn setTitleColor:Cor3
                             forState:UIControlStateNormal];
        _toRegisterBtn.titleLabel.font = [UIFont systemFontOfSize:JobsWidth(13)
                                                           weight:UIFontWeightMedium];
        @weakify(self)
        [[_toRegisterBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIButton * _Nullable x) {
            @strongify(self)
            x.selected = !x.selected;
            [self endEditing:YES];
            [self animationChangeRegisterBtnFrame];
        }];
        [self addSubview:_toRegisterBtn];
    }return _toRegisterBtn;
}

-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = UILabel.new;
        [self addSubview:_titleLab];
    }return _titleLab;
}

-(UIButton *)abandonLoginBtn{
    if (!_abandonLoginBtn) {
        _abandonLoginBtn = UIButton.new;
        @weakify(self)
        [[_abandonLoginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIButton * _Nullable x) {
            @strongify(self)
            if (self.viewBlock) self.viewBlock(x);
        }];
        [self addSubview:_abandonLoginBtn];
    }return _abandonLoginBtn;
}

-(UIButton *)sendBtn{
    if (!_sendBtn) {
        _sendBtn = UIButton.new;
        @jobs_weakify(self)
        [[_sendBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIButton * _Nullable x) {
            @jobs_strongify(self)
            [self endEditing:YES];
            self->_sendBtn.objBindingParams = self.appDoorModel;
            if ([x.titleLabel.text isEqualToString:Title7]) {// 登录
                if ([self loginCheck]) {
                    NSLog(@"SSSSS = 登录");
                    if (self.viewBlock) self.viewBlock(x);                }
            }else if ([x.titleLabel.text isEqualToString:Title6]){// 注册
                if ([self registerCheck]) {
                    NSLog(@"SSSSS = 注册");
                    if (self.viewBlock) self.viewBlock(x);
                }
            }else{}
        }];
        [self addSubview:_sendBtn];
        [UIView cornerCutToCircleWithView:_sendBtn
                          andCornerRadius:_sendBtn.height / 2];
    }return _sendBtn;
}
/// 记住登录成功的账号和密码
-(UIButton *)storeCodeBtn{
    if (!_storeCodeBtn) {
        _storeCodeBtn = UIButton.new;
        appDoorStoreCodeBtn = _storeCodeBtn;
        [_storeCodeBtn setTitle:Title5
                       forState:UIControlStateNormal];
        _storeCodeBtn.titleLabel.font = [UIFont systemFontOfSize:JobsWidth(10)
                                                          weight:UIFontWeightRegular];
        _storeCodeBtn.selected = YES;// 默认记住密码
        [_storeCodeBtn setImage:KIMG(@"没有记住密码")
                       forState:UIControlStateNormal];
        [_storeCodeBtn setImage:KIMG(@"记住密码")
                       forState:UIControlStateSelected];
        [_storeCodeBtn setTitleColor:Cor4
                            forState:UIControlStateNormal];
        [_storeCodeBtn.titleLabel sizeToFit];
        [_storeCodeBtn.titleLabel adjustsFontSizeToFitWidth];
        _storeCodeBtn.titleLabel.adjustsFontForContentSizeCategory = YES;
        [self addSubview:_storeCodeBtn];
        [_storeCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            JobsAppDoorInputViewBaseStyle_3 *inputView = (JobsAppDoorInputViewBaseStyle_3 *)self.inputViewMutArr.lastObject;
            make.left.equalTo(inputView).offset(JobsWidth(20));
            make.top.equalTo(inputView.mas_bottom).offset(JobsWidth(25));
        }];
        
        [self layoutIfNeeded];
        [_storeCodeBtn layoutButtonWithEdgeInsetsStyle:GLButtonEdgeInsetsStyleLeft
                                       imageTitleSpace:JobsWidth(3)];
        @weakify(self)
        [[_storeCodeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIButton * _Nullable x) {
            @strongify(self)
            x.selected = !x.selected;
            if (self.viewBlock) self.viewBlock(x);
        }];
    }return _storeCodeBtn;
}

-(UIButton *)findCodeBtn{
    if (!_findCodeBtn) {
        _findCodeBtn = UIButton.new;
        [_findCodeBtn setTitle:Title3
                      forState:UIControlStateNormal];
        _findCodeBtn.titleLabel.font = [UIFont systemFontOfSize:JobsWidth(10)
                                                         weight:UIFontWeightRegular];
        [_findCodeBtn setTitleColor:Cor3
                           forState:UIControlStateNormal];
        [_findCodeBtn.titleLabel sizeToFit];
        [_findCodeBtn.titleLabel adjustsFontSizeToFitWidth];
        _findCodeBtn.titleLabel.adjustsFontForContentSizeCategory = YES;
        [self addSubview:_findCodeBtn];
        [_findCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            JobsAppDoorInputViewBaseStyle_3 *inputView = (JobsAppDoorInputViewBaseStyle_3 *)self.inputViewMutArr.lastObject;
            make.right.equalTo(inputView).offset(-JobsWidth(20));
            make.top.equalTo(inputView.mas_bottom).offset(JobsWidth(20));
        }];

        @weakify(self)
        [[_findCodeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIButton * _Nullable x) {
            @strongify(self)
            if (self.viewBlock) self.viewBlock(x);
        }];
    }return _findCodeBtn;
}

-(NSMutableArray<JobsAppDoorInputViewBaseStyleModel *> *)loginDoorInputViewBaseStyleModelMutArr{
    if (!_loginDoorInputViewBaseStyleModelMutArr) {
        _loginDoorInputViewBaseStyleModelMutArr = NSMutableArray.array;

        {
            JobsAppDoorInputViewBaseStyleModel *用户名 = JobsAppDoorInputViewBaseStyleModel.new;
            用户名.leftViewIMG = KIMG(@"用户名称");
            用户名.placeHolderStr = Internationalization(@"User");
            用户名.isShowDelBtn = YES;
            用户名.isShowSecurityBtn = NO;
            用户名.returnKeyType = UIReturnKeyDone;
            用户名.keyboardAppearance = UIKeyboardAppearanceAlert;
            用户名.leftViewMode = UITextFieldViewModeAlways;
            用户名.placeholderColor = UIColor.whiteColor;

            if (self.readUserNameMutArr.count) {
                用户名.inputStr = [self readUserNameMutArr][0];
            }
            [_loginDoorInputViewBaseStyleModelMutArr addObject:用户名];
        }
        
        {
            JobsAppDoorInputViewBaseStyleModel *密码 = JobsAppDoorInputViewBaseStyleModel.new;
            密码.leftViewIMG = KIMG(@"Lock");
            密码.placeHolderStr = Internationalization(@"Code");
            密码.isShowDelBtn = YES;
            密码.isShowSecurityBtn = YES;
            密码.selectedSecurityBtnIMG = KIMG(@"codeEncode");//闭眼
            密码.unSelectedSecurityBtnIMG =KIMG(@"codeDecode");//开眼
            密码.returnKeyType = UIReturnKeyDone;
            密码.keyboardAppearance = UIKeyboardAppearanceAlert;
            密码.leftViewMode = UITextFieldViewModeAlways;
            密码.placeholderColor = UIColor.whiteColor;
            [_loginDoorInputViewBaseStyleModelMutArr addObject:密码];
        }
        
    }return _loginDoorInputViewBaseStyleModelMutArr;
}

-(NSMutableArray<JobsAppDoorInputViewBaseStyleModel *> *)registerDoorInputViewBaseStyleModelMutArr{
    if (!_registerDoorInputViewBaseStyleModelMutArr) {
        _registerDoorInputViewBaseStyleModelMutArr = NSMutableArray.array;
        
        {
            JobsAppDoorInputViewBaseStyleModel *用户名 = JobsAppDoorInputViewBaseStyleModel.new;
            用户名.leftViewIMG = KIMG(@"用户名称");
            用户名.placeHolderStr = Internationalization(@"User");
            用户名.isShowDelBtn = YES;
            用户名.isShowSecurityBtn = NO;
            用户名.returnKeyType = UIReturnKeyDone;
            用户名.keyboardAppearance = UIKeyboardAppearanceAlert;
            用户名.leftViewMode = UITextFieldViewModeAlways;
            用户名.inputStr = self.readUserInfo.userName;
            用户名.placeholderColor = UIColor.whiteColor;
            [_registerDoorInputViewBaseStyleModelMutArr addObject:用户名];
        }
        
        {
            JobsAppDoorInputViewBaseStyleModel *密码 = JobsAppDoorInputViewBaseStyleModel.new;
            密码.leftViewIMG = KIMG(@"Lock");
            密码.placeHolderStr = Internationalization(@"Code");
            密码.isShowDelBtn = YES;
            密码.isShowSecurityBtn = YES;
            密码.returnKeyType = UIReturnKeyDone;
            密码.keyboardAppearance = UIKeyboardAppearanceAlert;
            密码.selectedSecurityBtnIMG = KIMG(@"codeEncode");//闭眼
            密码.unSelectedSecurityBtnIMG = KIMG(@"codeDecode");//开眼
            密码.leftViewMode = UITextFieldViewModeAlways;
            密码.placeholderColor = UIColor.whiteColor;
            [_registerDoorInputViewBaseStyleModelMutArr addObject:密码];
        }
        
        {
            JobsAppDoorInputViewBaseStyleModel *确认密码 = JobsAppDoorInputViewBaseStyleModel.new;
            确认密码.leftViewIMG = KIMG(@"Lock");
            确认密码.placeHolderStr = Internationalization(@"Confirm");
            确认密码.isShowDelBtn = YES;
            确认密码.isShowSecurityBtn = YES;
            确认密码.returnKeyType = UIReturnKeyDone;
            确认密码.keyboardAppearance = UIKeyboardAppearanceAlert;
            确认密码.selectedSecurityBtnIMG = KIMG(@"codeEncode");//闭眼
            确认密码.unSelectedSecurityBtnIMG = KIMG(@"codeDecode");//开眼
            确认密码.leftViewMode = UITextFieldViewModeAlways;
            确认密码.placeholderColor = UIColor.whiteColor;
            [_registerDoorInputViewBaseStyleModelMutArr addObject:确认密码];
        }
        
        {
            JobsAppDoorInputViewBaseStyleModel *手机号码 = JobsAppDoorInputViewBaseStyleModel.new;
            手机号码.leftViewIMG = KIMG(@"手机号码");
            手机号码.placeHolderStr = Internationalization(@"telephone");
            手机号码.isShowDelBtn = YES;
            手机号码.isShowSecurityBtn = NO;
            手机号码.returnKeyType = UIReturnKeyDone;
            手机号码.keyboardAppearance = UIKeyboardAppearanceAlert;
            手机号码.leftViewMode = UITextFieldViewModeAlways;
            手机号码.placeholderColor = UIColor.whiteColor;
            手机号码.keyboardType = UIKeyboardTypePhonePad;
            [_registerDoorInputViewBaseStyleModelMutArr addObject:手机号码];
        }
        
        {
            JobsAppDoorInputViewBaseStyleModel *手机验证码 = JobsAppDoorInputViewBaseStyleModel.new;
            手机验证码.leftViewIMG = KIMG(@"验证ICON");
            手机验证码.placeHolderStr = Internationalization(@"Auth code");
            手机验证码.isShowDelBtn = YES;
            手机验证码.isShowSecurityBtn = NO;
            手机验证码.returnKeyType = UIReturnKeyDone;
            手机验证码.keyboardAppearance = UIKeyboardAppearanceAlert;
            手机验证码.leftViewMode = UITextFieldViewModeAlways;
            手机验证码.placeholderColor = UIColor.whiteColor;
            [_registerDoorInputViewBaseStyleModelMutArr addObject:手机验证码];
        }
        
    }return _registerDoorInputViewBaseStyleModelMutArr;
}

-(NSMutableArray<JobsAppDoorInputViewBaseStyle *> *)loginDoorInputViewBaseStyleMutArr{
    if (!_loginDoorInputViewBaseStyleMutArr) {
        _loginDoorInputViewBaseStyleMutArr = NSMutableArray.array;
    }return _loginDoorInputViewBaseStyleMutArr;
}

-(NSMutableArray<JobsAppDoorInputViewBaseStyle *> *)registerDoorInputViewBaseStyleMutArr{
    if (!_registerDoorInputViewBaseStyleMutArr) {
        _registerDoorInputViewBaseStyleMutArr = NSMutableArray.array;
    }return _registerDoorInputViewBaseStyleMutArr;
}

-(NSMutableArray<JobsAppDoorInputViewBaseStyle *> *)inputViewMutArr{
    if (!_inputViewMutArr) {
        _inputViewMutArr = NSMutableArray.array;
    }return _inputViewMutArr;
}

-(NSMutableDictionary *)loginInputTFValueMutDic{
    if (!_loginInputTFValueMutDic) {
        _loginInputTFValueMutDic = NSMutableDictionary.dictionary;
    }return _loginInputTFValueMutDic;
}

-(NSMutableDictionary *)registerInputTFValueMutDic{
    if (!_registerInputTFValueMutDic) {
        _registerInputTFValueMutDic = [NSMutableDictionary dictionaryWithDictionary:self.loginInputTFValueMutDic];
    }return _registerInputTFValueMutDic;
}

-(JobsAppDoorModel *)appDoorModel{
    if (!_appDoorModel) {
        _appDoorModel = JobsAppDoorModel.new;
    }return _appDoorModel;
}

@end
