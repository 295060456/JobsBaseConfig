//
//  JobsDataShowBackView.m
//  BaiShaEntertainmentProj
//
//  Created by Jobs on 2022/5/13.
//

#import "JobsDataShowBackView.h"

@interface JobsDataShowBackView ()
/// UI
@property(nonatomic,strong)UITableView *tableView;
/// Data
@property(nonatomic,strong)NSMutableArray <UIViewModel *>*dataMutArr;
@property(nonatomic,strong)NSMutableArray <NSString *>*richTextDataMutArr;

@end

@implementation JobsDataShowBackView

@synthesize viewModel = _viewModel;

#pragma mark —— BaseProtocol
/// 单例化和销毁
+(void)destroySingleton{
    static_showBackViewOnceToken = 0;
    static_showBackView = nil;
}

static JobsDataShowBackView *static_showBackView = nil;
static dispatch_once_t static_showBackViewOnceToken;
+(instancetype)sharedInstance{
    dispatch_once(&static_showBackViewOnceToken, ^{
        static_showBackView = JobsDataShowBackView.new;
    });return static_showBackView;
}

-(instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = UIColor.clearColor;
        self.backgroundImageView.image = JobsIMG(@"弹窗数据承接底图");
    }return self;
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
}
#pragma mark —— BaseViewProtocol
/// 具体由子类进行复写【数据定UI】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
-(void)richElementsInViewWithModel:(JobsUpDownLabModel *_Nullable)model{
    self.viewModel = model ? : UIViewModel.new;
    MakeDataNull
    self.tableView.alpha = 1;

}
/// 具体由子类进行复写【数据尺寸】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
+(CGSize)viewSizeWithModel:(JobsUpDownLabModel *_Nullable)model{
    return CGSizeMake(JobsWidth(303), JobsWidth(84));
}
#pragma mark —— UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return JobsWidth(84 / 3);
}

- (NSInteger)tableView:(UITableView *)tableView
numberOfRowsInSection:(NSInteger)section{
    return self.dataMutArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BaseTableViewCell *cell = [BaseTableViewCell cellStyleValue1WithTableView:self.tableView];
    [cell richElementsInCellWithModel:self.dataMutArr[indexPath.row]];
    return cell;
}
#pragma mark —— 一些私有的方法
/// 构造富文本
-(NSMutableAttributedString *)makeRichText:(NSArray <NSString *>*)arr{
    
    UIColor *color = [UIColor gradientCorDataMutArr:[NSMutableArray arrayWithArray:@[RGB_COLOR(247, 131, 97),RGB_COLOR(245, 75, 100)]]
                                         startPoint:CGPointZero
                                           endPoint:CGPointZero
                                             opaque:NO
                                     targetViewRect:CGRectMake(0,
                                                               0,
                                                               JobsWidth(400),
                                                               JobsWidth(1))];
    
    RichTextConfig *config_01 = RichTextConfig.new;
    config_01.font = [UIFont systemFontOfSize:JobsWidth(12) weight:UIFontWeightMedium];
    config_01.textCor = HEXCOLOR(0xD4A58);
    config_01.targetString = arr[0];

    RichTextConfig *config_02 = RichTextConfig.new;
    config_02.font = [UIFont systemFontOfSize:JobsWidth(12) weight:UIFontWeightRegular];
    config_02.textCor = color;
    config_02.targetString = arr[1];
    
    RichTextConfig *config_03 = RichTextConfig.new;
    config_03.font = [UIFont systemFontOfSize:JobsWidth(12) weight:UIFontWeightMedium];
    config_03.textCor = color;
    config_03.targetString = arr[1];

    NSMutableArray *dataMutArr = NSMutableArray.array;
    [dataMutArr addObject:config_01];
    [dataMutArr addObject:config_02];
    [dataMutArr addObject:config_03];

    // 设置整体的段落样式
    NSMutableAttributedString *attributedString = [self richTextWithDataConfigMutArr:dataMutArr];
    NSMutableParagraphStyle *paragraphStyle = NSMutableParagraphStyle.new;
    paragraphStyle.alignment = NSTextAlignmentLeft;//文本对齐方式 左右对齐（两边对齐）
    [attributedString addAttribute:NSParagraphStyleAttributeName
                             value:paragraphStyle
                             range:NSMakeRange(0, attributedString.string.length)];//设置段落样式
    return attributedString;
}
#pragma mark —— lazyLoad
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = UITableView.new;
        _tableView.backgroundColor = AppMainCor_02;
        _tableView.scrollEnabled = NO;
        _tableView.backgroundView = [UIImageView.alloc initWithImage:JobsIMG(@"弹窗数据承接底图")];
        _tableView.backgroundView.bounds = self.bounds;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = UIView.new;/// 这里接入的就是一个UIView的派生类
        _tableView.tableFooterView = UIView.new;/// 这里接入的就是一个UIView的派生类
        _tableView.separatorColor = UIColor.clearColor;
        [self addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }return _tableView;
}

-(NSMutableArray<UIViewModel *> *)dataMutArr{
    if (!_dataMutArr) {
        _dataMutArr = NSMutableArray.array;
        
        {
            UIViewModel *viewModel = UIViewModel.new;
            UITextModel *textModel = UITextModel.new;
            textModel.text = Internationalization(@"充值金额");
            textModel.textCor = HEXCOLOR(0x757575);
            textModel.font = [UIFont systemFontOfSize:JobsWidth(12) weight:UIFontWeightLight];

            UITextModel *subTextModel = UITextModel.new;
            subTextModel.text = Internationalization(@"5000.00");
            subTextModel.textCor = HEXCOLOR(0x3D4A58);
            subTextModel.font = [UIFont systemFontOfSize:JobsWidth(12) weight:UIFontWeightMedium];
            
            viewModel.textModel = textModel;
            viewModel.subTextModel = subTextModel;
            [_dataMutArr addObject:viewModel];
        }
        
        {
            UIViewModel *viewModel = UIViewModel.new;
            UITextModel *textModel = UITextModel.new;
            textModel.text = Internationalization(@"己獲紅利");
            textModel.textCor = HEXCOLOR(0x757575);
            textModel.font = [UIFont systemFontOfSize:JobsWidth(12) weight:UIFontWeightLight];
            
            UITextModel *subTextModel = UITextModel.new;
            subTextModel.text = Internationalization(@"5000.00");
            subTextModel.textCor = HEXCOLOR(0x3D4A58);
            subTextModel.font = [UIFont systemFontOfSize:JobsWidth(12) weight:UIFontWeightMedium];
            
            viewModel.textModel = textModel;
            viewModel.subTextModel = subTextModel;
            [_dataMutArr addObject:viewModel];
        }
        
        {
            UIViewModel *viewModel = UIViewModel.new;
            UITextModel *textModel = UITextModel.new;
            textModel.text = Internationalization(@"已完成流水");
            textModel.textCor = HEXCOLOR(0x757575);
            textModel.font = [UIFont systemFontOfSize:JobsWidth(12) weight:UIFontWeightLight];
            UITextModel *subTextModel = UITextModel.new;
//            subTextModel.text = Internationalization(@"4,800.00 /5,300.00  50%");
            subTextModel.attributedText = [self makeRichText:self.richTextDataMutArr];
            
            viewModel.textModel = textModel;
            viewModel.subTextModel = subTextModel;
            [_dataMutArr addObject:viewModel];
        }
        
    }return _dataMutArr;
}

-(NSMutableArray<NSString *> *)richTextDataMutArr{
    if (!_richTextDataMutArr) {
        _richTextDataMutArr = NSMutableArray.array;
        [_richTextDataMutArr addObject:@"4800.00"];
        [_richTextDataMutArr addObject:@"5300.00"];
        [_richTextDataMutArr addObject:@"  50%"];
    }return _richTextDataMutArr;
}

@end
