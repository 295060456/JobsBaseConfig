//
//  DDWaterBillBaseModel.m
//  DouDong-II
//
//  Created by Jobs on 2021/3/12.
//

#import "DDWaterBillBaseModel.h"

@implementation DDWaterBillBaseListModel

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    /* 返回的字典，key为模型属性名，value为转化的字典的多级key */
    return @{
        @"ID" : @"id"
    };
}

@end

@implementation DDWaterBillBaseModel

+(NSDictionary *)mj_objectClassInArray{
    return @{
        @"list" : DDWaterBillBaseListModel.class
    };
}

-(DDWaterBillCustomReassemblyDataModel *)reassemblyData{
    NSMutableArray <NSString *>*tempSectionDataMutArr = NSMutableArray.array;//section 的头部：年/月
    NSMutableArray <NSMutableArray *>*tempSectionAndRowDataMutArr = NSMutableArray.array;//每个section的row，具体月数的数据列表
    
    NSMutableArray <DDWaterBillBaseListModel *>*tempModel = NSMutableArray.array;
    NSMutableArray <NSMutableArray <DDWaterBillBaseListModel *>*>*tempListModel = NSMutableArray.array;
    
    for (DDWaterBillBaseListModel *waterBillBaseListModel in self.list) {//轮询所有数据源
        // createTime = "2021-03-05 12:02:17";
        // waterBillBaseListModel.createTime;//全时间
        //NSString *ymd = [waterBillBaseListModel.createTime substringToIndex:10];//年月日
        NSString *ym = [waterBillBaseListModel.createTime substringToIndex:7];//字符串截取得出年月
        if (!tempSectionDataMutArr.count) {//第一个数据加进去，不需要判断
            [tempSectionDataMutArr addObject:ym];
            NSMutableArray <NSString *>*fullTimeMutArr = NSMutableArray.array;
            [fullTimeMutArr addObject:waterBillBaseListModel.createTime];
            [tempSectionAndRowDataMutArr addObject:fullTimeMutArr];
            
            [tempModel addObject:waterBillBaseListModel];
            [tempListModel addObject:tempModel];
        }else{//第二个数据开始就要判断了
            
            if ([tempSectionDataMutArr containsObject:ym]) {//存在就直接取，不需要额外创建
                NSInteger index = [tempSectionDataMutArr indexOfObject:ym];//得出已经有的数组的下标
                NSMutableArray <NSString *>*fullTimeMutArr = tempSectionAndRowDataMutArr[index];//同一个月份就取用
                NSMutableArray <DDWaterBillBaseListModel *>*tempModel = tempListModel[index];
                if (![fullTimeMutArr containsObject:waterBillBaseListModel.createTime]) {//相同时间忽略不计
                    [fullTimeMutArr addObject:waterBillBaseListModel.createTime];
                    [tempModel addObject:waterBillBaseListModel];
                }
            }else{
                [tempSectionDataMutArr addObject:ym];
                NSMutableArray <NSString *>*fullTimeMutArr = NSMutableArray.array;//不同月份就创建
                [fullTimeMutArr addObject:waterBillBaseListModel.createTime];
                [tempSectionAndRowDataMutArr addObject:fullTimeMutArr];
                
                NSMutableArray <DDWaterBillBaseListModel *>*tempModel = NSMutableArray.array;
                [tempModel addObject:waterBillBaseListModel];
                [tempListModel addObject:tempModel];
            }
        }
    }
    
    DDWaterBillCustomReassemblyDataModel *waterBillCustomReassemblyDataModel = DDWaterBillCustomReassemblyDataModel.new;
    waterBillCustomReassemblyDataModel.tempSectionAndRowDataMutArr = tempSectionAndRowDataMutArr;
    waterBillCustomReassemblyDataModel.tempSectionDataMutArr = tempSectionDataMutArr;
    waterBillCustomReassemblyDataModel.reassemblyDataMutArr = tempListModel;
    
    return waterBillCustomReassemblyDataModel;
}

@end

@implementation DDWaterBillCustomReassemblyDataModel

@end
