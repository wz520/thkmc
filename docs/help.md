# THKMC - 东方STG专用键盘映射修改工具

当前版本: `1.20`

## 功能

众所周知，ZUN 制作的 东方STG 从来就不自带更改键盘键位的功能。为此，各路大神都写过各种键盘映射工具，但大多是外挂式的。随着新版本的 Windows 对系统安全性的要求越来越高，这些外挂式的改键工具都可能存在兼容性问题。

THKMC(TouHou Keyboard Mapping Changer) 通过修改东方STG游戏主程序文件中与键盘映射相关的代码，实现自定义游戏键位。

东方STG获取键盘按键状态的方法有两种：`使用 DirectInput` 和 `不使用 DirectInput` 。
其中 `使用 DirectInput` 是通过调用 [IDirectInputDevice8::GetDeviceState()] 来获取键盘状态的；而不使用 `DirectInput` 则是使用 Win32 API 中的 [GetKeyboardState()]。

本程序 **只支持** 对使用 DirectInput 方式获取的按键映射进行更改。所以要求在游戏自带的 custom.exe 程序中不能勾选 “不使用 DirectInput 获取键盘输入”。若勾选的话使用本程序改键将没有任何效果。（不过一般不会有人去勾选吧，因为游戏默认的不勾选也能工作得很好）。

## 特点

相比较其他常见的外挂式通用键位修改工具，因为 THKMC 是为特定的EXE文件量身定制的，所以只要游戏版本正确且用户写的配置文件内容无问题，改键后通常不会有出错或者失效的现象发生。

本程序可修改的键位不仅包括在STG中用到的各种控制键（↑、↓、←、→、Z、X、C、SHIFT、CTRL、ESC等），还包括：

* 截图键（`Home`或`P`）
* `R`（ `ESC+R` 可以快速 RETRY）
* `D`（永夜抄 RESULT 画面会用到，可以将游戏纪录保存到文件中）
* 以及其他游戏中用到的一切键位。
	+  不过 Windows 窗口程序的通用键位是改不了的，比如 `Alt+Space` 打开系统菜单， `Alt+F4` 关闭窗口什么的，这是 Windows 管的，本工具无法对这些系统组合键进行重映射。

除此之外，还有这些优点：

* 对于同一个玩家来讲，改键位一般不是经常要干的事情。直接改 EXE 的方法可以做到一劳永逸，玩家运行游戏时无需再运行其他辅助工具。
* 修改 EXE 只需操作者拥有对该 EXE 文件的读取和写入权限，所以通常不会有因为用户权限或内存布局等原因而导致修改失败的问题发生。

当然缺点也很明显，就是不通用，除了下面 `支持的游戏版本` 中所列出的游戏的主程序文件外，不支持任何其他的文件。

* 另外，也不能为同一个功能映射多个按键，不过游戏本来就已经有多个映射的除外。
	+ 比如在几乎所有的东方STG游戏中 `小键盘8` 的作用和 `↑` 方向键 相同，属于一个功能有多个映射的例子，本程序可以分别将它们映射到不同的功能上。

## 支持的游戏版本

* 东方红魔乡 1.02h 日文原版
* 东方红魔乡 渔场汉化版（**主程序需脱壳**）
* 东方妖妖梦 1.00b 日文原版、渔场汉化版
* 东方永夜抄 1.00d 日文原版、渔场汉化版
* 东方文花帖 1.02a 日文原版
* 东方风神录 1.00a 日文原版、东方喝茶委员会汉化版
* 东方地灵殿 1.00a 日文原版
* 东方星莲船 1.00b 日文原版
* 东方文花帖DS 1.00a 日文原版
* 妖精大战争 ~ 东方三月精 1.00a 日文原版
* 东方神灵庙 1.00c 日文原版
* 东方辉针城 1.00b 日文原版、喵玉汉化版
* 弹幕天邪鬼 1.00a 日文原版、喵玉汉化版
* 东方绀珠传 1.00b 日文原版、喵玉汉化版
* 东方天空璋 1.00a 日文原版、喵玉汉化版
* 秘封噩梦日记 1.00a 日文原版
* 黄昏酒场 1.00a


**注意**：若有哪一作未提到支持汉化版，只是未测试而已，多数情况下只要游戏版本号相同应该也能支持

_对于其他打了非官方补丁的版本，本程序可能也能识别，但不保证能达到正确的修改效果。_

* 喵玉汉化版请选择原版的 exe（比如 th14.exe），而不是带 c 的 exe（比如 th14c.exe。那只是个启动器而已，而非游戏主程序）。
* **花映冢**由于比较复杂，所以暂时坑掉。
* <s>**地灵殿**目前其实是可以打补丁的，但是打了补丁也没用，原因在ZUN。请参见下面的 `常见问题`。</s> 从 1.20 版起已经全面支持。

## 使用方法

1. 启动 thkmc.exe 。初次启动界面如图所示。
	* ![主界面](https://i.loli.net/2018/11/25/5bfa78bb3914b.png)
	* **注意**：启动时若 thkmc.ini 文件不存在，会提示该文件已被自动生成。
2. 点击左上角的“编辑 thkmc.ini”，会使用默认程序（通常是`记事本`）打开 thkmc.ini。你可以根据自己的喜好更改键位。
	* ![编辑按钮](https://i.loli.net/2018/11/25/5bfa8276be20b.png)
	* 若你未修改过自动生成的 thkmc.ini 文件，则按照以下规则修改键位：
		+ ↑=W
		+ ↓=S
		+ ←=A
		+ →=D
		+ Z=J
		+ X=K
		+ C=L
		+ 左SHIFT=I
	* 若要改成其他键位请参考本程序源代码中的 [KeyNamesDX.ahk] 。
	* **举个栗子**：比如如果要将 `ESC` 键映射为 `` ` `` 键（即“反引号”键。通常位于主键盘数字 `1` 键的左边），则可以在 `LSHIFT=i` 下面插入一行 `ESC=GRAVE` 即可。
		+ 除了字母键外，thkmc.ini 文件中其他的按键都必须写键位名称，这需要使用者自行参考 [KeyNamesDX.ahk]，然后将其填入 INI 文件中。其中 `THKMC_KeyNamesDX["XXX"]` 中的 `XXX` 部分便是可以使用的键位名称。
		+ 比如该文件中有一行是：
		
				THKMC_KeyNamesDX["GRAVE"] := 0x29 ; accent grave `
			
		+ 右边的注释 ``accent grave ` `` 提示 `` ` `` 键的名称是 `GRAVE` 。所以将其填入 INI 文件中即可。
		+ 完整的 INI 编写说明可参考 [INI设置项说明] 。
3. 编辑好后**别忘了保存**哦。怎么保存文件相信大家都会所以这里就不赘述啦（
4. 点击上面的“打开程序并应用补丁”按钮。
	* ![打开程序并应用补丁](https://i.loli.net/2018/11/25/5bfa83b457d71.png)
5. 选择一个本程序支持的东方STG的主程序。具体支持哪些游戏主程序请参考上面的 [支持的游戏版本] 。
	* ![选择文件](https://i.loli.net/2018/11/25/5bfa8401a323b.png)
6. THKMC 会自动根据 thkmc.ini 里设置的键位修改程序，并覆盖原EXE，然后报告结果。
	* ![打补丁结果](https://i.loli.net/2018/11/25/5bfa84db41b1a.png)
		- {未指定} 就是INI文件中没有设置重映射，但是本游戏程序支持该键被重映射。比如说这个窗口里写了 `{未指定} F10`，就说明弹幕天邪鬼支持 `F10` 键（切换全屏/窗口） 被重映射，如果你想要改成比如 `F12`，你可以在INI文件里写 `F10=F12` ，那么以后按 `F12` 就可以切换全屏了。
		- 另外要注意，能被重映射的键位，不一定表示该键位一定有功能。比如 `D` 键，曾经在永夜抄里有作用，而后来的作品基本都用不到了。但是你可以看到弹幕天邪鬼还会监视 `D` 键，但是其实是没有功能的。所以我们可以写 `RIGHT=D` 来赋予 `D` 键新的功能。
	* 如果 INI 中设置了备份选项，那么在覆盖前会自动备份。
	* 如果主窗口的 `测试模式` 复选框处于选中状态，也会弹出该结果框，但并不会真正地修改游戏主程序，备份文件也不会被生成。
7. 成功应用补丁的EXE会添加到列表中。
	* ![主界面2](https://i.loli.net/2018/11/25/5bfa85d4f3e20.png)
	* 以后如果要换一套键位，可以先修改 INI 文件（记得保存文件！），然后通过上面的“应用补丁”按钮或者右键菜单中的“应用改键补丁”命令再次应用补丁，这样就可以使用新键位了。
	* 也可以通过双击直接运行该程序，甚至还可以在右键菜单中运行 vpatch、custom.exe 等。所以也可以把 THKMC 当一个简单的 `东方STG游戏启动器` 来使用。


### 使用时的注意事项

本程序仅仅通过 EXE 的文件大小和 PE 文件头中的UNIX时间戳(dwTimestamp) 来判断是哪个游戏，所以应该可以兼容各种打过第三方补丁（包括汉化补丁）的版本。

* 【**注意**】一个例外是红魔乡渔场汉化版，这个版本的 EXE 因为是加过壳的，所以无法直接修改，必须要脱过壳的版本才可以。
	+ 而且网上流传的红魔乡渔场汉化版与最新的日文版版本号不同，并非 1.02h （这也是为什么只有红魔乡的汉化版不能使用VP的原因）。为此有人针对 1.02h 做过一个汉化版，可以使用 VP。获取方式请自行搜索。

~~由于作者患有懒癌晚期，~~本程序在修改前不会校验被修改的数据，所以如果有哪个第三方补丁修改的地方恰好与本程序相同，或者在补丁数据位置之前插入了其他数据导致位置发生了偏差，那么应用改键补丁后的结果将**没有人知道**！


### 使用技巧

* 支持文件拖拽。不过目前没有确认提示。

## INI设置项说明

请参阅软件目录下的 `thkmc_sample.ini` 文件。

* 或者直接用浏览器看 [带高亮版的 thkmc_sample.ini](https://wz520.github.io/thkmc/thkmc_sample_ini.html) 。


## 常见问题

* 如何从打过补丁后的EXE中获取键位？

	> 目前无法获取。

* **地灵殿键位修改无效。**

	> 请更新到最新版本的 THKMC。

* 各种杀软报毒？

	> 本程序使用 [AutoHotkey](https://autohotkey.com/) 语言编写，并使用 [MPRESS](http://www.matcode.com/mpress.htm) 压缩。可能有些杀软对 MPRESS 壳敏感。若报毒请添加信任。
	>
	> 作者承诺决不暗藏任何恶意代码。不信自己看源代码吧。

## 联系作者

@wz520
度娘贴吧ID: [天使的枷锁](http://tieba.baidu.com/home/main?id=f861cceccab9b5c4bccfcbf83d00&fr=userbar)
<span class="mail">[邮箱](mailto:wingzero1040@gmail.com)</span>


## 更新地址＆更新历史

本程序的新版本可以在以下地址获取到：

* 编译版＆更新历史：<https://github.com/wz520/thkmc/releases>
* 源代码：<https://github.com/wz520/thkmc>


我编写的其他小程序：

* <https://www.zybuluo.com/wz520/note/15842>


[thkmc_sample.ini]: https://github.com/wz520/thkmc/blob/master/thkmc_sample.ini
[IDirectInputDevice8::GetDeviceState()]: https://msdn.microsoft.com/en-us/library/windows/desktop/microsoft.directx_sdk.idirectinputdevice8.idirectinputdevice8.getdevicestate(v=vs.85).aspx
[GetKeyboardState()]: https://msdn.microsoft.com/en-us/library/windows/desktop/ms646299(v=vs.85).aspx
[IDirectInputDevice8::SetCooperativeLevel]: https://msdn.microsoft.com/en-us/library/windows/desktop/microsoft.directx_sdk.idirectinputdevice8.idirectinputdevice8.setcooperativelevel(v=vs.85).aspx
[CreateWindowEx()]: https://msdn.microsoft.com/en-us/library/windows/desktop/ms632680(v=vs.85).aspx
[KeyNamesDX.ahk]: https://github.com/wz520/thkmc/blob/master/KeyNamesDX.ahk
