

## 系统

Windows 10 家庭中文版

## Flutter SDK

下载地址：https://flutterchina.club/setup-windows/

### Flutter SDKZ安装

1. 配置镜像，添加环境变量。或者翻墙。（翻墙应该就不需要配镜像环境变量）
2. 下载[最新安装包](https://flutter.dev/docs/development/tools/sdk/releases#windows)，解压到你的目标安装目录，如d:\dev\flutter。
3. 更新环境变量，在path条目追加flutter\bin的全路径。
4. 命令行运行flutter监测是否安装成功。
5. 运行 flutter doctor查看是其他需要安装的任何依赖项，让装android studio...

```
配置镜像需要添加的环境变量：
PUB_HOSTED_URL=https://pub.flutter-io.cn
FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn
```

其实这个时候，在vs code里安装flutter插件，然后flutter create fultter_app就可以创建项目，但是没有虚拟机项目运行不起来。哎！老老实实去装android studio。

按官网的步骤来就行，基本没有什么坑。就是不知道为什么加到我的用户变量里不起作用，就只好加到系统变量里了。

## Android Studio/SDK

https://developer.android.google.cn/studio?hl=zh-cn

### android studio/SDK安装

1. 一路next，默认选项，安装完成后首次启动，提示 Unable to access Android SDK add-on list，单击cancel退出后面会下载SDK。
2. next让选择Install type，选custom可以自定义模式（主题样式之类的），我选的standard。
3. next进入SDK Components Setup，确认都勾选上，选择Android SDK安装路径，next进行安装下载，下载完后点finish。
4. 然后就可以使用啦。

### flutter插件安装和项目创建

1. 如果android studio创建/导入项目页有configure选项，选plugins安装flutter插件。如果直接进入了项目界面就双击shift，搜索plugins安装flutter插件。
2. 创建flutter项目，configure the new Flutter application，Flutter SDK path自动识别/手动选择，如果没装好的不建议在这里点击 Install SDK会很慢的。
3. 最后点击finish，开始创建项目，可能会卡在这里很久提示正在创建。此时打开项目目录查看是否有lib/main.dart，如果有表示已经创建好了。退出android studio重新进入即可。

### 创建虚拟机

1. 点击 Tools >  AVD manager，或右上角图标（手机+ android logo）。
2. 点击 create virtual device，选择 phone > Nexs 6p，下载/选择android版本，next 填写AVD name，finish。
3. 回到Your Virtual Devices列表，点击右侧绿色箭头运行虚拟机。

### flutter项目运行

1. AVD manager中运行虚拟机。
2. 选择虚拟机，点击右上角绿色的运行按钮。
3. 虚拟机上出现flutter项目，表示成功运行起来啦。

## 踩坑

### 虚拟机点击运行没反应

可能是Intel x86 Emulator Accelerator(HAXM)没有装好。

1. sdk manager > sdk tools，查看列表中Intel x86 Emulator... 安装状态，如果没装好下一步。
2. 勾选Intel x86 Emulator... ，点击apply，安装成功后重新启动android studio再次运行虚拟机应该就可以了。

### Intel x86 Emulator Accelerator(HAXM)安装失败

报错信息如下：（可能前面android studio/SDK安装就保错了，只是没注意）

```
This computer does not support Intel Virtualization Technology (VT-x) or it is being exclusively used by Hyper-V. HAXM cannot be installed. 
Please ensure Hyper-V is disabled in Windows Features, or refer to the Intel HAXM documentation for more information.
```

因为我的电脑装了docker，现在需要关闭Hyper-V。

方法1：计算机 > 管理 > 服务和应用程序 > 服务，禁用所有Hyper-V开头的服务。✖ 无效

方法2：设置 > 启用或关闭windows功能，取消勾选Hyper-v。 ✖ 无效

方法3：命令行输入 bcdedit /set hypervisorlaunchtype off。✔ 成功，但是可能会影响Doker。

成功关闭后，再安装Intel x86 Emulator Accelerator(HAXM)就成功啦。

### Please define ANDROID_SDK_ROOT

装好了Intel x86 Emulator Accelerator(HAXM)，运行虚拟机，报错如下：

```
Emulator: Process finished with exit code 1
Emulator: PANIC: Cannot find AVD system path. Please define ANDROID_SDK_ROOT
```

添加环境变量

```
ANDROID_SDK_HOME=d:\dev\android_adv	 手动新建的目录，存放adv相关文件
ANDROID_HOME=d:\dev\android_sdk       Android SDK安装路径
```

重新创建虚拟机，应该就能成功了。

### running gradle task 'assembleDebug'...

运行flutter应用，长时间卡在 running gradle task 'assembleDebug'

原因：gradle的仓库是国外的google()、jcenter()，可改用阿里云的镜像地址。修改内容如下：

```
项目目录 android/build.gradle
buildscript {
    ext.kotlin_version = '1.3.50'
    repositories {
        // google()  改动1
        // jcenter()
        maven { url 'https://maven.aliyun.com/repository/google' }
        maven { url 'https://maven.aliyun.com/repository/jcenter' }
        maven { url 'http://maven.aliyun.com/nexus/content/groups/public' }
    }

    dependencies {
        classpath 'com.android.tools.build:gradle:3.5.0'
        classpath "org.jetbrains.kotlin:kotlin-gradle-plugin:$kotlin_version"
    }
}

allprojects {
    repositories {
        // google()  改动2
        // jcenter()
        maven { url 'https://maven.aliyun.com/repository/google' }
        maven { url 'https://maven.aliyun.com/repository/jcenter' }
        maven { url 'http://maven.aliyun.com/nexus/content/groups/public' }
    }
}

flutter安装目录 D:\dev\flutter\packages\flutter_tools\gradle
buildscript {
    repositories {
        // 这里做了修改，使用国内阿里的代理
        // google()
        // jcenter()
        maven { url 'https://maven.aliyun.com/repository/google' }
        maven { url 'https://maven.aliyun.com/repository/jcenter' }
        maven { url 'http://maven.aliyun.com/nexus/content/groups/public' }
    }
    dependencies {
        classpath 'com.android.tools.build:gradle:3.5.0'
    }
}
```

按上面的配置好了，重新运行，还是很长时间。终止后再重新运行，再终止在重新运行，第三次终于可以啦。Σ( ° △ °|||)︴

### Android license status unknown

运行flutter doctor，提示Android license status unknown，具体如下：

```
Android toolchain - develop for Android devices (Android SDK version 29.0.3)
X Android license status unknown.
  Try re-installing or updating your Android SDK Manager.
  See https://developer.android.com/studio/#downloads or visit
      https://flutter.dev/setup/#android-setup for detailed instructions.
```

运行 flutter doctor --android-licenses，报错如下：

```
Android sdkmanager tool not found (C:\Users\Zheny\AppData\Local\Android\Sdk\tools\bin\sdkmanager).
Try re-installing or updating your Android SDK,
visit https://flutter.dev/setup/#android-setup for detailed instructions.
```

解决方法：打开android studio，双击shift，搜索sdk manager，切换tab至SDK Tools，右下方复选框 取消勾选 Hide Obsolete packages，然后安装列表中的Android SDK Tools（虽然它即将或已经废除）。完成后，重新打开命令行，运行 flutter doctor --android-licenses -v，一路y即可完成证书安装。再运行flutter doctor，就不会再由这个错误提示了。

## 总结

Android Studio对windows用户真心不怎么友好。搞了一晚上才装好。另外，我没有装java环境，我觉得flutter项目用不到。目前可以正常运行。