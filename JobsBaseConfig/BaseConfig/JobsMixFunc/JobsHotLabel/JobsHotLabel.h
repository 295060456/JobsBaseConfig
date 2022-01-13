//
//  HotLabel.h
//  JobsSearch
//
//  Created by Jobs on 2020/10/4.
//

#import <UIKit/UIKit.h>
#import "UIViewModelProtocol.h"
#import "BaseView.h"
#import "UIViewModel.h"
#import "CasinoCustomerContactModel.h"

NS_ASSUME_NONNULL_BEGIN
/**
    1、单排显示固定样式UI（UIButton 方便图文展示）：
        1.1、如果不满一行居中显示；
        1.2、如果超过一行滑动显示；
    2、如果要显示多排固定样式UI，请移步用CollectionView实现
 */
@interface JobsHotLabel : BaseView

@end

NS_ASSUME_NONNULL_END

/**
 uses
 
 // Data
 @property(nonatomic,strong)JobsHotLabel *hl;
 @property(nonatomic,strong)NSMutableArray <UIViewModel *>*hotLabelDataMutArr;
 
 -(JobsHotLabel *)hl{
     if (!_hl) {
         _hl = JobsHotLabel.new;
         _hl.backgroundColor = kClearColor;
         _hl.viewModelDataArr = self.hotLabelDataMutArr;
         [self addSubview:_hl];
         [_hl mas_makeConstraints:^(MASConstraintMaker *make) {
             make.centerX.equalTo(self.subTitleLab);
             make.top.equalTo(self.subTitleLab.mas_bottom).offset(JobsWidth(29));
             make.bottom.equalTo(self).offset(-JobsWidth(10));
             make.width.mas_equalTo(250);
         }];
         
         [self layoutIfNeeded];
         NSLog(@"");
         
     }return _hl;
 }

 -(NSMutableArray<UIViewModel *> *)hotLabelDataMutArr{
     if (!_hotLabelDataMutArr) {
         _hotLabelDataMutArr = NSMutableArray.array;
         
         {
             UIViewModel *vm = UIViewModel.new;
             vm.bgImage = KIMG(@"service_skype");
             vm.text = @"";
             vm.size = CGSizeMake(JobsWidth(46), JobsWidth(46));
             vm.offsetXForEach = JobsWidth(46);
             vm.offsetYForEach = JobsWidth(46);
             [_hotLabelDataMutArr addObject:vm];
         }
         
         {
             UIViewModel *vm = UIViewModel.new;
             vm.bgImage = KIMG(@"service_qq");
             vm.text = @"";
             vm.size = CGSizeMake(JobsWidth(46), JobsWidth(46));
             vm.offsetXForEach = JobsWidth(46);
             vm.offsetYForEach = JobsWidth(46);
             [_hotLabelDataMutArr addObject:vm];
         }
         
         {
             UIViewModel *vm = UIViewModel.new;
             vm.bgImage = KIMG(@"service_telegram");
             vm.text = @"";
             vm.size = CGSizeMake(JobsWidth(46), JobsWidth(46));
             vm.offsetXForEach = JobsWidth(46);
             vm.offsetYForEach = JobsWidth(46);
             [_hotLabelDataMutArr addObject:vm];
         }
         
         {
             UIViewModel *vm = UIViewModel.new;
             vm.bgImage = KIMG(@"service_wechat");
             vm.text = @"";
             vm.size = CGSizeMake(JobsWidth(46), JobsWidth(46));
             vm.offsetXForEach = JobsWidth(46);
             vm.offsetYForEach = JobsWidth(46);
             [_hotLabelDataMutArr addObject:vm];
         }
         
         {
             UIViewModel *vm = UIViewModel.new;
             vm.bgImage = KIMG(@"login_skype");
             vm.text = @"";
             vm.size = CGSizeMake(JobsWidth(46), JobsWidth(46));
             vm.offsetXForEach = JobsWidth(46);
             vm.offsetYForEach = JobsWidth(46);
             [_hotLabelDataMutArr addObject:vm];
         }
         
         {
             UIViewModel *vm = UIViewModel.new;
             vm.bgImage = KIMG(@"service_meiqia");
             vm.text = @"";
             vm.size = CGSizeMake(JobsWidth(46), JobsWidth(46));
             vm.offsetXForEach = JobsWidth(46);
             vm.offsetYForEach = JobsWidth(46);
             [_hotLabelDataMutArr addObject:vm];
         }
         
     }return _hotLabelDataMutArr;
 }
 
 
 */
