//
//  UIButton+ImageTitleSpacing.m
//  Intelligent_Fire
//
//  Created by 高磊 on 2016/12/19.
//  Copyright © 2016年 高磊. All rights reserved.
//

#import "UIButton+ImageTitleSpacing.h"

@implementation UIButton (ImageTitleSpacing)

-(CGFloat)layoutButtonWithEdgeInsetsStyle:(GLButtonEdgeInsetsStyle)style
                          imageTitleSpace:(CGFloat)imageTitleSpace{

    if (HDDeviceSystemVersion.floatValue >= 15.0) {
#warning UIButtonConfiguration 怎么适配使用？
    }
//    SuppressWdeprecatedDeclarationsWarning(
                                           /**
                                            *  知识点：titleEdgeInsets是title相对于其上下左右的inset，跟tableView的contentInset是类似的，
                                            *  如果只有title，那它上下左右都是相对于button的，image也是一样；
                                            *  如果同时有image和label，那这时候image的上左下是相对于button，右边是相对于label的；title的上右下是相对于button，左边是相对于image的。
                                            */
                                               
                                           // 1、 得到imageView和titleLabel的宽、高
                                           CGFloat imageWith = self.imageView.image.size.width;
                                           CGFloat imageHeight = self.imageView.image.size.height;
                                           
                                           CGFloat labelWidth = 0.0;
                                           CGFloat labelHeight = 0.0;
                                           
                                           /// 由于iOS8中titleLabel的size为0
                                           labelWidth = HDDeviceSystemVersion.floatValue >= 8.0 ? self.titleLabel.intrinsicContentSize.width : self.titleLabel.width;
                                           labelHeight = HDDeviceSystemVersion.floatValue >= 8.0 ? self.titleLabel.intrinsicContentSize.height : self.titleLabel.height;
             
                                           // 2、 声明全局的imageEdgeInsets和labelEdgeInsets
                                           UIEdgeInsets imageEdgeInsets = self.imageEdgeInsets;
                                           UIEdgeInsets labelEdgeInsets = self.titleEdgeInsets;
                                           // 3.、根据style和space得到imageEdgeInsets和labelEdgeInsets的值
                                           switch (style) {
                                               /// image在左，label在右 【系统默认状态】
                                               case GLButtonEdgeInsetsStyleLeft:{
                                                   labelEdgeInsets.left += imageTitleSpace;
                                                   
                                               }break;
                                               /// image在右，label在左
                                               case GLButtonEdgeInsetsStyleRight:{
                                                   imageEdgeInsets = UIEdgeInsetsMake(0,
                                                                                      labelWidth ,
                                                                                      0,
                                                                                      imageTitleSpace / 2.0);
                                                   labelEdgeInsets = UIEdgeInsetsMake(0,
                                                                                      -imageWith+imageTitleSpace / 2.0,
                                                                                      0,
                                                                                      imageWith + imageTitleSpace / 2.0);
                                               }break;
                                               /// image在上，label在下
                                               case GLButtonEdgeInsetsStyleTop:{
//                                                   imageEdgeInsets = UIEdgeInsetsMake(0,
//                                                                                      (imageTitleSpace + labelWidth) / 2.0,
//                                                                                      labelHeight + imageTitleSpace,
//                                                                                      0);
//                                                   labelEdgeInsets = UIEdgeInsetsMake(labelHeight + imageTitleSpace,
//                                                                                      -imageWith-imageTitleSpace,
//                                                                                      0,
//                                                                                      -imageTitleSpace);
                                                   imageEdgeInsets = UIEdgeInsetsMake(-labelHeight-imageTitleSpace / 2.0,
                                                                                      0,
                                                                                      0,
                                                                                      -labelWidth);
                                                   labelEdgeInsets = UIEdgeInsetsMake(0,
                                                                                      -imageWith,
                                                                                      -imageHeight-imageTitleSpace / 2.0,
                                                                                      0);
                                               }break;
                                               /// image在下，label在上
                                               case GLButtonEdgeInsetsStyleBottom:{
//                                                   labelEdgeInsets = UIEdgeInsetsMake(0,
//                                                                                      -imageWith-imageTitleSpace,
//                                                                                      imageHeight + imageTitleSpace,
//                                                                                      -imageTitleSpace);
//                                                   imageEdgeInsets = UIEdgeInsetsMake(labelHeight + imageTitleSpace,
//                                                                                      (imageTitleSpace + labelWidth) / 2.0,
//                                                                                      0,
//                                                                                      0);
                                                   imageEdgeInsets = UIEdgeInsetsMake(0,
                                                                                      0,
                                                                                      -labelHeight-imageTitleSpace / 2.0,
                                                                                      -labelWidth);
                                                   labelEdgeInsets = UIEdgeInsetsMake(-imageHeight-imageTitleSpace / 2.0,
                                                                                      -imageWith,
                                                                                      0,
                                                                                      0);
                                               }break;

                                               default:
                                                   break;
                                           }
                                           // 4、 赋值
                                           self.titleEdgeInsets = labelEdgeInsets;
                                           self.imageEdgeInsets = imageEdgeInsets;
                                           
//                                           self.titleLabel.backgroundColor = JobsRedColor;
//                                           self.imageView.backgroundColor = JobsBlueColor;
                                           
                                           switch (style) {
                                               /// image在上，label在下
                                               case GLButtonEdgeInsetsStyleTop:{
                                                   return self.titleLabel.top - self.imageView.bottom;
                                               }break;
                                               /// image在左，label在右
                                               case GLButtonEdgeInsetsStyleLeft:{
                                                   return self.titleLabel.x - self.imageView.right;
                                               }break;
                                               /// image在下，label在上
                                               case GLButtonEdgeInsetsStyleBottom:{
                                                   return self.imageView.top - self.titleLabel.bottom;
                                               }break;
                                               /// image在右，label在左
                                               case GLButtonEdgeInsetsStyleRight:{
                                                   return self.imageView.left - self.titleLabel.right;
                                               }break;
                                               default:
                                                   return 0;
                                                   break;
                                           }
//    );
}

@end
