//
//  JobsAppDoorInputViewBaseStyleModel.m
//  My_BaseProj
//
//  Created by Jobs on 2020/12/4.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "JobsAppDoorInputViewBaseStyleModel.h"

@interface JobsAppDoorInputViewBaseStyleModel ()

@end

@implementation JobsAppDoorInputViewBaseStyleModel

-(UIFont *)titleStrFont{
    if (!_titleStrFont) {
        _titleStrFont = [UIFont systemFontOfSize:JobsWidth(9)
                                          weight:UIFontWeightRegular];
    }return _titleStrFont;
}

-(UIColor *)titleStrCor{
    if (!_titleStrCor) {
        _titleStrCor = kWhiteColor;
    }return _titleStrCor;
}

-(UIFont *)placeholderFont{
    if (!_placeholderFont) {
        _placeholderFont = [UIFont systemFontOfSize:JobsWidth(14) weight:UIFontWeightRegular];
    }return _placeholderFont;
}

-(UIColor *)placeholderColor{
    if (!_placeholderColor) {
        _placeholderColor = HEXCOLOR(0x524740);
    }return _placeholderColor;
}

@end
