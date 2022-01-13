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

static char *UITableViewCell_Margin_index = "UITableViewCell_Margin_index";
@dynamic index;

@dynamic offsetXForEach;
@dynamic offsetYForEach;

// 在具体的子类去实现,分类调用异常
//-(void)setFrame:(CGRect)frame{
//    NSLog(@"self.offsetXForEach = %f",self.offsetXForEach);
//    NSLog(@"self.offsetYForEach = %f",self.offsetYForEach);
//    frame.origin.x += self.offsetXForEach;
//    frame.origin.y += self.offsetYForEach;
//    frame.size.height -= self.offsetYForEach * 2;
//    frame.size.width -= self.offsetXForEach * 2;
//    [super setFrame:frame];
//}
#pragma mark —— <UIViewModelProtocol> @property(nonatomic,strong)NSIndexPath *indexPath;
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
#pragma mark —— <UIViewModelProtocol> @property(nonatomic,assign)NSInteger index;
-(NSInteger)index{
    return [objc_getAssociatedObject(self, UITableViewCell_Margin_index) integerValue];
}

-(void)setIndex:(NSInteger)index{
    objc_setAssociatedObject(self,
                             UITableViewCell_Margin_index,
                             [NSNumber numberWithInteger:index],
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

