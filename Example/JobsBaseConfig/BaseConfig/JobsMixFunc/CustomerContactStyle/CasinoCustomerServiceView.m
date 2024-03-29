//
//  CasinoCustomerServiceView.m
//  Casino
//
//  Created by Jobs on 2021/12/24.
//

#import "CasinoCustomerServiceView.h"

@interface CasinoCustomerServiceView ()
/// UI
@property(nonatomic,strong)UILabel *titleLab;// 标题
@property(nonatomic,strong)UIButton *closeBtn;
@property(nonatomic,strong)UIButton *contactCustomerServiceBtn;// 联系客服按钮
@property(nonatomic,strong)UILabel *subTitleLab;// 副标题
@property(nonatomic,strong)UIImageView *leftIMGV;
@property(nonatomic,strong)UIImageView *rightIMGV;
@property(nonatomic,strong)JobsHotLabelWithSingleLine *hl;
/// Data
@property(nonatomic,strong)NSMutableArray <UIViewModel *>*hotLabelDataMutArr;
@property(nonatomic,strong)CasinoCustomerContactModel *customerContactModel;

@end

@implementation CasinoCustomerServiceView

static CasinoCustomerServiceView *static_customerServiceView = nil;
+(instancetype)sharedInstance{
    @synchronized(self){
        if (!static_customerServiceView) {
            static_customerServiceView = CasinoCustomerServiceView.new;
        }
    }return static_customerServiceView;
}

-(instancetype)init{
    if (self = [super init]) {
        self.backgroundImageView.image = JobsIMG(@"客服_背景图");
        [self customerContact];
    }return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self customerContact];
    }return self;
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
}
// BaseViewProtocol
-(void)richElementsInViewWithModel:(NSMutableArray <UIViewModel *>*_Nullable)model{
    
    self.titleLab.alpha = 1;
    self.contactCustomerServiceBtn.alpha = 1;
    self.closeBtn.alpha = 1;
    self.subTitleLab.alpha = 1;
    self.leftIMGV.alpha = 1;
    self.rightIMGV.alpha = 1;
    
    self.hotLabelDataMutArr = model;
    if (self.hotLabelDataMutArr.count) {
        self.hl.alpha = 1;
    }
}

+(CGSize)viewSizeWithModel:(NSArray <UIViewModel *>* _Nullable)model{
    CGFloat h = JobsWidth(162) + [JobsHotLabelWithSingleLine viewSizeWithModel:model].height + JobsWidth(70);
    return CGSizeMake(JobsWidth(345), h);
}
#pragma mark —— 网络请求
/// 获取客服联系方式
-(void)customerContact{

}
#pragma mark —— lazyLoad
-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = UILabel.new;
        _titleLab.text = Internationalization(Title10);
        _titleLab.textColor = HEXCOLOR(0x502600);
        _titleLab.font = [UIFont systemFontOfSize:JobsWidth(20)
                                           weight:UIFontWeightRegular];
        [_titleLab sizeToFit];
        [self.backgroundImageView addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self).offset(JobsWidth(20));
        }];
    }return _titleLab;
}

-(UIButton *)contactCustomerServiceBtn{
    if (!_contactCustomerServiceBtn) {
        _contactCustomerServiceBtn = UIButton.new;
        _contactCustomerServiceBtn.normalImage = JobsIMG(Internationalization(@"zaixiankefu_en"));
        @jobs_weakify(self)
        [_contactCustomerServiceBtn jobsBtnClickEventBlock:^id(UIButton *x) {
            NSLog(@"返回登录");
            @jobs_strongify(self)
            if (self.customerContactModel.onlineUrl.customerAccount.nullString) {
                [self customerContact];/// 获取客服联系方式
            }else{
                [self jobsOpenURL:self.customerContactModel.onlineUrl.customerAccount];
            }
            [self endEditing:YES];
            if (self.objectBlock) self.objectBlock(x);
            return nil;
        }];
        [self.backgroundImageView addSubview:_contactCustomerServiceBtn];
        [_contactCustomerServiceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(JobsWidth(150), JobsWidth(38)));
            make.top.equalTo(self.titleLab.mas_bottom).offset(JobsWidth(12));
            make.centerX.equalTo(self.titleLab);
        }];

    }return _contactCustomerServiceBtn;
}

-(UIButton *)closeBtn{
    if (!_closeBtn) {
        _closeBtn = UIButton.new;
        [_closeBtn normalBackgroundImage:JobsIMG(@"客服_关闭按钮")];
        @jobs_weakify(self)
        [_closeBtn jobsBtnClickEventBlock:^id(UIButton *x) {
            @jobs_strongify(self)
            if(self.objectBlock) self.objectBlock(x);
            return nil;
        }];
        [self.backgroundImageView addSubview:_closeBtn];
        [_closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(JobsWidth(24), JobsWidth(24)));
            make.right.equalTo(self).offset(JobsWidth(-20));
            make.top.equalTo(self).offset(JobsWidth(20));
        }];
    }return _closeBtn;
}

-(UILabel *)subTitleLab{
    if (!_subTitleLab) {
        _subTitleLab = UILabel.new;
        _subTitleLab.text = Internationalization(Title11);
        _subTitleLab.textAlignment = NSTextAlignmentCenter;
        _subTitleLab.numberOfLines = 0;
        _subTitleLab.textColor = HEXCOLOR(0x502600);
        _subTitleLab.font = UIFontWeightMediumSize(12);
        [_subTitleLab sizeToFit];
        [self addSubview:_subTitleLab];
        [_subTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contactCustomerServiceBtn);
            make.top.equalTo(self.contactCustomerServiceBtn.mas_bottom).offset(JobsWidth(23));
            make.left.equalTo(self).offset(JobsWidth(15));
            make.right.equalTo(self).offset(JobsWidth(-15));
        }];
    }return _subTitleLab;
}

-(JobsHotLabelWithSingleLine *)hl{
    if (!_hl) {
        _hl = JobsHotLabelWithSingleLine.new;
        _hl.backgroundColor = JobsClearColor;
        _hl.labelShowingType = UILabelShowingType_02;
        _hl.elementDefaultSize = CGSizeMake(JobsWidth(43), JobsWidth(43));
        [self actionForHotLabel:_hl];
        [self addSubview:_hl];
        [_hl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self.subTitleLab.mas_bottom).offset(JobsWidth(13));
            make.size.mas_equalTo([JobsHotLabelWithSingleLine viewSizeWithModel:self.hotLabelDataMutArr]);
        }];
        [self layoutIfNeeded];
        [_hl richElementsInViewWithModel:self.hotLabelDataMutArr];
    }return _hl;
}

-(UIImageView *)leftIMGV{
    if (!_leftIMGV) {
        _leftIMGV = UIImageView.new;
        _leftIMGV.image = JobsIMG(@"客服_左线");
        [self addSubview:_leftIMGV];
        [_leftIMGV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(JobsWidth(51.6), JobsWidth(1)));
            make.centerY.equalTo(self.subTitleLab);
            make.right.equalTo(self.subTitleLab).offset(JobsWidth(-5));
        }];
    }return _leftIMGV;
}

-(UIImageView *)rightIMGV{
    if (!_rightIMGV) {
        _rightIMGV = UIImageView.new;
        _rightIMGV.image = JobsIMG(@"客服_右线");
        [self addSubview:_rightIMGV];
        [_rightIMGV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(JobsWidth(51.6), JobsWidth(1)));
            make.centerY.equalTo(self.subTitleLab);
            make.left.equalTo(self.subTitleLab).offset(JobsWidth(5));
        }];
    }return _rightIMGV;
}

@end
