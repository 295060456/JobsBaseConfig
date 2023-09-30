//
//  CollectionViewCell.m
//  UBallLive
//
//  Created by Jobs on 2020/10/18.
//

#import "BaseCollectionViewCell.h"

@interface BaseCollectionViewCell ()
/// UI
@property(nonatomic,strong)UITextView *textView;
@property(nonatomic,strong)UIButton *bgBtn;

@end

@implementation BaseCollectionViewCell

@synthesize viewModel = _viewModel;

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
//        [self richElementsInCellWithModel:nil];
    }return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
}
#pragma mark —— UICollectionViewCellProtocol
+(instancetype)cellWithCollectionView:(nonnull UICollectionView *)collectionView
                         forIndexPath:(nonnull NSIndexPath *)indexPath{
    BaseCollectionViewCell *cell = (BaseCollectionViewCell *)[collectionView collectionViewCellClass:BaseCollectionViewCell.class forIndexPath:indexPath];
    if (!cell) {
        [collectionView registerCollectionViewCellClass:BaseCollectionViewCell.class];
        cell = (BaseCollectionViewCell *)[collectionView collectionViewCellClass:BaseCollectionViewCell.class forIndexPath:indexPath];
    }
    
    // UICollectionViewCell圆切角
//    cell.contentView.layer.cornerRadius = cell.layer.cornerRadius = JobsWidth(8);
//    cell.contentView.layer.borderWidth = cell.layer.borderWidth = JobsWidth(1);
//    cell.contentView.layer.borderColor = cell.layer.borderColor = RGBA_COLOR(255, 225, 144, 1).CGColor;
//    cell.contentView.layer.masksToBounds = cell.layer.masksToBounds = YES;

    cell.indexPath = indexPath;
    
    return cell;
}

-(UITextView *)getTextView{
    return self.textView;
}

-(UIButton *)getBgBtn{
    return self.bgBtn;
}
#pragma mark —— 复写父类相关方法和属性
-(void)setSelected:(BOOL)selected{
    [super setSelected:selected];
}
#pragma mark —— BaseCellProtocol
/// 具体由子类进行复写【数据尺寸】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
+(CGSize)cellSizeWithModel:(UIViewModel *_Nullable)model{
    return CGSizeZero;
}
/// 具体由子类进行复写【数据定UI】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
-(void)richElementsInCellWithModel:(UIViewModel *_Nullable)model{
    self.viewModel = model;
    /// 如果有图片则只显示这个图片，并铺满
    BOOL A = model.bgImage || model.image;
    BOOL B = (![model.textModel.text isEqualToString:Internationalization(TextModelDataString)] && model.textModel.text) || model.textModel.attributedText;

    if (A || self.forceUseBgBtn) {
        self.bgBtn.jobsVisible = A || self.forceUseBgBtn;
        return;
    }
    /// 如果有文字（普通文本 或者富文本）则只显示这个文字（普通文本 或者富文本），并铺满
    if (B || self.forceUsetextView) {
        /// ❤️textView 和 bgBtn不能共存❤️
        self.bgBtn.jobsVisible = !B || self.forceUsetextView;
        self.textView.jobsVisible = B || self.forceUsetextView;
        return;
    }
}
#pragma mark —— 一些私有方法
/// 利用UIBezierPath，对 UICollectionViewCell 描边 + 切角
/// 作用域 ：- (void)drawRect:(CGRect)rect
/// - Parameters:
///   - borderSideType: 描边方位
///   - cellBackgroundCor: UICollectionViewCell 的背景色
///   - borderColor: 描边颜色
///   - borderWidth: 描边线宽
///   - cornerRadiusSize: 切角弧度
///   - roundingCorners: 切角方位
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
                                               byRoundingCorners:(roundingCorners)
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
/// 利用CALayer，对 UICollectionViewCell 只描边、不切角
/// 作用域 ：- (void)drawRect:(CGRect)rect
/// - Parameters:
///   - borderSideType: 描边方位
///   - borderColor: 描边颜色
///   - borderWidth: 描边线宽
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
#pragma mark —— <UIViewModelProtocol> 协议属性合成set & get方法
@synthesize indexPath = _indexPath;
-(void)setIndexPath:(NSIndexPath *)indexPath{
    _indexPath = indexPath;
}

-(NSIndexPath *)indexPath{
    return _indexPath;
}
@synthesize index = _index;
-(NSInteger)index{
    return _index;
}

-(void)setIndex:(NSInteger)index{
    _index = index;
}
#pragma mark —— lazyLoad
-(UIButton *)bgBtn{
    if (!_bgBtn) {
        _bgBtn = UIButton.new;
        _bgBtn.userInteractionEnabled = NO;
        [self.contentView addSubview:_bgBtn];
        [_bgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
    }
    _bgBtn.normalImage = self.viewModel.image;
    _bgBtn.normalTitle = self.viewModel.textModel.text;
    _bgBtn.normalBackgroundImage = self.viewModel.bgImage;
    _bgBtn.normalAttributedTitle = self.viewModel.textModel.attributedText;
    _bgBtn.normalTitleColor = self.viewModel.textModel.textCor;
    
    _bgBtn.selectedImage = self.viewModel.selectedImage;
    _bgBtn.selectedTitle = self.viewModel.textModel.selectedText;
    _bgBtn.selectedBackgroundImage = self.viewModel.bgSelectedImage;
    _bgBtn.selectedAttributedTitle = self.viewModel.textModel.selectedAttributedText;
    _bgBtn.selectedTitleColor = self.viewModel.textModel.selectedTextCor;
    
    _bgBtn.titleFont = self.viewModel.textModel.font;
    _bgBtn.titleAlignment = self.viewModel.textModel.textAlignment;
//        _bgBtn.makeNewLineShows = self.viewModel.textModel.lineBreakMode;
    [_bgBtn layoutButtonWithEdgeInsetsStyle:self.viewModel.buttonEdgeInsetsStyle
                            imageTitleSpace:self.viewModel.imageTitleSpace];
    return _bgBtn;
}

-(UITextView *)textView{
    if (!_textView) {
        _textView = UITextView.new;
        _textView.editable = NO;
        _textView.userInteractionEnabled = NO;
        _textView.textColor = self.selected ? self.viewModel.textModel.selectedTextCor : self.viewModel.textModel.textCor;
        [self.contentView addSubview:_textView];
        [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
        [self layoutIfNeeded];
        @jobs_weakify(self)
        [_textView jobsTextViewFilterBlock:^BOOL(id data) {
            @jobs_strongify(self)
            return YES;
        } subscribeNextBlock:^(id data) {
            @jobs_strongify(self)
        }];
    }
    NSLog(@"SSS = %d,self = %@",self.selected,self);
//    _textView.attributedText = self.viewModel.textModel.attributedText;
    _textView.font = self.viewModel.textModel.font;
    _textView.textAlignment = self.viewModel.textModel.textAlignment;
    _textView.text = self.viewModel.textModel.text;
    [_textView contentSizeToFitByFont:_textView.font];
    NSLog(@"textView.text = %@",_textView.text);
    return _textView;
}

@end
