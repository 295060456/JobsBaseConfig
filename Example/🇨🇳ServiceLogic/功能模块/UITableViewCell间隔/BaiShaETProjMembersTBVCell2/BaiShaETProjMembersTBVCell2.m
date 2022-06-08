//
//  BaiShaETProjMembersTBVCell2.m
//  BaiShaEntertainmentProj
//
//  Created by Jobs on 2022/5/17.
//

#import "BaiShaETProjMembersTBVCell2.h"

@interface BaiShaETProjMembersTBVCell2 (){
    CGFloat btnEachSpacing;
    CGSize btnSize;
}
/// UI
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UIButton *eyeBtn;
@property(nonatomic,strong)UIButton *entryWalletBtn;
@property(nonatomic,strong)JobsUpDownLab *balanceValueLab;
@property(nonatomic,strong)JobsUpDownLab *walletValueLab;
@property(nonatomic,strong)UILabel *line;
@property(nonatomic,strong)UIButton *存;
@property(nonatomic,strong)UIButton *取;
@property(nonatomic,strong)UIButton *转;
/// Data
@property(nonatomic,strong)JobsUpDownLabModel *balanceValueData;
@property(nonatomic,strong)JobsUpDownLabModel *walletValueData;

@end

@implementation BaiShaETProjMembersTBVCell2
#pragma mark —— @synthesize UITableViewCellProtocol
UITableViewCellProtocol_synthesize
#pragma mark —— UITableViewCellProtocol
+(instancetype)cellWithTableView:(UITableView *)tableView{
    BaiShaETProjMembersTBVCell2 *cell = (BaiShaETProjMembersTBVCell2 *)[tableView tableViewCellClass:BaiShaETProjMembersTBVCell2.class];
    if (!cell) {
        cell = [BaiShaETProjMembersTBVCell2 initTableViewCellWithStyle:UITableViewCellStyleDefault];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.offsetXForEach = JobsWidth(8);
//        cell.offsetYForEach = JobsWidth(8);
        [cell cornerCutToCircleWithCornerRadius:JobsWidth(8)];
    }return cell;
}
#pragma mark —— BaseCellProtocol
/// 具体由子类进行复写【数据定UI】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
-(void)richElementsInCellWithModel:(UIViewModel *_Nullable)model{
    btnSize = CGSizeMake(JobsWidth(100), JobsWidth(36));
    btnEachSpacing = (JobsMainScreen_WIDTH() - self.offsetXForEach * 2 - btnSize.width * 3) / 2;
    
    self.titleLab.alpha = 1;
    self.eyeBtn.alpha = 1;
    self.entryWalletBtn.alpha = 1;
    self.line.alpha = 1;
    self.balanceValueLab.alpha = 1;
    self.walletValueLab.alpha = 1;
    self.取.alpha = 1;
    self.存.alpha = 1;
    self.转.alpha = 1;
}
/// 具体由子类进行复写【数据定高】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
+(CGFloat)cellHeightWithModel:(UIViewModel *_Nullable)model{
    return JobsWidth(166);
}
/// 设置Cell的背景图片
-(void)setCellBgImage:(UIImage *)bgImage{
    
}
#pragma mark —— 子类重写父类方法
-(void)setFrame:(CGRect)frame{
    NSLog(@"self.offsetXForEach = %f",self.offsetXForEach);
    NSLog(@"self.offsetYForEach = %f",self.offsetYForEach);
    frame.origin.x += self.offsetXForEach;
    frame.origin.y += self.offsetYForEach;
    frame.size.height -= self.offsetYForEach * 2;
    frame.size.width -= self.offsetXForEach * 2;
    [super setFrame:frame];
}
#pragma mark —— lazyLoad
-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = UILabel.new;
        _titleLab.text = Internationalization(@"我的钱包");
        _titleLab.textColor = HEXCOLOR(0x3D4A58);
        _titleLab.font = [UIFont systemFontOfSize:JobsWidth(16) weight:UIFontWeightRegular];
        [self.contentView addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(JobsWidth(12));
            make.left.equalTo(self.contentView).offset(JobsWidth(12));
        }];
        [_titleLab makeLabelByShowingType:UILabelShowingType_03];
    }return _titleLab;
}

-(UIButton *)eyeBtn{
    if (!_eyeBtn) {
        _eyeBtn = UIButton.new;
        _eyeBtn.normalBackgroundImage = KIMG(@"闭眼");
        _eyeBtn.selectedBackgroundImage = KIMG(@"睁眼");
        [self.contentView addSubview:_eyeBtn];
        [_eyeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(JobsWidth(16), JobsWidth(12)));
            make.centerY.equalTo(self.titleLab);
            make.left.equalTo(self.titleLab.mas_right).offset(JobsWidth(16) + self.offsetXForEach);
        }];
        BtnClickEvent(_eyeBtn, {
            [WHToast toastMsg:Internationalization(@"开眼")];
            x.selected = !x.selected;
        });
    }return _eyeBtn;
}

-(UIButton *)entryWalletBtn{
    if (!_entryWalletBtn) {
        _entryWalletBtn = UIButton.new;
        _entryWalletBtn.normalTitle = Internationalization(@"进入钱包");
        _entryWalletBtn.normalImage = KIMG(@"向右的箭头（大）");
        _entryWalletBtn.titleFont = [UIFont systemFontOfSize:JobsWidth(14) weight:UIFontWeightRegular];
        _entryWalletBtn.normalTitleColor = HEXCOLOR(0x757575);
        [_entryWalletBtn layoutButtonWithEdgeInsetsStyle:GLButtonEdgeInsetsStyleLeft
                                         imageTitleSpace:JobsWidth(16)];
        [self.contentView addSubview:_entryWalletBtn];
        [_entryWalletBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(JobsWidth(56 + 16 + 6), JobsWidth(16)));
            make.centerY.equalTo(self.eyeBtn);
            make.right.equalTo(self.contentView).offset(JobsWidth(-18));
        }];
        
        [_entryWalletBtn makeBtnLabelByShowingType:UILabelShowingType_01];
        [_entryWalletBtn layerBorderColour:HEXCOLOR(0xFFFFFF) andBorderWidth:JobsWidth(1)];
        [_entryWalletBtn layoutButtonWithEdgeInsetsStyle:GLButtonEdgeInsetsStyleRight imageTitleSpace:JobsWidth(9)];
        
        BtnClickEvent(_entryWalletBtn, {
            toast(Internationalization(@"进入钱包"));
        });
    }return _entryWalletBtn;
}

-(UILabel *)line{
    if (!_line) {
        _line = UILabel.new;
        _line.backgroundColor = HEXCOLOR(0xEAEBED);
        [self.contentView addSubview:_line];
        [_line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(JobsWidth(319), JobsWidth(2)));
            make.centerX.equalTo(self.contentView);
            make.top.equalTo(self.entryWalletBtn.mas_bottom).offset(JobsWidth(9));
        }];
    }return _line;
}

-(JobsUpDownLab *)balanceValueLab{
    if (!_balanceValueLab) {
        _balanceValueLab = JobsUpDownLab.new;
        [self.contentView addSubview:_balanceValueLab];
        [_balanceValueLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLab);
            make.top.equalTo(self.line).offset(JobsWidth(20));
        }];
        [_balanceValueLab richElementsInViewWithModel:self.balanceValueData];
    }return _balanceValueLab;
}

-(JobsUpDownLab *)walletValueLab{
    if (!_walletValueLab) {
        _walletValueLab = JobsUpDownLab.new;
        [self.contentView addSubview:_walletValueLab];
        [_walletValueLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_centerX);
            make.top.equalTo(self.line).offset(JobsWidth(20));
        }];
        [_walletValueLab richElementsInViewWithModel:self.walletValueData];
    }return _walletValueLab;
}

-(UIButton *)取{
    if (!_取) {
        _取 = UIButton.new;
        _取.normalTitle = Internationalization(@"取款");
        _取.normalImage = KIMG(@"首页_取款按钮");
        _取.normalTitleColor = HEXCOLOR(0xAE8330);
        _取.titleFont = [UIFont systemFontOfSize:JobsWidth(14) weight:UIFontWeightRegular];
        [self.contentView addSubview:_取];
        [_取 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(btnSize);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(JobsWidth(-7));
            make.centerX.equalTo(self.contentView);
        }];
        [_取 makeBtnLabelByShowingType:UILabelShowingType_01];
        [_取 cornerCutToCircleWithCornerRadius:JobsWidth(8)];
        [_取 layerBorderColour:HEXCOLOR(0xFFFFFF) andBorderWidth:JobsWidth(1)];
        [_取 layoutButtonWithEdgeInsetsStyle:GLButtonEdgeInsetsStyleLeft imageTitleSpace:JobsWidth(9)];
        BtnClickEvent(_取, {
            [WHToast toastMsg:Internationalization(@"取")];
            x.selected = !x.selected;
        });
    }return _取;
}

-(UIButton *)存{
    if (!_存) {
        _存 = UIButton.new;
        _存.normalTitle = Internationalization(@"充值");
        _存.normalImage = KIMG(@"首页_充值按钮");
        _存.normalTitleColor = HEXCOLOR(0xAE8330);
        _存.titleFont = [UIFont systemFontOfSize:JobsWidth(14) weight:UIFontWeightRegular];
        [self.contentView addSubview:_存];
        [_存 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(btnSize);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(JobsWidth(-7));
            make.right.equalTo(self.取.mas_left).offset(-btnEachSpacing);
        }];
        [_存 makeBtnLabelByShowingType:UILabelShowingType_01];
        [_存 cornerCutToCircleWithCornerRadius:JobsWidth(8)];
        [_存 layerBorderColour:HEXCOLOR(0xFFFFFF) andBorderWidth:JobsWidth(1)];
        [_存 layoutButtonWithEdgeInsetsStyle:GLButtonEdgeInsetsStyleLeft imageTitleSpace:JobsWidth(9)];
        BtnClickEvent(_存, {
            [WHToast toastMsg:Internationalization(@"存")];
            x.selected = !x.selected;
        });
    }return _存;
}

-(UIButton *)转{
    if (!_转) {
        _转 = UIButton.new;
        _转.normalTitle = Internationalization(@"转账");
        _转.normalTitleColor = HEXCOLOR(0xAE8330);
        _转.titleFont = [UIFont systemFontOfSize:JobsWidth(14) weight:UIFontWeightRegular];
        _转.normalImage = KIMG(@"个人中心_转账按钮");
        [self.contentView addSubview:_转];
        [_转 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(btnSize);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(JobsWidth(-7));
            make.left.equalTo(self.取.mas_right).offset(btnEachSpacing);
        }];
        [_转 makeBtnLabelByShowingType:UILabelShowingType_01];
        [_转 cornerCutToCircleWithCornerRadius:JobsWidth(8)];
        [_转 layerBorderColour:HEXCOLOR(0xFFFFFF) andBorderWidth:JobsWidth(1)];
        [_转 layoutButtonWithEdgeInsetsStyle:GLButtonEdgeInsetsStyleLeft imageTitleSpace:JobsWidth(9)];
        BtnClickEvent(_转, {
            [WHToast toastMsg:Internationalization(@"转")];
            x.selected = !x.selected;
        });
    }return _转;
}

-(JobsUpDownLabModel *)balanceValueData{
    if (!_balanceValueData) {
        _balanceValueData = JobsUpDownLabModel.new;
        _balanceValueData.upLabText = Internationalization(@"總餘額");
        _balanceValueData.upLabTextAlignment = NSTextAlignmentCenter;
        _balanceValueData.upLabFont = [UIFont systemFontOfSize:JobsWidth(14) weight:UIFontWeightRegular];
        _balanceValueData.upLabTextCor = HEXCOLOR(0x757575);
        _balanceValueData.upLabBgCor = UIColor.clearColor;

        _balanceValueData.downLabText = Internationalization(@"9999999999.00");
        _balanceValueData.downLabTextAlignment = NSTextAlignmentCenter;
        _balanceValueData.downLabFont = [UIFont systemFontOfSize:JobsWidth(18) weight:UIFontWeightRegular];
        _balanceValueData.downLabTextCor = HEXCOLOR(0x3D4A58);
        _balanceValueData.downLabBgCor = UIColor.clearColor;

        _balanceValueData.upLabVerticalAlign = JobsUpDownLabAlign_TopLeft;
        _balanceValueData.upLabLevelAlign = JobsUpDownLabAlign_TopLeft;
        _balanceValueData.downLabVerticalAlign = JobsUpDownLabAlign_TopLeft;
        _balanceValueData.downLabLevelAlign = JobsUpDownLabAlign_TopLeft;

        _balanceValueData.space = JobsWidth(12);
    }return _balanceValueData;
}

-(JobsUpDownLabModel *)walletValueData{
    if (!_walletValueData) {
        _walletValueData = JobsUpDownLabModel.new;
        _walletValueData.upLabText = Internationalization(@"中心錢包");
        _walletValueData.upLabTextAlignment = NSTextAlignmentCenter;
        _walletValueData.upLabFont = [UIFont systemFontOfSize:JobsWidth(14) weight:UIFontWeightRegular];
        _walletValueData.upLabTextCor = HEXCOLOR(0x757575);
        _walletValueData.upLabBgCor = UIColor.clearColor;

        _walletValueData.downLabText = Internationalization(@"9999999999.00");
        _walletValueData.downLabTextAlignment = NSTextAlignmentCenter;
        _walletValueData.downLabFont = [UIFont systemFontOfSize:JobsWidth(18) weight:UIFontWeightRegular];
        _walletValueData.downLabTextCor = HEXCOLOR(0x3D4A58);
        _walletValueData.downLabBgCor = UIColor.clearColor;

        _walletValueData.upLabVerticalAlign = JobsUpDownLabAlign_TopLeft;
        _walletValueData.upLabLevelAlign = JobsUpDownLabAlign_TopLeft;
        _walletValueData.downLabVerticalAlign = JobsUpDownLabAlign_TopLeft;
        _walletValueData.downLabLevelAlign = JobsUpDownLabAlign_TopLeft;

        _walletValueData.space = JobsWidth(12);
    }return _walletValueData;
}

@end
