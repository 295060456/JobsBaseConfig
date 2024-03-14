# Swift.OC 相关经验

[toc]

## 一些相关文献
[Swift自动布局SnapKit的详细使用介绍](https://www.jianshu.com/p/2bad53a2a180)
[SwiftUI - 与UIKit集成](https://www.jianshu.com/p/fbc920c11b0d)
[SwiftUI -SwiftUI 和 UIKit 的相互引用](https://juejin.cn/post/7153879743107399710)
[JXSegmentedView](https://github.com/pujiaxin33/JXSegmentedView)
## Swift视频教学
[BBCo - iOS开发入门教程 SwiftUI 微博App项目实战 Lesson 1 (零基础学习Swift编程)](https://www.youtube.com/watch?v=5n0qoRZ8gXA&list=PLotizAeaV0nPM7a7Yy3Uyh4rkgBvT9N_H&index=2)
## 网络分层
最常见的网络分层是 OSI（**O**pen **S**ystems **I**nterconnection）
### OSI 参考模型
* **物理层（Physical Layer）**：
   - 负责传输比特流（0 和 1）。
   - 包括物理介质、电压等传输媒介的规范。
* **数据链路层（Data Link Layer）**：
   - 提供了物理层之上的逻辑传输，将比特流转化为数据帧。
   - 提供了数据帧的传输和错误检测。
* **网络层（Network Layer）**：
   - 负责将数据包从源节点传输到目的节点，跨越不同的网络。
   - 提供了路由选择、分组转发等功能。
* **传输层（Transport Layer）**：
   - 提供端到端的数据传输服务，确保数据的可靠性和完整性。
   - 提供了流量控制、拥塞控制等功能，如 TCP 和 UDP 协议。
* **会话层（Session Layer）**：
   - 管理应用程序之间的会话，建立、维护和终止会话。
   - 提供了会话管理、同步和恢复等功能。
* **表示层（Presentation Layer）**：
   - 负责数据的格式化、加密和解密，以确保数据的可读性和安全性。
   - 提供了数据的表示、编码和解码。
* **应用层（Application Layer）**：
   - 提供了网络服务和应用程序之间的接口。
   - 包括 HTTP、FTP、SMTP 等协议，以及各种应用程序。
### 参考模型和 TCP/IP 协议族
* **应用层**：包含了 OSI 参考模型中的应用层、表示层和会话层;
* **传输层**：类似于 OSI 参考模型的传输层，提供了端到端的数据传输，如 TCP 和 UDP 协议;
* **网络层**：类似于 OSI 参考模型的网络层，负责数据包的传输和路由选择，如 IP 协议;
* **链路层**：类似于 OSI 参考模型的数据链路层和物理层，负责数据帧的传输和物理介质的规范;
## 内存区域分类
*在计算机中，内存可以**根据其功能和用途**划分为不同的区域。*以下是常见的内存区域分类：(7大区)
* **代码区（Code or Text Segment）**：
  * 代码区存储程序的可执行代码，包括机器指令和只读数据（如字符串常量）；
  * 代码区**通常是只读的**，因为程序的代码在运行时不应该被修改；
* **数据区（Data Segment）**：
   * 数据区包含了**已初始化的全局变量和静态变量**；
   * 这些变量在程序开始时分配并初始化，存储在内存的数据段中；
* **BSS 区（BSS Segment）**：
   * BSS（Block Started by Symbol）区存储**未初始化的全局变量和静态变量**；
   * 在程序启动时，这些变量被自动初始化为零值；
* **[堆（Heap）](# 堆(Heap))**：
   * 堆是动态分配的内存区域，用于存储**程序运行时动态分配的内存**；
   * [堆(Heap)](# 堆(Heap))上的内存可以通过函数如 `malloc()`、`calloc()` 或者 `new` 来分配，并通过 `free()` 或者 `delete` 函数来释放；
* **[栈（Stack）](# 栈(Stack))**：
   * 栈用于存储函数的局部变量、函数参数、函数的**返回地址**等；
   * 每次函数调用时，会在栈上分配一块称为栈帧（Stack Frame）的内存，**函数返回后，栈帧会被销毁**；
   * [栈](# 栈(Stack))的大小是有限的，通常比堆的大小小得多（[栈](# 栈(Stack)) << [堆](# 堆(Heap))）；
* **常量区（Constant Segment）**：
   * 常量区存储常量值，如字符串常量；
   * 这些常量**在程序运行期间是不可修改的**；
* **全局区（Global Segment）**：
   * 全局区存储全局变量，但是和数据区的区别是，它包含了**未初始化的全局变量**；
   * 在程序开始时，未初始化的全局变量会被初始化为默认值；
```
不同操作系统和编程语言的实现可能会有所不同，上述分类只是一种常见的划分方式。
TCP/IP 协议族中的层次结构并不是严格按照 OSI 参考模型来定义的，但它们都提供了类似的功能。网络分层的好处在于可以提高系统的模块化、灵活性和可维护性，同时也促进了不同厂商之间的互操作性。
```
## 堆和栈
### *堆(**Heap**)*
* 程序员手动控制
* 在堆上分配的内存由 **ARC**（**A**utomatic **R**eference **C**ounting）管理
* 存储：类实例.方法、类实例.属性
* **存放引用类型**：Class类型、闭包和函数
  * 浅拷贝
  * **堆操作牵涉到合并、移位、重新链接等**
### *栈(**Stack**)*
* 栈上的内存分配和释放由编译器自动管理；
* 将String，Array，Dictionary设计成值类型，**大幅减少了堆上的内存分配和回收的次数**。同时[**C**opy-**O**n-**W**rite](# Copy-On-Write)又将值传递和复制的开销降到了最低；
* **存放值类型**：结构体（struct）、枚举（enum）、元祖（tuple）
  * 深拷贝：可以确保在函数内部或者在其他变量中修改值类型的值时，不会影响到原始值；
  * 性能优势：**仅仅是单个指针的上下移动**；
  * 线程安全：直接存储于内存 ＋ 不需要引用（没有引用计数）和垃圾回收等操作 = 不会发生因为引用计数的增减而引起的竞态条件
## Copy-On-Write
* **C**opy-**O**n-**W**rite（COW）是一种内存管理技术，通常**用于优化复杂数据结构的拷贝操作**。
* 它的基本思想是**延迟拷贝**，只有在**需要修改数据时才进行实际的拷贝操作**，这样可以节省内存和提高性能。
* 具体来说，**当多个变量共享同一块内存时，如果其中一个变量需要修改数据，那么就会进行拷贝操作，而不是直接修改原始数据**
  * 这样，在修改数据之前，所有的变量都指向同一块内存，称为共享状态；
  * 而在修改数据后，修改发生的变量会拷贝一份数据到新的内存空间，然后修改新的内存空间中的数据，这样其他变量不受影响，仍然指向原来的内存空间。
* **C**opy-**O**n-**W**rite 的优点是在大部分情况下避免了不必要的数据拷贝，节省了内存和运行时间。它通常用于处理复杂数据结构，如字符串、数组、字典等，这些数据结构在进行赋值操作时可能需要进行大量的数据拷贝，使用 **C**opy-**O**n-**W**rite技术可以显著提高性能。
* 在实际应用中，**C**opy-**O**n-**W**rite 技术常见于编程语言的标准库中，如 Swift 中的字符串和数组类型就采用了**C**opy-**O**n-**W**rite
## 【Swift vs Java vs C/C++】static 和 final的区别
* # static
  * ## C/C++
    * 在函数内部，`static` 关键字用于**声明静态局部变量**。这些变量**在整个程序的生命周期内保持其值，但只在声明它们的函数内可见**；
    * 在全局作用域，`static` 关键字用于限制变量和函数的可见性。使用 `static` 关键字声明的全局变量和函数**只在当前源文件中可见，对其他源文件不可见**；
    * 存储在数据段中的**静态存储区**；
    
  * ## Java
    - 在 Java 中，`static` 关键字用于**声明静态成员**（静态变量和静态方法）。静态成员属于类而不是类的实例，可以通过类名直接访问，而不需要创建类的实例；
    - 静态成员**在整个程序的生命周期内保持其值**，并且可以被类的所有实例共享；
    - 存储在**方法区（Method Area）**中；
    
  * ## Swift
    * 在 Swift 中，`static` 关键字用于定义类型范围的属性和方法。这些属性和方法属于类型本身，而不是类的实例或结构体的实例；
    * 这些属性和方法**在整个程序的生命周期内保持其值**，并且可以通过类型名来访问，而不需要创建实例；
    * [定义单例](# Swift单例的写法和用法)
    * 在 Swift 中，静态成员的存储位置**取决于具体的上下文**；
      * 在类中，静态属性和方法通常存储在类的元类型中，而元类型本身**存储在[堆](# 堆(Heap))上**；
      * 而在结构体或枚举中，静态属性和方法**存储在静态数据区**中；
  
* # final
  * ## C/C++
    * **没有 `final` 关键字的概念**。如果要限制变量的值不可修改，可以使用 `const` 关键字来声明常量
    ```c
    const int constantValue = 10; // 声明一个常量
    ```
  * ## Java
    * 当一个类被声明为 `final` 时，它**不能被其他类继承**；
    * 当一个方法被声明为 `final` 时，它**不能被子类重写**；
    * 当一个变量被声明为 `final` 时，它的**值不能被修改，相当于常量**（**内存分布：常量池**）；
    * 在内存中，`final` 类的对象和成员变量**存储在[堆(Heap)](# 堆(Heap))上**，和普通类的对象存储位置相同；
  * ## Swift
    - 在 Swift 中，`final` 关键字用于限制类、方法或者属性**不可被继承或者重写**；
    - 当一个类被声明为 `final` 时，它**不能被其他类继承**；
    - 当一个方法或者属性被声明为 `final` 时，它**不能被子类重写**；
    - 在内存中，`final` 方法或属性的存储位置和普通方法或属性相同，取决于具体的上下文环境；
      * **堆（Heap）**：如果方法或属性属于类的实例，则它们通常**存储在[堆](# 堆(Heap))上**（ARC）；
      * **栈（Stack）**：如果方法或属性属于结构体的实例或是局部变量，则它们通常存储在[栈](# 栈(Stack))上（编译器自动）；
      * **常量池（Constant Pool）**：对于某些特定的常量或静态变量，它们可能被存储在常量池中，这取决于编译器的优化和实现方式；
## 为什么在Swift里面新建一个view要用struct，而不用class
```swift
在 SwiftUI 中，视图（View）被建议使用结构体（struct）而不是类（class）。
这是因为 SwiftUI 采用了声明式的编程范式，而结构体更符合声明式编程的特性。
```
*下面是一些原因：*
* 不可变性：结构体是值类型，而类是引用类型。值类型在传递和复制时会产生副本，这有助于保持不可变性
```swift
SwiftUI 的设计倾向于使用不可变的数据模型，以确保状态的一致性和可预测性
```
* 简单性和可预测性：结构体更简单，不涉及继承和引用计数等概念，使得代码更易于理解和维护。结构体通常更容易推导和预测其行为。
* 值语义：结构体提供了值语义，这意味着它们的比较是基于值而不是引用的。
```swift
这有助于在 SwiftUI 中更容易管理视图层次结构和状态。
```
* 性能优势:结构体在一些情况下可能具有性能优势
```swift
由于值语义和不可变性，Swift 编译器可以进行更多的优化，例如避免不必要的副本操作。
```
*综上所述*
```swift
在 SwiftUI 中，View 协议的实现通常要求是不可变的，因此使用结构体是一个自然的选择。
在 SwiftUI 中创建的视图是根据数据模型的变化而自动更新的，这与结构体的值语义非常契合。

尽管 SwiftUI 偏向结构体，但在其他上下文中，仍然可能使用类，特别是在需要引用语义和共享可变状态的情况下。
在 SwiftUI 中，这样的情况相对较少，因为 SwiftUI 本身的设计目标是通过数据驱动界面。
```
## ❤️OC/C.Block
当一个 Block 被创建时，它会捕获在其内部使用的外部变量。捕获的变量可以是局部变量或全局变量。
* **Block 的捕获变量** 
  * **对于局部变量，Block 会在创建时将其复制一份，然后在 Block 内部使用。**如果 Block 在定义时没有修改该变量，那么这个变量的值在 Block 内部是不可变的。这被称为值捕获（Value Capture）；
    ```objective-c
    // 定义一个Block
    typedef void (^SimpleBlock)(void);
    
    int main() {
        // 定义一个局部变量
        __block int count = 0;
        // 定义一个Block，并在Block内部使用count变量
        SimpleBlock block = ^{
            NSLog(@"Count inside block: %d", count);
        };
        // 修改count的值
        count = 10;
        // 调用Block
        block(); // 这里的count值在Block内部被捕获，即使count在Block定义之后被修改，但值仍然被捕获
        return 0;
    }
    
    // 输出将会是：
    Count inside block: 10
      
    在这个例子中，Block捕获了count变量的值，即使在Block定义之后count的值被修改，Block内部仍然使用了最初捕获的值。
    ```
  * **对于全局变量，Block 会直接引用其内存地址，而不会复制**；
* **__block 修饰符**
  * 当需要在 Block 内部修改局部变量的值时，需要使用 `__block` 修饰符来声明该变量。这样，在 Block 内部就可以通过引用来修改外部变量的值；
  * **使用 `__block` 修饰的变量在 Block 内部会被包装为一个结构体，这个结构体中包含了一个指向原始变量的指针。这样 Block 内部就可以通过这个指针来修改变量的值，而不会影响到原始变量的值**；
* ❤️**Block 的存储**
  * Block 是一个**对象**，它在**[堆](# 堆(Heap))上分配**内存；
  * 当一个 Block 捕获了一个 `__block` 修饰的变量时，Block 不会直接捕获这个变量的值，而是**捕获了一个指向变量的指针**；
  * 当 Block 在创建时，会检查其所引用的外部变量，如果有被 `__block` 修饰的变量，Block 会将这些变量的地址包装到一个结构体中，然后将这个结构体的指针传递给 Block；
## swift.mutating
* 用于结构体（struct）和枚举（enum）中的**方法声明**中，*表示该方法可以修改该结构体或枚举的属性值*，即使该方法在实例被声明为常量（`let`）时调用也可以；
* 对于类（class）中的方法，不需要使用`mutating`关键字，因为类是引用类型，即使在常量类实例上调用方法，也可以修改其属性；
```swift
struct Point {
    var x = 0.0
    var y = 0.0
    // 如果不将该方法标记为mutating，试图在常量结构体实例上调用此方法时将会导致编译错误。
    mutating func moveBy(x deltaX: Double, y deltaY: Double) {
        x += deltaX
        y += deltaY
    }
}

var point = Point(x: 1.0, y: 1.0)
print("Before moving: \(point)")

point.moveBy(x: 2.0, y: 3.0)
print("After moving: \(point)")
```
## 对比swift.mutating 和 swift.inout
* **inout**
  *  `inout`是Swift中**用于函数参数**的关键字。它**允许函数修改参数**的值，并且这种修改是在函数内部生效并影响到函数外部传入的实际参数；
  * 使用`inout`时，传入函数的参数被当做可变的，因此函数可以对其进行修改。在函数内部对`inout`参数的任何更改都会反映到调用该函数时传入的原始参数上；
  * `inout`参数本质上是**传递参数的引用**，因此对参数的任何更改都会影响调用者的原始数据；
  * 定义函数的时候加`inout`
  * 使用的时候配合取地址符号`&`使用
  ```swift
  // 定义一个函数，接受一个 inout 参数
  func increment(value: inout Int) {
      value += 1
  }
  // 定义一个变量
  var number = 5
  
  print("Before increment: \(number)")
  
  // 调用函数，并传递变量的引用作为参数
  increment(value: &number)
  
  print("After increment: \(number)")
  
  // 输出结果将会是：
  Before increment: 5
  After increment: 6
  ```
* **mutating**（专修结构体和枚举）
  * `mutating`是Swift中**用于结构体和枚举中方法**的关键字。它**允许方法修改结构体或枚举的实例属性**。由于结构体和枚举是值类型，它们的属性默认是不可变的。因此，如果需要在方法中修改属性，则必须将方法标记为`mutating`；
  * `mutating`关键字仅用于值类型（结构体和枚举）的方法声明。这样的方法可以修改调用该方法的实例的属性值；
## 内联函数，内联这两个字，我怎么去理解？
```
理解内联（Inlining）涉及到编程语言的编译和执行的一些概念。
简单来说，内联是一种编译器优化技术，它将调用函数的地方直接替换为被调用函数的实际代码，而不是通过在执行时跳转到函数的位置。
这样可以减少函数调用的开销，提高代码的执行效率。
```
*具体来说，理解内联函数涉及以下几个概念：*
* 函数调用开销：
```
在程序执行期间，每次调用函数都会引入一些开销，如保存当前函数的上下文、跳转到被调用函数的位置、执行函数体等。
对于一些小而频繁调用的函数，这些开销可能在一定程度上影响性能。
```
* 内联优化:
```
内联是一种编译器优化策略，它试图减少函数调用的开销，将函数调用处直接替换为函数体的内容。
这样可以避免调用开销，减少了跳转和上下文保存的开销。
```
**内联的适用情况： 内联适用于一些小型的、频繁调用的函数，这样可以减少函数调用的开销，提高性能。**
**但并不是所有函数都适合内联，因为内联会增加代码的体积，可能导致代码膨胀。**
```swift
@inlineable 和 @usableFromInline： 在 Swift 中，可以使用 @inlineable 和 @usableFromInline 属性来影响编译器对函数的内联决策。@inlineable 表示一个函数可以被内联，但具体是否内联取决于编译器的决策。@usableFromInline 则用于指示一个函数可以在同一模块的其他地方内联使用。

在 Swift 中，编译器会根据具体情况决定是否内联函数，而使用 @inlineable 和 @usableFromInline 可以影响这个决策。开发者通常无需过多关注内联，因为 Swift 的编译器会自动进行相应的优化。
```
## 当前函数的上下文，这个上下文是什么意思？
```
在计算机科学中，函数的上下文（Context）通常指的是函数执行时的运行环境，包括函数调用时的一些信息和状态。
```
*这个上下文包括但不限于以下内容：*
* 局部变量：
```
函数内部声明的局部变量和参数是函数上下文的一部分。
这些变量在函数调用时被创建，在函数返回时被销毁。
```
* 参数：
```
函数的参数值是上下文的一部分，它们存储了调用函数时传递的实际参数。
```
* 函数的返回地址：
```
在函数调用时，调用点的地址通常会被保存下来，以便在函数执行完成后返回到正确的位置。
```
* 调用[栈](# 栈(Stack))信息：
```
函数调用时，系统会在调用栈上保留一些信息，包括返回地址、局部变量和其他与函数调用相关的信息。
```
* 寄存器状态：
```
当函数被调用时，一些寄存器的状态也可能被保存，以便在函数返回时能够恢复调用前的寄存器状态。
```
* 异常处理信息：
```
如果支持异常处理机制，相关信息也可能包含在函数的上下文中。
```
*这些信息组成了函数的上下文，它在函数调用期间用于保持函数的执行状态。*
*在函数执行完成后，这个上下文的信息通常被恢复或者销毁。*
*函数的上下文是为了支持函数调用的正确执行而存在的，它确保了在函数调用期间可以正确地传递参数、保存执行状态，以及在函数返回时恢复执行环境。*
## UIHostingController 和一般的控制器，有何特别之处？（向下兼容）
* SwiftUI 视图的承载：`UIHostingController` 的主要功能是将 SwiftUI 的视图嵌入到 UIKit 中。你可以通过在 `UIHostingController` 中设置一个 SwiftUI 视图，将 SwiftUI 和 UIKit 进行无缝集成。**SwiftUI.view 👉🏻UIKit**
 ```swift
 let swiftUIView = MySwiftUIView()
 let hostingController = UIHostingController(rootView: swiftUIView)
 ```
* 动态视图更新：由于 SwiftUI 的特性，`UIHostingController` 能够自动响应 SwiftUI 视图状态的变化，从而动态地更新其包含的 UIKit 视图。这使得在 SwiftUI 中定义的视图能够自动保持同步，而无需手动刷新
* 声明式 UI 编程： 使用 `UIHostingController` 时，你可以继续使用 SwiftUI 的声明式 UI 编程范式，而不是传统的命令式 UI 编程方式。这使得 UI 的构建和维护更加简单和直观。
* 跨平台兼容性：`UIHostingController` 的使用不仅限于 iOS 平台，你也可以在 macOS 上使用 `NSHostingController`，在 watchOS 上使用 `WKHostingController`，以实现在不同平台上的 SwiftUI 视图承载。
*总体而言*
`UIHostingController` 提供了一种方便的方式，将 SwiftUI 和 UIKit 结合使用，使得你可以逐步采用 SwiftUI，而无需立即完全迁移到 SwiftUI 构建整个应用程序。这种渐进性迁移对于那些已有的 UIKit 项目而言是非常有帮助的。
## UIViewRepresentable 干嘛的？（向上兼容）
`UIViewRepresentable` 是SwiftUI中的一个协议，用于将 UIKit 中的 `UIView` 集成到 SwiftUI 视图层次结构中。当您想要在SwiftUI中使用一个基于 `UIView` 的自定义视图或控件时，可以通过遵循 `UIViewRepresentable` 协议来实现这个集成。**UIKit.UIView👉🏻SwiftUI**
`UIViewRepresentable` 要求您实现两个必备的方法：
1. **makeUIView(context:)：** 该方法创建并返回一个 `UIView` 实例。您可以在这个方法中配置和初始化您的 `UIView`。
2. **updateUIView(_:context:)：** 当视图需要更新时，系统调用此方法。您可以在这里更新您的 `UIView` 的状态或内容，以确保它与 SwiftUI 视图同步。
通过实现这两个方法，您可以在 SwiftUI 中使用自定义的 `UIView` 类型，使其成为 SwiftUI 视图体系的一部分。这对于集成一些原生的 UIKit 控件、图形渲染或其他需要直接使用 `UIView` 的情况非常有用。
```swift
import SwiftUI

struct TextFieldWrapper: UIViewRepresentable {
    @Binding var text: String

    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        textField.delegate = context.coordinator
        return textField
    }

    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: TextFieldWrapper

        init(_ parent: TextFieldWrapper) {
            self.parent = parent
        }

        func textFieldDidChangeSelection(_ textField: UITextField) {
            parent.text = textField.text ?? ""
        }
    }
}

struct ContentView: View {
    @State private var text = ""

    var body: some View {
        TextFieldWrapper(text: $text)
            .padding()
    }
}

在这个例子中，TextFieldWrapper 结构体实现了 UIViewRepresentable 协议，将 UITextField 集成到 SwiftUI 中。通过 @Binding 属性，它能够与 SwiftUI 视图的数据进行双向绑定。
```
## 属性修饰符（Property Attributes）≠ 属性包装器（Property Wrappers）
属性修饰符用于**修饰属性的行为**，而属性包装器用于**提供属性的包装和自定义行为**。
* 属性修饰符 （Property Attributes）：
```swift
属性修饰符是一种用于在 Swift 中附加额外信息或行为的语法元素
属性修饰符是一种用于改变属性行为或特性的关键字。
在 Swift 中，有一些属性修饰符可以用于声明属性，例如：

lazy： 延迟加载属性，只有在第一次访问时才会进行初始化。
weak 和 unowned： 用于管理引用关系，避免循环引用。
public、internal、fileprivate 和 private： 控制属性的访问级别。

class MyClass {
    lazy var lazyProperty: Int = 42
    weak var weakReference: MyClass?
    private var privateProperty: String
    // ...
}
```
* 属性包装器（Property Wrappers）：
```swift
属性包装器是一种用于包装属性的特性，通过在属性定义前使用包装器来提供一些额外的行为。
属性包装器通常用于简化属性的代码、提供额外逻辑或封装属性存储。

@propertyWrapper
struct MyWrapper {
    var value: Int
    
    init(initialValue: Int) {
        self.value = initialValue
    }
    
    var wrappedValue: Int {
        get { return value }
        set { value = newValue }
    }
}

struct MyStruct {
    @MyWrapper(initialValue: 10)
    var wrappedProperty: Int
}

在上述示例中，MyWrapper 是一个属性包装器，MyStruct 中的 wrappedProperty 使用了这个包装器。
属性包装器提供了一种可以自定义属性访问和修改的方式。
```
## @XXX
### @frozen:
*用于标记枚举声明，表示该枚举是冻结的，即其成员在编译时是不可改变的。这有助于编译器进行一些优化。*
```swift
@frozen enum Status {
    case success
    case failure(errorCode: Int)
}
```
在这个例子中，`Status` 是一个枚举，通过 `@frozen` 标记表示它是冻结的。这意味着在后续的代码中不能再添加新的枚举成员，使得编译器可以进行一些优化。
### @usableFromInline:
*用于标记属性、方法、类型等，表示它们可以在模块内的其他地方内联使用，但对模块外不可见。*
```swift
// MyModule.swift
@usableFromInline
struct InternalStruct {
    var value: Int
}

@usableFromInline
func internalFunction() {
    print("Internal function")
}

public struct PublicStruct {
    @usableFromInline
    var internalStruct: InternalStruct

    public init(value: Int) {
        self.internalStruct = InternalStruct(value: value)
    }
}

public func publicFunction() {
    print("Public function")
    internalFunction() // 可以直接调用 @usableFromInline 的函数
}

// 在模块外部的其他文件或模块
let myStruct = InternalStruct(value: 42) // 错误，InternalStruct 对模块外不可见
let result = internalFunction() // 错误，internalFunction 对模块外不可见
```
### @discardableResult:
*discard：丢弃*
*用于标记函数或方法，表示其返回值可以被忽略而不会触发编译器警告。**仅仅是抑制警告***
```swift
@discardableResult
func processResult() -> Int {
    // ...
}
```
### @available:
 *用于标记函数、方法、属性等，指示它们的可用性和版本要求。*

```swift
@available(iOS 14.0, *)
func newAPI() {
    // ...
}
```
### @MainActor：
*是一个属性包装器（property wrapper），它用于标记特定的属性、方法或函数在主线程上执行。*
*这是为了确保在 Swift 的并发编程中遵循特定的并发模型。
具体来说，@MainActor 是 Swift Concurrency 中的一部分，引入了 async/await 等新的并发编程特性。
它的目的是将代码标记为在主线程上执行，以确保操作 UI 或其他需要在主线程上执行的任务时不会发生线程不安全的情况。*
```swift
@MainActor
func updateUI() {
    // 在主线程上执行的代码
    // 可以直接操作 UI 元素
}
// 在异步函数中使用 @MainActor
func fetchData() async {
    let data = await fetchDataFromNetwork()
    
    // 在主线程上执行更新 UI 的操作
    updateUI()
}
```
### @objc：
*`@objc` 是一个 Objective-C 的修饰符，在 Swift 中用于标记特定的声明以便与 Objective-C 代码进行交互。它可以应用于类、协议、方法、属性等*

*在 Swift 中使用 `@objc` 有几个常见的用途：*

* 兼容 Objective-C 代码： 当你需要在 Swift 中使用 Objective-C 的框架、类、方法等时，你可能需要使用 `@objc` 修饰符。Objective-C 使用动态消息传递，而 Swift 使用静态派发，因此在 Swift 中调用 Objective-C 代码时，需要一些额外的信息来确保兼容性。

```swift
@objc class MySwiftClass: NSObject {
    @objc func mySwiftMethod() {
        // 方法实现
    }
}
```
* 在 Selector 中使用：在 Objective-C 中，方法的名称被表示为一个 `Selector` 对象。在 Swift 中，通过 `#selector` 语法可以引用一个 Objective-C 的方法。
```swift
@objc func myObjectiveCMethod() {
    // 方法实现
}
let selector = #selector(myObjectiveCMethod)
```
* 处理动态派发：`@objc` 也用于处理动态派发的情况，例如在 KVO（Key-Value Observing）中。
```swift
@objc dynamic var myProperty: Int = 0
```
  *需要注意的是：*
  使用 `@objc` 会使得相应的声明变得更加 Objective-C 友好，但也可能导致一些 Swift 特性无法使用。在新的 Swift 代码中，尽量避免不必要的 `@objc` 标记，以便充分利用 Swift 的静态类型检查和性能优势。
### @Binding：

*`@Binding` 是一个属性包装器（property wrapper），用于在 SwiftUI 中创建**双向绑定**（two-way binding）。它允许你在视图层次结构中传递数据，并确保这些数据的改变在整个视图层次结构中传播。*
*当你在一个视图中使用 `@Binding` 修饰符时，它表示该属性是一个引用到另一个视图层次结构中的数据的绑定。*
*当被绑定的数据发生变化时，相关的视图会自动更新，并且对绑定属性的修改也会反映到原始数据上。*
```swift
struct ContentView: View {
    @State private var textValue = ""

    var body: some View {
        VStack {
            Text("Entered Text: \(textValue)")
            TextField("Enter text", text: $textValue)
            Subview(bindingText: $textValue)
        }
    }
}

struct Subview: View {
    @Binding var bindingText: String

    var body: some View {
        TextField("Enter text in Subview", text: $bindingText)
    }
}
```
```swift
在上述例子中，ContentView 包含一个 TextField 和一个名为 Subview 的子视图。
通过在 Subview 中使用 @Binding，bindingText 成为与 ContentView 中的 $textValue 双向绑定的属性。
因此，当用户在 Subview 中输入文本时，ContentView 中的相应文本字段也会自动更新。

@Binding 是 SwiftUI 中用于实现数据流动和双向绑定的关键属性包装器之一，它使得构建响应式、动态的用户界面变得更加简单。
```
* *拓展知识*：**Vue中的数据绑定**
  **在Vue中，使用插值表达式实现单向绑定**

  ```vue
  <div>{{ message }}</div>
  
  这里message是模型中的数据，它会动态地显示在页面上。
  ```
    * 单向绑定是指数据从模型（或视图模型）流向视图（DOM）的过程。
    * 当模型的数据发生变化时，视图会相应地更新，但是反过来不成立。
    * 在Vue中，常见的单向绑定方式是使用插值表达式（`{{}}`）或者指令（例如`v-bind`）将模型中的数据绑定到视图上。

  **在Vue中，通常使用`v-model`指令来实现双向绑定**
  
  * 双向绑定是指数据在模型和视图之间进行双向同步；
  * 当模型中的数据发生变化时，视图会更新；
  * 同时，当用户在视图中输入数据时，模型中的数据也会随之更新；
  ```vue
  <input type="text" v-model="message">
  
  这里message是模型中的数据，用户在输入框中输入的值会动态地更新到模型中，并且模型中的数据变化也会反映到输入框中。
  ```
### @escaping：
*用于标记函数或闭包参数，表示它们在函数返回后仍然可以被调用；
*通常，当闭包作为参数传递给函数时，它默认是非逃逸的，即被保证在函数返回之前被执行；
*然而，如果该闭包可能在函数返回后执行，就需要使用 `@escaping` 修饰符
```swift
class MyViewController {
    
    var completionHandlers: [() -> Void] = []

    // 函数参数闭包标记为 @escaping
    func fetchData(completion: @escaping () -> Void) {
        // 模拟异步操作
        DispatchQueue.global().async {
            // 数据加载完成后执行闭包
            // 这里需要使用 self，因为在异步操作中，self 引用可能是弱引用
            completion()

            // 如果不标记 @escaping，编译器会产生错误：
            // Closure use of non-escaping parameter 'completion' may allow it to escape the function body
        }
    }

    // 函数参数闭包默认是非逃逸的
    func registerCompletionHandler(completion: () -> Void) {
        completionHandlers.append(completion)
    }

    // 函数参数闭包标记为 @escaping
    func executeCompletionHandlers() {
        for handler in completionHandlers {
            handler()
        }
        completionHandlers = []
    }
}
```
在上面的例子中，`fetchData(completion:)` 函数的参数闭包被标记为 `@escaping`，因为它在异步操作完成后被调用。而 `registerCompletionHandler(completion:)` 函数的参数闭包默认是非逃逸的，因为它被保存在数组中，不会在函数返回后被调用。 `executeCompletionHandlers()` 函数用于执行保存的闭包数组中的所有闭包。
### @inline

*用于标记函数，表示希望编译器尽可能地将函数内容内联到调用点，以提高性能。*

*在大多数情况下，Swift 编译器会自动进行内联优化，但使用 `@inline` 可以对编译器的行为进行更明确的指导。*

```swift
@inline(__always)
func add(_ a: Int, _ b: Int) -> Int {
    return a + b
}

let result = add(5, 7)
print(result)
```

在这个例子中，`add` 函数使用 `@inline(__always)`，表示开发者明确希望这个函数在调用点被始终内联。这样，编译器会尽可能地将 `add` 函数的内容嵌入到调用点，而不是生成一个函数调用。

请注意，使用 `@inline` 需要慎重，因为过度的内联可能导致代码体积膨胀，反而影响性能。编译器通常能够很好地处理内联，因此在大多数情况下，开发者无需手动添加 `@inline`。只有在对性能有特殊需求，且经过测试确认内联带来的性能提升时，才建议使用 `@inline`。

### @Main

*在Swift中，`@main` 是一个属性，用于标识应用程序的入口点，指定应用程序的主入口（main entry point）。*

*在Swift应用程序中，可以使用 `@main` 属性来指定一个遵循 `App` 协议的类型，以表示应用程序的主要入口。*

```swift
import SwiftUI

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

在这个示例中，MyApp 结构体采用 App 协议，表示它是一个应用程序。@main 属性标记了这个结构体，表明它是应用程序的主入口点。MyApp 结构体中的 body 属性返回一个 Scene，表示应用程序的主窗口中要显示的内容，这里是一个包含 ContentView 的 WindowGroup。
```

*总的来说，`@main` 属性简化了应用程序的入口点的定义，使得代码更加简洁和易读。*

*在应用程序启动时，系统将自动创建并运行标记为 `@main` 的结构体，从而启动应用程序。*

### @UIApplicationMain：

*是 Swift 中的一个标记性的属性，通常用于标识应用程序的主要入口点。在 Swift 中，它通常用于标记 AppDelegate 类，以指定应用程序的主要运行类。一个应用程序只能有一个使用 `@UIApplicationMain` 标记的类*

```swift
通过在 AppDelegate 类的声明前添加 `@UIApplicationMain` 属性，可以省略编写 `main.swift` 文件来启动应用程序

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // 应用程序启动时的初始化代码
        return true
    }
}

这样，编译器会自动生成 main.swift 文件，并在其中创建 UIApplication 对象和 AppDelegate 对象，从而启动应用程序。
```

### @State：

*是 SwiftUI 中的一个属性包装器（Property Wrapper），用于声明和管理视图的状态。`@State` 用于标识由视图持有和管理的可变状态，当状态发生改变时，视图会自动重新渲染以反映最新的状态。*

```swift
import SwiftUI

struct MyView: View {
    @State private var counter: Int = 0
    
    var body: some View {
        VStack {
            Text("Counter: \(counter)")
            Button("Increment") {
                counter += 1
            }
        }
    }
}

自动刷新： 当使用 @State 修饰的变量发生改变时，SwiftUI 会自动检测到变化，并重新渲染相关的视图。
仅在视图内有效： @State 用于管理视图内的状态，而不是应用程序的整体状态。每个使用 @State 的视图都有其自己的状态，这使得每个视图的状态都是独立的。
不保留历史值： @State 修饰的变量不保留历史值。当视图重新创建时，@State 变量会被重置为其初始值。
```
总的来说，`@State` 是 SwiftUI 中用于处理视图状态的重要属性包装器，它使得状态管理更加简单和直观。

### @EnvironmentObject：

*是 SwiftUI 中的一个属性包装器（Property Wrapper），用于在视图之间传递和共享数据。它允许你在整个 SwiftUI 视图层次结构中传递一个共享的对象，并在需要的地方访问该对象的属性。*
```swift
import SwiftUI

// 定义一个共享的数据模型
class UserData: ObservableObject {
    @Published var username = "Guest"
}

// 在 @main 函数中设置环境对象
@main
struct MyApp: App {
    @StateObject private var userData = UserData()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(userData) // 在整个应用程序中共享 UserData
        }
    }
}

// 在视图中使用 @EnvironmentObject
struct ContentView: View {
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        VStack {
            Text("Welcome, \(userData.username)!")
            Button("Login") {
                userData.username = "User123"
            }
        }
    }
}

在上述示例中，UserData 是一个可观察的对象，通过 @Published 标记的属性可以自动发布变化。
在 MyApp 中，使用 @StateObject 修饰的 userData 被设置为环境对象，然后在 ContentView 中使用 @EnvironmentObject 来获取该环境对象。
这样，在整个应用程序中，无需手动传递 userData，所有使用 @EnvironmentObject 的视图都能访问到共享的 UserData 对象。
```
**主要用途和特点：**
* 传递共享数据： 通过使用 @EnvironmentObject，你可以在整个 SwiftUI 视图层次结构中传递一个共享的数据模型，而不必在每个视图中手动传递该数据。
* 全局访问： 通过在 SwiftUI 的 Environment 中存储对象，你可以在整个应用程序中提供对该对象的全局访问。
* 数据更新时刷新视图： 当通过 @EnvironmentObject 引用的对象发生更改时，相关视图会自动刷新以反映最新的数据。
* 典型用法是在 @main 函数中设置环境对象，以便在整个应用程序中共享。
### @Environment：
*在Swift中，`@Environment` 是一个属性包装器（property wrapper），用于访问环境值（Environment Values）。*
*环境值是一种在应用程序中传递数据的方式，通常用于在视图层次结构中传递全局设置或共享的数据。*
*`@Environment` 允许您在视图中声明需要从环境中获取的值，并使其在整个视图层次结构中自动传递。*
```swift
import SwiftUI

struct ContentView: View {
    // 定义一个环境值，用于存储用户的偏好设置
    @Environment(\.userDefaults) var userDefaults

    var body: some View {
        VStack {
            Text("User's Preferences:")
            Text("Theme: \(userDefaults.string(forKey: "theme") ?? "Default")")
        }
    }
}

// 在应用程序的其他地方设置偏好设置，例如在AppDelegate中
extension EnvironmentValues {
    var userDefaults: UserDefaults {
        get { self[UserDefaultsKey.self] }
        set { self[UserDefaultsKey.self] = newValue }
    }
}

struct UserDefaultsKey: EnvironmentKey {
    static let defaultValue: UserDefaults = .standard
}

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

在这个示例中，ContentView 结构体声明了一个 @Environment(\.userDefaults) 属性，该属性将从环境中获取用户偏好设置。
然后，在 extension EnvironmentValues 中，我们为 userDefaults 创建了一个环境键，并为其提供了默认值（在这里是 UserDefaults.standard）。
```
在应用程序的其他地方，例如在 `AppDelegate` 中，您可以设置用户的偏好设置，然后这些设置将在整个应用程序中自动传递给使用 `@Environment(\.userDefaults)` 的视图。这是一种方便的方式，使得全局设置和共享数据能够轻松地在整个视图层次结构中传递。
### @ObservedObject：
*是 SwiftUI 中的一个属性包装器，用于将一个对象标记为可观察的。当被 `@ObservedObject` 标记的对象发生变化时，相关视图将会被刷新以反映这些变化。通常情况下，`@ObservedObject` 用于关联可观察对象和视图，使得 SwiftUI 能够自动响应对象的变化并更新 UI。*

```swift
import SwiftUI
import Combine

// 定义一个可观察的对象
class MyViewModel: ObservableObject {
    @Published var data: String = "Initial Data"
}

// 使用 @ObservedObject 关联视图和可观察对象
struct MyView: View {
    @ObservedObject var viewModel = MyViewModel()
    
    var body: some View {
        VStack {
            Text("Data: \(viewModel.data)")
            Button("Update Data") {
                viewModel.data = "New Data"
            }
        }
    }
}

在上述示例中，MyViewModel 是一个实现了 ObservableObject 协议的类，其中使用 @Published 标记的 data 属性将被观察。
在 MyView 中，通过 @ObservedObject 关联了一个 MyViewModel 对象。
当按钮点击时，data 发生变化，观察 @ObservedObject 的视图将会自动刷新以反映最新的数据。
```
**主要用途和特点：**
* 可观察对象： 通过 `@ObservedObject` 标记的对象必须符合 `ObservableObject` 协议，这通常是一个具有可发布属性的类。
* 刷新视图： 当 `@ObservedObject` 标记的对象的可发布属性发生变化时，相关视图将会自动刷新以反映最新的数据。
* 局部订阅： `@ObservedObject` 用于局部的、在视图层次结构中的某个特定位置进行数据绑定，而 `@EnvironmentObject` 用于全局的、在整个应用程序范围内传递数据。

总的来说，`@ObservedObject` 是 SwiftUI 中用于观察对象变化并刷新视图的关键属性包装器。它通常用于将可观察对象与特定视图关联，以便在对象变化时更新相关 UI。
### @Published：
*是 Swift 中的属性包装器，通常用于标记可观察对象的属性。在 SwiftUI 中，`@Published` 通常与 `ObservableObject` 协议一起使用，以提供一种简单的方式来发布属性的变化，从而让相关视图能够及时地更新。需要`import Combine`*
```swift
import SwiftUI
import Combine
// 定义可观察对象
class MyViewModel: ObservableObject {
    @Published var data: String = "Initial Data"
}

// 使用 @ObservedObject 监听变化
struct MyView: View {
    @ObservedObject var viewModel = MyViewModel()
    
    var body: some View {
        VStack {
            Text("Data: \(viewModel.data)")
            Button("Update Data") {
                viewModel.data = "New Data"
            }
        }
    }
}

在上述示例中，MyViewModel 类实现了 ObservableObject 协议，并使用 @Published 标记了 data 属性。
在 MyView 中，通过 @ObservedObject 关联了一个 MyViewModel 对象。
当按钮点击时，data 的值发生变化，@Published 将自动发布通知，@ObservedObject 的视图将会自动刷新。
```
总的来说，`@Published` 是 SwiftUI 中用于简化可观察对象的属性变化通知的属性包装器。
它与 `ObservableObject` 协议一起使用，使得 SwiftUI 能够在数据发生变化时自动刷新相关的视图。
## @main和@UIApplicationMain的区别
`@main` 和 `@UIApplicationMain` 都是在Swift中用于标识应用程序入口的属性，但它们有一些不同之处：
1. **平台差异：**
   * `@main` 是Swift 5.3及更高版本引入的属性，用于iOS、macOS、tvOS等所有平台。它是一种通用的属性，用于标识应用程序的入口。
   - `@UIApplicationMain` 是在较早的Swift版本中引入的，主要用于iOS开发。它是在AppDelegate中标识应用程序的主入口。
2. **使用方式：**
   - `@main` 用于标识遵循 `App` 协议的类型，表示整个应用程序的入口。在该类型中，通过实现 `body` 属性来定义应用程序的场景（Scene）。
   - `@UIApplicationMain` 用于标识一个包含 `UIApplication` 子类的文件，该子类充当应用程序的代理并定义应用程序的入口点。在这种情况下，`main.swift` 文件是不必要的，因为入口点由 `@UIApplicationMain` 属性标识的类的 `main` 方法提供。
3. **Flexibility：**
   - `@main` 更加灵活，允许您使用 `App` 协议自定义应用程序的入口，使其适用于不同的场景和平台。
   - `@UIApplicationMain` 相对较死板，主要用于传统的iOS应用程序入口点的定义。
   综上所述，如果您在Swift 5.3及更高版本上进行跨平台开发，推荐使用 `@main`。如果您在较早的Swift版本上仅进行iOS开发，可以使用 `@UIApplicationMain`。在实践中，大多数新的Swift项目会选择使用 `@main`，因为它提供更大的灵活性，并且在未来的Swift版本中可能会成为标准的应用程序入口点标识方式。
### Swift中 Any 和 Anyobject的区别？
**Any:**

- `Any` 可以表示任何类型，包括值类型（如结构体和枚举）和引用类型（如类）。
- 使用 `Any` 可以存储任何类型的值，但在操作这些值时，你需要进行类型转换。
- `Any` 是一个协议（protocol），所有类型都实现了 `Any`。因此，可以使用 `Any` 来表示任何值，而不管是值类型还是引用类型。

```swift
var value: Any
value = 42
value = "Hello"
value = [1, 2, 3]

if let intValue = value as? Int {
    print("It's an Int: \(intValue)")
}
```
**AnyObject:**

- `AnyObject` 是一个协议（protocol），用于表示类类型（class types）。
- 只有类（class）可以遵循 `AnyObject` 协议，而值类型（value types）不能。
- 对于使用 `AnyObject` 存储的值，你可以直接调用类的方法和属性，而无需进行类型转换。

```swift
var object: AnyObject
object = NSString(string: "Hello, AnyObject!")

// 调用NSString的方法
let length = object.length
```
综上所述：
主要区别在于 `Any` 可以表示任何类型，而 `AnyObject` 仅表示类类型。
因此，当你需要处理混合类型的数据时，可以使用 `Any`。当你知道你要处理的是类对象时，可以使用 `AnyObject`。
在实践中，尽量避免使用 `Any` 和 `AnyObject`，而是使用具体的类型，因为这样有助于代码的可读性和类型安全。
## var body: some View  这里面的some是什么意思？
```swift
在 SwiftUI 中，some View 是一个不透明类型（opaque type）。
这是 Swift 5.1 引入的一项功能，用于简化泛型代码中的类型表达。
在 SwiftUI 中，some View 的主要作用是表示返回的视图类型是不透明的，即编译器知道它是一种 View 类型，但不需要具体指定是哪一种 View。
这使得 SwiftUI 的视图层次结构能够更加灵活，因为你可以在不暴露具体实现细节的情况下返回不同类型的视图。

struct MyView: View {
    var body: some View {
        Text("Hello, SwiftUI!")
    }
}

在这个例子中，some View 表示 body 属性返回的视图类型是不透明的，并且编译器知道它遵循 View 协议。
不透明类型的优势在于它允许隐藏具体的实现细节，这在复杂的视图层次结构中非常有用。
在编写 SwiftUI 代码时，你通常不需要知道具体的视图类型，只需要知道它们是 View 协议的实现即可。
```
## \#available 和 @available 在Swift中有什么区别？
*在Swift中，`#available` 和 `@available` 都用于处理平台和版本的可用性检查，但它们在语法上和用途上有一些不同。*
**`#available`：**
- `#available` 是一个条件编译指令，用于在编译时检查代码的可用性。
- 你可以使用 `#available` 来检查某个特定平台上是否可用某个特定版本的API，以便在编译时做出相应的决策。这在编写跨平台应用时很有用。
```swift
if #available(iOS 15, *) {
    // 使用 iOS 15 及以上版本的API
} else {
    // 使用 iOS 15 以下版本的备用代码
}
```
**`@available`：**
- `@available` 是一个属性包装器，用于在运行时检查代码的可用性。
- 你可以使用 `@available` 来标记特定的函数、类、结构体等，并指定它们在不同平台和版本上的可用性。这允许编译器在运行时检查代码的使用情况，并在不支持的平台或版本上引发警告或错误。
```swift
@available(iOS 15, *)
func myFunction() {
    // 只有在 iOS 15 及以上版本才可用
}
```
*总体来说*
`#available` 用于条件编译，而 `@available` 用于标记在运行时检查的实体。在实际编码中，它们经常一起使用，以确保代码在编译和运行时都考虑到平台和版本的差异。
## extension 在Swift中什么意思？怎么使用？
*类似于OC中的分类*
允许你在不修改原始类型定义的情况下，向已有的类（Class）、结构体（Struct）、枚举（enum）或协议（Protocol）添加新的功能。
`extension` 可以用于添加新的计算属性、方法、初始化方法、下标等。

**扩展添加新方法：**
```swift
extension Double {
    func square() -> Double {
        return self * self
    }
}

let number = 4.0
let squared = number.square()  // 结果为 16.0
```
**扩展添加新计算属性：**

```swift
extension Int {
    var squared: Int {
        return self * self
    }
}

let num = 5
let squaredNum = num.squared  // 结果为 25
```

**扩展添加新初始化方法：**

```swift
extension String {
    init(repeating: String, count: Int) {
        self = String(repeating: repeating, count: count)
    }
}

let repeatedString = String(repeating: "Hello", count: 3)
// 结果为 "HelloHelloHello"
```

**扩展实现协议：**

```swift
protocol Describable {
    var description: String { get }
}

extension Double: Describable {
    var description: String {
        return "Value: \(self)"
    }
}

let value: Double = 3.14
print(value.description)  // 输出 "Value: 3.14"
```
**请注意，`extension` 中不能添加存储属性，只能添加计算属性。**

## 在Swift中，有两种类型不允许定义存储属性：

* **协议（Protocol）：** 协议本身不能包含存储属性。协议可以定义计算属性，以及方法、下标等，但它不支持直接定义存储属性。**和OC一致**
```
protocol MyProtocol {
    // 不允许在协议中定义存储属性
    // var myProperty: Int { get set } // 错误的示例

    // 可以定义计算属性
    var myComputedProperty: Int { get }
}
```

* **扩展（Extension）中的存储属性：** 在使用扩展为现有类型添加新功能时，不允许添加存储属性。扩展只能添加计算属性，而不能添加存储属性。**和OC一致**

```
extension String {
    // 不允许在扩展中添加存储属性
    // var myProperty: Int // 错误的示例

    // 可以添加计算属性
    var length: Int {
        return count
    }
}
```
## Swift的初始化方法
*在Swift中，初始化方法是用于创建并初始化实例的特殊方法。*
*Swift的初始化方法具有灵活性，可以包含多个参数、默认值、可选值，以及各种初始化阶段的操作。*
*以下是一些关于Swift初始化方法的重要概念：*
* **指定初始化方法（Designated Initializer）：**指定初始化方法是一个类中的主要初始化方法，用于初始化类的所有存储属性，并最终调用父类的初始化方法：

```swift
class MyClass {
    var property: Int
    
    init(property: Int) {
        self.property = property
    }
}
```
*  **便利初始化方法（Convenience Initializer）：**便利初始化方法是一个辅助方法，用于在指定初始化方法内部调用其他初始化方法，提供更多的初始化选项。
```swift
class MyClass {
    var property: Int
    
    init(property: Int) {
        self.property = property
    }
    
    convenience init() {
        self.init(property: 0)
    }
}
```
* **初始化参数的默认值：**初始化方法可以为参数提供默认值，使得在创建实例时可以选择性地省略某些参数。

```swift
class Person {
    var name: String
    var age: Int
    
    init(name: String, age: Int = 25) {
        self.name = name
        self.age = age
    }
}
```
*  **可选初始化方法（Failable Initializer）：**可选初始化方法允许初始化过程失败，返回一个可选值（初始化失败返回`nil`）。

```swift
class MyObject {
    var value: Int
    
    init?(value: Int) {
        guard value >= 0 else {
            return nil
        }
        self.value = value
    }
}
```
## Swift单例的写法和用法
```swift
class MySingleton {
    // 静态常量，用于保存唯一实例
    static let shared = MySingleton()

    // 私有构造函数，确保只能通过.shared创建实例
    private init() {
        // 初始化代码
    }

    // 其他方法和属性
    func doSomething() {
        // 实现功能
    }
}
```
```swift
let myInstance = MySingleton.shared
myInstance.doSomething()

这确保了在应用程序中只存在一个MySingleton实例，且可以在任何地方通过.shared访问它。
```
## Swift网络请求
### 1、URLSession（原生的工具）
```swift
import Foundation
// 定义请求的 URL
let url = URL(string: "https://example.com/api")!
// 创建请求对象
var request = URLRequest(url: url)
request.httpMethod = "POST"
// 添加自定义的 header 信息
request.allHTTPHeaderFields = [
    "Content-Type": "application/json",
    "Authorization": "Bearer YourAccessToken"
]
// 添加需要发送的数据，例如 JSON 数据
let jsonData = """
{
    "key1": "value1",
    "key2": "value2"
}
""".data(using: .utf8)
request.httpBody = jsonData
// 创建 URLSession 对象
let session = URLSession.shared
// 发送请求
let task = session.dataTask(with: request) { (data, response, error) in
    // 处理响应
    if let error = error {
        print("Error: \(error)")
    } else if let data = data {
        // 处理返回的数据
        let responseString = String(data: data, encoding: .utf8)
        print("Response: \(responseString ?? "")")
    }
}
// 启动任务
task.resume()
```
**需要特别指出的：**

*发送请求*

* 一般的请求

```swift
let url = "https://example.com/api"
// 这里的URL可以为String类型，框架可以接受URLRequest类型和String
let task = session.dataTask(with: url) { (data, response, error) in
  // TODO
}
```

```swift
import Foundation
// 如果不配置httpMethod（不创建URLRequest），则默认为httpMethod.GET方法 
// 定义请求的 URL
let url = URL(string: "https://example.com/api")!
// 创建 URLSession 对象
let session = URLSession.shared
// 发送请求
let task = session.dataTask(with: url) { (data, response, error) in
    // 处理响应
    if let error = error {
        print("Error: \(error)")
    } else if let data = data {
        // 处理返回的数据
        let responseString = String(data: data, encoding: .utf8)
        print("Response: \(responseString ?? "")")
    }
}
// 启动任务
task.resume()
```
* 数据下载

```swift
let task = session.downloadTask(with: request) { (data, response, error) in
	// TODO
}
```
* 数据上载

```swift
let task = session.uploadTask(with: request) { (data, response, error) in
	// TODO
}
```

### 2、Alamofire

```Ruby
pod 'Alamofire'
```

```swift
import Alamofire

// 定义请求的 URL
let url = "https://example.com/api"

// 发送 GET 请求
AF.request(url, method: .get).responseJSON { response in
    switch respo`nse.result {
    case .success(let data):
        print("Response JSON: \(data)")
    case .failure(let error):
        print("Error: \(error)")
    }
}
```
### 3、Moya（基于Alamofire的二次封装）

```ruby
pod 'Moya'
```

```swift
import Moya

// 将你的 API 定义为一个枚举
enum MyAPIService {
    case getPosts
}

// 遵循 TargetType 协议以提供关于你的 API 的详细信息
extension MyAPIService: TargetType {
    var baseURL: URL {
        return URL(string: "https://jsonplaceholder.typicode.com")!
    }

    var path: String {
        switch self {
        case .getPosts:
            return "/posts"
        }
    }

    var method: Method {
        return .get
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        return .requestPlain
    }

    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
}

// 使用你的 API 服务创建一个 Moya 提供者
let provider = MoyaProvider<MyAPIService>()

// 发送网络请求
provider.request(.getPosts) { result in
    switch result {
    case .success(let response):
        do {
            // 使用你喜欢的 JSON 解析方法解析响应数据
            let posts = try JSONDecoder().decode([Post].self, from: response.data)
            print(posts)
        } catch {
            print("解码响应数据时出错：\(error)")
        }
    case .failure(let error):
        print("网络请求失败：\(error)")
    }
}
```
## Swift的Json数据解析框架
### 1、Codable 协议（原生.简洁.官方推荐首选）
定义你的数据模型➕遵循 `Codable` 协议➕使用 `JSONDecoder` 来解码 JSON 数据
```swift
struct Post: Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

do {
    let jsonData = // Your JSON data
    let post = try JSONDecoder().decode(Post.self, from: jsonData)
    print(post)
} catch {
    print("Error decoding JSON: \(error)")
}
```
### 2、SwiftyJSON（第三方.流行）
更灵活➕链式语法
```swift
import SwiftyJSON

let json = // Your JSON data
let jsonObject = try? JSON(data: json)

// Accessing values
let title = jsonObject?["title"].stringValue
let userId = jsonObject?["userId"].intValue
```
### 3、ObjectMapper（第三方.常用）
对象到 ==>JSON 和 JSON  ==>对象的映射功能
```swift
import ObjectMapper

class Post: Mappable {
    var userId: Int?
    var id: Int?
    var title: String?
    var body: String?

    required init?(map: Map) {}

    func mapping(map: Map) {
        userId <- map["userId"]
        id <- map["id"]
        title <- map["title"]
        body <- map["body"]
    }
}

let post = Mapper<Post>().map(JSONString: jsonString)
```
