//
//  OCDynamicRegisterVC.m
//  JobsBaseConfig
//
//  Created by Jobs on 2022/6/9.
//

#import "OCDynamicRegisterVC.h"
#import <objc/message.h>

@interface OCDynamicRegisterVC (){
    Class newClass;
}

@end 
/**
 资料来源：
 https://cloud.tencent.com/developer/article/1799505
 http://southpeak.github.io/2014/10/25/objective-c-runtime-1/
 https://github.com/zhiyongzou/DynamicOC
 
 */
@implementation OCDynamicRegisterVC

- (void)dealloc{
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
    //    [[NSNotificationCenter defaultCenter] removeObserver:self];
    objc_disposeClassPair(newClass);
}

-(void)loadView{
    [super loadView];
    
    if ([self.requestParams isKindOfClass:UIViewModel.class]) {
        self.viewModel = (UIViewModel *)self.requestParams;
    }
    self.setupNavigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = RandomColor;
    [self setGKNav];
    [self setGKNavBackBtn];
    self.gk_navigationBar.jobsVisible = YES;
    
    [self work];
}

-(void)work{
    /// 动态创建类
    Class MyClass = [self createClass:@"dynaminClass"];
//    id myobjc = objc_msgSend(MyClass, @selector(alloc));？？？
    /// 各种添加赋值
    [self addProperty:@"jackName"];
    [self addIvarStr:@"jobsName"];
    [self addMethod];
    [self addProtocol];
    /// 注册到内存
    [self registerClass:MyClass];
    id myobjc = [self createInstanceByClass:@"dynaminClass"];
    /// 通过KVC的方式给myObj对象的jobsName属性赋值
    [myobjc setValue:@"我是Jobs" forKey:@"jobsName"];// ⚠️注意⚠️：此时，运行程序后会报错。这是因为我只添加了属性，并没有给属性添加对应的setter和getter
    /// 添加对应的setter和getter
    class_addMethod(MyClass, @selector(setJobsName:), (IMP)jobsNameSetter, "v@:@");
    class_addMethod(MyClass, @selector(jobsName), (IMP)jobsName, "@@:");
    
    id A = [myobjc performSelector:@selector(setJobsName:) withObject:@"bmw"];
    id B = [myobjc performSelector:@selector(jobsName) withObject:nil];
    NSLog(@"");
    /// 如果不调用- (void)addMethodForMyClass:(NSString *)string 这个方法，就不会调用static void addMethodForMyClass(id self, SEL _cmd, NSString *test) 函数
//    [myobjc addMethodForMyClass:@"参数"];
}
// setter
void jobsNameSetter(NSString *value){
    printf("%s/n",__func__);
}
// getter
NSString *jobsName(){
    printf("%s/n",__func__);
    return @"master NB";
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches
          withEvent:(UIEvent *)event{
    [OCDynamic Test];
    
    OCDynamic *dynamic = OCDynamic.new;
    [dynamic test];
}
#pragma mark —— 一些私有方法
/// 动态创建类并添加：成员变量、属性、方法、协议
-(Class)createClass:(NSString *)className {
    if (!NSClassFromString(className)) {
        /// ❤️添加一个集成NSObject的类  类名是className；注意：调用的c语言的方法  所以不要使用@""表示字符串 应该使用""❤️
        /// 我们如果使用objc_allocateClassPair函数来创建一个类对象失败了，那么objc_allocateClassPair就会返回Nil。如果所要创建的类已经存在了，那么就会返回Nil.
        newClass = objc_allocateClassPair(OCDynamic.class,/// 第一个参数是父类对象，如果传nil那么新创建的类就是跟NSObject同等级别的根类对象;
                                          className.UTF8String,/// 第二个参数是本类类名;
                                          0);/// 第三个参数是初始的内存空间大小;
        return newClass;
/*
 1、objc_registerClassPair函数是将创建的类对象加载到内存，加载完成之后，本类中的ro就已经确定了;
 2、我们知道，ro是只读的，它在确定之后就不可以动态增加内容了，如果我们想在运行时增加一些内容，只能是往rw中去增加;
 3、存储成员变量的数组ivars只在ro中有，rw中是没有ivars的;
 4、因此，成员变量在ro初始化了之后就不能再继续动态新增了;
 5、所以，必须在ro初始化之前（即在调用objc_registerClassPair函数之前）完成成员变量的定义;
 6、rw的结构，可以看到是有methods、properties和protocols三个变量的

 结论：
 1、【在类注册完成之后，不可以继续添加成员变量了】
 2、【所以，在类注册完成之后，可以继续添加方法、属性和协议】
 */
    }return NSClassFromString(className);
}
/// 【添加属性】
-(void)addProperty:(NSString *)propertyName{
    jobs_class_addProperty(newClass, propertyName.UTF8String);
}
/// 【添加方法】
-(void)addMethod{
    class_addMethod(newClass,/// 第一个参数是在哪个类中添加方法
                    @selector(test),/// 第二个参数是所添加方法的编号SEL
                    (IMP)funcIMP,/// 第三个参数是所添加方法的函数实现的指针IMP
                    "v@:");/// 第四个参数是所添加方法的签名
}
/// 【添加协议】❤️
-(void)addProtocol{
    
}
/// 【添加成员变量NSString *】
-(void)addIvarStr:(NSString *)ivarName{
    /// ⚠️注意⚠️：不能在objc_registerClassPair之后进行调用
    class_addIvar(newClass,/// 第一个参数cls是类对象，它表示是往哪个类添加成员变量。需要注意的是，这个cls不能是元类对象，因为我们不支持在元类中添加实例变量;
                  ivarName.UTF8String,/// 第二个参数name是成员变量的名字;
                  sizeof(NSString *),/// 第三个参数size是成员变量的类型的大小;
                  log2(sizeof(NSString *)),/// 第四个参数alignment是对齐处理方式，即二进制对齐位数，对于所有指针类型的变量，都是取成员变量类型大小以2为底的对数。比如8=2^3，因此这里就应该赋值3;
                  "@");/// 第五个参数types是签名
}
/// 注册到内存
-(void)registerClass:(Class)cls{
    objc_registerClassPair(cls);
}
/// 生成类的实例
-(id)createInstanceByClass:(NSString *)className {
    newClass = NSClassFromString(className);
    if (!newClass) {
        /// 第一个参数是父类对象，如果传nil那么新创建的类就是跟NSObject同等级别的根类对象;
        /// 第二个参数是本类类名;
        /// 第三个参数是初始的内存空间大小;
        /// 我们如果使用objc_allocateClassPair函数来创建一个类对象失败了，那么objc_allocateClassPair就会返回Nil。如果所要创建的类已经存在了，那么就会返回Nil.
        newClass = objc_allocateClassPair(OCDynamic.class,
                                          className.UTF8String,
                                          0);
    }
    id intanceOfClass = [newClass.alloc init];
    id PropertyList = printPropertyList(intanceOfClass);
    id MethodList = printMethodList(intanceOfClass);
    NSLog(@"PropertyList = %@",PropertyList);
    NSLog(@"MethodList = %@",MethodList);
    [intanceOfClass performSelector:@selector(test)];
    return intanceOfClass;
}
/// 调用方法
void funcIMP(Class self, SEL _cmd){
    Class class = [self class];
    // 类： dynaminClass, sel： test.
    NSLog(@"self: %@ sel: %s", class, _cmd);
}
/// 封装的添加属性的方法
void jobs_class_addProperty(Class targetClass , const char *propertyName) {
    objc_property_attribute_t type = { "T", [[NSString stringWithFormat:@"@\"%@\"",NSStringFromClass([NSString class])] UTF8String] }; //type
    objc_property_attribute_t ownership0 = { "C", "" }; // C = copy
    objc_property_attribute_t ownership = { "N", "" }; //N = nonatomic
    objc_property_attribute_t backingivar  = { "V", [NSString stringWithFormat:@"_%@",[NSString stringWithCString:propertyName encoding:NSUTF8StringEncoding]].UTF8String };  //variable name
    objc_property_attribute_t attrs[] = {type,
                                         ownership0,
                                         ownership,
                                         backingivar};
    /// 第一个参数是给哪个类添加属性
    /// 第二个参数是属性名
    /// 第三个参数是所添加的属性的一些属性，比如所属类、读写性、原子性、内存管理策略等。见图：objc_property_attribute_t
    /// 第四个参数是属性的属性的数量。
    class_addProperty(targetClass,
                      propertyName,
                      attrs,
                      4);
    /// 光添加属性，运行会报错，因为没有添加属性的 set / get 方法
}
/// self和_cmd是必须的，在之后可以随意添加其他参数
static void addMethodForMyClass(id self, SEL _cmd, NSString *test) {
    // 获取类中指定名称实例成员变量的信息
    Ivar ivar = class_getInstanceVariable([self class], "test");
// 获取整个成员变量列表
//   Ivar * class_copyIvarList ( Class cls, unsigned intint * outCount );
// 获取类中指定名称实例成员变量的信息
//   Ivar class_getInstanceVariable ( Class cls, const charchar *name );
// 获取类成员变量的信息
//   Ivar class_getClassVariable ( Class cls, const charchar *name );
    // 返回名为test的ivar变量的值
    id obj = object_getIvar(self, ivar);
    NSLog(@"%@",obj);
    NSLog(@"addMethodForMyClass:参数：%@",test);
    NSLog(@"ClassName：%@",NSStringFromClass([self class]));
}
/// 这个方法实际上没有被调用,但是必须实现否则不会调用下面的方法
- (void)addMethodForMyClass:(NSString *)string {
    NSLog(@"");
}

-(void)知识点{
    /// Class 反射创建
    // 方式1
    NSClassFromString(@"NSObject");
    // 方式2
    objc_getClass("NSObject");
    
    /// SEL 反射创建
    // 方式1
    @selector(init);
    // 方式2
    sel_registerName("init");
    // 方式3
    NSSelectorFromString(@"init");
}

@end
