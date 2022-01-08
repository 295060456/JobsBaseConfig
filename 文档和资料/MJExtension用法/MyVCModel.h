//
//  MyVCModel.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/7/22.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface VideoListModel : BaseModel

@property(nonatomic,strong)NSNumber *avg_time;
@property(nonatomic,strong)NSNumber *comment_num;
@property(nonatomic,strong)NSNumber *create_time;
@property(nonatomic,strong)NSNumber *create_user;
@property(nonatomic,strong)NSNumber *ID;
@property(nonatomic,strong)NSNumber *is_del;
@property(nonatomic,strong)NSNumber *is_publish;
@property(nonatomic,strong)NSNumber *play_num;
@property(nonatomic,strong)NSNumber *praise_num;
@property(nonatomic,strong)NSNumber *update_time;
@property(nonatomic,strong)NSNumber *update_user;
@property(nonatomic,strong)NSNumber *upload_type;
@property(nonatomic,strong)NSNumber *user_id;
@property(nonatomic,strong)NSString *video_article;
@property(nonatomic,strong)NSString *video_idc_url;
@property(nonatomic,strong)NSString *video_img;
@property(nonatomic,strong)NSNumber *video_size;
@property(nonatomic,strong)NSNumber *video_sort;
@property(nonatomic,strong)NSNumber *video_status;
@property(nonatomic,strong)NSNumber *video_time;

@end

@interface MyVCModel : BaseModel

@property(nonatomic,strong)NSNumber *account;
@property(nonatomic,strong)NSString *age;
@property(nonatomic,strong)NSString *area;
@property(nonatomic,strong)NSNumber *balance;
@property(nonatomic,strong)NSString *birthday;
@property(nonatomic,strong)NSNumber *createTime;
@property(nonatomic,strong)NSNumber *Delete;
@property(nonatomic,strong)NSNumber *goldNumber;
@property(nonatomic,strong)NSString *headImage;
@property(nonatomic,strong)NSNumber *ID;
@property(nonatomic,strong)NSNumber *lastLoginTime;
@property(nonatomic,strong)NSString *nickname;
@property(nonatomic,strong)NSNumber *phone;
@property(nonatomic,strong)NSString *remark;
@property(nonatomic,strong)NSNumber *sex;
@property(nonatomic,strong)NSNumber *updateTime;
@property(nonatomic,strong)NSNumber *updateUser;
@property(nonatomic,strong)NSNumber *valid;
@property(nonatomic,strong)VideoListModel *videoListModel;
@property(nonatomic,strong)NSNumber *walletId;

@end

NS_ASSUME_NONNULL_END

//{
//    "avg_time" = 0;
//    "comment_num" = 0;
//    "create_time" = 1595303169000;
//    "create_user" = 20200703001;
//    id = 1285420778532208641;
//    "is_del" = 0;
//    "is_publish" = 1;
//    "play_num" = 0;
//    "praise_num" = 0;
//    "update_time" = 1595330660000;
//    "update_user" = 123;
//    "upload_type" = 1;
//    "user_id" = 20200703001;
//    "video_article" = "这一生关于你的风景";
//    "video_idc_url" = "/VIDEOS/2020072111/20200703001/mp4/1587898652868.gif.mp4";
//    "video_img" = "/VIDEOS/2020072111/20200703001/mp4/1587898652868.gif.jpeg";
//    "video_size" = 159503;
//    "video_sort" = 0;
//    "video_status" = 1;
//    "video_time" = 135;
//}

//{
//    account = 13812345678;
//    age = "25岁";
//    area = "上海";
//    balance = 1537;
//    birthday = "1995-07-14";
//    createTime = 1594956406000;
//    delete = 0;
//    goldNumber = 0;
//    headImage = "http://103.243.183.254:9000/bucket1-dev/IMAGES/app-user/headimg/n1@2x.png";
//    id = 20200703001;
//    lastLoginTime = 1595302640000;
//    nickname = "胡三刀";
//    phone = 13812345678;
//    remark = "";
//    sex = 2;
//    updateTime = 1594870270000;
//    updateUser = 123;
//    valid = 1;
//    videoList =     (
//                {
//            "avg_time" = 0;
//            "comment_num" = 0;
//            "create_time" = 1595303169000;
//            "create_user" = 20200703001;
//            id = 1285420778532208641;
//            "is_del" = 0;
//            "is_publish" = 1;
//            "play_num" = 0;
//            "praise_num" = 0;
//            "update_time" = 1595330660000;
//            "update_user" = 123;
//            "upload_type" = 1;
//            "user_id" = 20200703001;
//            "video_article" = "这一生关于你的风景";
//            "video_idc_url" = "/VIDEOS/2020072111/20200703001/mp4/1587898652868.gif.mp4";
//            "video_img" = "/VIDEOS/2020072111/20200703001/mp4/1587898652868.gif.jpeg";
//            "video_size" = 159503;
//            "video_sort" = 0;
//            "video_status" = 1;
//            "video_time" = 135;
//        },
//                {
//            "avg_time" = 0;
//            "comment_num" = 0;
//            "create_time" = 1595256037000;
//            "create_user" = 20200703001;
//            id = 1285223362641039362;
//            "is_del" = 0;
//            "is_publish" = 1;
//            "play_num" = 0;
//            "praise_num" = 0;
//            "update_time" = 1595256037000;
//            "update_user" = 20200703001;
//            "upload_type" = 1;
//            "user_id" = 20200703001;
//            "video_article" = sadasdsa;
//            "video_idc_url" = "/VIDEOS/2020072022/20200703001/mp4/喜欢骑乘啪啪_疯狂扭动都快操飞了_极品尤物一天操八遍都不够_12.mp4";
//            "video_img" = "/VIDEOS/2020072022/20200703001/mp4/喜欢骑乘啪啪_疯狂扭动都快操飞了_极品尤物一天操八遍都不够_12.jpeg";
//            "video_size" = 21892490;
//            "video_sort" = 0;
//            "video_status" = 0;
//            "video_time" = 181;
//        },
//                {
//            "avg_time" = 0;
//            "comment_num" = 0;
//            "create_time" = 1595248501000;
//            "create_user" = 20200703001;
//            id = 1285191501610020865;
//            "is_del" = 0;
//            "is_publish" = 1;
//            "play_num" = 0;
//            "praise_num" = 0;
//            "update_time" = 1595248501000;
//            "update_user" = 20200703001;
//            "upload_type" = 1;
//            "user_id" = 20200703001;
//            "video_article" = "";
//            "video_idc_url" = "/VIDEOS/2020072020/20200703001/mp4/IMG_0075.mp4";
//            "video_img" = "/VIDEOS/2020072020/20200703001/mp4/IMG_0075.jpeg";
//            "video_size" = 1420252;
//            "video_sort" = 0;
//            "video_status" = 0;
//            "video_time" = 10;
//        },
//                {
//            "avg_time" = 0;
//            "comment_num" = 0;
//            "create_time" = 1595246467000;
//            "create_user" = 20200703001;
//            id = 1285183526719803393;
//            "is_del" = 0;
//            "is_publish" = 1;
//            "play_num" = 0;
//            "praise_num" = 0;
//            "update_time" = 1595246467000;
//            "update_user" = 20200703001;
//            "upload_type" = 1;
//            "user_id" = 20200703001;
//            "video_article" = "";
//            "video_idc_url" = "/VIDEOS/2020072020/20200703001/flv/c31d0610a34880591ec22c95590c81a5.flv";
//            "video_img" = "/VIDEOS/2020072020/20200703001/flv/c31d0610a34880591ec22c95590c81a5.jpeg";
//            "video_size" = 7835172;
//            "video_sort" = 0;
//            "video_status" = 0;
//            "video_time" = 1;
//        },
//                {
//            "avg_time" = 0;
//            "comment_num" = 0;
//            "create_time" = 1595246347000;
//            "create_user" = 20200703001;
//            id = 1285182991782465537;
//            "is_del" = 0;
//            "is_publish" = 1;
//            "play_num" = 0;
//            "praise_num" = 0;
//            "update_time" = 1595246347000;
//            "update_user" = 20200703001;
//            "upload_type" = 1;
//            "user_id" = 20200703001;
//            "video_article" = "";
//            "video_idc_url" = "/VIDEOS/2020072019/20200703001/flv/c31d0610a34880591ec22c95590c81a5.flv";
//            "video_img" = "/VIDEOS/2020072019/20200703001/flv/c31d0610a34880591ec22c95590c81a5.jpeg";
//            "video_size" = 7835172;
//            "video_sort" = 0;
//            "video_status" = 0;
//            "video_time" = 1;
//        },
//                {
//            "avg_time" = 0;
//            "comment_num" = 0;
//            "create_time" = 1595246079000;
//            "create_user" = 20200703001;
//            id = 1285181531896238082;
//            "is_del" = 0;
//            "is_publish" = 1;
//            "play_num" = 0;
//            "praise_num" = 0;
//            "update_time" = 1595246079000;
//            "update_user" = 20200703001;
//            "upload_type" = 1;
//            "user_id" = 20200703001;
//            "video_article" = "";
//            "video_idc_url" = "/VIDEOS/2020072019/20200703001/flv/c31d0610a34880591ec22c95590c81a5.flv";
//            "video_img" = "/VIDEOS/2020072019/20200703001/flv/c31d0610a34880591ec22c95590c81a5.jpeg";
//            "video_size" = 7835172;
//            "video_sort" = 0;
//            "video_status" = 0;
//            "video_time" = 1;
//        },
//                {
//            "avg_time" = 0;
//            "comment_num" = 0;
//            "create_time" = 1595239363000;
//            "create_user" = 20200703001;
//            id = 1285153241412243458;
//            "is_del" = 0;
//            "is_publish" = 1;
//            "play_num" = 0;
//            "praise_num" = 0;
//            "update_time" = 1595239363000;
//            "update_user" = 20200703001;
//            "upload_type" = 1;
//            "user_id" = 20200703001;
//            "video_article" = "";
//            "video_idc_url" = "/VIDEOS/2020072018/20200703001/flv/c31d0610a34880591ec22c95590c81a5.flv";
//            "video_img" = "/VIDEOS/2020072018/20200703001/flv/c31d0610a34880591ec22c95590c81a5.jpeg";
//            "video_size" = 7835172;
//            "video_sort" = 0;
//            "video_status" = 0;
//            "video_time" = 0;
//        },
//                {
//            "avg_time" = 0;
//            "comment_num" = 0;
//            "create_time" = 1595239087000;
//            "create_user" = 20200703001;
//            id = 1285152086024097793;
//            "is_del" = 0;
//            "is_publish" = 1;
//            "play_num" = 0;
//            "praise_num" = 0;
//            "update_time" = 1595239087000;
//            "update_user" = 20200703001;
//            "upload_type" = 1;
//            "user_id" = 20200703001;
//            "video_article" = "";
//            "video_idc_url" = "/VIDEOS/2020072017/20200703001/flv/c31d0610a34880591ec22c95590c81a5.flv";
//            "video_img" = "/VIDEOS/2020072017/20200703001/flv/c31d0610a34880591ec22c95590c81a5.jpeg";
//            "video_size" = 7835172;
//            "video_sort" = 0;
//            "video_status" = 0;
//            "video_time" = 0;
//        },
//                {
//            "avg_time" = 0;
//            "comment_num" = 0;
//            "create_time" = 1595238817000;
//            "create_user" = 20200703001;
//            id = 1285150962340696066;
//            "is_del" = 0;
//            "is_publish" = 1;
//            "play_num" = 0;
//            "praise_num" = 0;
//            "update_time" = 1595238817000;
//            "update_user" = 20200703001;
//            "upload_type" = 1;
//            "user_id" = 20200703001;
//            "video_article" = "";
//            "video_idc_url" = "/VIDEOS/2020072017/20200703001/flv/c31d0610a34880591ec22c95590c81a5.flv";
//            "video_img" = "/VIDEOS/2020072017/20200703001/flv/c31d0610a34880591ec22c95590c81a5.jpeg";
//            "video_size" = 7835172;
//            "video_sort" = 0;
//            "video_status" = 0;
//            "video_time" = 0;
//        },
//                {
//            "avg_time" = 0;
//            "comment_num" = 0;
//            "create_time" = 1595238583000;
//            "create_user" = 20200703001;
//            id = 1285149979669794818;
//            "is_del" = 0;
//            "is_publish" = 1;
//            "play_num" = 0;
//            "praise_num" = 0;
//            "update_time" = 1595238583000;
//            "update_user" = 20200703001;
//            "upload_type" = 1;
//            "user_id" = 20200703001;
//            "video_article" = "";
//            "video_idc_url" = "/VIDEOS/2020072017/20200703001/flv/c31d0610a34880591ec22c95590c81a5.flv";
//            "video_img" = "/VIDEOS/2020072017/20200703001/flv/c31d0610a34880591ec22c95590c81a5.jpeg";
//            "video_size" = 7835172;
//            "video_sort" = 0;
//            "video_status" = 0;
//            "video_time" = 0;
//        }
//    );
//    walletId = 3;
//}
