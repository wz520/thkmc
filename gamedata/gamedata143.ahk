﻿class THKMC_GameData143 extends THKMC_GameDataBase {
	__New( ) {
		base.__New("th143", "弹幕天邪鬼 1.00a", 0x53546435, 939008)
		pd = 
(LTrim Comment

0FB6B5 40FFFFFF    ;  MOVZX ESI,BYTE PTR SS:[EBP-C0]
0FB685 0FFFFFFF    ;  MOVZX EAX,BYTE PTR SS:[EBP-F1]

57                 ;  PUSH EDI
BF 80000000        ;  MOV EDI,80
21f8 ; and eax,edi
21FE               ;  AND ESI,EDI
C1E6 02            ;  SHL ESI,2
0BF0               ;  OR ESI,EAX

0FB68D 15FFFFFF   ; MOVZX ECX,BYTE PTR SS:[EBP-EB]
0FB685 1CFFFFFF   ; MOVZX EAX,BYTE PTR SS:[EBP-E4]
03F6              ; ADD ESI,ESI
21f8 ; and eax,edi
0FB695 2AFFFFFF   ; MOVZX EDX,BYTE PTR SS:[EBP-D6]
0BF0              ; OR ESI,EAX
0FB685 18FFFFFF   ; MOVZX EAX,BYTE PTR SS:[EBP-E8]
21f8 ; and eax,edi
03F6              ; ADD ESI,ESI
0BF0              ; OR ESI,EAX
0fb685 C3ffffff         ; MOVZX EAX,BYTE PTR SS:[EBP-3D]
0BC8              ; OR ECX,EAX
03F6              ; ADD ESI,ESI
0FB685 1BFFFFFF   ; MOVZX EAX,BYTE PTR SS:[EBP-E5]
21f9 ; and ecx,edi
0BF1              ; OR ESI,ECX
21f8 ; and eax,edi
03F6              ; ADD ESI,ESI
0FB68D 44FFFFFF   ; MOVZX ECX,BYTE PTR SS:[EBP-BC]
0BF0              ; OR ESI,EAX
0FB685 0CFFFFFF   ; MOVZX EAX,BYTE PTR SS:[EBP-F4]
21f8 ; and eax,edi
03F6              ; ADD ESI,ESI
0BF0              ; OR ESI,EAX
8BC2              ; MOV EAX,EDX
21f8 ; and eax,edi
C1E6 05           ; SHL ESI,5
0BF0              ; OR ESI,EAX
21fa ; and edx,edi
0FB685 19FFFFFF   ; MOVZX EAX,BYTE PTR SS:[EBP-E7]
21f8 ; and eax,edi
C1E6 02           ; SHL ESI,2
0BF0              ; OR ESI,EAX
0FB685 FDFEFFFF   ; MOVZX EAX,BYTE PTR SS:[EBP-103]
0BF2              ; OR ESI,EDX
21f8 ; and eax,edi
0FB695 29FFFFFF   ; MOVZX EDX,BYTE PTR SS:[EBP-D7]
03F6              ; ADD ESI,ESI
0BF0              ; OR ESI,EAX
21fa ; and edx,edi
0FB685 28FFFFFF   ; MOVZX EAX,BYTE PTR SS:[EBP-D8]
03F6              ; ADD ESI,ESI
D1E8              ; SHR EAX,1
0BD0              ; OR EDX,EAX
0FB685 26FFFFFF   ; MOVZX EAX,BYTE PTR SS:[EBP-DA]
C1EA 02           ; SHR EDX,2
21f8 ; and eax,edi
0BD0              ; OR EDX,EAX
0fb685 C4ffffff         ; MOVZX EAX,BYTE PTR SS:[EBP-3C]
0BC8              ; OR ECX,EAX
D1EA              ; SHR EDX,1
0FB685 4CFFFFFF   ; MOVZX EAX,BYTE PTR SS:[EBP-B4]
21f9 ; and ecx,edi
0BD1              ; OR EDX,ECX
0fb68d CCffffff         ; MOVZX ECX,BYTE PTR SS:[EBP-34]
0BC8              ; OR ECX,EAX
D1EA              ; SHR EDX,1
0fb685 C7ffffff         ; MOVZX EAX,BYTE PTR SS:[EBP-39]
21f9 ; and ecx,edi
0BD1              ; OR EDX,ECX
0FB68D 47FFFFFF   ; MOVZX ECX,BYTE PTR SS:[EBP-B9]
0BC8              ; OR ECX,EAX
D1EA              ; SHR EDX,1
0fb685 C9ffffff         ; MOVZX EAX,BYTE PTR SS:[EBP-37]
21f9 ; and ecx,edi
0BD1              ; OR EDX,ECX
0FB68D 49FFFFFF   ; MOVZX ECX,BYTE PTR SS:[EBP-B7]
0BC8              ; OR ECX,EAX
D1EA              ; SHR EDX,1
0FB685 45FFFFFF   ; MOVZX EAX,BYTE PTR SS:[EBP-BB]
0BF2              ; OR ESI,EDX
21f9 ; and ecx,edi
0BF1              ; OR ESI,ECX
24 80             ; AND AL,80
0FB6C0            ; MOVZX EAX,AL
F7D8              ; NEG EAX
1BC0              ; SBB EAX,EAX
25 90000000       ; AND EAX,90
0BF0              ; OR ESI,EAX
0FB685 4BFFFFFF   ; MOVZX EAX,BYTE PTR SS:[EBP-B5]
24 80             ; AND AL,80
0FB6C0            ; MOVZX EAX,AL
F7D8              ; NEG EAX
1BC0              ; SBB EAX,EAX
83E0 60           ; AND EAX,60
0BF0              ; OR ESI,EAX
0FB685 43FFFFFF   ; MOVZX EAX,BYTE PTR SS:[EBP-BD]
24 80             ; AND AL,80
0FB6C0            ; MOVZX EAX,AL
F7D8              ; NEG EAX
1BC0              ; SBB EAX,EAX
83E0 50           ; AND EAX,50
0BF0              ; OR ESI,EAX
0FB685 4DFFFFFF   ; MOVZX EAX,BYTE PTR SS:[EBP-B3]

5F              ; pop edi
	)
		this._setPatchData( 0x4021b7, 0x402339, 0x400c00, 0x104, pd )
	}
}

