//
//  BaiShaETProjMembersBoardView.m
//  BaiShaEntertainmentProj
//
//  Created by Jobs on 2022/5/16.
//

#import "BaiShaETProjMembersBoardView.h"

@interface BaiShaETProjMembersBoardView ()
/// UI
@property(nonatomic,strong)UIImageView *userIconIMGV;
@property(nonatomic,strong)UILabel *userNameLab;
@property(nonatomic,strong)UIButton *editBtn;
@property(nonatomic,strong)UIView *viewer;
@property(nonatomic,strong)UIButton *userRankBtn;
@property(nonatomic,strong)UILabel *rankProcessLab;
@property(nonatomic,strong)UIButton *rankProcessValueBtn;
/// Data

@end

@implementation BaiShaETProjMembersBoardView

@synthesize viewModel = _viewModel;

-(instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = UIColor.whiteColor;
    }return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = UIColor.whiteColor;
        [self layerBorderCor:UIColor.whiteColor andBorderWidth:JobsWidth(2)];
    }return self;
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
}

-(void)layoutSubviews{
    [super layoutSubviews];
}
#pragma mark —— BaseViewProtocol
/// 具体由子类进行复写【数据定UI】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
-(void)richElementsInViewWithModel:(UIViewModel *_Nullable)model{
    self.viewModel = model ? : UIViewModel.new;
    MakeDataNull
    self.userIconIMGV.alpha = 1;
    self.userNameLab.alpha = 1;
    self.editBtn.alpha = 1;
    self.userRankBtn.alpha = 1;
    self.rankProcessValueBtn.alpha = 1;
    self.rankProcessLab.alpha = 1;
}
/// 具体由子类进行复写【数据尺寸】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
+ (CGRect)viewFrameWithModel:(UIViewModel *)model{
    return CGRectMake(0, 0, JobsMainScreen_WIDTH(), JobsWidth(39 + 64));
}
#pragma mark —— lazyLoad
-(UIImageView *)userIconIMGV{
    if (!_userIconIMGV) {
        _userIconIMGV = UIImageView.new;
        _userIconIMGV.image = JobsIMG(@"默认头像");
        [self addSubview:_userIconIMGV];
        [_userIconIMGV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(JobsWidth(64), JobsWidth(64)));
            make.top.equalTo(self).offset(JobsWidth(19));
            make.left.equalTo(self).offset(JobsWidth(15));
        }];
        [_userIconIMGV cornerCutToCircleWithCornerRadius:JobsWidth(32)];
        [_userIconIMGV layerBorderCor:HEXCOLOR(0xC4C4C4) andBorderWidth:JobsWidth(1)];
    }return _userIconIMGV;
}

-(UILabel *)userNameLab{
    if (!_userNameLab) {
        _userNameLab = UILabel.new;
        _userNameLab.text = Internationalization([NSString stringWithFormat:@"Hi~,%@",@"13711112222"]);
        _userNameLab.textColor = HEXCOLOR(0x3D4A58);
        _userNameLab.font = UIFontWeightMediumSize(20);
        _userNameLab.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_userNameLab];
        [_userNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.userIconIMGV);
            make.left.equalTo(self.userIconIMGV.mas_right).offset(JobsWidth(16));
        }];
        [_userNameLab makeLabelByShowingType:UILabelShowingType_03];
    }return _userNameLab;
}

-(UIButton *)editBtn{
    if (!_editBtn) {
        _editBtn = UIButton.new;
        _editBtn.normalTitle = Internationalization(@"编辑");
        _editBtn.normalTitleColor = HEXCOLOR(0xC4C4C4);
        _editBtn.titleFont = UIFontWeightRegularSize(14);
        [self addSubview:_editBtn];
        [_editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(JobsWidth(59), JobsWidth(20)));
            make.left.equalTo(self.userNameLab.mas_right).offset(15);
            make.centerY.equalTo(self.userNameLab);
        }];
        [_editBtn cornerCutToCircleWithCornerRadius:JobsWidth(JobsWidth(10))];
        [_editBtn layerBorderCor:HEXCOLOR(0xC4C4C4) andBorderWidth:JobsWidth(1)];
        [_editBtn btnClickEventBlock:^(id data) {
            toast(Internationalization(@"编辑"));
        }];
    }return _editBtn;
}

-(UIButton *)userRankBtn{
    if (!_userRankBtn) {
        _userRankBtn = UIButton.new;
        _userRankBtn.normalTitle = Internationalization(@" VIP 1");
        _userRankBtn.normalTitleColor = HEXCOLOR(0xAE8330);
        _userRankBtn.normalImage = JobsIMG(@"用户等级_皇冠");
        _userRankBtn.backgroundColor = HEXCOLOR(0xFFEABA);
        _userRankBtn.titleFont = UIFontWeightRegularSize(14);
        [self addSubview:_userRankBtn];
        [_userRankBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(JobsWidth(64), JobsWidth(20)));
            make.left.equalTo(self.userIconIMGV.mas_right).offset(JobsWidth(16));
            make.top.equalTo(self.userIconIMGV).offset(JobsWidth(45));
        }];
        [_userRankBtn cornerCutToCircleWithCornerRadius:JobsWidth(JobsWidth(10))];
        [_userRankBtn layerBorderCor:UIColor.whiteColor andBorderWidth:JobsWidth(1)];
        @jobs_weakify(self)
        [_userRankBtn btnClickEventBlock:^(UIButton *x) {
            @jobs_strongify(self)
            if (self.objectBlock) self.objectBlock(x);
        }];
    }return _userRankBtn;
}

-(UIButton *)rankProcessValueBtn{
    if (!_rankProcessValueBtn) {
        _rankProcessValueBtn = UIButton.new;
        _rankProcessValueBtn.normalTitle = Internationalization(@"50% ");
        _rankProcessValueBtn.normalTitleColor = HEXCOLOR(0x757575);
        _rankProcessValueBtn.normalImage = JobsIMG(@"向右的箭头（小）");
        _rankProcessValueBtn.titleFont = UIFontWeightRegularSize(14);
        [self addSubview:_rankProcessValueBtn];
        [_rankProcessValueBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(28 + 6 + 14, JobsWidth(14)));
            make.right.equalTo(self).offset(JobsWidth(-22));
            make.centerY.equalTo(self.userRankBtn);
        }];
        [_rankProcessValueBtn layoutButtonWithEdgeInsetsStyle:GLButtonEdgeInsetsStyleRight imageTitleSpace:JobsWidth(14)];
    }return _rankProcessValueBtn;
}

-(UILabel *)rankProcessLab{
    if (!_rankProcessLab) {
        _rankProcessLab = UILabel.new;
        _rankProcessLab.text = Internationalization(@"晉級程度");
        _rankProcessLab.textColor = HEXCOLOR(0xC4C4C4);
        _rankProcessLab.font = UIFontWeightRegularSize(14);
        [self addSubview:_rankProcessLab];
        [_rankProcessLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.rankProcessValueBtn.mas_left).offset(JobsWidth(-8));
            make.centerY.equalTo(self.userRankBtn);
        }];
    }return _rankProcessLab;
}

@end
 
