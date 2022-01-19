//
//  JobsAppDoorForgotCodeContentView.m
//  Casino
//
//  Created by Jobs on 2021/11/22.
//

#import "JobsAppDoorForgotCodeContentView.h"

@class JobsAppDoorDoorInputViewBaseStyle;

@interface JobsAppDoorForgotCodeContentView ()
// UI
@property(nonatomic,strong)UILabel *titleLab;// 标题
@property(nonatomic,strong)UIButton *backToLoginBtn;// 返回登录
@property(nonatomic,strong)UIButton *contactCustomerServiceBtn;// 联系客服按钮
@property(nonatomic,strong)UILabel *subTitleLab;// 副标题
@property(nonatomic,strong)JobsHotLabelWithSingleLine *hl;
// Data
//@property(nonatomic,strong)NSMutableArray <UIViewModel *>*hotLabelDataMutArr;
//@property(nonatomic,strong)CasinoCustomerContactModel *customerContactModel;

@end

@implementation JobsAppDoorForgotCodeContentView
#pragma mark - Lifecycle
- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

-(instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = Cor2;
    }return self;
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches
          withEvent:(UIEvent *)event{
    [self endEditing:YES];
}
#pragma mark —— BaseViewProtocol
/// 外层数据渲染
-(void)richElementsInViewWithModel:(id _Nullable)contentViewModel{
    @jobs_weakify(self)
    [self customerContact:^(CasinoCustomerContactModel *data) {
        @jobs_strongify(self)
        self.backToLoginBtn.alpha = 1;
        self.titleLab.alpha = 1;
        self.contactCustomerServiceBtn.alpha = 1;
        if (self.hotLabelDataMutArr.count) {
            self.hl.alpha = 1;
        }
    }];
}
#pragma mark —— 网络请求
/// 获取客服联系方式
-(void)customerContact:(MKDataBlock)block{

}
#pragma mark —— lazyLoad
-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = UILabel.new;
        _titleLab.text = Internationalization(Title10);
        _titleLab.textColor = kWhiteColor;
        _titleLab.font = [UIFont systemFontOfSize:JobsWidth(20)
                                           weight:UIFontWeightRegular];
        [_titleLab sizeToFit];
        [self addSubview:_titleLab];
        _titleLab.centerX = (self.width - self.backToLoginBtn.width) / 2;
        _titleLab.top = JobsWidth(20);
    }return _titleLab;
}

-(UIButton *)backToLoginBtn{
    if (!_backToLoginBtn) {
        _backToLoginBtn = UIButton.new;
        _backToLoginBtn.titleLabel.numberOfLines = 0;
        _backToLoginBtn.backgroundColor = Cor1;
        _backToLoginBtn.titleLabel.font = [UIFont systemFontOfSize:JobsWidth(13)
                                                            weight:UIFontWeightMedium];
        _backToLoginBtn.alpha = 0.7f;
        [_backToLoginBtn normalTitleColor:Cor3];
        [_backToLoginBtn normalTitle:Title1];
        [_backToLoginBtn normalImage:KIMG(@"用户名称")];
        BtnClickEvent(_backToLoginBtn, {
            [self endEditing:YES];
            if (self.viewBlock) self.viewBlock(x);
        });
        [self addSubview:_backToLoginBtn];
        [_backToLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.bottom.equalTo(self);
            make.width.mas_equalTo(btnWidth);
        }];
        
        [self layoutIfNeeded];
        [_backToLoginBtn layoutButtonWithEdgeInsetsStyle:GLButtonEdgeInsetsStyleTop
                                         imageTitleSpace:JobsWidth(8)];
    }return _backToLoginBtn;
}

-(UIButton *)contactCustomerServiceBtn{
    if (!_contactCustomerServiceBtn) {
        _contactCustomerServiceBtn = UIButton.new;
        [_contactCustomerServiceBtn normalImage:KIMG(Internationalization(@"zaixiankefu_en"))];

        BtnClickEvent(_contactCustomerServiceBtn, {
            NSLog(@"返回登录");
            @jobs_strongify(self)
            if ([NSString isNullString:self.customerContactModel.onlineUrl.customerAccount]) {
                [self customerContact:nil];
            }else{
                [NSObject openURL:self.customerContactModel.onlineUrl.customerAccount];
            }
            [self endEditing:YES];
            if (self.viewBlock) self.viewBlock(x);
        });

        [self addSubview:_contactCustomerServiceBtn];
        [_contactCustomerServiceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(JobsWidth(230), JobsWidth(50)));
            make.top.equalTo(self.titleLab.mas_bottom).offset(JobsWidth(15));
            make.centerX.equalTo(self.titleLab);
        }];

    }return _contactCustomerServiceBtn;
}

-(UILabel *)subTitleLab{
    if (!_subTitleLab) {
        _subTitleLab = UILabel.new;
        _subTitleLab.text = Internationalization(Title11);
        _subTitleLab.textAlignment = NSTextAlignmentCenter;
        _subTitleLab.numberOfLines = 0;
        _subTitleLab.textColor = kWhiteColor;
        _subTitleLab.font = [UIFont systemFontOfSize:JobsWidth(12)
                                              weight:UIFontWeightMedium];
        [_subTitleLab sizeToFit];
        [self addSubview:_subTitleLab];
        [_subTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contactCustomerServiceBtn);
            make.top.equalTo(self.contactCustomerServiceBtn.mas_bottom).offset(JobsWidth(56));
            make.width.mas_equalTo(self.width - JobsWidth(80));
        }];
    }return _subTitleLab;
}

-(JobsHotLabelWithSingleLine *)hl{
    if (!_hl) {
        _hl = JobsHotLabelWithSingleLine.new;
        _hl.backgroundColor = kClearColor;
        _hl.labelShowingType = UILabelShowingType_02;
        _hl.elementDefaultSize = CGSizeMake(JobsWidth(46), JobsWidth(46));
        [self actionForHotLabel:_hl];
        [self addSubview:_hl];
        [_hl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.subTitleLab);
            make.top.equalTo(self.subTitleLab.mas_bottom).offset(JobsWidth(29));
            make.size.mas_equalTo(CGSizeMake(JobsWidth(250), JobsWidth(50)));
        }];
        [self layoutIfNeeded];
        [_hl richElementsInViewWithModel:self.hotLabelDataMutArr];
    }return _hl;
}
/**
    在 @interface NSObject (AppTools)<AppToolsProtocol>里
    对下列属性进行统一管理
    @property(nonatomic,strong)NSMutableArray <UIViewModel *>*hotLabelDataMutArr;
    @property(nonatomic,strong)CasinoCustomerContactModel *customerContactModel;
 */
//-(NSMutableArray<UIViewModel *> *)hotLabelDataMutArr{
//    if (!_hotLabelDataMutArr) {
//        _hotLabelDataMutArr = NSMutableArray.array;
//
//        for (CasinoCustomerContactElementModel *element in self.customerContactModel.customerList) {
//            UIViewModel *vm = UIViewModel.new;
//
//            vm.objBindingParams = element;
//            vm.bgImageURLString = [NSObject.BaseUrl stringByAppendingString:element.appIconUrl];
//            vm.text = @"";
//            vm.size = CGSizeMake(JobsWidth(46), JobsWidth(46));
//            vm.offsetXForEach = JobsWidth(46);
//            vm.offsetYForEach = JobsWidth(46);
//            [_hotLabelDataMutArr addObject:vm];
//        }
//
//    }return _hotLabelDataMutArr;
//}

@end

