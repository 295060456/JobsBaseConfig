//
//  DDTextView.h
//  DouDong-II
//
//  Created by alan comb on 2021/4/3.
//

#import "BaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDTextView : BaseView

@property(nonatomic,copy)NSString *placeholder;
@property(nonatomic,strong)UIColor *placeholderColor;
@property(nonatomic,strong)UIFont *font;
@property(nonatomic,assign)CGFloat lineSpacing;
@property(nonatomic,assign)NSInteger maxWordCount;
@property(nonatomic,copy)NSString *text;

-(void)markedTextValue:(jobsByIDBlock)valueBlock
          invalidBlock:(jobsByVoidBlock)invalidBlock;
@end

NS_ASSUME_NONNULL_END
