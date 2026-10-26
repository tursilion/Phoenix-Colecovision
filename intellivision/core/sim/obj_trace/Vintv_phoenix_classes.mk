# Verilated -*- Makefile -*-
# DESCRIPTION: Verilator output: Make include file with class lists
#
# This file lists generated Verilated files, for including in higher level makefiles.
# See Vintv_phoenix.mk for the caller.

### Switches...
# C11 constructs required?  0/1 (always on now)
VM_C11 = 1
# Timing enabled?  0/1
VM_TIMING = 0
# Coverage output mode?  0/1 (from --coverage)
VM_COVERAGE = 0
# Parallel builds?  0/1 (from --output-split)
VM_PARALLEL_BUILDS = 1
# Tracing output mode?  0/1 (from --trace/--trace-fst)
VM_TRACE = 0
# Tracing output mode in VCD format?  0/1 (from --trace)
VM_TRACE_VCD = 0
# Tracing output mode in FST format?  0/1 (from --trace-fst)
VM_TRACE_FST = 0

### Object file lists...
# Generated module classes, fast-path, compile with highest optimization
VM_CLASSES_FAST += \
	Vintv_phoenix \
	Vintv_phoenix___024root__DepSet_h43368929__0 \
	Vintv_phoenix___024root__DepSet_heb99da30__0 \
	Vintv_phoenix___024root__DepSet_heb99da30__1 \
	Vintv_phoenix___024root__DepSet_heb99da30__2 \
	Vintv_phoenix___024root__DepSet_heb99da30__3 \
	Vintv_phoenix___024root__DepSet_heb99da30__4 \
	Vintv_phoenix___024root__DepSet_heb99da30__5 \
	Vintv_phoenix___024root__DepSet_heb99da30__6 \
	Vintv_phoenix___024root__DepSet_heb99da30__7 \
	Vintv_phoenix___024root__DepSet_heb99da30__8 \

# Generated module classes, non-fast-path, compile with low/medium optimization
VM_CLASSES_SLOW += \
	Vintv_phoenix__ConstPool_0 \
	Vintv_phoenix__ConstPool_1 \
	Vintv_phoenix___024root__Slow \
	Vintv_phoenix___024root__DepSet_h43368929__0__Slow \
	Vintv_phoenix___024root__DepSet_heb99da30__0__Slow \
	Vintv_phoenix___024root__DepSet_heb99da30__1__Slow \
	Vintv_phoenix___024root__DepSet_heb99da30__2__Slow \
	Vintv_phoenix___024root__DepSet_heb99da30__3__Slow \
	Vintv_phoenix___024root__DepSet_heb99da30__4__Slow \
	Vintv_phoenix___024root__DepSet_heb99da30__5__Slow \
	Vintv_phoenix___024root__DepSet_heb99da30__6__Slow \
	Vintv_phoenix___024root__DepSet_heb99da30__7__Slow \
	Vintv_phoenix___024root__DepSet_heb99da30__8__Slow \
	Vintv_phoenix___024root__DepSet_heb99da30__9__Slow \
	Vintv_phoenix___024root__DepSet_heb99da30__10__Slow \
	Vintv_phoenix___024root__DepSet_heb99da30__11__Slow \
	Vintv_phoenix___024root__DepSet_heb99da30__12__Slow \
	Vintv_phoenix___024root__DepSet_heb99da30__13__Slow \
	Vintv_phoenix___024root__DepSet_heb99da30__14__Slow \

# Generated support classes, fast-path, compile with highest optimization
VM_SUPPORT_FAST += \

# Generated support classes, non-fast-path, compile with low/medium optimization
VM_SUPPORT_SLOW += \
	Vintv_phoenix__Syms \

# Global classes, need linked once per executable, fast-path, compile with highest optimization
VM_GLOBAL_FAST += \
	verilated \
	verilated_threads \

# Global classes, need linked once per executable, non-fast-path, compile with low/medium optimization
VM_GLOBAL_SLOW += \


# Verilated -*- Makefile -*-
