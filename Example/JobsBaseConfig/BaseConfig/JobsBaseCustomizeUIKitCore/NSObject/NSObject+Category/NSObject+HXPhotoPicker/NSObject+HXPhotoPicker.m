//
//  NSObject+HXPhotoPicker.m
//  BaiShaEntertainmentProj
//
//  Created by Jobs on 2022/5/20.
//

#import "NSObject+HXPhotoPicker.h"

@implementation HXPhotoPickerModel

@end

@implementation NSObject (HXPhotoPicker)

/// 弹出系统相册选择页面
-(void)invokeSysPhotoAlbumSuccessBlock:(jobsByIDBlock _Nullable)successBlock
                             failBlock:(jobsByIDBlock _Nullable)failBlock{
    /// 请求相册权限
    @jobs_weakify(self)
    [ECPrivacyCheckGatherTool requestPhotosAuthorizationWithCompletionHandler:^(BOOL granted) {
        if (granted) {
            //    HXCustomNavigationController *nav = [[HXCustomNavigationController alloc] initWithManager:self.photoManager delegate:self];
            //    nav.modalPresentationStyle = UIModalPresentationOverFullScreen;
            //    nav.modalPresentationCapturesStatusBarAppearance = YES;
            //    [self comingToPresentVC:nav];
                
            if ([self isKindOfClass:UIViewController.class]) {
                UIViewController *viewController = (UIViewController *)self;
                [viewController hx_presentSelectPhotoControllerWithManager:self.photoManager
                                                                   didDone:^(NSArray<HXPhotoModel *> *allList,
                                                                             NSArray<HXPhotoModel *> *photoList,
                                                                             NSArray<HXPhotoModel *> *videoList,
                                                                             BOOL isOriginal,
                                                                             UIViewController *viewController,
                                                                             HXPhotoManager *manager) {
                    @jobs_strongify(self)
                    HXPhotoPickerModel *photoPickerModel = HXPhotoPickerModel.new;
                    photoPickerModel.allList = allList;
                    photoPickerModel.photoList = photoList;
                    photoPickerModel.videoList = videoList;
                    photoPickerModel.isOriginal = isOriginal;
                    photoPickerModel.vc = viewController;
                    photoPickerModel.photoManager = manager;
                    if (successBlock) successBlock(photoPickerModel);
                } cancel:^(UIViewController *viewController, HXPhotoManager *manager) {
                    HXPhotoPickerModel *photoPickerModel = HXPhotoPickerModel.new;
                    photoPickerModel.vc = viewController;
                    photoPickerModel.photoManager = manager;
                    if (failBlock) failBlock(photoPickerModel);
                }];
            }
        }else{
            [WHToast toastMsg:@"保存图片需要过去您的相册权限,请前往设置打开"];
        }
    }];
}
/// 调取系统相机进行拍摄
-(void)invokeSysCameraSuccessBlock:(jobsByIDBlock _Nullable)successBlock
                         failBlock:(jobsByIDBlock _Nullable)failBlock{
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        /// 请求相机📷权限
        @jobs_weakify(self)
        [ECPrivacyCheckGatherTool requestCameraAuthorizationWithCompletionHandler:^(BOOL granted) {
            if (granted) {
                
                if ([self isKindOfClass:UIViewController.class]) {
                    UIViewController *viewController = (UIViewController *)self;
                    [viewController hx_presentCustomCameraViewControllerWithManager:self.photoManager
                                                                               done:^(HXPhotoModel *model,
                                                                                      HXCustomCameraViewController *viewController) {
                        @jobs_strongify(self)
                        HXPhotoPickerModel *photoPickerModel = HXPhotoPickerModel.new;
                        photoPickerModel.customCameraVC = viewController;
                        photoPickerModel.photoModel = model;
                        if (successBlock) successBlock(photoPickerModel);
                    } cancel:^(HXCustomCameraViewController *viewController) {
                        NSSLog(@"取消了");
                        HXPhotoPickerModel *photoPickerModel = HXPhotoPickerModel.new;
                        photoPickerModel.customCameraVC = viewController;
                        if (failBlock) failBlock(photoPickerModel);
                    }];
                }
            }else{
                [WHToast toastMsg:Internationalization(@"授权失败,无法使用相机.请在设置-隐私-相机中允许访问相机")];
            }
        }];
    }else{
        [WHToast toastMsg:Internationalization(@"此设备不支持相机!")];
    }
}
static char *NSObject_HXPhotoPicker_photoManager = "NSObject_HXPhotoPicker_photoManager";
@dynamic photoManager;
#pragma mark —— @property(nonatomic,strong)HXPhotoManager *photoManager;//选取图片的数据管理类
-(HXPhotoManager *)photoManager{
    HXPhotoManager *PhotoManager = objc_getAssociatedObject(self, NSObject_HXPhotoPicker_photoManager);
    if (!PhotoManager) {
        PhotoManager = [HXPhotoManager.alloc initWithType:HXPhotoManagerSelectedTypePhotoAndVideo];
        PhotoManager.configuration.localFileName = [self.appDisplayName stringByAppendingString:@"Models"];
        PhotoManager.configuration.type = HXConfigurationTypeWXChat;
        PhotoManager.configuration.showOriginalBytes = YES;
        PhotoManager.configuration.showOriginalBytesLoading = YES;
        PhotoManager.configuration.videoMaximumSelectDuration = -1;
        PhotoManager.configuration.limitVideoSize = 100 * 1024 * 1024;
        PhotoManager.configuration.selectVideoLimitSize = YES;
        PhotoManager.configuration.selectVideoBeyondTheLimitTimeAutoEdit = NO;
        PhotoManager.configuration.specialModeNeedHideVideoSelectBtn = NO;
        PhotoManager.configuration.videoMaxNum = 1;
        PhotoManager.configuration.maxNum = 9;
        PhotoManager.configuration.photoMaxNum = 9;
        PhotoManager.configuration.selectTogether = NO;
        
        objc_setAssociatedObject(self,
                                 NSObject_HXPhotoPicker_photoManager,
                                 PhotoManager,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return PhotoManager;
}

-(void)setPhotoManager:(HXPhotoManager *)photoManager{
    objc_setAssociatedObject(self,
                             NSObject_HXPhotoPicker_photoManager,
                             photoManager,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
static char *NSObject_HXPhotoPicker_historyPhotoDataMutArr = "NSObject_HXPhotoPicker_historyPhotoDataMutArr";
@dynamic historyPhotoDataMutArr;
#pragma mark —— @property(nonatomic,strong)NSMutableArray <HXPhotoModel *>*__block historyPhotoDataMutArr;//与之相对应的是self.photoManager.afterSelectedArray
-(NSMutableArray<HXPhotoModel *> *)historyPhotoDataMutArr{
    NSMutableArray <HXPhotoModel *>*HistoryPhotoDataMutArr = objc_getAssociatedObject(self, NSObject_HXPhotoPicker_historyPhotoDataMutArr);
    if (!HistoryPhotoDataMutArr) {
        HistoryPhotoDataMutArr = NSMutableArray.array;
        objc_setAssociatedObject(self,
                                 NSObject_HXPhotoPicker_historyPhotoDataMutArr,
                                 HistoryPhotoDataMutArr,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return HistoryPhotoDataMutArr;
}

-(void)setHistoryPhotoDataMutArr:(NSMutableArray<HXPhotoModel *> *)historyPhotoDataMutArr{
    objc_setAssociatedObject(self,
                             NSObject_HXPhotoPicker_historyPhotoDataMutArr,
                             historyPhotoDataMutArr,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
static char *NSObject_HXPhotoPicker_photosDataMutArr = "NSObject_HXPhotoPicker_photosDataMutArr";
@dynamic photosDataMutArr;
#pragma mark —— @property(nonatomic,strong)NSMutableArray <HXPhotoModel *>*__block photosDataMutArr;
-(NSMutableArray<HXPhotoModel *> *)photosDataMutArr{
    NSMutableArray <HXPhotoModel *>*PhotosDataMutArr = objc_getAssociatedObject(self, NSObject_HXPhotoPicker_photosDataMutArr);
    if (!PhotosDataMutArr) {
        PhotosDataMutArr = NSMutableArray.array;
        objc_setAssociatedObject(self,
                                 NSObject_HXPhotoPicker_photosDataMutArr,
                                 PhotosDataMutArr,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return PhotosDataMutArr;
}

-(void)setPhotosDataMutArr:(NSMutableArray<HXPhotoModel *> *)photosDataMutArr{
    objc_setAssociatedObject(self,
                             NSObject_HXPhotoPicker_photosDataMutArr,
                             photosDataMutArr,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
static char *NSObject_HXPhotoPicker_videosDataMutArr = "NSObject_HXPhotoPicker_videosDataMutArr";
@dynamic videosDataMutArr;
#pragma mark —— @property(nonatomic,strong)NSMutableArray <HXPhotoModel *>*__block videosDataMutArr;
-(NSMutableArray<HXPhotoModel *> *)videosDataMutArr{
    NSMutableArray <HXPhotoModel *>*VideosDataMutArr = objc_getAssociatedObject(self, NSObject_HXPhotoPicker_videosDataMutArr);
    if (!VideosDataMutArr) {
        VideosDataMutArr = NSMutableArray.array;
        objc_setAssociatedObject(self,
                                 NSObject_HXPhotoPicker_videosDataMutArr,
                                 VideosDataMutArr,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }return VideosDataMutArr;
}

-(void)setVideosDataMutArr:(NSMutableArray<HXPhotoModel *> *)videosDataMutArr{
    objc_setAssociatedObject(self,
                             NSObject_HXPhotoPicker_videosDataMutArr,
                             videosDataMutArr,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
