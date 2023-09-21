//
//  JobsBaseConfigTestPopupView.m
//  JobsBaseConfig
//
//  Created by Jobs on 2022/5/12.
//

#import "JobsBaseConfigTestPopupView.h"

@interface JobsBaseConfigTestPopupView ()
/// UI
@property(nonatomic,strong)JobsContainerView *containerView;
@property(nonatomic,strong)UIButton *testPopupViewSureBtn;
/// Data
@property(nonatomic,strong)NSMutableArray <JobsBtnModel *>*btnModelMutArr;

@end

@implementation JobsBaseConfigTestPopupView

@synthesize viewModel = _viewModel;

#pragma mark —— 单例化和销毁
+(void)destroySingleton{
    static_testPopupViewOnceToken = 0;
    static_popupView01 = nil;
}

static JobsBaseConfigTestPopupView *static_popupView01 = nil;
static dispatch_once_t static_testPopupViewOnceToken;
+(instancetype)sharedInstance{
    dispatch_once(&static_testPopupViewOnceToken, ^{
        static_popupView01 = JobsBaseConfigTestPopupView.new;
    });return static_popupView01;
}

-(instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = UIColor.whiteColor;
        self.backgroundImageView.image = JobsIMG(@"测试弹窗的背景图");
    }return self;
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
}
#pragma mark —— BaseViewProtocol
/// 具体由子类进行复写【数据定UI】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
-(void)richElementsInViewWithModel:(UIViewModel *_Nullable)model{
    self.viewModel = model;
    self.containerView.alpha = 1;
    self.testPopupViewSureBtn.alpha = 1;
}
/// 具体由子类进行复写【数据尺寸】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
+(CGSize)viewSizeWithModel:(UIViewModel *_Nullable)model{
    return CGSizeMake(JobsWidth(327), JobsWidth(226));
}
#pragma mark —— lazyLoad
-(JobsContainerView *)containerView{
    if(!_containerView){
        _containerView = [JobsContainerView.alloc initWithWidth:JobsWidth(200)
                                                     buttonModels:self.btnModelMutArr];
        _containerView.backgroundColor = UIColor.purpleColor;
        [self addSubview:_containerView];
        [_containerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(_containerView.jobsSize);
            make.center.equalTo(self);
        }];
    }return _containerView;
}

-(NSMutableArray<JobsBtnModel *> *)btnModelMutArr{
    if(!_btnModelMutArr){
        _btnModelMutArr = NSMutableArray.array;
        
        {
            JobsBtnModel *model = JobsBtnModel.new;
            model.backgroundColor = UIColor.grayColor;
//            model.backgroundImage = JobsIMG(@"手机号码");
            model.title = self.viewModel.textModel.text.nullString ? Internationalization(@"测试弹窗"): self.viewModel.textModel.text;
            model.font = UIFontWeightBoldSize(20);
            model.titleColor = UIColor.redColor;
            model.image = JobsIMG(@"手机号码");
            model.imageSize = CGSizeMake(JobsWidth(50), JobsWidth(80));
            model.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
            model.contentSpacing = JobsWidth(2);
            model.lineBreakMode = NSLineBreakByWordWrapping;
            model.btnWidth = JobsWidth(200);

            [_btnModelMutArr addObject:model];
        }
        
        {
            JobsBtnModel *model = JobsBtnModel.new;
            model.backgroundColor = UIColor.yellowColor;
//            model.backgroundImage = JobsIMG(@"手机号码");
            model.title = self.viewModel.subTextModel.text.nullString ? Internationalization(@"相关信息"): self.viewModel.textModel.text;
            model.font = UIFontWeightRegularSize(16);
            model.titleColor = UIColor.greenColor;
            model.image = JobsIMG(@"手机号码");
            model.imageSize = CGSizeMake(JobsWidth(50), JobsWidth(80));
            model.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
            model.contentSpacing = JobsWidth(8);
            model.lineBreakMode = NSLineBreakByWordWrapping;
            model.btnWidth = JobsWidth(200);

            [_btnModelMutArr addObject:model];
        }
        
    }return _btnModelMutArr;
}

-(UIButton *)testPopupViewSureBtn{
    if (!_testPopupViewSureBtn) {
        _testPopupViewSureBtn = UIButton.new;
        [_testPopupViewSureBtn handelAdjustsImageWhenHighlighted];
        _testPopupViewSureBtn.normalBackgroundImage = JobsIMG(@"测试弹窗的确定按钮");
        _testPopupViewSureBtn.selectedBackgroundImage = JobsIMG(@"测试弹窗的确定按钮");
        _testPopupViewSureBtn.normalTitle = Internationalization(@"确定");
        _testPopupViewSureBtn.normalTitleColor = JobsBlackColor;
        _testPopupViewSureBtn.titleFont = UIFontWeightRegularSize(18);
        [self addSubview:_testPopupViewSureBtn];
        [_testPopupViewSureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_bottom).offset(JobsWidth(-15));
            make.centerX.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(JobsWidth(190), JobsWidth(40)));
        }];
        @jobs_weakify(self)
        [_testPopupViewSureBtn btnClickEventBlock:^(UIButton *x) {
            @jobs_strongify(self)
            x.selected = !x.selected;
            [self tf_hide];
            if(self.objectBlock) self.objectBlock(x);
        }];
    }return _testPopupViewSureBtn;
}

@end
