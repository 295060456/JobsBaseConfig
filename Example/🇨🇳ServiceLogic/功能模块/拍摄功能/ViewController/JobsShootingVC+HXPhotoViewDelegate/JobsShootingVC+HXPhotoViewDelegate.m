//
//  JobsShootingVC+HXPhotoViewDelegate.m
//  DouDong-II
//
//  Created by Jobs on 2021/3/29.
//

#import "JobsShootingVC+HXPhotoViewDelegate.h"

@implementation JobsShootingVC (HXPhotoViewDelegate)
#pragma mark —— HXPhotoViewDelegate
// 在这里获取到点选的资料
- (void)photoView:(HXPhotoView *)photoView
   changeComplete:(NSArray<HXPhotoModel *> *)allList//self.photoManager.afterSelectedArray
           photos:(NSArray<HXPhotoModel *> *)photos
           videos:(NSArray<HXPhotoModel *> *)videos
         original:(BOOL)isOriginal{
    
    self.photosDataArr = photos;
    self.videosDataArr = videos;
    @weakify(self)
    if (self.videosDataArr.count) {
        [FileFolderHandleTool getVideoFromPHAsset:self.videosDataArr.lastObject.asset
                                         complete:^(FileFolderHandleModel *data) {
            @strongify(self)
            self.videosData = data.data;
        }];
    }else if(self.photosDataArr.count){
        
        if (self.photosImageMutArr.count) {
            [self.photosImageMutArr removeAllObjects];
        }
        
        [self.photosDataArr hx_requestImageWithOriginal:NO
                                             completion:^(NSArray<UIImage *> * _Nullable imageArray,
                                                          NSArray<HXPhotoModel *> * _Nullable errorArray) {
            @strongify(self)
            self.photosImageMutArr = [NSMutableArray arrayWithArray:imageArray];
        }];

    }else{}
    [self releaseBtnState:allList
          inputDataString:self.inputDataString];
}

- (void)photoView:(HXPhotoView *)photoView
      updateFrame:(CGRect)frame {
    @weakify(self)
    [UIView animateWithDuration:0.25
                     animations:^{
        @strongify(self)
        self.postDelView.y = JobsMainScreen_HEIGHT() - self->DDPostDelViewHeight;
    }];
}

- (void)photoView:(HXPhotoView *)photoView
currentDeleteModel:(HXPhotoModel *)model
     currentIndex:(NSInteger)index {
    // 删除的时候需要将草稿删除
    if (self.photoManager.localModels) {
        NSMutableArray *localModels = self.photoManager.localModels.mutableCopy;
        if ([self.photoManager.localModels containsObject:model]) {
            [localModels removeObject:model];
        }
        self.photoManager.localModels = localModels.copy;
    }
}

- (BOOL)photoViewShouldDeleteCurrentMoveItem:(HXPhotoView *)photoView
                           gestureRecognizer:(UILongPressGestureRecognizer *)longPgr
                                   indexPath:(NSIndexPath *)indexPath {
    return self.needDeleteItem;
}

- (void)photoView:(HXPhotoView *)photoView
gestureRecognizerBegan:(UILongPressGestureRecognizer *)longPgr
        indexPath:(NSIndexPath *)indexPath{
    @weakify(self)
    [UIView animateWithDuration:0.25
                     animations:^{
        @strongify(self)
        self.postDelView.y = JobsMainScreen_HEIGHT() - self->DDPostDelViewHeight;
    }];
}

- (void)photoView:(HXPhotoView *)photoView
gestureRecognizerChange:(UILongPressGestureRecognizer *)longPgr
        indexPath:(NSIndexPath *)indexPath {
    CGPoint point = [longPgr locationInView:self.view];
    [self.postDelView richElementsInViewWithModel:@(point.y >= self.postDelView.hx_y)];
}

- (void)photoView:(HXPhotoView *)photoView
gestureRecognizerEnded:(UILongPressGestureRecognizer *)longPgr
        indexPath:(NSIndexPath *)indexPath {
    CGPoint point = [longPgr locationInView:self.view];
    if (point.y >= self.postDelView.y) {
        self.needDeleteItem = YES;
        [self.postPhotoView deleteModelWithIndex:indexPath.item];
    }else {
        self.needDeleteItem = NO;
    }
    @jobs_weakify(self)
    [UIView animateWithDuration:0.25
                     animations:^{
        @jobs_strongify(self)
        self.postDelView.y = JobsMainScreen_HEIGHT();
    } completion:^(BOOL finished) {
        @jobs_strongify(self)
        [self.postDelView richElementsInViewWithModel:@(NO)];
    }];
}

@end
