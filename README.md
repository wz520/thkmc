# THKMC - 东方STG专用键盘映射修改工具

THKMC(TouHou Keyboard Mapping Changer) 是一个为东方STG量身定做的键盘映射修改工具。通过直接修改东方STG游戏主程序文件中与键盘映射相关的代码，实现自定义游戏键位。

本软件会直接修改 EXE 文件。修改后的文件可能会被某些<del>把不认识的都当病毒处理的</del>杀毒软件报毒。您可以添加信任，或者放弃使用本软件及其生成的文件。

## 文档

* <https://wz520.github.io/thkmc/help.html>

## 如何运行

本程序使用 AutoHotkey 语言编写，可以直接使用 AutoHotkey 1.1.25.01 或更高版本的解释器运行。

假设你已经把本仓库的代码下载到了你机器上。

1. 点击 [此处](https://autohotkey.com/) 进入 AutoHotkey 的官网。
2. 点击中间绿色的 `Download`。
3. 点击左上方蓝色的 `Download AutoHotkey Installer`。开始下载最新版本的 AutoHotkey 安装包。
4. 运行安装包。其中在选择默认的解释器版本这一步请选择 `ANSI 32-bit` 或者 `Unicode 32-bit`。目前本程序暂时还不能在 64-bit 的解释器上运行。
5. 安装 AutoHotkey 完成后，双击本仓库里的 `thkmc.ahk` 即可启动本程序。

## 如何编译

* [AutoHotkey 1.1.25.01+]
	+ 按照上面 `如何运行` 所描述的步骤安装即可。

* [Compile_AHK 0.9.1.3](https://autohotkey.com/board/topic/21189-compile-ahk-ii-for-those-who-compile/)
	+ 安装完成后。右键点击 `thkmc.ahk`，选择 `Compile with Options`，然后直接点击左下角的 `Compile` 按钮即可。

* [MPRESS 2.19（Optional）](http://www.matcode.com/mpress.htm)
	+ 如果不安装 MPRESS，编译后的 EXE 文件大约有 1MB 左右。
	+ 如果安装 MPRESS，使用上述步骤编译完本脚本后会自动调用 MPRESS 进行压缩。编译后的 EXE 文件会缩小到不到 400KB 。但可能会加大被杀毒软件误报的几率。

## 编译版＆更新历史

* <https://github.com/wz520/thkmc/releases>

### 我编写的其他小程序

* <https://www.zybuluo.com/wz520/note/15842>

[AutoHotkey 1.1.25.01+]: https://autohotkey.com/
