start:
	mov ax, 07C0h
	add ax, 288
	mov ss, ax
	mov sp, 4096
	mov ax, 07C0h
	mov ds, ax
	;;PRINTING
	msg db "hello", 0
	msgd db "OPA LINHA 2", 0
	mov si, msg
	call print_string
	;mov si, msgd
	;call print_string
	jmp $
print_string:
	mov ah, 0Eh
.repeat:
	lodsb
	cmp al, 0
	je .done
	int 10h
	jmp .repeat
.done:
	ret
	times 510 - ($-$$) db 0	;; Pad with zeros
	dw 0xaa55               ;; Boot signature