class THKMC_GameData6 extends THKMC_GameDataBase {
	__New( ) {
		base.__New("th6", "东方红魔乡 1.02h", 0x3DE9A0FB, 512000)
		pd = 
(LTrim Comment
8B85 C0FFFFFF                 ; MOV EAX,DWORD PTR SS:[EBP-40]
56 ; push esi
57 ; push edi
BE FF000000 ; mov esi, 0ff
BF 80000000 ; mov edi, 80
21f0             ; and eax,esi
21f8           ; and eax,edi
F7D8                    ; NEG EAX
1BC0                    ; SBB EAX,EAX
83E0 10                 ; AND EAX,10
8B8D F4FEFFFF           ; MOV ECX,DWORD PTR SS:[EBP-10C]
81E1 FFFF0000           ; AND ECX,0FFFF
0BC8                    ; OR ECX,EAX
66:898D F4FEFFFF        ; MOV WORD PTR SS:[EBP-10C],CX
8B95 C8FFFFFF                 ; MOV EDX,DWORD PTR SS:[EBP-38]
21f2           ; and edx,esi
21fa           ; and edx,edi
F7DA                    ; NEG EDX
1BD2                    ; SBB EDX,EDX
83E2 20                 ; AND EDX,20
8B85 F4FEFFFF           ; MOV EAX,DWORD PTR SS:[EBP-10C]
25 FFFF0000             ; AND EAX,0FFFF
0BC2                    ; OR EAX,EDX
66:8985 F4FEFFFF        ; MOV WORD PTR SS:[EBP-10C],AX
8B8D C3FFFFFF                 ; MOV ECX,DWORD PTR SS:[EBP-3D]
21f1           ; and ecx,esi
21f9           ; and ecx,edi
F7D9                    ; NEG ECX
1BC9                    ; SBB ECX,ECX
83E1 40                 ; AND ECX,40
8B95 F4FEFFFF           ; MOV EDX,DWORD PTR SS:[EBP-10C]
81E2 FFFF0000           ; AND EDX,0FFFF
0BD1                    ; OR EDX,ECX
66:8995 F4FEFFFF        ; MOV WORD PTR SS:[EBP-10C],DX
8B85 C5FFFFFF                 ; MOV EAX,DWORD PTR SS:[EBP-3B]
21f0             ; and eax,esi
21f8           ; and eax,edi
F7D8                    ; NEG EAX
1BC0                    ; SBB EAX,EAX
21f8           ; and eax,edi
8B8D F4FEFFFF           ; MOV ECX,DWORD PTR SS:[EBP-10C]
81E1 FFFF0000           ; AND ECX,0FFFF
0BC8                    ; OR ECX,EAX
66:898D F4FEFFFF        ; MOV WORD PTR SS:[EBP-10C],CX
8B95 40FFFFFF           ; MOV EDX,DWORD PTR SS:[EBP-C0]
21f2           ; and edx,esi
21fa           ; and edx,edi
F7DA                    ; NEG EDX
1BD2                    ; SBB EDX,EDX
83E2 10                 ; AND EDX,10
8B85 F4FEFFFF           ; MOV EAX,DWORD PTR SS:[EBP-10C]
25 FFFF0000             ; AND EAX,0FFFF
0BC2                    ; OR EAX,EDX
66:8985 F4FEFFFF        ; MOV WORD PTR SS:[EBP-10C],AX
8B8D 48FFFFFF           ; MOV ECX,DWORD PTR SS:[EBP-B8]
21f1           ; and ecx,esi
21f9           ; and ecx,edi
F7D9                    ; NEG ECX
1BC9                    ; SBB ECX,ECX
83E1 20                 ; AND ECX,20
8B95 F4FEFFFF           ; MOV EDX,DWORD PTR SS:[EBP-10C]
81E2 FFFF0000           ; AND EDX,0FFFF
0BD1                    ; OR EDX,ECX
66:8995 F4FEFFFF        ; MOV WORD PTR SS:[EBP-10C],DX
8B85 43FFFFFF           ; MOV EAX,DWORD PTR SS:[EBP-BD]
21f0             ; and eax,esi
21f8           ; and eax,edi
F7D8                    ; NEG EAX
1BC0                    ; SBB EAX,EAX
83E0 40                 ; AND EAX,40
8B8D F4FEFFFF           ; MOV ECX,DWORD PTR SS:[EBP-10C]
81E1 FFFF0000           ; AND ECX,0FFFF
0BC8                    ; OR ECX,EAX
66:898D F4FEFFFF        ; MOV WORD PTR SS:[EBP-10C],CX
8B95 45FFFFFF           ; MOV EDX,DWORD PTR SS:[EBP-BB]
21f2           ; and edx,esi
21fa           ; and edx,edi
F7DA                    ; NEG EDX
1BD2                    ; SBB EDX,EDX
21fa           ; and edx,edi
8B85 F4FEFFFF           ; MOV EAX,DWORD PTR SS:[EBP-10C]
25 FFFF0000             ; AND EAX,0FFFF
0BC2                    ; OR EAX,EDX
66:8985 F4FEFFFF        ; MOV WORD PTR SS:[EBP-10C],AX
8B8D 3FFFFFFF           ; MOV ECX,DWORD PTR SS:[EBP-C1]
21f1           ; and ecx,esi
21f9           ; and ecx,edi
F7D9                    ; NEG ECX
1BC9                    ; SBB ECX,ECX
83E1 50                 ; AND ECX,50
8B95 F4FEFFFF           ; MOV EDX,DWORD PTR SS:[EBP-10C]
81E2 FFFF0000           ; AND EDX,0FFFF
0BD1                    ; OR EDX,ECX
66:8995 F4FEFFFF        ; MOV WORD PTR SS:[EBP-10C],DX
8B85 41FFFFFF           ; MOV EAX,DWORD PTR SS:[EBP-BF]
21f0             ; and eax,esi
21f8           ; and eax,edi
F7D8                    ; NEG EAX
1BC0                    ; SBB EAX,EAX
25 90000000             ; AND EAX,90
8B8D F4FEFFFF           ; MOV ECX,DWORD PTR SS:[EBP-10C]
81E1 FFFF0000           ; AND ECX,0FFFF
0BC8                    ; OR ECX,EAX
66:898D F4FEFFFF        ; MOV WORD PTR SS:[EBP-10C],CX
8B95 47FFFFFF           ; MOV EDX,DWORD PTR SS:[EBP-B9]
21f2           ; and edx,esi
21fa           ; and edx,edi
F7DA                    ; NEG EDX
1BD2                    ; SBB EDX,EDX
83E2 60                 ; AND EDX,60
8B85 F4FEFFFF           ; MOV EAX,DWORD PTR SS:[EBP-10C]
25 FFFF0000             ; AND EAX,0FFFF
0BC2                    ; OR EAX,EDX
66:8985 F4FEFFFF        ; MOV WORD PTR SS:[EBP-10C],AX
8B8D 49FFFFFF           ; MOV ECX,DWORD PTR SS:[EBP-B7]
21f1           ; and ecx,esi
21f9           ; and ecx,edi
F7D9                    ; NEG ECX
1BC9                    ; SBB ECX,ECX
81E1 A0000000           ; AND ECX,0A0
8B95 F4FEFFFF           ; MOV EDX,DWORD PTR SS:[EBP-10C]
81E2 FFFF0000           ; AND EDX,0FFFF
0BD1                    ; OR EDX,ECX
66:8995 F4FEFFFF        ; MOV WORD PTR SS:[EBP-10C],DX
8B85 BFFFFFFF                 ; MOV EAX,DWORD PTR SS:[EBP-41]
21f0             ; and eax,esi
21f8           ; and eax,edi
F7D8                    ; NEG EAX
1BC0                    ; SBB EAX,EAX
25 00080000             ; AND EAX,800
8B8D F4FEFFFF           ; MOV ECX,DWORD PTR SS:[EBP-10C]
81E1 FFFF0000           ; AND ECX,0FFFF
0BC8                    ; OR ECX,EAX
66:898D F4FEFFFF        ; MOV WORD PTR SS:[EBP-10C],CX
8B95 24FFFFFF           ; MOV EDX,DWORD PTR SS:[EBP-DC]
21f2           ; and edx,esi
21fa           ; and edx,edi
F7DA                    ; NEG EDX
1BD2                    ; SBB EDX,EDX
F7DA                    ; NEG EDX
8B85 F4FEFFFF           ; MOV EAX,DWORD PTR SS:[EBP-10C]
25 FFFF0000             ; AND EAX,0FFFF
0BC2                    ; OR EAX,EDX
66:8985 F4FEFFFF        ; MOV WORD PTR SS:[EBP-10C],AX
8B8D 25FFFFFF           ; MOV ECX,DWORD PTR SS:[EBP-DB]
21f1           ; and ecx,esi
21f9           ; and ecx,edi
F7D9                    ; NEG ECX
1BC9                    ; SBB ECX,ECX
83E1 02                 ; AND ECX,2
8B95 F4FEFFFF           ; MOV EDX,DWORD PTR SS:[EBP-10C]
81E2 FFFF0000           ; AND EDX,0FFFF
0BD1                    ; OR EDX,ECX
66:8995 F4FEFFFF        ; MOV WORD PTR SS:[EBP-10C],DX
8B85 22FFFFFF           ; MOV EAX,DWORD PTR SS:[EBP-DE]
21f0             ; and eax,esi
21f8           ; and eax,edi
F7D8                    ; NEG EAX
1BC0                    ; SBB EAX,EAX
83E0 04                 ; AND EAX,4
8B8D F4FEFFFF           ; MOV ECX,DWORD PTR SS:[EBP-10C]
81E1 FFFF0000           ; AND ECX,0FFFF
0BC8                    ; OR ECX,EAX
66:898D F4FEFFFF        ; MOV WORD PTR SS:[EBP-10C],CX
8B95 2EFFFFFF           ; MOV EDX,DWORD PTR SS:[EBP-D2]
21f2           ; and edx,esi
21fa           ; and edx,edi
F7DA                    ; NEG EDX
1BD2                    ; SBB EDX,EDX
83E2 04                 ; AND EDX,4
8B85 F4FEFFFF           ; MOV EAX,DWORD PTR SS:[EBP-10C]
25 FFFF0000             ; AND EAX,0FFFF
0BC2                    ; OR EAX,EDX
66:8985 F4FEFFFF        ; MOV WORD PTR SS:[EBP-10C],AX
8B8D F9FEFFFF           ; MOV ECX,DWORD PTR SS:[EBP-107]
21f1           ; and ecx,esi
21f9           ; and ecx,edi
F7D9                    ; NEG ECX
1BC9                    ; SBB ECX,ECX
83E1 08                 ; AND ECX,8
8B95 F4FEFFFF           ; MOV EDX,DWORD PTR SS:[EBP-10C]
81E2 FFFF0000           ; AND EDX,0FFFF
0BD1                    ; OR EDX,ECX
66:8995 F4FEFFFF        ; MOV WORD PTR SS:[EBP-10C],DX
8B85 15FFFFFF           ; MOV EAX,DWORD PTR SS:[EBP-EB]
21f0             ; and eax,esi
21f8           ; and eax,edi
F7D8                    ; NEG EAX
1BC0                    ; SBB EAX,EAX
25 00010000             ; AND EAX,100
8B8D F4FEFFFF           ; MOV ECX,DWORD PTR SS:[EBP-10C]
81E1 FFFF0000           ; AND ECX,0FFFF
0BC8                    ; OR ECX,EAX
66:898D F4FEFFFF        ; MOV WORD PTR SS:[EBP-10C],CX
8B95 95FFFFFF                 ; MOV EDX,DWORD PTR SS:[EBP-6B]
21f2           ; and edx,esi
21fa           ; and edx,edi
F7DA                    ; NEG EDX
1BD2                    ; SBB EDX,EDX
81E2 00010000           ; AND EDX,100
8B85 F4FEFFFF           ; MOV EAX,DWORD PTR SS:[EBP-10C]
25 FFFF0000             ; AND EAX,0FFFF
0BC2                    ; OR EAX,EDX
66:8985 F4FEFFFF        ; MOV WORD PTR SS:[EBP-10C],AX
8B8D 08FFFFFF           ; MOV ECX,DWORD PTR SS:[EBP-F8]
21f1           ; and ecx,esi
21f9           ; and ecx,edi
F7D9                    ; NEG ECX
1BC9                    ; SBB ECX,ECX
81E1 00020000           ; AND ECX,200
8B95 F4FEFFFF           ; MOV EDX,DWORD PTR SS:[EBP-10C]
81E2 FFFF0000           ; AND EDX,0FFFF
0BD1                    ; OR EDX,ECX
66:8995 F4FEFFFF        ; MOV WORD PTR SS:[EBP-10C],DX
8B85 17FFFFFF           ; MOV EAX,DWORD PTR SS:[EBP-E9]
21f0             ; and eax,esi
21f8           ; and eax,edi
F7D8                    ; NEG EAX
1BC0                    ; SBB EAX,EAX
25 00040000             ; AND EAX,400
8B8D F4FEFFFF           ; MOV ECX,DWORD PTR SS:[EBP-10C]
81E1 FFFF0000           ; AND ECX,0FFFF
0BC8                    ; OR ECX,EAX
66:898D F4FEFFFF        ; MOV WORD PTR SS:[EBP-10C],CX
8B95 14FFFFFF           ; MOV EDX,DWORD PTR SS:[EBP-EC]
21f2           ; and edx,esi
21fa           ; and edx,edi
F7DA                    ; NEG EDX
1BD2                    ; SBB EDX,EDX
81E2 00100000           ; AND EDX,1000
8B85 F4FEFFFF           ; MOV EAX,DWORD PTR SS:[EBP-10C]
25 FFFF0000             ; AND EAX,0FFFF
5F ; pop edi
5E ; pop esi
	)
		this._setPatchData( 0x41dc85, 0x41e08c, 0x400000, 0x108, pd )
		this.addrPattern := "i)\b8b[0-9a-f]+\s([0-9a-z]{2}f[ef]ffff)\s"
	}
}
