//
//  BaseViewController.m
//  JobsSearch
//
//  Created by Jobs on 2020/12/1.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

#pragma mark —— UIViewModelProtocol
/// 主、副标题文字
@synthesize text = _text;
@synthesize subText = _subText;
@synthesize attributedText = _attributedText;
@synthesize subAttributedText = _subAttributedText;
@synthesize textCor = _textCor;
@synthesize subTextCor = _subTextCor;
@synthesize font = _font;
@synthesize subFont = _subFont;
@synthesize textAlignment = _textAlignment;
@synthesize subTextAlignment = _subTextAlignment;
@synthesize lineBreakMode = _lineBreakMode;
@synthesize subLineBreakMode = _subLineBreakMode;
@synthesize textLineSpacing = _textLineSpacing;
@synthesize subTextlineSpacing = _subTextlineSpacing;
/// 图片和背景颜色
@synthesize image = _image;
@synthesize bgImage = _bgImage;
@synthesize bgImageView = _bgImageView;
@synthesize bgSelectedImage = _bgSelectedImage;
@synthesize imageURLString = _imageURLString;
@synthesize bgImageURLString = _bgImageURLString;
@synthesize bgCor = _bgCor;
/// 方位
@synthesize cornerRadius = _cornerRadius;
@synthesize jobsWidth = _jobsWidth;
@synthesize jobsHeight = _jobsHeight;
@synthesize jobsTop = _jobsTop;
@synthesize jobsLeft = _jobsLeft;
@synthesize jobsRight = _jobsRight;
@synthesize jobsBottom = _jobsBottom;
@synthesize jobsSize = _jobsSize;
@synthesize jobsRect = _jobsRect;
@synthesize jobsPoint = _jobsPoint;
@synthesize offsetXForEach = _offsetXForEach;
@synthesize offsetYForEach = _offsetYForEach;
@synthesize offsetHeight = _offsetHeight;
@synthesize offsetWidth = _offsetWidth;
/// 标记📌
@synthesize indexPath = _indexPath;
@synthesize section = _section;
@synthesize row = _row;
@synthesize item = _item;
@synthesize lastPoint = _lastPoint;
@synthesize index = _index;
@synthesize currentPage = _currentPage;
@synthesize pageSize = _pageSize;
/// 其他
@synthesize cls = _cls;
@synthesize viewModel = _viewModel;
@synthesize data = _data;
@synthesize requestParams = _requestParams;
@synthesize reqSignal = _reqSignal;
@synthesize selected = _selected;
@synthesize isMultiLineShows = _isMultiLineShows;
@synthesize internationalizationKEY = _internationalizationKEY;
@synthesize isTranslucent = _isTranslucent;
@synthesize visible = _visible;
#pragma mark —— BaseViewControllerProtocol
@synthesize fromVC = _fromVC;
@synthesize alertController = _alertController;
@synthesize pushOrPresent = _pushOrPresent;
@synthesize setupNavigationBarHidden = _setupNavigationBarHidden;

- (void)dealloc{
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
    [NSNotificationCenter.defaultCenter removeObserver:self];
}

- (instancetype)init{
    if (self = [super init]) {
        
    }return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil
                         bundle:(NSBundle *)nibBundleOrNil {
    if(self = [super initWithNibName:nibNameOrNil
                              bundle:nibBundleOrNil]) {
        self.isHiddenNavigationBar = YES;
        self.setupNavigationBarHidden = YES;
    }return self;
}

-(void)loadView{
    [super loadView];
    self.currentPage = 1;
    self.bgImage = KIMG(@"洗码背景图");// 仅在loadView中配置有效
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.bgImage) {
        self.bgImageView.alpha = 1;
    }else{
        self.view.backgroundColor = kWhiteColor;
    }
    
    /*
     *  #pragma mark —— 全局配置 GKNavigationBar -(void)makeGKNavigationBarConfigure
     */
//    {
//        self.gk_navBackgroundColor = kWhiteColor;
//        self.gk_navTitleFont = [UIFont systemFontOfSize:18 weight:UIFontWeightMedium];
//        self.gk_navTitleColor = AppMainCor_01;
//        self.gk_backStyle = GKNavigationBarBackStyleBlack;
//        self.gk_navLineHidden = YES;
//    }
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    NotificationAdd(self,
                    @selector(languageSwitchNotification:),
                    LanguageSwitchNotification,
                    nil);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"%d",self.setupNavigationBarHidden);
    self.isHiddenNavigationBar = self.setupNavigationBarHidden;
    [self.navigationController setNavigationBarHidden:self.setupNavigationBarHidden animated:animated];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    /// 只有是在Tabbar管理的，不含导航的根控制器才开启手势
    self.isRootVC ? [self tabBarOpenPan] : [self tabBarClosePan];
#ifdef DEBUG
    /// 网络异步数据刷新UI会在viewDidAppear以后执行viewWillLayoutSubviews、viewDidLayoutSubviews
//    [self ifEmptyData];
#endif
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    NSLog(@"%d",self.setupNavigationBarHidden);
    self.isHiddenNavigationBar = self.setupNavigationBarHidden;
    [self.navigationController setNavigationBarHidden:self.setupNavigationBarHidden animated:animated];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.view.mjRefreshTargetView.mj_footer.y = self.view.mjRefreshTargetView.contentSize.height;
}
/**
 
 #  iOS 状态栏颜色的修改

 【全局修改】
  1、在Info.plist里面加入如下键值对：
     1.1、View controller-based status bar appearance : NO
     1.2、Status bar style : Light Content

  2、[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;// iOS 13 后方法被标注废弃

  1.2 和 2 任意选一个即可

 【局部修改】
  1、在Info.plist里面加入如下键值对：
  View controller-based status bar appearance ： YES //全局是NO、局部是YES
  2、@interface BaseNavigationVC : UINavigationController
     2.1、在 BaseNavigationVC.m里面写入：
     - (UIViewController *)childViewControllerForStatusBarStyle {
             return self.topViewController;
     }
     2.2、在具体的需要修改的VC.m里面写入：
     -(UIStatusBarStyle)preferredStatusBarStyle{
         return UIStatusBarStyleLightContent;
     }
 
 */
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
#pragma mark —— UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}
#pragma mark —— BaseProtocol
/// 接收通知相应的方法【在分类或者基类中实现会屏蔽具体子类的相关实现】
-(void)languageSwitchNotification:(nonnull NSNotification *)notification{
    NSLog(@"通知传递过来的 = %@",notification.object);
}
#pragma mark —— lazyLoad
-(UIImageView *)bgImageView{
    if (!_bgImageView) {
        _bgImageView = UIImageView.new;
        _bgImageView.frame = self.view.bounds;
        _bgImageView.image = self.bgImage;
        _bgImageView.userInteractionEnabled = YES;
        self.view = _bgImageView;
    }return _bgImageView;
}

@end
