//
//  UITextModelProtocol.h
//  JobsBaseConfig
//
//  Created by Jobs on 2022/1/17.
//

#import <Foundation/Foundation.h>

@class RichTextConfig;

NS_ASSUME_NONNULL_BEGIN

@protocol UITextModelProtocol <NSObject>

@optional
/// Common
@property(nonatomic,assign)NSTextAlignment __block textAlignment;/// 主文字对齐方式
@property(nonatomic,assign)NSLineBreakMode __block lineBreakMode;/// 主文字提行方式
@property(nonatomic,assign)CGFloat __block textLineSpacing;
@property(nonatomic,strong,nullable)UIFont __block *font;/// 主文字字体
/// Normal
@property(nonatomic,strong,nullable)NSString __block *text;
@property(nonatomic,strong,nullable)UIColor __block *textCor;/// 主字体颜色
@property(nonatomic,strong,nullable)NSAttributedString __block *attributedText API_AVAILABLE(ios(6.0));
@property(nonatomic,strong)NSMutableArray <RichTextConfig *>*titleAttributedDataMutArr;/// 对于富文本优先级：titleAttributedDataMutArr > titleAttributedStr
/// Selected
@property(nonatomic,strong,nullable)NSString __block *selectedText;
@property(nonatomic,strong,nullable)UIColor __block *selectedTextCor;/// 主字体颜色
@property(nonatomic,strong,nullable)NSAttributedString __block *selectedAttributedText API_AVAILABLE(ios(6.0));
@property(nonatomic,strong)NSMutableArray <RichTextConfig *>*selectedTitleAttributedDataMutArr;/// 对于富文本优先级：titleAttributedDataMutArr > selectedAttributedText

@end

NS_ASSUME_NONNULL_END

#pragma mark —— @synthesize UITextModelProtocol
#ifndef UITextModelProtocol_synthesize
#define UITextModelProtocol_synthesize \
\
@synthesize textAlignment = _textAlignment;\
@synthesize lineBreakMode = _lineBreakMode;\
@synthesize textLineSpacing = _textLineSpacing;\
@synthesize font = _font;\
@synthesize text = _text;\
@synthesize textCor = _textCor;\
@synthesize attributedText = _attributedText;\
@synthesize titleAttributedDataMutArr = _titleAttributedDataMutArr;\
@synthesize selectedText = _selectedText;\
@synthesize selectedTextCor = _selectedTextCor;\
@synthesize selectedAttributedText = _selectedAttributedText;\
@synthesize selectedTitleAttributedDataMutArr = _selectedTitleAttributedDataMutArr;\

#endif

#pragma mark —— @dynamic UITextModelProtocol
#ifndef UITextModelProtocol_dynamic
#define UITextModelProtocol_dynamic \
@dynamic textAlignment;\
@dynamic lineBreakMode;\
@dynamic textLineSpacing;\
@dynamic font;\
@dynamic text;\
@dynamic textCor;\
@dynamic attributedText;\
@dynamic titleAttributedDataMutArr;\
@dynamic selectedText;\
@dynamic selectedTextCor;\
@dynamic selectedAttributedText;\
@dynamic selectedTitleAttributedDataMutArr;\

#endif

