start:
	mov	ebx, 31744
.L2:
	mov	eax, ebx
	cwde
	movzx	eax, BYTE [here+eax]
	cbw
	movzx	eax, al
	or	ah, 14
	int 	0x10
	mov	edx, ebx
	add	edx, 1
	mov	ebx, edx
	cmp	ax, 3584
	jne	.L2
.L3:
	jmp	.L3
here:
	db	"Prado, o negocio pelo menos ta progredindo..."

	times 510 - ($-$$) db 0	;; Pad with zeros
	
	dw 0xaa55               ;; Boot signature
	
