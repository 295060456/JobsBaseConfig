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

@property(nonatomic,strong,nullable)NSString __block *text;
@property(nonatomic,strong,nullable)NSAttributedString __block *attributedText API_AVAILABLE(ios(6.0));
@property(nonatomic,strong)NSMutableArray <RichTextConfig *>*titleAttributedDataMutArr;/// 对于富文本优先级：titleAttributedDataMutArr > titleAttributedStr
@property(nonatomic,strong,nullable)UIColor __block *textCor;//主字体颜色
@property(nonatomic,strong,nullable)UIFont __block *font;//主文字字体
@property(nonatomic,assign)NSTextAlignment __block textAlignment;//主文字对齐方式
@property(nonatomic,assign)NSLineBreakMode __block lineBreakMode;//主文字提行方式
@property(nonatomic,assign)CGFloat __block textLineSpacing;

@end

NS_ASSUME_NONNULL_END

#pragma mark —— @synthesize UITextModelProtocol
#ifndef UITextModelProtocol_synthesize
#define UITextModelProtocol_synthesize \
\
@synthesize text = _text;\
@synthesize attributedText = _attributedText;\
@synthesize titleAttributedDataMutArr = _titleAttributedDataMutArr;\
@synthesize textCor = _textCor;\
@synthesize font = _font;\
@synthesize textAlignment = _textAlignment;\
@synthesize lineBreakMode = _lineBreakMode;\
@synthesize textLineSpacing = _textLineSpacing;\

#endif

#pragma mark —— @dynamic UITextModelProtocol
#ifndef UITextModelProtocol_dynamic
#define UITextModelProtocol_dynamic \
@dynamic text;\
@dynamic attributedText;\
@dynamic titleAttributedDataMutArr;\
@dynamic textCor;\
@dynamic font;\
@dynamic textAlignment;\
@dynamic lineBreakMode;\
@dynamic textLineSpacing;\

#endif

