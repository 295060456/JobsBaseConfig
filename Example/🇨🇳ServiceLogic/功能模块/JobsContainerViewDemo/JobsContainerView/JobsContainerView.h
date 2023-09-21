//
//  JobsContainerView.h
//  MataShop
//
//  Created by Jobs Hi on 9/21/23.
//

#import <UIKit/UIKit.h>
#import "JobsBtnModel.h"
#import "BaseView.h"

NS_ASSUME_NONNULL_BEGIN
/**
 不能使用
 - (CGRect)boundingRectWithSize:(CGSize)size
 options:(NSStringDrawingOptions)options
 attributes:(nullable NSDictionary<NSAttributedStringKey, id> *)attributes
 context:(nullable NSStringDrawingContext *)context API_AVAILABLE(macos(10.11), ios(7.0));
 方法来精确计算文本尺寸的原因:行间距的不确定性
 
 在iOS中，UILabel 默认的行间距是根据字体和文本内容来自动计算的，并且通常情况下不会有明确的默认值。
 行间距会受到字体、文本内容、字体大小以及UILabel的frame大小等因素的影响。
 */
/// ❤️宽度的优先级示意图：JobsBtnModel.btnWidth > 不提行时候的最大宽度 > 整个容器的宽widthBySelf ❤️
@interface JobsContainerView : BaseView
/// 禁止使用系统的 alloc.init 和 new方法来进行创建对象
+(instancetype)new NS_UNAVAILABLE;
-(instancetype)init NS_UNAVAILABLE;
/// - Parameters:
///   - widthBySelf: 整个容器的宽度 == 子控件（UIButton）的预设值
///   - buttonModels: 数据源
-(instancetype)initWithWidth:(CGFloat)widthBySelf
                buttonModels:(NSArray<JobsBtnModel *> *)buttonModels;
@end

NS_ASSUME_NONNULL_END
/**

 要求：
 1、用OC代码作答下列需求；
 2、自定义一个容器View；
     2.1、这个容器有个属性：每个子元素之间的垂直距离offsetY；
 3、里面从上至下首尾相接铺满UIButton；
 4、UIButton的个数是根据外界传入的数组A决定的；
     4.1、这个数组是可变数组；
     4.2、数组里面存放的元素是一个继承于NSObject的Model；
     4.3、这个Model的属性是对UIButton的配置信息：
         4.3.1、UIButton的背景色、
     4.3.2、背景图片、
     4.3.3、文字内容、
     4.3.4、字体、
     4.3.5、字体颜色、
     4.3.6、图片、
     4.3.7、图片的Size、
     4.3.8、图片和文字的相对位置（图左文字右/图右文字左/图上文字下/图下文字上）、
     4.3.9、图片和文字之间的距离、
     4.3.10、文字是否换行显示；
 5、这两个UIButton是铺满整个容器View的；
     5.1、这个容器View的宽 = 是依据外界传入的数组A里面对UIButton的配置而来的所有UIButton相比较以后得的最大宽度距离；
     5.2、这个容器View的高 = 是依据外界传入的数组A里面对UIButton的配置而来的所有UIButton的高 + 每个子元素之间的垂直距离offsetY；
     5.3、第一个UIButton的上边界与这个容器View的上边界对齐；
     5.4、最后一个UIButton的上边界与这个容器View的下边界对齐；
     5.5、容器View里面装着的是依据外界传入的数组A（数组里面装的是UIButton各项配置），自上而下紧挨着排布的，子元素之间的垂直距离offsetY。UIButton的个数 = 数组A的元素个数
 
 使用方法：
 -(JobsContainerView *)containerView{
    if(!_containerView){
     _containerView = [JobsContainerView.alloc initWithWidth:JobsWidth(200)
                                                  buttonModels:self.btnModelMutArr];
     _containerView.backgroundColor = UIColor.purpleColor;
     [self.view addSubview:_containerView];
     [_containerView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.size.mas_equalTo(_containerView.jobsSize);
         make.center.equalTo(self.view);
     }];
 }return _containerView;
}

 -(NSMutableArray<JobsBtnModel *> *)btnModelMutArr{
     if(!_btnModelMutArr){
         _btnModelMutArr = NSMutableArray.array;
         {
             JobsBtnModel *model = JobsBtnModel.new;
             model.backgroundColor = UIColor.yellowColor;
 //            model.backgroundImage = JobsIMG(@"手机号码");
             model.title = Internationalization(@"普通的.普通的.普通的.普通的.普通的.普通的.");
             model.font = UIFontWeightRegularSize(12);
             model.titleColor = UIColor.blueColor;
             model.image = JobsIMG(@"手机号码");
             model.imageSize = CGSizeMake(JobsWidth(50), JobsWidth(80));
             model.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
             model.contentSpacing = JobsWidth(8);
             model.wrapsText = NO;

             [_btnModelMutArr addObject:model];
         }

         {
             JobsBtnModel *model = JobsBtnModel.new;
             model.backgroundColor = UIColor.grayColor;
 //            model.backgroundImage = JobsIMG(@"手机号码");
             model.title = Internationalization(@"我不换行.我不换行.我不换行.我不换行.");
             model.font = UIFontWeightRegularSize(12);
             model.titleColor = UIColor.redColor;
             model.image = JobsIMG(@"手机号码");
             model.imageSize = CGSizeMake(JobsWidth(50), JobsWidth(80));
             model.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
             model.contentSpacing = JobsWidth(2);
             model.wrapsText = NO;

             [_btnModelMutArr addObject:model];
         }
         
         {
             JobsBtnModel *model = JobsBtnModel.new;
             model.backgroundColor = UIColor.yellowColor;
 //            model.backgroundImage = JobsIMG(@"手机号码");
             model.title = Internationalization(@"我要换行.我要换行.我要换行.我要换行.我要换行.我要换行.我要换行.我要换行.");
             model.font = UIFontWeightRegularSize(12);
             model.titleColor = UIColor.greenColor;
             model.image = JobsIMG(@"手机号码");
             model.imageSize = CGSizeMake(JobsWidth(50), JobsWidth(80));
             model.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
             model.contentSpacing = JobsWidth(8);
             model.wrapsText = YES;

             [_btnModelMutArr addObject:model];
         }
         
     }return _btnModelMutArr;
 }
 
 */




