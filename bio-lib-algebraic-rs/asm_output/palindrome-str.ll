define void @bio_lib_algebraic_rs::find_reverse_palindromes_str(%"alloc::vec::Vec<PalindromeLocation>"* noalias nocapture sret(%"alloc::vec::Vec<PalindromeLocation>") dereferenceable(24) %0, [0 x i8]* noalias nonnull readonly align 1 %seq.0, i64 %seq.1) unnamed_addr #3 personality i32 (i32, i32, i64, %"unwind::libunwind::_Unwind_Exception"*, %"unwind::libunwind::_Unwind_Context"
bb2:
%_4.i = alloca %"alloc::string::String"
%locations = alloca %"alloc::vec::Vec<PalindromeLocation>"
%1 = bitcast %"alloc::vec::Vec<PalindromeLocation>"
call void @llvm.lifetime.start.p0i8(i64 24, i8* nonnull %1)
tail call void @llvm.experimental.noalias.scope.decl(metadata !659)
%2 = load i64*, i64** bitcast (<{ [16 x i8] }>* @1 to i64**), align 8, !noalias !659, !nonnull !10
%3 = getelementptr inbounds %"alloc::vec::Vec<PalindromeLocation>", %"alloc::vec::Vec<PalindromeLocation>"
store i64* %2, i64** %3, align 8, !alias.scope !659
%4 = getelementptr inbounds %"alloc::vec::Vec<PalindromeLocation>", %"alloc::vec::Vec<PalindromeLocation>"
%5 = bitcast i64* %4 to i8*
call void @llvm.memset.p0i8.i64(i8* noundef nonnull align 8 dereferenceable(16) %5, i8 0, i64 16, i1 false) #19, !alias.scope !659
%_5 = icmp ult i64 %seq.1, 4
br i1 %_5, label %"core::ptr::drop_in_place<alloc::vec::Vec<bio_lib_algebraic_rs::PalindromeLocation>>.exit"

cleanup.loopexit.loopexit:                        ; preds = %bb21
%lpad.loopexit114 = landingpad { i8*, i32 }
cleanup
br label %cleanup

cleanup.loopexit.loopexit.split-lp:               ; preds = %bb2.i.i.i34
%lpad.loopexit.split-lp115 = landingpad { i8*, i32 }
cleanup
br label %cleanup

cleanup.loopexit.split-lp:                        ; preds = %bb2.i.i31
%lpad.loopexit.split-lp = landingpad { i8*, i32 }
cleanup
br label %cleanup

cleanup:                                          ; preds = %cleanup.loopexit.loopexit, %cleanup.loopexit.loopexit.split-lp, %cleanup.loopexit.split-lp
%lpad.phi = phi { i8*, i32 } [ %lpad.loopexit.split-lp, %cleanup.loopexit.split-lp ], [ %lpad.loopexit114, %cleanup.loopexit.loopexit ], [ %lpad.loopexit.split-lp115, %cleanup.loopexit.loopexit.split-lp ]
; call core::ptr::drop_in_place<alloc::vec::Vec<bio_lib_algebraic_rs::PalindromeLocation>>
call fastcc void @"core::ptr::drop_in_place<alloc::vec::Vec<bio_lib_algebraic_rs::PalindromeLocation>>"(%"alloc::vec::Vec<PalindromeLocation>"
resume { i8*, i32 } %lpad.phi

"core::ptr::drop_in_place<alloc::vec::Vec<bio_lib_algebraic_rs::PalindromeLocation>>.exit"
%6 = getelementptr inbounds %"alloc::vec::Vec<PalindromeLocation>", %"alloc::vec::Vec<PalindromeLocation>"
store i64* %2, i64** %6, align 8, !alias.scope !662
%7 = getelementptr inbounds %"alloc::vec::Vec<PalindromeLocation>", %"alloc::vec::Vec<PalindromeLocation>"
%8 = bitcast i64* %7 to i8*
tail call void @llvm.memset.p0i8.i64(i8* noundef nonnull align 8 dereferenceable(16) %8, i8 0, i64 16, i1 false) #19, !alias.scope !662
call void @llvm.lifetime.end.p0i8(i64 24, i8* nonnull %1)
br label %bb29

bb29:                                             ; preds = %bb9, %"core::ptr::drop_in_place<alloc::vec::Vec<bio_lib_algebraic_rs::PalindromeLocation>>.exit"
ret void

bb13.preheader:                                   ; preds = %bb2
%9 = bitcast i64* %2 to { i64, i64 }*
%_11 = add i64 %seq.1, -3
%10 = bitcast %"alloc::string::String"
%_6.idx1.i.i.i = getelementptr inbounds %"alloc::string::String", %"alloc::string::String"
%.idx.i.i.phi.trans.insert.i = getelementptr inbounds %"alloc::string::String", %"alloc::string::String"
%11 = bitcast %"alloc::string::String"
%.idx5.i.i.i = getelementptr inbounds %"alloc::string::String", %"alloc::string::String"
%12 = getelementptr inbounds %"alloc::vec::Vec<PalindromeLocation>", %"alloc::vec::Vec<PalindromeLocation>"
%_6.i = getelementptr inbounds %"alloc::vec::Vec<PalindromeLocation>", %"alloc::vec::Vec<PalindromeLocation>"
%13 = bitcast %"alloc::vec::Vec<PalindromeLocation>"
br label %bb13

bb9:                                              ; preds = %bb16
%14 = bitcast %"alloc::vec::Vec<PalindromeLocation>"
call void @llvm.memcpy.p0i8.p0i8.i64(i8* noundef nonnull align 8 dereferenceable(24) %14, i8* noundef nonnull align 8 dereferenceable(24) %1, i64 24, i1 false)
call void @llvm.lifetime.end.p0i8(i64 24, i8* nonnull %1)
br label %bb29

bb13:                                             ; preds = %bb13.preheader, %bb16
%_2.idx.val1.i.i96 = phi { i64, i64 }* [ %_2.idx.val1.i.i97.ph, %bb16 ], [ %9, %bb13.preheader ]
%_4.i3393 = phi i64 [ %_4.i33.ph, %bb16 ], [ 0, %bb13.preheader ]
%iter.sroa.0.089 = phi i64 [ %15, %bb16 ], [ 0, %bb13.preheader ]
%15 = add nuw i64 %iter.sroa.0.089, 1
%16 = icmp eq i64 %iter.sroa.0.089, 0
%_3.i.i.i.i.i.i = icmp ult i64 %iter.sroa.0.089, %seq.1
%17 = icmp eq i64 %iter.sroa.0.089, %seq.1
%18 = getelementptr inbounds [0 x i8], [0 x i8]* %seq.0, i64 0, i64 %iter.sroa.0.089
%19 = bitcast i8* %18 to [0 x i8]*
br label %bb14.outer

bb14.outer:                                       ; preds = %"alloc::vec::Vec<T,A>::push.exit"
%_2.idx.val1.i.i97.ph = phi { i64, i64 }* [ %_2.idx.val1.i.i, %"alloc::vec::Vec<T,A>::push.exit"
%_4.i33.ph = phi i64 [ %33, %"alloc::vec::Vec<T,A>::push.exit"
%iter1.sroa.0.0.ph = phi i64 [ %iter1.sroa.0.183, %"alloc::vec::Vec<T,A>::push.exit"
%_2.not.i.ph = phi i1 [ true, %"alloc::vec::Vec<T,A>::push.exit"
br label %bb14

bb14:                                             ; preds = %bb14.backedge, %bb14.outer
%iter1.sroa.0.0 = phi i64 [ %iter1.sroa.0.0.ph, %bb14.outer ], [ %iter1.sroa.0.183, %bb14.backedge ]
%_2.not.i = phi i1 [ %_2.not.i.ph, %bb14.outer ], [ true, %bb14.backedge ]
br i1 %_2.not.i, label %bb15, label %bb1.i

bb1.i:                                            ; preds = %bb14
%20 = icmp ult i64 %iter1.sroa.0.0, 13
br i1 %20, label %bb19, label %bb16

bb15:                                             ; preds = %bb14
%21 = tail call { i64, i1 } @llvm.uadd.with.overflow.i64(i64 %iter1.sroa.0.0, i64 1) #19
%22 = extractvalue { i64, i1 } %21, 0
%23 = extractvalue { i64, i1 } %21, 1
%24 = icmp ugt i64 %22, 12
%25 = or i1 %23, %24
br i1 %25, label %bb16, label %bb19

bb16:                                             ; preds = %bb1.i, %bb15
%exitcond.not = icmp eq i64 %15, %_11
br i1 %exitcond.not, label %bb9, label %bb13

bb19:                                             ; preds = %bb1.i, %bb15
%_3.val.i.i.pn.i85 = phi i64 [ %22, %bb15 ], [ %iter1.sroa.0.0, %bb1.i ]
%iter1.sroa.0.183 = add nuw i64 %_3.val.i.i.pn.i85, 1
%_42 = add i64 %_3.val.i.i.pn.i85, %iter.sroa.0.089
%_41 = icmp ugt i64 %_42, %seq.1
br i1 %_41, label %bb14.backedge, label %bb20

bb20:                                             ; preds = %bb19
%_5.not.i.i.i = icmp ult i64 %_42, %iter.sroa.0.089
br i1 %_5.not.i.i.i, label %bb2.i.i31, label %bb5.i.i.i

bb5.i.i.i:                                        ; preds = %bb20
br i1 %16, label %bb2.i.i.i30, label %bb2.i.i.i.i29

bb2.i.i.i.i29:                                    ; preds = %bb5.i.i.i
br i1 %_3.i.i.i.i.i.i, label %"core::str::<impl str>::is_char_boundary::h48d46309e7314696.exit.i.i.i"

bb7.i.i.i.i:                                      ; preds = %bb2.i.i.i.i29
br i1 %17, label %bb2.i.i.i30, label %bb2.i.i31

"core::str::<impl str>::is_char_boundary::h48d46309e7314696.exit.i.i.i"
%b.i.i.i.i = load i8, i8* %18, align 1, !alias.scope !665
%26 = icmp sgt i8 %b.i.i.i.i, -65
br i1 %26, label %bb2.i.i.i30, label %bb2.i.i31

bb2.i.i.i30:                                      ; preds = %"core::str::<impl str>::is_char_boundary::h48d46309e7314696.exit.i.i.i"
%27 = icmp eq i64 %_42, 0
br i1 %27, label %bb21, label %bb2.i3.i.i.i

bb2.i3.i.i.i:                                     ; preds = %bb2.i.i.i30
%_3.i.i.i2.i.i.i = icmp ult i64 %_42, %seq.1
br i1 %_3.i.i.i2.i.i.i, label %"core::str::<impl str>::is_char_boundary::h48d46309e7314696.exit8.i.i.i"

bb7.i4.i.i.i:                                     ; preds = %bb2.i3.i.i.i
%28 = icmp eq i64 %_42, %seq.1
br i1 %28, label %bb21, label %bb2.i.i31

"core::str::<impl str>::is_char_boundary::h48d46309e7314696.exit8.i.i.i"
%29 = getelementptr inbounds [0 x i8], [0 x i8]* %seq.0, i64 0, i64 %_42
%b.i5.i.i.i = load i8, i8* %29, align 1, !alias.scope !674
%30 = icmp sgt i8 %b.i5.i.i.i, -65
br i1 %30, label %bb21, label %bb2.i.i31

bb2.i.i31:                                        ; preds = %"core::str::<impl str>::is_char_boundary::h48d46309e7314696.exit8.i.i.i", %bb7.i4.i.i.i, %"core::str::<impl str>::is_char_boundary::h48d46309e7314696.exit.i.i.i"
; invoke core::str::slice_error_fail
invoke void @_ZN4core3str16slice_error_fail17h75b5adf3a88db9cfE([0 x i8]* noalias nonnull readonly align 1 %seq.0, i64 %seq.1, i64 %iter.sroa.0.089, i64 %_42, %"core::panic::location::Location"* noalias readonly align 8 dereferenceable(24) bitcast (<{ i8*, [16 x i8] }>* @alloc348 to %"core::panic::location::Location"
to label %.noexc unwind label %cleanup.loopexit.split-lp

.noexc:                                           ; preds = %bb2.i.i31
unreachable

bb21:                                             ; preds = %"core::str::<impl str>::is_char_boundary::h48d46309e7314696.exit8.i.i.i"
call void @llvm.lifetime.start.p0i8(i64 24, i8* nonnull %10), !noalias !677
; invoke bio_lib_algebraic_rs::reverse_complement_dna_str
invoke void @_ZN20bio_lib_algebraic_rs26reverse_complement_dna_str17hebefe5a841e803e7E(%"alloc::string::String"* noalias nocapture nonnull sret(%"alloc::string::String"
to label %.noexc32 unwind label %cleanup.loopexit.loopexit

.noexc32:                                         ; preds = %bb21
tail call void @llvm.experimental.noalias.scope.decl(metadata !680)
%_6.idx1.val.i.i.i = load i64, i64* %_6.idx1.i.i.i, align 8, !alias.scope !683, !noalias !677
%_3.not.i.i.i.i.i.i = icmp eq i64 %_6.idx1.val.i.i.i, %_3.val.i.i.pn.i85
br i1 %_3.not.i.i.i.i.i.i, label %bb2.i.i.i.i.i.i, label %start.bb2_crit_edge.i

start.bb2_crit_edge.i:                            ; preds = %.noexc32
%.idx.val.i.i.pre.i = load i8*, i8** %.idx.i.i.phi.trans.insert.i, align 8, !noalias !677
br label %bb2.i

bb2.i.i.i.i.i.i:                                  ; preds = %.noexc32
%_6.idx.val2.i.i.i = load [0 x i8]*, [0 x i8]** %11, align 8, !alias.scope !686, !noalias !677
%31 = getelementptr [0 x i8], [0 x i8]* %_6.idx.val2.i.i.i, i64 0, i64 0
%_10.i.i.i.i.i.i = tail call i32 @memcmp(i8* nonnull %18, i8* nonnull %31, i64 %_3.val.i.i.pn.i85) #19, !alias.scope !689, !noalias !680
%32 = icmp eq i32 %_10.i.i.i.i.i.i, 0
br label %bb2.i

bb2.i:                                            ; preds = %bb2.i.i.i.i.i.i, %start.bb2_crit_edge.i
%.idx.val.i.i.i = phi i8* [ %31, %bb2.i.i.i.i.i.i ], [ %.idx.val.i.i.pre.i, %start.bb2_crit_edge.i ]
%.0.i.i.i.i.i.i = phi i1 [ %32, %bb2.i.i.i.i.i.i ], [ false, %start.bb2_crit_edge.i ]
%.idx5.val.i.i.i = load i64, i64* %.idx5.i.i.i, align 8, !noalias !677
%_4.i.i.i.i.i.i = icmp eq i64 %.idx5.val.i.i.i, 0
%.not.i.i.i.i.i = icmp eq i8* %.idx.val.i.i.i, null
%or.cond.i.i.i.i.i = select i1 %_4.i.i.i.i.i.i, i1 true, i1 %.not.i.i.i.i.i
br i1 %or.cond.i.i.i.i.i, label %bb22, label %"<alloc::alloc::Global as core::alloc::Allocator>::deallocate::h9b60384a02e7a209.exit.i.i.i.i.i"

"<alloc::alloc::Global as core::alloc::Allocator>::deallocate::h9b60384a02e7a209.exit.i.i.i.i.i"
tail call void @__rust_dealloc(i8* nonnull %.idx.val.i.i.i, i64 %.idx5.val.i.i.i, i64 1) #19
br label %bb22

bb22:                                             ; preds = %"<alloc::alloc::Global as core::alloc::Allocator>::deallocate::h9b60384a02e7a209.exit.i.i.i.i.i"
call void @llvm.lifetime.end.p0i8(i64 24, i8* nonnull %10), !noalias !677
br i1 %.0.i.i.i.i.i.i, label %bb23, label %bb14.backedge

bb14.backedge:                                    ; preds = %bb22, %bb19
br label %bb14

bb23:                                             ; preds = %bb22
tail call void @llvm.experimental.noalias.scope.decl(metadata !699)
%_6.idx.val.i = load i64, i64* %4, align 8, !alias.scope !699
%_3.i = icmp eq i64 %_4.i33.ph, %_6.idx.val.i
br i1 %_3.i, label %bb2.i.i.i34, label %"alloc::vec::Vec<T,A>::push.exit"

bb2.i.i.i34:                                      ; preds = %bb23
; invoke alloc::raw_vec::RawVec<T,A>::reserve::do_reserve_and_handle
invoke fastcc void @"alloc::raw_vec::RawVec<T,A>::reserve::do_reserve_and_handle"
to label %.noexc35 unwind label %cleanup.loopexit.loopexit.split-lp

.noexc35:                                         ; preds = %bb2.i.i.i34
%_12.pre.i = load i64, i64* %12, align 8, !alias.scope !699
%_2.idx.val1.i.i.pre = load { i64, i64 }*, { i64, i64 }** %13, align 8, !alias.scope !702
br label %"alloc::vec::Vec<T,A>::push.exit"

"alloc::vec::Vec<T,A>::push.exit"
%_2.idx.val1.i.i = phi { i64, i64 }* [ %_2.idx.val1.i.i.pre, %.noexc35 ], [ %_2.idx.val1.i.i97.ph, %bb23 ]
%_12.i = phi i64 [ %_12.pre.i, %.noexc35 ], [ %_4.i33.ph, %bb23 ]
%src.sroa.0.0..sroa_idx.i.i = getelementptr inbounds { i64, i64 }, { i64, i64 }* %_2.idx.val1.i.i, i64 %_12.i, i32 0
store i64 %15, i64* %src.sroa.0.0..sroa_idx.i.i, align 8, !noalias !699
%src.sroa.2.0..sroa_idx1.i.i = getelementptr inbounds { i64, i64 }, { i64, i64 }* %_2.idx.val1.i.i, i64 %_12.i, i32 1
store i64 %_3.val.i.i.pn.i85, i64* %src.sroa.2.0..sroa_idx1.i.i, align 8, !noalias !699
%33 = add i64 %_12.i, 1
store i64 %33, i64* %12, align 8, !alias.scope !699
br label %bb14.outer
}
