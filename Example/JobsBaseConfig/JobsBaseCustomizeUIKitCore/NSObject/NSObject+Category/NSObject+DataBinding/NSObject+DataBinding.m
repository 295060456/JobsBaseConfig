//
//  NSObject+DataBinding.m
//  DouDong-II
//
//  Created by Jobs on 2021/4/22.
//

#import "NSObject+DataBinding.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wprotocol"

@implementation NSObject (DataBinding)

-(void)dataLinkByTableView:(UITableView *)tableView{
    tableView.delegate = self;
    tableView.dataSource = self;
}

-(void)dataLinkByCollectionView:(UICollectionView *)collectionView{
    collectionView.delegate = self;
    collectionView.dataSource = self;
}
#pragma mark —— @property(nonatomic,strong)id objBindingParams;
JobsKey(_objBindingParams)
@dynamic objBindingParams;
-(id)objBindingParams{
    return Jobs_getAssociatedObject(_objBindingParams);
}

-(void)setObjBindingParams:(id)objBindingParams{
    Jobs_setAssociatedRETAIN_NONATOMIC(_objBindingParams, objBindingParams)
}

@end

#pragma clang diagnostic pop
