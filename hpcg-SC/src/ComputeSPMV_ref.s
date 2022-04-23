# mark_description "Intel(R) C Intel(R) 64 Compiler for applications running on Intel(R) 64, Version 19.0.3.199 Build 20190206";
# mark_description "-I./src -I./src/CCE -I/global/opt/intel/compilers_and_libraries_2019.3.199/linux/mpi/intel64/include -qopenm";
# mark_description "p -S";
	.file "ComputeSPMV_ref.cpp"
	.text
..TXTST0:
.L_2__routine_start__Z15ComputeSPMV_refRK19SparseMatrix_STRUCTR13Vector_STRUCTS3__0:
# -- Begin  _Z15ComputeSPMV_refRK19SparseMatrix_STRUCTR13Vector_STRUCTS3_, L__Z15ComputeSPMV_refRK19SparseMatrix_STRUCTR13Vector_STRUCTS3__59__par_loop0_2.0
	.text
# mark_begin;
       .align    16,0x90
	.globl _Z15ComputeSPMV_refRK19SparseMatrix_STRUCTR13Vector_STRUCTS3_
# --- ComputeSPMV_ref(const SparseMatrix &, Vector &, Vector &)
_Z15ComputeSPMV_refRK19SparseMatrix_STRUCTR13Vector_STRUCTS3_:
# parameter 1: %rdi
# parameter 2: %rsi
# parameter 3: %rdx
..B1.1:                         # Preds ..B1.0
                                # Execution count [1.00e+00]
	.cfi_startproc
	.cfi_personality 0x3,__gxx_personality_v0
..___tag_value__Z15ComputeSPMV_refRK19SparseMatrix_STRUCTR13Vector_STRUCTS3_.1:
..L2:
                                                          #47.70
        subq      $88, %rsp                                     #47.70
	.cfi_def_cfa_offset 96
        movq      %rbx, 48(%rsp)                                #47.70[spill]
	.cfi_offset 3, -48
        movq      %rsi, %rbx                                    #47.70
        movq      %rbp, 56(%rsp)                                #47.70[spill]
	.cfi_offset 6, -40
        movq      %rdx, %rbp                                    #47.70
        movq      %r15, 16(%rsp)                                #47.70[spill]
        movq      %r14, 24(%rsp)                                #47.70[spill]
        movl      (%rbx), %eax                                  #49.3
        movq      %r13, 32(%rsp)                                #47.70[spill]
        movq      %r12, 40(%rsp)                                #47.70[spill]
        movq      %rdi, 64(%rsp)                                #47.70
        cmpl      36(%rdi), %eax                                #49.3
        jl        ..B1.42       # Prob 0%                       #49.3
	.cfi_offset 12, -56
	.cfi_offset 13, -64
	.cfi_offset 14, -72
	.cfi_offset 15, -80
                                # LOE rbx rbp rdi
..B1.2:                         # Preds ..B1.1
                                # Execution count [9.95e-01]
        movl      (%rbp), %eax                                  #50.3
        cmpl      32(%rdi), %eax                                #50.3
        jl        ..B1.41       # Prob 0%                       #50.3
                                # LOE rbx rbp rdi
..B1.3:                         # Preds ..B1.2
                                # Execution count [9.90e-01]
        movq      %rbx, %rsi                                    #53.5
..___tag_value__Z15ComputeSPMV_refRK19SparseMatrix_STRUCTR13Vector_STRUCTS3_.16:
#       ExchangeHalo(const SparseMatrix &, Vector &)
        call      _Z12ExchangeHaloRK19SparseMatrix_STRUCTR13Vector_STRUCT #53.5
..___tag_value__Z15ComputeSPMV_refRK19SparseMatrix_STRUCTR13Vector_STRUCTS3_.17:
                                # LOE rbx rbp
..B1.4:                         # Preds ..B1.3
                                # Execution count [9.90e-01]
        movq      64(%rsp), %rcx                                #57.28
        movl      $.2.3_2_kmpc_loc_struct_pack.12, %edi         #59.3
        movq      8(%rbx), %rax                                 #55.29
        movq      8(%rbp), %rdx                                 #56.23
        movl      32(%rcx), %ebx                                #57.28
        movq      %rax, (%rsp)                                  #55.27
        movq      %rdx, 8(%rsp)                                 #56.21
        movl      %ebx, 72(%rsp)                                #57.26
        call      __kmpc_global_thread_num                      #59.3
                                # LOE eax
..B1.49:                        # Preds ..B1.4
                                # Execution count [9.90e-01]
        movl      %eax, 76(%rsp)                                #59.3
        movl      $.2.3_2_kmpc_loc_struct_pack.20, %edi         #59.3
        xorl      %eax, %eax                                    #59.3
..___tag_value__Z15ComputeSPMV_refRK19SparseMatrix_STRUCTR13Vector_STRUCTS3_.18:
        call      __kmpc_ok_to_fork                             #59.3
..___tag_value__Z15ComputeSPMV_refRK19SparseMatrix_STRUCTR13Vector_STRUCTS3_.19:
                                # LOE eax
..B1.5:                         # Preds ..B1.49
                                # Execution count [9.90e-01]
        testl     %eax, %eax                                    #59.3
        je        ..B1.7        # Prob 50%                      #59.3
                                # LOE
..B1.6:                         # Preds ..B1.5
                                # Execution count [0.00e+00]
        addq      $-16, %rsp                                    #59.3
	.cfi_def_cfa_offset 112
        movl      $L__Z15ComputeSPMV_refRK19SparseMatrix_STRUCTR13Vector_STRUCTS3__59__par_loop0_2.0, %edx #59.3
        movl      $.2.3_2_kmpc_loc_struct_pack.20, %edi         #59.3
        lea       24(%rsp), %rax                                #59.3
        movl      $4, %esi                                      #59.3
        lea       64(%rax), %rcx                                #59.3
        lea       56(%rax), %r8                                 #59.3
        movq      %rax, (%rsp)                                  #59.3
        lea       16(%rsp), %r9                                 #59.3
        xorl      %eax, %eax                                    #59.3
..___tag_value__Z15ComputeSPMV_refRK19SparseMatrix_STRUCTR13Vector_STRUCTS3_.21:
        call      __kmpc_fork_call                              #59.3
..___tag_value__Z15ComputeSPMV_refRK19SparseMatrix_STRUCTR13Vector_STRUCTS3_.22:
                                # LOE
..B1.50:                        # Preds ..B1.6
                                # Execution count [0.00e+00]
        addq      $16, %rsp                                     #59.3
	.cfi_def_cfa_offset 96
        jmp       ..B1.10       # Prob 100%                     #59.3
                                # LOE
..B1.7:                         # Preds ..B1.5
                                # Execution count [0.00e+00]
        movl      $.2.3_2_kmpc_loc_struct_pack.20, %edi         #59.3
        xorl      %eax, %eax                                    #59.3
        movl      76(%rsp), %esi                                #59.3
..___tag_value__Z15ComputeSPMV_refRK19SparseMatrix_STRUCTR13Vector_STRUCTS3_.24:
        call      __kmpc_serialized_parallel                    #59.3
..___tag_value__Z15ComputeSPMV_refRK19SparseMatrix_STRUCTR13Vector_STRUCTS3_.25:
                                # LOE
..B1.8:                         # Preds ..B1.7
                                # Execution count [0.00e+00]
        movl      $___kmpv_zero_Z15ComputeSPMV_refRK19SparseMatrix_STRUCTR13Vector_STRUCTS3__0, %esi #59.3
        lea       76(%rsp), %rdi                                #59.3
        lea       -4(%rdi), %rdx                                #59.3
        lea       -8(%rdx), %rcx                                #59.3
        lea       (%rsp), %r8                                   #59.3
        lea       -64(%rdx), %r9                                #59.3
..___tag_value__Z15ComputeSPMV_refRK19SparseMatrix_STRUCTR13Vector_STRUCTS3_.26:
        call      L__Z15ComputeSPMV_refRK19SparseMatrix_STRUCTR13Vector_STRUCTS3__59__par_loop0_2.0 #59.3
..___tag_value__Z15ComputeSPMV_refRK19SparseMatrix_STRUCTR13Vector_STRUCTS3_.27:
                                # LOE
..B1.9:                         # Preds ..B1.8
                                # Execution count [0.00e+00]
        movl      $.2.3_2_kmpc_loc_struct_pack.20, %edi         #59.3
        xorl      %eax, %eax                                    #59.3
        movl      76(%rsp), %esi                                #59.3
..___tag_value__Z15ComputeSPMV_refRK19SparseMatrix_STRUCTR13Vector_STRUCTS3_.28:
        call      __kmpc_end_serialized_parallel                #59.3
..___tag_value__Z15ComputeSPMV_refRK19SparseMatrix_STRUCTR13Vector_STRUCTS3_.29:
                                # LOE
..B1.10:                        # Preds ..B1.50 ..B1.9
                                # Execution count [9.90e-01]
        movq      16(%rsp), %r15                                #73.10[spill]
	.cfi_restore 15
        xorl      %eax, %eax                                    #73.10
        movq      24(%rsp), %r14                                #73.10[spill]
	.cfi_restore 14
        movq      32(%rsp), %r13                                #73.10[spill]
	.cfi_restore 13
        movq      40(%rsp), %r12                                #73.10[spill]
	.cfi_restore 12
        movq      48(%rsp), %rbx                                #73.10[spill]
	.cfi_restore 3
        movq      56(%rsp), %rbp                                #73.10[spill]
	.cfi_restore 6
        addq      $88, %rsp                                     #73.10
	.cfi_def_cfa_offset 8
        ret                                                     #73.10
	.cfi_def_cfa_offset 96
                                # LOE
L__Z15ComputeSPMV_refRK19SparseMatrix_STRUCTR13Vector_STRUCTS3__59__par_loop0_2.0:
# parameter 1: %rdi
# parameter 2: %rsi
# parameter 3: %rdx
# parameter 4: %rcx
# parameter 5: %r8
# parameter 6: %r9
..B1.11:                        # Preds ..B1.0
                                # Execution count [9.90e-01]
        subq      $88, %rsp                                     #59.3
        movq      %r12, 40(%rsp)                                #59.3[spill]
	.cfi_offset 12, -56
        movl      (%rdx), %r12d                                 #59.3
        movq      %rbp, 56(%rsp)                                #59.3[spill]
        movq      %r15, 16(%rsp)                                #59.3[spill]
        movq      %rbx, 48(%rsp)                                #59.3[spill]
        movq      %r14, 24(%rsp)                                #59.3[spill]
	.cfi_offset 3, -48
	.cfi_offset 6, -40
	.cfi_offset 14, -72
	.cfi_offset 15, -80
        movq      %r9, %r14                                     #59.3
        movq      %r13, 32(%rsp)                                #59.3[spill]
	.cfi_offset 13, -64
        movq      %r8, %r13                                     #59.3
        movl      (%rdi), %ebp                                  #59.3
        movq      (%rcx), %r15                                  #59.3
        testl     %r12d, %r12d                                  #61.40
        jle       ..B1.40       # Prob 10%                      #61.40
                                # LOE r13 r14 r15 ebp r12d
..B1.12:                        # Preds ..B1.11
                                # Execution count [4.95e+00]
        xorl      %ebx, %ebx                                    #59.3
        decl      %r12d                                         #59.3
        movl      %ebx, 64(%rsp)                                #59.3
        movl      $.2.3_2_kmpc_loc_struct_pack.20, %edi         #59.3
        movl      %ebx, 72(%rsp)                                #59.3
        movl      $1, %ebx                                      #59.3
        movl      %r12d, 68(%rsp)                               #59.3
        movl      %ebp, %esi                                    #59.3
        movl      %ebx, 76(%rsp)                                #59.3
        addq      $-32, %rsp                                    #59.3
	.cfi_def_cfa_offset 128
        movl      $34, %edx                                     #59.3
        lea       104(%rsp), %rcx                               #59.3
        lea       96(%rsp), %r8                                 #59.3
        lea       100(%rsp), %r9                                #59.3
        lea       108(%rsp), %rax                               #59.3
        movq      %rax, (%rsp)                                  #59.3
        movl      %ebx, 8(%rsp)                                 #59.3
        movl      %ebx, 16(%rsp)                                #59.3
        call      __kmpc_for_static_init_4                      #59.3
                                # LOE r13 r14 r15 ebx ebp r12d
..B1.51:                        # Preds ..B1.12
                                # Execution count [4.95e+00]
        addq      $32, %rsp                                     #59.3
	.cfi_def_cfa_offset 96
                                # LOE r13 r14 r15 ebx ebp r12d
..B1.13:                        # Preds ..B1.51
                                # Execution count [0.00e+00]
        movslq    %r12d, %r12                                   #59.3
        movslq    64(%rsp), %rdx                                #59.3
        movl      68(%rsp), %eax                                #59.3
        cmpq      %r12, %rdx                                    #59.3
        jg        ..B1.39       # Prob 50%                      #59.3
                                # LOE rdx r13 r14 r15 eax ebx ebp r12d
..B1.14:                        # Preds ..B1.13
                                # Execution count [8.91e-01]
        cmpl      %r12d, %eax                                   #59.3
        movq      72(%r15), %r8                                 #63.37
        cmovl     %eax, %r12d                                   #59.3
        xorl      %r9d, %r9d                                    #59.3
        movq      64(%r15), %rdi                                #64.42
        movq      (%r14), %rcx                                  #71.5
        lea       (%r8,%rdx,8), %r8                             #63.37
        movslq    %r12d, %r12                                   #59.3
        movq      (%r13), %r11                                  #69.26
        subq      %rdx, %r12                                    #59.3
        movq      48(%r15), %r10                                #65.25
        lea       (%rdi,%rdx,8), %rdi                           #64.42
        movq      %r11, 8(%rsp)                                 #59.3[spill]
        lea       (%rcx,%rdx,8), %rcx                           #71.5
        movl      %ebp, (%rsp)                                  #59.3[spill]
        addq      %rdx, %r10                                    #65.25
        incq      %r12                                          #59.3
                                # LOE rcx rdi r8 r9 r10 r12
..B1.15:                        # Preds ..B1.37 ..B1.14
                                # Execution count [4.95e+00]
        movsbq    (%r9,%r10), %rbp                              #65.25
        movq      (%r8,%r9,8), %r11                             #63.37
        pxor      %xmm0, %xmm0                                  #62.16
        movq      (%rdi,%r9,8), %rsi                            #64.42
        testq     %rbp, %rbp                                    #68.22
        jle       ..B1.37       # Prob 50%                      #68.22
                                # LOE rcx rbp rsi rdi r8 r9 r10 r11 r12 xmm0
..B1.16:                        # Preds ..B1.15
                                # Execution count [4.46e+00]
        cmpq      $6, %rbp                                      #68.5
        jl        ..B1.43       # Prob 10%                      #68.5
                                # LOE rcx rbp rsi rdi r8 r9 r10 r11 r12 xmm0
..B1.17:                        # Preds ..B1.16
                                # Execution count [4.46e+00]
        movq      %r11, %rbx                                    #68.5
        andq      $15, %rbx                                     #68.5
        testl     %ebx, %ebx                                    #68.5
        je        ..B1.20       # Prob 50%                      #68.5
                                # LOE rcx rbp rsi rdi r8 r9 r10 r11 r12 ebx xmm0
..B1.18:                        # Preds ..B1.17
                                # Execution count [4.46e+00]
        testb     $7, %bl                                       #68.5
        jne       ..B1.43       # Prob 10%                      #68.5
                                # LOE rcx rbp rsi rdi r8 r9 r10 r11 r12 xmm0
..B1.19:                        # Preds ..B1.18
                                # Execution count [2.23e+00]
        movl      $1, %ebx                                      #68.5
                                # LOE rcx rbp rsi rdi r8 r9 r10 r11 r12 ebx xmm0
..B1.20:                        # Preds ..B1.19 ..B1.17
                                # Execution count [4.46e+00]
        movl      %ebx, %r13d                                   #68.5
        lea       6(%r13), %rax                                 #68.5
        cmpq      %rax, %rbp                                    #68.5
        jl        ..B1.43       # Prob 10%                      #68.5
                                # LOE rcx rbp rsi rdi r8 r9 r10 r11 r12 r13 ebx xmm0
..B1.21:                        # Preds ..B1.20
                                # Execution count [4.46e+00]
        movl      %ebp, %r14d                                   #68.5
        movl      $715827883, %eax                              #68.5
        movl      %r14d, %r15d                                  #68.5
        subl      %ebx, %r15d                                   #68.5
        imull     %r15d                                         #68.5
        movl      %r15d, %eax                                   #68.5
        sarl      $31, %eax                                     #68.5
        subl      %eax, %edx                                    #68.5
        lea       (%rdx,%rdx,2), %eax                           #68.5
        addl      %eax, %eax                                    #68.5
        subl      %eax, %r15d                                   #68.5
        subl      %r15d, %r14d                                  #68.5
        movslq    %r14d, %r14                                   #68.5
                                # LOE rcx rbp rsi rdi r8 r9 r10 r11 r12 r13 r14 ebx xmm0
..B1.23:                        # Preds ..B1.21
                                # Execution count [4.95e+00]
        xorl      %eax, %eax                                    #68.5
        testl     %ebx, %ebx                                    #68.5
        jbe       ..B1.27       # Prob 10%                      #68.5
                                # LOE rax rcx rbp rsi rdi r8 r9 r10 r11 r12 r13 r14 xmm0
..B1.24:                        # Preds ..B1.23
                                # Execution count [4.46e+00]
        movq      8(%rsp), %rbx                                 #[spill]
                                # LOE rax rcx rbx rbp rsi rdi r8 r9 r10 r11 r12 r13 r14 xmm0
..B1.25:                        # Preds ..B1.25 ..B1.24
                                # Execution count [2.48e+01]
        movslq    (%rsi,%rax,4), %rdx                           #69.29
        movsd     (%r11,%rax,8), %xmm1                          #69.14
        incq      %rax                                          #68.5
        mulsd     (%rbx,%rdx,8), %xmm1                          #69.26
        addsd     %xmm1, %xmm0                                  #69.7
        cmpq      %r13, %rax                                    #68.5
        jb        ..B1.25       # Prob 82%                      #68.5
                                # LOE rax rcx rbx rbp rsi rdi r8 r9 r10 r11 r12 r13 r14 xmm0
..B1.27:                        # Preds ..B1.25 ..B1.23
                                # Execution count [4.46e+00]
        pxor      %xmm1, %xmm1                                  #62.16
        movaps    %xmm1, %xmm2                                  #62.16
        movsd     %xmm0, %xmm2                                  #62.16
        movaps    %xmm1, %xmm0                                  #62.16
                                # LOE rcx rbp rsi rdi r8 r9 r10 r11 r12 r13 r14 xmm0 xmm1 xmm2
..B1.29:                        # Preds ..B1.27
                                # Execution count [4.46e+00]
        movq      8(%rsp), %rax                                 #[spill]
        .align    16,0x90
                                # LOE rax rcx rbp rsi rdi r8 r9 r10 r11 r12 r13 r14 xmm0 xmm1 xmm2
..B1.30:                        # Preds ..B1.30 ..B1.29
                                # Execution count [2.48e+01]
        movslq    (%rsi,%r13,4), %rdx                           #69.26
        movslq    4(%rsi,%r13,4), %rbx                          #69.26
        movslq    8(%rsi,%r13,4), %r15                          #69.26
        movsd     (%rax,%rdx,8), %xmm3                          #69.26
        movhpd    (%rax,%rbx,8), %xmm3                          #69.26
        movslq    16(%rsi,%r13,4), %rbx                         #69.26
        movsd     (%rax,%r15,8), %xmm4                          #69.26
        movslq    12(%rsi,%r13,4), %rdx                         #69.26
        movslq    20(%rsi,%r13,4), %r15                         #69.26
        movsd     (%rax,%rbx,8), %xmm5                          #69.26
        movhpd    (%rax,%rdx,8), %xmm4                          #69.26
        movhpd    (%rax,%r15,8), %xmm5                          #69.26
        mulpd     (%r11,%r13,8), %xmm3                          #69.26
        mulpd     16(%r11,%r13,8), %xmm4                        #69.26
        mulpd     32(%r11,%r13,8), %xmm5                        #69.26
        addpd     %xmm3, %xmm2                                  #69.7
        addpd     %xmm4, %xmm1                                  #69.7
        addpd     %xmm5, %xmm0                                  #69.7
        addq      $6, %r13                                      #68.5
        cmpq      %r14, %r13                                    #68.5
        jb        ..B1.30       # Prob 82%                      #68.5
                                # LOE rax rcx rbp rsi rdi r8 r9 r10 r11 r12 r13 r14 xmm0 xmm1 xmm2
..B1.31:                        # Preds ..B1.30
                                # Execution count [4.46e+00]
        addpd     %xmm1, %xmm2                                  #62.16
        addpd     %xmm0, %xmm2                                  #62.16
        movaps    %xmm2, %xmm0                                  #62.16
        unpckhpd  %xmm2, %xmm0                                  #62.16
        addsd     %xmm0, %xmm2                                  #62.16
        movaps    %xmm2, %xmm0                                  #62.16
                                # LOE rcx rbp rsi rdi r8 r9 r10 r11 r12 r14 xmm0
..B1.33:                        # Preds ..B1.43 ..B1.31
                                # Execution count [4.95e+00]
        cmpq      %rbp, %r14                                    #68.5
        jae       ..B1.37       # Prob 10%                      #68.5
                                # LOE rcx rbp rsi rdi r8 r9 r10 r11 r12 r14 xmm0
..B1.34:                        # Preds ..B1.33
                                # Execution count [4.46e+00]
        movq      8(%rsp), %rdx                                 #[spill]
                                # LOE rdx rcx rbp rsi rdi r8 r9 r10 r11 r12 r14 xmm0
..B1.35:                        # Preds ..B1.35 ..B1.34
                                # Execution count [2.48e+01]
        movslq    (%rsi,%r14,4), %rax                           #69.29
        movsd     (%r11,%r14,8), %xmm1                          #69.14
        incq      %r14                                          #68.5
        mulsd     (%rdx,%rax,8), %xmm1                          #69.26
        addsd     %xmm1, %xmm0                                  #69.7
        cmpq      %rbp, %r14                                    #68.5
        jb        ..B1.35       # Prob 82%                      #68.5
                                # LOE rdx rcx rbp rsi rdi r8 r9 r10 r11 r12 r14 xmm0
..B1.37:                        # Preds ..B1.35 ..B1.33 ..B1.15
                                # Execution count [4.95e+00]
        movsd     %xmm0, (%rcx,%r9,8)                           #71.5
        incq      %r9                                           #61.3
        cmpq      %r12, %r9                                     #61.3
        jb        ..B1.15       # Prob 82%                      #61.3
                                # LOE rcx rdi r8 r9 r10 r12
..B1.38:                        # Preds ..B1.37
                                # Execution count [8.91e-01]
        movl      (%rsp), %ebp                                  #[spill]
                                # LOE ebp
..B1.39:                        # Preds ..B1.38 ..B1.13
                                # Execution count [0.00e+00]
        movl      $.2.3_2_kmpc_loc_struct_pack.20, %edi         #59.3
        movl      %ebp, %esi                                    #59.3
        call      __kmpc_for_static_fini                        #59.3
                                # LOE
..B1.40:                        # Preds ..B1.39 ..B1.11
                                # Execution count [0.00e+00]
        movq      16(%rsp), %r15                                #59.3[spill]
	.cfi_restore 15
        movq      24(%rsp), %r14                                #59.3[spill]
	.cfi_restore 14
        movq      32(%rsp), %r13                                #59.3[spill]
	.cfi_restore 13
        movq      40(%rsp), %r12                                #59.3[spill]
	.cfi_restore 12
        movq      48(%rsp), %rbx                                #59.3[spill]
	.cfi_restore 3
        movq      56(%rsp), %rbp                                #59.3[spill]
	.cfi_restore 6
        addq      $88, %rsp                                     #59.3
	.cfi_def_cfa_offset 8
        ret                                                     #59.3
	.cfi_def_cfa_offset 96
	.cfi_offset 3, -48
	.cfi_offset 6, -40
	.cfi_offset 12, -56
	.cfi_offset 13, -64
	.cfi_offset 14, -72
	.cfi_offset 15, -80
                                # LOE
..B1.41:                        # Preds ..B1.2
                                # Execution count [4.97e-03]: Infreq
        movl      $.L_2__STRING.2, %edi                         #50.3
        movl      $.L_2__STRING.1, %esi                         #50.3
        movl      $50, %edx                                     #50.3
        movl      $__$U0, %ecx                                  #50.3
#       __assert_fail(const char *, const char *, unsigned int, const char *)
        call      __assert_fail                                 #50.3
                                # LOE
..B1.42:                        # Preds ..B1.1
                                # Execution count [5.00e-03]: Infreq
        movl      $.L_2__STRING.0, %edi                         #49.3
        movl      $.L_2__STRING.1, %esi                         #49.3
        movl      $49, %edx                                     #49.3
        movl      $__$U0, %ecx                                  #49.3
#       __assert_fail(const char *, const char *, unsigned int, const char *)
        call      __assert_fail                                 #49.3
                                # LOE
..B1.43:                        # Preds ..B1.16 ..B1.18 ..B1.20
                                # Execution count [4.46e-01]: Infreq
        xorl      %r14d, %r14d                                  #68.5
        jmp       ..B1.33       # Prob 100%                     #68.5
        .align    16,0x90
                                # LOE rcx rbp rsi rdi r8 r9 r10 r11 r12 r14 xmm0
	.cfi_endproc
# mark_end;
	.type	_Z15ComputeSPMV_refRK19SparseMatrix_STRUCTR13Vector_STRUCTS3_,@function
	.size	_Z15ComputeSPMV_refRK19SparseMatrix_STRUCTR13Vector_STRUCTS3_,.-_Z15ComputeSPMV_refRK19SparseMatrix_STRUCTR13Vector_STRUCTS3_
..LN_Z15ComputeSPMV_refRK19SparseMatrix_STRUCTR13Vector_STRUCTS3_.0:
	.data
	.align 4
	.align 4
.2.3_2_kmpc_loc_struct_pack.12:
	.long	0
	.long	2
	.long	0
	.long	0
	.quad	.2.3_2__kmpc_loc_pack.11
	.align 4
.2.3_2__kmpc_loc_pack.11:
	.byte	59
	.byte	117
	.byte	110
	.byte	107
	.byte	110
	.byte	111
	.byte	119
	.byte	110
	.byte	59
	.byte	67
	.byte	111
	.byte	109
	.byte	112
	.byte	117
	.byte	116
	.byte	101
	.byte	83
	.byte	80
	.byte	77
	.byte	86
	.byte	95
	.byte	114
	.byte	101
	.byte	102
	.byte	59
	.byte	53
	.byte	57
	.byte	59
	.byte	53
	.byte	57
	.byte	59
	.byte	59
	.align 4
.2.3_2_kmpc_loc_struct_pack.20:
	.long	0
	.long	514
	.long	0
	.long	0
	.quad	.2.3_2__kmpc_loc_pack.19
	.align 4
.2.3_2__kmpc_loc_pack.19:
	.byte	59
	.byte	117
	.byte	110
	.byte	107
	.byte	110
	.byte	111
	.byte	119
	.byte	110
	.byte	59
	.byte	67
	.byte	111
	.byte	109
	.byte	112
	.byte	117
	.byte	116
	.byte	101
	.byte	83
	.byte	80
	.byte	77
	.byte	86
	.byte	95
	.byte	114
	.byte	101
	.byte	102
	.byte	59
	.byte	53
	.byte	57
	.byte	59
	.byte	55
	.byte	50
	.byte	59
	.byte	59
	.data
# -- End  _Z15ComputeSPMV_refRK19SparseMatrix_STRUCTR13Vector_STRUCTS3_, L__Z15ComputeSPMV_refRK19SparseMatrix_STRUCTR13Vector_STRUCTS3__59__par_loop0_2.0
	.bss
	.align 4
	.align 4
___kmpv_zero_Z15ComputeSPMV_refRK19SparseMatrix_STRUCTR13Vector_STRUCTS3__0:
	.type	___kmpv_zero_Z15ComputeSPMV_refRK19SparseMatrix_STRUCTR13Vector_STRUCTS3__0,@object
	.size	___kmpv_zero_Z15ComputeSPMV_refRK19SparseMatrix_STRUCTR13Vector_STRUCTS3__0,4
	.space 4	# pad
	.section .rodata, "a"
	.align 32
	.align 32
__$U0:
	.long	544501353
	.long	1886220099
	.long	1399157877
	.long	1599491408
	.long	677799282
	.long	1936617315
	.long	1884495988
	.long	1702064737
	.long	1920229709
	.long	1398765673
	.long	1129665108
	.long	740696148
	.long	1667585568
	.long	1601335156
	.long	1431458899
	.long	639652931
	.long	1700143148
	.long	1919906915
	.long	1381258079
	.long	542393173
	.word	10534
	.byte	0
	.type	__$U0,@object
	.size	__$U0,83
	.section .rodata.str1.4, "aMS",@progbits,1
	.align 4
	.align 4
.L_2__STRING.2:
	.long	1869360761
	.long	1282171235
	.long	1952935525
	.long	1094532712
	.long	1668246574
	.long	1968073825
	.long	1919246957
	.long	1867671119
	.word	29559
	.byte	0
	.type	.L_2__STRING.2,@object
	.size	.L_2__STRING.2,35
	.space 1, 0x00 	# pad
	.align 4
.L_2__STRING.1:
	.long	1886220099
	.long	1399157877
	.long	1599491408
	.long	778462578
	.long	7368803
	.type	.L_2__STRING.1,@object
	.size	.L_2__STRING.1,20
	.align 4
.L_2__STRING.0:
	.long	1869360760
	.long	1282171235
	.long	1952935525
	.long	1094532712
	.long	1668246574
	.long	1968073825
	.long	1919246957
	.long	1866688079
	.long	1852667244
	.word	115
	.type	.L_2__STRING.0,@object
	.size	.L_2__STRING.0,38
	.data
	.section .note.GNU-stack, ""
# End
