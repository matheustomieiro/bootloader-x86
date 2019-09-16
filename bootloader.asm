	BITS 16
start:
	mov ax, 07C0h
	mov ds, ax
	mov si, start_string
	call print_string
	call scan_char
	cmp al, 0x20
	je ROOM1
	jmp start

ROOM1:
	mov ah, 0x01
	mov bh, 0x00
	mov ch, 0x00
	mov dh, 0x00
	call print_room
	call read_direction
	cmp ah, 0x00
	je ROOM2
	jmp ROOM1

ROOM2:
	mov ah, 0x00
	mov bh, 0x00
	mov ch, 0x00
	mov dh, 0x00
	call print_room
	call read_direction
	cmp ah, 0x02
	je ROOM1
	jmp END

read_direction:
	call scan_char
	cmp al, 0x6e
	je .nc
	cmp al, 0x65
	je .ec
	cmp al, 0x73
	je .sc
	cmp al, 0x77
	je .wc
	jmp read_direction
.nc:
	mov ah, 0x00
	jmp end_read
.ec:
	mov ah, 0x01
	jmp end_read
.sc:
	mov ah, 0x02
	jmp end_read
.wc:
	mov ah, 0x03
	jmp end_read
end_read:	
	ret

;; Fuction to print a room
print_room:
.north:
	cmp ah, 0x01
	je .north_open
	mov si, str_north
	call print_string
.east:
	cmp bh, 0x01
	je .east_open
	mov si, str_east
	call print_string
	jmp .south
.south:
	cmp ch, 0x01
	je .south_open
	mov si, str_south
	call print_string
	ret
.west:
	cmp dh, 0x01
	je .west_open
	mov si, str_west
	call print_string
	jmp .east
.north_open:
	mov si, str_north_open
	call print_string
	jmp .east
.east_open:
	mov si, str_east_open
	call print_string
	jmp .south
.south_open:
	mov si, str_south_open
	call print_string
	jmp .west
.west_open:
	mov si, str_west_open
	call print_string
	ret

;;Function to print a string
;;args: si - string to print
print_string:
	mov ah, 0eh
.repeat:
	lodsb
	cmp al, 0
	je .done
	int 10h
	jmp .repeat
.done:
	ret
	
scan_char:
	mov ah, 0x00
	int 0x16
	ret

start_string db 'Pressione SPACE para iniciar!', 0x0a, 0x0d, 0
str_north db '-------', 0
str_north_open db '---N---', 0
str_east db ' E', 0
str_east_open db ' EO', 0
str_south db ' S', 0x0a, 0x0d, 0
str_south_open db ' SO', 0x0a, 0x0d, 0
str_west db ' W', 0
str_west_open db ' WO', 0

END:
	end_message db 'FIM DE JOGO!', 0
	mov si, end_message
	call print_string
	jmp start
	times 510-($-$$) db 0
	dw 0xaa55