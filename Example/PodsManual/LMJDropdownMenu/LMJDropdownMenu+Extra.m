//
//  LMJDropdownMenu+Extra.m
//  Casino
//
//  Created by Jobs on 2022/1/11.
//

#import "LMJDropdownMenu+Extra.h"

@implementation LMJDropdownMenu (Extra)

-(UIButton *)great{
    UIButton *btn = [self object:self
                         getIvar:[self classGetInstanceVariableWithClass:LMJDropdownMenu.class
                                                    instanceVariableName:@"mainBtn"]];
    return btn;
}

-(void)greatAtEmpty{
    UIButton *btn = self.great;
    [btn normalImage:JobsIMG(@"空白图")];
    [btn layoutButtonWithEdgeInsetsStyle:GLButtonEdgeInsetsStyleRight
                         imageTitleSpace:JobsWidth(5)];
}

@end
