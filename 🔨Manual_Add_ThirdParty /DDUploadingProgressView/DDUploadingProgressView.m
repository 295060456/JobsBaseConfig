//
//  DDUploadingProgressView.m
//  DouDong-II
//
//  Created by xxx on 2021/1/12.
//

#import "DDUploadingProgressView.h"

@interface DDUploadingProgressView()

@property(nonatomic,strong)CAShapeLayer *shapLayer;
@property(nonatomic,strong)UIBezierPath *bezier;
@property(nonatomic,strong)UILabel *refreshLabel;
@property(nonatomic,strong)UIImageView *imgeV;
@property(nonatomic,strong)UILabel *subrefreshLabel;
@property(nonatomic,strong)UIView *backView;
@property(nonatomic,strong)UIView *shapLayerView;
@property(nonatomic,strong)CAKeyframeAnimation *anim;
@property(nonatomic,strong)NSTimerManager *nsTimerManager;

@end

@implementation DDUploadingProgressView

static DDUploadingProgressView *static_uploadingProgressView = nil;
+(instancetype)sharedInstance{
    @synchronized(self){
        if (!static_uploadingProgressView) {
            static_uploadingProgressView = [[DDUploadingProgressView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 267) / 2,
                                                                                                     SCREEN_HEIGHT / 2 - 76,
                                                                                                     267,
                                                                                                     76)];
        }
    }return static_uploadingProgressView;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        static_uploadingProgressView = self;
        [getMainWindow() addSubview:self];
        [getMainWindow() bringSubviewToFront:self];
        self.imge = KIMG(@"icon_upload_imge");
        self.strokeColor = [UIColor colorWithPatternImage:[UIImage imageResize:KIMG(@"gradualColor")
                                                                   andResizeTo:CGSizeMake(50, 25)]]; //圆环底色
        self.radius = 34;

        self.hidden = YES;
        self.backgroundColor = [[UIColor colorWithWhite:0.0 alpha:1.000] colorWithAlphaComponent:0.9];
        self.layer.cornerRadius = 10;
        self.clipsToBounds = YES;
        
    }return self;
}
/**
 *  创建动画
 */
- (void)starAnimation{
    self.shapLayer.hidden = NO;
    self.imgeV.alpha = 1;
}

- (void)updateProgressText:(NSString *)progressText {
    self.hidden = NO;
    self.backView.hidden = NO;
    self.subrefreshLabel.text = progressText;
    if (self.nsTimerManager.timerCurrentStatus == NSTimerCurrentStatusPause) {
        [NSTimerManager nsTimecontinue:self.nsTimerManager];
    }else{
        [self.nsTimerManager nsTimeStartSysAutoInRunLoop];
    }
    [self starAnimation];
}

- (void)dismiss{
    self.hidden = YES;
    self.backView.hidden = YES;
    [self.shapLayer removeAnimationForKey:@"CLAnimation"];
    
    [NSTimerManager nsTimePause:self.nsTimerManager];
    [self.nsTimerManager nsTimeDestroy];

    self.anim = nil;
}
#pragma mark —— lazyLoad
-(NSTimerManager *)nsTimerManager{
    if (!_nsTimerManager) {
        _nsTimerManager = NSTimerManager.new;
        // 顺时针:每一个时间间隔为 1 秒
        _nsTimerManager.timerStyle = TimerStyle_clockwise;
        _nsTimerManager.timeInterval = .5f;
        @weakify(self)
        [_nsTimerManager actionNSTimerManagerRunningBlock:^(id data) {
            @strongify(self)
            if ([self.refreshLabel.text isEqualToString:@"正在上传..."]) {
                self.refreshLabel.text = @"正在上传";
            }else{
                self.refreshLabel.text = [NSString stringWithFormat:@"%@.",self.refreshLabel.text];
            }
        }];
        [_nsTimerManager actionNSTimerManagerFinishBlock:^(id data) {
            NSLog(@"我死球了");
        }];
    }return _nsTimerManager;
}

- (CAShapeLayer *)shapLayer{
    if (!_shapLayer) {
        _shapLayer = CAShapeLayer.layer;
    
        _shapLayer.frame = CGRectMake(0, 0, self.radius, self.radius);
        _shapLayer.fillColor = [UIColor clearColor].CGColor;
        
        _shapLayer.lineWidth = 2.0f;
        _shapLayer.strokeColor = self.strokeColor.CGColor;//线条颜色

        _shapLayer.path = self.bezier.CGPath;
        [self.shapLayerView.layer addSublayer:_shapLayer];
        _shapLayer.strokeStart = 0;
        _shapLayer.strokeEnd = 0.85;
        [_shapLayer addAnimation:self.anim forKey:@"CLAnimation"];
    }return _shapLayer;
}

-(UIBezierPath *)bezier{
    if (!_bezier) {
        _bezier = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, self.radius,self.radius)];//画个圆
    }return _bezier;
}

-(CAKeyframeAnimation *)anim{
    if (!_anim) {
        _anim = CAKeyframeAnimation.animation;
        _anim.keyPath = @"transform.rotation";
        _anim.values = @[@(M_PI/4.0),
                         @(M_PI * 2/4.0),
                         @(M_PI * 3/4.0),
                         @(4 * M_PI /4.0),
                         @(5 *M_PI/4.0),
                         @(6 *M_PI/4.0),
                         @(7 *M_PI/4.0),
                         @(8 * M_PI /4.0),
                         @(8 * M_PI /4.0 + M_PI/4.0)];
        _anim.repeatCount = MAXFLOAT;
        _anim.duration = 1;
        _anim.removedOnCompletion = NO;
        _anim.fillMode = kCAFillModeForwards;
    }return _anim;
}

- (UIView *)shapLayerView{
    if (!_shapLayerView) {
        _shapLayerView = UIView.new;
        [self addSubview:_shapLayerView];
        [self.shapLayerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(self).offset(62);
            make.height.offset(self.radius + 2);
            make.width.offset(self.radius + 2);
        }];
    }return _shapLayerView;
}

-(UIImageView *)imgeV{
    if (!_imgeV) {
        _imgeV = UIImageView.new;
        _imgeV.image = self.imge;
        [self.shapLayerView addSubview:_imgeV];
        [_imgeV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.shapLayerView).offset(-2); // 由于图片不是对称的，需要位置微调
            make.centerX.equalTo(self.shapLayerView).offset(-8); // 位置微调
            make.size.mas_equalTo(CGSizeMake(KWidth(12), KWidth(20)));
        }];
    }return _imgeV;
}

- (UILabel *)refreshLabel{
    if (!_refreshLabel) {
        _refreshLabel = UILabel.new;
        _refreshLabel.textColor = kWhiteColor;
        _refreshLabel.text = @"正在上传...";
        [self addSubview:_refreshLabel];
        [_refreshLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.shapLayerView.mas_right).offset(12);
            make.centerY.equalTo(self);
        }];
    }return _refreshLabel;
}

- (UILabel *)subrefreshLabel{
    if (!_subrefreshLabel) {
        _subrefreshLabel = UILabel.new;
        _subrefreshLabel.textColor = kWhiteColor;
        _subrefreshLabel.textAlignment = NSTextAlignmentRight;
        _subrefreshLabel.font = [UIFont systemFontOfSize:KWidth(12) weight:UIFontWeightRegular];
        [self addSubview:_subrefreshLabel];
        [_subrefreshLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-8);
            make.bottom.equalTo(self).offset(-8);
        }];
    }return _subrefreshLabel;
}

@end
