//
//  JobsIMShowVC.m
//  JobsBaseConfig
//
//  Created by Jobs on 2022/1/13.
//

#import "JobsIMShowVC.h"

@interface JobsIMShowVC ()

@property(nonatomic,strong)UIBarButtonItem *shareBtnItem;
@property(nonatomic,strong)UIButton *shareBtn;
@property(nonatomic,strong)JobsIMListView *listView;

@end

@implementation JobsIMShowVC

- (void)dealloc{
    NSLog(@"%@",JobsLocalFunc);
    //    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)loadView{
    [super loadView];
    
    if ([self.requestParams isKindOfClass:UIViewModel.class]) {
        self.viewModel = (UIViewModel *)self.requestParams;
    }
    
    self.setupNavigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = JobsYellowColor;
    {
        [self setGKNav];
        [self setGKNavBackBtn];
        self.gk_navRightBarButtonItems = @[self.shareBtnItem];
    }
    self.listView.alpha = 1;
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
#pragma mark —— 一些私有方法
-(UIViewModel *)makeData:(JobsIMListDataModel *)data{
    
    JobsIMChatInfoModel *chatInfoModel = JobsIMChatInfoModel.new;
    chatInfoModel.chatTextStr = data.contentStr;
    chatInfoModel.userNameStr = data.usernameStr;
    {
        JobsTimeModel *timeModel = self.makeSpecificTime;
        chatInfoModel.chatTextTimeStr = [NSString stringWithFormat:@"%ld:%ld:%ld",timeModel.currentHour,timeModel.currentMin,timeModel.currentSec];
    }
    chatInfoModel.userIconIMG = data.userHeaderIMG;
    chatInfoModel.identification = @"我是服务器";
    
    UIViewModel *viewModel = UIViewModel.new;
    viewModel.data = chatInfoModel;
    return viewModel;
}
#pragma mark —— lazyLoad
-(JobsIMListView *)listView{
    if (!_listView) {
        _listView = JobsIMListView.new;
        @jobs_weakify(self)
        [_listView richElementsInViewWithModel:nil];
        [_listView actionObjectBlock:^(JobsIMListDataModel *data) {
            @jobs_strongify(self)
            [self comingToPushVC:JobsIMVC.new
                   requestParams:[self makeData:data]];
        }];
        [self.view addSubview:_listView];
        [_listView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.view);
            if (self.gk_navBarAlpha && !self.gk_navigationBar.hidden) {//显示
                make.top.equalTo(self.gk_navigationBar.mas_bottom);
            }else{
                make.top.equalTo(self.view.mas_top);
            }
        }];
    }return _listView;
}

-(UIBarButtonItem *)shareBtnItem{
    if (!_shareBtnItem) {
        _shareBtnItem = [UIBarButtonItem.alloc initWithCustomView:self.shareBtn];
    }return _shareBtnItem;
}

-(UIButton *)shareBtn{
    if (!_shareBtn) {
        _shareBtn = UIButton.new;
        _shareBtn.width = JobsWidth(23);
        _shareBtn.height = JobsWidth(23);
        _shareBtn.normalImage = JobsBuddleIMG(@"⚽️PicResource", @"Others", nil, @"PLUS");
        _shareBtn.normalTitleColor = JobsWhiteColor;
        [_shareBtn cornerCutToCircleWithCornerRadius:23 / 2];
        [_shareBtn btnClickEventBlock:^(id data) {
            toast(Internationalization(@"此功能尚在开发中..."));
        }];
    }return _shareBtn;
}

@end
