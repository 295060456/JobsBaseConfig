//
//  BaseTableViewer.h
//  Feidegou
//
//  Created by Kite on 2019/10/31.
//  Copyright © 2019 朝花夕拾. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewProtocol.h"
#import "AABlock.h"

NS_ASSUME_NONNULL_BEGIN
/**
    1、子类如果重写-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event，
        则将会被优先执行，从而忽略UITableViewDelegate方法；
    2、监听reloadData的方法： 因为reloadData刷新UI是在主线程上，那么就在主线程上等待。直接在reloadData后获取主线程操作等待；
 */
@interface BaseTableView : UITableView<BaseViewProtocol>
/*
    用于以此为基类的BaseTableView具体子类上所有数据的回调,当然也可以用NSObject分类的方法定位于：@interface NSObject (CallBackInfoByBlock)
 */
-(void)actionBlockBaseTableView:(MKDataBlock _Nullable)baseTableViewBlock;

@end

NS_ASSUME_NONNULL_END
