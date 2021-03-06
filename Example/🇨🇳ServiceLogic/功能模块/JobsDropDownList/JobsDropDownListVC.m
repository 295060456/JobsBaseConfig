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
@property(nonatomic,strong)UISwitch *switcher;
/// Data
@property(nonatomic,strong)NSMutableArray <UIViewModel *>*listViewData;
@property(nonatomic,strong)UIColor *cor;
@property(nonatomic,assign)JobsDropDownListViewDirection dropDownListViewDirection;

@end

@implementation JobsDropDownListVC

- (void)dealloc{
    NSLog(@"%@",JobsLocalFunc);
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
    self.switcher.alpha = 1;
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
    [_dropDownListView dropDownListViewDisappear:nil];
    _dropDownListView = nil;
}
#pragma mark —— lazyLoad
-(UIButton *)btn{
    if (!_btn) {
        _btn = UIButton.new;
        _btn.normalTitle = Internationalization(@"点击按钮弹出下拉列表");
        _btn.titleFont = UIFontWeightRegularSize(12);
        _btn.normalTitleColor = JobsWhiteColor;
        @jobs_weakify(self)
        [_btn btnClickEventBlock:^(UIButton *x) {
            @jobs_strongify(self)
            NSLog(@"AAA = %@",self.dropDownListView);
            x.selected = !x.selected;
            if (x.selected) {
                /// ❤️只能让它执行一次❤️
                self.dropDownListView = [self motivateFromView:x
                                 jobsDropDownListViewDirection:self.dropDownListViewDirection
                                                          data:self.listViewData
                                            motivateViewOffset:JobsWidth(5)
                                                   finishBlock:^(UIViewModel *data) {
                    NSLog(@"data = %@",data);
                }];
            }else{
                [self endDropDownListView];
            }
        }];
        _btn.backgroundColor = UIColor.orangeColor;
        [_btn buttonAutoWidthByFont];

        [self.view addSubview:_btn];
        [_btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.view);
        }];
        [_btn layoutIfNeeded];
        [_btn cornerCutToCircleWithCornerRadius:JobsWidth(8)];
    }return _btn;
}

-(UISwitch *)switcher{
    if (!_switcher) {
        _switcher = UISwitch.new;
        [self.view addSubview:_switcher];
        _switcher.selected = NO;
        _switcher.thumbTintColor = _switcher.selected ? self.cor : HEXCOLOR(0xB0B0B0);
        _switcher.tintColor = UIColor.whiteColor;
        _switcher.onTintColor = HEXCOLOR(0xFFFCF7);
        _switcher.backgroundColor = UIColor.whiteColor;
        [_switcher cornerCutToCircleWithCornerRadius:31 / 2];
        [_switcher mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.gk_navigationBar.mas_bottom);
            make.left.equalTo(self.view).offset(JobsWidth(16));
        }];
        [_switcher layerBorderColour:_switcher.selected ? self.cor : HEXCOLOR(0xB0B0B0) andBorderWidth:JobsWidth(1)];
        @jobs_weakify(self)
        [_switcher switchClickEventBlock:^(UISwitch *x) {
            @jobs_strongify(self)
            x.selected = !x.selected;
            self.btn.selected = !self.btn.selected;
            [self endDropDownListView];
            x.thumbTintColor = x.selected ? self.cor : HEXCOLOR(0xB0B0B0);
            [x layerBorderColour:x.selected ? self.cor : HEXCOLOR(0xB0B0B0) andBorderWidth:JobsWidth(1)];
//            toast(x.selected ? Internationalization(@"打开解锁"):Internationalization(@"关闭解锁"));
            self.dropDownListViewDirection = x.selected;
            self->_btn.normalTitle = x.selected ? Internationalization(@"点击按钮弹出上拉列表") : Internationalization(@"点击按钮弹出下拉列表");
        }];
    }return _switcher;
}

-(UIColor *)cor{
    if (!_cor) {
        _cor = [UIColor gradientCorDataMutArr:[NSMutableArray arrayWithArray:@[HEXCOLOR(0xE9C65D),HEXCOLOR(0xDDAA3A)]]
                                   startPoint:CGPointZero
                                     endPoint:CGPointZero
                                       opaque:NO
                               targetViewRect:CGRectMake(0, 0, 51, 31)];
    }return _cor;
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
