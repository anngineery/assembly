@Get a user input and echo it back

.global _start
.equ BUFFER_MAX_LENGTH, 10

.section .bss
buffer: 	.space 	BUFFER_MAX_LENGTH	@set aside 10 bytes of data 
input_len:	.space 	1			@max value will be 10, so 1 byte is sufficient

.section .data
prompt: 	.asciz 	"enter a string to echo\n"
prompt_len: 	.word 	. - prompt	@automatically calculate the lengh

.section .text
_start:
	@print out a prompt
	mov r0, #1 	@fd = STDOUT
	ldr r1, =prompt
	ldr r2, =prompt_len
	ldr r2, [r2]
	mov r7, #0x04	@write syscall
	swi 0

	@read the input
	mov r0, #0 	@fd = STDIN
	ldr r1, =buffer
	mov r2, #BUFFER_MAX_LENGTH
	mov r7, #0x03	@read syscall
	swi 0
	ldr r1, =input_len
	add r0, r0, #48	@convert to ASCII
	strb r0, [r1]	@[input_len] = r0 = return value

	@echo back what is read	
	mov r0, #1 	@fd = STDOUT
	ldr r1, =buffer
	ldr r2, =input_len
	ldrb r2, [r2]	
	mov r7, #0x04	@write syscall
	swi 0

	@print out number of bytes read	
	ldr r1, =input_len
	mov r2, #1
	swi 0

	@exit the program
	mov r0, #13	@a random error code
	mov r7, #0x1	@exit syscall
	swi 0
