class THKMC_GameData128 extends THKMC_GameDataBase {
	__New( ) {
		base.__New("th128", "妖精大战争 ~ 东方三月精 1.00a", 0x4C57A196, 752640)
		pd=
(LTrim Comment

57                 ;  PUSH EDI
BF 80000000        ;  MOV EDI,80

0FB6B5 40FFFFFF      ; MOVZX ESI,BYTE PTR SS:[EBP-C0]
0FB685 0FFFFFFF      ; MOVZX EAX,BYTE PTR SS:[EBP-F1]
0FB68D 1CFFFFFF      ; MOVZX ECX,BYTE PTR SS:[EBP-E4]
0FB695 18FFFFFF      ; MOVZX EDX,BYTE PTR SS:[EBP-E8]
21fe ; and esi,edi
03F6                 ; ADD ESI,ESI
21f9 ; and ecx,edi
03F6                 ; ADD ESI,ESI
21f8 ; and eax,edi
0BF0                 ; OR ESI,EAX
0FB685 15FFFFFF      ; MOVZX EAX,BYTE PTR SS:[EBP-EB]
03F6                 ; ADD ESI,ESI
0BF1                 ; OR ESI,ECX
0fb68d C3ffffff            ; MOVZX ECX,BYTE PTR SS:[EBP-3D]
0BC1                 ; OR EAX,ECX
0FB68D 2AFFFFFF      ; MOVZX ECX,BYTE PTR SS:[EBP-D6]
21fa ; and edx,edi
03F6                 ; ADD ESI,ESI
0BF2                 ; OR ESI,EDX
0FB695 1BFFFFFF      ; MOVZX EDX,BYTE PTR SS:[EBP-E5]
03F6                 ; ADD ESI,ESI
21f8 ; and eax,edi
0BF0                 ; OR ESI,EAX
0FB685 0CFFFFFF      ; MOVZX EAX,BYTE PTR SS:[EBP-F4]
21fa ; and edx,edi
03F6                 ; ADD ESI,ESI
0BF2                 ; OR ESI,EDX
0FB695 19FFFFFF      ; MOVZX EDX,BYTE PTR SS:[EBP-E7]
0BCA                 ; OR ECX,EDX
0FB695 28FFFFFF      ; MOVZX EDX,BYTE PTR SS:[EBP-D8]
21f9 ; and ecx,edi
21f8 ; and eax,edi
03F6                 ; ADD ESI,ESI
0BF0                 ; OR ESI,EAX
0FB685 FDFEFFFF      ; MOVZX EAX,BYTE PTR SS:[EBP-103]
C1E6 07              ; SHL ESI,7
0BF1                 ; OR ESI,ECX
0FB68D 29FFFFFF      ; MOVZX ECX,BYTE PTR SS:[EBP-D7]
21f9 ; and ecx,edi
21f8 ; and eax,edi
D1EA                 ; SHR EDX,1
0BCA                 ; OR ECX,EDX
0FB695 44FFFFFF      ; MOVZX EDX,BYTE PTR SS:[EBP-BC]
C1E9 02              ; SHR ECX,2
03F6                 ; ADD ESI,ESI
0BF0                 ; OR ESI,EAX
0FB685 26FFFFFF      ; MOVZX EAX,BYTE PTR SS:[EBP-DA]
21f8 ; and eax,edi
0BC8                 ; OR ECX,EAX
0fb685 C4ffffff            ; MOVZX EAX,BYTE PTR SS:[EBP-3C]
0BD0                 ; OR EDX,EAX
0FB685 4CFFFFFF      ; MOVZX EAX,BYTE PTR SS:[EBP-B4]
D1E9                 ; SHR ECX,1
21fa ; and edx,edi
0BCA                 ; OR ECX,EDX
0fb695 CCffffff            ; MOVZX EDX,BYTE PTR SS:[EBP-34]
D1E9                 ; SHR ECX,1
0BD0                 ; OR EDX,EAX
0fb685 C7ffffff            ; MOVZX EAX,BYTE PTR SS:[EBP-39]
21fa ; and edx,edi
0BCA                 ; OR ECX,EDX
0FB695 47FFFFFF      ; MOVZX EDX,BYTE PTR SS:[EBP-B9]
D1E9                 ; SHR ECX,1
0BD0                 ; OR EDX,EAX
0FB685 45FFFFFF      ; MOVZX EAX,BYTE PTR SS:[EBP-BB]
21fa ; and edx,edi
0BCA                 ; OR ECX,EDX
0fb695 C9ffffff            ; MOVZX EDX,BYTE PTR SS:[EBP-37]
D1E9                 ; SHR ECX,1
03F6                 ; ADD ESI,ESI
0BF1                 ; OR ESI,ECX
0FB68D 49FFFFFF      ; MOVZX ECX,BYTE PTR SS:[EBP-B7]
0BCA                 ; OR ECX,EDX
21f9 ; and ecx,edi
0BF1                 ; OR ESI,ECX
24 80                ; AND AL,80
0FB6C8               ; MOVZX ECX,AL
F7D9                 ; NEG ECX
1BC9                 ; SBB ECX,ECX
81E1 90000000        ; AND ECX,90
0BF1                 ; OR ESI,ECX
8A95 4BFFFFFF        ; MOV DL,BYTE PTR SS:[EBP-B5]
8A8D 43FFFFFF        ; MOV CL,BYTE PTR SS:[EBP-BD]
80E2 80              ; AND DL,80
0FB6C2               ; MOVZX EAX,DL
F7D8                 ; NEG EAX
1BC0                 ; SBB EAX,EAX
80E1 80              ; AND CL,80
83E0 60              ; AND EAX,60
0FB6D1               ; MOVZX EDX,CL
0BF0                 ; OR ESI,EAX
0FB685 4DFFFFFF      ; MOVZX EAX,BYTE PTR SS:[EBP-B3]

5F              ; pop edi
)

		this._setPatchData( 0x469032, 0x46919e, 0x400c00, 0x104, pd )
	}
}

