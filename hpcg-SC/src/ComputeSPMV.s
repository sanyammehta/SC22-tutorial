	.text
	.ident	"Cray C++ : Version 10.0.x.x"
	.file	"The Cpu Module"
                                        // Start of file scope inline assembly
	.pushsection	.note.ftn_module_data
	.balign	4
	.4byte	10, 1f-0f, 8
	.asciz	"Cray Inc."
	.balign	4
0:
	.ascii	"\363\371\106\136\345\166\000\000\001\000\001\000\024\000"
	.ascii	"\000\000\015\000\000\000\057\164\155\160\057\160\145\137"
	.ascii	"\063\060\064\063\067\057\057\160\154\144\151\162\000\103"
	.ascii	"\157\155\160\165\164\145\123\120\115\126\056\163\000"
	.balign	4
1:	.popsection

                                        // End of file scope inline assembly
	.globl	_Z11ComputeSPMVRK19SparseMatrix_STRUCTR13Vector_STRUCTS3_ // -- Begin function _Z11ComputeSPMVRK19SparseMatrix_STRUCTR13Vector_STRUCTS3_
	.p2align	2
	.type	_Z11ComputeSPMVRK19SparseMatrix_STRUCTR13Vector_STRUCTS3_,@function
_Z11ComputeSPMVRK19SparseMatrix_STRUCTR13Vector_STRUCTS3_: // @_Z11ComputeSPMVRK19SparseMatrix_STRUCTR13Vector_STRUCTS3_
	.cfi_startproc
..TxtBeg_F1:
	.file	1  "ComputeSPMV.cpp"
	.loc	1  40  0
// BB#0:                                // %", bb1"
	.loc	1  43  0
	strb	wzr, [x0, #169]         // ComputeSPMV.cpp:43
	.loc	1  44  0
	b	_Z15ComputeSPMV_refRK19SparseMatrix_STRUCTR13Vector_STRUCTS3_ // ComputeSPMV.cpp:44
..TxtEnd_F1:
.Lfunc_end0:
	.size	_Z11ComputeSPMVRK19SparseMatrix_STRUCTR13Vector_STRUCTS3_, .Lfunc_end0-_Z11ComputeSPMVRK19SparseMatrix_STRUCTR13Vector_STRUCTS3_
	.cfi_endproc
                                        // -- End function
	.type	initialized$$$CFE_id_540596a5_0abfbdd1,@object // @"initialized$$$CFE_id_540596a5_0abfbdd1"
	.data
	.p2align	6
initialized$$$CFE_id_540596a5_0abfbdd1:
	.xword	__pthread_key_create
	.xword	0                       // 0x0
	.xword	0                       // 0x0
	.xword	0                       // 0x0
	.size	initialized$$$CFE_id_540596a5_0abfbdd1, 32


	.section	".note.GNU-stack","",@progbits
