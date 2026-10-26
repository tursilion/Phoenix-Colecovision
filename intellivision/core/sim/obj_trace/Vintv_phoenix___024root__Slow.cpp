// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vintv_phoenix.h for the primary calling header

#include "verilated.h"

#include "Vintv_phoenix__Syms.h"
#include "Vintv_phoenix__Syms.h"
#include "Vintv_phoenix___024root.h"

void Vintv_phoenix___024root___ctor_var_reset(Vintv_phoenix___024root* vlSelf);

Vintv_phoenix___024root::Vintv_phoenix___024root(Vintv_phoenix__Syms* symsp, const char* v__name)
    : VerilatedModule{v__name}
    , vlSymsp{symsp}
 {
    // Reset structure values
    Vintv_phoenix___024root___ctor_var_reset(this);
}

void Vintv_phoenix___024root::__Vconfigure(bool first) {
    if (false && first) {}  // Prevent unused
}

Vintv_phoenix___024root::~Vintv_phoenix___024root() {
}
