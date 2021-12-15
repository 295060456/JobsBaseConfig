//
//  NSObject+Popup.h
//  Casino
//
//  Created by Jobs on 2021/12/15.
//

#import <Foundation/Foundation.h>
#import "JobsNoticePopupView.h"

#if __has_include(<TFPopup/TFPopup.h>)
#import <TFPopup/TFPopup.h>
#else
#import "TFPopup.h"
#endif

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Popup)
/// UI
@property(nonatomic,strong)JobsNoticePopupView *popupView;
/// Data
@property(nonatomic,strong)TFPopupParam *popupParam;

-(void)popupWithView:(UIView *_Nullable)view;

@end

NS_ASSUME_NONNULL_END
