//
//  NoticePopupView.m
//  UBallLive
//
//  Created by Jobs on 2020/10/26.
//

#import "JobsNoticePopupView.h"

@interface JobsNoticePopupView ()

@property(nonatomic,strong)UIImageView *imageView;

@end

@implementation JobsNoticePopupView

-(instancetype)init{
    if (self = [super init]) {
        
    }return self;
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
}
//外层数据渲染
-(void)richElementsInViewWithModel:(id _Nullable)model{
    self.imageView.alpha = 1;
}

-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView = UIImageView.new;
        _imageView.image = KIMG(@"登录弹窗");
        
        {// A
            _imageView.userInteractionEnabled = YES;
            _imageView.target = self;
            _imageView.numberOfTouchesRequired = 1;
            _imageView.numberOfTapsRequired = 1;
            _imageView.tapGR.enabled = YES;
            @jobs_weakify(self)
            _imageView.callbackBlock = ^(id weakSelf, id arg, UIGestureRecognizer *data3) {
                @jobs_strongify(self)
                NSLog(@"%@",self.popupView);
                [self.popupView tf_hide];
            };
        }
        
        [self addSubview:_imageView];
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }return _imageView;
}

@end
