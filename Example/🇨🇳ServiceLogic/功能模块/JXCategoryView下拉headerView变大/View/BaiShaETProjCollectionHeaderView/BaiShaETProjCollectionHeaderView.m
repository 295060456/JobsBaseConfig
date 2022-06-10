//
//  BaiShaETProjCollectionHeaderView.m
//  BaiShaEntertainmentProj
//
//  Created by Jobs on 2022/6/10.
//

#import "BaiShaETProjCollectionHeaderView.h"

@interface BaiShaETProjCollectionHeaderView ()

@property(nonatomic,assign)CGRect imageViewFrame;

@end

@implementation BaiShaETProjCollectionHeaderView

@synthesize viewModel = _viewModel;

#pragma mark —— BaseProtocol
/// 单例化和销毁
+(void)destroySingleton{
    static_collectionHeaderViewOnceToken = 0;
    static_collectionHeaderView = nil;
}

static BaiShaETProjCollectionHeaderView *static_collectionHeaderView = nil;
static dispatch_once_t static_collectionHeaderViewOnceToken;
+(instancetype)sharedInstance{
    dispatch_once(&static_collectionHeaderViewOnceToken, ^{
        static_collectionHeaderView = BaiShaETProjCollectionHeaderView.new;
    });return static_collectionHeaderView;
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

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
}

-(void)layoutSubviews{
    [super layoutSubviews];
}
#pragma mark —— UIScrollViewDelegate
- (void)scrollViewDidScroll:(CGFloat)contentOffsetY {
    if (self.isZoom) {
//        CGRect frame = self.imageViewFrame;
//        frame.size.height -= contentOffsetY;
//        frame.origin.y = contentOffsetY;
//        self.imageView.frame = frame;
    }
}
#pragma mark —— BaseViewProtocol
- (instancetype)initWithSize:(CGSize)thisViewSize{
    if (self = [super init]) {
        self.backgroundColor = UIColor.redColor;
    }return self;
}
/// 具体由子类进行复写【数据定UI】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
-(void)richElementsInViewWithModel:(UIViewModel *_Nullable)model{
    self.viewModel = model;
    MakeDataNull
}
/// 具体由子类进行复写【数据尺寸】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
+(CGSize)viewSizeWithModel:(UIViewModel *_Nullable)model{
    return CGSizeMake(JobsMainScreen_WIDTH(), JobsWidth(338));
}
#pragma mark —— lazyLoad




@end
