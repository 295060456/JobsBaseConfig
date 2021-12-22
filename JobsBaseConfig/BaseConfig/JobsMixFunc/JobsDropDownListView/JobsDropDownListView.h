//
//  JobsDropDownListView.h
//  Casino
//
//  Created by Jobs on 2021/12/21.
//

#import "BaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface JobsDropDownListView : BaseView
<
UITableViewDelegate
,UITableViewDataSource
>

-(void)dropDownListViewDisappear;

@end

NS_ASSUME_NONNULL_END

/**
 【用法与用量】
 -(UIButton *)btn1{
     if (!_btn1) {
         _btn1 = UIButton.new;
         [_btn1 normalTitle:[@"2388 3788 8907 8890 8888" stringByAppendingString:@"  建设银行"]];
         [_btn1 normalTitleColor:HEXCOLOR(0x524740)];
         [_btn1 normalBackgroundImage:KIMG(@"全局输入框背景图")];
         [_btn1 titleFont:[UIFont systemFontOfSize:KWidth(14) weight:UIFontWeightRegular]];
         BtnClickEvent(_btn1, {
             NSLog(@"%@",self->dropDownListView);
             x.selected = !x.selected;
             if (x.selected) {
                 self->dropDownListView = [self motivateFromView:x
                                                            data:nil
                                              motivateViewOffset:KWidth(5)
                                                     finishBlock:^(UIViewModel *data) {
                     NSLog(@"data = %@",data);
                     [x normalTitle:data.text];
                 }];
             }else{
                 [self->dropDownListView dropDownListViewDisappear];
             }
         });
         [self.view addSubview:_btn1];
         [_btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
             make.size.mas_equalTo(CGSizeMake(KWidth(305), KWidth(36)));
             make.top.equalTo(self.titleLab3.mas_bottom).offset(KWidth(4));
             make.left.equalTo(self.titleLab1);
         }];
         [UIView cornerCutToCircleWithView:_btn1 andCornerRadius:KWidth(3)];
     }return _btn1;
 }
 
 */
