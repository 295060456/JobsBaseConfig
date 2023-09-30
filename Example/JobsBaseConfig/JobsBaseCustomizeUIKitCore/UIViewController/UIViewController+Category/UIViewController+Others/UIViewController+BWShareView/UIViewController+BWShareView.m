//
//  UIViewController+BWShareView.m
//  UBallLive
//
//  Created by Jobs on 2020/10/12.
//

#import "UIViewController+BWShareView.h"

@implementation UIViewController (BWShareView)
#pragma mark —— @property(strong,nonatomic)BWShareView *shareView;
JobsKey(_shareView)
@dynamic shareView;
-(BWShareView *)shareView{
    BWShareView *ShareView = objc_getAssociatedObject(self, _cmd);
    switch (self.bWShareViewStyle) {
        case BWShareViewStyle_1:{
            if (!ShareView) {
                ShareView = [BWShareView.alloc initWithFrame:self.shareViewFrame
                                                  shareTitle:self.shareTitle
                                                  shareArray:self.shareViewDataMutArr];
            }
        }
            break;
        case BWShareViewStyle_2:{
            if (!ShareView) {
                ShareView = [BWShareView.alloc initWithFrame:self.shareViewFrame
                                                  shareTitle:self.shareTitle
                                                  firstArray:self.shareViewDataMutArr
                                                 secondArray:self.shareViewDataMutSecArr];
            }
        }
        default:
            ShareView = Nil;
            NSAssert(ShareView,@"ShareView 创建出现错误");
            break;
    }
    objc_setAssociatedObject(self,
                             _cmd,
                             ShareView,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return ShareView;
}

-(void)setShareView:(BWShareView *)shareView{
    objc_setAssociatedObject(self,
                             _cmd,
                             shareView,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(assign,nonatomic)CGRect shareViewFrame;
JobsKey(_shareViewFrame)
JobsKey(_originX)
JobsKey(_originY)
JobsKey(_sizeW)
JobsKey(_sizeH)
@dynamic shareViewFrame;
-(CGRect)shareViewFrame{
    
    CGFloat ShareViewFrameX = [Jobs_getAssociatedObject(_originX) floatValue];
    CGFloat ShareViewFrameY = [Jobs_getAssociatedObject(_originY) floatValue];
    CGFloat ShareViewFrameW = [Jobs_getAssociatedObject(_sizeW) floatValue];
    CGFloat ShareViewFrameH = [Jobs_getAssociatedObject(_sizeH) floatValue];
    
    return CGRectMake(ShareViewFrameX,
                      ShareViewFrameY,
                      ShareViewFrameW,
                      ShareViewFrameH);
}

-(void)setShareViewFrame:(CGRect)shareViewFrame{
    Jobs_setAssociatedCOPY_NONATOMIC(_originX, @(shareViewFrame.origin.x))
    Jobs_setAssociatedCOPY_NONATOMIC(_originY, @(shareViewFrame.origin.y))
    Jobs_setAssociatedCOPY_NONATOMIC(_sizeW, @(shareViewFrame.size.width))
    Jobs_setAssociatedCOPY_NONATOMIC(_sizeH, @(shareViewFrame.size.height))
}
#pragma mark —— @property(assign,nonatomic)BWShareViewStyle bWShareViewStyle;
JobsKey(_bWShareViewStyle)
@dynamic bWShareViewStyle;
-(BWShareViewStyle)bWShareViewStyle{
    return [Jobs_getAssociatedObject(_bWShareViewStyle) integerValue];
}

-(void)setBWShareViewStyle:(BWShareViewStyle)bWShareViewStyle{
    Jobs_setAssociatedRETAIN_NONATOMIC(_bWShareViewStyle, @(bWShareViewStyle))
}
#pragma mark —— @property(strong,nonatomic)NSMutableArray *shareViewDataMutArr;
JobsKey(_shareViewDataMutArr)
@dynamic shareViewDataMutArr;
-(NSMutableArray *)shareViewDataMutArr{
    NSMutableArray *ShareViewDataMutArr = Jobs_getAssociatedObject(_shareViewDataMutArr);
    if (!ShareViewDataMutArr) {
        ShareViewDataMutArr = NSMutableArray.array;
        Jobs_setAssociatedRETAIN_NONATOMIC(_shareViewDataMutArr, ShareViewDataMutArr)
    }return ShareViewDataMutArr;
}

-(void)setShareViewDataMutArr:(NSMutableArray *)shareViewDataMutArr{
    Jobs_setAssociatedRETAIN_NONATOMIC(_shareViewDataMutArr, shareViewDataMutArr)
}
#pragma mark —— @property(strong,nonatomic)NSMutableArray *shareViewDataMutSecArr;
JobsKey(_shareViewDataMutSecArr)
@dynamic shareViewDataMutSecArr;
-(NSMutableArray *)shareViewDataMutSecArr{
    NSMutableArray *ShareViewDataMutSecArr = Jobs_getAssociatedObject(_shareViewDataMutSecArr);
    if (!ShareViewDataMutSecArr) {
        ShareViewDataMutSecArr = NSMutableArray.array;
        Jobs_setAssociatedRETAIN_NONATOMIC(_shareViewDataMutSecArr, ShareViewDataMutSecArr)
    }return ShareViewDataMutSecArr;
}

-(void)setShareViewDataMutSecArr:(NSMutableArray *)shareViewDataMutSecArr{
    Jobs_setAssociatedRETAIN_NONATOMIC(_shareViewDataMutSecArr, shareViewDataMutSecArr)
}
#pragma mark —— @property(strong,nonatomic)NSString *shareTitle;
JobsKey(_shareTitle)
@dynamic shareTitle;
-(NSString *)shareTitle{
    return Jobs_getAssociatedObject(_shareTitle);
}

-(void)setShareTitle:(NSString *)shareTitle{
    Jobs_setAssociatedRETAIN_NONATOMIC(_shareTitle, shareTitle)
}

@end
