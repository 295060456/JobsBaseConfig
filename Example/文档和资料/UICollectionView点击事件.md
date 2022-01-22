#  UICollectionView点击事件

UICollectionView 似乎不能直接响应touchBegan
只能用手势

{
    _collectionView.userInteractionEnabled = YES;
    _collectionView.target = self;
    _collectionView.tapGRSEL = NSStringFromSelector(@selector(endEditing));
    _collectionView.numberOfTouchesRequired = 1;
    _collectionView.numberOfTapsRequired = 1;
    _collectionView.tapGR.enabled = YES;
}

-(void)endEditing{
    [self.view endEditing:YES];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
       shouldReceiveTouch:(UITouch *)touch{
    // 判断如果点击的View是UICollectionView就可以执行手势方法，否则不执行
    if ([touch.view isKindOfClass:UICollectionView.class]) {
        return YES;
    }return NO;
}

<UIGestureRecognizerDelegate>
