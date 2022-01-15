//
//  SearchView.m
//  Feidegou
//
//  Created by Kite on 2019/11/21.
//  Copyright © 2019 朝花夕拾. All rights reserved.
//

#import "SearchView.h"

#define BtnDefaultWidth 100

@interface SearchView ()
<
UIScrollViewDelegate
>

@property(nonatomic,copy)MKDataBlock block;
@property(nonatomic,assign)CGFloat BtnWidth;
@property(nonatomic,strong)UIButton *tempBtn;

@end

@implementation SearchView

-(instancetype)initWithBtnTitleMutArr:(NSArray *)btnTitleMutArr{
    if (self = [super init]) {
        self.btnTitleArr = btnTitleMutArr;
        self.scrollView.alpha = 1;
        self.backgroundColor = kClearColor;
        
        if (btnTitleMutArr.count < 5) {
            self.BtnWidth = (JobsSCREEN_WIDTH - 5 * 2 - 10 * (btnTitleMutArr.count - 1))/ btnTitleMutArr.count;
        }else{
            self.BtnWidth = BtnDefaultWidth;
        }
        
        for (int i = 0; i < btnTitleMutArr.count; i++) {
            UIButton *btn = UIButton.new;
//            btn.backgroundColor = RandomColor;
            [UIView cornerCutToCircleWithView:btn
                              andCornerRadius:7.f];
            [UIView colourToLayerOfView:btn
                             withColour:KLightGrayColor
                         andBorderWidth:.5f];
            
            if ([btnTitleMutArr[i] isKindOfClass:[UIImage class]]) {
                [btn setBackgroundImage:btnTitleMutArr[i]
                               forState:UIControlStateNormal];
            }else if ([btnTitleMutArr[i] isKindOfClass:[NSString class]]){
                [btn setTitle:btnTitleMutArr[i]
                     forState:UIControlStateNormal];
//                [btn setImage:KIMG(@"TwoWayArrow_1")
//                     forState:UIControlStateNormal];
//                [btn setImage:KIMG(@"TwoWayArrow_2")
//                     forState:UIControlStateSelected];
                [btn setTitleColor:kBlackColor
                          forState:UIControlStateNormal];
                [btn setTitleColor:kRedColor
                          forState:UIControlStateSelected];
            }else{}
            [btn layoutButtonWithEdgeInsetsStyle:GLButtonEdgeInsetsStyleRight
                                 imageTitleSpace:10];
            [btn.titleLabel sizeToFit];
            btn.titleLabel.adjustsFontSizeToFitWidth = YES;
            @jobs_weakify(self)
            [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
                @jobs_strongify(self)
                if ([self.tempBtn isEqual:x]) {//同一个btn
                    x.selected = !x.selected;
                }else{//不同一个btn
                    //点击不同的btn
                    for (UIButton *btn in self.btnMutArr) {
                        btn.selected = NO;
                    }
                    x.selected = YES;
                }
                self.tempBtn = x;//上一个被点击的btn
                if (self.block) {
                    self.block(x);
                }
            }];
            [btn setTitleColor:kBlackColor
                      forState:UIControlStateNormal];
            [self.scrollView addSubview:btn];
            btn.frame = CGRectMake((self.BtnWidth + 10) * (i) + 5,
                                   0,
                                   self.BtnWidth,
                                   30);
            [self.btnMutArr addObject:btn];
        }
    }return self;
}

-(void)actionBlock:(MKDataBlock _Nullable)block{
    self.block = block;
}
#pragma mark —— UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{

}
#pragma mark —— lazyLoad
-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = UIScrollView.new;
//        _scrollView.alwaysBounceHorizontal = YES;//禁止左右滚动
//        _scrollView.alwaysBounceVertical = NO;//禁止上下滚动
        _scrollView.pagingEnabled = YES;
        _scrollView.contentSize = CGSizeMake((100 + 10) * (self.btnTitleArr.count) + 5,
                                             55);
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator = YES;
        [self addSubview:_scrollView];
        [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }return _scrollView;
}

-(NSMutableArray<UIButton *> *)btnMutArr{
    if (!_btnMutArr) {
        _btnMutArr = NSMutableArray.array;
    }return _btnMutArr;
}

@end
