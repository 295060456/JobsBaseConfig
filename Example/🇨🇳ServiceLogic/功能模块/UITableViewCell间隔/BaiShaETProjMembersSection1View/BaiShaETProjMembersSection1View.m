//
//  BaiShaETProjMembersSection1View.m
//  BaiShaEntertainmentProj
//
//  Created by Jobs on 2022/5/16.
//

#import "BaiShaETProjMembersSection1View.h"

@interface BaiShaETProjMembersSection1View ()

@end

@implementation BaiShaETProjMembersSection1View


@synthesize viewModel = _viewModel;

#pragma mark —— BaseProtocol
/// 单例化和销毁
+(void)destroySingleton{
    static_membersSection1ViewOnceToken = 0;
    static_membersSection1View = nil;
}

static BaiShaETProjMembersSection1View *static_membersSection1View = nil;
static dispatch_once_t static_membersSection1ViewOnceToken;
+(instancetype)sharedInstance{
    dispatch_once(&static_membersSection1ViewOnceToken, ^{
        static_membersSection1View = BaiShaETProjMembersSection1View.new;
    });return static_membersSection1View;
}

-(instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = UIColor.whiteColor;
    }return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {

    }return self;
}
#pragma mark —— BaseViewProtocol
- (instancetype)initWithSize:(CGSize)thisViewSize{
    if (self = [super init]) {
        self.backgroundColor = UIColor.whiteColor;;
    }return self;
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
}

-(void)layoutSubviews{
    [super layoutSubviews];
}
#pragma mark —— BaseViewProtocol
/// 具体由子类进行复写【数据定UI】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
-(void)richElementsInViewWithModel:(UIViewModel *_Nullable)model{
    self.viewModel = model ? : UIViewModel.new;
    MakeDataNull
}
/// 具体由子类进行复写【数据尺寸】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
+(CGSize)viewSizeWithModel:(UIViewModel *_Nullable)model{
    return CGSizeMake(JobsMainScreen_WIDTH(), JobsWidth(100 + 28 + 199));
}
#pragma mark —— lazyLoad

@end
