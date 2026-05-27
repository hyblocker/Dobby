.code

PUBLIC closure_trampoline_asm
PUBLIC closure_trampoline_asm_end

closure_trampoline_asm PROC
    ; tip: rip mean next instruction address
    push qword ptr [closure_tramp_entry_addr]
    jmp qword ptr [closure_bridge_addr]

closure_tramp_entry_addr:
    DQ 0

closure_bridge_addr:
    DQ 0
closure_trampoline_asm ENDP

closure_trampoline_asm_end PROC
    ret
closure_trampoline_asm_end ENDP

END