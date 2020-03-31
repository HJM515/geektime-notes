## 01 Fultter工程环境搭建

内容较长，单独放到了一个文件 “Flutter环境搭建踩坑之旅”。Android Studio的windows安装有大量的坑。

## 02 Dart语言概述

2011年，由 Google 发布。Dart 的最初定位也是一种运行在浏览器中的脚本语言。为了推广 Dart，Google 在 Chrome 浏览器内置了 Dart VM，可以直接高效地运行 Dart 代码，同时提供一套将 Dart 代码编译成 JS 代码的转换工具。

2015年，Dart VM 引擎从 Chrome 移除。同年5月，Google 推出以 Dart 作为开发语言的移动开发框架Flutter。

### JIT & AOT

Dart 同时支持 JIT（Just In Time，即时编译）和 AOT（Ahead of Time，运行前编译）。

- JIT，开发周期中可以动态下发和执行代码，开发测试效率高。如热重载就基于此。
- AOT，发布期使用AOT直接生成二进制代码，运行速度快、执行性能好。

### 内存分配 & 垃圾回收

Dart VM内存分配策略，创建对象只在堆上移动指针，内存增长时钟是线性的。

Dart 并发通过 Isolate实现。Isolate类似于线程但不共享内存，是独立运行的worker。可实现无锁快速分配。

Dart 垃圾回收采用多生代算法。新生代采用 半空间 机制，只操作少量 活跃 对象。适合Flutter框架中大量Widget销毁重建的场景。

### 单线程模型

Dart 中没有现成，只有 Isolate。Isolate 像几个运行在不同进程中的 worker，通过事件循环在事件队列上传递消息通信。

### 无需单独的声明式布局语言

Flutter 中，界面布局直接通过Dart编码定义。❓❓ 没看懂这个特点

## 03 跨平台方案发展

### Web容器时代

基于 web 相关技术，通过浏览器组件来实现界面及功能，典型框架包括 Cordova、Ionic 和微信小程序。

原生应用内嵌浏览器控件 WebView，进行 H5 页面渲染。通过 JS Bridge 将部分原生系统能力暴露给 H5 ，如定位、音视频、相册/相机、传感器...

- 优势：生态繁荣、开发体验友好、生产效率高、跨平台兼容性强。
- 问题：Web 容器过于笨重，以至于性能和体验都达不到与原生同样的水准。

### 泛Web容器时代

采用类 web 标准进行开发，运行时把绘制和渲染交由原生系统接管的技术，代表框架React Native、Weex、Virtual View。

采用JS开发，通过Bridge连接原生渲染组件和系统能力。控件渲染由原生组件完成简化渲染过程同时保证良好的渲染性能。

- 优势：解决了web容器带来的性能问题。
- 问题：Follow Native的思维方式，框架需要大量平台相关的逻辑，不同平台原生控件渲染能力差异导致大量bug。

### 自绘引擎时代

自带渲染引擎，客户端仅提供一块画布即可获得从业务逻辑到功能呈现的多端高度一致的渲染体验。代表框架Flutter。

不依赖于原生控件，自绘组件完成系统绘制和事件。通过平台插件获取原生系统能力。

代表Fultter：

- 渲染引擎，依靠跨平台的Skia图形库实现，Skia引擎将使用Dart构建的抽象视图结构数据加工成GPU数据，叫有OpenGL最终提供给GPU渲染。

- Dart语言同时支持JIT和AOP，保证开发效率同时，提升执行效率。

### 跨平台方案对比

<img src="img/1585475269(1).jpg">

### Flutter动态化问题

动态化，是指代码逻辑放在云端，以下发的法师更新应用程序原本功能的方式，是不依赖于程序安装包的更新，就能进行动态实时更新页面的技术。可以理解成游戏下载新的关卡。

Flutter确实不支持动态化，根据具体需求有两个解法：

1. 把你们需要动态变更的模块全部组件化，修改前后端通信协议让服务器可以动态的配置页面模块。
2. 业界已经有一些通过JSCore实现Flutter动态布局的实践。

## 04 Flutter如何运行在原生系统

Flutter 是构建 Google 物联网操作系统 Fuchsia 的 SDK，主打跨平台、高保真、高性能

### Flutter绘制原理

1. UI线程使用Dart构建视图结构数据；
2. 这些数据在GPU线程进行图层合成；
3. 交给Skia引擎加工成GPU数据；
4. 通过OpenGL最终提供给GPU渲染。

OpenGL是skia的渲染后端，主要用于GPU硬件加速。

### Skia

一款用 C++ 开发的、性能彪悍的 2D 图像（图形转换、文字渲染、位图渲染）绘制引擎。

Skia 保证了同一套代码调用在 Android 和 iOS 平台上的渲染效果是完全一致的。

### Flutter架构

从下到上分为三层，Embedder、Engine、Framework。

- Embedder 是操作系统适配层，实现了渲染 Surface 设置、线程设置，以及平台插件等平台相关特性的适配。
- Engine 主要包含 Skia、Dart、Text，实现 Flutter 的渲染引擎、文字排版、事件处理和Dart运行是等功能。
- Framework 是一个用 Dart 实现的 UI SDK，包含动画、图形绘制和手势识别等功能。根据 Material 和 Cupertino 两种设计风格封装了一套UI组件库。

### 界面渲染过程

页面的界面元素widget组成控件树。每个空间创建不同类型的渲染对象，组成渲染对象树。

渲染对象树的展示过程：

1. 布局：深度优先机制遍历，决定渲染对象位置和尺寸；布局边界机制控制重新布局影响范围。
2. 绘制：布局后按深度优选机制，将所有渲染对象绘制到不同的图层；重绘边界机制避免无关内容置于统一图层引起不必要的重绘。
3. 合成：将所有图层根据大小、层级、透明度等规则计算最终显示效果，将相同的图层归类合并，简化渲染树。
4. 渲染：将合成后的几何图层数据交由Skia引擎加工成二维图像数据，最后由GPU渲染。



## 06 Dart基础语法与类型变量

Dart 中使用 var 定义变量时，表示类型是交由编译器推断决定的。在默认情况下，未初始化的变量的值都是 null。

Dart 是类型安全的语言，所有类型都是对象类型，继承自顶层类型 Object，一切变量的值都是类的实例。

### num、bool、String

num 数值类型，两种子类init 、double。基本运算符 + 、- 、* 、/、%、~/、<=、>=、==、abs()、round()。dart:math库提供了三角函数、指数、对数、平方根等高级函数。

bool 布尔类型，true false，都是编译时常量。不能使用 if (nonbooleanValue) 隐私类型转换判断，必须显示的比较，因为Dart是类型安全的。

String 字符串类型，可以使用${ express }在字符串中嵌入变量或表达式，如果只有一个标识符 {} 可省略。

### List、Map

对应于其他语言的数组和字典。

```dart
var arr1 = [1, 2, 3];
var arr2 = List.of(['h', 'j', 'm']); // 这写的有问题吧❓❓ 都是数组了还要去List.of一下
arr1.add('h'); // Error，Dart会根据上下文进行类型推荐List<int>，不能添加String 或 double等非init 类型数据
arr2.forEach((v) => print(v)); // 单个参数也不可省略括号
// 为语言清晰，可增加类型约束
var arr1 = <String>['h', 'j', 'm'];
var arr2 = new List<int>.of([1, 2, 3]);
arr2.add(499);
print(arr2 is List<int>); // true
```

```dart
var map1 = {"name": "Tom", 'sex': 'male'}; 
var map2 = new Map();
map2['name'] = 'Tom';
map2['sex'] = 'male';
map2.forEach((k,v) => print('${k}: ${v}'));
// 为语言清晰，可增加类型约束
var map1 = {'name': 'Tom','sex': 'male',};
var map2 = new Map();map2['name'] = 'Tom';map2['sex'] = 'male';
map2.forEach((k,v) => print('${k}: ${v}')); 
print(map2 is Map); // true
```

可以使用 List<num, String> 等使 List 支持多种类型内部元素，不建议使用 List<dynamic>。遍历集合时，可通过 is 判断可枚举类型，也可以通过 runtimeType 判断类型。

List 指定 length 后，默认数值都为null ，这是由于未初始化的变量都是 null特性，并且这时候可以在安全下标内进行赋值。但是不指定 length 的 List 则无法指定下标赋值，因为超出了下标边界。

### 常量

const，编译期常量。final，运行是常量。

```dart
const count = 2; // const 必须直接赋值一个字面量
var x = 20;
var y = 30;
final z = x / y; // final 可以赋值一个字面量 或变量 或公式，但是一旦赋值不能改变
```

## 07 函数、类、运算符

### 函数

函数也是对象，类型 Function。

```
bool isZero(int number) {
	return number == 0;
}
bool isZero(int number) => number == 0;
// 定义可选命名参数，增加默认值
void enable({bool bold, bool hidden = false}) => print();
// 定义可忽略参数
void enable(bool bold, [bool hidden = false], [bool lg]) => print();
```

### 类

