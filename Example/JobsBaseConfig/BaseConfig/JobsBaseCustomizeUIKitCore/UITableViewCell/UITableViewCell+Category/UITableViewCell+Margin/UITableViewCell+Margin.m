//
//  UITableViewCell+Margin.m
//  JobsIM
//
//  Created by Jobs on 2020/11/13.
//

#import "UITableViewCell+Margin.h"

@implementation UITableViewCell (Margin)

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

#pragma mark —— 一些公有的功能方法
/// 以section为单位，UITableViewCell 第一行和最后一行圆角设置【cell之间有分割线】
/// @param tableView 作用对象tableView
/// @param cell 作用对象Tableviewcell
/// @param indexPath indexPath
/// @param strokeColor strokeColor
/// @param fillColor fillColor
/// @param radius 切角弧度
/// @param borderWidth 线宽
/// @param dx 内有介绍
/// @param dy 内有介绍
+(void)tableView:(UITableView *_Nonnull)tableView
makeFirstAndLastCell:(UITableViewCell *_Nonnull)cell
     atIndexPath:(NSIndexPath *_Nonnull)indexPath
     strokeColor:(UIColor *_Nullable)strokeColor
       fillColor:(UIColor *_Nullable)fillColor
     roundCorner:(CGFloat)radius
     borderWidth:(CGFloat)borderWidth
              dx:(CGFloat)dx
              dy:(CGFloat)dy{
    if (!tableView) return;
    if (!cell) return;
    if (!indexPath) return;
    if (!strokeColor) strokeColor = UIColor.redColor;
    if (!fillColor) fillColor = UIColor.blueColor;
    // 圆角角度
    if (!radius) radius = JobsWidth(10.f);
    if (!dx) dx = JobsWidth(15);
    // 设置cell 背景色为透明
    cell.backgroundColor = UIColor.clearColor;
    // 创建两个layer
    CAShapeLayer *normalLayer = CAShapeLayer.new;
    CAShapeLayer *selectLayer = CAShapeLayer.new;
    // 获取显示区域大小
    CGRect bounds = [self tableViewCell:cell
                                     dx:dx
                                     dy:dy];
    // 获取每组行数
    NSInteger rowNum = [tableView numberOfRowsInSection:indexPath.section];
    // 贝塞尔曲线
    UIBezierPath *bezierPath = nil;
    if (rowNum == 1) {
       bezierPath = [UIBezierPath bezierPathWithRoundedRect:bounds
                                          byRoundingCorners:UIRectCornerAllCorners
                                                cornerRadii:CGSizeMake(radius, radius)];
    }else{
        if (indexPath.row == 0) {
            // 每组第一行（添加左上和右上的圆角）
            bezierPath = [UIBezierPath bezierPathWithRoundedRect:bounds
                                               byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight
                                                     cornerRadii:CGSizeMake(radius, radius)];
        }else if (indexPath.row == rowNum - 1){
            // 每组最后一行（添加左下和右下的圆角）
            bezierPath = [UIBezierPath bezierPathWithRoundedRect:bounds
                                               byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight
                                                     cornerRadii:CGSizeMake(radius, radius)];
        }else{
            // 每组不是首位的行不设置圆角
            bezierPath = [UIBezierPath bezierPathWithRect:bounds];
        }
   }
    
    /*
     
     同 ：指定圆切角
     -(void)appointCornerCutToCircleByRoundingCorners:(UIRectCorner)corners
                                          cornerRadii:(CGSize)cornerRadii;
     **/
    
    // 把已经绘制好的贝塞尔曲线路径赋值给图层，然后图层根据path进行图像渲染render
    normalLayer.path = bezierPath.CGPath;
    selectLayer.path = bezierPath.CGPath;
       
    UIView *nomarBgView = [UIView.alloc initWithFrame:bounds];
    // 设置填充颜色
    // normalLayer.fillColor = [UIColor colorWithWhite:0.95 alpha:1.0].CGColor;
    normalLayer.fillColor = fillColor.CGColor;
    normalLayer.strokeColor = strokeColor.CGColor;
    
    // 添加图层到nomarBgView中
    [nomarBgView.layer insertSublayer:normalLayer atIndex:0];
    nomarBgView.backgroundColor = UIColor.clearColor;
    // nomarBgView.backgroundColor = UIColor.whiteColor;
    cell.backgroundView = nomarBgView;
    // 此时圆角显示就完成了，但是如果没有取消cell的点击效果，还是会出现一个灰色的长方形的形状，再用上面创建的selectLayer给cell添加一个selectedBackgroundView
    UIView *selectBgView = [UIView.alloc initWithFrame:bounds];
    selectLayer.fillColor = UIColor.whiteColor.CGColor;
    [selectBgView.layer insertSublayer:selectLayer atIndex:0];
    selectBgView.backgroundColor = UIColor.clearColor;
    cell.selectedBackgroundView = selectBgView;
}
/// 以section为单位，每个section的第一行和最后一行的cell圆角化处理【cell之间没有分割线】
/// @param tableView 作用对象tableView
/// @param cell 作用对象Tableviewcell
/// @param radius 切角弧度
/// @param borderWidth 线宽
/// @param dx 内有介绍
/// @param dy 内有介绍
/// @param indexPath indexPath
+(void)tableView:(UITableView *_Nonnull)tableView
makeSectionFirstAndLastCell:(UITableViewCell *_Nonnull)cell
     atIndexPath:(NSIndexPath *_Nonnull)indexPath
       cellBgCor:(UIColor *_Nullable)cellBgCor
   bottomLineCor:(UIColor *_Nullable)bottomLineCor
  cellOutLineCor:(UIColor *_Nullable)cellOutLineCor
     roundCorner:(CGFloat)radius
     borderWidth:(CGFloat)borderWidth
              dx:(CGFloat)dx
              dy:(CGFloat)dy{
    if (!tableView) return;
    if (!cell) return;
    if (!indexPath) return;
    // 圆角角度
    if (!radius) radius = JobsWidth(10.f);
    // 水平偏移量
    if (!dx) dx = JobsWidth(15);
    // cell的底色
    if (!cellBgCor) cellBgCor = UIColor.whiteColor;
    // cell下线的颜色
    if (!bottomLineCor) bottomLineCor = UIColor.whiteColor;
    // cell外线的颜色
    if (!cellOutLineCor) cellOutLineCor = UIColor.whiteColor;
    // 大小
    CGRect bounds = [self tableViewCell:cell
                                     dx:dx
                                     dy:dy];
    // 行数
    NSInteger numberOfRows = [tableView numberOfRowsInSection:indexPath.section];
    // 绘制曲线
    UIBezierPath *bezierPath = nil;
    if (indexPath.row == 0 && numberOfRows == 1) {
        // 一个为一组时,四个角都为圆角
        bezierPath = [UIBezierPath bezierPathWithRoundedRect:bounds
                                           byRoundingCorners:UIRectCornerAllCorners
                                                 cornerRadii:CGSizeMake(radius, radius)];
    } else if (indexPath.row == 0) {
        // 为组的第一行时,左上、右上角为圆角
        bezierPath = [UIBezierPath bezierPathWithRoundedRect:bounds
                                           byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerTopRight)
                                                 cornerRadii:CGSizeMake(radius, radius)];
    } else if (indexPath.row == numberOfRows - 1) {
        // 为组的最后一行,左下、右下角为圆角
        bezierPath = [UIBezierPath bezierPathWithRoundedRect:bounds
                                           byRoundingCorners:(UIRectCornerBottomLeft | UIRectCornerBottomRight)
                                                 cornerRadii:CGSizeMake(radius, radius)];
    } else {
        //中间的都为矩形
        bezierPath = [UIBezierPath bezierPathWithRect:bounds];
    }
    
    {
        // 新建一个图层
        CAShapeLayer *layer = CAShapeLayer.layer;
        // 线宽
        layer.borderWidth = borderWidth;
        // 图层边框路径
        layer.path = bezierPath.CGPath;
        // 图层填充色,也就是cell的底色
        layer.fillColor = cellBgCor.CGColor;
        // 图层边框线条颜色
        /*
         如果self.tableView.style = UITableViewStyleGrouped时,每一组的首尾都会有一根分割线,目前我还没找到去掉每组首尾分割线,保留cell分割线的办法。
         所以这里取巧,用带颜色的图层边框替代分割线。
         这里为了美观,最好设为和tableView的底色一致。
         设为透明,好像不起作用。
         */
        layer.strokeColor = cellOutLineCor.CGColor;
        //将图层添加到cell的图层中,并插到最底层
        [cell.layer insertSublayer:layer atIndex:0];
    }
    /// 除了最后一行以外，所有的cell的最下面的线的颜色为bottomLineCor
    [UITableViewCell tableView:tableView
               makeLastRowCell:cell
                   atIndexPath:indexPath
                 bottomLineCor:bottomLineCor
                   borderWidth:borderWidth
                            dx:dx
                            dy:dy];
}
/// 除了最后一行以外，所有的cell的最下面的线的颜色为bottomLineCor
+(void)tableView:(UITableView *_Nonnull)tableView
 makeLastRowCell:(UITableViewCell *_Nonnull)cell
     atIndexPath:(NSIndexPath *_Nonnull)indexPath
   bottomLineCor:(UIColor *_Nullable)bottomLineCor
     borderWidth:(CGFloat)borderWidth
              dx:(CGFloat)dx
              dy:(CGFloat)dy{
    if (!tableView) return;
    if (!cell) return;
    if (!indexPath) return;
    if (!bottomLineCor) bottomLineCor = UIColor.whiteColor;
    if (!dx) dx = JobsWidth(15);
    // 大小
    CGRect bounds = [self tableViewCell:cell
                                     dx:dx
                                     dy:dy];
    // 行数
    NSInteger numberOfRows = [tableView numberOfRowsInSection:indexPath.section];
    /// 除了最后一行以外，所有的cell的最下面的线为bottomLineCor
    if (indexPath.row != numberOfRows - 1) {
        UIBezierPath *linePath = UIBezierPath.bezierPath;
        // 起点
        [linePath moveToPoint:CGPointMake(bounds.origin.x, bounds.size.height)];
        // 其他点
        [linePath addLineToPoint:CGPointMake(bounds.origin.x + bounds.size.width, bounds.size.height)];
        // 新建一个图层
        CAShapeLayer *layer = CAShapeLayer.layer;
        layer.borderWidth = borderWidth;
        layer.path = linePath.CGPath;
        layer.strokeColor = bottomLineCor.CGColor;
        //将图层添加到cell的图层中,并插到最底层
        [cell.layer insertSublayer:layer atIndex:1];
    }
}
#pragma mark —— 一些私有的功能方法
// 大小
+(CGRect)tableViewCell:(nonnull UITableViewCell *)tableViewCell
                    dx:(CGFloat)dx
                    dy:(CGFloat)dy{
    
    /// CGRectInset会进行平移和缩放两个操作;CGRectOffset做的只是平移
    /**
     CGRectInset(CGRect rect, CGFloat dx, CGFloat dy),
     三个参数:
     rect：待操作的CGRect；
     dx：为正数时，向右平移dx，宽度缩小2dx。为负数时，向左平移dx，宽度增大2dx；
     dy：为正数是，向下平移dy，高度缩小2dy。为负数是，向上平移dy，高度增大2dy。
     
     **/
    // 获取显示区域大小
    return CGRectInset(tableViewCell.bounds,
                       dx,
                       dy);
}
static char *UITableViewCell_Margin_indexPath = "UITableViewCell_Margin_indexPath";
@dynamic indexPath;
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
static char *UITableViewCell_Margin_index = "UITableViewCell_Margin_index";
@dynamic index;
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

