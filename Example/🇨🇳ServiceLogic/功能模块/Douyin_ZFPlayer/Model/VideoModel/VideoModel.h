//
//  VideoModel.h
//  DouYin
//
//  Created by Jobs on 2020/9/24.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface VideoModel_Core : NSObject

@property(nonatomic,strong)NSString *isPraise;/// 是否点赞
@property(nonatomic,strong)NSString *authorId;/// 视频作者ID
@property(nonatomic,strong)NSString *videoSort;/// 视频分类
@property(nonatomic,strong)NSString *headImage;/// 作者头像
@property(nonatomic,strong)NSString *praiseNum;/// 点赞数
@property(nonatomic,strong)NSString *author;/// 作者花名
@property(nonatomic,strong)NSString *videoId;/// 视频ID
@property(nonatomic,strong)NSString *videoSize;/// 视频尺寸
@property(nonatomic,strong)NSString *isVip;/// 是否是VIP
@property(nonatomic,strong)NSString *commentNum;/// 评论数
@property(nonatomic,strong)NSString *isAttention;/// 是否关注
@property(nonatomic,strong)NSString *areSelf;/// 视频是否是本人发布
@property(nonatomic,strong)NSString *publishTime;/// 视频的发布时间
@property(nonatomic,strong)NSString *playNum;/// 视频的播放次数
@property(nonatomic,strong)NSString *videoTime;/// 视频持续时间
/// 以下是几个最主要的属性
@property(nonatomic,strong)NSString *videoTitle;/// 视频标题
@property(nonatomic,strong)NSString *videoImg;/// 图
@property(nonatomic,strong)NSString *videoIdcUrl;/// 视频地址

@end

@interface VideoModel : BaseModel

@property(nonatomic,strong)NSMutableArray <VideoModel_Core *>*listMutArr;

@end


NS_ASSUME_NONNULL_END

