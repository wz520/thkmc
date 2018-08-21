" 用于把从 OD 粘贴过来的反汇编list转换成 patchdata 格式的辅助脚本。
"
" 粘贴过来的代码首先要手动把左边的地址去掉（用可视块模式(CTRL+Q)很容易解决，所以就不搞替换命令了），然后在每一行的机器码和汇编码之间加分号（同样用可视块手动来做就够了）。
"
" 当然，要使用本脚本里定义的命令，别忘了先 :source 一下。


" ** 用于 th128+
"
" **【注意】程序通常使用 MOVZX 获取按键状态的指令，但也可能是 MOV。

" and r32, 80h ，将 80h 改成 edi，精简字节码，这样 EXE 中才有空间使用下面的
" KMOVZX 系列命令。
"
" 用了本系列命令后，别忘了在前面加上：
" 57               ; PUSH EDI
" BF 80000000      ; MOV EDI,80
" 代码最后要加上：
" 5F              ; POP EDI
com! KEAX80EDI	%s/^.\+and eax,80$/21f8 ; and eax,edi/gc
com! KEDX80EDI	%s/^.\+and edx,80$/21fa ; and edx,edi/gc
com! KECX80EDI	%s/^.\+and ecx,80$/21f9 ; and ecx,edi/gc
com! KESI80EDI	%s/^.\+and esi,80$/21fe ; and esi,edi/gc

" 与上面类似，只不过源操作数改成了 EBX
com! KEAX80EBX	%s/^.\+and eax,80$/21d8 ; and eax,ebx/gc
com! KEDX80EBX	%s/^.\+and edx,80$/21da ; and edx,ebx/gc
com! KECX80EBX	%s/^.\+and ecx,80$/21d9 ; and ecx,ebx/gc

" 修改 MOVZX R32, BYTE PTR [EBP-XXX]
" 将8位操作数(XXX)改成32位
com! KMOVZXBYTEEAX	%s/^0fb645 \(\x\{2}\>\)/0fb685 \1ffffff/gc
com! KMOVZXBYTEEDX	%s/^0fb655 \(\x\{2}\>\)/0fb695 \1ffffff/gc
com! KMOVZXBYTEECX	%s/^0fb64d \(\x\{2}\>\)/0fb68d \1ffffff/gc


" ** 用于使用 ESP 访问局部变量的游戏(th10, th11, th12, th125, alcostg)

" 与 KXXX80EBX 类似，只不过源操作数改成了 BL，且目标操作数也都是 8 位（AL, CL, DL）
com! KAL80BL	%s/^.\+and al,80$/20d8 ; and al,bl/gc
com! KCL80BL	%s/^.\+and cl,80$/20d9 ; and cl,bl/gc
com! KDL80BL	%s/^.\+and dl,80$/20da ; and dl,bl/gc

" 修改 MOVZX R32, BYTE PTR [ESP+XXX]
" 将8位操作数(XXX)改成32位
com! KESPMOVZXBYTEESI	%s/^0fb67424 \(\x\{2}\>\)/0fb6b424 \1000000/gc
com! KESPMOVZXBYTEEAX	%s/^0fb64424 \(\x\{2}\>\)/0fb68424 \1000000/gc
com! KESPMOVZXBYTEECX	%s/^0fb64c24 \(\x\{2}\>\)/0fb68c24 \1000000/gc
com! KESPMOVZXBYTEEDX	%s/^0fb65424 \(\x\{2}\>\)/0fb69424 \1000000/gc

" 修改 MOVZX R32, BYTE PTR [ESP+XXX]
" 将32位操作数(XXX)改成8位
com! K32T8ESPMOVZXBYTEESI	%s/^0fb6b424 \(\x\{2}\)000000\>/0fb67424 \1/gc
com! K32T8ESPMOVZXBYTEEAX	%s/^0fb68424 \(\x\{2}\)000000\>/0fb64424 \1/gc
com! K32T8ESPMOVZXBYTEECX	%s/^0fb68c24 \(\x\{2}\)000000\>/0fb64c24 \1/gc
com! K32T8ESPMOVZXBYTEEDX	%s/^0fb69424 \(\x\{2}\)000000\>/0fb65424 \1/gc

" 同上注意与上面的不同之处，这是 MOV 不是 MOVZX，目标操作数是 8 位
com! K32T8ESPMOVBYTEAL	%s/^8a8424 \(\x\{2}\)000000\>/8a4424 \1/gc
com! K32T8ESPMOVBYTECL	%s/^8a8c24 \(\x\{2}\)000000\>/8a4c24 \1/gc
com! K32T8ESPMOVBYTEDL	%s/^8a9424 \(\x\{2}\)000000\>/8a5424 \1/gc
com! K32T8ESPMOVBYTEBL	%s/^8a9c24 \(\x\{2}\)000000\>/8a5c24 \1/gc

" 修改 OR R8， BYTE PTR [ESP+XXX]
" 将32位操作数(XXX)改成8位
" 同上注意与上面的不同之处，这是 MOV 不是 MOVZX，目标操作数是 8 位
com! K32T8ESPORBYTEAL	%s/^0a8424 \(\x\{2}\)000000\>/0a4424 \1/gc
com! K32T8ESPORBYTECL	%s/^0a8c24 \(\x\{2}\)000000\>/0a4c24 \1/gc
com! K32T8ESPORBYTEDL	%s/^0a9424 \(\x\{2}\)000000\>/0a5424 \1/gc

" 对 [ESP+xxx] 或 [ESP-xxx] 中的 xxx 进行十六进制加减运算，并将替换掉原来的值
" --- 这个用于操作分号左边的机器码
com! -nargs=1 -range=% KADD  <line1>,<line2>s/^\%(0fb6\|8a\|0a\)\x\{2}24\s\zs\x\{2}\ze\>/\=<SID>AddHex(submatch(0),<args>)/gc
" --- 这个用于操作分号右边的注释
com! -nargs=1 -range=% KADDForComment  <line1>,<line2>s/ESP\zs[+-]\x\{1,2}\ze/\=<SID>AddHexForComment(submatch(0),<args>)/gc

fun! s:AddHex( m, n ) "{{{
	let result = str2nr(a:m,16) + a:n
	if result < 0
		let result = and(result, 0xff)
	endif
	return printf("%02X", result )  "  只需 8-bit
endfunction "}}}

fun! s:AddHexForComment( m, n ) "{{{
	let result = str2nr(a:m,16) + a:n
	if result < 0
		" let result = and(result, 0xff)
		let result = -result
		return printf("-%02X", result )  "  只需 8-bit
	else
		return printf("+%02X", result )  "  只需 8-bit
	endif
endfunction "}}}

