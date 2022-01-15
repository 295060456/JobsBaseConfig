//
//  JobsSearchTableView.m
//  JobsSearch
//
//  Created by Jobs on 2020/10/6.
//

#import "JobsSearchTableView.h"

@interface JobsSearchTableView ()

@property(nonatomic,strong)UITapGestureRecognizer *tapGR;

@end

@implementation JobsSearchTableView

-(instancetype)init {
    if (self = [super init]) {
        self.tapGR.enabled = YES;
    }return self;
}

-(void)tapGRHandleSingleFingerAction:(UITapGestureRecognizer *)sender{
    if (self.viewBlock) self.viewBlock(sender);
}
#pragma mark —— UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    return YES;
}
#pragma mark —— lazyLoad
-(UITapGestureRecognizer *)tapGR{//单击一下
    if (!_tapGR) {
        _tapGR = [UITapGestureRecognizer.alloc initWithTarget:self
                                                       action:@selector(tapGRHandleSingleFingerAction:)];
        _tapGR.numberOfTouchesRequired = 1; //手指数
        _tapGR.numberOfTapsRequired = 1; //tap次数
        _tapGR.delegate = self;
        [self addGestureRecognizer:_tapGR];
    }return _tapGR;
}

@end
