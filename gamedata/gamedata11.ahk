; 本作很坑爹的按 [ESP+XX] 来访问局部变量...


class THKMC_GameData11 extends THKMC_GameData10 {
	__New( ) {
		base.__New()
		this._setEXEInfo("th11", "东方地灵殿 1.00a", 0x489526fa, 688128)
		pd = 
(LTrim Comment

53               ; PUSH EBX    ; 这里 PUSH 了，后面的 ESP+XX 要 +4
BB 80000000      ; MOV EBX,80

21de ; AND ESI,EBX
21d8 ; and eax,ebx

81C4 88000000 ; add esp, 88  ; 后面的地址总共 -80-4=-84

0FB67424 C4       ;    MOVZX ESI,BYTE PTR SS:[ESP-3C]
0FB64424 93       ;    MOVZX EAX,BYTE PTR SS:[ESP-6D]
0FB64C24 A0       ;    MOVZX ECX,BYTE PTR SS:[ESP-60]
0FB65424 9C       ;    MOVZX EDX,BYTE PTR SS:[ESP-64]
81E6 80000000     ;    AND ESI,80
21d8 ; and eax,ebx
03F6              ;    ADD ESI,ESI
03F6              ;    ADD ESI,ESI
0BF0              ;    OR ESI,EAX
0FB64424 99       ;    MOVZX EAX,BYTE PTR SS:[ESP-67]
03F6              ;    ADD ESI,ESI
21d9 ; and ecx,ebx
0BF1              ;    OR ESI,ECX
0fb64c24 47 ;    MOVZX ECX,BYTE PTR SS:[ESP+47]
0BC1              ;    OR EAX,ECX
0FB64C24 9D       ;    MOVZX ECX,BYTE PTR SS:[ESP-63]
21d8 ; and eax,ebx
03F6              ;    ADD ESI,ESI
21da ; and edx,ebx
0BF2              ;    OR ESI,EDX
0FB65424 9F       ;    MOVZX EDX,BYTE PTR SS:[ESP-61]
03F6              ;    ADD ESI,ESI
0BF0              ;    OR ESI,EAX
0FB64424 90       ;    MOVZX EAX,BYTE PTR SS:[ESP-70]
21d8 ; and eax,ebx
03F6              ;    ADD ESI,ESI
21da ; and edx,ebx
0BF2              ;    OR ESI,EDX
0FB65424 81       ;    MOVZX EDX,BYTE PTR SS:[ESP-7F]
21d9 ; and ecx,ebx
03F6              ;    ADD ESI,ESI
0BF0              ;    OR ESI,EAX
0FB64424 AD       ;    MOVZX EAX,BYTE PTR SS:[ESP-53]
21d8 ; and eax,ebx
C1E6 07           ;    SHL ESI,7
0BF1              ;    OR ESI,ECX
0FB64C24 AC       ;    MOVZX ECX,BYTE PTR SS:[ESP-54]
D1E9              ;    SHR ECX,1
0BC1              ;    OR EAX,ECX
0FB64C24 C8       ;    MOVZX ECX,BYTE PTR SS:[ESP-38]
21da ; and edx,ebx
C1E8 02           ;    SHR EAX,2
03F6              ;    ADD ESI,ESI
0BF2              ;    OR ESI,EDX
0FB65424 AA       ;    MOVZX EDX,BYTE PTR SS:[ESP-56]
21da ; and edx,ebx
0BC2              ;    OR EAX,EDX
0fb65424 48 ;    MOVZX EDX,BYTE PTR SS:[ESP+48]
0BCA              ;    OR ECX,EDX
0FB65424 D0       ;    MOVZX EDX,BYTE PTR SS:[ESP-30]
D1E8              ;    SHR EAX,1
21d9 ; and ecx,ebx
0BC1              ;    OR EAX,ECX
0fb64c24 50 ;    MOVZX ECX,BYTE PTR SS:[ESP+50]
0BCA              ;    OR ECX,EDX
0fb65424 4B ;    MOVZX EDX,BYTE PTR SS:[ESP+4B]
D1E8              ;    SHR EAX,1
21d9 ; and ecx,ebx
0BC1              ;    OR EAX,ECX
0FB64C24 CB       ;    MOVZX ECX,BYTE PTR SS:[ESP-35]
D1E8              ;    SHR EAX,1
0BCA              ;    OR ECX,EDX
0FB65424 C9       ;    MOVZX EDX,BYTE PTR SS:[ESP-37]
21d9 ; and ecx,ebx
0BC1              ;    OR EAX,ECX
0fb64c24 4D ;    MOVZX ECX,BYTE PTR SS:[ESP+4D]
D1E8              ;    SHR EAX,1
03F6              ;    ADD ESI,ESI
0BF0              ;    OR ESI,EAX
0FB64424 CD       ;    MOVZX EAX,BYTE PTR SS:[ESP-33]
0BC1              ;    OR EAX,ECX
8A4C24 CF         ;    MOV CL,BYTE PTR SS:[ESP-31]
21d8 ; and eax,ebx
0BF0              ;    OR ESI,EAX
80E2 80           ;    AND DL,80
0FB6C2            ;    MOVZX EAX,DL
F7D8              ;    NEG EAX
1BC0              ;    SBB EAX,EAX
25 90000000       ;    AND EAX,90
0BF0              ;    OR ESI,EAX
80E1 80           ;    AND CL,80
8A4424 C7         ;    MOV AL,BYTE PTR SS:[ESP-39]
0FB6D1            ;    MOVZX EDX,CL
F7DA              ;    NEG EDX
1BD2              ;    SBB EDX,EDX
24 80             ;    AND AL,80
83E2 60           ;    AND EDX,60
0FB6C8            ;    MOVZX ECX,AL
0BF2              ;    OR ESI,EDX
0FB65424 D1       ;    MOVZX EDX,BYTE PTR SS:[ESP-2F]

81EC 88000000   ; sub esp, 88  ; 恢复ESP
5B              ; pop ebx
	)
		this._setPatchData( 0x457883, 0x4579d1, 0x400c00, 0x80, pd )
		this.addrPattern := "i)(?:\b0fb6|\b8a4)[0-9a-f]+\s([0-9a-z]{2})\s"
	}

	doCustomPatch( pExeData ) {
		; 要让上面的补丁有效，
		; 需要打个补丁以修正总是无法正常初始化 DirectInput 的 BUG 。

		; original data
		od =
		(LTrim Comment
E8 F11A0100              ; call <th11.sub_4571A0>
E8 BC2A0100              ; call <th11.sub_458170>
8125 10384C00 FFF3FFFF   ; and dword ptr ds:[4C3810],FFFFF3FF
B8 80324C00              ; mov eax,th11.4C3280
E8 E8230000              ; call <th11.sub_447AB0>
A1 10384C00              ; mov eax,dword ptr ds:[4C3810]
33D2                     ; xor edx,edx
391D A0324C00            ; cmp dword ptr ds:[4C32A0],ebx
BE E4584A00              ; mov esi,th11.4A58E4
0F95C2                   ; setne dl
33C9                     ; xor ecx,ecx
C1E2 0A                  ; shl edx,A
33D0                     ; xor edx,eax
81E2 00040000            ; and edx,400
33C2                     ; xor eax,edx
391D A4324C00            ; cmp dword ptr ds:[4C32A4],ebx
0F95C1                   ; setne cl
C1E1 0B                  ; shl ecx,B
33C8                     ; xor ecx,eax
81E1 00080000            ; and ecx,800
33C1                     ; xor eax,ecx
A3 10384C00              ; mov dword ptr ds:[4C3810],eax
E8 243D0100              ; call <th11.sub_459430>
6A 20                    ; push 20
E8 A3A20100              ; call <JMP.&Direct3DCreate9>
A3 84324C00              ; mov dword ptr ds:[4C3284],eax
3BC3                     ; cmp eax,ebx
75 17                    ; jne th11.445733
68 5C684900              ; push th11.49685C
BF 40594A00              ; mov edi,th11.4A5940
E8 C5330100              ; call <th11.sub_458AF0>
83C4 04                  ; add esp,4
E9 66040000              ; jmp th11.445B99
8B5C24 10                ; mov ebx,dword ptr ss:[esp+10]
E8 A4130000              ; call <th11.sub_446AE0>
85C0                     ; test eax,eax
0F85 53040000            ; jne th11.445B97
		)

		; patch data
		pd = 
		(LTrim Comment
8B5C24 10                ; mov ebx,dword ptr ss:[esp+10]
E8 2D140000              ; call <th11.sub_446AE0>
85C0                     ; test eax,eax
0F85 DC040000            ; jne th11.445B97
E8 E01A0100              ; call <th11.sub_4571A0>
E8 AB2A0100              ; call <th11.sub_458170>
8125 10384C00 FFF3FFFF   ; and dword ptr ds:[4C3810],FFFFF3FF
B8 80324C00              ; mov eax,th11.4C3280
E8 D7230000              ; call <th11.sub_447AB0>
A1 10384C00              ; mov eax,dword ptr ds:[4C3810]
33D2                     ; xor edx,edx
3915 A0324C00            ; cmp dword ptr ds:[4C32A0],edx
BE E4584A00              ; mov esi,th11.4A58E4
0F95C2                   ; setne dl
33C9                     ; xor ecx,ecx
C1E2 0A                  ; shl edx,A
33D0                     ; xor edx,eax
81E2 00040000            ; and edx,400
33C2                     ; xor eax,edx
390D A4324C00            ; cmp dword ptr ds:[4C32A4],ecx
0F95C1                   ; setne cl
C1E1 0B                  ; shl ecx,B
33C8                     ; xor ecx,eax
81E1 00080000            ; and ecx,800
33C1                     ; xor eax,ecx
A3 10384C00              ; mov dword ptr ds:[4C3810],eax
E8 133D0100              ; call <th11.sub_459430>
6A 20                    ; push 20
E8 92A20100              ; call <JMP.&Direct3DCreate9>
A3 84324C00              ; mov dword ptr ds:[4C3284],eax
3BC7                     ; cmp eax,edi
75 17                    ; jne th11.445744
68 5C684900              ; push th11.49685C
BF 40594A00              ; mov edi,th11.4A5940
E8 B4330100              ; call <th11.sub_458AF0>
83C4 04                  ; add esp,4
E9 55040000              ; jmp th11.445B99
		)

		addr := 0x44AAA
		
		AddLog("【提示】开始打补丁以修正地灵殿特有的无法正确初始化 DirectInput8 的 BUG 。")
		if ( compareHexToBinary( od, pExeData, addr ) = 0 ) {
			AddLog("【提示】用于修正BUG的补丁应用成功！")
			writeHexToBinary( pd, pExeData, addr )
		}
		else if ( compareHexToBinary( pd, pExeData, addr) = 0 ) {
			AddLog("【提示】无需打补丁。跳过。")
		}
		else {
			AddLog("【警告】无法打补丁。因为需要打补丁的数据已被第三方程序修改过。自定义键位可能无效。")
		}
	}
}
