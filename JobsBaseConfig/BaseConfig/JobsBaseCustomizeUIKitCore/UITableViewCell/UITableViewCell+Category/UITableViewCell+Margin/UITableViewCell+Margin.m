//
//  UITableViewCell+Margin.m
//  JobsIM
//
//  Created by Jobs on 2020/11/13.
//

#import "UITableViewCell+Margin.h"

@implementation UITableViewCell (Margin)

static char *UITableViewCell_Margin_indexPath = "UITableViewCell_Margin_indexPath";
@dynamic indexPath;

// 在具体的子类去实现,分类调用无效
-(void)setFrame:(CGRect)frame{
    NSLog(@"self.marginX = %f",self.marginX);
    NSLog(@"self.marginY = %f",self.marginY);
    frame.origin.x += self.marginX;
    frame.origin.y += self.marginY;
    frame.size.height -= self.marginY * 2;
    frame.size.width -= self.marginX * 2;
    [super setFrame:frame];
}
#pragma mark —— @property(nonatomic,strong)NSIndexPath *indexPath;
-(NSIndexPath *)indexPath{
    NSIndexPath *indexPath = objc_getAssociatedObject(self, UITableViewCell_Margin_indexPath);
    return indexPath;
}

-(void)setIndexPath:(NSIndexPath *)indexPath{
    objc_setAssociatedObject(self,
                             UITableViewCell_Margin_indexPath,
                             indexPath,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
