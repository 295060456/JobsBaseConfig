//
//  ViewForTableViewHeader.m
//  UBallLive
//
//  Created by Jobs on 2020/10/27.
//

#import "BaseTableViewHeaderView.h"

@interface BaseTableViewHeaderView ()

@end

@implementation BaseTableViewHeaderView

-(instancetype)initWithReuseIdentifier:(nullable NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {

    }return self;
}
//在具体的子类实现，实现控制UITableViewHeaderFooterView是否悬停
- (void)setFrame:(CGRect)frame {
    [super setFrame:[self.tableView rectForHeaderInSection:self.section]];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches
          withEvent:(UIEvent *)event{
    if (self.viewBlock) self.viewBlock(@1);
}
#pragma mark —— BaseViewProtocol
//具体由子类进行复写【数据定UI】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
-(void)richElementsInViewWithModel:(id _Nullable)model{}
//具体由子类进行复写【数据定高】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
+(CGFloat)viewHeightWithModel:(id _Nullable)model{
    return 0.0f;
}

@end
