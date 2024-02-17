

# Swift 经验

[toc]

## 一些相关文献

[Swift自动布局SnapKit的详细使用介绍](https://www.jianshu.com/p/2bad53a2a180)

[SwiftUI - 与UIKit集成](https://www.jianshu.com/p/fbc920c11b0d)

[SwiftUI -SwiftUI 和 UIKit 的相互引用](https://juejin.cn/post/7153879743107399710)

[JXSegmentedView](https://github.com/pujiaxin33/JXSegmentedView)

## Swift视频教学

[BBCo - iOS开发入门教程 SwiftUI 微博App项目实战 Lesson 1 (零基础学习Swift编程)](https://www.youtube.com/watch?v=5n0qoRZ8gXA&list=PLotizAeaV0nPM7a7Yy3Uyh4rkgBvT9N_H&index=2)

## 为什么在swift里面新建一个view要用struct，而不用class

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

* 调用栈信息：

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

## UIHostingController 和一般的控制器，有何特别之处？

* SwiftUI 视图的承载：`UIHostingController` 的主要功能是将 SwiftUI 的视图嵌入到 UIKit 中。你可以通过在 `UIHostingController` 中设置一个 SwiftUI 视图，将 SwiftUI 和 UIKit 进行无缝集成。

 ```swift
 let swiftUIView = MySwiftUIView()
 let hostingController = UIHostingController(rootView: swiftUIView)
 ```

* 动态视图更新：由于 SwiftUI 的特性，`UIHostingController` 能够自动响应 SwiftUI 视图状态的变化，从而动态地更新其包含的 UIKit 视图。这使得在 SwiftUI 中定义的视图能够自动保持同步，而无需手动刷新

* 声明式 UI 编程： 使用 `UIHostingController` 时，你可以继续使用 SwiftUI 的声明式 UI 编程范式，而不是传统的命令式 UI 编程方式。这使得 UI 的构建和维护更加简单和直观。

* 跨平台兼容性：`UIHostingController` 的使用不仅限于 iOS 平台，你也可以在 macOS 上使用 `NSHostingController`，在 watchOS 上使用 `WKHostingController`，以实现在不同平台上的 SwiftUI 视图承载。

*总体而言*

`UIHostingController` 提供了一种方便的方式，将 SwiftUI 和 UIKit 结合使用，使得你可以逐步采用 SwiftUI，而无需立即完全迁移到 SwiftUI 构建整个应用程序。这种渐进性迁移对于那些已有的 UIKit 项目而言是非常有帮助的。

## 属性修饰符（Property Attributes）≠ 属性包装器（Property Wrappers）

属性修饰符用于修饰属性的行为，而属性包装器用于提供属性的包装和自定义行为。

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

**@frozen:** 用于标记枚举声明，表示该枚举是冻结的，即其成员在编译时是不可改变的。这有助于编译器进行一些优化。

```swift
@frozen enum Status {
    case success
    case failure(errorCode: Int)
}
```

在这个例子中，`Status` 是一个枚举，通过 `@frozen` 标记表示它是冻结的。这意味着在后续的代码中不能再添加新的枚举成员，使得编译器可以进行一些优化。

**@usableFromInline:** 用于标记属性、方法、类型等，表示它们可以在模块内的其他地方内联使用，但对模块外不可见。

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

**@discardableResult:** 用于标记函数或方法，表示其返回值可以被忽略而不会触发编译器警告。**仅仅是抑制警告**

```swift
@discardableResult
func processResult() -> Int {
    // ...
}
```

**@available:** 用于标记函数、方法、属性等，指示它们的可用性和版本要求。

```swift
@available(iOS 14.0, *)
func newAPI() {
    // ...
}
```

**@MainActor：**是一个属性包装器（property wrapper），它用于标记特定的属性、方法或函数在主线程上执行。

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

**@objc：**`@objc` 是一个 Objective-C 的修饰符，在 Swift 中用于标记特定的声明以便与 Objective-C 代码进行交互。它可以应用于类、协议、方法、属性等。

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

**@Binding：**`@Binding` 是一个属性包装器（property wrapper），用于在 SwiftUI 中创建双向绑定（two-way binding）。它允许你在视图层次结构中传递数据，并确保这些数据的改变在整个视图层次结构中传播。

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

**@escaping：**用于标记函数或闭包参数，表示它们在函数返回后仍然可以被调用。

*通常，当闭包作为参数传递给函数时，它默认是非逃逸的，即被保证在函数返回之前被执行。*

*然而，如果该闭包可能在函数返回后执行，就需要使用 `@escaping` 修饰符。*

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

**@inline：** 用于标记函数，表示希望编译器尽可能地将函数内容内联到调用点，以提高性能。

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

**@UIApplicationMain：**是 Swift 中的一个标记性的属性，通常用于标识应用程序的主要入口点。在 Swift 中，它通常用于标记 AppDelegate 类，以指定应用程序的主要运行类。一个应用程序只能有一个使用 `@UIApplicationMain` 标记的类

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

**@State：**是 SwiftUI 中的一个属性包装器（Property Wrapper），用于声明和管理视图的状态。`@State` 用于标识由视图持有和管理的可变状态，当状态发生改变时，视图会自动重新渲染以反映最新的状态。

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

**@EnvironmentObject：**是 SwiftUI 中的一个属性包装器（Property Wrapper），用于在视图之间传递和共享数据。它允许你在整个 SwiftUI 视图层次结构中传递一个共享的对象，并在需要的地方访问该对象的属性。

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

**@ObservedObject：**是 SwiftUI 中的一个属性包装器，用于将一个对象标记为可观察的。当被 `@ObservedObject` 标记的对象发生变化时，相关视图将会被刷新以反映这些变化。通常情况下，`@ObservedObject` 用于关联可观察对象和视图，使得 SwiftUI 能够自动响应对象的变化并更新 UI。

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

### 主要用途和特点：

* 可观察对象： 通过 `@ObservedObject` 标记的对象必须符合 `ObservableObject` 协议，这通常是一个具有可发布属性的类。
* 刷新视图： 当 `@ObservedObject` 标记的对象的可发布属性发生变化时，相关视图将会自动刷新以反映最新的数据。
* 局部订阅： `@ObservedObject` 用于局部的、在视图层次结构中的某个特定位置进行数据绑定，而 `@EnvironmentObject` 用于全局的、在整个应用程序范围内传递数据。

总的来说，`@ObservedObject` 是 SwiftUI 中用于观察对象变化并刷新视图的关键属性包装器。它通常用于将可观察对象与特定视图关联，以便在对象变化时更新相关 UI。

**@Published：**是 Swift 中的属性包装器，通常用于标记可观察对象的属性。在 SwiftUI 中，`@Published` 通常与 `ObservableObject` 协议一起使用，以提供一种简单的方式来发布属性的变化，从而让相关视图能够及时地更新。需要`import Combine`

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

## \#available 和 @available 在swift中有什么区别？

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

## extension 在swift中什么意思？怎么使用？

*类似于OC中的分类*

允许你在不修改原始类型定义的情况下，向已有的类、结构体、枚举或协议添加新的功能。

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









