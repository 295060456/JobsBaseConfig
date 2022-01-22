//
//  ViewForTableViewFooter.m
//  UBallLive
//
//  Created by Jobs on 2020/10/27.
//

#import "BaseTableViewFooterView.h"

@interface BaseTableViewFooterView ()

@end

@implementation BaseTableViewFooterView

-(instancetype)initWithReuseIdentifier:(nullable NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {

    }return self;
}
#pragma mark —— BaseViewProtocol
//具体由子类进行复写【数据定UI】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
-(void)richElementsInViewWithModel:(id _Nullable)model{}
//具体由子类进行复写【数据定高】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
+(CGFloat)viewHeightWithModel:(id _Nullable)model{
    return 0.0f;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches
          withEvent:(UIEvent *)event{
    if (self.viewBlock) self.viewBlock(@1);
}

@end
