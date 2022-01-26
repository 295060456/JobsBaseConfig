//
//  DDWaterBillBaseModel.h
//  DouDong-II
//
//  Created by Jobs on 2021/3/12.
//

#import "BaseModel.h"
@class DDWaterBillCustomReassemblyDataModel;

NS_ASSUME_NONNULL_BEGIN

@interface DDWaterBillBaseListModel : NSObject

@property(nonatomic,copy)NSString *amount;
@property(nonatomic,copy)NSString *ID;
@property(nonatomic,copy)NSString *createTime;
@property(nonatomic,copy)NSNumber *inOutType;
@property(nonatomic,copy)NSString *moneyType;

@end

@interface DDWaterBillBaseModel : BaseModel

@property(nonatomic,strong)NSArray <DDWaterBillBaseListModel *>*list;

-(DDWaterBillCustomReassemblyDataModel *)reassemblyData;

@end

@interface DDWaterBillCustomReassemblyDataModel : NSObject

@property(nonatomic,strong)NSMutableArray <NSString *>*tempSectionDataMutArr;//section的头数据
@property(nonatomic,strong)NSMutableArray <NSMutableArray *>*tempSectionAndRowDataMutArr;//具体的有多少行 每行多少列的数据源
@property(nonatomic,strong)NSMutableArray <DDWaterBillBaseListModel *>*list;
@property(nonatomic,strong)NSMutableArray <NSMutableArray <DDWaterBillBaseListModel *>*>*reassemblyDataMutArr;

@end

NS_ASSUME_NONNULL_END
//数据格式：
/*
 
 {
     endRow = "8";
     hasNextPage = 0;
     pages = 1;
     pageNum = 1;
     navigatepageNums = (
         1
     );
     isLastPage = 1;
     total = "8";
     nextPage = 0;
     navigatePages = 8;
     size = 8;
     hasPreviousPage = 0;
     navigateFirstPage = 1;
     startRow = "1";
     navigateLastPage = 1;
     prePage = 0;
     list = (
         {
             amount = "100.00";
             id = "1370300051760058370";
             createTime = "2021-03-12 17:06:06";
             inOutType = 0;
             moneyType = "5";
         },
         {
             amount = "100.00";
             id = "1367703729198505985";
             createTime = "2021-03-05 13:09:14";
             inOutType = 0;
             moneyType = "5";
         },
         {
             amount = "100.00";
             id = "1367703182382923777";
             createTime = "2021-03-05 13:07:04";
             inOutType = 0;
             moneyType = "5";
         },
         {
             amount = "100.00";
             id = "1367702966913138689";
             createTime = "2021-03-05 13:06:13";
             inOutType = 0;
             moneyType = "5";
         },
         {
             amount = "100.00";
             id = "1367686887339917314";
             createTime = "2021-03-05 12:02:17";
             inOutType = 0;
             moneyType = "5";
         },
         {
             amount = "100.00";
             id = "1367683276945981441";
             createTime = "2021-03-05 11:47:58";
             inOutType = 0;
             moneyType = "5";
         },
         {
             amount = "100.00";
             id = "1367680617543286785";
             createTime = "2021-03-05 11:37:24";
             inOutType = 0;
             moneyType = "5";
         },
         {
             amount = "100.00";
             id = "1366944841494929410";
             createTime = "2021-03-03 10:53:41";
             inOutType = 0;
             moneyType = "5";
         }
     );
     isFirstPage = 1;
     pageSize = 10;
 }
 
 
 */
