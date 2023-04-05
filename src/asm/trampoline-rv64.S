.globl mmk_trampoline
mmk_trampoline:
    ld      t0, mmk_trampoline       // Save the address

    addi    sp, sp, -80
    sd      t0, 80(sp)
    sd      a0, 72(sp)
    sd      a1, 64(sp)
    sd      a2, 56(sp)
    sd      a3, 48(sp)
    sd      a4, 40(sp)
    sd      a5, 32(sp)
    sd      a6, 24(sp)
    sd      a7, 16(sp)
    sd      ra, 8(sp)

    ld      a0, -16(t0)            // Call mmk_set_ctx
    ld      t0, 8(a0)
    jalr    t0

    ld      ra, 8(sp)
    ld      t0, 16(sp)
    sd      t0, 16(sp)
    sd      ra, 8(sp)

    ld      t0, -16(t0)            // Check if context was asked
    ld      t0, 0(t0)
    jalr    t0
    bne     a0, x0, ret_ctx        // If the return value is 0, goto ret_ctx

    ld      ra, 8(sp)
    ld      a7, 16(sp)
    ld      a6, 24(sp)
    ld      a5, 32(sp)
    ld      a4, 40(sp)
    ld      a3, 48(sp)
    ld      a2, 56(sp)
    ld      a1, 64(sp)
    ld      a0, 72(sp)
    ld      t0, 80(sp)
    addi    sp, sp, 80
    jalr    -8(t0)                // Trampoline jump

ret_ctx:

    ld      ra, 8(sp)
    ld      a7, 16(sp)
    ld      a6, 24(sp)
    ld      a5, 32(sp)
    ld      a4, 40(sp)
    ld      a3, 48(sp)
    ld      a2, 56(sp)
    ld      a1, 64(sp)
    ld      a0, 72(sp)
    ld      t0, 80(sp)

    addi    sp, sp, 80
    addi    sp, sp, -16
    sd      t0, 16(sp)
    sd      ra, 8(sp)

    ld      t0, -16(t0)     // Call mmk_ctx
    ld      t0, 16(t0)
    jalr    t0

    ld      t0, 16(sp)
    ld      ra, 8(sp)
    addi    sp, sp, 16

.globl mmk_trampoline_end
mmk_trampoline_end:
    nop