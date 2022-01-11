//
//  JobsLabBaseModel.h
//  Casino
//
//  Created by Jobs on 2021/12/16.
//

#import "UIViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface JobsLabBaseModel : UIViewModel

@property(nonatomic,assign)CGFloat rate;// UpLab 和 DownLab的上下占比,默认为0.5（上下均等分）
@property(nonatomic,assign)CGFloat space;// 间距
#pragma mark —— UpLab / LeftLab
@property(nonatomic,strong)UIColor *upLabTextCor;
@property(nonatomic,strong)UIColor *upLabBgCor;
@property(nonatomic,strong)UIFont *upLabFont;
@property(nonatomic,strong)NSString *upLabText;
@property(nonatomic,strong)UIImage *upLabImage;
@property(nonatomic,strong)UIImage *upLabBgImage;
@property(nonatomic,assign)NSTextAlignment upLabTextAlignment;
@property(nonatomic,assign)NSLineBreakMode upLabLineBreakMode;
@property(nonatomic,strong)NSAttributedString *upLabAttributedText;
@property(nonatomic,assign)BOOL isUpLabMultiLineShows;// 是否多行行显示【默认单行显示】
#pragma mark —— DownLab / RightLab
@property(nonatomic,strong)UIColor *downLabTextCor;
@property(nonatomic,strong)UIColor *downLabBgCor;
@property(nonatomic,strong)UIFont *downLabFont;
@property(nonatomic,strong)NSString *downLabText;
@property(nonatomic,strong)UIImage *downLabImage;
@property(nonatomic,strong)UIImage *downLabBgImage;
@property(nonatomic,assign)NSTextAlignment downLabTextAlignment;
@property(nonatomic,assign)NSLineBreakMode downLabLineBreakMode;
@property(nonatomic,strong)NSAttributedString *downLabAttributedText;
@property(nonatomic,assign)BOOL isDownLabMultiLineShows;// 是否多行行显示【默认单行显示】

@end

NS_ASSUME_NONNULL_END
