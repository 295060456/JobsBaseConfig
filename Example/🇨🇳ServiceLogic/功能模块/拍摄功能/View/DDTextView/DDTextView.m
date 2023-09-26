//
//  DDTextView.m
//  DouDong-II
//
//  Created by alan comb on 2021/4/3.
//

#import "DDTextView.h"
#import "UITextView+Extend.h"

@interface DDTextView()

@property(nonatomic,strong)SZTextView* textView;
@property(nonatomic,strong)UILabel* countLabel;
@property(nonatomic,assign)NSInteger curWordCount;

@end

@implementation DDTextView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.curWordCount = 0;
        self.maxWordCount = 500;
        self.countLabel.alpha = 1;
        self.textView.alpha = 1;
        self.lineSpacing = 4;
    }return self;
}

- (void)setCurWordCount:(NSInteger)curWordCount{
    _curWordCount = curWordCount;
    [self updateWordCount];
}

- (void)setMaxWordCount:(NSInteger)maxWordCount{
    _maxWordCount = maxWordCount;
    [self updateWordCount];
}

- (void)setText:(NSString *)text{
    self.textView.text = text;
}

- (NSString *)text{
    return self.textView.text;
}

-(void)markedTextValue:(jobsByIDBlock)valueBlock
          invalidBlock:(jobsByVoidBlock)invalidBlock{
    [self.textView markedTextValue:valueBlock invalidBlock:invalidBlock];
}

- (void)updateWordCount{
    NSString* wordStr = [NSString stringWithFormat:@"%ld/%ld", self.curWordCount, self.maxWordCount];
    self.countLabel.text = wordStr;
    [self.countLabel sizeToFit];
}

- (void)setPlaceholder:(NSString *)placeholder{
    self.textView.placeholder = placeholder;
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor{
    self.textView.placeholderTextColor = placeholderColor;
}

- (void)setFont:(UIFont *)font{
    self.textView.font = font;
}

- (void)setLineSpacing:(CGFloat)lineSpacing{
    _lineSpacing = lineSpacing;
}
#pragma mark —— lazyLoad
- (SZTextView *)textView{
    if (!_textView) {
        _textView = SZTextView.new;
        [self addSubview:_textView];
        [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.left.equalTo(self).offset(JobsWidth(10));
            make.right.equalTo(self).offset(JobsWidth(-10));
            make.bottom.equalTo(self.countLabel.mas_top);
        }];
        @weakify(self)
        [_textView.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
            @strongify(self);
            //中文高亮不处理
            UITextRange *selectedRange = [self.textView markedTextRange];
            NSString *lang = [[UIApplication sharedApplication]textInputMode].primaryLanguage;
            if ([lang isEqualToString:@"zh-Hans"]) { //中文输入
                UITextPosition *position = [self.textView positionFromPosition:selectedRange.start offset:0];
                if (position) return;
            }
            //超过直接截取
            NSString *text = self.textView.text;
            if(text.length > self.maxWordCount) {
                self.textView.text = [text substringToIndex:self.maxWordCount];
                [WHToast toastMsg:[NSString stringWithFormat:Internationalization(@"最多只能输入%ld个字"), self.maxWordCount]];
            }
            self.curWordCount = self.textView.text.length;
            if (self.objectBlock) self.objectBlock(self.textView.text);
            
            if (self.textView.text.length == 0) return;
            NSMutableParagraphStyle *paragraphStyle = NSMutableParagraphStyle.new;
            paragraphStyle.lineSpacing = self.lineSpacing;// 字体的行间距
            NSDictionary *attributes = @{
                NSFontAttributeName : self.textView.font,
                NSParagraphStyleAttributeName:paragraphStyle
            };
            NSMutableAttributedString* attString = [NSMutableAttributedString.alloc initWithString:self.textView.text];
            [attString addAttributes:attributes range:NSMakeRange(0,attString.length)];
            self.textView.attributedText = attString;
        }];
    }return _textView;
}

- (UILabel *)countLabel{
    if (!_countLabel) {
        _countLabel = UILabel.new;
        _countLabel.textColor = AppMainCor_04;
        _countLabel.textAlignment = NSTextAlignmentCenter;
        _countLabel.font = UIFontWeightBoldSize(12);
        [self addSubview:_countLabel];
        [_countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(JobsWidth(17));
            make.bottom.mas_equalTo(-JobsWidth(8));
            make.right.equalTo(self).offset(-JobsWidth(5));
        }];
    }return _countLabel;
}

@end
