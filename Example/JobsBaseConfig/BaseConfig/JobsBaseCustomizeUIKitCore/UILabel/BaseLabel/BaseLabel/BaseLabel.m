//
//  AutoScrollLabel.m
//  JobsBaseConfig
//
//  Created by Jobs on 2022/1/18.
//

#import "BaseLabel.h"

@interface BaseLabel ()
/// Data
@property(nonatomic,assign)JobsReturnIDByGestureRecognizerBlock tapGRBlock;
@property(nonatomic,assign)JobsReturnIDByGestureRecognizerBlock longPressGRBlock;

@end

@implementation BaseLabel

-(instancetype)init{
    if (self = [super init]) {
        
    }return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        {/// 配置相关手势
            self.numberOfTouchesRequired = 1;
            self.numberOfTapsRequired = 1;/// ⚠️注意：如果要设置长按手势，此属性必须设置为0⚠️
            self.minimumPressDuration = 0.1;
            self.numberOfTouchesRequired = 1;
            self.allowableMovement = 1;
            self.userInteractionEnabled = YES;
            self.target = self;
            @jobs_weakify(self)
            self.longPressGR_SelImp.selector = [self jobsSelectorBlock:^(id _Nullable target, UILongPressGestureRecognizer *_Nullable arg) {
                @jobs_strongify(self)
//                [self 长按手势:arg];
                if (self.longPressGRBlock) self.longPressGRBlock(arg);
            }];
            self.tapGR_SelImp.selector = [self jobsSelectorBlock:^(id _Nullable target, UITapGestureRecognizer *_Nullable arg) {
                @jobs_strongify(self)
//                [self 点击手势:arg];
                if (self.tapGRBlock) self.tapGRBlock(arg);
            }];
        }
    }return self;
}
#pragma mark —— 一些私有方法
-(void)长按手势:(UIGestureRecognizer *)arg{
    if (self.longPressGRBlock) self.longPressGRBlock(arg);
}

-(void)点击手势:(UIGestureRecognizer *)arg{
    if (self.tapGRBlock) self.tapGRBlock(arg);
}
#pragma mark —— 一些公有方法
-(void)actionTapGRBlock:(JobsReturnIDByGestureRecognizerBlock _Nullable)tapGRBlock{
    self.tapGRBlock = tapGRBlock;
    self.tapGR.enabled = (BOOL)self.tapGRBlock;/// 必须在设置完Target和selector以后方可开启执行
}

-(void)actionLongPressGRBlock:(JobsReturnIDByGestureRecognizerBlock _Nullable)longPressGRBlock{
    self.longPressGRBlock = longPressGRBlock;
    self.longPressGR.enabled = (BOOL)self.longPressGRBlock;/// 必须在设置完Target和selector以后方可开启执行
}
/// UILabel文字的复制
-(void)copyText{
    [self.text pasteboard];
    NSLog(@"%@%@",Internationalization(@"复制的文字："),self.text.pasteboard);
}
#pragma mark —— UIGestureRecognizerDelegate
/// 解决 UITableViewCell和手势冲突 https://blog.csdn.net/FreeTourW/article/details/51911416
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
      shouldReceiveTouch:(UITouch *)touch {
    return ![NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"];
}
#pragma mark —— 复写相关父类方法
- (void)drawRect:(CGRect)rect{
    if (self.labelShowingType == UILabelShowingType_02) {
        self.layer.masksToBounds = YES;
        if (!self.shouldAutoScroll){
            [super drawRect:rect];
        }
        [self setTextLayerScroll];
    }else{
        [super drawRect:rect];
    }
}

-(void)setFrame:(CGRect)frame{
    if (self.labelShowingType == UILabelShowingType_02) {
        [self setTextLayerScroll];
    }else{
        [super setFrame:frame];
    }
}
/// 修改绘制文字的区域，edgeInsets增加bounds
- (CGRect)textRectForBounds:(CGRect)bounds
     limitedToNumberOfLines:(NSInteger)numberOfLines {
    CGRect rect = [super textRectForBounds:UIEdgeInsetsInsetRect(bounds, self.edgeInsets)
                    limitedToNumberOfLines:numberOfLines];
    rect.origin.x -= self.edgeInsets.left;
    rect.origin.y -= self.edgeInsets.top;
    rect.size.width += self.edgeInsets.left + self.edgeInsets.right;
    rect.size.height += self.edgeInsets.top + self.edgeInsets.bottom;
    return rect;
}
/// 绘制文字
- (void)drawTextInRect:(CGRect)rect {
    CGRect newRect = rect;
    newRect.origin.y += self.offsetY;
    newRect.origin.x += self.offsetX;
    
    if (self.text && ![self.text isEqualToString:@""]) {
        [super drawTextInRect:UIEdgeInsetsInsetRect(newRect, self.edgeInsets)];
        self.hidden = NO;
    } else {
        [super drawTextInRect:UIEdgeInsetsInsetRect(newRect, UIEdgeInsetsZero)];
        self.hidden = YES;
    }
}
#pragma mark —— LazyLoad
-(JobsReturnIDByGestureRecognizerBlock)tapGRBlock{
    if (!_tapGRBlock) {
        _tapGRBlock = ^id(UIGestureRecognizer *data) {
            NSLog(@"JobsBaseLabel的Tap手势");
            return @1;
        };
    }return _tapGRBlock;
}

-(JobsReturnIDByGestureRecognizerBlock)longPressGRBlock{
    if (!_longPressGRBlock) {
        _longPressGRBlock = ^id(UIGestureRecognizer *data) {
            NSLog(@"JobsBaseLabel的LongPress手势");
            return @1;
        };
    }return _longPressGRBlock;
}

@end
