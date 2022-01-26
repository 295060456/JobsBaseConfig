//
//  JobsWelcomeVC.m
//  Casino
//
//  Created by Jobs on 2021/12/15.
//

#import "JobsWelcomeVC.h"

@interface JobsWelcomeVC ()
// UI
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)UIPageControl *pageControl;
// Data
@property(nonatomic,strong)NSMutableArray <NSString *>*dataMutArr;

@end

@implementation JobsWelcomeVC

- (void)dealloc{
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
    //    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)loadView{
    [super loadView];
    self.setupNavigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = KYellowColor;
    self.scrollView.visible = YES;
    self.pageControl.visible = YES;

    [self loadPhoto];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)loadPhoto{
    for (NSUInteger i = 0; i < self.dataMutArr.count; i++) {
        UIImageView * imageView = UIImageView.new;
        imageView.frame = CGRectMake(JobsMainScreen_WIDTH() * i, 0, JobsMainScreen_WIDTH(), JobsMainScreen_HEIGHT());
        //用SDWebImage下载图片
        NSString *imageName = @"";
        if (i < 10) {
            imageName = [NSString stringWithFormat:@"启动页_0%lu",(unsigned long)i];
        }else{
            imageName = [NSString stringWithFormat:@"启动页_%ld",i];
        }
        [imageView sd_setImageWithURL:[NSURL URLWithString:self.dataMutArr[i]] placeholderImage:KIMG(imageName)];
        [self.scrollView addSubview:imageView];
    }
}
#pragma mark —— UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.scrollView.contentOffset.x > JobsMainScreen_WIDTH() * 2.8){
        if (self.viewControllerBlock) {
            self.viewControllerBlock(@1);
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (self.scrollView.contentOffset.x < JobsMainScreen_WIDTH() * 0.5) {
        self.pageControl.currentPage = 0;
    }else if(self.scrollView.contentOffset.x > JobsMainScreen_WIDTH() * 0.5 &&
             self.scrollView.contentOffset.x < JobsMainScreen_WIDTH() * 1.5){
        self.pageControl.currentPage = 1;
    }else if(self.scrollView.contentOffset.x > JobsMainScreen_WIDTH() * 1.5){
        self.pageControl.currentPage = 2;
    }else{}
}
#pragma mark —— lazyLoad
-(UIPageControl *)pageControl{
    if (!_pageControl) {
        _pageControl = UIPageControl.new;
        _pageControl.numberOfPages = 3;
        _pageControl.currentPage = 0;
        _pageControl.currentPageIndicatorTintColor = UIColor.redColor;
        _pageControl.pageIndicatorTintColor = UIColor.whiteColor;
        [self.view addSubview:_pageControl];
        [_pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.offset(0);
            make.bottom.offset(-JobsWidth(60));
        }];
    }return _pageControl;
}

-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [UIScrollView.alloc initWithFrame:UIScreen.mainScreen.bounds];
        _scrollView.delegate = self;
        _scrollView.contentOffset = CGPointMake(0, 0);
        _scrollView.contentSize = CGSizeMake(JobsMainScreen_WIDTH() * 4, JobsMainScreen_HEIGHT());
        _scrollView.bounces = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        [self.view addSubview:_scrollView];
    }return _scrollView;
}

-(NSMutableArray<NSString *> *)dataMutArr{
    if (!_dataMutArr) {
        _dataMutArr = NSMutableArray.array;
        [_dataMutArr addObject:@"https://b-ssl.duitang.com/uploads/item/201503/25/20150325184145_SBu3J.jpeg"];
        [_dataMutArr addObject:@"https://b-ssl.duitang.com/uploads/item/201503/25/20150325184145_SBu3J.jpeg"];
        [_dataMutArr addObject:@"https://b-ssl.duitang.com/uploads/item/201503/25/20150325184145_SBu3J.jpeg"];
    }return _dataMutArr;
}

@end
