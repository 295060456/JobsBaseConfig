//
//  JobsShootingVC.h
//  JobsBaseConfig
//
//  Created by Jobs Hi on 9/26/23.
//

#import "BaseViewController.h"
#import "DDPostDelView.h"
#import "DDTextView.h"

#if __has_include(<SZTextView/SZTextView.h>)
#import <SZTextView/SZTextView.h>
#else
#import "SZTextView.h"
#endif

#if __has_include(<HXPhotoPicker/HXPhotoPicker.h>)
#import <HXPhotoPicker/HXPhotoPicker.h>
#else
#import "HXPhotoPicker.h"
#endif

NS_ASSUME_NONNULL_BEGIN

@interface JobsShootingVC : BaseViewController
<
HXPhotoViewDelegate
,UITextViewDelegate
>
{
    CGFloat DDPostDelViewHeight;
}
// UI
@property(nonatomic,strong)HXPhotoView *postPhotoView;//展示选择的图片
@property(nonatomic,strong)HXPhotoManager *photoManager;//选取图片的数据管理类
@property(nonatomic,strong)DDPostDelView *postDelView;//长按拖动的删除区域
// Data
@property(nonatomic,strong)NSArray <HXPhotoModel *>*historyPhotoDataArr;//与之相对应的是self.photoManager.afterSelectedArray
@property(nonatomic,strong)NSArray <HXPhotoModel *>*__block photosDataArr;
@property(nonatomic,strong)NSArray <HXPhotoModel *>*__block videosDataArr;
@property(nonatomic,strong)NSString *__block inputDataString;
@property(nonatomic,strong)NSString *__block inputDataHistoryString;
@property(nonatomic,strong)NSData *__block videosData;
@property(nonatomic,strong)NSURL *__block videosUrl;
@property(nonatomic,strong)NSMutableArray <UIImage *>*photosImageMutArr;
@property(nonatomic,strong)NSString *__block pictures;
@property(nonatomic,strong)NSString *__block videos;
@property(nonatomic,strong)NSString *__block coverVideo;
@property(nonatomic,assign)BOOL needDeleteItem;

-(void)releaseBtnState:(NSArray *)photoDataArr
       inputDataString:(NSString *)inputDataString;

@end

NS_ASSUME_NONNULL_END

/**
 
 -(UIButton *)cameraBtn{
     if(!_cameraBtn){
         _cameraBtn = UIButton.new;
         _cameraBtn.normalTitle = Internationalization(@"调取系统相机");
         _cameraBtn.backgroundColor = UIColor.whiteColor;
         [self.view addSubview:_cameraBtn];
         [_cameraBtn mas_makeConstraints:^(MASConstraintMaker *make) {
             make.height.mas_equalTo(JobsWidth(50));
             make.left.equalTo(self.view).offset(JobsWidth(20));
             make.top.equalTo(self.gk_navigationBar.mas_bottom).offset(JobsWidth(100));
         }];
         [_cameraBtn makeBtnLabelByShowingType:UILabelShowingType_03];
         @jobs_weakify(self)
         [_cameraBtn jobsBtnClickEventBlock:^(id data) {
             /// 调取系统相机
             [self invokeSysCameraSuccessBlock:^(HXPhotoPickerModel *data) {
                 @jobs_strongify(self)
                 self.photoManager = data.photoManager;
                 
                 if (!self.historyPhotoDataArr.count) {
                     HXPhotoSubViewCell *cell = (HXPhotoSubViewCell *)[self.postPhotoView.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
                     if (cell) {
                         cell.imageView.image = JobsIMG(@"选择资源➕");
                     }
                 }
                 
             } failBlock:^(HXPhotoPickerModel *data) {
                 @jobs_strongify(self)
                 self.photoManager = data.photoManager;
             }];
         }];
     }return _cameraBtn;
 }

 -(UIButton *)photoAlbumBtn{
     if(!_photoAlbumBtn){
         _photoAlbumBtn = UIButton.new;
         _photoAlbumBtn.backgroundColor = UIColor.whiteColor;
         _photoAlbumBtn.normalTitle = Internationalization(@"调取系统相机");
         [self.view addSubview:_photoAlbumBtn];
         [_photoAlbumBtn mas_makeConstraints:^(MASConstraintMaker *make) {
             make.height.mas_equalTo(JobsWidth(50));
             make.right.equalTo(self.view).offset(JobsWidth(-20));
             make.top.equalTo(self.gk_navigationBar.mas_bottom).offset(JobsWidth(100));
         }];
         [_photoAlbumBtn makeBtnLabelByShowingType:UILabelShowingType_03];
         @jobs_weakify(self)
         [_photoAlbumBtn jobsBtnClickEventBlock:^(id data) {
             /// 调取系统相册
             [self invokeSysPhotoAlbumSuccessBlock:^(HXPhotoPickerModel *data) {
                 @jobs_strongify(self)
                 self.photoManager = data.photoManager;
             } failBlock:^(HXPhotoPickerModel *data) {
                 @jobs_strongify(self)
                 self.photoManager = data.photoManager;
             }];
         }];
     }return _photoAlbumBtn;
 }
 
 */
