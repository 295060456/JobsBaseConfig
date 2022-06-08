//
//  UIViewController+JXPagingViewListViewDelegate.m
//  UBallLive
//
//  Created by Jobs on 2020/10/26.
//

#import "UIViewController+JXPagerViewListViewDelegate.h"

@implementation UIViewController (JXPagerViewListViewDelegate)
#pragma mark —— UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([scrollView isKindOfClass:self.scrollViewClass]) {
        CGFloat sectionHeaderHeight = 40;
        if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
        } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
        }
    }
    if (self.scrollCallback) {
        self.scrollCallback(scrollView);
    }
}
#pragma mark —— JXPagerViewListViewDelegate
- (UIScrollView *)listScrollView {
    return self.scrollView;
}

- (void)listViewDidScrollCallback:(void (^)(UIScrollView *))callback {
    self.scrollCallback = callback;
}

- (UIView *)listView {
    return self.view;
}

static char *UIViewController_JXPagingViewListViewDelegate_scrollViewClass = "UIViewController_JXPagingViewListViewDelegate_scrollViewClass";
@dynamic scrollViewClass;
#pragma mark —— @property(nonatomic,strong)Class scrollViewClass;
-(Class)scrollViewClass{
    Class ScrollViewClass = objc_getAssociatedObject(self, UIViewController_JXPagingViewListViewDelegate_scrollViewClass);
    return ScrollViewClass;
}

-(void)setScrollViewClass:(Class)scrollViewClass{
    objc_setAssociatedObject(self,
                             UIViewController_JXPagingViewListViewDelegate_scrollViewClass,
                             scrollViewClass,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
static char *UIViewController_JXPagingViewListViewDelegate_scrollView = "UIViewController_JXPagingViewListViewDelegate_scrollView";
@dynamic scrollView;
#pragma mark —— @property(nonatomic,strong)UIScrollView *scrollView;
/**
 1、Masonry约束必须以self.scrollView为锚点，不能以self.view。否则无法拖动
 [self.scrollView addSubview:_tableView];
 [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
     make.top.equalTo(self.scrollView);
     make.height.mas_equalTo(JobsMainScreen_HEIGHT());
     make.width.mas_equalTo(JobsMainScreen_WIDTH());
     make.centerX.equalTo(self.scrollView);
 }];
 2、必须设置 contentSize。否则无法拖动
 self.scrollView.contentSize = CGSizeMake(JobsMainScreen_WIDTH(), 2*JobsMainScreen_HEIGHT());
 3、加在scrollView上的内容物的相关长度比如超出scrollView容器的相关长度。否则无法拖动
 */
-(UIScrollView *)scrollView{
    UIScrollView *ScrollView = objc_getAssociatedObject(self, UIViewController_JXPagingViewListViewDelegate_scrollView);
    if (!ScrollView) {
        ScrollView = UIScrollView.new;
        ScrollView.delegate = self;
        [self.view addSubview:ScrollView];
        objc_setAssociatedObject(self,
                                 UIViewController_JXPagingViewListViewDelegate_scrollView,
                                 ScrollView,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [ScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
    }return ScrollView;
}

-(void)setScrollView:(UIScrollView *)scrollView{
    objc_setAssociatedObject(self,
                             UIViewController_JXPagingViewListViewDelegate_scrollView,
                             scrollView,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
static char *UIViewController_JXPagingViewListViewDelegate_scrollCallback = "UIViewController_JXPagingViewListViewDelegate_scrollCallback";
@dynamic scrollCallback;
#pragma mark —— @property(nonatomic,copy)void(^scrollCallback)(UIScrollView *scrollView);
-(void)setScrollCallback:(void (^)(UIScrollView * _Nonnull))scrollCallback{
    objc_setAssociatedObject(self,
                             UIViewController_JXPagingViewListViewDelegate_scrollCallback,
                             scrollCallback,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(void (^)(UIScrollView * _Nonnull))scrollCallback{
    return objc_getAssociatedObject(self, UIViewController_JXPagingViewListViewDelegate_scrollCallback);
}

@end
