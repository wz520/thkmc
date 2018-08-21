; 本作很坑爹的按 [ESP+XX] 来访问局部变量...

class THKMC_GameData10 extends THKMC_GameDataBase {
	__New( ) {
		base.__New("th10", "东方风神录 1.00a", 0x46b23cd0, 487936)
		pd = 
(LTrim Comment

53               ; PUSH EBX
B380             ; MOV BL,80

81C4 94000000 ; add esp, 94  ; 后面的地址总共 -0x90。使用 KADD 和 KADDForComment 命令

8A4C24 AA         ; MOV CL,BYTE PTR SS:[ESP-56]
8A5424 AD         ; MOV DL,BYTE PTR SS:[ESP-53]
8A4424 AC         ; MOV AL,BYTE PTR SS:[ESP-54]
80E2 BF           ; AND DL,0BF
D0E8              ; SHR AL,1
0AD0              ; OR DL,AL
D0EA              ; SHR DL,1
8A4424 81         ; MOV AL,BYTE PTR SS:[ESP-7F]
80E1 9F           ; AND CL,9F
0AD1              ; OR DL,CL
8A4C24 C8         ; MOV CL,BYTE PTR SS:[ESP-38]
D0EA              ; SHR DL,1
24 8F             ; AND AL,8F
0AD0              ; OR DL,AL
0a4c24 48   ; OR CL,BYTE PTR SS:[ESP+48]
8a4424 50   ; MOV AL,BYTE PTR SS:[ESP+50]
D0EA              ; SHR DL,1
80E1 87           ; AND CL,87
0AD1              ; OR DL,CL
0A4424 D0         ; OR AL,BYTE PTR SS:[ESP-30]
8A4C24 CB         ; MOV CL,BYTE PTR SS:[ESP-35]
D0EA              ; SHR DL,1
24 83             ; AND AL,83
0AD0              ; OR DL,AL
0a4c24 4B   ; OR CL,BYTE PTR SS:[ESP+4B]
8A4424 CD         ; MOV AL,BYTE PTR SS:[ESP-33]
D0EA              ; SHR DL,1
80E1 81           ; AND CL,81
0AD1              ; OR DL,CL
0a4424 4D   ; OR AL,BYTE PTR SS:[ESP+4D]
8A4C24 93         ; MOV CL,BYTE PTR SS:[ESP-6D]
D0EA              ; SHR DL,1
20d8 ; and al,bl
0AD0              ; OR DL,AL
8A4424 A0         ; MOV AL,BYTE PTR SS:[ESP-60]
66:0FB6FA         ; MOVZX DI,DL
20d9 ; and cl,bl
20d8 ; and al,bl
66:0FB6D1         ; MOVZX DX,CL
66:0FB6C8         ; MOVZX CX,AL
8A4424 9C         ; MOV AL,BYTE PTR SS:[ESP-64]
20d8 ; and al,bl
D1E2              ; SHL EDX,1
0BD1              ; OR EDX,ECX
66:0FB6C8         ; MOVZX CX,AL
8A4424 99         ; MOV AL,BYTE PTR SS:[ESP-67]
D1E2              ; SHL EDX,1
0BD1              ; OR EDX,ECX
0a4424 47   ; OR AL,BYTE PTR SS:[ESP+47]
20d8 ; and al,bl
66:0FB6C8         ; MOVZX CX,AL
8A4424 9F         ; MOV AL,BYTE PTR SS:[ESP-61]
D1E2              ; SHL EDX,1
20d8 ; and al,bl
0BD1              ; OR EDX,ECX
66:0FB6C8         ; MOVZX CX,AL
8A4424 90         ; MOV AL,BYTE PTR SS:[ESP-70]
D1E2              ; SHL EDX,1
20d8 ; and al,bl
0BD1              ; OR EDX,ECX
66:0FB6C8         ; MOVZX CX,AL
8A4424 9D         ; MOV AL,BYTE PTR SS:[ESP-63]
D1E2              ; SHL EDX,1
20d8 ; and al,bl
0BD1              ; OR EDX,ECX
66:0FB6C8         ; MOVZX CX,AL
D1E2              ; SHL EDX,1
0BD1              ; OR EDX,ECX
D1E2              ; SHL EDX,1
0BFA              ; OR EDI,EDX
8A5424 C9         ; MOV DL,BYTE PTR SS:[ESP-37]
20da ; and dl,bl
F6DA              ; NEG DL
1BD2              ; SBB EDX,EDX
81E2 90000000     ; AND EDX,90
0BFA              ; OR EDI,EDX
8A4424 CF         ; MOV AL,BYTE PTR SS:[ESP-31]
8A4C24 C7         ; MOV CL,BYTE PTR SS:[ESP-39]
8A5424 D1         ; MOV DL,BYTE PTR SS:[ESP-2F]

81EC 94000000   ; sub esp, 94  ; 恢复ESP
5B              ; pop ebx
	)
		; OD中向上找 44a75b 处是 call dword ptr ds:[edx+24]，这正是 "CALL IDirectInputDevice8::GetDeviceState()"
		; 其参数有 lea ecx,dword ptr ss:[esp+10]，于是 0x90-0x10=0x80
		this._setPatchData( 0x44a796, 0x44a88d, 0x400c00, 0x80, pd )
		this.addrPattern := "i)(?:\b0fb6|\b[80]a[45])[0-9a-f]+\s([0-9a-z]{2})\s"
	}

	; 如果返回字符串 "OUT"，则认为超出范围，跳过
	; 这个类只需要处理一个字节即可
	str2KeymapValue( s ) {
		KeymapValue := (Pad0x(s)+0)
		; 转换成8位有符号
		KeymapValue :=  KeymapValue > 0x7f ? -(0x100-KeymapValue) : KeymapValue
		KeymapValue +=  this.patchvaluefix

		if ( KeymapValue > 0xff || KeymapValue < 0 ) {
			return "OUT" ; 超出范围， 忽略
		}

		return KeymapValue
	}

	keymapValue2Str( k ) {
		k := (k - this.patchvaluefix) & 0xff ; 转换成8位无符号
		return PadLeadingZero( UnPad0x(ToHex( k )), 2 )
	}
}

