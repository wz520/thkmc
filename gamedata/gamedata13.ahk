class THKMC_GameData13 extends THKMC_GameDataBase {
	__New( ) {
		base.__New("th13", "东方神灵庙 1.00c", 0x4e4bc8a5, 790528)
		pd = 
(LTrim Comment
0FB6B5 40FFFFFF  ;   MOVZX ESI,BYTE PTR SS:[EBP-C0]
0FB68D 0FFFFFFF  ;   MOVZX ECX,BYTE PTR SS:[EBP-F1]
0FB695 1CFFFFFF  ;   MOVZX EDX,BYTE PTR SS:[EBP-E4]
57               ; PUSH EDI
BF 80000000      ; MOV EDI,80
21FE             ; AND ESI,EDI
03F6             ;   ADD ESI,ESI
03F6             ;   ADD ESI,ESI
21f9 ; and ecx,edi
0BF1             ;   OR ESI,ECX
0FB68D 18FFFFFF  ;   MOVZX ECX,BYTE PTR SS:[EBP-E8]
03F6             ;   ADD ESI,ESI
21fa ; and edx,edi
0BF2             ;   OR ESI,EDX
0FB695 15FFFFFF  ;   MOVZX EDX,BYTE PTR SS:[EBP-EB]
21f9 ; and ecx,edi
03F6             ;   ADD ESI,ESI
0BF1             ;   OR ESI,ECX
0fb68d C3ffffff        ;   MOVZX ECX,BYTE PTR SS:[EBP-3D]
0BD1             ;   OR EDX,ECX
0FB68D 0CFFFFFF  ;   MOVZX ECX,BYTE PTR SS:[EBP-F4]
0FB685 2AFFFFFF  ;   MOVZX EAX,BYTE PTR SS:[EBP-D6]
03F6             ;   ADD ESI,ESI
21fa ; and edx,edi
0BF2             ;   OR ESI,EDX
0FB695 1BFFFFFF  ;   MOVZX EDX,BYTE PTR SS:[EBP-E5]
03F6             ;   ADD ESI,ESI
21fa ; and edx,edi
0BF2             ;   OR ESI,EDX
21f9 ; and ecx,edi
8BD0             ;   MOV EDX,EAX
03F6             ;   ADD ESI,ESI
0BF1             ;   OR ESI,ECX
0FB68D 19FFFFFF  ;   MOVZX ECX,BYTE PTR SS:[EBP-E7]
C1E6 05          ;   SHL ESI,5
21fa ; and edx,edi
0BF2             ;   OR ESI,EDX
0FB695 FDFEFFFF  ;   MOVZX EDX,BYTE PTR SS:[EBP-103]
21f8 ; and eax,edi
21f9 ; and ecx,edi
03F6             ;   ADD ESI,ESI
03F6             ;   ADD ESI,ESI
0BF1             ;   OR ESI,ECX
0FB68D 28FFFFFF  ;   MOVZX ECX,BYTE PTR SS:[EBP-D8]
0BF0             ;   OR ESI,EAX
0FB685 29FFFFFF  ;   MOVZX EAX,BYTE PTR SS:[EBP-D7]
21f8 ; and eax,edi
D1E9             ;   SHR ECX,1
0BC1             ;   OR EAX,ECX
0FB68D 44FFFFFF  ;   MOVZX ECX,BYTE PTR SS:[EBP-BC]
21fa ; and edx,edi
C1E8 02          ;   SHR EAX,2
03F6             ;   ADD ESI,ESI
0BF2             ;   OR ESI,EDX
0FB695 26FFFFFF  ;   MOVZX EDX,BYTE PTR SS:[EBP-DA]
21fa ; and edx,edi
0BC2             ;   OR EAX,EDX
0fb695 C4ffffff        ;   MOVZX EDX,BYTE PTR SS:[EBP-3C]
0BCA             ;   OR ECX,EDX
0FB695 4CFFFFFF  ;   MOVZX EDX,BYTE PTR SS:[EBP-B4]
D1E8             ;   SHR EAX,1
21f9 ; and ecx,edi
0BC1             ;   OR EAX,ECX
0fb68d CCffffff        ;   MOVZX ECX,BYTE PTR SS:[EBP-34]
0BCA             ;   OR ECX,EDX
0fb695 C7ffffff        ;   MOVZX EDX,BYTE PTR SS:[EBP-39]
D1E8             ;   SHR EAX,1
21f9 ; and ecx,edi
0BC1             ;   OR EAX,ECX
0FB68D 47FFFFFF  ;   MOVZX ECX,BYTE PTR SS:[EBP-B9]
D1E8             ;   SHR EAX,1
0BCA             ;   OR ECX,EDX
0FB695 45FFFFFF  ;   MOVZX EDX,BYTE PTR SS:[EBP-BB]
21f9 ; and ecx,edi
0BC1             ;   OR EAX,ECX
0fb68d C9ffffff        ;   MOVZX ECX,BYTE PTR SS:[EBP-37]
D1E8             ;   SHR EAX,1
03F6             ;   ADD ESI,ESI
0BF0             ;   OR ESI,EAX
0FB685 49FFFFFF  ;   MOVZX EAX,BYTE PTR SS:[EBP-B7]
0BC1             ;   OR EAX,ECX
21f8 ; and eax,edi
0BF0             ;   OR ESI,EAX
8A8D 4BFFFFFF    ;   MOV CL,BYTE PTR SS:[EBP-B5]
80E2 80          ;   AND DL,80
0FB6C2           ;   MOVZX EAX,DL
F7D8             ;   NEG EAX
1BC0             ;   SBB EAX,EAX
80E1 80          ;   AND CL,80
25 90000000      ;   AND EAX,90
0BF0             ;   OR ESI,EAX
8A85 43FFFFFF    ;   MOV AL,BYTE PTR SS:[EBP-BD]
0FB6D1           ;   MOVZX EDX,CL
F7DA             ;   NEG EDX
1BD2             ;   SBB EDX,EDX
24 80            ;   AND AL,80
83E2 60          ;   AND EDX,60
0FB6C8           ;   MOVZX ECX,AL
0BF2             ;   OR ESI,EDX
0FB695 4DFFFFFF  ;   MOVZX EDX,BYTE PTR SS:[EBP-B3]
5F              ; pop edi
	)
		this._setPatchData( 0x471845, 0x4719c6, 0x400c00, 0x104, pd )
	}
}

