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
        [self richElementsInViewWithModel:nil];
    }return self;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches
          withEvent:(UIEvent *)event{
    @jobs_weakify(self)
    if (self.viewBlock) self.viewBlock(weak_self);
}
//由具体的子类进行覆写
+(CGSize)viewSizeWithModel:(id _Nullable)model{
    return CGSizeZero;
}
//由具体的子类进行覆写
-(void)richElementsInViewWithModel:(id _Nullable)model{}

@end
