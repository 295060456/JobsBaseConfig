//
//  HotLabel.m
//  JobsSearch
//
//  Created by Jobs on 2020/10/4.
//

#import "JobsHotLabel.h"

@interface JobsHotLabel (){
    CGSize btnSize;
}
/// UI
@property(nonatomic,strong)UIScrollView *scrollView;//所有控件加在这上面
@property(nonatomic,strong)NSMutableArray <UIButton *>*btnMutArr;
/// Data
@property(nonatomic,assign)CGFloat X;//如果加载了下一个btn，那么直到他的尾巴处的x值，记住包含两边固有的间距进行比较
@property(nonatomic,assign)int row;
@property(nonatomic,assign)CGFloat hotLabelHeight;

@end

static dispatch_once_t JobsHotLabelDispatchOnce;
@implementation JobsHotLabel

-(void)dealloc{
    JobsHotLabelDispatchOnce = 0;
}

-(instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = HEXCOLOR(0xFFFFFF);
        JobsHotLabelDispatchOnce = 0;
    }return self;
}
/// 必须有frame的前提下才会进行绘制
-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    dispatch_once(&JobsHotLabelDispatchOnce, ^{
        self.scrollView.alpha = 1;
        [self createHotLabelWithArr:self.viewModelDataArr];
    });
}
#pragma mark —— BaseViewProtocol
/// 具体由子类进行复写【数据尺寸】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
+(CGSize)viewSizeWithModel:(NSArray <UIViewModel *>* _Nullable)model{
    return CGSizeMake(KWidth(46 * 3 + 59 * 2), [self lineNum:3 byData:model] * KWidth(46 + 7));
}
#pragma mark —— 一些私有方法
-(void)changeButtonState{
    for (UIButton *btn in self.btnMutArr) {
        btn.selected = NO;
    }
}

-(void)createHotLabelWithArr:(NSArray <UIViewModel *>*)dataArr{
    if (dataArr.count) {
        for (UIViewModel *vm in dataArr) {
            self.viewModel = vm;
            // 其实item是button,因为button有相对于Label更为丰富的表现形式
            UIButton *btn = UIButton.new;
            btn.selected = self.viewModel.selected;
            btn.objBindingParams = vm.objBindingParams;
            if ([btn.objBindingParams isKindOfClass:CasinoCustomerContactElementModel.class]) {
                CasinoCustomerContactElementModel *customerContactElementModel = (CasinoCustomerContactElementModel *)btn.objBindingParams;
                
                UIImage *bgImg = nil;
                switch (customerContactElementModel.customerMark) {
                    case CustomerContactStyle_QQ:{
                        bgImg = vm.bgImage ? : KIMG(@"service_qq");
                    }break;
                    case CustomerContactStyle_Skype:{
                        bgImg = vm.bgImage ? : KIMG(@"service_skype");
                    }break;
                    case CustomerContactStyle_Telegram:{
                        bgImg = vm.bgImage ? : KIMG(@"service_telegram");
                    }break;
                    case CustomerContactStyle_whatsApp:{
                        bgImg = vm.bgImage ? : KIMG(@"service_meiqia");//???
                    }break;
                    case CustomerContactStyle_手机号码:{
                        bgImg = vm.bgImage ? : KIMG(@"service_meiqia");//???
                    }break;
                    case CustomerContactStyle_onlineURL:{
                        bgImg = vm.bgImage ? : KIMG(@"service_meiqia");//???
                    }break;
                        
                    default:
                        break;
                }
                
                [btn sd_setBackgroundImageWithURL:[NSURL URLWithString:vm.bgImageURLString]
                                         forState:UIControlStateNormal
                                 placeholderImage:bgImg];
            }else{
                [btn normalBackgroundImage:vm.bgImage];
                [btn selectedBackgroundImage:vm.bgSelectedImage];
            }
            
            [btn normalTitle:vm.text];
            [btn titleFont:vm.font];
            [btn normalTitleColor:vm.textCor];
            [btn buttonAutoWidthByFont];
            
            // 手动计算出的Button的size
            [btn buttonAutoFontByWidth];
            CGSize BtnSize = [UILabel sizeWithText:vm.text
                                              font:vm.font
                                           maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
            
            if (CGSizeEqualToSize(vm.size, CGSizeZero)) {
                btnSize = BtnSize;
            }else{
                // 两项比较取最大值。防止多语言化的时候，外文显示过长的问题
                btnSize = CGSizeMake(MAX(BtnSize.width, vm.size.width), MAX(BtnSize.height, vm.size.height));
            }
            
            NSLog(@"btnSize.width = %f,btnSize.height = %f",btnSize.width,btnSize.height);
            BtnClickEvent(btn, {
                [self changeButtonState];
                x.selected = !x.selected;
                if (self.viewBlock) self.viewBlock(x);
            });
            [self.scrollView addSubview:btn];
            if (self.btnMutArr.count) {
                self.X += btnSize.width + vm.offsetXForEach;
                NSLog(@"self.X = %f",self.X);
                [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                    UIButton *lastBtn = (UIButton *)self.btnMutArr.lastObject;
                    if (self.X <= self.mj_w - self.left + vm.width) {//在本行排列
                        make.top.equalTo(lastBtn);
                        make.left.equalTo(lastBtn.mas_right).offset(vm.offsetXForEach);
                    }else{//换行从头排列
                        
                        self.row += 1;
                        self.X = self.left + btnSize.width;//换行了 self.X 重置
                        
                        make.top.equalTo(lastBtn.mas_bottom).offset(vm.offsetYForEach);
                        make.left.equalTo(self).offset(self.left);
                    }
                    
                    make.size.mas_equalTo(btnSize);
                    
                }];
            }else{//第一次
                self.X = self.left + (btnSize.width + vm.offsetXForEach);
                self.row = 1;
                [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self).offset(self.top);
                    make.left.equalTo(self).offset(self.left);
                    make.size.mas_equalTo(btnSize);
                }];
            }
            [UIView cornerCutToCircleWithView:btn andCornerRadius:vm.cornerRadius];
            [self.btnMutArr addObject:btn];
        }
        
        self.hotLabelHeight = self.top * 2 + btnSize.height * self.row + (self.row - 1) * self.viewModel.offsetYForEach;
        
        NSLog(@"self.hotLabelHeight = %f",self.hotLabelHeight);
        NSLog(@"self.row = %d",self.row);
        
        [NSNotificationCenter.defaultCenter postNotificationName:reuseIdentifier(self.class)
                                                          object:nil
                                                        userInfo:@{@"hotLabelHeight":@(self.hotLabelHeight)}];
    }
}

-(CGFloat)heightForHotLabel{
    return self.hotLabelHeight;
}
#pragma mark —— lazyLoad
-(NSMutableArray<UIButton *> *)btnMutArr{
    if (!_btnMutArr) {
        _btnMutArr = NSMutableArray.array;
    }return _btnMutArr;
}

-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = UIScrollView.new;
        [self addSubview:_scrollView];
        [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }return _scrollView;
}

-(CGFloat)top{
    if (_top == 0) {
        _top = 5;
    }return _top;
}

-(CGFloat)left{
    if (_left == 0) {
        _left = 5;
    }return _left;
}

@end
