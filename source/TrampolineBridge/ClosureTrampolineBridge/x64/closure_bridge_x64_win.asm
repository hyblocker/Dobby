.code

EXTERN common_closure_bridge_handler : PROC

PUBLIC closure_bridge_asm
closure_bridge_asm PROC
  ; flags register
  pushfq
  ; used for alignment
  sub rsp, 8

  ; general register
  sub rsp, 128
  mov [rsp+8*0], rax
  mov [rsp+8*1], rbx
  mov [rsp+8*2], rcx
  mov [rsp+8*3], rdx
  mov [rsp+8*4], rbp
  mov [rsp+8*5], rsp
  mov [rsp+8*6], rdi
  mov [rsp+8*7], rsi
  mov [rsp+8*8], r8
  mov [rsp+8*9], r9
  mov [rsp+8*10], r10
  mov [rsp+8*11], r11
  mov [rsp+8*12], r12
  mov [rsp+8*13], r13
  mov [rsp+8*14], r14
  mov [rsp+8*15], r15

  mov rax, rsp
  add rax, 152 ; include `closure_tramp_entry_addr` stack var
  mov [rsp+40], rax

  ; call convention: rdi = register context, rsi = interceptor entry
  mov rcx, rsp
  mov rdx, [rsp+144]

  mov rax, rsp
  and rax, 0Fh
  jz Lstack_aligned_call_start
  push rax
  call common_closure_bridge_handler
  pop rax
  jmp Lcall_end

  Lstack_aligned_call_start:
  call common_closure_bridge_handler
  Lcall_end:

  ; general register
  mov rax, [rsp+8*0]
  mov rbx, [rsp+8*1]
  mov rcx, [rsp+8*2]
  mov rdx, [rsp+8*3]
  mov rbp, [rsp+8*4]
  mov rdi, [rsp+8*6]
  mov rsi, [rsp+8*7]
  mov r8,  [rsp+8*8]
  mov r9,  [rsp+8*9]
  mov r10, [rsp+8*10]
  mov r11, [rsp+8*11]
  mov r12, [rsp+8*12]
  mov r13, [rsp+8*13]
  mov r14, [rsp+8*14]
  mov r15, [rsp+8*15]
  add rsp, 128

  ; used for alignment
  add rsp, 8
  ; flags register
  popfq

  ; trick: use `closure_tramp_entry_addr` stack_addr to store the return address
  ret
closure_bridge_asm ENDP

PUBLIC closure_bridge_asm_end
closure_bridge_asm_end PROC
  ret
closure_bridge_asm_end ENDP

END