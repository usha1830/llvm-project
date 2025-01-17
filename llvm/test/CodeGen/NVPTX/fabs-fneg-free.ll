; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 5
; RUN: llc < %s -mtriple=nvptx64 -mcpu=sm_35 -verify-machineinstrs | FileCheck %s
; RUN: %if ptxas %{ llc < %s -mtriple=nvptx64 -mcpu=sm_35 | %ptxas-verify %}
target triple = "nvptx64-nvidia-cuda"

define float @fabs_free(i32 %in) {
; CHECK-LABEL: fabs_free(
; CHECK:       {
; CHECK-NEXT:    .reg .f32 %f<3>;
; CHECK-EMPTY:
; CHECK-NEXT:  // %bb.0:
; CHECK-NEXT:    ld.param.f32 %f1, [fabs_free_param_0];
; CHECK-NEXT:    abs.f32 %f2, %f1;
; CHECK-NEXT:    st.param.f32 [func_retval0], %f2;
; CHECK-NEXT:    ret;
  %b = bitcast i32 %in to float
  %f = call float @llvm.fabs.f32(float %b)
  ret float %f
}

define float @fneg_free(i32 %in) {
; CHECK-LABEL: fneg_free(
; CHECK:       {
; CHECK-NEXT:    .reg .f32 %f<3>;
; CHECK-EMPTY:
; CHECK-NEXT:  // %bb.0:
; CHECK-NEXT:    ld.param.f32 %f1, [fneg_free_param_0];
; CHECK-NEXT:    neg.f32 %f2, %f1;
; CHECK-NEXT:    st.param.f32 [func_retval0], %f2;
; CHECK-NEXT:    ret;
  %b = bitcast i32 %in to float
  %f = fneg float %b
  ret float %f
}
