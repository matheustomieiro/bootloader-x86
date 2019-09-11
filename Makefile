compile:
	nasm -f bin -o temp.bin bootloader.asm

mk_flp:	compile
	dd bs=512 count=2880 if=/dev/zero of=image.flp

cp_flp: mk_flp
	dd status=noxfer conv=notrunc if=temp.bin of=image.flp

iso:	cp_flp
	mkisofs -o boot.iso -b image.flp .

all:	iso
	echo "OK!"

clean:
	rm -rf image.flp temp.bin

clean_all:
	rm -rf image.flp temp.bin boot.iso

0:	all	clean
	echo "Finished"
