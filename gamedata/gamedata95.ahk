﻿class THKMC_GameData95 extends THKMC_GameDataBase {
	__New( ) {
		base.__New("th95", "东方文花帖 1.02a", 0x43c68d3f, 696832)


		pd = 
(LTrim Comment

53               ; PUSH EBX
BB 80000000      ; MOV EBX,80

0fb68d C8ffffff     ;       MOVZX ECX,BYTE PTR SS:[EBP-38]
21d9 ; and ecx,ebx
F7D9                ; NEG ECX
1BC9                ; SBB ECX,ECX
83E1 10             ; AND ECX,10
0FB795 FCFEFFFF     ; MOVZX EDX,WORD PTR SS:[EBP-104]
0BD1                ; OR EDX,ECX
66:8995 FCFEFFFF    ; MOV WORD PTR SS:[EBP-104],DX
0fb685 D0ffffff     ;       MOVZX EAX,BYTE PTR SS:[EBP-30]
21d8 ; and eax,ebx
F7D8                ; NEG EAX
1BC0                ; SBB EAX,EAX
83E0 20             ; AND EAX,20
0FB78D FCFEFFFF     ; MOVZX ECX,WORD PTR SS:[EBP-104]
0BC8                ; OR ECX,EAX
66:898D FCFEFFFF    ; MOV WORD PTR SS:[EBP-104],CX
0fb695 CBffffff     ;       MOVZX EDX,BYTE PTR SS:[EBP-35]
21da ; and edx,ebx
F7DA                ; NEG EDX
1BD2                ; SBB EDX,EDX
83E2 40             ; AND EDX,40
0FB785 FCFEFFFF     ; MOVZX EAX,WORD PTR SS:[EBP-104]
0BC2                ; OR EAX,EDX
66:8985 FCFEFFFF    ; MOV WORD PTR SS:[EBP-104],AX
0fb68d CDffffff     ;       MOVZX ECX,BYTE PTR SS:[EBP-33]
21d9 ; and ecx,ebx
F7D9                ; NEG ECX
1BC9                ; SBB ECX,ECX
21d9 ; and ecx,ebx
0FB795 FCFEFFFF     ; MOVZX EDX,WORD PTR SS:[EBP-104]
0BD1                ; OR EDX,ECX
66:8995 FCFEFFFF    ; MOV WORD PTR SS:[EBP-104],DX
0FB685 2CFFFFFF     ; MOVZX EAX,BYTE PTR SS:[EBP-D4]
21d8 ; and eax,ebx
F7D8                ; NEG EAX
1BC0                ; SBB EAX,EAX
83E0 02             ; AND EAX,2
0FB78D FCFEFFFF     ; MOVZX ECX,WORD PTR SS:[EBP-104]
0BC8                ; OR ECX,EAX
66:898D FCFEFFFF    ; MOV WORD PTR SS:[EBP-104],CX
0FB695 2DFFFFFF     ; MOVZX EDX,BYTE PTR SS:[EBP-D3]
21da ; and edx,ebx
F7DA                ; NEG EDX
1BD2                ; SBB EDX,EDX
F7DA                ; NEG EDX
0FB785 FCFEFFFF     ; MOVZX EAX,WORD PTR SS:[EBP-104]
0BC2                ; OR EAX,EDX
66:8985 FCFEFFFF    ; MOV WORD PTR SS:[EBP-104],AX
0FB68D 2AFFFFFF     ; MOVZX ECX,BYTE PTR SS:[EBP-D6]
21d9 ; and ecx,ebx
F7D9                ; NEG ECX
1BC9                ; SBB ECX,ECX
83E1 05             ; AND ECX,5
0FB795 FCFEFFFF     ; MOVZX EDX,WORD PTR SS:[EBP-104]
0BD1                ; OR EDX,ECX
66:8995 FCFEFFFF    ; MOV WORD PTR SS:[EBP-104],DX
0FB685 48FFFFFF     ; MOVZX EAX,BYTE PTR SS:[EBP-B8]
21d8 ; and eax,ebx
F7D8                ; NEG EAX
1BC0                ; SBB EAX,EAX
83E0 10             ; AND EAX,10
0FB78D FCFEFFFF     ; MOVZX ECX,WORD PTR SS:[EBP-104]
0BC8                ; OR ECX,EAX
66:898D FCFEFFFF    ; MOV WORD PTR SS:[EBP-104],CX
0FB695 50FFFFFF     ; MOVZX EDX,BYTE PTR SS:[EBP-B0]
21da ; and edx,ebx
F7DA                ; NEG EDX
1BD2                ; SBB EDX,EDX
83E2 20             ; AND EDX,20
0FB785 FCFEFFFF     ; MOVZX EAX,WORD PTR SS:[EBP-104]
0BC2                ; OR EAX,EDX
66:8985 FCFEFFFF    ; MOV WORD PTR SS:[EBP-104],AX
0FB68D 4BFFFFFF     ; MOVZX ECX,BYTE PTR SS:[EBP-B5]
21d9 ; and ecx,ebx
F7D9                ; NEG ECX
1BC9                ; SBB ECX,ECX
83E1 40             ; AND ECX,40
0FB795 FCFEFFFF     ; MOVZX EDX,WORD PTR SS:[EBP-104]
0BD1                ; OR EDX,ECX
66:8995 FCFEFFFF    ; MOV WORD PTR SS:[EBP-104],DX
0FB685 4DFFFFFF     ; MOVZX EAX,BYTE PTR SS:[EBP-B3]
21d8 ; and eax,ebx
F7D8                ; NEG EAX
1BC0                ; SBB EAX,EAX
21d8 ; and eax,ebx
0FB78D FCFEFFFF     ; MOVZX ECX,WORD PTR SS:[EBP-104]
0BC8                ; OR ECX,EAX
66:898D FCFEFFFF    ; MOV WORD PTR SS:[EBP-104],CX
0FB695 47FFFFFF     ; MOVZX EDX,BYTE PTR SS:[EBP-B9]
21da ; and edx,ebx
F7DA                ; NEG EDX
1BD2                ; SBB EDX,EDX
83E2 50             ; AND EDX,50
0FB785 FCFEFFFF     ; MOVZX EAX,WORD PTR SS:[EBP-104]
0BC2                ; OR EAX,EDX
66:8985 FCFEFFFF    ; MOV WORD PTR SS:[EBP-104],AX
0FB68D 49FFFFFF     ; MOVZX ECX,BYTE PTR SS:[EBP-B7]
21d9 ; and ecx,ebx
F7D9                ; NEG ECX
1BC9                ; SBB ECX,ECX
81E1 90000000       ; AND ECX,90
0FB795 FCFEFFFF     ; MOVZX EDX,WORD PTR SS:[EBP-104]
0BD1                ; OR EDX,ECX
66:8995 FCFEFFFF    ; MOV WORD PTR SS:[EBP-104],DX
0FB685 4FFFFFFF     ; MOVZX EAX,BYTE PTR SS:[EBP-B1]
21d8 ; and eax,ebx
F7D8                ; NEG EAX
1BC0                ; SBB EAX,EAX
83E0 60             ; AND EAX,60
0FB78D FCFEFFFF     ; MOVZX ECX,WORD PTR SS:[EBP-104]
0BC8                ; OR ECX,EAX
66:898D FCFEFFFF    ; MOV WORD PTR SS:[EBP-104],CX
0FB695 51FFFFFF     ; MOVZX EDX,BYTE PTR SS:[EBP-AF]
21da ; and edx,ebx
F7DA                ; NEG EDX
1BD2                ; SBB EDX,EDX
81E2 A0000000       ; AND EDX,0A0
0FB785 FCFEFFFF     ; MOVZX EAX,WORD PTR SS:[EBP-104]
0BC2                ; OR EAX,EDX
66:8985 FCFEFFFF    ; MOV WORD PTR SS:[EBP-104],AX
0FB685 1DFFFFFF     ; MOVZX EAX,BYTE PTR SS:[EBP-E3]
21d8 ; and eax,ebx
F7D8                ; NEG EAX
1BC0                ; SBB EAX,EAX
25 00010000         ; AND EAX,100
0FB78D FCFEFFFF     ; MOVZX ECX,WORD PTR SS:[EBP-104]
0BC8                ; OR ECX,EAX
66:898D FCFEFFFF    ; MOV WORD PTR SS:[EBP-104],CX
0FB695 01FFFFFF     ; MOVZX EDX,BYTE PTR SS:[EBP-FF]
21da ; and edx,ebx
F7DA                ; NEG EDX
1BD2                ; SBB EDX,EDX
83E2 08             ; AND EDX,8
0FB785 FCFEFFFF     ; MOVZX EAX,WORD PTR SS:[EBP-104]
0BC2                ; OR EAX,EDX
66:8985 FCFEFFFF    ; MOV WORD PTR SS:[EBP-104],AX
0FB68D 1CFFFFFF     ; MOVZX ECX,BYTE PTR SS:[EBP-E4]
21d9 ; and ecx,ebx
F7D9                ; NEG ECX
1BC9                ; SBB ECX,ECX
81E1 00100000       ; AND ECX,1000
0FB795 FCFEFFFF     ; MOVZX EDX,WORD PTR SS:[EBP-104]
0BD1                ; OR EDX,ECX
66:8995 FCFEFFFF    ; MOV WORD PTR SS:[EBP-104],DX
0fb685 C7ffffff     ;       MOVZX EAX,BYTE PTR SS:[EBP-39]
21d8 ; and eax,ebx
F7D8                ; NEG EAX
1BC0                ; SBB EAX,EAX
25 00080000         ; AND EAX,800
0FB78D FCFEFFFF     ; MOVZX ECX,WORD PTR SS:[EBP-104]
0BC8                ; OR ECX,EAX
66:898D FCFEFFFF    ; MOV WORD PTR SS:[EBP-104],CX
0FB695 19FFFFFF     ; MOVZX EDX,BYTE PTR SS:[EBP-E7]
21da ; and edx,ebx
F7DA                ; NEG EDX
1BD2                ; SBB EDX,EDX
81E2 00080000       ; AND EDX,800
0FB785 FCFEFFFF     ; MOVZX EAX,WORD PTR SS:[EBP-104]
0BC2                ; OR EAX,EDX
66:8985 FCFEFFFF    ; MOV WORD PTR SS:[EBP-104],AX
0FB68D 20FFFFFF     ; MOVZX ECX,BYTE PTR SS:[EBP-E0]
21d9 ; and ecx,ebx
F7D9                ; NEG ECX
1BC9                ; SBB ECX,ECX
81E1 00200000       ; AND ECX,2000
0FB795 FCFEFFFF     ; MOVZX EDX,WORD PTR SS:[EBP-104]
0BD1                ; OR EDX,ECX
66:8995 FCFEFFFF    ; MOV WORD PTR SS:[EBP-104],DX
0FB685 10FFFFFF     ; MOVZX EAX,BYTE PTR SS:[EBP-F0]
21d8 ; and eax,ebx
F7D8                ; NEG EAX
1BC0                ; SBB EAX,EAX
25 00020000         ; AND EAX,200
0FB78D FCFEFFFF     ; MOVZX ECX,WORD PTR SS:[EBP-104]
0BC8                ; OR ECX,EAX
66:898D FCFEFFFF    ; MOV WORD PTR SS:[EBP-104],CX
0FB695 1FFFFFFF     ; MOVZX EDX,BYTE PTR SS:[EBP-E1]
21da ; and edx,ebx
F7DA                ; NEG EDX
1BD2                ; SBB EDX,EDX
81E2 00040000       ; AND EDX,400
0FB785 FCFEFFFF     ; MOVZX EAX,WORD PTR SS:[EBP-104]
0BC2                ; OR EAX,EDX
66:8985 FCFEFFFF    ; MOV WORD PTR SS:[EBP-104],AX
0FB68D 13FFFFFF     ; MOVZX ECX,BYTE PTR SS:[EBP-ED]
21d9 ; and ecx,ebx
F7D9                ; NEG ECX
1BC9                ; SBB ECX,ECX
81E1 00400000       ; AND ECX,4000
0FB795 FCFEFFFF     ; MOVZX EDX,WORD PTR SS:[EBP-104]
0BD1                ; OR EDX,ECX
66:8995 FCFEFFFF    ; MOV WORD PTR SS:[EBP-104],DX
0FB685 26FFFFFF     ; MOVZX EAX,BYTE PTR SS:[EBP-DA]

5B              ; pop ebx
	)
		this._setPatchData( 0x419f4e, 0x41a2bd, 0x400C00, 0x100, pd )
	}
}
