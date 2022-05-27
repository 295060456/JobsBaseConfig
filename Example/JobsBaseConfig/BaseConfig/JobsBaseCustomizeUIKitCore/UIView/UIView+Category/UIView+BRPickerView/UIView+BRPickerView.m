//
//  UIView+BRPickerView.m
//  UBallLive
//
//  Created by Jobs on 2020/10/12.
//

#import "UIView+BRPickerView.h"
/// https://github.com/91renb/BRPickerView
@implementation UIView (BRPickerView)
#pragma mark 一些公有方法
+(BRPickerStyle *)makeCustomStyle{
    BRPickerStyle *pickerStyle = BRPickerStyle.new;
    pickerStyle.pickerColor = UIColor.whiteColor;
    pickerStyle.pickerTextColor = HEXCOLOR(0x3D4A58);
    pickerStyle.separatorColor = HEXCOLOR(0xEAEBED);
    pickerStyle.cancelBtnTitle = Internationalization(@"取消");
    pickerStyle.doneBtnTitle = Internationalization(@"确定");
    return pickerStyle;
}

+(BRAddressPickerView *)makeAddressPickerView:(BRPickerStyle *_Nullable)pickerStyle{
    BRAddressPickerView *addressPickerView = BRAddressPickerView.new;
    /**
     BRAddressPickerModeArea,/// 显示【省市区】（默认）
     BRAddressPickerModeCity,/// 显示【省市】
     BRAddressPickerModeProvince/// 显示【省】
     */
    addressPickerView.pickerMode = BRAddressPickerModeArea;
    addressPickerView.title = Internationalization(@"请选择地区");
    //AddressPickerView.selectValues = @[@"浙江省", @"杭州市", @"西湖区"];
    addressPickerView.selectIndexs = @[@10, @0, @4];
    addressPickerView.isAutoSelect = YES;
    // 设置自定义样式
    addressPickerView.pickerStyle = pickerStyle;
    return addressPickerView;
}

+(BRStringPickerView *)makeStringPickerView:(BRStringPickerMode)stringPickerMode{
    return [BRStringPickerView.alloc initWithPickerMode:stringPickerMode];
}

+(BRDatePickerView *)makeDatePickerView:(BRPickerStyle *_Nullable)customStyle{
    if (!customStyle) {
        customStyle = self.makeCustomStyle;
    }
    BRDatePickerView *datePickerView = BRDatePickerView.new;
    datePickerView.pickerMode = BRDatePickerModeYMD;
    datePickerView.title = Internationalization(@"选择年月日");
    // datePickerView.selectValue = @"2019-10-30";
    datePickerView.selectDate = [NSDate br_setYear:2019
                                              month:10
                                                day:30];
    datePickerView.minDate = [NSDate br_setYear:1949
                                           month:3
                                             day:12];
    datePickerView.maxDate = NSDate.date;
    datePickerView.isAutoSelect = YES;
    datePickerView.pickerStyle = customStyle;
    return datePickerView;
}
/// 时间选择器
-(void)makeDatePickerDoneBlock:(BRDoneClickBlock)clickDoneBlock
                   resultBlock:(BRDateResultBlock)clickResultBlock{
    @jobs_weakify(self)
    self.datePickerView.doneBlock = ^{
        @jobs_strongify(self)
        [self.datePickerView removePickerFromView:nil];
        if (clickDoneBlock) clickDoneBlock();
    };
    self.datePickerView.resultBlock = ^(NSDate *selectDate,
                                    NSString *selectValue) {
        @jobs_strongify(self)
        NSLog(@"选择的值：%@", selectValue);
        if (clickResultBlock) clickResultBlock(selectDate,selectValue);
    };
    [self.datePickerView show];
}
/// 地址选择器
-(void)makeAddressPickerViewDoneBlock:(BRDoneClickBlock)clickDoneBlock
                          resultBlock:(BRAddressResultBlock)clickResultBlock{
    @jobs_weakify(self)
    self.addressPickerView.doneBlock = ^{
        @jobs_strongify(self)
        [self.addressPickerView removePickerFromView:nil];
        if (clickDoneBlock) clickDoneBlock();
    };
    
    self.addressPickerView.resultBlock = ^(BRProvinceModel *province,
                                           BRCityModel *city,
                                           BRAreaModel *area) {
        @jobs_strongify(self)
        NSLog(@"选择的值：%@", [NSString stringWithFormat:@"%@-%@-%@", province.name, city.name, area.name]);
        if (clickResultBlock) clickResultBlock(province,city,area);
    };
//    self.addressPickerView.pickerMode = BRAddressPickerModeProvince;
    [self.addressPickerView show];
}
/// 自定义字符串选择器
-(void)makeStringPickerViewWithModel:(BRStringPickerViewModel *_Nullable)stringPickerViewModel
                         pickerStyle:(BRPickerStyle *_Nullable)pickerStyle
                           doneBlock:(BRDoneClickBlock)clickDoneBlock
                         resultBlock:(jobsByIDBlock)clickResultBlock{
    if (!stringPickerViewModel) {
        stringPickerViewModel = BRStringPickerViewModel.new;
        stringPickerViewModel.pickerMode = BRStringPickerComponentSingle;
        stringPickerViewModel.title = Internationalization(@"学历");
        stringPickerViewModel.dataSourceArr = @[Internationalization(@"大专以下"),
                                                Internationalization(@"大专"),
                                                Internationalization(@"本科"),
                                                Internationalization(@"硕士"),
                                                Internationalization(@"博士"),
                                                Internationalization(@"博士后")];
        stringPickerViewModel.selectIndex = 2;
    }
    
    self.stringPickerView.pickerMode = stringPickerViewModel.pickerMode;
    self.stringPickerView.title = stringPickerViewModel.title;
    self.stringPickerView.dataSourceArr = stringPickerViewModel.dataSourceArr;
    self.stringPickerView.selectIndex = stringPickerViewModel.selectIndex;
    self.stringPickerView.pickerStyle = pickerStyle ? : self.customStyle;
    
    @jobs_weakify(self)
    self.stringPickerView.doneBlock = ^{
        @jobs_strongify(self)
        [self.stringPickerView removePickerFromView:nil];
        if (clickDoneBlock) clickDoneBlock();
    };
    /** 选择结果的回调【单列】 */
    self.stringPickerView.resultModelBlock = ^(BRResultModel *resultModel) {
//            NSLog(@"选择的值：%@", resultModel.selectValue);
        @jobs_strongify(self)
        if (self.brStringPickerViewBlock) self.brStringPickerViewBlock(resultModel);
    };
    /** 选择结果的回调【多列】 */
    self.stringPickerView.resultModelArrayBlock = ^(NSArray<BRResultModel *> * _Nullable resultModelArr) {
        @jobs_strongify(self)
        if (self.brStringPickerViewBlock) self.brStringPickerViewBlock(resultModelArr);
    };
    
    [self.stringPickerView show];
}

-(void)BRStringPickerViewBlock:(jobsByIDBlock)block{
    self.brStringPickerViewBlock = block;
}
#pragma mark —— 一些私有方法
-(void)change:(BRStringPickerViewModel *)stringPickerViewModel{
    if (stringPickerViewModel.dataSourceArr.count > 2) {
        NSMutableArray *temp = stringPickerViewModel.dataSourceArr.copy;
        [temp removeObjectAtIndex:0];
        self.stringPickerView.dataSourceArr = temp;
        self.stringPickerView.title = stringPickerViewModel.dataSourceArr[0];
    }
}
#pragma mark SET | GET
static char *UIView_BRStringPickerView_stringPickerView = "UIView_BRStringPickerView_stringPickerView";
@dynamic stringPickerView;
#pragma mark —— @property(nonatomic,strong)BRStringPickerView *stringPickerView;/// 自定义字符串选择器
-(BRStringPickerView *)stringPickerView{
    BRStringPickerView *StringPickerView = objc_getAssociatedObject(self, UIView_BRStringPickerView_stringPickerView);
    if (!StringPickerView) {
        StringPickerView = [UIView makeStringPickerView:self.brStringPickerMode];
        objc_setAssociatedObject(self,
                                 UIView_BRStringPickerView_stringPickerView,
                                 StringPickerView,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return StringPickerView;
}

-(void)setStringPickerView:(BRStringPickerView *)stringPickerView{
    objc_setAssociatedObject(self,
                             UIView_BRStringPickerView_stringPickerView,
                             stringPickerView,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
static char *UIView_BRStringPickerView_datePickerView = "UIView_BRStringPickerView_datePickerView";
@dynamic datePickerView;
#pragma mark —— @property(nonatomic,strong)BRDatePickerView *datePickerView;/// 时间选择器
-(BRDatePickerView *)datePickerView{
    BRDatePickerView *DatePickerView = objc_getAssociatedObject(self, UIView_BRStringPickerView_datePickerView);
    if (!DatePickerView) {
        DatePickerView = [UIView makeDatePickerView:self.customStyle];
        objc_setAssociatedObject(self,
                                 UIView_BRStringPickerView_datePickerView,
                                 DatePickerView,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return DatePickerView;
}

-(void)setDatePickerView:(BRDatePickerView *)datePickerView{
    objc_setAssociatedObject(self,
                             UIView_BRStringPickerView_datePickerView,
                             datePickerView,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
static char *UIView_BRStringPickerView_addressPickerView = "UIView_BRStringPickerView_addressPickerView";
@dynamic addressPickerView;
#pragma mark —— @property(nonatomic,strong)BRAddressPickerView *addressPickerView;/// 地址选择器
-(BRAddressPickerView *)addressPickerView{
    BRAddressPickerView *AddressPickerView = objc_getAssociatedObject(self, UIView_BRStringPickerView_addressPickerView);
    if (!AddressPickerView) {
        AddressPickerView = [UIView makeAddressPickerView:self.customStyle];
        objc_setAssociatedObject(self,
                                 UIView_BRStringPickerView_addressPickerView,
                                 AddressPickerView,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return AddressPickerView;
}

-(void)setAddressPickerView:(BRAddressPickerView *)addressPickerView{
    objc_setAssociatedObject(self,
                             UIView_BRStringPickerView_addressPickerView,
                             addressPickerView,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
static char *UIView_BRStringPickerView_customStyle = "UIView_BRStringPickerView_customStyle";
@dynamic customStyle;
#pragma mark —— @property(nonatomic,strong)BRPickerStyle *customStyle;
-(BRPickerStyle *)customStyle{
    BRPickerStyle *pickerStyle = objc_getAssociatedObject(self, UIView_BRStringPickerView_customStyle);
    if (!pickerStyle) {
        pickerStyle = [UIView makeCustomStyle];
        objc_setAssociatedObject(self,
                                 UIView_BRStringPickerView_customStyle,
                                 pickerStyle,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return pickerStyle;
}

-(void)setCustomStyle:(BRPickerStyle *)customStyle{
    objc_setAssociatedObject(self,
                             UIView_BRStringPickerView_customStyle,
                             customStyle,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
static char *UIView_BRStringPickerView_brStringPickerMode = "UIView_BRStringPickerView_brStringPickerMode";
@dynamic brStringPickerMode;
#pragma mark —— @property(nonatomic,assign)BRStringPickerMode brStringPickerMode;
-(BRStringPickerMode)brStringPickerMode{
    return [objc_getAssociatedObject(self, UIView_BRStringPickerView_brStringPickerMode) integerValue];
}

-(void)setBrStringPickerMode:(BRStringPickerMode)brStringPickerMode{
    objc_setAssociatedObject(self,
                             UIView_BRStringPickerView_brStringPickerMode,
                             [NSNumber numberWithInteger:brStringPickerMode],
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
static char *UIView_BRStringPickerView_brStringPickerViewBlock = "UIView_BRStringPickerView_brStringPickerViewBlock";
@dynamic brStringPickerViewBlock;
#pragma mark —— @property(nonatomic,copy)jobsByIDBlock brStringPickerViewBlock;
-(jobsByIDBlock)brStringPickerViewBlock{
    return objc_getAssociatedObject(self, UIView_BRStringPickerView_brStringPickerViewBlock);
}

-(void)setBrStringPickerViewBlock:(jobsByIDBlock)brStringPickerViewBlock{
    objc_setAssociatedObject(self,
                             UIView_BRStringPickerView_brStringPickerViewBlock,
                             brStringPickerViewBlock,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}
static char *UIView_BRStringPickerView_BRStringPickerViewDataMutArr = "UIView_BRStringPickerView_BRStringPickerViewDataMutArr";
@dynamic BRStringPickerViewDataMutArr;
#pragma mark —— @property(nonatomic,strong)NSMutableArray *BRStringPickerViewDataMutArr;
-(NSMutableArray *)BRStringPickerViewDataMutArr{
    NSMutableArray *brStringPickerViewDataMutArr = objc_getAssociatedObject(self, UIView_BRStringPickerView_BRStringPickerViewDataMutArr);
    if (!brStringPickerViewDataMutArr) {
        brStringPickerViewDataMutArr = NSMutableArray.array;
        objc_setAssociatedObject(self,
                                 UIView_BRStringPickerView_BRStringPickerViewDataMutArr,
                                 brStringPickerViewDataMutArr,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return brStringPickerViewDataMutArr;
}

-(void)setBRStringPickerViewDataMutArr:(NSMutableArray *)BRStringPickerViewDataMutArr{
    objc_setAssociatedObject(self,
                             UIView_BRStringPickerView_BRStringPickerViewDataMutArr,
                             BRStringPickerViewDataMutArr,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

@implementation BRStringPickerViewModel

@end
