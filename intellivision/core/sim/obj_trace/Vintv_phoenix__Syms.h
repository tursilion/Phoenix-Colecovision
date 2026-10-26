// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Symbol table internal header
//
// Internal details; most calling programs do not need this header,
// unless using verilator public meta comments.

#ifndef VERILATED_VINTV_PHOENIX__SYMS_H_
#define VERILATED_VINTV_PHOENIX__SYMS_H_  // guard

#include "verilated.h"

// INCLUDE MODEL CLASS

#include "Vintv_phoenix.h"

// INCLUDE MODULE CLASSES
#include "Vintv_phoenix___024root.h"

// SYMS CLASS (contains all model state)
class alignas(VL_CACHE_LINE_BYTES)Vintv_phoenix__Syms final : public VerilatedSyms {
  public:
    // INTERNAL STATE
    Vintv_phoenix* const __Vm_modelp;
    VlDeleter __Vm_deleter;
    bool __Vm_didInit = false;

    // MODULE INSTANCE STATE
    Vintv_phoenix___024root        TOP;

    // CONSTRUCTORS
    Vintv_phoenix__Syms(VerilatedContext* contextp, const char* namep, Vintv_phoenix* modelp);
    ~Vintv_phoenix__Syms();

    // METHODS
    const char* name() { return TOP.name(); }
};

#endif  // guard
