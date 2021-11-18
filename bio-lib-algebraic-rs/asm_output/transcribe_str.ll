define void @bio_lib_algebraic_rs::transcribe_str(%"alloc::string::String"* noalias nocapture sret(%"alloc::string::String") dereferenceable(24) %0, [0 x i8]* noalias nonnull readonly align 1 %dna_seq.0, i64 %dna_seq.1) unnamed_addr #3 personality i32 (i32, i32, i64, %"unwind::libunwind::_Unwind_Exception"*, %"unwind::libunwind::_Unwind_Context"
start:
%1 = getelementptr [0 x i8], [0 x i8]* %dna_seq.0, i64 0, i64 0
%2 = getelementptr inbounds [0 x i8], [0 x i8]* %dna_seq.0, i64 0, i64 %dna_seq.1
tail call void @llvm.experimental.noalias.scope.decl(metadata !659)
tail call void @llvm.experimental.noalias.scope.decl(metadata !662)
tail call void @llvm.experimental.noalias.scope.decl(metadata !665)
%3 = load i8*, i8** bitcast (<{ [16 x i8] }>* @0 to i8**), align 8, !noalias !668, !nonnull !10
%_1.sroa.4.0..sroa_idx.i.i.i = getelementptr %"alloc::string::String", %"alloc::string::String"
%_1.sroa.4.0..sroa_idx910.i.i.i = bitcast i64* %_1.sroa.4.0..sroa_idx.i.i.i to i8*
tail call void @llvm.memset.p0i8.i64(i8* noundef nonnull align 8 dereferenceable(16) %_1.sroa.4.0..sroa_idx910.i.i.i, i8 0, i64 16, i1 false) #19, !alias.scope !671
%_1.sroa.0.0..sroa_idx.i.i.i = getelementptr inbounds %"alloc::string::String", %"alloc::string::String"
store i8* %3, i8** %_1.sroa.0.0..sroa_idx.i.i.i, align 8, !alias.scope !671
%_14.i.i.i.i.i.i = ptrtoint i8* %2 to i64
%_16.i.i.i.i.i.i = ptrtoint [0 x i8]* %dna_seq.0 to i64
%4 = sub i64 3, %_16.i.i.i.i.i.i
%_5.i.i.i.i.i = add i64 %4, %_14.i.i.i.i.i.i
%.not.i.i = icmp ult i64 %_5.i.i.i.i.i, 4
br i1 %.not.i.i, label %_ZN5alloc6string6String7reserve17h9ed00dc8fd25bd6dE.exit.i.i.i, label %bb2.i.i.i.i.i.i

bb2.i.i.i.i.i.i:                                  ; preds = %start
%_4.i.i.i.i.i = lshr i64 %_5.i.i.i.i.i, 2
%_4.i.i7.i.i.i = getelementptr inbounds %"alloc::string::String", %"alloc::string::String"
; invoke alloc::raw_vec::RawVec<T,A>::reserve::do_reserve_and_handle
invoke fastcc void @"alloc::raw_vec::RawVec<T,A>::reserve::do_reserve_and_handle"
to label %_ZN5alloc6string6String7reserve17h9ed00dc8fd25bd6dE.exit.i.i.i unwind label %cleanup1.loopexit.split-lp.i.i

_ZN5alloc6string6String7reserve17h9ed00dc8fd25bd6dE.exit.i.i.i: ; preds = %bb2.i.i.i.i.i.i, %start
%_12.i.i.i20.i.i.i.i.i.i = icmp eq i64 %dna_seq.1, 0
br i1 %_12.i.i.i20.i.i.i.i.i.i, label %_ZN4core4iter6traits8iterator8Iterator7collect17h8c399863fcfb1eefE.exit, label %bb3.i.i.i.i.i.i.i.i

bb3.i.i.i.i.i.i.i.i:                              ; preds = %_ZN5alloc6string6String7reserve17h9ed00dc8fd25bd6dE.exit.i.i.i, %.noexc9.i.i
%self.sroa.0.021.i.i.i.i.i.i = phi i8* [ %self.sroa.0.416.i.i.i.i.i.i, %.noexc9.i.i ], [ %1, %_ZN5alloc6string6String7reserve17h9ed00dc8fd25bd6dE.exit.i.i.i ]
%5 = getelementptr inbounds i8, i8* %self.sroa.0.021.i.i.i.i.i.i, i64 1
%x.i.i.i.i.i.i.i.i = load i8, i8* %self.sroa.0.021.i.i.i.i.i.i, align 1, !noalias !672
%_11.i.i.i.i.i.i.i.i = icmp sgt i8 %x.i.i.i.i.i.i.i.i, -1
br i1 %_11.i.i.i.i.i.i.i.i, label %bb7.i.i.i.i.i.i.i.i, label %bb8.i.i.i.i.i.i.i.i

bb8.i.i.i.i.i.i.i.i:                              ; preds = %bb3.i.i.i.i.i.i.i.i
%_3.i.i.i.i.i.i.i.i.i = and i8 %x.i.i.i.i.i.i.i.i, 31
%6 = zext i8 %_3.i.i.i.i.i.i.i.i.i to i32
%_12.i6.i.i.i.i.i.i.i.i = icmp eq i8* %5, %2
br i1 %_12.i6.i.i.i.i.i.i.i.i, label %_ZN4core3str11validations11unwrap_or_017h0c4fd6f52c5e1b09E.exit.i.i.i.i.i.i.i.i, label %bb3.i.i.i.i.i.i.i.i.i

bb3.i.i.i.i.i.i.i.i.i:                            ; preds = %bb8.i.i.i.i.i.i.i.i
%7 = getelementptr inbounds i8, i8* %self.sroa.0.021.i.i.i.i.i.i, i64 2
%byte.i.i.i.i.i.i.i.i.i = load i8, i8* %5, align 1, !alias.scope !685, !noalias !672
%phi.bo.i.i.i.i.i.i.i.i = and i8 %byte.i.i.i.i.i.i.i.i.i, 63
%phi.cast.i.i.i.i.i.i.i.i = zext i8 %phi.bo.i.i.i.i.i.i.i.i to i32
br label %_ZN4core3str11validations11unwrap_or_017h0c4fd6f52c5e1b09E.exit.i.i.i.i.i.i.i.i

_ZN4core3str11validations11unwrap_or_017h0c4fd6f52c5e1b09E.exit.i.i.i.i.i.i.i.i: ; preds = %bb3.i.i.i.i.i.i.i.i.i, %bb8.i.i.i.i.i.i.i.i
%self.sroa.0.1.i.i.i.i.i.i = phi i8* [ %2, %bb8.i.i.i.i.i.i.i.i ], [ %7, %bb3.i.i.i.i.i.i.i.i.i ]
%.0.i10.i.i.i.i.i.i.i.i = phi i32 [ 0, %bb8.i.i.i.i.i.i.i.i ], [ %phi.cast.i.i.i.i.i.i.i.i, %bb3.i.i.i.i.i.i.i.i.i ]
%_3.i11.i.i.i.i.i.i.i.i = shl nuw nsw i32 %6, 6
%8 = or i32 %.0.i10.i.i.i.i.i.i.i.i, %_3.i11.i.i.i.i.i.i.i.i
%_23.i.i.i.i.i.i.i.i = icmp ugt i8 %x.i.i.i.i.i.i.i.i, -33
br i1 %_23.i.i.i.i.i.i.i.i, label %bb13.i.i.i.i.i.i.i.i, label %bb3.i.i.i.i.i.i

bb7.i.i.i.i.i.i.i.i:                              ; preds = %bb3.i.i.i.i.i.i.i.i
%_13.i.i.i.i.i.i.i.i = zext i8 %x.i.i.i.i.i.i.i.i to i32
br label %bb3.i.i.i.i.i.i

bb13.i.i.i.i.i.i.i.i:                             ; preds = %_ZN4core3str11validations11unwrap_or_017h0c4fd6f52c5e1b09E.exit.i.i.i.i.i.i.i.i
%_12.i14.i.i.i.i.i.i.i.i = icmp eq i8* %self.sroa.0.1.i.i.i.i.i.i, %2
br i1 %_12.i14.i.i.i.i.i.i.i.i, label %_ZN4core3str11validations11unwrap_or_017h0c4fd6f52c5e1b09E.exit21.i.i.i.i.i.i.i.i, label %bb3.i19.i.i.i.i.i.i.i.i

bb3.i19.i.i.i.i.i.i.i.i:                          ; preds = %bb13.i.i.i.i.i.i.i.i
%9 = getelementptr inbounds i8, i8* %self.sroa.0.1.i.i.i.i.i.i, i64 1
%byte.i18.i.i.i.i.i.i.i.i = load i8, i8* %self.sroa.0.1.i.i.i.i.i.i, align 1, !alias.scope !688, !noalias !672
%phi.bo42.i.i.i.i.i.i.i.i = and i8 %byte.i18.i.i.i.i.i.i.i.i, 63
%phi.cast43.i.i.i.i.i.i.i.i = zext i8 %phi.bo42.i.i.i.i.i.i.i.i to i32
br label %_ZN4core3str11validations11unwrap_or_017h0c4fd6f52c5e1b09E.exit21.i.i.i.i.i.i.i.i

_ZN4core3str11validations11unwrap_or_017h0c4fd6f52c5e1b09E.exit21.i.i.i.i.i.i.i.i: ; preds = %bb3.i19.i.i.i.i.i.i.i.i, %bb13.i.i.i.i.i.i.i.i
%self.sroa.0.2.i.i.i.i.i.i = phi i8* [ %2, %bb13.i.i.i.i.i.i.i.i ], [ %9, %bb3.i19.i.i.i.i.i.i.i.i ]
%.0.i20.i.i.i.i.i.i.i.i = phi i32 [ 0, %bb13.i.i.i.i.i.i.i.i ], [ %phi.cast43.i.i.i.i.i.i.i.i, %bb3.i19.i.i.i.i.i.i.i.i ]
%_3.i22.i.i.i.i.i.i.i.i = shl nuw nsw i32 %.0.i10.i.i.i.i.i.i.i.i, 6
%10 = or i32 %.0.i20.i.i.i.i.i.i.i.i, %_3.i22.i.i.i.i.i.i.i.i
%_33.i.i.i.i.i.i.i.i = shl nuw nsw i32 %6, 12
%11 = or i32 %10, %_33.i.i.i.i.i.i.i.i
%_36.i.i.i.i.i.i.i.i = icmp ugt i8 %x.i.i.i.i.i.i.i.i, -17
br i1 %_36.i.i.i.i.i.i.i.i, label %bb17.i.i.i.i.i.i.i.i, label %bb3.i.i.i.i.i.i

bb17.i.i.i.i.i.i.i.i:                             ; preds = %_ZN4core3str11validations11unwrap_or_017h0c4fd6f52c5e1b09E.exit21.i.i.i.i.i.i.i.i
%_12.i27.i.i.i.i.i.i.i.i = icmp eq i8* %self.sroa.0.2.i.i.i.i.i.i, %2
br i1 %_12.i27.i.i.i.i.i.i.i.i, label %"<core::str::iter::Chars as core::iter::traits::iterator::Iterator>::next::h1db5823436931f08.exit.i.i.i.i.i.i"

bb3.i32.i.i.i.i.i.i.i.i:                          ; preds = %bb17.i.i.i.i.i.i.i.i
%12 = getelementptr inbounds i8, i8* %self.sroa.0.2.i.i.i.i.i.i, i64 1
%byte.i31.i.i.i.i.i.i.i.i = load i8, i8* %self.sroa.0.2.i.i.i.i.i.i, align 1, !alias.scope !691, !noalias !672
%phi.bo44.i.i.i.i.i.i.i.i = and i8 %byte.i31.i.i.i.i.i.i.i.i, 63
%phi.cast45.i.i.i.i.i.i.i.i = zext i8 %phi.bo44.i.i.i.i.i.i.i.i to i32
br label %"<core::str::iter::Chars as core::iter::traits::iterator::Iterator>::next::h1db5823436931f08.exit.i.i.i.i.i.i"

"<core::str::iter::Chars as core::iter::traits::iterator::Iterator>::next::h1db5823436931f08.exit.i.i.i.i.i.i"
%self.sroa.0.3.i.i.i.i.i.i = phi i8* [ %2, %bb17.i.i.i.i.i.i.i.i ], [ %12, %bb3.i32.i.i.i.i.i.i.i.i ]
%.0.i33.i.i.i.i.i.i.i.i = phi i32 [ 0, %bb17.i.i.i.i.i.i.i.i ], [ %phi.cast45.i.i.i.i.i.i.i.i, %bb3.i32.i.i.i.i.i.i.i.i ]
%_42.i.i.i.i.i.i.i.i = shl nuw nsw i32 %6, 18
%_41.i.i.i.i.i.i.i.i = and i32 %_42.i.i.i.i.i.i.i.i, 1835008
%_3.i35.i.i.i.i.i.i.i.i = shl nuw nsw i32 %10, 6
%13 = or i32 %_3.i35.i.i.i.i.i.i.i.i, %_41.i.i.i.i.i.i.i.i
%14 = or i32 %13, %.0.i33.i.i.i.i.i.i.i.i
%.not.i.i.i.i.i.i = icmp eq i32 %14, 1114112
br i1 %.not.i.i.i.i.i.i, label %_ZN4core4iter6traits8iterator8Iterator7collect17h8c399863fcfb1eefE.exit, label %bb3.i.i.i.i.i.i

bb3.i.i.i.i.i.i:                                  ; preds = %"<core::str::iter::Chars as core::iter::traits::iterator::Iterator>::next::h1db5823436931f08.exit.i.i.i.i.i.i"
%15 = phi i32 [ %14, %"<core::str::iter::Chars as core::iter::traits::iterator::Iterator>::next::h1db5823436931f08.exit.i.i.i.i.i.i"
%self.sroa.0.416.i.i.i.i.i.i = phi i8* [ %self.sroa.0.3.i.i.i.i.i.i, %"<core::str::iter::Chars as core::iter::traits::iterator::Iterator>::next::h1db5823436931f08.exit.i.i.i.i.i.i"
%16 = icmp eq i32 %15, 84
%.x.i.i.i.i.i.i.i.i = select i1 %16, i32 85, i32 %15
; invoke alloc::string::String::push
invoke fastcc void @_ZN5alloc6string6String4push17h0aadd5d81b44be8aE(%"alloc::string::String"
to label %.noexc9.i.i unwind label %cleanup1.loopexit.i.i

.noexc9.i.i:                                      ; preds = %bb3.i.i.i.i.i.i
%_12.i.i.i.i.i.i.i.i.i = icmp eq i8* %self.sroa.0.416.i.i.i.i.i.i, %2
br i1 %_12.i.i.i.i.i.i.i.i.i, label %_ZN4core4iter6traits8iterator8Iterator7collect17h8c399863fcfb1eefE.exit, label %bb3.i.i.i.i.i.i.i.i

cleanup1.loopexit.i.i:                            ; preds = %bb3.i.i.i.i.i.i
%lpad.loopexit.i.i = landingpad { i8*, i32 }
cleanup
br label %cleanup1.i.i

cleanup1.loopexit.split-lp.i.i:                   ; preds = %bb2.i.i.i.i.i.i
%lpad.loopexit.split-lp.i.i = landingpad { i8*, i32 }
cleanup
br label %cleanup1.i.i

cleanup1.i.i:                                     ; preds = %cleanup1.loopexit.split-lp.i.i, %cleanup1.loopexit.i.i
%lpad.phi.i.i = phi { i8*, i32 } [ %lpad.loopexit.i.i, %cleanup1.loopexit.i.i ], [ %lpad.loopexit.split-lp.i.i, %cleanup1.loopexit.split-lp.i.i ]
; call core::ptr::drop_in_place<alloc::string::String>
tail call fastcc void @"core::ptr::drop_in_place<alloc::string::String>"(%"alloc::string::String"
resume { i8*, i32 } %lpad.phi.i.i

_ZN4core4iter6traits8iterator8Iterator7collect17h8c399863fcfb1eefE.exit: ; preds = %"<core::str::iter::Chars as core::iter::traits::iterator::Iterator>::next::h1db5823436931f08.exit.i.i.i.i.i.i"
ret void
}
