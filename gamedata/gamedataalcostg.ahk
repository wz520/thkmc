; 本作很坑爹的按 [ESP+XX] 来访问局部变量...
; 而且会修改 EBX/BL

class THKMC_GameDataAlcostg extends THKMC_GameData10 {
	__New( ) {
		base.__New()
		base._setEXEInfo("alcostg", "黄昏酒场 1.00a", 0x47755c66, 472064)
		pd = 
(LTrim Comment

57               ; PUSH EDI
BF 80000000      ; MOV EDI,80

81C4 94000000 ; add esp, 94  ; 后面的地址总共 -0x90。使用 KADD 和 KADDForComment 命令

33C9                 ; XOR ECX,ECX
8A4C24 A0            ; MOV CL,BYTE PTR SS:[ESP-60]
33D2                 ; XOR EDX,EDX
8A5424 9C            ; MOV DL,BYTE PTR SS:[ESP-64]
33C0                 ; XOR EAX,EAX
8A4424 93            ; MOV AL,BYTE PTR SS:[ESP-6D]
33DB                 ; XOR EBX,EBX
8A5C24 48            ; MOV BL,BYTE PTR SS:[ESP+48]
21f9 ; and ecx,edi
21fa ; and edx,edi
21f8 ; and eax,edi
D1E0                 ; SHL EAX,1
0BC1                 ; OR EAX,ECX
33C9                 ; XOR ECX,ECX
8A4C24 99            ; MOV CL,BYTE PTR SS:[ESP-67]
D1E0                 ; SHL EAX,1
0BC2                 ; OR EAX,EDX
33D2                 ; XOR EDX,EDX
8a5424 47      ; MOV DL,BYTE PTR SS:[ESP+47]
D1E0                 ; SHL EAX,1
0BCA                 ; OR ECX,EDX
21f9 ; and ecx,edi
0BC1                 ; OR EAX,ECX
33D2                 ; XOR EDX,EDX
8A5424 90            ; MOV DL,BYTE PTR SS:[ESP-70]
33C9                 ; XOR ECX,ECX
8A4C24 9F            ; MOV CL,BYTE PTR SS:[ESP-61]
D1E0                 ; SHL EAX,1
21fa ; and edx,edi
21f9 ; and ecx,edi
0BC1                 ; OR EAX,ECX
33C9                 ; XOR ECX,ECX
8A4C24 9D            ; MOV CL,BYTE PTR SS:[ESP-63]
D1E0                 ; SHL EAX,1
0BC2                 ; OR EAX,EDX
33D2                 ; XOR EDX,EDX
8A5424 81            ; MOV DL,BYTE PTR SS:[ESP-7F]
C1E0 07              ; SHL EAX,7
21f9 ; and ecx,edi
0BC1                 ; OR EAX,ECX
33C9                 ; XOR ECX,ECX
8A4C24 AD            ; MOV CL,BYTE PTR SS:[ESP-53]
21fa ; and edx,edi
D1E0                 ; SHL EAX,1
0BC2                 ; OR EAX,EDX
0FB65424 AC          ; MOVZX EDX,BYTE PTR SS:[ESP-54]
D1EA                 ; SHR EDX,1
21f9 ; and ecx,edi
0BCA                 ; OR ECX,EDX
33D2                 ; XOR EDX,EDX
8A5424 AE            ; MOV DL,BYTE PTR SS:[ESP-52]
D1E9                 ; SHR ECX,1
D1E0                 ; SHL EAX,1
21fa ; and edx,edi
0BCA                 ; OR ECX,EDX
33D2                 ; XOR EDX,EDX
8A5424 AA            ; MOV DL,BYTE PTR SS:[ESP-56]
D1E9                 ; SHR ECX,1
21fa ; and edx,edi
0BCA                 ; OR ECX,EDX
33D2                 ; XOR EDX,EDX
8A5424 C8            ; MOV DL,BYTE PTR SS:[ESP-38]
D1E9                 ; SHR ECX,1
0BD3                 ; OR EDX,EBX
21fa ; and edx,edi
0BCA                 ; OR ECX,EDX
33D2                 ; XOR EDX,EDX
8a5424 50      ; MOV DL,BYTE PTR SS:[ESP+50]
33DB                 ; XOR EBX,EBX
8A5C24 D0            ; MOV BL,BYTE PTR SS:[ESP-30]
D1E9                 ; SHR ECX,1
0BD3                 ; OR EDX,EBX
21fa ; and edx,edi
0BCA                 ; OR ECX,EDX
33D2                 ; XOR EDX,EDX
8A5424 CB            ; MOV DL,BYTE PTR SS:[ESP-35]
33DB                 ; XOR EBX,EBX
8a5c24 4B      ; MOV BL,BYTE PTR SS:[ESP+4B]
D1E9                 ; SHR ECX,1
0BD3                 ; OR EDX,EBX
21fa ; and edx,edi
0BCA                 ; OR ECX,EDX
D1E9                 ; SHR ECX,1
0BC1                 ; OR EAX,ECX
33C9                 ; XOR ECX,ECX
8A4C24 CD            ; MOV CL,BYTE PTR SS:[ESP-33]
33D2                 ; XOR EDX,EDX
8a5424 4D      ; MOV DL,BYTE PTR SS:[ESP+4D]
0BCA                 ; OR ECX,EDX
8A5424 CF            ; MOV DL,BYTE PTR SS:[ESP-31]
21f9 ; and ecx,edi
0BC1                 ; OR EAX,ECX
8A4C24 C9            ; MOV CL,BYTE PTR SS:[ESP-37]
80E1 80              ; AND CL,80
F6D9                 ; NEG CL
1BC9                 ; SBB ECX,ECX
81E1 90000000        ; AND ECX,90
80E2 80              ; AND DL,80
0BC1                 ; OR EAX,ECX
8A4C24 C7            ; MOV CL,BYTE PTR SS:[ESP-39]
F6DA                 ; NEG DL
1BD2                 ; SBB EDX,EDX
83E2 60              ; AND EDX,60
0BC2                 ; OR EAX,EDX
8A5424 D1            ; MOV DL,BYTE PTR SS:[ESP-2F]


81EC 94000000   ; sub esp, 94  ; 恢复ESP
5F              ; pop edi
	)
		this._setPatchData( 0x446a37, 0x446b8e, 0x400c00, 0x80, pd )
	}
}


