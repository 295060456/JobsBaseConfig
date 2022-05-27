//
//  UITextModel.m
//  JobsBaseConfig
//
//  Created by Jobs on 2022/1/17.
//

#import "UITextModel.h"

@implementation UITextModel

UITextModelProtocol_synthesize
UILocationProtocol_synthesize

-(UIColor *)textCor{
    if (!_textCor) {
        _textCor = RGB_SAMECOLOR(51);
    }return _textCor;
}

-(UIFont *)font{
    if (!_font) {
        _font = [UIFont systemFontOfSize:JobsWidth(12) weight:UIFontWeightRegular];
    }return _font;
}

-(NSString *)text{
    if (!_text) {
#ifdef DEBUG
        _text = Internationalization(TextModelDataString);
#endif
    }return _text;
}

@end
