//
//  JobsDropDownListVC.m
//  JobsBaseConfig
//
//  Created by Jobs on 2022/1/26.
//

#import "JobsDropDownListVC.h"

@interface JobsDropDownListVC ()
/// UI
@property(nonatomic,strong)JobsDropDownListView *dropDownListView;
@property(nonatomic,strong)UIButton *btn;
@property(nonatomic,strong)UITextField *textField;
/// Data
@property(nonatomic,strong)NSMutableArray <UIViewModel *>*listViewData;

@end

@implementation JobsDropDownListVC

- (void)dealloc{
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
    //    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self endDropDownListView];
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
    [self setGKNav];
    [self setGKNavBackBtn];
    
    self.btn.alpha = 1;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    /// 加在这里，否则要停顿一秒左右才移除
    [self endDropDownListView];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches
          withEvent:(UIEvent *)event{
    [self endDropDownListView];
}
#pragma mark —— 一些私有化方法
/// 移除掉这个下拉列表
-(void)endDropDownListView{
    [_dropDownListView dropDownListViewDisappear];
    _dropDownListView = nil;
}
#pragma mark —— lazyLoad
-(UIButton *)btn{
    if (!_btn) {
        _btn = UIButton.new;
        [_btn normalTitle:Internationalization(@"点击按钮弹出下拉列表")];
        [_btn titleFont:[UIFont systemFontOfSize:JobsWidth(12) weight:UIFontWeightRegular]];
        [_btn normalTitleColor:UIColor.whiteColor];
        _btn.backgroundColor = UIColor.orangeColor;
        [_btn buttonAutoWidthByFont];
        BtnClickEvent(_btn, {
            NSLog(@"AAA = %@",self.dropDownListView);
            x.selected = !x.selected;
            if (x.selected) {
                /// ❤️只能让它执行一次❤️
                self.dropDownListView = [self motivateFromView:x
                                                          data:self.listViewData
                                            motivateViewOffset:JobsWidth(5)
                                                   finishBlock:^(UIViewModel *data) {
                    NSLog(@"data = %@",data);
                }];
            }else{
                [self endDropDownListView];
            }
        });
        [self.view addSubview:_btn];
        [_btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view).offset(JobsWidth(20));
            make.top.equalTo(self.gk_navigationBar.mas_bottom).offset(JobsWidth(30));
        }];
        [_btn layoutIfNeeded];
        [_btn cornerCutToCircleWithCornerRadius:JobsWidth(8)];
    }return _btn;
}

-(NSMutableArray<UIViewModel *> *)listViewData{
    if (!_listViewData) {
        _listViewData = NSMutableArray.new;

        for (int i = 1; i <= 9; i++) {
            UIViewModel *viewModel = UIViewModel.new;
            viewModel.textModel.text = Internationalization([NSString stringWithFormat:@"0%d",i]);
            viewModel.subTextModel.text = Internationalization([NSString stringWithFormat:@"00%d",i]);
            
            [_listViewData addObject:viewModel];
        }
        
    }return _listViewData;
}

@end
