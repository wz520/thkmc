class THKMC_GameData7 extends THKMC_GameDataBase {
	__New( ) {
		base.__New("th7", "东方妖妖梦 1.00b", 0x3F983F81, 650752)
		pd = 
(LTrim Comment
0fb685 C8ffffff              ; MOVZX EAX,BYTE PTR SS:[EBP-38]
57 ; push edi
BF 80000000 ; mov edi, 80
21f8 ; and eax,edi
F7D8                   ; NEG EAX
1BC0                   ; SBB EAX,EAX
83E0 10                ; AND EAX,10
0FB78D FCFEFFFF        ; MOVZX ECX,WORD PTR SS:[EBP-104]
0BC8                   ; OR ECX,EAX
66:898D FCFEFFFF       ; MOV WORD PTR SS:[EBP-104],CX
0fb695 D0ffffff              ; MOVZX EDX,BYTE PTR SS:[EBP-30]
21fa ; and edx,edi
F7DA                   ; NEG EDX
1BD2                   ; SBB EDX,EDX
83E2 20                ; AND EDX,20
0FB785 FCFEFFFF        ; MOVZX EAX,WORD PTR SS:[EBP-104]
0BC2                   ; OR EAX,EDX
66:8985 FCFEFFFF       ; MOV WORD PTR SS:[EBP-104],AX
0fb68d CBffffff              ; MOVZX ECX,BYTE PTR SS:[EBP-35]
21f9 ; and ecx,edi
F7D9                   ; NEG ECX
1BC9                   ; SBB ECX,ECX
83E1 40                ; AND ECX,40
0FB795 FCFEFFFF        ; MOVZX EDX,WORD PTR SS:[EBP-104]
0BD1                   ; OR EDX,ECX
66:8995 FCFEFFFF       ; MOV WORD PTR SS:[EBP-104],DX
0fb685 CDffffff              ; MOVZX EAX,BYTE PTR SS:[EBP-33]
21f8 ; and eax,edi
F7D8                   ; NEG EAX
1BC0                   ; SBB EAX,EAX
21f8 ; and eax,edi
0FB78D FCFEFFFF        ; MOVZX ECX,WORD PTR SS:[EBP-104]
0BC8                   ; OR ECX,EAX
66:898D FCFEFFFF       ; MOV WORD PTR SS:[EBP-104],CX
0FB695 48FFFFFF        ; MOVZX EDX,BYTE PTR SS:[EBP-B8]
21fa ; and edx,edi
F7DA                   ; NEG EDX
1BD2                   ; SBB EDX,EDX
83E2 10                ; AND EDX,10
0FB785 FCFEFFFF        ; MOVZX EAX,WORD PTR SS:[EBP-104]
0BC2                   ; OR EAX,EDX
66:8985 FCFEFFFF       ; MOV WORD PTR SS:[EBP-104],AX
0FB68D 50FFFFFF        ; MOVZX ECX,BYTE PTR SS:[EBP-B0]
21f9 ; and ecx,edi
F7D9                   ; NEG ECX
1BC9                   ; SBB ECX,ECX
83E1 20                ; AND ECX,20
0FB795 FCFEFFFF        ; MOVZX EDX,WORD PTR SS:[EBP-104]
0BD1                   ; OR EDX,ECX
66:8995 FCFEFFFF       ; MOV WORD PTR SS:[EBP-104],DX
0FB685 4BFFFFFF        ; MOVZX EAX,BYTE PTR SS:[EBP-B5]
21f8 ; and eax,edi
F7D8                   ; NEG EAX
1BC0                   ; SBB EAX,EAX
83E0 40                ; AND EAX,40
0FB78D FCFEFFFF        ; MOVZX ECX,WORD PTR SS:[EBP-104]
0BC8                   ; OR ECX,EAX
66:898D FCFEFFFF       ; MOV WORD PTR SS:[EBP-104],CX
0FB695 4DFFFFFF        ; MOVZX EDX,BYTE PTR SS:[EBP-B3]
21fa ; and edx,edi
F7DA                   ; NEG EDX
1BD2                   ; SBB EDX,EDX
21fa ; and edx,edi
0FB785 FCFEFFFF        ; MOVZX EAX,WORD PTR SS:[EBP-104]
0BC2                   ; OR EAX,EDX
66:8985 FCFEFFFF       ; MOV WORD PTR SS:[EBP-104],AX
0FB68D 47FFFFFF        ; MOVZX ECX,BYTE PTR SS:[EBP-B9]
21f9 ; and ecx,edi
F7D9                   ; NEG ECX
1BC9                   ; SBB ECX,ECX
83E1 50                ; AND ECX,50
0FB795 FCFEFFFF        ; MOVZX EDX,WORD PTR SS:[EBP-104]
0BD1                   ; OR EDX,ECX
66:8995 FCFEFFFF       ; MOV WORD PTR SS:[EBP-104],DX
0FB685 49FFFFFF        ; MOVZX EAX,BYTE PTR SS:[EBP-B7]
21f8 ; and eax,edi
F7D8                   ; NEG EAX
1BC0                   ; SBB EAX,EAX
25 90000000            ; AND EAX,90
0FB78D FCFEFFFF        ; MOVZX ECX,WORD PTR SS:[EBP-104]
0BC8                   ; OR ECX,EAX
66:898D FCFEFFFF       ; MOV WORD PTR SS:[EBP-104],CX
0FB695 4FFFFFFF        ; MOVZX EDX,BYTE PTR SS:[EBP-B1]
21fa ; and edx,edi
F7DA                   ; NEG EDX
1BD2                   ; SBB EDX,EDX
83E2 60                ; AND EDX,60
0FB785 FCFEFFFF        ; MOVZX EAX,WORD PTR SS:[EBP-104]
0BC2                   ; OR EAX,EDX
66:8985 FCFEFFFF       ; MOV WORD PTR SS:[EBP-104],AX
0FB68D 51FFFFFF        ; MOVZX ECX,BYTE PTR SS:[EBP-AF]
21f9 ; and ecx,edi
F7D9                   ; NEG ECX
1BC9                   ; SBB ECX,ECX
81E1 A0000000          ; AND ECX,0A0
0FB795 FCFEFFFF        ; MOVZX EDX,WORD PTR SS:[EBP-104]
0BD1                   ; OR EDX,ECX
66:8995 FCFEFFFF       ; MOV WORD PTR SS:[EBP-104],DX
0fb685 C7ffffff              ; MOVZX EAX,BYTE PTR SS:[EBP-39]
21f8 ; and eax,edi
F7D8                   ; NEG EAX
1BC0                   ; SBB EAX,EAX
25 00080000            ; AND EAX,800
0FB78D FCFEFFFF        ; MOVZX ECX,WORD PTR SS:[EBP-104]
0BC8                   ; OR ECX,EAX
66:898D FCFEFFFF       ; MOV WORD PTR SS:[EBP-104],CX
0FB695 20FFFFFF        ; MOVZX EDX,BYTE PTR SS:[EBP-E0]
21fa ; and edx,edi
F7DA                   ; NEG EDX
1BD2                   ; SBB EDX,EDX
81E2 00200000          ; AND EDX,2000
0FB785 FCFEFFFF        ; MOVZX EAX,WORD PTR SS:[EBP-104]
0BC2                   ; OR EAX,EDX
66:8985 FCFEFFFF       ; MOV WORD PTR SS:[EBP-104],AX
0FB68D 2CFFFFFF        ; MOVZX ECX,BYTE PTR SS:[EBP-D4]
21f9 ; and ecx,edi
F7D9                   ; NEG ECX
1BC9                   ; SBB ECX,ECX
F7D9                   ; NEG ECX
0FB795 FCFEFFFF        ; MOVZX EDX,WORD PTR SS:[EBP-104]
0BD1                   ; OR EDX,ECX
66:8995 FCFEFFFF       ; MOV WORD PTR SS:[EBP-104],DX
0FB685 2DFFFFFF        ; MOVZX EAX,BYTE PTR SS:[EBP-D3]
21f8 ; and eax,edi
F7D8                   ; NEG EAX
1BC0                   ; SBB EAX,EAX
83E0 02                ; AND EAX,2
0FB78D FCFEFFFF        ; MOVZX ECX,WORD PTR SS:[EBP-104]
0BC8                   ; OR ECX,EAX
66:898D FCFEFFFF       ; MOV WORD PTR SS:[EBP-104],CX
0FB695 2AFFFFFF        ; MOVZX EDX,BYTE PTR SS:[EBP-D6]
21fa ; and edx,edi
F7DA                   ; NEG EDX
1BD2                   ; SBB EDX,EDX
83E2 04                ; AND EDX,4
0FB785 FCFEFFFF        ; MOVZX EAX,WORD PTR SS:[EBP-104]
0BC2                   ; OR EAX,EDX
66:8985 FCFEFFFF       ; MOV WORD PTR SS:[EBP-104],AX
0FB68D 36FFFFFF        ; MOVZX ECX,BYTE PTR SS:[EBP-CA]
21f9 ; and ecx,edi
F7D9                   ; NEG ECX
1BC9                   ; SBB ECX,ECX
83E1 04                ; AND ECX,4
0FB795 FCFEFFFF        ; MOVZX EDX,WORD PTR SS:[EBP-104]
0BD1                   ; OR EDX,ECX
66:8995 FCFEFFFF       ; MOV WORD PTR SS:[EBP-104],DX
0FB685 01FFFFFF        ; MOVZX EAX,BYTE PTR SS:[EBP-FF]
21f8 ; and eax,edi
F7D8                   ; NEG EAX
1BC0                   ; SBB EAX,EAX
83E0 08                ; AND EAX,8
0FB78D FCFEFFFF        ; MOVZX ECX,WORD PTR SS:[EBP-104]
0BC8                   ; OR ECX,EAX
66:898D FCFEFFFF       ; MOV WORD PTR SS:[EBP-104],CX
0FB695 1DFFFFFF        ; MOVZX EDX,BYTE PTR SS:[EBP-E3]
21fa ; and edx,edi
F7DA                   ; NEG EDX
1BD2                   ; SBB EDX,EDX
81E2 00010000          ; AND EDX,100
0FB785 FCFEFFFF        ; MOVZX EAX,WORD PTR SS:[EBP-104]
0BC2                   ; OR EAX,EDX
66:8985 FCFEFFFF       ; MOV WORD PTR SS:[EBP-104],AX
0fb68d 9Dffffff              ; MOVZX ECX,BYTE PTR SS:[EBP-63]
21f9 ; and ecx,edi
F7D9                   ; NEG ECX
1BC9                   ; SBB ECX,ECX
81E1 00010000          ; AND ECX,100
0FB795 FCFEFFFF        ; MOVZX EDX,WORD PTR SS:[EBP-104]
0BD1                   ; OR EDX,ECX
66:8995 FCFEFFFF       ; MOV WORD PTR SS:[EBP-104],DX
0FB685 10FFFFFF        ; MOVZX EAX,BYTE PTR SS:[EBP-F0]
21f8 ; and eax,edi
F7D8                   ; NEG EAX
1BC0                   ; SBB EAX,EAX
25 00020000            ; AND EAX,200
0FB78D FCFEFFFF        ; MOVZX ECX,WORD PTR SS:[EBP-104]
0BC8                   ; OR ECX,EAX
66:898D FCFEFFFF       ; MOV WORD PTR SS:[EBP-104],CX
0FB695 1FFFFFFF        ; MOVZX EDX,BYTE PTR SS:[EBP-E1]
21fa ; and edx,edi
F7DA                   ; NEG EDX
1BD2                   ; SBB EDX,EDX
81E2 00040000          ; AND EDX,400
0FB785 FCFEFFFF        ; MOVZX EAX,WORD PTR SS:[EBP-104]
0BC2                   ; OR EAX,EDX
66:8985 FCFEFFFF       ; MOV WORD PTR SS:[EBP-104],AX
0FB68D 1CFFFFFF        ; MOVZX ECX,BYTE PTR SS:[EBP-E4]
21f9 ; and ecx,edi
F7D9                   ; NEG ECX
1BC9                   ; SBB ECX,ECX
81E1 00100000          ; AND ECX,1000
0FB795 FCFEFFFF        ; MOVZX EDX,WORD PTR SS:[EBP-104]
0BD1                   ; OR EDX,ECX
66:8995 FCFEFFFF       ; MOV WORD PTR SS:[EBP-104],DX
0FB685 13FFFFFF        ; MOVZX EAX,BYTE PTR SS:[EBP-ED]
21f8 ; and eax,edi
5F ; pop edi
	)
		this._setPatchData( 0x430f2a, 0x431298, 0x400C00, 0x100, pd )
	}

	doCustomPatch( pExeData ) {
		; 检查是否中文版
		result := compareHexToBinary( "EB56909090", pExeData, 0x37A97 )
		if ( result = 0 ) {
			AddLog("【提示】这是渔场汉化版")
		}
		else {
			; 若不是中文版，则去掉自校验
			writeHexToBinary( "C705145C570000EE0900C705105C57005C44C5AEC3", pExeData, 0x352c0 )
		}
	}
}
