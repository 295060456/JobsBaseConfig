/**
 *******************  葵花宝典  ****************************

 */

//iOS开发：常用三方库(API)接口汇总(表格布局,内容尽收眼底)

http://www.jianshu.com/p/2d2521f4e28a

#pragma mark - iOS中一句代码解决倒计时问题

http://www.jianshu.com/p/ccbbdc776876

/************************************************/

#pragma mark - 高效图片轮播，两个ImageView实现

http://www.jianshu.com/p/ef03ec7f23b2

/************************************************/

#pragma mark - 放肆的使用UIBezierPath和CAShapeLayer画各种图形

http://www.jianshu.com/p/c5cbb5e05075

/************************************************/

#pragma mark - iOS 实现ScrollView 上滑隐藏Navigationbar,下滑显示

http://www.jianshu.com/p/b43113256ce1

/************************************************/

#pragma mark - iOS 关于navigationBar的一些：毛玻璃、透明、动态缩放、动态隐藏

http://www.jianshu.com/p/b2585c37e14b

/************************************************/

#pragma mark - iOS开发的一些奇巧淫技2

http://www.jianshu.com/p/08f194e9904c

/************************************************/


#pragma mark - SB 上scrollerView添加约束

http://www.cocoachina.com/cms/wap.php?action=article&id=10242

http://www.kittenyang.com/autolayoutforscrollview/

/************************************************/

// 单例
+ (instancetype)shared<#name#> {
    static <#class#> *_shared<#name#> = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shared<#name#> = <#initializer#>;
    });
    
    return _shared<#name#>;
}
//--------------------------//
// 单例化一个类
// @interface .h
#define singleton_interface(className) \
+ (className *)shared##className;

// @implementation .m
#define singleton_implementation(className) \
static className *_instance; \
+ (id)allocWithZone:(NSZone *)zone \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [super allocWithZone:zone]; \
}); \
return _instance; \
} \
+ (className *)shared##className \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [[self alloc] init]; \
}); \
return _instance; \
}

/************************************************/

// 通知关闭键盘
[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];

#pragma mark - 监听方法
/**
 * 键盘的frame发生改变时调用（显示、隐藏等）
 */
- (void)keyboardWillChangeFrame:(NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    
    // 动画的持续时间
    double duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 键盘的frame
    CGRect keyboardF = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    NSLog(@"keyboardF %@",NSStringFromCGRect(keyboardF));
    NSLog(@"%@",NSStringFromCGRect(self.view.frame));
    __block CGRect f = self.view.frame;
    // 执行动画
    [UIView animateWithDuration:duration animations:^{
        
        if (keyboardF.origin.y <= keyboardF.size.height) {
            f.origin.y = -(f.size.height - keyboardF.origin.y-100);
        }
        else if (keyboardF.origin.y == self.view.frame.size.height) {
            f.origin.y = -(f.size.height - keyboardF.origin.y);
        }
        
        self.view.frame = f;
    }];
}

/************************************************/

#pragma mark - CLLocationManager定位检索地址
- (void)locate{
    // 判断定位操作是否被允许
    if([CLLocationManager locationServicesEnabled]) {
        //定位初始化
        _locationManager=[[CLLocationManager alloc] init];
        _locationManager.delegate=self;
        _locationManager.desiredAccuracy=kCLLocationAccuracyBest;
        _locationManager.distanceFilter=10;
        if (iOSVersion >= 8) {
            [_locationManager requestWhenInUseAuthorization];//使用程序其间允许访问位置数据（iOS8定位需要）
        }
        [_locationManager startUpdatingLocation];//开启定位
    }else {
        //提示用户无法进行定位操作
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"定位不成功 ,请确认开启定位" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];
    }
    // 开始定位
    [_locationManager startUpdatingLocation];
}
#pragma mark - CLLocationManagerDelegate
/**
 *  只要定位到用户的位置，就会调用（调用频率特别高）
 *  @param locations : 装着CLLocation对象
 */
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    //此处locations存储了持续更新的位置坐标值，取最后一个值为最新位置，如果不想让其持续更新位置，则在此方法中获取到一个值之后让locationManager stopUpdatingLocation
    CLLocation *currentLocation = [locations lastObject];
    // 获取当前所在的城市名
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    //根据经纬度反向地理编译出地址信息
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *array, NSError *error)
     {
         if (array.count > 0)
         {
             CLPlacemark *placemark = [array objectAtIndex:0];
             //NSLog(@%@,placemark.name);//具体位置
             //获取城市
             NSString *city = placemark.locality;
             if (!city) {
                 //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                 city = placemark.administrativeArea;
             }
             if ([placemark.administrativeArea isEqualToString:@"四川省"]) {
                 if ([city isEqualToString:@"攀枝花市"]) {
                     city = [city substringToIndex:3];
                 }else {
                     city = [city substringToIndex:2];
                 }
             }
             [_locationCity replaceObjectAtIndex:0 withObject:city];
             [_collectionView reloadData];
             
             //系统会一直更新数据，直到选择停止更新，因为我们只需要获得一次经纬度即可，所以获取之后就停止更新
             [manager stopUpdatingLocation];
         }else if (error == nil && [array count] == 0)
         {
             NSLog(@"No results were returned.");
         }else if (error != nil)
         {
             NSLog(@"An error occurred = %@", error);
         }
     }];
}

/************************************************/


#pragma mark - OC调用JS

#import <JavaScriptCore/JavaScriptCore.h>

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    // 支付完成的 结果 回调
    JSContext *jsContext = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    // 关联打印异常
    jsContext.exceptionHandler = ^(JSContext *context, JSValue *exceptionValue) {
        context.exception = exceptionValue;
    };
    
    __weak UIViewController *weakSelf = self;
    //elePayCallIOS 方法名的 回调
    jsContext[@"elePayCallIOS"] = ^(NSDictionary *param) {
        
        // 把 字符串 转换成data
        NSData *strData = [[param objectForKey:@"data"] dataUsingEncoding:NSUTF8StringEncoding];
        
        NSError *error = nil;
        
        //把 字符串 转换成 json
        NSDictionary  *result = [NSJSONSerialization JSONObjectWithData:strData options:NSJSONReadingMutableLeaves error:&error];
        NSLog(@"结果%@", result);
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            // 在主线程 做相应的操作
            
            //            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"完成" message:[[result objectForKey:@"header"] objectForKey:@"repmsg"] delegate:weakSelf cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            //            [alertView show];
            
            NSString *title = NSLocalizedString(@"完成", nil);
            NSString *message = NSLocalizedString([[result objectForKey:@"header"] objectForKey:@"repmsg"], nil);
            NSString *cancelButtonTitle = NSLocalizedString(@"Cancel", nil);
            NSString *otherButtonTitle = NSLocalizedString(@"确定", nil);
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
            
            //Create the actions.
            //            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            //                 NSLog(@"The \"Okay/Cancel\" alert's cancel action occured.");
            //            }];
            
            UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [self popvc];
            }];
            
            // Add the actions.
            //            [alertController addAction:cancelAction];
            [alertController addAction:otherAction];
            
            [self presentViewController:alertController animated:YES completion:nil];
        });
    };
}

// 万老板的
#import "YKXShareViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "YKXShareSDKHelper.h"

#define YKXPassengerShareURL @"http://ykxapi.honc.tech/ios/share"


@interface YKXShareViewController () <UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *shareWeb;


@end

@implementation YKXShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutViews];
}
- (BOOL)prefersStatusBarHidden
{
    return YES;
}
-(void)layoutViews {
    self.shareWeb=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.shareWeb.userInteractionEnabled=YES;
    self.shareWeb.scrollView.scrollEnabled=NO;
    SKAccountManager *manager = [SKAccountManager defaultAccountManager];
    NSString *sharedURL = [NSString stringWithFormat:@"%@?token=%@",YKXPassengerShareURL,[manager token]];
    NSURLRequest *request=[[NSURLRequest alloc]initWithURL:[NSURL URLWithString:sharedURL]];
    [self.shareWeb loadRequest:request];
    self.shareWeb.delegate=self;
    [self.view addSubview:self.shareWeb];
    
    UIButton *closeBtn=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-42, 6, 36, 36)];
    [closeBtn setBackgroundImage:[UIImage imageNamed:@"iconfont-cha"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeShare) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeBtn];
}

-(void)closeShare {
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)webViewDidFinishLoad:(UIWebView *)webView {
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
    // Disable callout
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout='none';"];
    [self jsInteraction];
}
-(void)jsInteraction{
    //获取UIWebView的js执行环境.
    JSContext *context = [self.shareWeb  valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    context.exceptionHandler = ^(JSContext *cnt,JSValue *expt){
        cnt.exception = expt;
    };
    context[@"shareToQQ"]=^{
        [self ShareMessWithType:SSDKPlatformSubTypeQQFriend];
    };
    context[@"shareToQZone"]=^{
        [self ShareMessWithType:SSDKPlatformSubTypeQZone];
    };
    context[@"shareToWeibo"]=^{
        [self ShareMessWithType:SSDKPlatformTypeSinaWeibo];
    };
    context[@"shareToWechat"]=^{
        [self ShareMessWithType:SSDKPlatformSubTypeWechatSession];
    };
    context[@"shareToWechatLine"]=^{
        [self ShareMessWithType:SSDKPlatformSubTypeWechatTimeline];
    };
    
}

-(void)ShareMessWithType:(SSDKPlatformType)type {
    SKHTTPSessionManager *manager=[[SKHTTPSessionManager alloc]init];
    [manager GetShareMes:nil].then(^(OVCResponse *response) {
        NSString *title = response.result[@"title"];
        NSString *imageUrl = response.result[@"imageUrl"];
        NSString *text = response.result[@"text"];
        NSString *url=response.result[@"url"];
        [YKXShareSDKHelper shareText:text title:title imageArray:@[imageUrl] platformType:type andUrl:url];
    }).catch(^(NSError *error) {
        [SKToastUtil toastWithText:[SKErrorResponseModel buildMessageWithNetworkError:error]];
    }).finally(^{
        
    });
}

/************************************************/

#pragma mark -  数组转字符串

NSMutableString *mutStr = [[NSMutableString alloc] init];

NSArray *arr = @[@"1",@"2",@"3"];

for (NSString *str in arr) {
    
    if (mutStr.length > 0)
    {
        [mutStr appendString:@","];
    }
    [mutStr appendString:str];
    
}

NSLog(@"%@", mutStr);
/************************************************/

#pragma mark -  本地txt文件中存放son  转成 dict

NSString * path = [[NSBundle mainBundle] pathForResource:@"companyModel" ofType:@"txt"];
//NSData *data = [NSData dataWithContentsOfFile:path];
//NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
NSString * str = [NSString stringWithContentsOfFile:path encoding:NSASCIIStringEncoding error:nil];
NSData *data = [[NSData alloc]initWithData:[str dataUsingEncoding:NSUTF8StringEncoding]];
NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
NSLog(@"%@",dic);


/************************************************/

#pragma mark - 圆角设置   xib SB 添加圆角

layer.cornerRadius

layer.borderWidth

layer.borderColorFromUIColor

/************************************************/
#pragma mark 导航栏设置

//http://www.cocoachina.com/design/20131104/7287.html
/**
 *  全局设置,1.可以直接放到AppDelegate里面。2.直接放到自定义的NavigationController里面
 */
+ (void)initialize {
    // 模型修改属性只能用字典
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[NSForegroundColorAttributeName] = [UIColor whiteColor];
    // 导航栏标题颜色
    [UINavigationBar appearance].titleTextAttributes = dic;
    
    // 设置返回按钮的颜色
    [UINavigationBar appearance].tintColor = [UIColor whiteColor];
    
    // 导航栏背景颜色
    [UINavigationBar appearance].barTintColor = [UIColor whiteColor];
    
    // 去掉导航栏黑线
    [UINavigationBar appearance].barStyle = UIBarStyleBlackTranslucent;
    
    //去掉导航条返回键带的title
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
    
    
}

/*****鬼魅的“64边距”--translucent属性

 *这个BOOL属性能控制UITabBar/UINavigationBar的半透明效果，默认为YES，即默认情况下为半透明效果
 *默认情况下，如果使用UITabBarController和UINavigationBarController（translucent属性默认为YES），
 *设置一个蓝色的view添加其中并设置距离屏幕边距为（0，0，0，0）
 *UITabBarController和UINavigationBarController被蓝色的view“穿透”了，此时view的边距也正如设置的一样，零点坐标在（0，0）处。
 *>如果将view替换成tableView
 *可以看到，tableView的cell并没有因为“穿透”效果而出现被遮挡的情况，
 *这是由于苹果对滚动视图的特殊性进行处理：对于类ScrollView，系统默认默认控制器属性automaticallyAdjustsScrollViewInsets默认为YES
 *零点坐标在（0，64）
**********************************/

 self.automaticallyAdjustsScrollViewInsets = NO;

//---------------------------------------------------------//

/*****非滚动视图中导致“鬼魅”的原因  向上偏移64
1.保留半透明效果（导航条/TabBar的translucent == YES）
 手动修改frame布局，从（0，64）开始布局，底部同理，需要计算坐标尺寸，比较繁琐。
 修改viewController的edgesForExtendedLayout属性，edgesForExtendedLayout = UIRectEdgeNone
*****/
if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
    self.edgesForExtendedLayout = UIRectEdgeNone;
}
// 2.不保留半透明效果（导航条/TabBar的translucent == NO）
// 将TabBar和导航条的translucent属性分别设置为NO，不做任何其他修改 64问题得到解决
[UINavigationBar appearance].translucent = NO;
[UITabBar appearance].translucent = NO;

//------------------------------------------------------
/**
    非跟控制器隐藏tabBar <UINavigationControllerDelegate>
 */
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (viewController != self.viewControllers[0]) {
        viewController.tabBarController.tabBar.hidden = YES;
    }
    else {
        viewController.tabBarController.tabBar.hidden = NO;
    }
}

/**
 *  单独一个控制器导航栏透明
 */
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    // 去掉导航栏黑线
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    
    // 设置透明导航栏
    // 1.给一张透明的图片，这种做法不好的一点是到2级界面的时候 导航不好处理
    //[self.navigationController.navigationBar setBackgroundImage:[UIImageView] forBarMetrics:UIBarMetricsDefault];
    //self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    
    // 2.根据navigationBar的层级关系直接设置透明度，这样好处理2级界面的导航栏
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:0];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    // 离开的时候设置透明为1
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1];
}



/************************************************/
#pragma mark -  设置tabBar
/**
 tabBar自定义 stroyBoard
 */

http://www.tuicool.com/articles/e6Jb2y6

/**
 tabbar 修改选中时候的颜色
 */
http://blog.csdn.net/tangaowen/article/details/43524815

// 设置tabBar选中图片颜色
[[UITabBar appearance] setTintColor:[UIColor colorWithRed:0.141 green:0.435 blue:0.698 alpha:1.000]];

+ (void)initialize
{
    UITabBar *tabbar = [UITabBar appearance];
    //1.隐藏默认的tab按钮
    //    [self.tabBar removeFromSuperview];  //直接移除的话界面切换tabbar一直在
    [tabbar.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj setHidden:YES];
    }];
    
    //2.隐藏黑线
    [tabbar setShadowImage:[UIImage new]];
    [tabbar setBackgroundImage:[[UIImage alloc] init]];
}

/************************************************/

#pragma mark -  设置searchBar
- (void)setSearchBarApperance {
    //1. 设置背景图是为了去掉上下黑线
    self.searchBar.backgroundImage = [[UIImage alloc] init];
    
    //2. 设置圆角和边框颜色
    //获取searchBar里面的TextField
    UITextField *searchField = [self.searchBar valueForKey:@"searchField"];
    
    if (searchField) {
        [searchField setBackgroundColor:[UIColor whiteColor]];
        searchField.layer.cornerRadius = 0.0f;
        searchField.layer.borderColor = [UIColor colorWithWhite:0.961 alpha:1.000].CGColor;
        searchField.layer.borderWidth = 1;
        searchField.layer.masksToBounds = YES;
        //更改searchBar 中PlaceHolder 字体颜色
        //        [searchField setValue:[UIColor colorWithRed:0.129 green:0.667 blue:0.702 alpha:1.000] forKeyPath:@"_placeholderLabel.textColor"];
        
    }
    
    //4. 设置输入框文字颜色和字体
    [UITextField appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]].textColor = [UIColor colorWithRed:0.129 green:0.667 blue:0.702 alpha:1.000];
    
    //5. 设置搜索Icon
    [self.searchBar setImage:[UIImage imageNamed:@"ic_search"]
            forSearchBarIcon:UISearchBarIconSearch
                       state:UIControlStateNormal];
    
    self.searchBar.delegate = self;
    
}


/************************************************/
/**
 *  设置pickView
 *
 */
#pragma mark - set PickView
- (void)setPickView {
    
    pickView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 150)];
    pickView.backgroundColor = [UIColor whiteColor];
    [garyView addSubview:pickView];
    
    pick = [[UIDatePicker alloc] init];
    pick.backgroundColor = [UIColor whiteColor];
    [pick sizeToFit];
    pick.datePickerMode = UIDatePickerModeDate;
    pick.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    [pickView addSubview:pick];
    
    UIToolbar *pickToolbar = [[UIToolbar alloc] init];
    [pickToolbar sizeToFit];
    [pickView addSubview:pickToolbar];
    
    UIBarButtonItem *canceItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleDone  target:self action:@selector(canceDate)];
    UIBarButtonItem *midItem = [[UIBarButtonItem  alloc]initWithBarButtonSystemItem:                                        UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem *doneItem = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone  target:self action:@selector(chooseDate)];
    pickToolbar.items = @[canceItem, midItem,doneItem];
}

- (void)canceDate {
    [pickView removeFromSuperview];
}

- (void)chooseDate {
    self.selectedDate = [pick date];
    if (tag == 0) {
        [searchView.sTimeBtn setTitle:[self stringFromDate:self.selectedDate] forState:UIControlStateNormal];
    }else {
        [searchView.eTimeBtn setTitle:[self stringFromDate:self.selectedDate] forState:UIControlStateNormal];
    }
    [pickView removeFromSuperview];
}

#pragma mark - NSDate ——> string 时间转换
- (NSString *)stringFromDate:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}
/*---------------------------------------------------------------------------*/
#pragma mark - UIPickerView去掉背景上的黑线
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view;
{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.font=[UIFont systemFontOfSize:18 weight:UIFontWeightRegular];
        pickerLabel.textColor=[UIColor whiteColor];
        pickerLabel.textAlignment=1;
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
    }
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    //在该代理方法里添加以下两行代码删掉上下的黑线
    [[pickerView.subviews objectAtIndex:1] setHidden:TRUE];
    [[pickerView.subviews objectAtIndex:2] setHidden:TRUE];
    return pickerLabel;
}


/*---------------------------------------------------------------------------*/
/**
 * iso时间转成字符串时间
 **/
+ (NSString *)toolDateFormatterWithISODateString:(NSString *)timeString;

/**
 * 字符串时间转成发布状态日期
 **/
+ (NSString *)toolPublishDateWithDateString:(NSString *)dateString;

/**
 * 字符串转成时间戳
 **/
+ (int)toolDateIntervalWithDateString:(NSString *)rfc3339DateTimeString;


#pragma mark - data
/**
 * iso时间转成字符串时间
 **/
+ (NSString *)toolDateFormatterWithISODateString:(NSString *)timeString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
    NSDate *date = [dateFormatter dateFromString:timeString];
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"YYYY.MM.dd"];
    NSString *iso8601String = [format stringFromDate:date];
    return iso8601String;
}

/**
 * 字符串时间转成发布状态日期
 **/
+ (NSString *)toolPublishDateWithDateString:(NSString *)dateString{
    
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate * nowDate = [NSDate date];
    //将需要转换的时间转换成 NSDate 对象
    NSDate * needFormatDate = [dateFormatter dateFromString:dateString];
    //取当前时间和转换时间两个日期对象的时间间隔
    NSTimeInterval time = [nowDate timeIntervalSinceDate:needFormatDate];
    //把间隔的秒数折算成天数和小时数：
    NSString *dateStr = @"";
    
    if (time <= 60) {  //1分钟以内的
        dateStr = @"刚刚";
    }else if(time <= 60*60){  //一个小时以内的
        
        int mins = time/60;
        dateStr = [NSString stringWithFormat:@"%d分钟前",mins];
    }
    else if(time <= 60*60*24){   //在两天内的
        [dateFormatter setDateFormat:@"YYYY.MM.dd"];
        NSString * need_yMd = [dateFormatter stringFromDate:needFormatDate];
        NSString *now_yMd = [dateFormatter stringFromDate:nowDate];
        
        [dateFormatter setDateFormat:@"HH:mm"];
        if ([need_yMd isEqualToString:now_yMd]) {
            //在同一天
            //            dateStr = [NSString stringWithFormat:@"今天 %@",[dateFormatter stringFromDate:needFormatDate]];
            int hour = time/60/60;
            dateStr = [NSString stringWithFormat:@"%d小时前",hour];
            
        }else{
            ////  昨天
            //            dateStr = [NSString stringWithFormat:@"昨天 %@",[dateFormatter stringFromDate:needFormatDate]];
            dateStr = [NSString stringWithFormat:@"昨天"];
        }
    }
    else {
        
        [dateFormatter setDateFormat:@"YYYY"];
        NSString * yearStr = [dateFormatter stringFromDate:needFormatDate];
        NSString *nowYear = [dateFormatter stringFromDate:nowDate];
        
        if ([yearStr isEqualToString:nowYear]) {
            //在同一年
            [dateFormatter setDateFormat:@"YYYY.MM.dd"];
            dateStr = [dateFormatter stringFromDate:needFormatDate];
        }
        else{
            dateStr = [NSString stringWithFormat:@"%@", @"很久以前"];
            
        }
    }
    
    return dateStr;
}

/**
 * 字符串转成时间戳
 **/
+ (int)toolDateIntervalWithDateString:(NSString *)rfc3339DateTimeString{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    NSDate *date =[dateFormatter dateFromString:rfc3339DateTimeString];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    NSDate *current = [NSDate date];
    int interval = [current timeIntervalSinceDate:date];
    if (interval < 0) interval = 0;
    return interval;
}

/************************************************/
/**
 *  网络请求
 */

#import "MJRefresh.h"
#import "AFNetworking.h"
#import "ComInterface.h"
#import "MBProgressHUD+Show.h"


- (AFHTTPRequestOperationManager *)manager {
    if (_manager == nil) {
        _manager = [AFHTTPRequestOperationManager manager];
        // 匹配类型
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    }
    return _manager;
}


#pragma mark - 请求网络
#pragma mark - 上拉加载下拉刷新

-#pragma mark - 上拉加载下拉刷新
- (void)MJRefresh {
    //下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getNewData];
        [self.tableView.mj_header endRefreshing];
    }];
    //上拉加载
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
}

//下拉刷新
- (void)getNewData{
    self.page = 1;
    // 下拉刷新将tag改为全部值
    self.tagID = @"";
    [self.dataArr removeAllObjects];
    [self getNetWorkingRequeset];
}
//上拉加载
- (void)loadMoreData{
    self.page++;
    if (self.page <= self.pageCount) {
        [self getNetWorkingRequeset];
        
    }else {
        [MBProgressHUD showErrorWithText:@"没有更多数据了"];
        
    }
    [self.tableView.mj_footer endRefreshingWithNoMoreData];
    [self.tableView.mj_footer resetNoMoreData];
    [self.tableView.mj_footer endRefreshing];
}
/************************************************************/

#pragma mark -关闭textfield的复制粘贴等功能？

-(BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    
    if (action == @selector(cut:)){
        return NO;
    } else if(action == @selector(copy:)){
        return NO;
    } else if(action == @selector(paste:)){
        return NO;
    }else if(action == @selector(select:)){
        return NO;
    } else if(action == @selector(selectAll:)){
        return NO;
    } else {
        
        return NO;
        
    }
    
}


/************************************************************/

#pragma mark - tableCell处理

//cell点击背景色不变
cell.selectionStyle = UITableViewCellSelectionStyleNone;

//cell不能点击
cell.userInteractionEnabled = YES;

//cell右边箭头
cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

//去掉单个cell的下划线
cell.separatorInset = UIEdgeInsetsMake(0, ScreenW, 0, 0);

//去掉cell分割线
_tabelView.separatorStyle = UITableViewCellSelectionStyleNone;

//避免tableView重复创建cell
while ([myCell1.contentView.subviews lastObject] != nil) {
    [(UIView *)[myCell1.contentView.subviews lastObject] removeFromSuperview];
}

// Cell重用问题
[cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
/*
 1.  makeObjectsPerformSelector:@select（aMethod）
 简介：让数组中的每个元素 都调用 aMethod
 
 2. makeObjectsPerformSelector:@select（aMethod） withObject:oneObject
 简介：让数组中的每个元素 都调用 aMethod  并把 withObject 后边的 oneObject 对象做为参数传给方法aMethod
*/

//去掉底部多余分割线
self.tableView.tableFooterView = [[UIView alloc] init];

// tableViewCell自动高度
//1.
self.tableView.estimatedRowHeight = 80.0f;
self.tableView.rowHeight = UITableViewAutomaticDimension;

// 2.UITableView+FDTemplateLayoutCell
//#import <UITableView+FDTemplateLayoutCell.h>
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView fd_heightForCellWithIdentifier:@"identifer" cacheByIndexPath:indexPath configuration:^(id cell) {
        // 配置 cell 的数据源，和 "cellForRow" 干的事一致，比如：
        cell.entity = self.feedEntities[indexPath.row];
    }];
}

/**
 *  cell下划线从最左边开始
 */
-(void)viewDidLayoutSubviews
{
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

//刷新单个cell
[self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];

//        NSIndexPath *reloadIndexPath = [NSIndexPath indexPathForRow:self.tempType inSection:0];
//        [self.sendTable reloadRowsAtIndexPaths:[NSArray arrayWithObject:reloadIndexPath]
//

//                              withRowAnimation:UITableViewRowAnimationNone


//一个section刷新
NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:2];
[tableview reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];

// 一个cell刷新
NSIndexPath *indexPath=[NSIndexPath indexPathForRow:3 inSection:0];
[tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];

#pragma mark - cell左滑删除处理

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.tableView) {
        if (!self.dataArr) {
            return 0;
        }
        return self.dataArr.count ? self.dataArr.count : 1;
    }
    else {
        return self.tagsArr.count;
    }
}
/**
 *  只要实现了这个方法,就拥有"左滑出行Delete"按钮功能
 *  点击默认的Delete按钮会调用这个方法
 */
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.dataArr.count == 0) {
        return;
    }
    YMCustomer *data = self.dataArr[indexPath.row];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@", TEST_URL, CARE_URL];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"sid"] = self.sid;
    params[@"name"] = data.enterpriseName;
    params[@"type"] = @"2";
    params[@"token"] = self.token;
    
    [NetWorkingManager postWithURLString:urlStr parameters:params success:^(NSDictionary *data) {
        //        YMLog(@"%@", data);
        NSString *code = data[@"code"];
        NSString *message = data[@"message"];
        if ([code isEqualToString:NETCODE_SUCCESS_]) {
            
            // 修改模型
            //            YMCustomer *data = self.dataArr[indexPath.row];
            //            [self.dataArr  removeObject:data];
            //            // 刷新表格
            //            [self.tableView reloadData];
            
            // 修改模型
            [self.dataArr removeObjectAtIndex:indexPath.row];
            // 刷新表格
            //            [self.tableView beginUpdates];
            
            if (self.dataArr.count <= 0) {
                //                [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationLeft];
                
                [self.tableView reloadData];
            }else {
                [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
            }
            
            //            [self.tableView endUpdates];
        }
        else {
            [MBProgressHUD showErrorWithText:[NSString stringWithFormat:@"%@", message]];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD showErrorWithText:@"网络异常"];
    }];
    //
}
#pragma mark =====网络请求  对tabelView 数据源的处理   1.数组不要懒加载 2. 添加需要判断

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.tableView) {
        if (!self.dataArr) {
            return 0;
        }
        return self.dataArr.count ? self.dataArr.count : 1;
    }
    else {
        return self.tagsArr.count;
    }
}

- (void)getNetWorkingRequeset {

    [NetWorkingManager postWithURLString:urlStr parameters:params success:^(NSDictionary *data) {

        if ([code isEqualToString:NETCODE_SUCCESS_]) {
            
            YMCunstomerModel *model = [YMCunstomerModel yy_modelWithDictionary:data];
            
            if (!_dataArr) {
                _dataArr = [NSMutableArray arrayWithArray:model.customers];
            }else {
                [_dataArr addObjectsFromArray:model.customers];
            }
            
            [self.tableView reloadData];
        }else {
            [MBProgressHUD showErrorWithText:[NSString stringWithFormat:@"%@", message]];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD showErrorWithText:@"网络异常"];
        [self.dataArr removeAllObjects];
        [self.tableView reloadData];
    }];
}


/************************************************************/

#pragma mark - textView光标问题
self.automaticallyAdjustsScrollViewInsets = NO;

/************************************************************/

//计算字符串高度
CGSize size = CGSizeMake(ScreenW-40,MAXFLOAT);

NSDictionary *attribute = @{NSFontAttributeName: label.font};

CGSize labelsize = [label.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;

//计算字符串的高度
CGRect rect = [urlStr boundingRectWithSize:CGSizeMake(self.view.frame.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15 weight:UIFontWeightRegular]} context:nil];


/************************************************************/
/**
 *  设置button文字左对齐串
 */
button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;


#pragma mark - 存储信息 单例userdeafualt
NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
_memberId = [userDefaults stringForKey:@"memberId"];
_memberType = [userDefaults stringForKey:@"memberType"];

#pragma mark - 设置圆角头像
// 1
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    _icon.layer.cornerRadius = 30;
    _icon.layer.masktoBounds = YES;
//    _icon.clipsToBounds = YES; //既让是layer层用上面代码会好点
}

//2
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    UIImage *image = [UIImage imageNamed:@"welcome1.png"];
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(60, 60), NO, 0);
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 60, 60)];
    [path addClip];
    [image drawInRect:CGRectMake(0, 0, 60, 60)];
    UIImage *tempImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.icon.image = tempImg;
}


/************************************************************/

#pragma mark - 富文本

NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"你可以输入200字"];

[str addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, 5)];
[str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(5, 3)];
[str addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(8,1)];
footlabel.attributedText = str;


NSMakeRange(0, 5)  第一个参数是位子  后面的字符长度  有几个字符就几个字符 表示的是长度  不是位子

/**富文本例子 —— 字体
 */
// 收益
NSString *tStr = [NSString stringWithFormat:@"%d", data.transIncome];
NSString *tStr1 = [NSString stringWithFormat:@"%d%@", data.transIncome, pasid];
NSMutableAttributedString *tStr2 = [[NSMutableAttributedString alloc] initWithString:tStr1];
[tStr2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20.0 weight:UIFontWeightRegular] range:NSMakeRange(0, tStr.length)];
[tStr2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14.0 weight:UIFontWeightRegular] range:NSMakeRange(tStr.length, 1)];
_transIncome.attributedText = tStr2;


/************************************************************/
/**
 *  多个button同一个界面 处理点击每个button的状态  我图片的改变
 *
 */
#pragma mark - 排序按钮事件
- (void)paixuAuction:(UIButton *)sender {
    
    for (UIButton *btn in self.downBtns){
        btn.selected = NO;
    }
    for (UIImageView *imgView in self.downImgs){
        if (imgView.tag == sender.tag){
            [imgView setHidden:NO];
        }else{
            [imgView setHidden:YES];
        }
    }
    sender.selected = YES;
    
}
#pragma mark - 贴换tableView
- (void)swithTableView:(UIButton *)sender {
    
    for (UIButton *btn in self.upBtns){
        btn.selected = NO;
    }
    sender.selected = YES;
  
    
}

/************************************************************/

#pragma mark - 延迟执行方法
/**
 *  1
 */
[self performSelector:@selector(goBackHomeView) withObject:self afterDelay:2];

/**
 *  延迟执行
 *
 *  @param aSelector  方法名称
 *  @param anArgument 要传递的参数，如果无参数，就设为nil
 *  @param delay      延迟的时间
 */
- (void)performSelector:(SEL)aSelector withObject:(nullable id)anArgument afterDelay:(NSTimeInterval)delay{}

/**
 *  2
 */
int64_t delayInSeconds = 10.0;      // 延迟的时间
/*
 *@parameter 1,时间参照，从此刻开始计时
 *@parameter 2,延时多久，此处为秒级，还有纳秒等。10ull * NSEC_PER_MSEC
 */
dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
    // do something
});


//每一秒执行一次 （重复性）
timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(testTimer) userInfo:nil repeats:YES];


/************************************************************/
#pragma mark - 限制textField输入个数

[textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];

- (void)textFieldDidChange:(UITextField *)textField
{
    if (textField.tag == 0) {
        if (textField.text.length > 11) {
            textField.text = [textField.text substringToIndex:11];
        }
    }
    else if (textField.tag == 1) {
        if (textField.text.length > 16) {
            textField.text = [textField.text substringToIndex:16];
        }
    }
    else if (textField.tag == 2) {
        if (textField.text.length > 6) {
            textField.text = [textField.text substringToIndex:6];
        }
    }
}



#pragma mark - TextField输入限制 格式

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField == self.topView.zkxsTF) {
        return YES;
    }
    if ([textField.text rangeOfString:@"."].location==NSNotFound) {
        isHaveDian = NO;
    }
    if ([string length]>0)  {
        unichar single=[string characterAtIndex:0];//当前输入的字符
        if ((single >='0' && single<='9') || single=='.')//数据格式正确
        {
            //首字母不能为0和小数点
            if([textField.text length]==0) //第一个数字不能为小数点
            {
                if(single == '.') {
                    [textField.text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                }
                if (single == '0') //第一个数字不能为0
                {
                    [textField.text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                }
            }
            if (single=='.'){
                if(!isHaveDian) //text中还没有小数点
                {
                    isHaveDian=YES;
                    return YES;
                }
                else //已经输入过小数点了，不能再输
                {
                    [textField.text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                }
            }
            else {
                if (isHaveDian) //存在小数点
                { //判断小数点的位数
                    NSRange ran=[textField.text rangeOfString:@"."];
                    int tt=range.location-ran.location;
                    if (tt <= 2){
                        return YES;
                    }
                    else //最多输入两位小数
                    {
                        return NO;
                    }
                }
                else {
                    return YES;
                }
            }
        }
        else //输入的数据格式不正确
        {
            [textField.text stringByReplacingCharactersInRange:range withString:@""];
            return NO;
        }
    }
    else {
        return YES;
    }
}

/*********************************************************/

#pragma maek - 各种正则判断
/**
 *  各种正则判断
 *
 *  http://www.open-open.com/code/view/1448117846369
    http://blog.csdn.net/hopedark/article/details/41545891
 *
 *  @return 注意要去掉网页中的空格 表达式要加@""
 */
//正则匹配用户密码 6 - 16 位数字和字母组合
+ (BOOL)validatePassword:(NSString *) password
{
    NSString *pattern = @"^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,16}";
    NSPredicate *pred = [NSPredicate predicateWithFormat: @"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:password];
    return isMatch;
    
}

//正则匹配用户姓名, 10 位的中文或英文
+ (BOOL)checkUserName:(NSString *)userName
{
    NSString *pattern = @"^[a-zA-Z一-龥]{1,10}";
    NSPredicate *pred = [NSPredicate predicateWithFormat: @"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:userName];
    return isMatch;
    
}

//正则匹配用户身份证号 15 或 18 位
+ (BOOL)checkUserIdCard: (NSString *) idCard
{
    NSString *pattern = @"(^[0-9]{15}$)|([0-9]{17}([0-9]|X)$)";
    NSPredicate *pred = [NSPredicate predicateWithFormat: @"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:idCard];
    return isMatch;
}

///// 手机号码的有效性判断
//检测是否是手机号码
- (BOOL)isMobileNumber:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}



/*********************************************************/

#pragma mark - 特殊字符的限制输入，价格金额的有效性判断


#define myDotNumbers     @"0123456789.\n"
#define myNumbers          @"0123456789\n"
-(void) createTextFiled {
    textfield1_ = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    textfield1_.delegate = self;
    [self addSubview:textfield1_];
    
    textfield2_ = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    textfield2_.delegate = self;
    [self addSubview:textfield2_];
    
    textfield3_ = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    textfield3_.delegate = self;
    [self addSubview:textfield3_];
    
}

-(void)showMyMessage:(NSString*)aInfo {
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:aInfo delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil nil];
    [alertView show];
    [alertView release];
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSCharacterSet *cs;
    if ([textField isEqual:textfield1_]) {
        cs = [[NSCharacterSet characterSetWithCharactersInString:myNumbers] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        BOOL basicTest = [string isEqualToString:filtered];
        if (!basicTest) {
            [self showMyMessage:@"只能输入数字"];
            return NO;
        }
    }
    else if ([textField isEqual:textfield2_]) {
        cs = [[NSCharacterSet characterSetWithCharactersInString:myNumbers] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        BOOL basicTest = [string isEqualToString:filtered];
        if (!basicTest) {
            [self showMyMessage:@"只能输入数字"];
            return NO;
        }
    }
    else if ([textField isEqual:textfield3_]) {
        NSUInteger nDotLoc = [textField.text rangeOfString:@"."].location;
        if (NSNotFound == nDotLoc && 0 != range.location) {
            cs = [[NSCharacterSet characterSetWithCharactersInString:myDotNumbers] invertedSet];
        }
        else {
            cs = [[NSCharacterSet characterSetWithCharactersInString:myNumbers] invertedSet];
        }
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        BOOL basicTest = [string isEqualToString:filtered];
        if (!basicTest) {
            
            [self showMyMessage:@"只能输入数字和小数点"];
            return NO;
        }
        if (NSNotFound != nDotLoc && range.location > nDotLoc + 3) {
            [self showMyMessage:@"小数点后最多三位"];
            return NO;
        }
    }
    return YES;
}


/*********************************************************/

#pragma make - 警告框 UIAlertAction
- (void)showDefaultAlert {
    NSString *title = NSLocalizedString(@"发帖失败", nil);
    // NSString *message = NSLocalizedString(@"A message should be a short, complete sentence.", nil);
    NSString *cancelButtonTitle = NSLocalizedString(@"Cancel", nil);
    NSString *otherButtonTitle = NSLocalizedString(@"OK", nil);
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    // Create the actions.
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        // NSLog(@"The \"Okay/Cancel\" alert's cancel action occured.");
    }];
    
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        // NSLog(@"The \"Okay/Cancel\" alert's other action occured.");
    }];
    
    // Add the actions.
    [alertController addAction:cancelAction];
    [alertController addAction:otherAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

/*********************************************************/

/**
 *  AFNetworking 3.0  上传
 */

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSLog(@"图片选中");
    //截取图片
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    NSData *imageData = UIImageJPEGRepresentation(image, 0.001);
    self.mv.portraitImageView.image = image;
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain", nil nil];
    // 参数
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"token"] = "param....";
    // 访问路径
    NSString *stringURL = [NSString stringWithFormat:@"%@%@",HOSTURL,kUploadAvatar];
    
    [manager POST:stringURL parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        // 上传文件
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
        
        [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"image/png"];
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"上传成功");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"上传错误");
    }];
}



AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];

NSString * cerPath = [[NSBundle mainBundle] pathForResource:@"server" ofType:@"cer"];
NSData * cerData = [NSData dataWithContentsOfFile:cerPath];
NSLog(@"%@", cerData);

manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate withPinnedCertificates:[[NSArray alloc] initWithObjects:cerData, nil]];

manager.securityPolicy.allowInvalidCertificates = YES;
[manager.securityPolicy setValidatesDomainName:NO];

manager.requestSerializer = [AFJSONRequestSerializer serializer];
manager.responseSerializer = [AFJSONResponseSerializer serializer];

NSDictionary * parameter = @{@"username":self.username, @"password":self.password};

[manager POST:@"https://192.168.1.4:9777" parameters:parameter success:^(NSURLSessionDataTask * task, id responseObject) {
    NSLog(@"success %@", responseObject);
}
      failure:^(NSURLSessionDataTask * task, NSError * error) {
          NSLog(@"failure %@", error);
      }];

/*********************************************************/


#pragma mark - 随机生成from - to 之间的数
-(int)getRandomNumber:(int)from to:(int)to
{
    return (int)(from + (arc4random() % (to - from + 1)));
}


/*********************************************************/

/**
 *  遇到网络请求 返回的既不是字典 又不是数组 只有一个数字 1  这样AF里面要用这样接收数据
 */

NSString * str = [[NSString alloc] initWithData: responseObject encoding: NSUTF8StringEncoding];

/*********************************************************/

/**
 *  URL转码 UTF8过时了  用下面的
 */
[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];// 过期

[urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];

/*********************************************************/

/**
 *  输入限制
 */

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    //第一个字符禁止输入空格
    if (range.length == 0 && range.location == 0 && [text isEqual: @" "])
    {
        return NO;
    }
    
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    // 将字符串首尾空格去掉
    textView.text = [textView.text  stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    return YES;
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if ([textView.text rangeOfString:@"."].location==NSNotFound) {
        isHaveDian = NO;
    }
    if ([text length]>0) {
        unichar single=[text characterAtIndex:0];//当前输入的字符
        if (NSUTF16StringEncoding)//数据格式正确
        {
            //首字母不能为0和小数点
            if([textView.text length]==0) //第一个数字不能为小数点
            {
                if(single == '.') {
                    [textView.text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                }
                if (single == '0') //第一个数字不能为0
                {
                    [textView.text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                }
            }
            if (single=='.')
            {
                if(!isHaveDian) //text中还没有小数点
                {
                    isHaveDian=YES;
                    return YES;
                }
                else //已经输入过小数点了，不能再输
                {
                    [textView.text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                }
            }
            else
            {
                if (isHaveDian) //存在小数点
                {
                    //判断小数点的位数
                    NSRange ran=[textView.text rangeOfString:@"."];
                    int tt=range.location-ran.location;
                    if (tt <= 2){
                        return YES;
                    }
                    else //最多输入两位小数
                    {
                        return NO;
                    }
                }
                else{
                    return YES;
                }
            }
        }
        else //输入的数据格式不正确
        {
            [textView.text stringByReplacingCharactersInRange:range withString:@""];
            return NO;
        }
    }
    else {
        return YES;
    }
}


/*********************************************************/


#pragma mark - 设置 UISearchBar

//1. 设置背景图是为了去掉上下黑线
self.searchBar.backgroundImage = [[UIImage alloc] init];

//2. 设置圆角和边框颜色
//获取searchBar里面的TextField
UITextField *searchField = [self.searchBar valueForKey:@"searchField"];

if (searchField) {
    [searchField setBackgroundColor:[UIColor whiteColor]];
    searchField.layer.cornerRadius = 0.0f;
    searchField.layer.borderColor = [UIColor colorWithWhite:0.961 alpha:1.000].CGColor;
    searchField.layer.borderWidth = 1;
    searchField.layer.masksToBounds = YES;
    
    //更改searchBar 中PlaceHolder 字体颜色
    [searchField setValue:[UIColor colorWithRed:0.129 green:0.667 blue:0.702 alpha:1.000] forKeyPath:@"_placeholderLabel.textColor"];
}

//4. 设置输入框文字颜色和字体
[UITextField appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]].textColor = [UIColor colorWithRed:0.129 green:0.667 blue:0.702 alpha:1.000];

//5. 设置搜索Icon
[self.searchBar setImage:[UIImage imageNamed:@"ic_search"]
        forSearchBarIcon:UISearchBarIconSearch
                   state:UIControlStateNormal];


#pragma mark - UISearchBarDelegate
// 搜索文字改变
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
}
// 搜索开始编辑
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    //设置取消按钮样式
    //首先取出cancelBtn
    UIButton *cancelBtn = [searchBar valueForKey:@"cancelButton"];
    //取消按钮文字
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    //取消按钮文字颜色
    [cancelBtn setTitleColor:[UIColor colorWithRed:0.129 green:0.667 blue:0.702 alpha:1.000] forState:UIControlStateNormal];
    
}

// 编辑
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    //展示取消按钮
    searchBar.showsCancelButton = YES;
    return YES;
}
// 编辑
- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar {
    return YES;
}
// 取消按钮点击
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    searchBar.text = @"";
    //收起键盘
    [searchBar resignFirstResponder];
    //隐藏取消按钮
    [searchBar setShowsCancelButton:NO animated:YES];
    
}
// 键盘return按钮
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"搜索");
    
}


/*********************************************************/

/**
 *  本地txt文件中存放son  转成 dict
 */

NSString * path = [[NSBundle mainBundle] pathForResource:@"companyModel" ofType:@"txt"];
//NSData *data = [NSData dataWithContentsOfFile:path];
//NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
NSString * str = [NSString stringWithContentsOfFile:path encoding:NSASCIIStringEncoding error:nil];
NSData *data = [[NSData alloc]initWithData:[str dataUsingEncoding:NSUTF8StringEncoding]];
NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
NSLog(@"%@",dic);


/*********************************************************/

//iOS 系统应用调用: 电话、短信息、邮件、跳转到应用商店

#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
@interface ViewController ()<MFMessageComposeViewControllerDelegate,MFMailComposeViewControllerDelegate>
@end

在相应按钮的点击方法中实现相关的功能，并实现相应的代理方法
//打电话
- (IBAction)clickBtn:(id)sender {
    //通过UIWebView实现
    UIWebView *phoneWV = [[UIWebView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:phoneWV];
    //读入电话号码
    NSString *urlStr = [NSString stringWithFormat:@"tel:%@",self.myText.text];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //加载请求
    [phoneWV loadRequest:request];
}

//发短信
- (IBAction)clickSmsBtn:(id)sender {
    if( [MFMessageComposeViewController canSendText] ){
        MFMessageComposeViewController * controller = [[MFMessageComposeViewController alloc]init];
        controller.recipients = [NSArray arrayWithObject:self.myText.text];
        controller.body = @"测试发短信";
        controller.messageComposeDelegate = self;
        [self presentViewController:controller animated:YES completion:nil];
    }else{
        NSLog(@"设备不具备短信功能");
    }
}
/*短信发送完成后返回app*/
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
    [controller dismissViewControllerAnimated:YES completion:nil];
    if (result ==  MessageComposeResultSent) {
        NSLog(@"发送成功");
    }
}


//发邮件
- (IBAction)clickEmailBtn:(id)sender {
    
    if ([MFMailComposeViewController canSendMail]) {
        
        MFMailComposeViewController* controller = [[MFMailComposeViewController alloc] init];
        controller.mailComposeDelegate = self;
        [controller setToRecipients:[NSArray arrayWithObjects:self.myText.text, nil]];
        [controller setSubject:@"邮件测试"];
        [controller setMessageBody:@"Hello " isHTML:NO];
        [self presentViewController:controller animated:YES completion:nil];
    }else{
        NSLog(@"设备不具备发送邮件功能");
    }
    
}
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    if (result == MFMailComposeResultSent) {
        NSLog(@"邮件发送成功");
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}
// 跳转到应用商店
[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/cn/app/zsdl/id796332505?mt=8"]];


/*********************************************************/
// 拆分字符串
"gpsposition":"29.444748,104.420663",

NSString *lattude = [gpsposition componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@","]][0];

NSString *longitude = [gpsposition componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@","]][1];

/*********************************************************/
// 全局键盘管理
IQKeyboardReturnKeyHandler 设置return收起键盘

#import "IQKeyboardReturnKeyHandler.h"


@property (nonatomic, strong) IQKeyboardReturnKeyHandler *returnKeyHandler; //键盘return

self.returnKeyHandler = [[IQKeyboardReturnKeyHandler alloc] initWithViewController:self];


- (void)dealloc {
    self.returnKeyHandler = nil;
}

/*********************************************************/
#pragma mark -  图片贴圆角
// 切圆角
- (void)cutRoundView:(UIImageView *)imageView
{
    CGFloat corner = imageView.frame.size.width / 2;
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:imageView.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(corner, corner)];
    shapeLayer.path = path.CGPath;
    imageView.layer.mask = shapeLayer;
}
