//
//  NSObject+Extras.m
//  TestDemo
//
//  Created by AaltoChen on 15/10/31.
//  Copyright © 2015年 AaltoChen. All rights reserved.
//

#import "NSObject+Extras.h"

@implementation NSObject (Extras)

static char *NSObject_Extras_lastPoint = "NSObject_Extras_lastPoint";
@dynamic lastPoint;

static char *NSObject_Extras_indexPath = "NSObject_Extras_indexPath";
@dynamic _indexPath;

static char *NSObject_Extras_currentPage = "NSObject_Extras_currentPage";
@dynamic _currentPage;

static char *NSObject_Extras_pageSize = "NSObject_Extras_pageSize";
@dynamic _pageSize;

static char *NSObject_Extras_index = "NSObject_Extras_index";
@dynamic _index;

static char *NSObject_Extras_viewModel = "NSObject_Extras_viewModel";
@dynamic viewModel;

static char *NSObject_Extras_internationalizationKEY = "NSObject_Extras_internationalizationKEY";
@dynamic internationalizationKEY;

#pragma mark —— 宏
/// App 国际化相关系统宏二次封装 + 设置缺省值
+(NSString *_Nullable)localStringWithKey:(nonnull NSString *)key{
    return NSLocalizedString(key, nil);
}

+(NSString *_Nullable)localizedString:(nonnull NSString *)key
                            fromTable:(nullable NSString *)tableName{
    return NSLocalizedStringFromTable(key,
                                      tableName,
                                      nil);
}

+(NSString *_Nullable)localizedString:(nonnull NSString *)key
                            fromTable:(nullable NSString *)tableName
                             inBundle:(nullable NSBundle *)bundle{
    return NSLocalizedStringFromTableInBundle(key,
                                              tableName,
                                              bundle ? : NSBundle.mainBundle,
                                              nil);
}

+(NSString *_Nullable)localizedString:(nonnull NSString *)key
                            fromTable:(nullable NSString *)tableName
                             inBundle:(nullable NSBundle *)bundle
                         defaultValue:(nullable NSString *)defaultValue{
    return NSLocalizedStringWithDefaultValue(key,
                                             tableName,
                                             bundle ? : NSBundle.mainBundle,
                                             defaultValue,
                                             nil);
}
#pragma mark —— ViewController
-(UIViewController *_Nullable)getCurrentViewController{
    return [self getCurrentViewControllerFromRootVC:getMainWindow().rootViewController];;
}

-(UIViewController *_Nullable)getCurrentViewControllerFromRootVC:(UIViewController *_Nullable)rootVC{
    UIViewController *currentVC;
    if ([rootVC presentedViewController]) {
        // 视图是被presented出来的
        rootVC = [rootVC presentedViewController];
    }

    if ([rootVC isKindOfClass:UITabBarController.class]) {
        // 根视图为UITabBarController
        currentVC = [self getCurrentViewControllerFromRootVC:[(UITabBarController *)rootVC selectedViewController]];
    } else if ([rootVC isKindOfClass:UINavigationController.class]){
        // 根视图为UINavigationController
        currentVC = [self getCurrentViewControllerFromRootVC:[(UINavigationController *)rootVC visibleViewController]];
    } else {
        // 根视图为非导航类
        currentVC = rootVC;
    }return currentVC;
}
/**
    【强制展现页面】
    1、本类如果是ViewController则用本类推；
    2、否则用向下遍历用最近的ViewController来推；
    3、如果想用AppDelegate的自定义TabbarVC：
        extern AppDelegate *appDelegate;
        (UIViewController *)appDelegate.tabBarVC;
 
    @param toPushVC 需要进行展现的页面
    @param requestParams 正向推页面传递的参数
 */
-(void)forceComingToPushVC:(UIViewController *_Nonnull)toPushVC
             requestParams:(id _Nullable)requestParams{
    UIViewController *viewController = [self isKindOfClass:UIViewController.class] ? (UIViewController *)self : self.getCurrentViewController;
    if (viewController) {
        [viewController comingToPushVC:toPushVC
                         requestParams:requestParams];
    }else{
        NSLog(@"%@强制展现页面%@失败,携带的参数%@",viewController,toPushVC,requestParams);
        [WHToast toastErrMsg:@"强制展现页面失败,请检查控制台"];
    }
}
#pragma mark —— KVO
/**
 
 在 self里面实现下列方法：实现监听
 -(void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary*)change
                       context:(void *)context{
     if ([object isKindOfClass:UIScrollView.class]) {
         UIScrollView *scrollView = (UIScrollView *)object;
         CGPoint point = [((NSValue *)[scrollView valueForKey:@"contentOffset"]) CGPointValue];
         NSLog(@"point.x = %f,point.y = %f",point.x,point.y);
     }
 }
 */
/// 添加监听【针对UIScrollView 的 ContentOffset 属性】
-(void)monitorContentOffsetScrollView:(UIScrollView *_Nonnull)scrollView{
    [scrollView addObserver:self
                 forKeyPath:@"contentOffset"
                    options:NSKeyValueObservingOptionNew
                    context:nil];
}
#pragma mark —— 功能性的
/// 给定一个数据源（数组）和 每行需要展示的元素个数，计算行数
/// @param elementNumberInEveryLine 每行需要展示的元素个数
/// @param arr 数据源（数组）
-(NSInteger)lineNum:(NSInteger)elementNumberInEveryLine
             byData:(NSArray *_Nonnull)arr{
    return (arr.count + (elementNumberInEveryLine - 1)) / elementNumberInEveryLine;
}
/**
 ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️
 -(ScrollDirection)judgementScrollDirectionByPoint:(CGPoint)point;
                    和
 -(CGFloat)scrollOffsetByDirectionXPoint:(CGPoint)point；
 -(CGFloat)scrollOffsetByDirectionYPoint:(CGPoint)point;
                   互斥
 * 因为 全局是用唯一变量lastPoint进行保存和判定
 * 而不断地滚动会不断地对lastPoint这个值进行冲刷
 * 而这两个方法都会依赖同一个lastPoint，所以会出现偏差
 ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️ ⚠️
 */
/// X 轴方向的偏移量
-(CGFloat)scrollOffsetByDirectionXPoint:(CGPoint)point{
    CGFloat f = self.lastPoint.x - point.x;
    self.lastPoint = point;
    return f;
}
/// Y 轴方向的偏移量
-(CGFloat)scrollOffsetByDirectionYPoint:(CGPoint)point{
    CGFloat f = self.lastPoint.y - point.y;
    self.lastPoint = point;
    return f;
}
/// 依据不断地传入的CGPoint *point，系统通过lastPoint来记录上一次的数据，两者进行比较，以此判断滑动的方向
/// @param point 最新的point
-(ScrollDirection)judgementScrollDirectionByPoint:(CGPoint)point{
    ScrollDirection direction = ScrollDirectionNone;
    if (self.lastPoint.x > point.x &&
        self.lastPoint.y == point.y) {
        NSLog(@"👉🏻");
        direction = ScrollDirectionRight;
    }else if (self.lastPoint.x < point.x &&
              self.lastPoint.y == point.y){
        NSLog(@"👈🏻");
        direction = ScrollDirectionLeft;
    }else if (self.lastPoint.x == point.x &&
              self.lastPoint.y > point.y){
        NSLog(@"👇🏻");
        direction = ScrollDirectionDown;
    }else if (self.lastPoint.x == point.x &&
              self.lastPoint.y < point.y){
        NSLog(@"👆🏻");
        direction = ScrollDirectionUp;
    }else if (self.lastPoint.x > point.x &&
              self.lastPoint.y < point.y){
        NSLog(@"👉🏻👆🏻");
        direction = ScrollDirectionRight_UP;
    }else if (self.lastPoint.x < point.x &&
              self.lastPoint.y < point.y){
        NSLog(@"👈🏻👆🏻");
        direction = ScrollDirectionLeft_UP;
    }else if (self.lastPoint.x > point.x &&
              self.lastPoint.y > point.y){
        NSLog(@"👉🏻👇🏻");
        direction = ScrollDirectionRight_Down;
    }else if (self.lastPoint.x < point.x &&
              self.lastPoint.y > point.y){
        NSLog(@"👈🏻👇🏻");
        direction = ScrollDirectionLeft_Down;
    }
    self.lastPoint = point;
    return direction;
}
/// 创建IndexPath坐标
-(NSIndexPath *_Nonnull)myIndexPath:(JobsIndexPath)indexPath{
    if (AvailableSysVersion(6.0)) {
        return [NSIndexPath indexPathForItem:indexPath.rowOrItem inSection:indexPath.section];;
    }else{
        return [NSIndexPath indexPathForRow:indexPath.rowOrItem inSection:indexPath.section];
    }
}
/// 点击任意一个view，下拉弹出与此View等宽，且与下底有一个motivateViewOffset距离的列表
/// @param motivateFromView 点击的锚点View
/// @param data 列表数据源
/// @param motivateViewOffset 下拉列表和motivateFromView保持一个motivateViewOffset的距离
/// @param finishBlock 点击列表以后的回调数据是UIViewModel类型
-(JobsDropDownListView *_Nullable)motivateFromView:(UIView * _Nonnull)motivateFromView
                                              data:(NSMutableArray <UIViewModel *>* _Nullable)data
                                motivateViewOffset:(CGFloat)motivateViewOffset
                                       finishBlock:(MKDataBlock _Nullable)finishBlock{
    
    JobsDropDownListView *dropDownListView = JobsDropDownListView.new;
    [dropDownListView actionViewBlock:^(id data) {
        if ([motivateFromView isKindOfClass:UIButton.class]) {
            UIButton *btn = (UIButton *)motivateFromView;
            btn.selected = !btn.selected;
        }
        
        if (finishBlock) finishBlock(data);
        
        [dropDownListView dropDownListViewDisappear];
    }];
    
    dropDownListView.backgroundColor = kRedColor;

    if (!data) {
        data = NSMutableArray.array;
        {
            UIViewModel *viewModel = UIViewModel.new;
            viewModel.text = @"111111111";
            viewModel.subText = @"QQQQQQ";
            [data addObject:viewModel];
        }
        
        {
            UIViewModel *viewModel = UIViewModel.new;
            viewModel.text = @"222222222";
            viewModel.subText = @"WWWWWW";
            [data addObject:viewModel];
        }
        
        {
            UIViewModel *viewModel = UIViewModel.new;
            viewModel.text = @"333333333";
            viewModel.subText = @"EEEEEE";
            [data addObject:viewModel];
        }
    }
    [dropDownListView richElementsInViewWithModel:data];
    CGRect f = [NSObject getWindowFrameByView:motivateFromView];
    dropDownListView.frame = CGRectMake(f.origin.x,
                                        f.origin.y + f.size.height + motivateViewOffset,
                                        f.size.width,
                                        data.count * [JobsDropDownListTBVCell cellHeightWithModel:Nil]);
    [getMainWindow() addSubview:dropDownListView];
    return dropDownListView;
}
/// iOS 获取任意控件在屏幕中的坐标
+(CGRect)getWindowFrameByView:(UIView *_Nonnull)view{
    // 将rect由rect所在视图转换到目标视图view中，返回在目标视图view中的rect
    CGRect rect = [view convertRect:view.bounds toView:getMainWindow()];
    return rect;
    /**
      类似的：
     // 将像素point由point所在视图转换到目标视图view中，返回在目标视图view中的像素值
     - (CGPoint)convertPoint:(CGPoint)point toView:(UIView *)view;
     // 将像素point从view中转换到当前视图中，返回在当前视图中的像素值
     - (CGPoint)convertPoint:(CGPoint)point fromView:(UIView *)view;
     // 将rect由rect所在视图转换到目标视图view中，返回在目标视图view中的rect
     - (CGRect)convertRect:(CGRect)rect toView:(UIView *)view;
     // 将rect从view中转换到当前视图中，返回在当前视图中的rect
     - (CGRect)convertRect:(CGRect)rect fromView:(UIView *)view;
     */
}
/// 依据View上铆定的internationalizationKEY来全局更改文字以适配国际化
-(void)languageSwitch{
    UIView *v = nil;
    if ([self isKindOfClass:UIViewController.class]) {
        UIViewController *viewController = (UIViewController *)self;
        v = viewController.view;
    }else if ([self isKindOfClass:UIView.class]){
        UIView *viewer = (UIView *)self;
        v = viewer;
    }else{}
    
    if (v) {
        for (UIView *view in v.subviews) {
            if (![NSString isNullString:view.internationalizationKEY]) {
                if ([view isKindOfClass:UILabel.class]) {
                    UILabel *lab = (UILabel *)view;
                    lab.text = Internationalization(view.internationalizationKEY);
                }else if ([view isKindOfClass:UIButton.class]){
                    UIButton *btn = (UIButton *)view;
                    [btn normalTitle:Internationalization(view.internationalizationKEY)];
                }else{}
            }
        }
    }
}
/// 打印请求体
+(void)printRequestMessage:(NSURLSessionDataTask *_Nonnull)task{
    if (task) {
        // 请求URL
        NSLog(@"请求URL:%@\n",task.originalRequest.URL);
        
        // 请求方式
        NSLog(@"请求方式:%@\n",task.originalRequest.HTTPMethod);
        
        // 请求头信息
        NSLog(@"请求头信息:%@\n",task.originalRequest.allHTTPHeaderFields);
        
        // 请求正文信息
        NSLog(@"请求正文信息:%@\n",[[NSString alloc] initWithData:task.originalRequest.HTTPBody encoding:NSUTF8StringEncoding]);
        
    //    // 请求响应时间
    //    NSTimeInterval time = [[NSDate date] timeIntervalSinceDate:NSDate.date];
    //    NSLog(@"请求响应时间:%@\n",@(time));
    //    NSLog(@"\n请求URL:%@\n请求方式:%@\n请求头信息:%@\n请求正文信息:%@\n请求响应时间:%@\n",task.originalRequest.URL,task.originalRequest.HTTPMethod,task.originalRequest.allHTTPHeaderFields,[[NSString alloc] initWithData:task.originalRequest.HTTPBody encoding:NSUTF8StringEncoding],@(time));
    }else{
        NSLog(@"NSURLSessionDataTask *task 为空,请检查");
    }
}
/// 判断是否是此版本App的首次启动
-(BOOL)isAppFirstLaunch{
    BOOL isFirstLaunch = [NSUserDefaults.standardUserDefaults boolForKey:@"AppFirstLaunch"];
    if (!isFirstLaunch) {
        [NSUserDefaults.standardUserDefaults setBool:YES forKey:@"AppFirstLaunch"];
        [NSUserDefaults.standardUserDefaults synchronize];
    }return !isFirstLaunch;
}
/// 判断是否是App今日的首次启动
-(BOOL)isTodayAppFirstLaunch{
    NSString *recordToday = [NSUserDefaults.standardUserDefaults valueForKey:@"TodayAppFirstLaunch"];
    JobsTimeModel *timeModel = JobsTimeModel.new;
    NSString *today = [NSString stringWithFormat:@"%ld-%ld-%ld-%ld",timeModel.currentEra,timeModel.currentYear,timeModel.currentMonth,timeModel.currentDay];
    if ([recordToday isEqualToString:today]) {
        NSLog(@"今天已经启动过");
    }else{
        NSLog(@"今天第一次启动");
        [NSUserDefaults.standardUserDefaults setValue:today forKey:@"TodayAppFirstLaunch"];
        [NSUserDefaults.standardUserDefaults synchronize];//
    }return ![recordToday isEqualToString:today];
}
/// 震动特效反馈
+(void)feedbackGenerator{
    if (@available(iOS 10.0, *)) {
        UIImpactFeedbackGenerator *generator = [UIImpactFeedbackGenerator.alloc initWithStyle:UIImpactFeedbackStyleMedium];
        [generator prepare];
        [generator impactOccurred];
    } else {
        // Fallback on earlier versions
        AudioServicesPlaySystemSound(1520);
    }
}
/// 检测用户是否锁屏：根据屏幕光线来进行判定，而不是系统通知
+(BOOL)didUserPressLockButton{
    //获取屏幕亮度
    CGFloat oldBrightness = [UIScreen mainScreen].brightness;
    //以较小的数量改变屏幕亮度
    [UIScreen mainScreen].brightness = oldBrightness + (oldBrightness <= 0.01 ? (0.01) : (-0.01));
    CGFloat newBrightness  = [UIScreen mainScreen].brightness;
    //恢复屏幕亮度
    [UIScreen mainScreen].brightness = oldBrightness;
    //判断屏幕亮度是否能够被改变
    return oldBrightness != newBrightness;
}
/// iOS 限制自动锁屏 lockSwitch:YES(关闭自动锁屏)
+(void)autoLockedScreen:(BOOL)lockSwitch{
    [UIApplication.sharedApplication setIdleTimerDisabled:lockSwitch];
}

+(void)savePic:(GKPhotoBrowser *_Nonnull)browser{
    if (browser) {
        GKPhoto *photo = browser.photos[browser.currentIndex];
        
        NSData *imageData = nil;
        
        if ([photo.image isKindOfClass:[SDAnimatedImage class]]) {
            imageData = [(SDAnimatedImage *)photo.image animatedImageData];
        }else if ([photo.image isKindOfClass:[YYImage class]]) {
            imageData = [(YYImage *)photo.image animatedImageData];
        }else {
            imageData = [photo.image sd_imageData];
        }
        
        if (!imageData) return;
        
        [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
            if (@available(iOS 9, *)) {
                PHAssetCreationRequest *request = [PHAssetCreationRequest creationRequestForAsset];
                [request addResourceWithType:PHAssetResourceTypePhoto data:imageData options:nil];
                request.creationDate = [NSDate date];
            }
        } completionHandler:^(BOOL success, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (success) {
                    NSLog(@"保存照片成功");
                    [WHToast showSuccessWithMessage:@"图片保存成功"
                                           duration:2
                                      finishHandler:^{}];
                } else if (error) {
                    [WHToast showErrorWithMessage:@"保存保存失败"
                                         duration:2
                                    finishHandler:^{}];
                    NSLog(@"保存照片出错:%@",error.localizedDescription);
                }
            });
        }];
    }else{
        NSLog(@"GKPhotoBrowser * 为空");
    }
}
/// 将基本数据类型（先统一默认视作浮点数）转化为图片进行显示。使用前提，图片的名字命令为0~9，方便进行映射
/// @param inputData 需要进行转换映射的基本数据类型数据
/// @param bitNum 如果操作对象是浮点数，那么小数点后需要保留的位数
-(nonnull NSMutableArray <UIImage *>*)translateToArr:(CGFloat)inputData
                                   saveBitAfterPoint:(NSInteger)bitNum{
    
    if ([self isFloat:inputData] && !bitNum) {
        bitNum = 2;//默认保存小数点后2位
    }

    NSString *format = [@"%." stringByAppendingString:[NSString stringWithFormat:@"%ldf",bitNum]];
    NSString *str = [NSString stringWithFormat:format,inputData];
    
    NSMutableArray <NSString *>*resultMutArr = NSMutableArray.array;// For test
    NSMutableArray <UIImage *>*resultIMGMutArr = NSMutableArray.array;
    
    NSUInteger len = str.length;
    unichar buffer[len + 1];
    [str getCharacters:buffer
                 range:NSMakeRange(0, len)];
    
    for(int i = 0; i < len; i++) {
        NSLog(@"%C", buffer[i]);
        NSString *temp = [NSString stringWithFormat:@"%C",buffer[i]];
        [resultMutArr addObject:temp];
        // 数字映射图片
        if ([temp isEqualToString:@"."]) {
            temp = @"小数点";
        }
        [resultIMGMutArr addObject:KIMG(temp)];
    }
    NSLog(@"resultMutArr【For Test】 = %@",resultMutArr);
    return resultIMGMutArr;
}
/// 读取本地的plist文件到内存  【 plist ——> NSDictionary * 】
/// @param fileName Plist文件名
-(nullable NSDictionary *)readLocalPlistWithFileName:(nullable NSString *)fileName{
    NSString *filePath = getPathForResource(nil,
                                            fileName,
                                            nil,
                                            @"plist");
    
    if ([FileFolderHandleTool isExistsAtPath:filePath]) {
        return [[NSDictionary alloc] initWithContentsOfFile:filePath];
    }return nil;
}
/// 监听程序被杀死前的时刻，进行一些需要异步的操作：磁盘读写、网络请求...
-(void)terminalCheck:(MKDataBlock _Nullable)checkBlock{
    [NSNotificationCenter.defaultCenter addObserver:self
                                           selector:selectorBlocks(^(id  _Nullable weakSelf,
                                                                     id  _Nullable arg) {
        //进行埋点操作
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            NSLog(@"我只执行一次");
            // 在这里写遗言：最后希望去完成的事情
            if (checkBlock) {
                checkBlock(@1);
            }
            [NSThread sleepForTimeInterval:60];
            NSLog(@"程序被杀死");
        });
    }, self)
                                               name:@"UIApplicationWillTerminateNotification"
                                             object:nil];
}
/// Object转换为NSData
+(NSData *_Nullable)transformToData:(id _Nullable)object{
    if ([object isKindOfClass:NSString.class]) {
        NSString *string = (NSString *)object;
        return [string dataUsingEncoding:NSUTF8StringEncoding];
    }else if ([object isKindOfClass:NSArray.class]){
        NSArray *array = (NSArray *)object;
        NSError *err = nil;
        /*
         *  object 要归档的对象图的根
         *  requiresSecureCoding 一个布尔值，指示是否所有编码对象都必须符合 NSSecureCoding
         *  error 返回时，是编码时发生的错误，或者nil没有发生错误
         */
        if (@available(iOS 11.0, *)) {
            return [NSKeyedArchiver archivedDataWithRootObject:array
                                         requiringSecureCoding:YES
                                                         error:&err];
        } else {
            SuppressWdeprecatedDeclarationsWarning(return [NSKeyedArchiver archivedDataWithRootObject:array]);
        }
    }else if ([object isKindOfClass:NSDictionary.class]){
        NSDictionary *dictionary = (NSDictionary *)object;
        NSError *err = nil;
        return [NSJSONSerialization dataWithJSONObject:dictionary
                                               options:NSJSONWritingPrettyPrinted
                                                 error:&err];
    }else{
        return nil;
    }
}
/// 获取当前设备可用内存
+(double)availableMemory{
    vm_statistics_data_t vmStats;
    mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;
    kern_return_t kernReturn = host_statistics(mach_host_self(),
                                               HOST_VM_INFO,
                                               (host_info_t)&vmStats,
                                               &infoCount);
    if (kernReturn != KERN_SUCCESS) {
        return NSNotFound;
    }
    return ((vm_page_size * vmStats.free_count)/1024.0)/1024.0;
}
/// 获取当前任务所占用内存
+(double)usedMemory{
    task_basic_info_data_t taskInfo;
    mach_msg_type_number_t infoCount = TASK_BASIC_INFO_COUNT;
    kern_return_t kernReturn = task_info(mach_task_self(),
                                         TASK_BASIC_INFO,
                                         (task_info_t)&taskInfo,
                                         &infoCount);
    if (kernReturn != KERN_SUCCESS) {
        return NSNotFound;
    }return taskInfo.resident_size/1024.0/1024.0;
}
#pragma mark —— 尺寸
/*
    参考资料：https://blog.csdn.net/www9500net_/article/details/52437987
 */
/// TableViewCell 相对于此TableView的frame【用indexPath】
/// @param tableView 此TableView
/// @param indexPath 用indexPath定位📌TableViewCell
-(CGRect)tbvCellRectInTableView:(UITableView *_Nonnull)tableView
                    atIndexPath:(NSIndexPath *_Nonnull)indexPath{
    return [tableView rectForRowAtIndexPath:indexPath];
}
/// TableViewCell 相对于此TableView的frame【用TableViewCell】❤️
-(CGRect)tableViewCell:(UITableViewCell *_Nonnull)tableViewCell
      frameInTableView:(UITableView *_Nonnull)tableView{
    NSIndexPath *indexPath = [tableView indexPathForCell:tableViewCell];
    return [tableView rectForRowAtIndexPath:indexPath];
}
/// TableViewCell 相对于承接此tableView的父视图的frame【用indexPath】
/// @param tableView 此TableView
/// @param tbvSuperview 承接这个TableView的父容器View
/// @param indexPath 用indexPath定位📌TableViewCell
-(CGRect)tableView:(UITableView *_Nonnull)tableView
      tbvSuperview:(UIView *_Nonnull)tbvSuperview
   cellAtIndexPath:(NSIndexPath *_Nonnull)indexPath{
    CGRect rectInTableView = [self tbvCellRectInTableView:tableView atIndexPath:indexPath];
    return [tableView convertRect:rectInTableView toView:tbvSuperview];
}
/// TableViewCell 相对于承接此tableView的父视图的frame【用TableViewCell】❤️
-(CGRect)tableView:(UITableView *_Nonnull)tableView
      tbvSuperview:(UIView *_Nonnull)tbvSuperview
     tableViewCell:(UITableViewCell *_Nonnull)tableViewCell{
    CGRect rectInTableView = [self tableViewCell:tableViewCell frameInTableView:tableView];
    return [tableView convertRect:rectInTableView toView:tbvSuperview];
}
/// 获取CollectionViewCell在当前collection的位置【用indexPath】
/// @param collectionView 此CollectionView
/// @param indexPath 用indexPath定位📌CollectionViewCell
-(CGRect)frameInCollectionView:(UICollectionView *_Nonnull)collectionView
               cellAtIndexPath:(NSIndexPath *_Nonnull)indexPath{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    return [collectionView convertRect:cell.frame toView:collectionView];
}
/// 获取CollectionViewCell在当前collection的位置【用collectionViewCell】❤️
-(CGRect)collectionViewCell:(UICollectionViewCell *_Nonnull)collectionViewCell
      frameInCollectionView:(UICollectionView *_Nonnull)collectionView{
    return [collectionView convertRect:collectionViewCell.frame toView:collectionView];
}
/// 获取CollectionViewCell在当前屏幕的位置【用indexPath】
/// @param cvSuperview 承接这个CollectionView的父容器View
/// @param collectionView  此CollectionView
/// @param indexPath 用indexPath定位📌CollectionViewCell
-(CGRect)frameInCVSuperview:(UIView *_Nonnull)cvSuperview
             collectionView:(UICollectionView *_Nonnull)collectionView
            cellAtIndexPath:(NSIndexPath *_Nonnull)indexPath{
    CGRect cellInCollection = [self frameInCollectionView:collectionView
                                          cellAtIndexPath:indexPath];
    return [collectionView convertRect:cellInCollection toView:cvSuperview];
}
/// 获取CollectionViewCell在当前屏幕的位置【用collectionViewCell】❤️
-(CGRect)frameInCVSuperview:(UIView *_Nonnull)cvSuperview
             collectionView:(UICollectionView *_Nonnull)collectionView
         collectionViewCell:(UICollectionViewCell *_Nonnull)collectionViewCell{
    CGRect cellInCollection = [self collectionViewCell:collectionViewCell frameInCollectionView:collectionView];
    return [collectionView convertRect:cellInCollection toView:cvSuperview];
}
#pragma mark —— 数字
/// 获取任意数字最高位数字
-(NSInteger)getTopDigit:(NSInteger)number{
    // makes sure you really get the digit!
    number = labs(number);// abs()
    if (number < 10){
        return number;
    }return [self getTopDigit:((number - (number % 10)) / 10)];
}
/// 判断任意给定的一个整型是多少位数
-(NSInteger)bitNum:(NSInteger)number{
    NSInteger count = 0;
    while(number != 0){
        number /= 10;
        count++;
    }
    printf("数字是 %ld 位数。", (long)count);
    return count;
}
/// 判断任意数字是否为小数
-(BOOL)isFloat:(CGFloat)num{
    return num - (int)num;
}
/**
    判断 num1 是否能被 num2 整除
    也就是判断 num2 是否是 num1 的整数倍
    也就是判断 num1 除以 num2 的余数是否是 0
 
    特别指出的是：
    1、除数为零的情况，被判定为不能被整除；
    2、num1 和 num2 必须为 NSNumber* 类型，否则判定为不能够被整除
 
 */
-(BOOL)judgementExactDivisionByNum1:(NSNumber *_Nonnull)num1
                               num2:(NSNumber *_Nonnull)num2{
    /// 过滤数据类型
    if (![num1 isKindOfClass:NSNumber.class] || ![num2 isKindOfClass:NSNumber.class]) {
        return NO;
    }
    /// 在数据类型为NSNumber* 的基础上进行讨论和判断
    if (num1 == num2) {
        return YES;
    }
    
    if (num2.floatValue) {
        int a = num2.intValue;
        double s1 = num1.doubleValue;
        int s2 = num1.intValue;
        return s1/a-s2/a <= 0;
    }else{
        return YES;
    }
}
#pragma mark —— 键盘⌨️
/// 加入键盘通知的监听者
-(void)keyboard{
    [NSNotificationCenter.defaultCenter addObserver:self
                                           selector:@selector(keyboardWillChangeFrameNotification:)
                                               name:UIKeyboardWillChangeFrameNotification
                                             object:nil];
    
    [NSNotificationCenter.defaultCenter addObserver:self
                                           selector:@selector(keyboardDidChangeFrameNotification:)
                                               name:UIKeyboardDidChangeFrameNotification
                                             object:nil];
}
/// 键盘 弹出 和 收回 走这个方法
-(void)keyboardWillChangeFrameNotification:(NSNotification *_Nullable)notification{
    NSDictionary *userInfo = notification.userInfo;
    CGRect beginFrame = [userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGRect endFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat KeyboardOffsetY = beginFrame.origin.y - endFrame.origin.y;// 正则抬起 ，负值下降
    NSLog(@"KeyboardOffsetY = %f",KeyboardOffsetY);
 
    if (KeyboardOffsetY > 0) {
        NSLog(@"键盘抬起");
    }else if(KeyboardOffsetY < 0){
        NSLog(@"键盘收回");
    }else{
        NSLog(@"键盘");
    }
}

-(void)keyboardDidChangeFrameNotification:(NSNotification *_Nullable)notification{}
#pragma mark —— 刷新
/// 停止刷新【可能还有数据的情况，状态为：MJRefreshStateIdle】
-(void)endRefreshing:(UIScrollView *_Nonnull)targetScrollView{
    if ([targetScrollView isKindOfClass:UITableView.class]) {
        UITableView *tableView = (UITableView *)targetScrollView;
        [tableView reloadData];
    }else if ([targetScrollView isKindOfClass:UICollectionView.class]){
        UICollectionView *collectionView = (UICollectionView *)targetScrollView;
        [collectionView reloadData];
    }else{}
    
    [targetScrollView tab_endAnimation];//里面实现了 [self.collectionView reloadData];
    
    [self endMJHeaderRefreshing:targetScrollView];
    [self endMJFooterRefreshingWithMoreData:targetScrollView];
}
/// 停止刷新【没有数据的情况，状态为：MJRefreshStateNoMoreData】
-(void)endRefreshingWithNoMoreData:(UIScrollView *_Nonnull)targetScrollView{
    if ([targetScrollView isKindOfClass:UITableView.class]) {
        UITableView *tableView = (UITableView *)targetScrollView;
        [tableView reloadData];
    }else if ([targetScrollView isKindOfClass:UICollectionView.class]){
        UICollectionView *collectionView = (UICollectionView *)targetScrollView;
        [collectionView reloadData];
    }else{}
    
    [targetScrollView tab_endAnimation];//里面实现了 [self.collectionView reloadData];

    [self endMJHeaderRefreshing:targetScrollView];
    [self endMJFooterRefreshingWithNoMoreData:targetScrollView];
}
/// 停止MJHeader的刷新
-(void)endMJHeaderRefreshing:(UIScrollView *_Nonnull)targetScrollView{
    if (targetScrollView.mj_header.refreshing) {
        [targetScrollView.mj_header endRefreshing];// 结束刷新
    }
}
/// 停止MJFooter的刷新【没有数据的情况，状态为：MJRefreshStateNoMoreData】
-(void)endMJFooterRefreshingWithNoMoreData:(UIScrollView *_Nonnull)targetScrollView{
    if (targetScrollView.mj_footer.refreshing) {
        [targetScrollView.mj_footer endRefreshingWithNoMoreData];// 结束刷新
    }
}
/// 停止MJFooter刷新【可能还有数据的情况，状态为：MJRefreshStateIdle】
-(void)endMJFooterRefreshingWithMoreData:(UIScrollView *_Nonnull)targetScrollView{
    if (targetScrollView.mj_footer.refreshing) {
        [targetScrollView.mj_footer endRefreshing];// 结束刷新
    }else{
        [targetScrollView.mj_footer resetNoMoreData];// 结束刷新
    }
}
/// 根据数据源【数组】是否有值进行判定：占位图 和 mj_footer 的显隐性
-(void)dataSource:(NSArray *_Nonnull)dataSource
      contentView:(UIScrollView *_Nonnull)contentView{
    if (dataSource.count) {
        [contentView ly_hideEmptyView];
        contentView.ly_emptyView.alpha = 0;
    }else{
        [contentView ly_showEmptyView];
        contentView.ly_emptyView.alpha = 1;
    }
    contentView.mj_footer.hidden = !dataSource.count;
}
#pragma mark —— 参数 和 相关调用
/// 如果某个实例对象存在某个【不带参数的方法】，则对其调用执行
/// @param targetObj 靶点，方法在哪里
/// @param methodName 不带参数的方法名
+(void)targetObj:(nonnull NSObject *)targetObj
callingMethodWithName:(nullable NSString *)methodName{
    if ([NSObject judgementObj:targetObj existMethodWithName:methodName]) {
        SuppressWarcPerformSelectorLeaksWarning([targetObj performSelector:NSSelectorFromString(methodName)]);
    }else{
        NSLog(@"目标类：%@,不存在此方法：%@,请检查",targetObj.class,methodName);
    }
}
/// 如果某个实例对象存在某个【不带参数的方法】，则对其调用执行
/// @param methodName 不带参数的方法名
-(void)callingMethodWithName:(nullable NSString *)methodName{
    if ([NSObject judgementObj:self existMethodWithName:methodName]) {
        SuppressWarcPerformSelectorLeaksWarning([self performSelector:NSSelectorFromString(methodName)]);
    }else{
        NSLog(@"目标类：%@,不存在此方法：%@,请检查",self.class,methodName);
    }
}
/// 使用 dispatch_once 来执行只需运行一次的线程安全代码
/// @param methodName 需要执行的方法的方法名（不带参数）
-(void)dispatchOnceInvokingWithMethodName:(nullable NSString *)methodName{
    static dispatch_once_t NSObjectDispatchOnce;
    @jobs_weakify(self)
    dispatch_once(&NSObjectDispatchOnce, ^{
        [weak_self callingMethodWithName:methodName];
    });
}
/// NSInvocation的使用，方法多参数传递
/// @param methodName 方法名
/// @param targetObj 靶点，方法在哪里
/// @param paramarrays 参数数组
+(void)methodName:(NSString *_Nonnull)methodName
        targetObj:(id _Nonnull)targetObj
      paramarrays:(NSArray *_Nullable)paramarrays{
    SEL selector = NSSelectorFromString(methodName);
    /*
     NSMethodSignature有两个常用的只读属性
     a. numberOfArguments:方法参数的个数
     b. methodReturnLength:方法返回值类型的长度，大于0表示有返回值
     **/
    NSMethodSignature *signature = [targetObj methodSignatureForSelector:selector];
    //或使用下面这种方式
    //NSMethodSignature *signature = [[target class] instanceMethodSignatureForSelector:selector];
    
    if (!signature) {
        // 处理方式一：
        {
            [WHToast toastErrMsg:@"方法不存在,请检查参数"];
            return;
        }
        // 处理方式二：【经常崩溃损伤硬件】
//        {
//            //传入的方法不存在 就抛异常
//            NSString *info = [NSString stringWithFormat:@"-[%@ %@]:unrecognized selector sent to instance",[self class],NSStringFromSelector(selector)];
//            @throw [[NSException alloc] initWithName:@"方法不存在"
//                                              reason:info
//                                            userInfo:nil];
//        }
    }
    
    //只能使用该方法来创建，不能使用alloc init
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    invocation.target = targetObj;
    invocation.selector = selector;
    /*
     注意:
     1、下标从2开始，因为0、1已经被target与selector占用
     2、设置参数，必须传递参数的地址，不能直接传值
     **/
    for (int i = 2; i < paramarrays.count + 2; i++) {
        NSLog(@"i = %d",i);
        id d = paramarrays[i - 2];
        [invocation setArgument:&d atIndex:i];
    }
    // 执行方法
    [invocation invoke];
    //可以在invoke方法前添加，也可以在invoke方法后添加
    //通过方法签名的methodReturnLength判断是否有返回值
    if (signature.methodReturnLength > 0) {
        NSString *result = nil;
        [invocation getReturnValue:&result];
        NSLog(@"result = %@",result);
    }
}
/// 判断本程序是否存在某个类
+(BOOL)judgementAppExistClassWithName:(nullable NSString *)className{
    return NSClassFromString(className);
}
/// 判断某个实例对象是否存在某个【不带参数的方法】
+(BOOL)judgementObj:(nonnull NSObject *)obj
existMethodWithName:(nullable NSString *)methodName{
    if (!obj || [NSString isNullString:methodName]) {
        return NO;
    }else{
        SEL sel = NSSelectorFromString(methodName);
        return [obj respondsToSelector:sel];
    }
}
/// 用block来代替selector
SEL _Nullable selectorBlocks(void (^_Nullable block)(id _Nullable weakSelf, id _Nullable arg),
                             id _Nullable target){
    if (!block) {
        [NSException raise:@"block can not be nil"
                    format:@"%@ selectorBlock error", target];
    }
    NSString *selName = [NSString stringWithFormat:@"selector_%p:", block];
    SEL sel = NSSelectorFromString(selName);
    class_addMethod([target class],
                    sel,
                    (IMP)selectorImp,
                    "v@:@");
    objc_setAssociatedObject(target,
                             sel,
                             block,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
    return sel;
}

static void selectorImp(id self,
                        SEL _cmd,
                        id arg) {
    callback block = objc_getAssociatedObject(self, _cmd);
    __weak typeof(self) weakSelf = self;
    if (block) {
        block(weakSelf, arg);
    }
}
#pragma mark —— 属性的Set | GET
#pragma mark —— @property(nonatomic,assign)CGPoint lastPoint;
-(CGPoint)lastPoint{
    CGPoint LastPoint = [objc_getAssociatedObject(self,
                                                  NSObject_Extras_lastPoint) CGPointValue];
    return LastPoint;
}

-(void)setLastPoint:(CGPoint)lastPoint{
    objc_setAssociatedObject(self,
                             NSObject_Extras_lastPoint,
                             [NSValue valueWithCGPoint:lastPoint],
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,strong)NSIndexPath *_indexPath;
-(NSIndexPath *)_indexPath{
    return objc_getAssociatedObject(self, NSObject_Extras_indexPath);;
}

-(void)set_indexPath:(NSIndexPath *)_indexPath{
    objc_setAssociatedObject(self,
                             NSObject_Extras_indexPath,
                             _indexPath,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,assign)NSInteger _currentPage;
-(NSInteger)_currentPage{
    NSInteger _CurrentPage = [objc_getAssociatedObject(self, NSObject_Extras_currentPage) integerValue];
    if (_CurrentPage == 0) {
        _CurrentPage = 1;
        objc_setAssociatedObject(self,
                                 NSObject_Extras_currentPage,
                                 [NSNumber numberWithInteger:_CurrentPage],
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return _CurrentPage;
}

-(void)set_currentPage:(NSInteger)_currentPage{
    objc_setAssociatedObject(self,
                             NSObject_Extras_currentPage,
                             [NSNumber numberWithInteger:_currentPage],
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,assign)NSInteger _pageSize;
-(NSInteger)_pageSize{
    NSInteger _PageSize = [objc_getAssociatedObject(self, NSObject_Extras_pageSize) integerValue];
    if (_PageSize == 0) {
        _PageSize = 10;
        objc_setAssociatedObject(self,
                                 NSObject_Extras_pageSize,
                                 [NSNumber numberWithInteger:_PageSize],
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return _PageSize;
}

-(void)set_pageSize:(NSInteger)_pageSize{
    objc_setAssociatedObject(self,
                             NSObject_Extras_pageSize,
                             [NSNumber numberWithInteger:_pageSize],
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,assign)NSInteger _index;
-(NSInteger)_index{
    NSInteger _Index = [objc_getAssociatedObject(self, NSObject_Extras_index) integerValue];
    return _Index;
}

-(void)set_index:(NSInteger)_index{
    objc_setAssociatedObject(self,
                             NSObject_Extras_index,
                             [NSNumber numberWithInteger:_index],
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,strong)UIViewModel *viewModel;
-(UIViewModel *)viewModel{
    UIViewModel *ViewModel = objc_getAssociatedObject(self, NSObject_Extras_viewModel);
    if (!ViewModel) {
        ViewModel = UIViewModel.new;
        objc_setAssociatedObject(self,
                                 NSObject_Extras_viewModel,
                                 ViewModel,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return ViewModel;
}

-(void)setViewModel:(UIViewModel *)viewModel{
    objc_setAssociatedObject(self,
                             NSObject_Extras_viewModel,
                             viewModel,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark —— @property(nonatomic,strong)NSString *internationalizationKEY;/// 国际化的key
-(NSString *)internationalizationKEY{
    NSString *InternationalizationKEY = objc_getAssociatedObject(self, NSObject_Extras_internationalizationKEY);
    return InternationalizationKEY;
}

-(void)setInternationalizationKEY:(NSString *)internationalizationKEY{
    objc_setAssociatedObject(self,
                             NSObject_Extras_internationalizationKEY,
                             internationalizationKEY,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

