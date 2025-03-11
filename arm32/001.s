@Print out a text to the screen

.global _start

.section .data
prompt: 	.asciz 	"enter anything you want"
prompt_len: 	.word 	. - prompt	@automatically calculate the lengh

.section .text
_start:
	@ print out a prompt
	mov r0, #1 	@file descriptor 1 = STDOUT
	ldr r1, =prompt
	ldr r2, =prompt_len
	ldr r2, [r2]
	mov r7, #0x04	@ write syscall
	swi 0

	@ read the input
	mov r7, #0x03	@ read syscall
	swi 0
	@ exit the program
	mov r0, #13	@ a random error code
	mov r7, #0x1	@ exit syscall
	swi 0



.section .bss
.equ BUFFER_LENGTH, 10
buffer: 	.space 	BUFFER_LENGTH	@ set aside 10 bytes of data 

