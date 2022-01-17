//
//  DataCollectionViewCell.h
//  JobsSearch
//
//  Created by Jobs on 2020/10/22.
//

#import "BaseCellProtocol.h"
#import "UIViewModelProtocol.h"
#import "BaseCollectionViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface JobsSearchDataCVCell : BaseCollectionViewCell
<
BaseCellProtocol
,UIViewModelProtocol
>

@end

NS_ASSUME_NONNULL_END
