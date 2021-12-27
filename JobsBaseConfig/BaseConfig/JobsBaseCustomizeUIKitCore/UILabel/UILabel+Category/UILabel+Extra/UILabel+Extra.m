//
//  UILabel+Extra.m
//  Casino
//
//  Created by Jobs on 2021/12/27.
//

#import "UILabel+Extra.h"

@implementation UILabel (Extra)

-(void)lbBackgroundImage:(UIImage *)bgImage{
    self.backgroundColor = [UIColor colorWithPatternImage:bgImage];
}

@end
