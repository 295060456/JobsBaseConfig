//
//  CollectionReusableView.m
//  UBallLive
//
//  Created by Jobs on 2020/10/12.
//

#import "BaseCollectionReusableView.h"

@interface BaseCollectionReusableView ()

@end

@implementation BaseCollectionReusableView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
//        [self richElementsInViewWithModel:nil];
    }return self;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches
          withEvent:(UIEvent *)event{
    @jobs_weakify(self)
    if (self.objectBlock) self.objectBlock(weak_self);
}
/// 由具体的子类进行覆写
+(CGSize)viewSizeWithModel:(id _Nullable)model{
    return CGSizeZero;
}
/// 由具体的子类进行覆写
-(void)richElementsInViewWithModel:(id _Nullable)model{}
/// 具体由子类进行复写【数据尺寸】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
/// UICollectionViewDelegateFlowLayout
+(CGSize)collectionReusableViewSizeWithModel:(id _Nullable)model{
    return CGSizeMake(JobsMainScreen_WIDTH(), JobsWidth(50));
}

@end
