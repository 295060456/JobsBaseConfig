//
//  NSObject+Extras.h
//  TestDemo
//
//  Created by AaltoChen on 15/10/31.
//  Copyright Β© 2015εΉ΄ AaltoChen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>
#import <objc/runtime.h>
#import <sys/sysctl.h>
#import <mach/mach.h>

#import "BaseProtocol.h"
#import "UIViewModelProtocol.h"
#import "JobsBlock.h"
#import "MacroDef_Func.h"
#import "MacroDef_SysWarning.h"
#import "FileFolderHandleTool.h"

#if __has_include(<WHToast/WHToast.h>)
#import <WHToast/WHToast.h>
#else
#import "WHToast.h"
#endif

#if __has_include(<GKPhotoBrowser/GKPhotoBrowser.h>)
#import <GKPhotoBrowser/GKPhotoBrowser.h>
#else
#import "GKPhotoBrowser.h"
#endif

#if __has_include(<TABAnimated/TABAnimated.h>)
#import <TABAnimated/TABAnimated.h>
#else
#import "TABAnimated.h"
#endif

#if __has_include(<SDWebImage/SDWebImage.h>)
#import <SDWebImage/SDWebImage.h>
#else
#import "SDWebImage.h"
#endif

#if __has_include(<MJRefresh/MJRefresh.h>)
#import <MJRefresh/MJRefresh.h>
#else
#import "MJRefresh.h"
#endif

#if __has_include(<LYEmptyView/LYEmptyViewHeader.h>)
#import <LYEmptyView/LYEmptyViewHeader.h>
#else
#import "LYEmptyViewHeader.h"
#endif

#if __has_include(<YYImage/YYImage.h>)
#import <YYImage/YYImage.h>
#else
#import "YYImage.h"
#endif

#import "JobsDropDownListView.h"

typedef struct{
    NSInteger rowOrItem;
    NSInteger section;
}JobsIndexPath;

typedef NS_ENUM(NSInteger, CompareRes) {
    CompareRes_Error,
    CompareRes_MoreThan,// >
    CompareRes_Equal,// ==
    CompareRes_LessThan// <
};

typedef NS_ENUM(NSInteger, ScrollDirection) {
    ScrollDirectionNone = 0,
    ScrollDirectionRight,// ε³ππ»
    ScrollDirectionLeft,// ε·¦ππ»
    ScrollDirectionUp,// δΈι’ππ»
    ScrollDirectionDown,// δΈι’ππ»
    
    ScrollDirectionRight_UP,//ε³δΈππ»ππ»
    ScrollDirectionLeft_UP,//ε·¦δΈππ»ππ»
    ScrollDirectionRight_Down,//ε³δΈππ»ππ»
    ScrollDirectionLeft_Down,//ε·¦δΈππ»ππ»
};
/**
 @param weakSelf ζΉδΎΏδ½Ώη¨οΌη¨ζ₯ζη ΄εΎͺη―εΌη¨γδ½Ώη¨ζΆιθ¦ζΉζε?ιη±»εοΌε¦εζ²‘ζδ»£η ζη€Ί.
 @param arg δΊδ»Άι»θ?€δΌ ιηε―Ήθ±‘οΌζ―ε¦`NSNotification`οΌ`UIButton`γ
 */
typedef void (^callback)(id _Nullable weakSelf, id _Nullable arg);

@interface NSObject (Extras)
<
BaseProtocol
,UIViewModelProtocol
>

#pragma mark ββ ε?
/// App ε½ιεηΈε³η³»η»ε?δΊζ¬‘ε°θ£ + θ?Ύη½?ηΌΊηεΌ
+(NSString *_Nullable)localStringWithKey:(nonnull NSString *)key;
+(NSString *_Nullable)localizedString:(nonnull NSString *)key
                            fromTable:(nullable NSString *)tableName;
+(NSString *_Nullable)localizedString:(nonnull NSString *)key
                            fromTable:(nullable NSString *)tableName
                             inBundle:(nullable NSBundle *)bundle;
+(NSString *_Nullable)localizedString:(nonnull NSString *)key
                            fromTable:(nullable NSString *)tableName
                             inBundle:(nullable NSBundle *)bundle
                         defaultValue:(nullable NSString *)defaultValue;
#pragma mark ββ ViewController
-(UIViewController *_Nullable)getCurrentViewController;
-(UIViewController *_Nullable)getCurrentViewControllerFromRootVC:(UIViewController *_Nullable)rootVC;
/**
    γεΌΊεΆε±η°ι‘΅ι’γ
    1γζ¬η±»ε¦ζζ―ViewControllerεη¨ζ¬η±»ζ¨οΌ
    2γε¦εη¨εδΈιεη¨ζθΏηViewControllerζ₯ζ¨οΌ
    3γε¦ζζ³η¨AppDelegateηθͺε?δΉTabbarVCοΌ
        extern AppDelegate *appDelegate;
        (UIViewController *)appDelegate.tabBarVC;
 
    @param toPushVC ιθ¦θΏθ‘ε±η°ηι‘΅ι’
    @param requestParams ζ­£εζ¨ι‘΅ι’δΌ ιηεζ°
 */
-(void)forceComingToPushVC:(UIViewController *_Nonnull)toPushVC
             requestParams:(id _Nullable)requestParams;
#pragma mark ββ KVO
/**
 
 ε¨ selfιι’ε?η°δΈεζΉζ³οΌε?η°ηε¬
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
/// ζ·»ε ηε¬γιε―ΉUIScrollView η ContentOffset ε±ζ§γ
-(void)monitorContentOffsetScrollView:(UIScrollView *_Nonnull)scrollView;
#pragma mark ββ εθ½ζ§η
/// ηζ¬ε·ζ―θΎ
/// @param versionNumber1 ηζ¬ε·1
/// @param versionNumber2 ηζ¬ε·2
-(CompareRes)versionNumber1:(NSString *_Nonnull)versionNumber1
             versionNumber2:(NSString *_Nonnull)versionNumber2;
/// η»ε?δΈδΈͺζ°ζ?ζΊοΌζ°η»οΌε ζ―θ‘ιθ¦ε±η€Ίηεη΄ δΈͺζ°οΌθ?‘η?θ‘ζ°
/// @param elementNumberInEveryLine ζ―θ‘ιθ¦ε±η€Ίηεη΄ δΈͺζ°
/// @param arr ζ°ζ?ζΊοΌζ°η»οΌ
-(NSInteger)lineNum:(NSInteger)elementNumberInEveryLine
             byData:(NSArray *_Nonnull)arr;
/**
 β οΈ β οΈ β οΈ β οΈ β οΈ β οΈ β οΈ β οΈ β οΈ β οΈ β οΈ β οΈ β οΈ β οΈ β οΈ β οΈ β οΈ β οΈ β οΈ
 -(ScrollDirection)judgementScrollDirectionByPoint:(CGPoint)point;
                    ε
 -(CGFloat)scrollOffsetByDirectionXPoint:(CGPoint)pointοΌ
 -(CGFloat)scrollOffsetByDirectionYPoint:(CGPoint)point;
                   δΊζ₯
 * ε δΈΊ ε¨ε±ζ―η¨ε―δΈειlastPointθΏθ‘δΏε­εε€ε?
 * θδΈζ­ε°ζ»ε¨δΌδΈζ­ε°ε―ΉlastPointθΏδΈͺεΌθΏθ‘ε²ε·
 * θθΏδΈ€δΈͺζΉζ³ι½δΌδΎθ΅εδΈδΈͺlastPointοΌζδ»₯δΌεΊη°εε·?
 β οΈ β οΈ β οΈ β οΈ β οΈ β οΈ β οΈ β οΈ β οΈ β οΈ β οΈ β οΈ β οΈ β οΈ β οΈ β οΈ β οΈ β οΈ β οΈ
 */
/// X θ½΄ζΉεηεη§»ι
-(CGFloat)scrollOffsetByDirectionXPoint:(CGPoint)point;
/// Y θ½΄ζΉεηεη§»ι
-(CGFloat)scrollOffsetByDirectionYPoint:(CGPoint)point;
/// δΎζ?δΈζ­ε°δΌ ε₯ηCGPoint *pointοΌη³»η»ιθΏlastPointζ₯θ?°ε½δΈδΈζ¬‘ηζ°ζ?οΌδΈ€θθΏθ‘ζ―θΎοΌδ»₯ζ­€ε€ζ­ζ»ε¨ηζΉε
/// @param point ζζ°ηpoint
-(ScrollDirection)judgementScrollDirectionByPoint:(CGPoint)point;
/// εε»ΊIndexPathεζ 
-(NSIndexPath *_Nonnull)myIndexPath:(JobsIndexPath)indexPath;
/// ηΉε»δ»»ζδΈδΈͺviewοΌδΈζεΌΉεΊδΈζ­€Viewη­ε?½οΌδΈδΈδΈεΊζδΈδΈͺmotivateViewOffsetθ·η¦»ηεθ‘¨
/// @param motivateFromView ηΉε»ηιηΉView
/// @param data εθ‘¨ζ°ζ?ζΊ
/// @param motivateViewOffset δΈζεθ‘¨εmotivateFromViewδΏζδΈδΈͺmotivateViewOffsetηθ·η¦»
/// @param finishBlock ηΉε»εθ‘¨δ»₯εηεθ°ζ°ζ?ζ―UIViewModelη±»ε
-(JobsDropDownListView *_Nullable)motivateFromView:(UIView * _Nonnull)motivateFromView
                                              data:(NSMutableArray <UIViewModel *>* _Nullable)data
                                motivateViewOffset:(CGFloat)motivateViewOffset
                                       finishBlock:(MKDataBlock _Nullable)finishBlock;
/// iOS θ·εδ»»ζζ§δ»Άε¨ε±εΉδΈ­ηεζ 
+(CGRect)getWindowFrameByView:(UIView *_Nonnull)view;
/// δΎζ?ViewδΈιε?ηinternationalizationKEYζ₯ε¨ε±ζ΄ζΉζε­δ»₯ιιε½ιε
-(void)languageSwitch;
/// ζε°θ―·ζ±δ½
+(void)printRequestMessage:(NSURLSessionDataTask *_Nonnull)task;
/// ε€ζ­ζ―ε¦ζ―ζ­€ηζ¬Appηι¦ζ¬‘ε―ε¨
-(BOOL)isAppFirstLaunch;
/// ε€ζ­ζ―ε¦ζ―Appδ»ζ₯ηι¦ζ¬‘ε―ε¨
-(BOOL)isTodayAppFirstLaunch;
/// ιε¨ηΉζει¦
+(void)feedbackGenerator;
/// ζ£ζ΅η¨ζ·ζ―ε¦ιε±οΌζ Ήζ?ε±εΉεηΊΏζ₯θΏθ‘ε€ε?οΌθδΈζ―η³»η»ιη₯
+(BOOL)didUserPressLockButton;
/// iOS ιεΆθͺε¨ιε± lockSwitch:YES(ε³ι­θͺε¨ιε±)
+(void)autoLockedScreen:(BOOL)lockSwitch;

+(void)savePic:(GKPhotoBrowser *_Nonnull)browser;
/// ε°εΊζ¬ζ°ζ?η±»εοΌεη»δΈι»θ?€θ§δ½ζ΅?ηΉζ°οΌθ½¬εδΈΊεΎηθΏθ‘ζΎη€Ίγδ½Ώη¨εζοΌεΎηηεε­ε½δ»€δΈΊ0~9οΌζΉδΎΏθΏθ‘ζ ε°
/// @param inputData ιθ¦θΏθ‘θ½¬ζ’ζ ε°ηεΊζ¬ζ°ζ?η±»εζ°ζ?
/// @param bitNum ε¦ζζδ½ε―Ήθ±‘ζ―ζ΅?ηΉζ°οΌι£δΉε°ζ°ηΉειθ¦δΏηηδ½ζ°
-(nonnull NSMutableArray <UIImage *>*)translateToArr:(CGFloat)inputData
                                   saveBitAfterPoint:(NSInteger)bitNum;
/// θ―»εζ¬ε°ηplistζδ»Άε°εε­  γ plist ββ> NSDictionary * γ
/// @param fileName Plistζδ»Άε
-(nullable NSDictionary *)readLocalPlistWithFileName:(nullable NSString *)fileName;
/// ηε¬η¨εΊθ’«ζζ­»εηζΆε»οΌθΏθ‘δΈδΊιθ¦εΌζ­₯ηζδ½οΌη£ηθ―»εγη½η»θ―·ζ±...
-(void)terminalCheck:(MKDataBlock _Nullable)checkBlock;
/// Objectθ½¬ζ’δΈΊNSData
+(NSData *_Nullable)transformToData:(id _Nullable)object;
/// θ·εε½εθ?Ύε€ε―η¨εε­
+(double)availableMemory;
/// θ·εε½εδ»»ε‘ζε η¨εε­
+(double)usedMemory;
#pragma mark ββ ε°Ίε―Έ
/*
    εθθ΅ζοΌhttps://blog.csdn.net/www9500net_/article/details/52437987
 */
/// TableViewCell ηΈε―ΉδΊζ­€TableViewηframeγη¨indexPathγ
/// @param tableView ζ­€TableView
/// @param indexPath η¨indexPathε?δ½πTableViewCell
-(CGRect)tbvCellRectInTableView:(UITableView *_Nonnull)tableView
                    atIndexPath:(NSIndexPath *_Nonnull)indexPath;
/// TableViewCell ηΈε―ΉδΊζ­€TableViewηframeγη¨TableViewCellγβ€οΈ
-(CGRect)tableViewCell:(UITableViewCell *_Nonnull)tableViewCell
      frameInTableView:(UITableView *_Nonnull)tableView;
/// TableViewCell ηΈε―ΉδΊζΏζ₯ζ­€tableViewηηΆθ§εΎηframeγη¨indexPathγ
/// @param tableView ζ­€TableView
/// @param tbvSuperview ζΏζ₯θΏδΈͺTableViewηηΆε?Ήε¨View
/// @param indexPath η¨indexPathε?δ½πTableViewCell
-(CGRect)tableView:(UITableView *_Nonnull)tableView
      tbvSuperview:(UIView *_Nonnull)tbvSuperview
   cellAtIndexPath:(NSIndexPath *_Nonnull)indexPath;
/// TableViewCell ηΈε―ΉδΊζΏζ₯ζ­€tableViewηηΆθ§εΎηframeγη¨TableViewCellγβ€οΈ
-(CGRect)tableView:(UITableView *_Nonnull)tableView
      tbvSuperview:(UIView *_Nonnull)tbvSuperview
     tableViewCell:(UITableViewCell *_Nonnull)tableViewCell;
/// θ·εCollectionViewCellε¨ε½εcollectionηδ½η½?γη¨indexPathγ
/// @param collectionView ζ­€CollectionView
/// @param indexPath η¨indexPathε?δ½πCollectionViewCell
-(CGRect)frameInCollectionView:(UICollectionView *_Nonnull)collectionView
               cellAtIndexPath:(NSIndexPath *_Nonnull)indexPath;
/// θ·εCollectionViewCellε¨ε½εcollectionηδ½η½?γη¨collectionViewCellγβ€οΈ
-(CGRect)collectionViewCell:(UICollectionViewCell *_Nonnull)collectionViewCell
      frameInCollectionView:(UICollectionView *_Nonnull)collectionView;
/// θ·εCollectionViewCellε¨ε½εε±εΉηδ½η½?γη¨indexPathγ
/// @param cvSuperview ζΏζ₯θΏδΈͺCollectionViewηηΆε?Ήε¨View
/// @param collectionView  ζ­€CollectionView
/// @param indexPath η¨indexPathε?δ½πCollectionViewCell
-(CGRect)frameInCVSuperview:(UIView *_Nonnull)cvSuperview
             collectionView:(UICollectionView *_Nonnull)collectionView
            cellAtIndexPath:(NSIndexPath *_Nonnull)indexPath;
/// θ·εCollectionViewCellε¨ε½εε±εΉηδ½η½?γη¨collectionViewCellγβ€οΈ
-(CGRect)frameInCVSuperview:(UIView *_Nonnull)cvSuperview
             collectionView:(UICollectionView *_Nonnull)collectionView
         collectionViewCell:(UICollectionViewCell *_Nonnull)collectionViewCell;
#pragma mark ββ ζ°ε­
/// θ·εδ»»ζζ°ε­ζι«δ½ζ°ε­
-(NSInteger)getTopDigit:(NSInteger)number;
/// ε€ζ­δ»»ζη»ε?ηδΈδΈͺζ΄εζ―ε€ε°δ½ζ°
-(NSInteger)bitNum:(NSInteger)number;
/// ε€ζ­δ»»ζζ°ε­ζ―ε¦δΈΊε°ζ°
-(BOOL)isFloat:(CGFloat)num;
/**
    ε€ζ­ num1 ζ―ε¦θ½θ’« num2 ζ΄ι€
    δΉε°±ζ―ε€ζ­ num2 ζ―ε¦ζ― num1 ηζ΄ζ°ε
    δΉε°±ζ―ε€ζ­ num1 ι€δ»₯ num2 ηδ½ζ°ζ―ε¦ζ― 0
 
    ηΉε«ζεΊηζ―οΌ
    1γι€ζ°δΈΊιΆηζε΅οΌθ’«ε€ε?δΈΊδΈθ½θ’«ζ΄ι€οΌ
    2γnum1 ε num2 εΏι‘»δΈΊ NSNumber* η±»εοΌε¦εε€ε?δΈΊδΈθ½ε€θ’«ζ΄ι€
 
 */
-(BOOL)judgementExactDivisionByNum1:(NSNumber *_Nonnull)num1
                               num2:(NSNumber *_Nonnull)num2;
#pragma mark ββ ι?ηβ¨οΈ
/// ε ε₯ι?ηιη₯ηηε¬θ
-(void)keyboard;
/// ι?η εΌΉεΊ ε ζΆε θ΅°θΏδΈͺζΉζ³
-(void)keyboardWillChangeFrameNotification:(NSNotification *_Nullable)notification;

-(void)keyboardDidChangeFrameNotification:(NSNotification *_Nullable)notification;
#pragma mark ββ ε·ζ°
/// εζ­’ε·ζ°γε―θ½θΏζζ°ζ?ηζε΅οΌηΆζδΈΊοΌMJRefreshStateIdleγ
-(void)endRefreshing:(UIScrollView *_Nonnull)targetScrollView;
/// εζ­’ε·ζ°γζ²‘ζζ°ζ?ηζε΅οΌηΆζδΈΊοΌMJRefreshStateNoMoreDataγ
-(void)endRefreshingWithNoMoreData:(UIScrollView *_Nonnull)targetScrollView;
/// εζ­’MJHeaderηε·ζ°
-(void)endMJHeaderRefreshing:(UIScrollView *_Nonnull)targetScrollView;
/// εζ­’MJFooterηε·ζ°γζ²‘ζζ°ζ?ηζε΅οΌηΆζδΈΊοΌMJRefreshStateNoMoreDataγ
-(void)endMJFooterRefreshingWithNoMoreData:(UIScrollView *_Nonnull)targetScrollView;
/// εζ­’MJFooterε·ζ°γε―θ½θΏζζ°ζ?ηζε΅οΌηΆζδΈΊοΌMJRefreshStateIdleγ
-(void)endMJFooterRefreshingWithMoreData:(UIScrollView *_Nonnull)targetScrollView;
/// ζ Ήζ?ζ°ζ?ζΊγζ°η»γζ―ε¦ζεΌθΏθ‘ε€ε?οΌε δ½εΎ ε mj_footer ηζΎιζ§
-(void)dataSource:(NSArray *_Nonnull)dataSource
      contentView:(UIScrollView *_Nonnull)contentView;

@end
/**
 ιη₯ηεζ³οΌη€ΊδΎδ»£η 
 
 ζ₯ειη₯οΌ
         @jobs_weakify(self)
         [NSNotificationCenter.defaultCenter addObserver:self
                                                selector:selectorBlocks(^(id  _Nullable weakSelf,
                                                                          id  _Nullable arg) {
             NSNotification *notification = (NSNotification *)arg;
             NSNumber *b = notification.object;
             NSLog(@"SSS = %d",b.boolValue);
             @jobs_strongify(self)
             self.imageView.hidden = !b.boolValue;
             self.imageView.hidden = self.selectedIndex != 4;
             self.imageView.alpha = b.boolValue;
         }, self)
                                                    name:@"ηΉε»εΌζζη€Ί"
                                                  object:nil];
 
 ειη₯οΌ[NSNotificationCenter.defaultCenter postNotificationName:@"ηΉε»εΌζζη€Ί" object:@(NO)];
 
 */

/**
 NSInvocationηδ½Ώη¨οΌζΉζ³ε€εζ°δΌ ι η€ΊδΎδ»£η 
 
 -(void)touchesBegan:(NSSet<UITouch *> *)touches
           withEvent:(UIEvent *)event{
     
     NSString *arg1 = @"a";
     NSString *arg2 = @"b";
     NSString *arg3 = @"c";
     MKDataBlock arg4 = ^(id data){
         NSLog(@"ε―οΌδΈι");
     };
     
     NSArray *paramarrays = @[arg1,
                         arg2,
                         arg3,
                         arg4];
     
     [NSObject methodName:@"test:withArg2:andArg3:block:"
                   target:self
              paramarrays:paramarrays];
 }
 
 
 - (NSString *)test:(NSString *)arg1
           withArg2:(NSString *)arg2
            andArg3:(NSString *)arg3
              block:(MKDataBlock)block{
 
     NSLog(@"%@---%@---%@", arg1, arg2, arg3);
     if (block) {
         block(@"ε―οΌοΌ");
     }
     return @"gaga";
 }
 
 */
