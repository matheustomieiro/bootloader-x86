	BITS 16
start:
	mov ax, 07C0h
	mov ds, ax
	mov si, text_string
	call print_string
	call scan_char
	mov si, text_string
	call print_string

;;Function to print a string
;;args: si - string to print
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
text_string db 'OS COROA!', 0x0a, 0x0d, 0

scan_char:
mov ah, 0x00
int 0x16
ret

times 510-($-$$) db 0
dw 0xaa55