; 键位名称和其扫描码的对照表
; 注意这是 DirectInput 的扫描码，与 Win32 API 中的扫描码不完全相同（虽然有大部分是相同的）。
;
; 来自 MSDN - Keyboard Device Enumeration:
; https://msdn.microsoft.com/en-us/library/windows/desktop/ee418641%28v=vs.85%29.aspx
; 然而实际上 MSDN 上的并不全，需要完整的可以打开 Visual Studio 的 include/dinput.h 然后搜索 "DIK_"
;
; 以下的内容转换自 VS2010 的 dinput.h 中与扫描码相关的内容。
; 不过部分名称根据我自己的习惯作了一些修改，主要是一些较长或现在不太用的名称，
;   比如 ESCAPE 改成 ESC，RETURN 改成 ENTER 等等。
; 当然以后如果有需要可能还会添加更多的别名。
;
; 【注意】INI 文件里的键位名称是大小写不敏感的，也就是说 "ESC" 可以写成 "esc" 或者 "eSc" 等等，都是相同的意思。
;
; 以下的 THKMC_KeyNamesDX["XXX"] 中的 XXX 部分便是 INI 文件中可以使用的键位名称。
; 【注意1】不一定所有的键位都可用。
; 【注意2】主键盘上的数字键不能直接写数字（因为数字直接代表扫描码），而要写成 "VK数字" 。
;           比如如果你要将 "Z" 键映射为主键盘上的数字键 "1"，不能写 "Z=1"，而要写成 "Z=VK1" 。
;           当然，由于数字键“1”的扫描码是 0x02，所以你也可以写成“Z=0x02”。
;           （虽然“Z=2”也是相同的意思，不过不建议这么写，因为很容易让别人误以为是数字键“2”）

THKMC_KeyNamesDX := {}
THKMC_KeyNamesDX["ESC"]          := 0x01
THKMC_KeyNamesDX["VK1"]          := 0x02   ;  主键盘数字键“1”
THKMC_KeyNamesDX["VK2"]          := 0x03
THKMC_KeyNamesDX["VK3"]          := 0x04
THKMC_KeyNamesDX["VK4"]          := 0x05
THKMC_KeyNamesDX["VK5"]          := 0x06
THKMC_KeyNamesDX["VK6"]          := 0x07
THKMC_KeyNamesDX["VK7"]          := 0x08
THKMC_KeyNamesDX["VK8"]          := 0x09
THKMC_KeyNamesDX["VK9"]          := 0x0A
THKMC_KeyNamesDX["VK0"]          := 0x0B
THKMC_KeyNamesDX["MINUS"]        := 0x0C   ;   主键盘区的减号键
THKMC_KeyNamesDX["EQUALS"]       := 0x0D   ;   等号
THKMC_KeyNamesDX["BACK"]         := 0x0E   ;   退格键 backspace 
THKMC_KeyNamesDX["TAB"]          := 0x0F
THKMC_KeyNamesDX["Q"]            := 0x10
THKMC_KeyNamesDX["W"]            := 0x11
THKMC_KeyNamesDX["E"]            := 0x12
THKMC_KeyNamesDX["R"]            := 0x13
THKMC_KeyNamesDX["T"]            := 0x14
THKMC_KeyNamesDX["Y"]            := 0x15
THKMC_KeyNamesDX["U"]            := 0x16
THKMC_KeyNamesDX["I"]            := 0x17
THKMC_KeyNamesDX["O"]            := 0x18
THKMC_KeyNamesDX["P"]            := 0x19
THKMC_KeyNamesDX["LBRACKET"]     := 0x1A   ;   左方括号 [
THKMC_KeyNamesDX["RBRACKET"]     := 0x1B   ;   右方括号 ]
THKMC_KeyNamesDX["ENTER"]        := 0x1C   ;   Enter on main keyboard 
THKMC_KeyNamesDX["LCONTROL"]     := 0x1D   ;   左 CTRL
THKMC_KeyNamesDX["A"]            := 0x1E
THKMC_KeyNamesDX["S"]            := 0x1F
THKMC_KeyNamesDX["D"]            := 0x20
THKMC_KeyNamesDX["F"]            := 0x21
THKMC_KeyNamesDX["G"]            := 0x22
THKMC_KeyNamesDX["H"]            := 0x23
THKMC_KeyNamesDX["J"]            := 0x24
THKMC_KeyNamesDX["K"]            := 0x25
THKMC_KeyNamesDX["L"]            := 0x26
THKMC_KeyNamesDX["SEMICOLON"]    := 0x27   ;  分号 ;
THKMC_KeyNamesDX["APOSTROPHE"]   := 0x28   ;  单引号 '
THKMC_KeyNamesDX["GRAVE"]        := 0x29   ;  accent grave `
THKMC_KeyNamesDX["LSHIFT"]       := 0x2A   ;  左 SHIFT
THKMC_KeyNamesDX["BACKSLASH"]    := 0x2B   ;  反斜杠 \ 
THKMC_KeyNamesDX["Z"]            := 0x2C
THKMC_KeyNamesDX["X"]            := 0x2D
THKMC_KeyNamesDX["C"]            := 0x2E
THKMC_KeyNamesDX["V"]            := 0x2F
THKMC_KeyNamesDX["B"]            := 0x30
THKMC_KeyNamesDX["N"]            := 0x31
THKMC_KeyNamesDX["M"]            := 0x32
THKMC_KeyNamesDX["COMMA"]        := 0x33   ;  逗号 ,
THKMC_KeyNamesDX["PERIOD"]       := 0x34   ;  点号 . on main keyboard 
THKMC_KeyNamesDX["SLASH"]        := 0x35   ;  斜杠 / on main keyboard 
THKMC_KeyNamesDX["RSHIFT"]       := 0x36
THKMC_KeyNamesDX["MULTIPLY"]     := 0x37   ;  星号 * on numeric keypad
THKMC_KeyNamesDX["LMENU"]        := 0x38   ;  左 Alt 
THKMC_KeyNamesDX["SPACE"]        := 0x39
THKMC_KeyNamesDX["CAPITAL"]      := 0x3A   ;  Capslock
THKMC_KeyNamesDX["F1"]           := 0x3B
THKMC_KeyNamesDX["F2"]           := 0x3C
THKMC_KeyNamesDX["F3"]           := 0x3D
THKMC_KeyNamesDX["F4"]           := 0x3E
THKMC_KeyNamesDX["F5"]           := 0x3F
THKMC_KeyNamesDX["F6"]           := 0x40
THKMC_KeyNamesDX["F7"]           := 0x41
THKMC_KeyNamesDX["F8"]           := 0x42
THKMC_KeyNamesDX["F9"]           := 0x43
THKMC_KeyNamesDX["F10"]          := 0x44
THKMC_KeyNamesDX["NUMLOCK"]      := 0x45
THKMC_KeyNamesDX["SCROLL"]       := 0x46   ;   Scroll Lock 
THKMC_KeyNamesDX["NUMPAD7"]      := 0x47
THKMC_KeyNamesDX["NUMPAD8"]      := 0x48
THKMC_KeyNamesDX["NUMPAD9"]      := 0x49
THKMC_KeyNamesDX["SUBTRACT"]     := 0x4A   ;   - on numeric keypad 
THKMC_KeyNamesDX["NUMPAD4"]      := 0x4B
THKMC_KeyNamesDX["NUMPAD5"]      := 0x4C
THKMC_KeyNamesDX["NUMPAD6"]      := 0x4D
THKMC_KeyNamesDX["ADD"]          := 0x4E   ;   + on numeric keypad 
THKMC_KeyNamesDX["NUMPAD1"]      := 0x4F
THKMC_KeyNamesDX["NUMPAD2"]      := 0x50
THKMC_KeyNamesDX["NUMPAD3"]      := 0x51
THKMC_KeyNamesDX["NUMPAD0"]      := 0x52
THKMC_KeyNamesDX["DECIMAL"]      := 0x53   ;   . on numeric keypad 
THKMC_KeyNamesDX["OEM_102"]      := 0x56   ;   <> or \| on RT 102-key keyboard (Non-U.S.) 
THKMC_KeyNamesDX["F11"]          := 0x57
THKMC_KeyNamesDX["F12"]          := 0x58
THKMC_KeyNamesDX["F13"]          := 0x64   ;                       (NEC PC98) 
THKMC_KeyNamesDX["F14"]          := 0x65   ;                       (NEC PC98) 
THKMC_KeyNamesDX["F15"]          := 0x66   ;                       (NEC PC98) 
THKMC_KeyNamesDX["KANA"]         := 0x70   ;   (Japanese keyboard)            
THKMC_KeyNamesDX["ABNT_C1"]      := 0x73   ;   /? on Brazilian keyboard 
THKMC_KeyNamesDX["CONVERT"]      := 0x79   ;   (Japanese keyboard)            
THKMC_KeyNamesDX["NOCONVERT"]    := 0x7B   ;   (Japanese keyboard)            
THKMC_KeyNamesDX["YEN"]          := 0x7D   ;   (Japanese keyboard)            
THKMC_KeyNamesDX["ABNT_C2"]      := 0x7E   ;   Numpad . on Brazilian keyboard 
THKMC_KeyNamesDX["NUMPADEQUALS"] := 0x8D   ;   = on numeric keypad (NEC PC98) 
THKMC_KeyNamesDX["PREVTRACK"]    := 0x90   ;   Previous Track (DIK_CIRCUMFLEX on Japanese keyboard) 
THKMC_KeyNamesDX["AT"]           := 0x91   ;                       (NEC PC98) 
THKMC_KeyNamesDX["COLON"]        := 0x92   ;                       (NEC PC98) 
THKMC_KeyNamesDX["UNDERLINE"]    := 0x93   ;                       (NEC PC98) 
THKMC_KeyNamesDX["KANJI"]        := 0x94   ;   (Japanese keyboard)            
THKMC_KeyNamesDX["STOP"]         := 0x95   ;                       (NEC PC98) 
THKMC_KeyNamesDX["AX"]           := 0x96   ;                       (Japan AX) 
THKMC_KeyNamesDX["UNLABELED"]    := 0x97   ;                          (J3100) 
THKMC_KeyNamesDX["NEXTTRACK"]    := 0x99   ;   Next Track 
THKMC_KeyNamesDX["NUMPADENTER"]  := 0x9C   ;   Enter on numeric keypad 
THKMC_KeyNamesDX["RCONTROL"]     := 0x9D
THKMC_KeyNamesDX["MUTE"]         := 0xA0   ;   Mute 
THKMC_KeyNamesDX["CALCULATOR"]   := 0xA1   ;   Calculator 
THKMC_KeyNamesDX["PLAYPAUSE"]    := 0xA2   ;   Play / Pause 
THKMC_KeyNamesDX["MEDIASTOP"]    := 0xA4   ;   Media Stop 
THKMC_KeyNamesDX["VOLUMEDOWN"]   := 0xAE   ;   Volume - 
THKMC_KeyNamesDX["VOLUMEUP"]     := 0xB0   ;   Volume + 
THKMC_KeyNamesDX["WEBHOME"]      := 0xB2   ;   Web home 
THKMC_KeyNamesDX["NUMPADCOMMA"]  := 0xB3   ;   , on numeric keypad (NEC PC98) 
THKMC_KeyNamesDX["DIVIDE"]       := 0xB5   ;   / on numeric keypad 
THKMC_KeyNamesDX["SYSRQ"]        := 0xB7
THKMC_KeyNamesDX["RMENU"]        := 0xB8   ;   右 Alt 
THKMC_KeyNamesDX["PAUSE"]        := 0xC5   ;   Pause 
THKMC_KeyNamesDX["HOME"]         := 0xC7   ;   Home on arrow keypad 
THKMC_KeyNamesDX["UP"]           := 0xC8   ;   ↑
THKMC_KeyNamesDX["PRIOR"]        := 0xC9   ;   PgUp
THKMC_KeyNamesDX["LEFT"]         := 0xCB   ;   ←
THKMC_KeyNamesDX["RIGHT"]        := 0xCD   ;   →
THKMC_KeyNamesDX["END"]          := 0xCF   ;   End
THKMC_KeyNamesDX["DOWN"]         := 0xD0   ;   ↓
THKMC_KeyNamesDX["NEXT"]         := 0xD1   ;   PgDn
THKMC_KeyNamesDX["INSERT"]       := 0xD2   ;   Insert
THKMC_KeyNamesDX["DELETE"]       := 0xD3   ;   Delete
THKMC_KeyNamesDX["LWIN"]         := 0xDB   ;   左 Windows 徽标键
THKMC_KeyNamesDX["RWIN"]         := 0xDC   ;   右 Windows 徽标键
THKMC_KeyNamesDX["APPS"]         := 0xDD   ;   AppMenu key 
THKMC_KeyNamesDX["POWER"]        := 0xDE   ;   System Power 
THKMC_KeyNamesDX["SLEEP"]        := 0xDF   ;   System Sleep 
THKMC_KeyNamesDX["WAKE"]         := 0xE3   ;   System Wake 
THKMC_KeyNamesDX["WEBSEARCH"]    := 0xE5   ;   Web Search 
THKMC_KeyNamesDX["WEBFAVORITES"] := 0xE6   ;   Web Favorites 
THKMC_KeyNamesDX["WEBREFRESH"]   := 0xE7   ;   Web Refresh 
THKMC_KeyNamesDX["WEBSTOP"]      := 0xE8   ;   Web Stop 
THKMC_KeyNamesDX["WEBFORWARD"]   := 0xE9   ;   Web Forward 
THKMC_KeyNamesDX["WEBBACK"]      := 0xEA   ;   Web Back 
THKMC_KeyNamesDX["MYCOMPUTER"]   := 0xEB   ;   My Computer 
THKMC_KeyNamesDX["MAIL"]         := 0xEC   ;   Mail 
THKMC_KeyNamesDX["MEDIASELECT"]  := 0xED   ;   Media Select 


; 这些是 DINPUT.H 里定义的个别键位的别名
THKMC_KeyNamesDX["BACKSPACE"]      := THKMC_KeyNamesDX["BACK"]
THKMC_KeyNamesDX["NUMPADSTAR"]     := THKMC_KeyNamesDX["MULTIPLY"]
THKMC_KeyNamesDX["LALT"]           := THKMC_KeyNamesDX["LMENU"]
THKMC_KeyNamesDX["CAPSLOCK"]       := THKMC_KeyNamesDX["CAPITAL"]
THKMC_KeyNamesDX["NUMPADMINUS"]    := THKMC_KeyNamesDX["SUBTRACT"]
THKMC_KeyNamesDX["NUMPADPLUS"]     := THKMC_KeyNamesDX["ADD"]
THKMC_KeyNamesDX["NUMPADPERIOD"]   := THKMC_KeyNamesDX["DECIMAL"]
THKMC_KeyNamesDX["NUMPADSLASH"]    := THKMC_KeyNamesDX["DIVIDE"]
THKMC_KeyNamesDX["RALT"]           := THKMC_KeyNamesDX["RMENU"]
THKMC_KeyNamesDX["PGUP"]           := THKMC_KeyNamesDX["PRIOR"]
THKMC_KeyNamesDX["PGDN"]           := THKMC_KeyNamesDX["NEXT"]
THKMC_KeyNamesDX["DIK_CIRCUMFLEX"] := THKMC_KeyNamesDX["PREVTRACK"]



; 这是我自己定义的别名
THKMC_KeyNamesDX["EQUAL"]      := THKMC_KeyNamesDX["EQUALS"]
THKMC_KeyNamesDX["SCROLLLOCK"] := THKMC_KeyNamesDX["SCROLL"]

