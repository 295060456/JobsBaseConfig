//
//  LikeButton.m
//  EmitterAnimation
//
//  Created by 刘庆贺 on 2019/3/13.
//  Copyright © 2019 lmh. All rights reserved.
//

#import "RBCLikeButton.h"

#define leftTime 0.5

@interface RBCLikeButton()

@property(nonatomic,strong)CAEmitterLayer * explosionLayer;
@property(nonatomic,strong)UIImageView *backImageView;
@property(nonatomic,strong)UILabel *incLabel;
@property(nonatomic,assign)BOOL isNeedAnimation;/// 选中/取消时是否需要动画
@property(nonatomic,strong)UILabel *countLabel;/// 点赞数量Label

@end

@implementation RBCLikeButton {
    //记录初始"上升数字"label的Y值
    CGFloat _incOrginY;
    RBCLikeButtonType _type;
}

- (instancetype)initWithFrame:(CGRect)frame
                         type:(RBCLikeButtonType)type{
    if (self = [super initWithFrame:frame]) {
        _type = type;
        _isNeedAnimation = YES;
        [self setupExplosion];//初始化粒子动画
        [self setupBackWithFrame:frame];//初始化其他控件
    }return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _type = RBCLikeButtonTypeImageleft;
        _isNeedAnimation = YES;
        [self setupExplosion];/// 初始化粒子动画
        [self setupBackWithFrame:frame];/// 初始化其他控件
    }return self;
}

- (void)setupBackWithFrame:(CGRect)frame {
    //1.初始化👍View
    UIImageView *backImageView = [UIImageView.alloc initWithImage:JobsBuddleIMG(@"bundle",
                                                                                @"RBCLikeButton",
                                                                                nil,
                                                                                @"day_like_red")];
    backImageView.alpha = 0;
    [self addSubview:backImageView];
    self.backImageView = backImageView;
    /// 2.初始化"+1"上升label
    UILabel *incLabel = UILabel.new;
    incLabel.font = UIFontWeightRegularSize(13);
    incLabel.textColor = HEXCOLOR(0xFD5656);
    incLabel.textAlignment = NSTextAlignmentCenter;
    incLabel.text = @"+1";
    incLabel.alpha = 0;
    incLabel.numberOfLines = 1;
    [self addSubview:incLabel];
    self.incLabel = incLabel;
    /// 3.初始化总点赞数label
    UILabel *countLabel = UILabel.new;
    countLabel.font = UIFontWeightRegularSize(12);
    countLabel.textColor = HEXCOLOR(0xCFD2D6);
    if (_type == RBCLikeButtonTypeImageleft) {
        countLabel.textAlignment = NSTextAlignmentLeft;
    }else{
        countLabel.textAlignment = NSTextAlignmentCenter;
    }
    countLabel.text = @"0";
    countLabel.numberOfLines = 1;
    [self addSubview:countLabel];
    self.countLabel = countLabel;
    /// 4.设置粒子动画发射源的位置
    self.explosionLayer.position = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5);
    /// 5.设置"+1"上升label的frame
    CGFloat height = 30;
    CGFloat width = height;
    self.incLabel.frame = CGRectMake((self.width - width)/2, (self.height - height)/2, width, height);
    /// 6.记录"+1"上升label的初始Y值
    _incOrginY = self.incLabel.frame.origin.y;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    /// 1.确定👍View的frame
    self.backImageView.frame = self.imageView.frame;
    /// 2.确定总赞数label的frame
    CGFloat countLabelWidth = 30;
    if (_type == RBCLikeButtonTypeImageleft) {
        self.countLabel.frame = CGRectMake(CGRectGetMaxX(self.imageView.frame)+5,
                                           self.imageView.top + (self.imageView.height - 15)/2 + 0.5,
                                           countLabelWidth,
                                           15);
    }else{
        self.countLabel.frame = CGRectMake((self.width - countLabelWidth)/2,
                                           self.height,
                                           countLabelWidth,
                                           15);
    }
}
/// 设置粒子动画
-(void)setupExplosion{
    CAEmitterCell * explosionCell = CAEmitterCell.emitterCell;/// 1. 粒子
    explosionCell.alphaSpeed = -1.0;/// 透明度变化速度
    explosionCell.alphaRange = 0.5;/// 透明度变化范围
    explosionCell.lifetime = leftTime;/// 粒子存在时间
    explosionCell.lifetimeRange = 0.5;/// 粒子存在时间的范围
    explosionCell.birthRate = 15;/// 每个cell可以释放多少个粒子
    explosionCell.velocity = 75.f;/// 粒子扩散的速度
    explosionCell.velocityRange = 10.f;/// 粒子扩散的速度上下区间 +10 or -10
    //最大 - M_PI_4/2  粒子发射方向
    explosionCell.emissionLongitude = - M_PI_2;
    explosionCell.emissionRange = M_PI_2;
    explosionCell.scale = 0.08;/// 粒子形变大小
    //explosionCell.scaleRange = 0.02;/// 形变范围
    explosionCell.contents = (id)[JobsBuddleIMG(@"bundle",@"RBCLikeButton",nil, @"spark_red") CGImage];/// 粒子内容
    explosionCell.color = HEXCOLOR(0xFE6262).CGColor;/// 粒子初始颜色
    /// 粒子其他混合颜色
    explosionCell.redRange = 10;
    explosionCell.greenRange = 10;
    explosionCell.blueRange = 10;
    /// 混合色颜色变化速度
    explosionCell.redSpeed = 10;
    explosionCell.greenSpeed = 10;
    explosionCell.blueSpeed = 10;
   
    CAEmitterLayer * explosionLayer = CAEmitterLayer.layer;/// 2.发射源
    [self.layer addSublayer:explosionLayer];
    self.explosionLayer = explosionLayer;
    //发射位置 - 粒子从哪里出现开始扩散
    //self.explosionLayer.emitterSize = CGSizeMake(self.bounds.size.width + 3, self.bounds.size.height + 3);
    explosionLayer.emitterShape = kCAEmitterLayerPoint;/// 发射源的形状
    explosionLayer.birthRate = 0;/// 每秒发射cell的数量
    explosionLayer.emitterMode = kCAEmitterLayerVolume;/// 发射模式: 从发射体的哪个位置发出c粒子: 某个点,表面,边缘,体内(3D)
    explosionLayer.renderMode = kCAEmitterLayerAdditive;/// 粒子的渲染模式
    explosionLayer.emitterCells = @[explosionCell];
}
/// 选中状态
- (void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    if (selected) {  // 从取消状态到点击状态
        /// 1.隐藏点赞label
        self.countLabel.alpha = 0;
        self.countLabel.textColor = HEXCOLOR(0xFD5656);
        /// 不需要动画时,返回,不需要动画说明是获取数据后的赋值操作
        if (!_isNeedAnimation) {
            self.countLabel.alpha = 1;
            return;
        }
        /// 2.放大拳头动画
        [self enlargementAnimation];
        /// 开始动画时展示"+1"上升label,先隐藏它
        self.incLabel.hidden = NO;
        /// 延迟这里有问题,延迟时间设置为0则没有问题,如果添加了延时时间,那么已经开始的动画无法移除
        /// 3.执行上升数字动画
        [self performSelector:@selector(countAnimation) withObject:nil afterDelay:0.0];
        /// 4.执行粒子动画
        [self performSelector:@selector(startAnimation) withObject:nil afterDelay:0.2];
        /// 5.点赞数出现动画
        [self performSelector:@selector(countLabelAppearAnimation) withObject:nil afterDelay:0.5];
    }else{
        /// 从点击状态normal状态 无动画效果 如果点赞之后马上取消 那么也立马停止动画
        /// 手动取消赞时,隐藏"+1"上升label
        self.incLabel.hidden = YES;
        self.incLabel.alpha = 0;
        [self.incLabel.layer removeAllAnimations];
        self.countLabel.textColor = HEXCOLOR(0xCFD2D6);
    }
}
/// 当点赞数改变时,就改变
- (void)setThumpNum:(NSInteger)thumpNum {
    _thumpNum = thumpNum;
    self.countLabel.text = [self getSentenceListStandardWithString:[NSString stringWithFormat:@"%ld",thumpNum]];
}

- (void)setThumbWithSelected:(BOOL)selected
                    thumbNum:(NSInteger)thumbNum
                   animation:(BOOL)animation {
    self.isNeedAnimation = animation;
    self.selected = selected;
    self.thumpNum = thumbNum;
}

- (void)cancelLike{
    self.isNeedAnimation = NO;
    self.selected = NO;
}

- (void)recoverLike {
    self.isNeedAnimation = NO;
    self.thumpNum += 1;
    self.selected = YES;
}
/// 开始粒子动画
- (void)startAnimation{
    self.explosionLayer.birthRate = 1;/// 设置颗粒个数
    self.explosionLayer.beginTime = CACurrentMediaTime() - 0.2;/// 开始动画
    [self performSelector:@selector(autoStopAnimation) withObject:nil afterDelay:leftTime];/// 延迟停止动画
}
/// 自动结束粒子动画
- (void)autoStopAnimation{
    // 用KVC设置颗粒个数
    self.explosionLayer.birthRate = 0;
    [self.explosionLayer removeAllAnimations];
}
/// 手动结束动画
- (void)manualStopAnimation {
    self.incLabel.alpha = 0;
    [self.incLabel.layer removeAllAnimations];
}
/// 点赞数值出现动画
- (void)countLabelAppearAnimation {
    if (self.selected){ //如果此时取消了点赞,则不执行动画
        CAKeyframeAnimation *animation2 = [CAKeyframeAnimation animationWithKeyPath:@"countLabel"];
        animation2.keyPath = @"opacity";
        animation2.values = @[@0.2,@0.5,@0.8,@1];
        animation2.duration = 0.8;
        animation2.calculationMode = kCAAnimationCubic;
        [self.countLabel.layer addAnimation:animation2 forKey:nil];
    }self.countLabel.alpha = 1;
}
/// 拳头放大动画
- (void)enlargementAnimation {
    
    //通过键帧动画实现缩放
    CAKeyframeAnimation * animation = CAKeyframeAnimation.animation;
    animation.keyPath = @"transform.scale";
    animation.values = @[@1.5,@2.0,@3.5];
    animation.duration = 0.25;
    animation.calculationMode = kCAAnimationCubic;
    self.backImageView.alpha = 0.2;
    [self.backImageView.layer addAnimation:animation forKey:nil];
}

- (void)countAnimation {
    /// 1、添加数字+1透明度动画
    CAKeyframeAnimation *animation0 = CAKeyframeAnimation.animation;
    animation0.keyPath = @"opacity";
    animation0.values = @[@0.5,@0.8,@1.0];
    animation0.duration = 0.5;
    animation0.calculationMode = kCAAnimationCubic;
    [self.incLabel.layer addAnimation:animation0 forKey:nil];
    /// 开始动画时"+1"上升label回到起始位置
    self.incLabel.top = _incOrginY;
    /// 防止label闪烁
    self.incLabel.alpha = 1;
    /// 2、添加"+1"慢慢变大动画
    CAKeyframeAnimation *animationScale = CAKeyframeAnimation.animation;
    animationScale.keyPath = @"transform.scale";
    animationScale.values = @[@1.0,@1.1,@1.2];
    animationScale.duration = 1.0;
    animationScale.calculationMode = kCAAnimationCubic;
    [self.incLabel.layer addAnimation:animationScale forKey:nil];
    /// 3、添加"+1"s向上位移动画
    @jobs_weakify(self)
    [UIView animateWithDuration:0.5
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
        @jobs_strongify(self)
        self.incLabel.top = self->_incOrginY - 18;
    } completion:^(BOOL finished) {
        @jobs_strongify(self)
        /// 4、添加"+1"慢慢消失动画
        CAKeyframeAnimation *animation2 = CAKeyframeAnimation.animation;
        animation2.keyPath = @"opacity";
        animation2.values = @[@0.8,@0.5,@0];
        animation2.duration = 0.5;
        animation2.calculationMode = kCAAnimationCubic;
        [self.incLabel.layer addAnimation:animation2 forKey:nil];
        self.incLabel.alpha = 0;
    }];
}
/// 屏蔽drawRect
-(void)drawRect:(CGRect)rect {}
/// 没有高亮状态
-(void)setHighlighted:(BOOL)highlighted{}

-(NSString *)getSentenceListStandardWithString:(NSString *)orginStr {
    NSInteger orginInt = [orginStr integerValue];
    if (orginInt >= 10000) {
        NSInteger wan = orginInt / 10000;
        NSInteger qian = (orginInt - wan * 10000)/1000;
        return qian > 0 ? [NSString stringWithFormat:@"%ld.%ldw",wan,qian] : [NSString stringWithFormat:@"%ldw",wan];
    }else if (orginInt >= 1000){
        NSInteger qian = orginInt / 1000;
        NSInteger bai = (orginInt - qian * 1000)/100;
        return bai > 0 ? [NSString stringWithFormat:@"%ld.%ldk",qian,bai] :[NSString stringWithFormat:@"%ldk",qian];
    }else return orginStr;
}

@end
