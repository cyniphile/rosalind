define void @bio_lib_algebraic_rs::find_reverse_palindromes(%"alloc::vec::Vec<PalindromeLocation>"* noalias nocapture sret(%"alloc::vec::Vec<PalindromeLocation>") dereferenceable(24) %0, [0 x i8]* noalias nonnull readonly align 1 %seq.0, i64 %seq.1) unnamed_addr #3 personality i32 (i32, i32, i64, %"unwind::libunwind::_Unwind_Exception"*, %"unwind::libunwind::_Unwind_Context"
bb2:
%locations = alloca %"alloc::vec::Vec<PalindromeLocation>"
%1 = bitcast %"alloc::vec::Vec<PalindromeLocation>"
call void @llvm.lifetime.start.p0i8(i64 24, i8* nonnull %1)
tail call void @llvm.experimental.noalias.scope.decl(metadata !659)
%2 = load i64*, i64** bitcast (<{ [16 x i8] }>* @1 to i64**), align 8, !noalias !659, !nonnull !10
%3 = getelementptr inbounds %"alloc::vec::Vec<PalindromeLocation>", %"alloc::vec::Vec<PalindromeLocation>"
store i64* %2, i64** %3, align 8, !alias.scope !659
%4 = getelementptr inbounds %"alloc::vec::Vec<PalindromeLocation>", %"alloc::vec::Vec<PalindromeLocation>"
%5 = bitcast i64* %4 to i8*
call void @llvm.memset.p0i8.i64(i8* noundef nonnull align 8 dereferenceable(16) %5, i8 0, i64 16, i1 false) #18, !alias.scope !659
%_5 = icmp ult i64 %seq.1, 4
br i1 %_5, label %"core::ptr::drop_in_place<alloc::vec::Vec<bio_lib_algebraic_rs::PalindromeLocation>>.exit"

cleanup.loopexit:                                 ; preds = %bb2.i.i.i32
%lpad.loopexit = landingpad { i8*, i32 }
cleanup
br label %cleanup

cleanup.loopexit.split-lp:                        ; preds = %bb1.i.i
%lpad.loopexit.split-lp = landingpad { i8*, i32 }
cleanup
br label %cleanup

cleanup:                                          ; preds = %cleanup.loopexit.split-lp, %cleanup.loopexit
%lpad.phi = phi { i8*, i32 } [ %lpad.loopexit, %cleanup.loopexit ], [ %lpad.loopexit.split-lp, %cleanup.loopexit.split-lp ]
; call core::ptr::drop_in_place<alloc::vec::Vec<bio_lib_algebraic_rs::PalindromeLocation>>
call fastcc void @"core::ptr::drop_in_place<alloc::vec::Vec<bio_lib_algebraic_rs::PalindromeLocation>>"(%"alloc::vec::Vec<PalindromeLocation>"
resume { i8*, i32 } %lpad.phi

"core::ptr::drop_in_place<alloc::vec::Vec<bio_lib_algebraic_rs::PalindromeLocation>>.exit"
%6 = getelementptr inbounds %"alloc::vec::Vec<PalindromeLocation>", %"alloc::vec::Vec<PalindromeLocation>"
store i64* %2, i64** %6, align 8, !alias.scope !662
%7 = getelementptr inbounds %"alloc::vec::Vec<PalindromeLocation>", %"alloc::vec::Vec<PalindromeLocation>"
%8 = bitcast i64* %7 to i8*
tail call void @llvm.memset.p0i8.i64(i8* noundef nonnull align 8 dereferenceable(16) %8, i8 0, i64 16, i1 false) #18, !alias.scope !662
call void @llvm.lifetime.end.p0i8(i64 24, i8* nonnull %1)
br label %bb29

bb29:                                             ; preds = %bb9, %"core::ptr::drop_in_place<alloc::vec::Vec<bio_lib_algebraic_rs::PalindromeLocation>>.exit"
ret void

bb13.preheader:                                   ; preds = %bb2
%9 = bitcast i64* %2 to { i64, i64 }*
%_11 = add i64 %seq.1, -3
%10 = getelementptr inbounds %"alloc::vec::Vec<PalindromeLocation>", %"alloc::vec::Vec<PalindromeLocation>"
%_6.i = getelementptr inbounds %"alloc::vec::Vec<PalindromeLocation>", %"alloc::vec::Vec<PalindromeLocation>"
%11 = bitcast %"alloc::vec::Vec<PalindromeLocation>"
br label %bb13

bb9:                                              ; preds = %bb16
%12 = bitcast %"alloc::vec::Vec<PalindromeLocation>"
call void @llvm.memcpy.p0i8.p0i8.i64(i8* noundef nonnull align 8 dereferenceable(24) %12, i8* noundef nonnull align 8 dereferenceable(24) %1, i64 24, i1 false)
call void @llvm.lifetime.end.p0i8(i64 24, i8* nonnull %1)
br label %bb29

bb13:                                             ; preds = %bb13.preheader, %bb16
%_2.idx.val1.i.i108 = phi { i64, i64 }* [ %_2.idx.val1.i.i109.ph, %bb16 ], [ %9, %bb13.preheader ]
%_4.i105 = phi i64 [ %_4.i.ph, %bb16 ], [ 0, %bb13.preheader ]
%iter.sroa.0.094 = phi i64 [ %13, %bb16 ], [ 0, %bb13.preheader ]
%13 = add nuw i64 %iter.sroa.0.094, 1
%14 = getelementptr inbounds [0 x i8], [0 x i8]* %seq.0, i64 0, i64 %iter.sroa.0.094
br label %bb14.outer

bb14.outer:                                       ; preds = %"alloc::vec::Vec<T,A>::push.exit"
%_2.idx.val1.i.i109.ph = phi { i64, i64 }* [ %_2.idx.val1.i.i, %"alloc::vec::Vec<T,A>::push.exit"
%_4.i.ph = phi i64 [ %48, %"alloc::vec::Vec<T,A>::push.exit"
%iter1.sroa.0.0.ph = phi i64 [ %iter1.sroa.0.181, %"alloc::vec::Vec<T,A>::push.exit"
%_2.not.i.ph = phi i1 [ true, %"alloc::vec::Vec<T,A>::push.exit"
br label %bb14

bb14:                                             ; preds = %bb14.backedge, %bb14.outer
%iter1.sroa.0.0 = phi i64 [ %iter1.sroa.0.0.ph, %bb14.outer ], [ %iter1.sroa.0.181, %bb14.backedge ]
%_2.not.i = phi i1 [ %_2.not.i.ph, %bb14.outer ], [ true, %bb14.backedge ]
br i1 %_2.not.i, label %bb15, label %bb1.i

bb1.i:                                            ; preds = %bb14
%15 = icmp ult i64 %iter1.sroa.0.0, 13
br i1 %15, label %bb19, label %bb16

bb15:                                             ; preds = %bb14
%16 = tail call { i64, i1 } @llvm.uadd.with.overflow.i64(i64 %iter1.sroa.0.0, i64 1) #18
%17 = extractvalue { i64, i1 } %16, 0
%18 = extractvalue { i64, i1 } %16, 1
%19 = icmp ugt i64 %17, 12
%20 = or i1 %18, %19
br i1 %20, label %bb16, label %bb19

bb16:                                             ; preds = %bb1.i, %bb15
%exitcond.not = icmp eq i64 %13, %_11
br i1 %exitcond.not, label %bb9, label %bb13

bb19:                                             ; preds = %bb1.i, %bb15
%_3.val.i.i.pn.i83 = phi i64 [ %17, %bb15 ], [ %iter1.sroa.0.0, %bb1.i ]
%iter1.sroa.0.181 = add nuw i64 %_3.val.i.i.pn.i83, 1
%_42 = add i64 %_3.val.i.i.pn.i83, %iter.sroa.0.094
%_41 = icmp ugt i64 %_42, %seq.1
br i1 %_41, label %bb14.backedge, label %bb20

bb20:                                             ; preds = %bb19
%_3.i.i29 = icmp ult i64 %_42, %iter.sroa.0.094
br i1 %_3.i.i29, label %bb1.i.i, label %bb21

bb1.i.i:                                          ; preds = %bb20
; invoke core::slice::index::slice_index_order_fail
invoke void @_ZN4core5slice5index22slice_index_order_fail17he509ed29038f8526E(i64 %iter.sroa.0.094, i64 %_42, %"core::panic::location::Location"* noalias readonly align 8 dereferenceable(24) bitcast (<{ i8*, [16 x i8] }>* @alloc330 to %"core::panic::location::Location"
to label %.noexc unwind label %cleanup.loopexit.split-lp

.noexc:                                           ; preds = %bb1.i.i
unreachable

bb21:                                             ; preds = %bb20
tail call void @llvm.experimental.noalias.scope.decl(metadata !665)
tail call void @llvm.experimental.noalias.scope.decl(metadata !668)
%21 = icmp eq i64 %_3.val.i.i.pn.i83, 0
br i1 %21, label %_ZN20bio_lib_algebraic_rs18reverse_complement17h79fc599ad2bf9f79E.exit.i, label %"<alloc::alloc::Global as core::alloc::Allocator>::allocate::hf937eda5e01a1b11.exit.i.i.i.i.i.i.i.i.i.i"

"<alloc::alloc::Global as core::alloc::Allocator>::allocate::hf937eda5e01a1b11.exit.i.i.i.i.i.i.i.i.i.i"
%22 = tail call i8* @__rust_alloc(i64 %_3.val.i.i.pn.i83, i64 1) #18, !noalias !671
%23 = icmp eq i8* %22, null
br i1 %23, label %bb20.i.i.i.i.i.i.i.i.i.i, label %bb3.i.i.i.i.i.i.i.i.i.i.i.preheader

bb3.i.i.i.i.i.i.i.i.i.i.i.preheader:              ; preds = %"<alloc::alloc::Global as core::alloc::Allocator>::allocate::hf937eda5e01a1b11.exit.i.i.i.i.i.i.i.i.i.i"
%24 = getelementptr inbounds i8, i8* %14, i64 %_3.val.i.i.pn.i83
%25 = add i64 %_3.val.i.i.pn.i83, -1
%xtraiter = and i64 %_3.val.i.i.pn.i83, 7
%lcmp.mod.not = icmp eq i64 %xtraiter, 0
br i1 %lcmp.mod.not, label %bb3.i.i.i.i.i.i.i.i.i.i.i.prol.loopexit, label %bb3.i.i.i.i.i.i.i.i.i.i.i.prol

bb3.i.i.i.i.i.i.i.i.i.i.i.prol:                   ; preds = %bb3.i.i.i.i.i.i.i.i.i.i.i.preheader, %bb3.i.i.i.i.i.i.i.i.i.i.i.prol
%_6.sroa.0.0.i.i.i.i.i.i.i.i.i.i.prol = phi i8* [ %27, %bb3.i.i.i.i.i.i.i.i.i.i.i.prol ], [ %22, %bb3.i.i.i.i.i.i.i.i.i.i.i.preheader ]
%self.sroa.2.021.i.i.i.i.i.i.i.i.i.i.i.prol = phi i8* [ %26, %bb3.i.i.i.i.i.i.i.i.i.i.i.prol ], [ %24, %bb3.i.i.i.i.i.i.i.i.i.i.i.preheader ]
%prol.iter = phi i64 [ %prol.iter.sub, %bb3.i.i.i.i.i.i.i.i.i.i.i.prol ], [ %xtraiter, %bb3.i.i.i.i.i.i.i.i.i.i.i.preheader ]
%26 = getelementptr inbounds i8, i8* %self.sroa.2.021.i.i.i.i.i.i.i.i.i.i.i.prol, i64 -1
%.val.i.i.i.i.i.i.i.i.i.i.i.prol = load i8, i8* %26, align 1, !alias.scope !685, !noalias !688
%switch.offset.prol = sub i8 3, %.val.i.i.i.i.i.i.i.i.i.i.i.prol
store i8 %switch.offset.prol, i8* %_6.sroa.0.0.i.i.i.i.i.i.i.i.i.i.prol, align 1, !noalias !699
%27 = getelementptr inbounds i8, i8* %_6.sroa.0.0.i.i.i.i.i.i.i.i.i.i.prol, i64 1
%prol.iter.sub = add i64 %prol.iter, -1
%prol.iter.cmp.not = icmp eq i64 %prol.iter.sub, 0
br i1 %prol.iter.cmp.not, label %bb3.i.i.i.i.i.i.i.i.i.i.i.prol.loopexit, label %bb3.i.i.i.i.i.i.i.i.i.i.i.prol, !llvm.loop !706

bb3.i.i.i.i.i.i.i.i.i.i.i.prol.loopexit:          ; preds = %bb3.i.i.i.i.i.i.i.i.i.i.i.prol, %bb3.i.i.i.i.i.i.i.i.i.i.i.preheader
%_6.sroa.0.0.i.i.i.i.i.i.i.i.i.i.unr = phi i8* [ %22, %bb3.i.i.i.i.i.i.i.i.i.i.i.preheader ], [ %27, %bb3.i.i.i.i.i.i.i.i.i.i.i.prol ]
%self.sroa.2.021.i.i.i.i.i.i.i.i.i.i.i.unr = phi i8* [ %24, %bb3.i.i.i.i.i.i.i.i.i.i.i.preheader ], [ %26, %bb3.i.i.i.i.i.i.i.i.i.i.i.prol ]
%28 = icmp ult i64 %25, 7
br i1 %28, label %_ZN20bio_lib_algebraic_rs18reverse_complement17h79fc599ad2bf9f79E.exit.i, label %bb3.i.i.i.i.i.i.i.i.i.i.i

bb20.i.i.i.i.i.i.i.i.i.i:                         ; preds = %"<alloc::alloc::Global as core::alloc::Allocator>::allocate::hf937eda5e01a1b11.exit.i.i.i.i.i.i.i.i.i.i"
; call alloc::alloc::handle_alloc_error
tail call void @_ZN5alloc5alloc18handle_alloc_error17h4cd683bcbb15ef4bE(i64 %_3.val.i.i.pn.i83, i64 1) #21, !noalias !671
unreachable

bb3.i.i.i.i.i.i.i.i.i.i.i:                        ; preds = %bb3.i.i.i.i.i.i.i.i.i.i.i.prol.loopexit, %bb3.i.i.i.i.i.i.i.i.i.i.i
%_6.sroa.0.0.i.i.i.i.i.i.i.i.i.i = phi i8* [ %44, %bb3.i.i.i.i.i.i.i.i.i.i.i ], [ %_6.sroa.0.0.i.i.i.i.i.i.i.i.i.i.unr, %bb3.i.i.i.i.i.i.i.i.i.i.i.prol.loopexit ]
%self.sroa.2.021.i.i.i.i.i.i.i.i.i.i.i = phi i8* [ %43, %bb3.i.i.i.i.i.i.i.i.i.i.i ], [ %self.sroa.2.021.i.i.i.i.i.i.i.i.i.i.i.unr, %bb3.i.i.i.i.i.i.i.i.i.i.i.prol.loopexit ]
%29 = getelementptr inbounds i8, i8* %self.sroa.2.021.i.i.i.i.i.i.i.i.i.i.i, i64 -1
%.val.i.i.i.i.i.i.i.i.i.i.i = load i8, i8* %29, align 1, !alias.scope !685, !noalias !688
%switch.offset = sub i8 3, %.val.i.i.i.i.i.i.i.i.i.i.i
store i8 %switch.offset, i8* %_6.sroa.0.0.i.i.i.i.i.i.i.i.i.i, align 1, !noalias !699
%30 = getelementptr inbounds i8, i8* %_6.sroa.0.0.i.i.i.i.i.i.i.i.i.i, i64 1
%31 = getelementptr inbounds i8, i8* %self.sroa.2.021.i.i.i.i.i.i.i.i.i.i.i, i64 -2
%.val.i.i.i.i.i.i.i.i.i.i.i.1 = load i8, i8* %31, align 1, !alias.scope !685, !noalias !688
%switch.offset.1 = sub i8 3, %.val.i.i.i.i.i.i.i.i.i.i.i.1
store i8 %switch.offset.1, i8* %30, align 1, !noalias !699
%32 = getelementptr inbounds i8, i8* %_6.sroa.0.0.i.i.i.i.i.i.i.i.i.i, i64 2
%33 = getelementptr inbounds i8, i8* %self.sroa.2.021.i.i.i.i.i.i.i.i.i.i.i, i64 -3
%.val.i.i.i.i.i.i.i.i.i.i.i.2 = load i8, i8* %33, align 1, !alias.scope !685, !noalias !688
%switch.offset.2 = sub i8 3, %.val.i.i.i.i.i.i.i.i.i.i.i.2
store i8 %switch.offset.2, i8* %32, align 1, !noalias !699
%34 = getelementptr inbounds i8, i8* %_6.sroa.0.0.i.i.i.i.i.i.i.i.i.i, i64 3
%35 = getelementptr inbounds i8, i8* %self.sroa.2.021.i.i.i.i.i.i.i.i.i.i.i, i64 -4
%.val.i.i.i.i.i.i.i.i.i.i.i.3 = load i8, i8* %35, align 1, !alias.scope !685, !noalias !688
%switch.offset.3 = sub i8 3, %.val.i.i.i.i.i.i.i.i.i.i.i.3
store i8 %switch.offset.3, i8* %34, align 1, !noalias !699
%36 = getelementptr inbounds i8, i8* %_6.sroa.0.0.i.i.i.i.i.i.i.i.i.i, i64 4
%37 = getelementptr inbounds i8, i8* %self.sroa.2.021.i.i.i.i.i.i.i.i.i.i.i, i64 -5
%.val.i.i.i.i.i.i.i.i.i.i.i.4 = load i8, i8* %37, align 1, !alias.scope !685, !noalias !688
%switch.offset.4 = sub i8 3, %.val.i.i.i.i.i.i.i.i.i.i.i.4
store i8 %switch.offset.4, i8* %36, align 1, !noalias !699
%38 = getelementptr inbounds i8, i8* %_6.sroa.0.0.i.i.i.i.i.i.i.i.i.i, i64 5
%39 = getelementptr inbounds i8, i8* %self.sroa.2.021.i.i.i.i.i.i.i.i.i.i.i, i64 -6
%.val.i.i.i.i.i.i.i.i.i.i.i.5 = load i8, i8* %39, align 1, !alias.scope !685, !noalias !688
%switch.offset.5 = sub i8 3, %.val.i.i.i.i.i.i.i.i.i.i.i.5
store i8 %switch.offset.5, i8* %38, align 1, !noalias !699
%40 = getelementptr inbounds i8, i8* %_6.sroa.0.0.i.i.i.i.i.i.i.i.i.i, i64 6
%41 = getelementptr inbounds i8, i8* %self.sroa.2.021.i.i.i.i.i.i.i.i.i.i.i, i64 -7
%.val.i.i.i.i.i.i.i.i.i.i.i.6 = load i8, i8* %41, align 1, !alias.scope !685, !noalias !688
%switch.offset.6 = sub i8 3, %.val.i.i.i.i.i.i.i.i.i.i.i.6
store i8 %switch.offset.6, i8* %40, align 1, !noalias !699
%42 = getelementptr inbounds i8, i8* %_6.sroa.0.0.i.i.i.i.i.i.i.i.i.i, i64 7
%43 = getelementptr inbounds i8, i8* %self.sroa.2.021.i.i.i.i.i.i.i.i.i.i.i, i64 -8
%.val.i.i.i.i.i.i.i.i.i.i.i.7 = load i8, i8* %43, align 1, !alias.scope !685, !noalias !688
%switch.offset.7 = sub i8 3, %.val.i.i.i.i.i.i.i.i.i.i.i.7
store i8 %switch.offset.7, i8* %42, align 1, !noalias !699
%44 = getelementptr inbounds i8, i8* %_6.sroa.0.0.i.i.i.i.i.i.i.i.i.i, i64 8
%_12.i.i.i.i.i.i.i.i.i.i.i.i.7 = icmp eq i8* %43, %14
br i1 %_12.i.i.i.i.i.i.i.i.i.i.i.i.7, label %_ZN20bio_lib_algebraic_rs18reverse_complement17h79fc599ad2bf9f79E.exit.i, label %bb3.i.i.i.i.i.i.i.i.i.i.i

_ZN20bio_lib_algebraic_rs18reverse_complement17h79fc599ad2bf9f79E.exit.i: ; preds = %bb3.i.i.i.i.i.i.i.i.i.i.i.prol.loopexit, %bb3.i.i.i.i.i.i.i.i.i.i.i, %bb21
%_3.0.i.i.i.i.i.i.i11.i = phi i8* [ inttoptr (i64 1 to i8*), %bb21 ], [ %22, %bb3.i.i.i.i.i.i.i.i.i.i.i ], [ %22, %bb3.i.i.i.i.i.i.i.i.i.i.i.prol.loopexit ]
tail call void @llvm.experimental.noalias.scope.decl(metadata !707) #18
tail call void @llvm.experimental.noalias.scope.decl(metadata !710) #18
tail call void @llvm.experimental.noalias.scope.decl(metadata !712) #18
tail call void @llvm.experimental.noalias.scope.decl(metadata !715) #18
br label %bb1.i.i.i.i.i.i

bb1.i.i.i.i.i.i:                                  ; preds = %"<core::iter::adapters::zip::Zip<A,B> as core::iter::traits::iterator::Iterator>::next::hb534527c8b4dda02.exit.i.i.i.i.i.i"
%_3.i.i.i.i.i.i.i.i = phi i64 [ %45, %"<core::iter::adapters::zip::Zip<A,B> as core::iter::traits::iterator::Iterator>::next::hb534527c8b4dda02.exit.i.i.i.i.i.i"
%exitcond.not.i.i.i.i.i = icmp eq i64 %_3.i.i.i.i.i.i.i.i, %_3.val.i.i.pn.i83
br i1 %exitcond.not.i.i.i.i.i, label %bb2.i, label %"<core::iter::adapters::zip::Zip<A,B> as core::iter::traits::iterator::Iterator>::next::hb534527c8b4dda02.exit.i.i.i.i.i.i"

"<core::iter::adapters::zip::Zip<A,B> as core::iter::traits::iterator::Iterator>::next::hb534527c8b4dda02.exit.i.i.i.i.i.i"
%45 = add i64 %_3.i.i.i.i.i.i.i.i, 1
%46 = getelementptr inbounds i8, i8* %14, i64 %_3.i.i.i.i.i.i.i.i
%47 = getelementptr inbounds i8, i8* %_3.0.i.i.i.i.i.i.i11.i, i64 %_3.i.i.i.i.i.i.i.i
%.fca.0.extract.val.i.i.i.i.i.i = load i8, i8* %47, align 1, !alias.scope !717, !noalias !720
%.fca.1.extract.val.i.i.i.i.i.i = load i8, i8* %46, align 1, !alias.scope !726, !noalias !727
%_10.i.i.i.i.not.i.i.i.i.i.i = icmp eq i8 %.fca.0.extract.val.i.i.i.i.i.i, %.fca.1.extract.val.i.i.i.i.i.i
br i1 %_10.i.i.i.i.not.i.i.i.i.i.i, label %bb1.i.i.i.i.i.i, label %bb2.i

bb2.i:                                            ; preds = %"<core::iter::adapters::zip::Zip<A,B> as core::iter::traits::iterator::Iterator>::next::hb534527c8b4dda02.exit.i.i.i.i.i.i"
br i1 %21, label %bb22, label %"<alloc::alloc::Global as core::alloc::Allocator>::deallocate::h9b60384a02e7a209.exit.i.i.i.i"

"<alloc::alloc::Global as core::alloc::Allocator>::deallocate::h9b60384a02e7a209.exit.i.i.i.i"
tail call void @__rust_dealloc(i8* nonnull %_3.0.i.i.i.i.i.i.i11.i, i64 %_3.val.i.i.pn.i83, i64 1) #18
br label %bb22

bb22:                                             ; preds = %"<alloc::alloc::Global as core::alloc::Allocator>::deallocate::h9b60384a02e7a209.exit.i.i.i.i"
br i1 %exitcond.not.i.i.i.i.i, label %bb23, label %bb14.backedge

bb14.backedge:                                    ; preds = %bb22, %bb19
br label %bb14

bb23:                                             ; preds = %bb22
tail call void @llvm.experimental.noalias.scope.decl(metadata !728)
%_6.idx.val.i = load i64, i64* %4, align 8, !alias.scope !728
%_3.i = icmp eq i64 %_4.i.ph, %_6.idx.val.i
br i1 %_3.i, label %bb2.i.i.i32, label %"alloc::vec::Vec<T,A>::push.exit"

bb2.i.i.i32:                                      ; preds = %bb23
; invoke alloc::raw_vec::RawVec<T,A>::reserve::do_reserve_and_handle
invoke fastcc void @"alloc::raw_vec::RawVec<T,A>::reserve::do_reserve_and_handle"
to label %.noexc33 unwind label %cleanup.loopexit

.noexc33:                                         ; preds = %bb2.i.i.i32
%_12.pre.i = load i64, i64* %10, align 8, !alias.scope !728
%_2.idx.val1.i.i.pre = load { i64, i64 }*, { i64, i64 }** %11, align 8, !alias.scope !731
br label %"alloc::vec::Vec<T,A>::push.exit"

"alloc::vec::Vec<T,A>::push.exit"
%_2.idx.val1.i.i = phi { i64, i64 }* [ %_2.idx.val1.i.i.pre, %.noexc33 ], [ %_2.idx.val1.i.i109.ph, %bb23 ]
%_12.i = phi i64 [ %_12.pre.i, %.noexc33 ], [ %_4.i.ph, %bb23 ]
%src.sroa.0.0..sroa_idx.i.i = getelementptr inbounds { i64, i64 }, { i64, i64 }* %_2.idx.val1.i.i, i64 %_12.i, i32 0
store i64 %13, i64* %src.sroa.0.0..sroa_idx.i.i, align 8, !noalias !728
%src.sroa.2.0..sroa_idx1.i.i = getelementptr inbounds { i64, i64 }, { i64, i64 }* %_2.idx.val1.i.i, i64 %_12.i, i32 1
store i64 %_3.val.i.i.pn.i83, i64* %src.sroa.2.0..sroa_idx1.i.i, align 8, !noalias !728
%48 = add i64 %_12.i, 1
store i64 %48, i64* %10, align 8, !alias.scope !728
br label %bb14.outer
}
