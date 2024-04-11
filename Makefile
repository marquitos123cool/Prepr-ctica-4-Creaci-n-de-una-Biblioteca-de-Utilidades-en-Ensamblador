all: preprac4.bin

preprac4.bin: main.o count_char.o convert_to_string.o
	ld -o preprac4.bin main.o count_char.o convert_to_string.o

main.o: main.asm
	nasm -f elf64 main.asm -o main.o

count_char.o: count_char.asm
	nasm -f elf64 count_char.asm -o count_char.o

convert_to_string.o: convert_to_string.asm
	nasm -f elf64 convert_to_string.asm -o convert_to_string.o

clean:
	rm preprac4.bin main.o count_char.o convert_to_string.o