; 本作很坑爹的按 [ESP+XX] 来访问局部变量...

class THKMC_GameData125 extends THKMC_GameData11 {
	__New( ) {
		base.__New()
		this._setEXEInfo("th125", "东方文花帖DS 1.00a", 0x4b916e39, 743424)
		pd = 
(LTrim Comment

57               ; PUSH EDI
BF 80000000      ; MOV EDI,80

81C4 88000000 ; add esp, 88  ; 后面的地址总共 -80-4=-84

0FB67424 81       ; MOVZX ESI,BYTE PTR SS:[ESP-7F]
0FB64424 AE       ; MOVZX EAX,BYTE PTR SS:[ESP-52]
0FB64C24 A6       ; MOVZX ECX,BYTE PTR SS:[ESP-5A]
0FB65424 C4       ; MOVZX EDX,BYTE PTR SS:[ESP-3C]
21fe ; and esi,edi
03F6              ; ADD ESI,ESI
21f9 ; and ecx,edi
21f8 ; and eax,edi
0BF0              ; OR ESI,EAX
0FB64424 93       ; MOVZX EAX,BYTE PTR SS:[ESP-6D]
03F6              ; ADD ESI,ESI
0BF1              ; OR ESI,ECX
0FB64C24 A0       ; MOVZX ECX,BYTE PTR SS:[ESP-60]
21fa ; and edx,edi
03F6              ; ADD ESI,ESI
03F6              ; ADD ESI,ESI
0BF2              ; OR ESI,EDX
0FB65424 9C       ; MOVZX EDX,BYTE PTR SS:[ESP-64]
03F6              ; ADD ESI,ESI
03F6              ; ADD ESI,ESI
21f9 ; and ecx,edi
21f8 ; and eax,edi
0BF0              ; OR ESI,EAX
0FB64424 99       ; MOVZX EAX,BYTE PTR SS:[ESP-67]
21fa ; and edx,edi
03F6              ; ADD ESI,ESI
0BF1              ; OR ESI,ECX
0fb64c24 47 ; MOVZX ECX,BYTE PTR SS:[ESP+47]
0BC1              ; OR EAX,ECX
0FB64C24 AD       ; MOVZX ECX,BYTE PTR SS:[ESP-53]
03F6              ; ADD ESI,ESI
0BF2              ; OR ESI,EDX
0FB65424 9F       ; MOVZX EDX,BYTE PTR SS:[ESP-61]
21fa ; and edx,edi
21f8 ; and eax,edi
03F6              ; ADD ESI,ESI
0BF0              ; OR ESI,EAX
0FB64424 90       ; MOVZX EAX,BYTE PTR SS:[ESP-70]
21f9 ; and ecx,edi
03F6              ; ADD ESI,ESI
0BF2              ; OR ESI,EDX
0FB65424 AC       ; MOVZX EDX,BYTE PTR SS:[ESP-54]
D1EA              ; SHR EDX,1
0BCA              ; OR ECX,EDX
0FB65424 C8       ; MOVZX EDX,BYTE PTR SS:[ESP-38]
21f8 ; and eax,edi
D1E9              ; SHR ECX,1
03F6              ; ADD ESI,ESI
0BF0              ; OR ESI,EAX
0FB64424 AA       ; MOVZX EAX,BYTE PTR SS:[ESP-56]
21f8 ; and eax,edi
0BC8              ; OR ECX,EAX
0fb64424 48 ; MOVZX EAX,BYTE PTR SS:[ESP+48]
0BD0              ; OR EDX,EAX
0FB64424 D0       ; MOVZX EAX,BYTE PTR SS:[ESP-30]
21fa ; and edx,edi
D1E9              ; SHR ECX,1
0BCA              ; OR ECX,EDX
0fb65424 50 ; MOVZX EDX,BYTE PTR SS:[ESP+50]
0BD0              ; OR EDX,EAX
0fb64424 4B ; MOVZX EAX,BYTE PTR SS:[ESP+4B]
21fa ; and edx,edi
D1E9              ; SHR ECX,1
0BCA              ; OR ECX,EDX
0FB65424 CB       ; MOVZX EDX,BYTE PTR SS:[ESP-35]
0BD0              ; OR EDX,EAX
0fb64424 4D ; MOVZX EAX,BYTE PTR SS:[ESP+4D]
D1E9              ; SHR ECX,1
21fa ; and edx,edi
0BCA              ; OR ECX,EDX
0FB65424 CD       ; MOVZX EDX,BYTE PTR SS:[ESP-33]
0BD0              ; OR EDX,EAX
D1E9              ; SHR ECX,1
21fa ; and edx,edi
0BCA              ; OR ECX,EDX
D1E9              ; SHR ECX,1
C1E6 09           ; SHL ESI,9
0BF1              ; OR ESI,ECX
0FB64C24 C9       ; MOVZX ECX,BYTE PTR SS:[ESP-37]
80E1 80           ; AND CL,80
0FB6D1            ; MOVZX EDX,CL
8A4424 CF         ; MOV AL,BYTE PTR SS:[ESP-31]
F7DA              ; NEG EDX
1BD2              ; SBB EDX,EDX
24 80             ; AND AL,80
83E2 48           ; AND EDX,48
0BF2              ; OR ESI,EDX
8A5424 C7         ; MOV DL,BYTE PTR SS:[ESP-39]
0FB6C8            ; MOVZX ECX,AL
F7D9              ; NEG ECX
1BC9              ; SBB ECX,ECX
80E2 80           ; AND DL,80
83E1 30           ; AND ECX,30
0BF1              ; OR ESI,ECX
0FB64C24 D1       ; MOVZX ECX,BYTE PTR SS:[ESP-2F]
0FB6C2            ; MOVZX EAX,DL
F7D8              ; NEG EAX
1BC0              ; SBB EAX,EAX
80E1 80           ; AND CL,80
83E0 28           ; AND EAX,28
0BF0              ; OR ESI,EAX
0FB64424 9D       ; MOVZX EAX,BYTE PTR SS:[ESP-63]


81EC 88000000   ; sub esp, 88  ; 恢复ESP
5F              ; pop edi
	)
		this._setPatchData( 0x46245b, 0x4625ca, 0x400c00, 0x80, pd )
	}
}
