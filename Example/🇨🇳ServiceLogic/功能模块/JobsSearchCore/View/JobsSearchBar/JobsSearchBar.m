//
//  JobsSearchBar.m
//  JobsSearch
//
//  Created by Jobs on 2020/10/2.
//

#import "JobsSearchBar.h"

@interface JobsSearchBar ()
/// UI
@property(nonatomic,strong)ZYTextField *textField;
@property(nonatomic,strong)UIButton *cancelBtn;
@property(nonatomic,strong)UIImageView *imgView;
@property(nonatomic,strong)JobsAdNoticeView *adNoticeView;

@end

@implementation JobsSearchBar

- (instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = HEXCOLOR(0xF9F9F9);
    }return self;
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
}
#pragma mark —— BaseViewProtocol
-(void)richElementsInViewWithModel:(id _Nullable)model{
    self.textField.alpha = 1;
    self.cancelBtn.alpha = 1;
}
/// 具体由子类进行复写【数据尺寸】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
+(CGSize)viewSizeWithModel:(id _Nullable)model{
    return CGSizeMake(JobsSCREEN_WIDTH, 60);
}
#pragma mark —— JobsDoorInputViewProtocol
-(UITextField *_Nullable)getTextField{
    return _textField;
}
#pragma mark —— 一些私有化方法
//告诉委托人对指定的文本字段停止编辑
- (void)textFieldDidEndEditing{
    [self.textField isEmptyText];
    //用以区分是“取消”触发还是“搜索”触发
    if (self.cancelBtn.selected) {//来自“取消”
        self.textField.text = @"";
        self.cancelBtn.selected = NO;
    }else{//来自“搜索”
        //给定一个字符串 判定 是否在目标数组中，以达到数组元素单一性
        BOOL (^checkArrContainString)(NSArray <NSString *>*arr,
                                      NSString *string) = ^(NSArray <NSString *>*arr,
                                                            NSString *string){
                                          BOOL t = NO;
                                          for (NSString *str in arr) {
                                              if ([str isEqualToString:string]) {
                                                  t = YES;//只要有一个是重复的就赋值YES
                                              }
                                          }return t;
                                      };
        //存数据
        void (^storage)(NSString *storageID,
                        id content,
                        NSMutableArray *container) = ^(NSString *storageID,
                                                       id content,
                                                       NSMutableArray *container){
                            [container addObject:content];
                            
                            UserDefaultModel *userDefaultModel = UserDefaultModel.new;
                            userDefaultModel.obj = container;
                            userDefaultModel.key = storageID;
                            
                            [NSUserDefaults updateWithModel:userDefaultModel];
                            NSLog(@"历史数据已存入");
        };
        
        if (![NSString isNullString:self.textField.text]) {
            //先取值进行对比
            NSArray *jobsSearchHistoryDataArr = (NSArray *)[NSUserDefaults readWithKey:@"JobsSearchHistoryData"];
            if (jobsSearchHistoryDataArr.count) {
                if (!checkArrContainString(jobsSearchHistoryDataArr,self.textField.text)) {
                    //目标数组不存在此字符串，允许存入
                    NSMutableArray *dataMutArr = [NSMutableArray arrayWithArray:jobsSearchHistoryDataArr];
                    storage(@"JobsSearchHistoryData",self.textField.text,dataMutArr);
                }
            }else{
                NSMutableArray *dataMutArr = NSMutableArray.array;
                storage(@"JobsSearchHistoryData",self.textField.text,dataMutArr);
            }
        }
    }
}
#pragma mark —— lazyLoad
-(ZYTextField *)textField{
    if (!_textField) {
        _textField = ZYTextField.new;
        _textField.placeholder = @"请输入搜索内容";
        _textField.delegate = self;
        _textField.leftView = self.imgView;
        _textField.placeHolderAlignment = PlaceHolderAlignmentCenter;
        _textField.textColor = KPurpleColor;
        _textField.inputAccessoryView = self.adNoticeView;
        _textField.leftViewMode = UITextFieldViewModeAlways;
        _textField.backgroundColor = HEXCOLOR(0xFFFFFF);
        _textField.keyboardAppearance = UIKeyboardAppearanceAlert;
        _textField.returnKeyType = UIReturnKeySearch;
        [self addSubview:_textField];
//        _tf.isShowHistoryDataList = YES;//一句代码实现下拉历史列表：这句一定要写在addSubview之后，否则找不到父控件会崩溃
        _textField.frame = CGRectMake(10,
                               10,
                               JobsSCREEN_WIDTH - 20,
                               self.mj_h - 20);
        
        @jobs_weakify(self)
        [[_textField.rac_textSignal filter:^BOOL(NSString * _Nullable value) {
            return YES;
        }] subscribeNext:^(NSString * _Nullable x) {
            @jobs_strongify(self)
            NSLog(@"输入的字符为 = %@",x);
            [self textFieldDidEndEditing];
            if (self.viewBlock) self.viewBlock(x);
        }];
        
        [_textField cornerCutToCircleWithCornerRadius:2];
        [_textField layerBorderColour:kBlueColor andBorderWidth:.05f];
        
    }return _textField;
}

-(UIButton *)cancelBtn{
    if (!_cancelBtn) {
        _cancelBtn = UIButton.new;
        _cancelBtn.backgroundColor = KGreenColor;
        [_cancelBtn normalTitle:@"取消"];
        [_cancelBtn normalTitleColor:HEXCOLOR(0x0F81FE)];
        [self addSubview:_cancelBtn];
        _cancelBtn.frame = CGRectMake(JobsSCREEN_WIDTH - 10,
                                      10,
                                      0,
                                      0);
        [_cancelBtn layerBorderColour:KGreenColor andBorderWidth:1];
        [_cancelBtn cornerCutToCircleWithCornerRadius:8];
        BtnClickEvent(_cancelBtn, if (self.viewBlock) self.viewBlock(self.textField.text);)
    }return _cancelBtn;
}

-(UIImageView *)imgView{
    if (!_imgView) {
        _imgView = UIImageView.new;
        _imgView.image = KIMG(@"放大镜");
    }return _imgView;
}

-(JobsAdNoticeView *)adNoticeView{
    if (!_adNoticeView) {
        _adNoticeView = JobsAdNoticeView.new;
        _adNoticeView.size = [JobsAdNoticeView viewSizeWithModel:nil];
        [_adNoticeView richElementsInViewWithModel:nil];
    }return _adNoticeView;
}

@end
