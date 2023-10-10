# 关于UITableViewCell和UICollectionViewCell圆切角+Cell的偏移量

[toc]

## 一些公共的

```objective-c
@implementation UITableViewCell (BaseCellProtocol)
/// 获取这个UITableViewCell所承载的UITableView
-(UITableView *)jobsGetCurrentTableView{
    return (UITableView *)self.superview;
}
/// 获取当前的UITableViewCell对应的indexPath
-(NSIndexPath *)jobsGetCurrentIndexPath{
    return [(UITableView *)self.jobsGetCurrentTableView indexPathForCell:self];
}
/// 获取当前的UITableViewCell对应的section
-(NSInteger)jobsGetCurrentNumberOfSections{
    return [self.jobsGetCurrentTableView numberOfSections];
}
/// 获取当前的UITableViewCell对应的row
-(NSInteger)jobsGetCurrentNumberOfRowsInSection{
    return [self.jobsGetCurrentTableView numberOfRowsInSection:self.jobsGetCurrentIndexPath.section];
}

@end
```

```objective-c
@implementation UICollectionViewCell (UICollectionViewCellProtocol)
/// 获取这个UICollectionViewCell所承载的UICollectionView
-(UICollectionView *)jobsGetCurrentCollectionView{
    return (UICollectionView *)self.superview;
}
/// 获取当前的UICollectionViewCell对应的indexPath
-(NSIndexPath *)jobsGetCurrentIndexPath{
    return [(UICollectionView *)self.jobsGetCurrentCollectionView indexPathForCell:self];
}
/// 获取当前的UICollectionViewCell对应的section
-(NSInteger)jobsGetCurrentNumberOfSections{
    return [self.jobsGetCurrentCollectionView numberOfSections];
}
/// 获取当前的UICollectionViewCell对应的item
-(NSInteger)jobsGetCurrentNumberOfItemsInSection{
    return [self.jobsGetCurrentCollectionView numberOfItemsInSection:self.jobsGetCurrentIndexPath.section];
}

@end
```

```objective-c
/// 附加偏移量以后的大小
-(CGRect)dx:(CGFloat)dx dy:(CGFloat)dy{
    /**
     CGRectInset会进行平移和缩放两个操作;CGRectOffset做的只是平移
     CGRectInset(CGRect rect, CGFloat dx, CGFloat dy),
     三个参数:
     rect：待操作的CGRect；
     dx：为正数时，向右平移dx，宽度缩小2dx。为负数时，向左平移dx，宽度增大2dx；
     dy：为正数是，向下平移dy，高度缩小2dy。为负数是，向上平移dy，高度增大2dy。
     */
    return CGRectInset(self.bounds,dx,dy);/// 获取显示区域大小
}
```

* 这种方式，只能统一的设置同一种样式，并不能满足自定义需求

```objective-c
cell.contentView.layer.cornerRadius = cell.layer.cornerRadius = JobsWidth(8);
cell.contentView.layer.borderWidth = cell.layer.borderWidth = JobsWidth(1);
cell.contentView.layer.borderColor = cell.layer.borderColor = RGBA_COLOR(255, 225, 144, 1).CGColor;
cell.contentView.layer.masksToBounds = cell.layer.masksToBounds = YES;
```

## 1、关于UITableView.UITableViewCell

### 1.1、圆切角

#### 1.1.1、以section为单位，每个section的第一行和最后一行的cell圆角化处理【cell之间没有分割线】

```objective-c
-(void)cutFirstAndLastTableViewCellWithBackgroundCor:(UIColor *_Nullable)cellBgCor
                                       bottomLineCor:(UIColor *_Nullable)bottomLineCor
                                      cellOutLineCor:(UIColor *_Nullable)cellOutLineCor
                                    cornerRadiusSize:(CGSize)cornerRadiusSize
                                         borderWidth:(CGFloat)borderWidth
                                                  dx:(CGFloat)dx
                                                  dy:(CGFloat)dy{
    if (!cellBgCor) cellBgCor = UIColor.whiteColor;
    if (!bottomLineCor) bottomLineCor = UIColor.whiteColor;
    if (!cellOutLineCor) cellOutLineCor = UIColor.whiteColor;
    CGRect bounds = [self dx:dx dy:dy];
    NSInteger numberOfRowsInSection = self.jobsGetCurrentNumberOfRowsInSection;
    NSIndexPath *indexPath = self.jobsGetCurrentIndexPath;
    // 绘制曲线
    UIBezierPath *bezierPath = nil;
    {
        if(numberOfRowsInSection <= 1){/// 一个section里面只有一个row = 四个角都为圆角
            bezierPath = [UIBezierPath bezierPathWithRoundedRect:bounds
                                               byRoundingCorners:UIRectCornerAllCorners
                                                     cornerRadii:cornerRadiusSize];
        }else{/// 一个section里面有多个item
            if(indexPath.row == 0){/// 首行 = 左上、右上角为圆角
                bezierPath = [UIBezierPath bezierPathWithRoundedRect:bounds
                                                   byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerTopRight)
                                                         cornerRadii:cornerRadiusSize];
            }else if (indexPath.row == numberOfRowsInSection - 1){/// 末行 = 左下、右下角为圆角
                bezierPath = [UIBezierPath bezierPathWithRoundedRect:bounds
                                                   byRoundingCorners:(UIRectCornerBottomLeft | UIRectCornerBottomRight)
                                                         cornerRadii:cornerRadiusSize];
            }else{/// 中间的都为矩形
                bezierPath = [UIBezierPath bezierPathWithRect:bounds];
            }
        }
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
        [self.layer insertSublayer:layer atIndex:0];
    }
    /// 除了最后一行以外，所有的cell的最下面的线的颜色为bottomLineCor
    [self tableViewMakesLastRowCellAtIndexPath:indexPath
                                        bounds:bounds
                         numberOfRowsInSection:numberOfRowsInSection
                                   borderWidth:borderWidth
                                 bottomLineCor:bottomLineCor];
    /// 除了第一行以外，所有的cell的最上面的线为bottomLineCor
    [self tableViewMakesFirstRowCellAtIndexPath:indexPath
                                         bounds:bounds
                          numberOfRowsInSection:numberOfRowsInSection
                                  bottomLineCor:bottomLineCor
                                    borderWidth:borderWidth];
}
```

#### 1.1.2、除了最后一行以外，所有的cell的最下面的线的颜色为bottomLineCor

```objective-c
-(void)tableViewMakesLastRowCellAtIndexPath:(NSIndexPath *_Nonnull)indexPath
                                     bounds:(CGRect)bounds
                      numberOfRowsInSection:(NSInteger)numberOfRowsInSection
                                borderWidth:(CGFloat)borderWidth
                              bottomLineCor:(UIColor *_Nullable)bottomLineCor{
    if (!indexPath) return;
    if (!bottomLineCor) bottomLineCor = UIColor.whiteColor;
    if (indexPath.row != numberOfRowsInSection - 1) {
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
        [self.layer insertSublayer:layer atIndex:1];
    }
}
```

#### 1.1.3、除了第一行以外，所有的cell的最上面的线为bottomLineCor

```objective-c
-(void)tableViewMakesFirstRowCellAtIndexPath:(NSIndexPath *_Nonnull)indexPath
                                      bounds:(CGRect)bounds
                       numberOfRowsInSection:(NSInteger)numberOfRowsInSection
                               bottomLineCor:(UIColor *_Nullable)bottomLineCor
                                 borderWidth:(CGFloat)borderWidth{
    if (!indexPath) return;
    if (!bottomLineCor) bottomLineCor = UIColor.whiteColor;
    if(indexPath.row){
        UIBezierPath *linePath = UIBezierPath.bezierPath;
        /// 起点
        [linePath moveToPoint:CGPointMake(bounds.origin.x, 0)];
        /// 其他点
        [linePath addLineToPoint:CGPointMake(bounds.origin.x + bounds.size.width,0)];
        /// 新建一个图层
        CAShapeLayer *layer3 = CAShapeLayer.layer;
        layer3.borderWidth = borderWidth;
        layer3.path = linePath.CGPath;
        layer3.strokeColor = bottomLineCor.CGColor;
        /// 将图层添加到cell的图层中,并插到最底层
        [self.layer insertSublayer:layer3 atIndex:1];
    }
}
```

#### 1.1.4、调用示例

* 以section为单位，每个section的第一行和最后一行的cell圆角化处理【cell之间没有分割线】

```objective-c
- (void)tableView:(UITableView *)tableView
  willDisplayCell:(UITableViewCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath{
    [cell cutFirstAndLastTableViewCellWithBackgroundCor:JobsRedColor
                                          bottomLineCor:JobsGreenColor
                                         cellOutLineCor:JobsYellowColor
                                       cornerRadiusSize:CGSizeMake(JobsWidth(8), JobsWidth(8)) borderWidth:JobsWidth(.5f)
                                                     dx:0
                                                     dy:0];
}
```

### 1.2、X、Y的偏移量

* 对单个cell的偏移：需要在cell的子类里面复写父类方法-(void)setFrame:(CGRect)frame

*详见@implementation UITableViewCell (Margin)*

```objective-c
// 需要在具体的子类去实现
// 如果在分类调用，则出现异常
-(void)setFrame:(CGRect)frame{
    NSLog(@"self.offsetXForEach = %f",self.offsetXForEach);
    NSLog(@"self.offsetYForEach = %f",self.offsetYForEach);
    frame.origin.x += self.offsetXForEach;
    frame.origin.y += self.offsetYForEach;
    frame.size.height -= self.offsetYForEach * 2;
    frame.size.width -= self.offsetXForEach * 2;
    [super setFrame:frame];
}
```

* 但是对于以section为单位基准的圆角处理

```
参见：1.1的调用示例
```

## 2、关于UICollectionView.UICollectionViewCell

### 2.1、圆切角

#### 2.1.1、对UICollectionView上的每一组的第一个和最后一个UICollectionViewCell进行圆切角

* 对UICollectionView上的每一组的第一个和最后一个UICollectionViewCell进行圆切角
* 要求切第一个UICollectionViewCell的左上+右上，最后一个UICollectionViewCell的左下和右下

* 作用域 ：UICollectionViewCell子类的 - (void)drawRect:(CGRect)rect
* 注意：⚠️不能写在UICollectionViewDelegate的 -(void)collectionView:(UICollectionView *)collectionView  willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath方法里面，因为此时-(NSIndexPath *)jobsGetCurrentIndexPath；返回nil

```objective-c
-(void)cutFirstAndLastCollectionViewCellWithBackgroundCor:(UIColor *_Nullable)cellBgCor
                                           cellOutLineCor:(UIColor *_Nullable)cellOutLineCor
                                            bottomLineCor:(UIColor *_Nullable)bottomLineCor
                                              borderWidth:(CGFloat)borderWidth
                                         cornerRadiusSize:(CGSize)cornerRadiusSize
                                                       dx:(CGFloat)dx
                                                       dy:(CGFloat)dy{
    if(!cellBgCor) cellBgCor = JobsGreenColor;
    if(!borderWidth) borderWidth = 1.0f;
    if (!bottomLineCor) bottomLineCor = UIColor.whiteColor;
    CGRect bounds = [self dx:dx dy:dy];
    
    NSIndexPath *indexPath = self.jobsGetCurrentIndexPath;
//    NSInteger numberOfSections = self.jobsGetCurrentNumberOfSections;
    NSInteger numberOfItemsInSection = self.jobsGetCurrentNumberOfItemsInSection;

    {
        // 绘制曲线
        UIBezierPath *bezierPath = nil;
        {
            if(numberOfItemsInSection <= 1){/// 一个section里面只有一个item = 四个角都为圆角
                bezierPath = [UIBezierPath bezierPathWithRoundedRect:bounds
                                                   byRoundingCorners:UIRectCornerAllCorners
                                                         cornerRadii:cornerRadiusSize];
            }else{/// 一个section里面有多个item
                if(indexPath.row == 0){/// 首行 = 左上、右上角为圆角
                    bezierPath = [UIBezierPath bezierPathWithRoundedRect:bounds
                                                       byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerTopRight)
                                                             cornerRadii:cornerRadiusSize];
                }else if (indexPath.row == numberOfItemsInSection - 1){/// 末行 = 左下、右下角为圆角
                    bezierPath = [UIBezierPath bezierPathWithRoundedRect:bounds
                                                       byRoundingCorners:(UIRectCornerBottomLeft | UIRectCornerBottomRight)
                                                             cornerRadii:cornerRadiusSize];
                }else{/// 中间的都为矩形
                    bezierPath = [UIBezierPath bezierPathWithRect:bounds];
                }
            }
        }
        
        {
            CAShapeLayer *layer1 = CAShapeLayer.layer;/// 新建一个图层
            layer1.borderWidth = borderWidth;/// 线宽
            layer1.path = bezierPath.CGPath;/// 图层边框路径
            layer1.fillColor = cellBgCor.CGColor;/// 图层填充色,也就是cell的底色
            layer1.strokeColor = cellOutLineCor.CGColor;/// 图层边框线条颜色
            [self.layer insertSublayer:layer1 atIndex:0];/// 将图层添加到cell的图层中,并插到最底层
        }
        /// 除了最后一行以外，所有的cell的最下面的线为bottomLineCor
        [self makeBottomLineWithIndexPath:indexPath
                                   bounds:bounds
                   numberOfItemsInSection:numberOfItemsInSection
                              borderWidth:borderWidth
                            bottomLineCor:bottomLineCor];
        /// 除了第一行以外，所有的cell的最上面的线为bottomLineCor
        [self makeTopLineWithIndexPath:indexPath
                                bounds:bounds
                numberOfItemsInSection:numberOfItemsInSection
                           borderWidth:borderWidth
                         bottomLineCor:bottomLineCor];
    }
}
```

* 除了最后一行以外，所有的cell的最下面的线为bottomLineCor

```
-(void)makeBottomLineWithIndexPath:(NSIndexPath *)indexPath
                            bounds:(CGRect)bounds
            numberOfItemsInSection:(NSInteger)numberOfItemsInSection 
                       borderWidth:(CGFloat)borderWidth
                     bottomLineCor:(UIColor *_Nullable)bottomLineCor{
    if (indexPath.row != numberOfItemsInSection - 1) {
        UIBezierPath *linePath = UIBezierPath.bezierPath;
        /// 起点
        [linePath moveToPoint:CGPointMake(bounds.origin.x, bounds.size.height)];
        /// 其他点
        [linePath addLineToPoint:CGPointMake(bounds.origin.x + bounds.size.width, bounds.size.height)];
        /// 新建一个图层
        CAShapeLayer *layer2 = CAShapeLayer.layer;
        layer2.borderWidth = borderWidth;
        layer2.path = linePath.CGPath;
        layer2.strokeColor = bottomLineCor.CGColor;
        /// 将图层添加到cell的图层中,并插到最底层
        [self.layer insertSublayer:layer2 atIndex:1];
    }
}
```

* 除了第一行以外，所有的cell的最上面的线为bottomLineCor

```
-(void)makeTopLineWithIndexPath:(NSIndexPath *)indexPath
                         bounds:(CGRect)bounds
         numberOfItemsInSection:(NSInteger)numberOfItemsInSection
                    borderWidth:(CGFloat)borderWidth
                  bottomLineCor:(UIColor *_Nullable)bottomLineCor{
    if(indexPath.row){
        UIBezierPath *linePath = UIBezierPath.bezierPath;
        /// 起点
        [linePath moveToPoint:CGPointMake(bounds.origin.x, 0)];
        /// 其他点
        [linePath addLineToPoint:CGPointMake(bounds.origin.x + bounds.size.width,0)];
        /// 新建一个图层
        CAShapeLayer *layer3 = CAShapeLayer.layer;
        layer3.borderWidth = borderWidth;
        layer3.path = linePath.CGPath;
        layer3.strokeColor = bottomLineCor.CGColor;
        /// 将图层添加到cell的图层中,并插到最底层
        [self.layer insertSublayer:layer3 atIndex:1];
    }
}
```

#### 2.1.2、利用UIBezierPath，对 UICollectionViewCell 描边 + 切角

* 作用域 ：UICollectionViewCell子类的 - (void)drawRect:(CGRect)rect

```objective-c
-(void)outlineByBezierPath:(UIBorderSideType)borderSideType
         cellBackgroundCor:(UIColor *)cellBackgroundCor
               borderColor:(UIColor *)borderColor
               borderWidth:(CGFloat)borderWidth
          cornerRadiusSize:(CGSize)cornerRadiusSize
           roundingCorners:(UIRectCorner)roundingCorners{
    if(!borderColor) borderColor = JobsRedColor;
    if(!cellBackgroundCor) cellBackgroundCor = JobsGreenColor;
    if(!borderWidth) borderWidth = 1.0f;
     // 创建一个贝塞尔曲线
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                               byRoundingCorners:roundingCorners
                                                     cornerRadii:cornerRadiusSize];
    // 设置填充颜色为背景颜色，以保留原始背景
    [cellBackgroundCor setFill];
    [path fill];
     
    // 设置边框的属性
    [borderColor setStroke];// 设置边框颜色
    path.lineWidth = borderWidth; // 设置边框宽度
     
    // 添加路径到上下文中并绘制
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddPath(context, path.CGPath);
    CGContextDrawPath(context, kCGPathStroke);
}
```

#### 2.1.3、利用CALayer，对 UICollectionViewCell 只描边、不切角

* 作用域 ：UICollectionViewCell子类的 - (void)drawRect:(CGRect)rect

```objective-c
-(void)outlineByLayer:(UIBorderSideType)borderSideType
          borderColor:(UIColor *)borderColor
          borderWidth:(CGFloat)borderWidth{
    
    if(!borderColor) borderColor = JobsRedColor;
    if(!borderWidth) borderWidth = 1.0f;
    
    CALayer *topBorder = nil;
    CALayer *bottomBorder = nil;
    CALayer *leftBorder = nil;
    CALayer *rightBorder = nil;
    
    if(borderSideType & UIBorderSideTypeTop || borderSideType & UIBorderSideTypeAll){
        topBorder = CALayer.layer;
        topBorder.borderColor = borderColor.CGColor; // 选择你想要的颜色
        topBorder.borderWidth = borderWidth;// 选择边框的宽度
        // 设置边框的位置和大小
        topBorder.frame = CGRectMake(0,
                                     0,
                                     self.contentView.frame.size.width,
                                     borderWidth);
    }
    
    if(borderSideType & UIBorderSideTypeBottom || borderSideType & UIBorderSideTypeAll){
        bottomBorder = CALayer.layer;
        bottomBorder.borderColor = borderColor.CGColor; // 选择你想要的颜色
        bottomBorder.borderWidth = borderWidth;// 选择边框的宽度
        // 设置边框的位置和大小
        bottomBorder.frame = CGRectMake(0,
                                        self.contentView.frame.size.height - borderWidth,
                                        self.contentView.frame.size.width,
                                        borderWidth);
    }
    
    if(borderSideType & UIBorderSideTypeLeft || borderSideType & UIBorderSideTypeAll){
        leftBorder = CALayer.layer;
        leftBorder.borderColor = borderColor.CGColor; // 选择你想要的颜色
        leftBorder.borderWidth = borderWidth;// 选择边框的宽度
        // 设置边框的位置和大小
        leftBorder.frame = CGRectMake(0,
                                      0,
                                      borderWidth,
                                      self.contentView.frame.size.height);
    }
    
    if(borderSideType & UIBorderSideTypeRight || borderSideType & UIBorderSideTypeAll){
        rightBorder = CALayer.layer;
        rightBorder.borderColor = borderColor.CGColor; // 选择你想要的颜色
        rightBorder.borderWidth = borderWidth;// 选择边框的宽度
        // 设置边框的位置和大小
        rightBorder.frame = CGRectMake(self.contentView.frame.size.width - borderWidth,
                                       0,
                                       borderWidth,
                                       self.contentView.frame.size.height);
    }
    
    if(topBorder) [self.contentView.layer addSublayer:topBorder];
    if(bottomBorder) [self.contentView.layer addSublayer:bottomBorder];
    if(leftBorder) [self.contentView.layer addSublayer:leftBorder];
    if(rightBorder) [self.contentView.layer addSublayer:rightBorder];
}
```

## 3、指定对某个View的某个角进行圆切角

* 在这个View的具体子类里面，复写系统方法-(**void**)layoutSubviews;

```objective-c
-(void)layoutSubviews{
    [super layoutSubviews];
    /// 内部指定圆切角
    [self layoutSubviewsCutCnrByRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight
                                    cornerRadii:CGSizeMake(JobsWidth(8), JobsWidth(8))];
}
```

## 4、对某个View的4个角无差别进行圆切角

```objective-c
[View cornerCutToCircleWithCornerRadius:JobsWidth(8)];
[View layerBorderCor:RGBA_COLOR(255, 225, 144, 1) andBorderWidth:JobsWidth(0.5f)];
```

## 5、其他

* 隐藏每个分区最后一个cell的分割线:系统分割线,移到屏幕外

```objective-c
 - (void)tableView:(UITableView *)tableView
   willDisplayCell:(UITableViewCell *)cell
 forRowAtIndexPath:(NSIndexPath *)indexPath{
 	 _tableView.separatorColor = HEXCOLOR(0xeeeeee);//改变分割线颜色
	 cell.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);//改变分割线长度
 }
```

