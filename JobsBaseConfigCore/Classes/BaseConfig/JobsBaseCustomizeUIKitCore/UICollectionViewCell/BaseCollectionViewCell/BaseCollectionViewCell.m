//
//  CollectionViewCell.m
//  UBallLive
//
//  Created by Jobs on 2020/10/18.
//

#import "BaseCollectionViewCell.h"

@interface BaseCollectionViewCell ()

@end

@implementation BaseCollectionViewCell

@synthesize indexPath = _indexPath;
@synthesize index = _index;

#pragma mark —— BaseCellProtocol
+(instancetype)cellWithCollectionView:(nonnull UICollectionView *)collectionView
                         forIndexPath:(nonnull NSIndexPath *)indexPath{
    BaseCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier(self.class)
                                                                             forIndexPath:indexPath];
    if (!cell) {
        [collectionView registerClass:self.class
           forCellWithReuseIdentifier:reuseIdentifier(self.class)];
        [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier(self.class)
                                                  forIndexPath:indexPath];
    }
    
    cell.indexPath = indexPath;
    return cell;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
//        [self richElementsInCellWithModel:nil];
    }return self;
}
/// 具体由子类进行复写【数据尺寸】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
+(CGSize)cellSizeWithModel:(id _Nullable)model{
    return CGSizeZero;
}
/// 具体由子类进行复写【数据定UI】【如果所传参数为基本数据类型，那么包装成对象NSNumber进行转化承接】
-(void)richElementsInCellWithModel:(id _Nullable)model{}
#pragma mark —— <UIViewModelProtocol> 协议属性合成set & get方法
-(void)setIndexPath:(NSIndexPath *)indexPath{
    _indexPath = indexPath;
}

-(NSIndexPath *)indexPath{
    return _indexPath;
}

-(NSInteger)index{
    return _index;
}

-(void)setIndex:(NSInteger)index{
    _index = index;
}

@end
