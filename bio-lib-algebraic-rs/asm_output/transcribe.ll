define void @bio_lib_algebraic_rs::transcribe(%"alloc::vec::Vec<RnaNucleotide>"* noalias nocapture sret(%"alloc::vec::Vec<RnaNucleotide>") dereferenceable(24) %0, [0 x i8]* noalias nonnull readonly align 1 %seq.0, i64 %seq.1) unnamed_addr #2 personality i32 (i32, i32, i64, %"unwind::libunwind::_Unwind_Exception"*, %"unwind::libunwind::_Unwind_Context"
start:
%1 = getelementptr [0 x i8], [0 x i8]* %seq.0, i64 0, i64 0
%2 = getelementptr inbounds [0 x i8], [0 x i8]* %seq.0, i64 0, i64 %seq.1
tail call void @llvm.experimental.noalias.scope.decl(metadata !619)
tail call void @llvm.experimental.noalias.scope.decl(metadata !622) #19
tail call void @llvm.experimental.noalias.scope.decl(metadata !625) #19
tail call void @llvm.experimental.noalias.scope.decl(metadata !628) #19
tail call void @llvm.experimental.noalias.scope.decl(metadata !631) #19
tail call void @llvm.experimental.noalias.scope.decl(metadata !634) #19
%3 = icmp eq i64 %seq.1, 0
br i1 %3, label %"alloc::vec::Vec<T,A>::reserve::h1a0d8def52324524.exit.i.i.i.i.i", label %"<alloc::alloc::Global as core::alloc::Allocator>::allocate::hf937eda5e01a1b11.exit.i.i.i.i.i.i.i.i"

"<alloc::alloc::Global as core::alloc::Allocator>::allocate::hf937eda5e01a1b11.exit.i.i.i.i.i.i.i.i"
%4 = tail call i8* @__rust_alloc(i64 %seq.1, i64 1) #19, !noalias !637
%5 = insertvalue { i8*, i64 } undef, i8* %4, 0
%6 = icmp eq i8* %4, null
br i1 %6, label %bb20.i.i.i.i.i.i.i.i, label %"alloc::vec::Vec<T,A>::reserve::h1a0d8def52324524.exit.i.i.i.i.i"

bb20.i.i.i.i.i.i.i.i:                             ; preds = %"<alloc::alloc::Global as core::alloc::Allocator>::allocate::hf937eda5e01a1b11.exit.i.i.i.i.i.i.i.i"
; call alloc::alloc::handle_alloc_error
tail call void @_ZN5alloc5alloc18handle_alloc_error17h4cd683bcbb15ef4bE(i64 %seq.1, i64 1) #22, !noalias !637
unreachable

"alloc::vec::Vec<T,A>::reserve::h1a0d8def52324524.exit.i.i.i.i.i": ; preds = %"<alloc::alloc::Global as core::alloc::Allocator>::allocate::hf937eda5e01a1b11.exit.i.i.i.i.i.i.i.i"
%.pn.i.i.i.i.i.i.i.i = phi { i8*, i64 } [ %5, %"<alloc::alloc::Global as core::alloc::Allocator>::allocate::hf937eda5e01a1b11.exit.i.i.i.i.i.i.i.i"
%_3.0.i.i.i.i.i.i = extractvalue { i8*, i64 } %.pn.i.i.i.i.i.i.i.i, 0
%7 = getelementptr inbounds %"alloc::vec::Vec<RnaNucleotide>", %"alloc::vec::Vec<RnaNucleotide>"
store i8* %_3.0.i.i.i.i.i.i, i8** %7, align 8, !alias.scope !637
%8 = getelementptr %"alloc::vec::Vec<RnaNucleotide>", %"alloc::vec::Vec<RnaNucleotide>"
store i64 %seq.1, i64* %8, align 8, !alias.scope !637
%9 = getelementptr %"alloc::vec::Vec<RnaNucleotide>", %"alloc::vec::Vec<RnaNucleotide>"
store i64 0, i64* %9, align 8, !alias.scope !637
tail call void @llvm.experimental.noalias.scope.decl(metadata !638) #19
br i1 %3, label %_ZN4core4iter6traits8iterator8Iterator7collect17h603b08d5cd2b4d3eE.exit, label %bb3.i.i.i.i.i.i.i.i.preheader

bb3.i.i.i.i.i.i.i.i.preheader:                    ; preds = %"alloc::vec::Vec<T,A>::reserve::h1a0d8def52324524.exit.i.i.i.i.i"
%10 = add i64 %seq.1, -1
%xtraiter = and i64 %seq.1, 7
%lcmp.mod.not = icmp eq i64 %xtraiter, 0
br i1 %lcmp.mod.not, label %bb3.i.i.i.i.i.i.i.i.prol.loopexit, label %bb3.i.i.i.i.i.i.i.i.prol

bb3.i.i.i.i.i.i.i.i.prol:                         ; preds = %bb3.i.i.i.i.i.i.i.i.preheader, %bb3.i.i.i.i.i.i.i.i.prol
%_6.sroa.0.0.i.i.i.i.i.i.i.prol = phi i8* [ %12, %bb3.i.i.i.i.i.i.i.i.prol ], [ %_3.0.i.i.i.i.i.i, %bb3.i.i.i.i.i.i.i.i.preheader ]
%self.sroa.0.021.i.i.i.i.i.i.i.i.prol = phi i8* [ %11, %bb3.i.i.i.i.i.i.i.i.prol ], [ %1, %bb3.i.i.i.i.i.i.i.i.preheader ]
%prol.iter = phi i64 [ %prol.iter.sub, %bb3.i.i.i.i.i.i.i.i.prol ], [ %xtraiter, %bb3.i.i.i.i.i.i.i.i.preheader ]
%11 = getelementptr inbounds i8, i8* %self.sroa.0.021.i.i.i.i.i.i.i.i.prol, i64 1
%.val.i.i.i.i.i.i.i.i.prol = load i8, i8* %self.sroa.0.021.i.i.i.i.i.i.i.i.prol, align 1, !noalias !641
store i8 %.val.i.i.i.i.i.i.i.i.prol, i8* %_6.sroa.0.0.i.i.i.i.i.i.i.prol, align 1, !noalias !648
%12 = getelementptr inbounds i8, i8* %_6.sroa.0.0.i.i.i.i.i.i.i.prol, i64 1
%prol.iter.sub = add i64 %prol.iter, -1
%prol.iter.cmp.not = icmp eq i64 %prol.iter.sub, 0
br i1 %prol.iter.cmp.not, label %bb3.i.i.i.i.i.i.i.i.prol.loopexit, label %bb3.i.i.i.i.i.i.i.i.prol, !llvm.loop !655

bb3.i.i.i.i.i.i.i.i.prol.loopexit:                ; preds = %bb3.i.i.i.i.i.i.i.i.prol, %bb3.i.i.i.i.i.i.i.i.preheader
%_6.sroa.0.0.i.i.i.i.i.i.i.unr = phi i8* [ %_3.0.i.i.i.i.i.i, %bb3.i.i.i.i.i.i.i.i.preheader ], [ %12, %bb3.i.i.i.i.i.i.i.i.prol ]
%self.sroa.0.021.i.i.i.i.i.i.i.i.unr = phi i8* [ %1, %bb3.i.i.i.i.i.i.i.i.preheader ], [ %11, %bb3.i.i.i.i.i.i.i.i.prol ]
%13 = icmp ult i64 %10, 7
br i1 %13, label %_ZN4core4iter6traits8iterator8Iterator7collect17h603b08d5cd2b4d3eE.exit, label %bb3.i.i.i.i.i.i.i.i

bb3.i.i.i.i.i.i.i.i:                              ; preds = %bb3.i.i.i.i.i.i.i.i.prol.loopexit, %bb3.i.i.i.i.i.i.i.i
%_6.sroa.0.0.i.i.i.i.i.i.i = phi i8* [ %29, %bb3.i.i.i.i.i.i.i.i ], [ %_6.sroa.0.0.i.i.i.i.i.i.i.unr, %bb3.i.i.i.i.i.i.i.i.prol.loopexit ]
%self.sroa.0.021.i.i.i.i.i.i.i.i = phi i8* [ %28, %bb3.i.i.i.i.i.i.i.i ], [ %self.sroa.0.021.i.i.i.i.i.i.i.i.unr, %bb3.i.i.i.i.i.i.i.i.prol.loopexit ]
%14 = getelementptr inbounds i8, i8* %self.sroa.0.021.i.i.i.i.i.i.i.i, i64 1
%.val.i.i.i.i.i.i.i.i = load i8, i8* %self.sroa.0.021.i.i.i.i.i.i.i.i, align 1, !noalias !641
store i8 %.val.i.i.i.i.i.i.i.i, i8* %_6.sroa.0.0.i.i.i.i.i.i.i, align 1, !noalias !648
%15 = getelementptr inbounds i8, i8* %_6.sroa.0.0.i.i.i.i.i.i.i, i64 1
%16 = getelementptr inbounds i8, i8* %self.sroa.0.021.i.i.i.i.i.i.i.i, i64 2
%.val.i.i.i.i.i.i.i.i.1 = load i8, i8* %14, align 1, !noalias !641
store i8 %.val.i.i.i.i.i.i.i.i.1, i8* %15, align 1, !noalias !648
%17 = getelementptr inbounds i8, i8* %_6.sroa.0.0.i.i.i.i.i.i.i, i64 2
%18 = getelementptr inbounds i8, i8* %self.sroa.0.021.i.i.i.i.i.i.i.i, i64 3
%.val.i.i.i.i.i.i.i.i.2 = load i8, i8* %16, align 1, !noalias !641
store i8 %.val.i.i.i.i.i.i.i.i.2, i8* %17, align 1, !noalias !648
%19 = getelementptr inbounds i8, i8* %_6.sroa.0.0.i.i.i.i.i.i.i, i64 3
%20 = getelementptr inbounds i8, i8* %self.sroa.0.021.i.i.i.i.i.i.i.i, i64 4
%.val.i.i.i.i.i.i.i.i.3 = load i8, i8* %18, align 1, !noalias !641
store i8 %.val.i.i.i.i.i.i.i.i.3, i8* %19, align 1, !noalias !648
%21 = getelementptr inbounds i8, i8* %_6.sroa.0.0.i.i.i.i.i.i.i, i64 4
%22 = getelementptr inbounds i8, i8* %self.sroa.0.021.i.i.i.i.i.i.i.i, i64 5
%.val.i.i.i.i.i.i.i.i.4 = load i8, i8* %20, align 1, !noalias !641
store i8 %.val.i.i.i.i.i.i.i.i.4, i8* %21, align 1, !noalias !648
%23 = getelementptr inbounds i8, i8* %_6.sroa.0.0.i.i.i.i.i.i.i, i64 5
%24 = getelementptr inbounds i8, i8* %self.sroa.0.021.i.i.i.i.i.i.i.i, i64 6
%.val.i.i.i.i.i.i.i.i.5 = load i8, i8* %22, align 1, !noalias !641
store i8 %.val.i.i.i.i.i.i.i.i.5, i8* %23, align 1, !noalias !648
%25 = getelementptr inbounds i8, i8* %_6.sroa.0.0.i.i.i.i.i.i.i, i64 6
%26 = getelementptr inbounds i8, i8* %self.sroa.0.021.i.i.i.i.i.i.i.i, i64 7
%.val.i.i.i.i.i.i.i.i.6 = load i8, i8* %24, align 1, !noalias !641
store i8 %.val.i.i.i.i.i.i.i.i.6, i8* %25, align 1, !noalias !648
%27 = getelementptr inbounds i8, i8* %_6.sroa.0.0.i.i.i.i.i.i.i, i64 7
%28 = getelementptr inbounds i8, i8* %self.sroa.0.021.i.i.i.i.i.i.i.i, i64 8
%.val.i.i.i.i.i.i.i.i.7 = load i8, i8* %26, align 1, !noalias !641
store i8 %.val.i.i.i.i.i.i.i.i.7, i8* %27, align 1, !noalias !648
%29 = getelementptr inbounds i8, i8* %_6.sroa.0.0.i.i.i.i.i.i.i, i64 8
%_12.i.i.i.i.i.i.i.i.i.7 = icmp eq i8* %28, %2
br i1 %_12.i.i.i.i.i.i.i.i.i.7, label %_ZN4core4iter6traits8iterator8Iterator7collect17h603b08d5cd2b4d3eE.exit, label %bb3.i.i.i.i.i.i.i.i

_ZN4core4iter6traits8iterator8Iterator7collect17h603b08d5cd2b4d3eE.exit: ; preds = %bb3.i.i.i.i.i.i.i.i.prol.loopexit, %bb3.i.i.i.i.i.i.i.i, %"alloc::vec::Vec<T,A>::reserve::h1a0d8def52324524.exit.i.i.i.i.i"
store i64 %seq.1, i64* %9, align 8, !alias.scope !657, !noalias !658
ret void
}
