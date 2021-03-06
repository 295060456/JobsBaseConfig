//
//  JobsMsgDetailVC.m
//  BaiShaEntertainmentProj
//
//  Created by Jobs on 2022/6/7.
//

#import "JobsMsgDetailVC.h"

@interface JobsMsgDetailVC ()
/// UI
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UILabel *subTitleLab;
@property(nonatomic,strong)UIButton *drawBtn;
@property(nonatomic,strong)UILabel *lineLab;
@property(nonatomic,strong)UITextView *textView;
@property(nonatomic,strong)UIButton *deleteBtn;
/// Data
@property(nonatomic,strong)JobsUpDownLabModel *upDownLabModel;
@property(nonatomic,strong)JobsMsgDataModel *msgDataModel;

@end

@implementation JobsMsgDetailVC

- (void)dealloc{
    NSLog(@"%@",JobsLocalFunc);
    //    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)loadView{
    [super loadView];
    
    if ([self.requestParams isKindOfClass:UIViewModel.class]) {
        self.viewModel = (UIViewModel *)self.requestParams;
        self.msgDataModel = self.viewModel.data;
    }
    self.setupNavigationBarHidden = YES;
    
    self.viewModel.backBtnTitleModel.text = @"";
    self.viewModel.textModel.textCor = HEXCOLOR(0x3D4A58);
    self.viewModel.textModel.text = Internationalization(@"消息详情页");
    self.viewModel.textModel.font = notoSansBold(16);
    
    self.bgImage = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setGKNav];
    [self setGKNavBackBtn];
    self.gk_navRightBarButtonItems = @[[UIBarButtonItem.alloc initWithCustomView:self.deleteBtn]];
    
    self.titleLab.alpha = 1;
    self.subTitleLab.alpha = 1;
    self.drawBtn.alpha = 1;
    self.lineLab.alpha = 1;
    self.textView.alpha = 1;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    NSLog(@"");
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    NSLog(@"");
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}
#pragma mark —— lazyLoad
-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab = UILabel.new;
        _titleLab.text = self.msgDataModel.textModel.text;
        _titleLab.font = notoSansBold(16);
        _titleLab.textColor = HEXCOLOR(0x3D4A58);
        [self.view addSubview:_titleLab];
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.gk_navigationBar.mas_bottom).offset(JobsWidth(28));
            make.left.equalTo(self.view).offset(JobsWidth(16));
            make.width.mas_equalTo(JobsWidth(217));
        }];
        [_titleLab makeLabelByShowingType:UILabelShowingType_05];
    }return _titleLab;
}

-(UILabel *)subTitleLab{
    if (!_subTitleLab) {
        _subTitleLab = UILabel.new;
        _subTitleLab.font = notoSansRegular(12);
        _subTitleLab.text = self.msgDataModel.time;
        _subTitleLab.textColor = HEXCOLOR(0xB0B0B0);
        [self.view addSubview:_subTitleLab];
        [_subTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLab.mas_bottom).offset(JobsWidth(12));
            make.left.equalTo(self.titleLab);
        }];
        [_subTitleLab makeLabelByShowingType:UILabelShowingType_01];
    }return _subTitleLab;
}

-(UIButton *)drawBtn{
    if (!_drawBtn) {
        _drawBtn = UIButton.new;
        _drawBtn.normalTitle = self.msgDataModel.isDraw ? Internationalization(@"  已领取  ") : Internationalization(@"  领取  ");
        _drawBtn.normalTitleColor = HEXCOLOR(0xAE8330);
        _drawBtn.selectedTitleColor = HEXCOLOR(0x757575);
        _drawBtn.backgroundColor = HEXCOLOR(0xFFEABA);
        _drawBtn.titleFont = notoSansRegular(12);
        [self.view addSubview:_drawBtn];
        [_drawBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(JobsWidth(40), JobsWidth(20)));
            make.right.equalTo(self.view).offset(JobsWidth(-16));
            make.top.equalTo(self.view).offset(JobsWidth(28));
        }];
    }return _drawBtn;
}

-(UILabel *)lineLab{
    if (!_lineLab) {
        _lineLab = UILabel.new;
        _lineLab.backgroundColor = HEXCOLOR(0xEAEBED);
        [self.view addSubview:_lineLab];
        [_lineLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(JobsWidth(343), JobsWidth(2)));
            make.centerX.equalTo(self.view);
            make.top.equalTo(self.subTitleLab.mas_bottom).offset(JobsWidth(24));
        }];
    }return _lineLab;
}

-(UITextView *)textView{
    if (!_textView) {
        _textView = UITextView.new;
        _textView.text = self.msgDataModel.subTextModel.text;
        _textView.textColor = HEXCOLOR(0xB0B0B0);
        _textView.font = notoSansRegular(14);
        [self.view addSubview:_textView];
        [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view);
            make.top.equalTo(self.lineLab.mas_bottom).offset(JobsWidth(20));
            make.size.mas_equalTo(CGSizeMake(JobsWidth(343), JobsWidth(452)));
        }];
    }return _textView;
}

-(UIButton *)deleteBtn{
    if (!_deleteBtn) {
        _deleteBtn = UIButton.new;
        _deleteBtn.normalTitle = Internationalization(@"删除");
        _deleteBtn.titleFont = notoSansRegular(12);
        _deleteBtn.normalTitleColor = HEXCOLOR(0x3D4A58);
        @jobs_weakify(self)
        [_deleteBtn btnClickEventBlock:^(UIButton *x) {
            @jobs_strongify(self)
            [self backBtnClickEvent:x];
            if (self.objectBlock) self.objectBlock(self.msgDataModel);
        }];
    }return _deleteBtn;
}

@end

