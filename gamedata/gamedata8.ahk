class THKMC_GameData8 extends THKMC_GameDataBase {
	__New( ) {
		base.__New("th8", "东方永夜抄 1.00d", 0x414daf4c, 840704)
		pd = 
(LTrim Comment
53               ; PUSH EBX
BB 80000000      ; MOV EBX,80

0fb695 C8ffffff            ;   MOVZX EDX,BYTE PTR SS:[EBP-38]
21da ; and edx,ebx
F7DA                 ;   NEG EDX
1BD2                 ;   SBB EDX,EDX
83E2 10              ;   AND EDX,10
0FB785 FCFEFFFF      ;   MOVZX EAX,WORD PTR SS:[EBP-104]
0BC2                 ;   OR EAX,EDX
66:8985 FCFEFFFF     ;   MOV WORD PTR SS:[EBP-104],AX
0fb68d D0ffffff            ;   MOVZX ECX,BYTE PTR SS:[EBP-30]
21d9 ; and ecx,ebx
F7D9                 ;   NEG ECX
1BC9                 ;   SBB ECX,ECX
83E1 20              ;   AND ECX,20
0FB795 FCFEFFFF      ;   MOVZX EDX,WORD PTR SS:[EBP-104]
0BD1                 ;   OR EDX,ECX
66:8995 FCFEFFFF     ;   MOV WORD PTR SS:[EBP-104],DX
0fb685 CBffffff            ;   MOVZX EAX,BYTE PTR SS:[EBP-35]
21d8 ; and eax,ebx
F7D8                 ;   NEG EAX
1BC0                 ;   SBB EAX,EAX
83E0 40              ;   AND EAX,40
0FB78D FCFEFFFF      ;   MOVZX ECX,WORD PTR SS:[EBP-104]
0BC8                 ;   OR ECX,EAX
66:898D FCFEFFFF     ;   MOV WORD PTR SS:[EBP-104],CX
0fb695 CDffffff            ;   MOVZX EDX,BYTE PTR SS:[EBP-33]
21da ; and edx,ebx
F7DA                 ;   NEG EDX
1BD2                 ;   SBB EDX,EDX
21da ; and edx,ebx
0FB785 FCFEFFFF      ;   MOVZX EAX,WORD PTR SS:[EBP-104]
0BC2                 ;   OR EAX,EDX
66:8985 FCFEFFFF     ;   MOV WORD PTR SS:[EBP-104],AX
0FB68D 48FFFFFF      ;   MOVZX ECX,BYTE PTR SS:[EBP-B8]
21d9 ; and ecx,ebx
F7D9                 ;   NEG ECX
1BC9                 ;   SBB ECX,ECX
83E1 10              ;   AND ECX,10
0FB795 FCFEFFFF      ;   MOVZX EDX,WORD PTR SS:[EBP-104]
0BD1                 ;   OR EDX,ECX
66:8995 FCFEFFFF     ;   MOV WORD PTR SS:[EBP-104],DX
0FB685 50FFFFFF      ;   MOVZX EAX,BYTE PTR SS:[EBP-B0]
21d8 ; and eax,ebx
F7D8                 ;   NEG EAX
1BC0                 ;   SBB EAX,EAX
83E0 20              ;   AND EAX,20
0FB78D FCFEFFFF      ;   MOVZX ECX,WORD PTR SS:[EBP-104]
0BC8                 ;   OR ECX,EAX
66:898D FCFEFFFF     ;   MOV WORD PTR SS:[EBP-104],CX
0FB695 4BFFFFFF      ;   MOVZX EDX,BYTE PTR SS:[EBP-B5]
21da ; and edx,ebx
F7DA                 ;   NEG EDX
1BD2                 ;   SBB EDX,EDX
83E2 40              ;   AND EDX,40
0FB785 FCFEFFFF      ;   MOVZX EAX,WORD PTR SS:[EBP-104]
0BC2                 ;   OR EAX,EDX
66:8985 FCFEFFFF     ;   MOV WORD PTR SS:[EBP-104],AX
0FB68D 4DFFFFFF      ;   MOVZX ECX,BYTE PTR SS:[EBP-B3]
21d9 ; and ecx,ebx
F7D9                 ;   NEG ECX
1BC9                 ;   SBB ECX,ECX
21d9 ; and ecx,ebx
0FB795 FCFEFFFF      ;   MOVZX EDX,WORD PTR SS:[EBP-104]
0BD1                 ;   OR EDX,ECX
66:8995 FCFEFFFF     ;   MOV WORD PTR SS:[EBP-104],DX
0FB685 47FFFFFF      ;   MOVZX EAX,BYTE PTR SS:[EBP-B9]
21d8 ; and eax,ebx
F7D8                 ;   NEG EAX
1BC0                 ;   SBB EAX,EAX
83E0 50              ;   AND EAX,50
0FB78D FCFEFFFF      ;   MOVZX ECX,WORD PTR SS:[EBP-104]
0BC8                 ;   OR ECX,EAX
66:898D FCFEFFFF     ;   MOV WORD PTR SS:[EBP-104],CX
0FB695 49FFFFFF      ;   MOVZX EDX,BYTE PTR SS:[EBP-B7]
21da ; and edx,ebx
F7DA                 ;   NEG EDX
1BD2                 ;   SBB EDX,EDX
81E2 90000000        ;   AND EDX,90
0FB785 FCFEFFFF      ;   MOVZX EAX,WORD PTR SS:[EBP-104]
0BC2                 ;   OR EAX,EDX
66:8985 FCFEFFFF     ;   MOV WORD PTR SS:[EBP-104],AX
0FB68D 4FFFFFFF      ;   MOVZX ECX,BYTE PTR SS:[EBP-B1]
21d9 ; and ecx,ebx
F7D9                 ;   NEG ECX
1BC9                 ;   SBB ECX,ECX
83E1 60              ;   AND ECX,60
0FB795 FCFEFFFF      ;   MOVZX EDX,WORD PTR SS:[EBP-104]
0BD1                 ;   OR EDX,ECX
66:8995 FCFEFFFF     ;   MOV WORD PTR SS:[EBP-104],DX
0FB685 51FFFFFF      ;   MOVZX EAX,BYTE PTR SS:[EBP-AF]
21d8 ; and eax,ebx
F7D8                 ;   NEG EAX
1BC0                 ;   SBB EAX,EAX
25 A0000000          ;   AND EAX,0A0
0FB78D FCFEFFFF      ;   MOVZX ECX,WORD PTR SS:[EBP-104]
0BC8                 ;   OR ECX,EAX
66:898D FCFEFFFF     ;   MOV WORD PTR SS:[EBP-104],CX
0fb695 C7ffffff            ;   MOVZX EDX,BYTE PTR SS:[EBP-39]
21da ; and edx,ebx
F7DA                 ;   NEG EDX
1BD2                 ;   SBB EDX,EDX
81E2 00080000        ;   AND EDX,800
0FB785 FCFEFFFF      ;   MOVZX EAX,WORD PTR SS:[EBP-104]
0BC2                 ;   OR EAX,EDX
66:8985 FCFEFFFF     ;   MOV WORD PTR SS:[EBP-104],AX
0FB68D 19FFFFFF      ;   MOVZX ECX,BYTE PTR SS:[EBP-E7]
21d9 ; and ecx,ebx
F7D9                 ;   NEG ECX
1BC9                 ;   SBB ECX,ECX
81E1 00080000        ;   AND ECX,800
0FB795 FCFEFFFF      ;   MOVZX EDX,WORD PTR SS:[EBP-104]
0BD1                 ;   OR EDX,ECX
66:8995 FCFEFFFF     ;   MOV WORD PTR SS:[EBP-104],DX
0FB685 20FFFFFF      ;   MOVZX EAX,BYTE PTR SS:[EBP-E0]
21d8 ; and eax,ebx
F7D8                 ;   NEG EAX
1BC0                 ;   SBB EAX,EAX
25 00200000          ;   AND EAX,2000
0FB78D FCFEFFFF      ;   MOVZX ECX,WORD PTR SS:[EBP-104]
0BC8                 ;   OR ECX,EAX
66:898D FCFEFFFF     ;   MOV WORD PTR SS:[EBP-104],CX
0FB695 2CFFFFFF      ;   MOVZX EDX,BYTE PTR SS:[EBP-D4]
21da ; and edx,ebx
F7DA                 ;   NEG EDX
1BD2                 ;   SBB EDX,EDX
F7DA                 ;   NEG EDX
0FB785 FCFEFFFF      ;   MOVZX EAX,WORD PTR SS:[EBP-104]
0BC2                 ;   OR EAX,EDX
66:8985 FCFEFFFF     ;   MOV WORD PTR SS:[EBP-104],AX
0FB68D 2DFFFFFF      ;   MOVZX ECX,BYTE PTR SS:[EBP-D3]
21d9 ; and ecx,ebx
F7D9                 ;   NEG ECX
1BC9                 ;   SBB ECX,ECX
83E1 02              ;   AND ECX,2
0FB795 FCFEFFFF      ;   MOVZX EDX,WORD PTR SS:[EBP-104]
0BD1                 ;   OR EDX,ECX
66:8995 FCFEFFFF     ;   MOV WORD PTR SS:[EBP-104],DX
0FB685 2AFFFFFF      ;   MOVZX EAX,BYTE PTR SS:[EBP-D6]
21d8 ; and eax,ebx
F7D8                 ;   NEG EAX
1BC0                 ;   SBB EAX,EAX
83E0 04              ;   AND EAX,4
0FB78D FCFEFFFF      ;   MOVZX ECX,WORD PTR SS:[EBP-104]
0BC8                 ;   OR ECX,EAX
66:898D FCFEFFFF     ;   MOV WORD PTR SS:[EBP-104],CX
0FB695 36FFFFFF      ;   MOVZX EDX,BYTE PTR SS:[EBP-CA]
21da ; and edx,ebx
F7DA                 ;   NEG EDX
1BD2                 ;   SBB EDX,EDX
83E2 04              ;   AND EDX,4
0FB785 FCFEFFFF      ;   MOVZX EAX,WORD PTR SS:[EBP-104]
0BC2                 ;   OR EAX,EDX
66:8985 FCFEFFFF     ;   MOV WORD PTR SS:[EBP-104],AX
0FB68D 01FFFFFF      ;   MOVZX ECX,BYTE PTR SS:[EBP-FF]
21d9 ; and ecx,ebx
F7D9                 ;   NEG ECX
1BC9                 ;   SBB ECX,ECX
83E1 08              ;   AND ECX,8
0FB795 FCFEFFFF      ;   MOVZX EDX,WORD PTR SS:[EBP-104]
0BD1                 ;   OR EDX,ECX
66:8995 FCFEFFFF     ;   MOV WORD PTR SS:[EBP-104],DX
0FB685 1DFFFFFF      ;   MOVZX EAX,BYTE PTR SS:[EBP-E3]
21d8 ; and eax,ebx
F7D8                 ;   NEG EAX
1BC0                 ;   SBB EAX,EAX
25 00010000          ;   AND EAX,100
0FB78D FCFEFFFF      ;   MOVZX ECX,WORD PTR SS:[EBP-104]
0BC8                 ;   OR ECX,EAX
66:898D FCFEFFFF     ;   MOV WORD PTR SS:[EBP-104],CX
0fb695 9Dffffff            ;   MOVZX EDX,BYTE PTR SS:[EBP-63]
21da ; and edx,ebx
F7DA                 ;   NEG EDX
1BD2                 ;   SBB EDX,EDX
81E2 00010000        ;   AND EDX,100
0FB785 FCFEFFFF      ;   MOVZX EAX,WORD PTR SS:[EBP-104]
0BC2                 ;   OR EAX,EDX
66:8985 FCFEFFFF     ;   MOV WORD PTR SS:[EBP-104],AX
0FB68D 10FFFFFF      ;   MOVZX ECX,BYTE PTR SS:[EBP-F0]
21d9 ; and ecx,ebx
F7D9                 ;   NEG ECX
1BC9                 ;   SBB ECX,ECX
81E1 00020000        ;   AND ECX,200
0FB795 FCFEFFFF      ;   MOVZX EDX,WORD PTR SS:[EBP-104]
0BD1                 ;   OR EDX,ECX
66:8995 FCFEFFFF     ;   MOV WORD PTR SS:[EBP-104],DX
0FB685 1FFFFFFF      ;   MOVZX EAX,BYTE PTR SS:[EBP-E1]
21d8 ; and eax,ebx
F7D8                 ;   NEG EAX
1BC0                 ;   SBB EAX,EAX
25 00040000          ;   AND EAX,400
0FB78D FCFEFFFF      ;   MOVZX ECX,WORD PTR SS:[EBP-104]
0BC8                 ;   OR ECX,EAX
66:898D FCFEFFFF     ;   MOV WORD PTR SS:[EBP-104],CX
0FB695 1CFFFFFF      ;   MOVZX EDX,BYTE PTR SS:[EBP-E4]
21da ; and edx,ebx
F7DA                 ;   NEG EDX
1BD2                 ;   SBB EDX,EDX
81E2 00100000        ;   AND EDX,1000
0FB785 FCFEFFFF      ;   MOVZX EAX,WORD PTR SS:[EBP-104]
0BC2                 ;   OR EAX,EDX
66:8985 FCFEFFFF     ;   MOV WORD PTR SS:[EBP-104],AX
0FB68D 13FFFFFF      ;   MOVZX ECX,BYTE PTR SS:[EBP-ED]

5B              ; pop ebx
	)
		this._setPatchData( 0x43dd9e, 0x43e12e, 0x400200, 0x100, pd )
	}

	doCustomPatch( pExeData ) {
		; 检查是否中文版
		result := compareHexToBinary( "EB5A909090", pExeData, 0x45fd2 )
		if ( result = 0 ) {
			AddLog("【提示】这是渔场汉化版")
		}
		else {
			; 若不是中文版，则去掉自校验
			writeHexToBinary( "C785E8FEFFFF B96168A2 C785F0FEFFFF00D40C00", pExeData, 0x435ef )
		}
	}
}
