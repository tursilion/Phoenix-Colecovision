// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vintv_phoenix.h for the primary calling header

#include "verilated.h"

#include "Vintv_phoenix__Syms.h"
#include "Vintv_phoenix__Syms.h"
#include "Vintv_phoenix___024root.h"

#ifdef VL_DEBUG
VL_ATTR_COLD void Vintv_phoenix___024root___dump_triggers__ico(Vintv_phoenix___024root* vlSelf);
#endif  // VL_DEBUG

void Vintv_phoenix___024root___eval_triggers__ico(Vintv_phoenix___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vintv_phoenix__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vintv_phoenix___024root___eval_triggers__ico\n"); );
    // Body
    vlSelf->__VicoTriggered.set(0U, (0U == vlSelf->__VicoIterCount));
#ifdef VL_DEBUG
    if (VL_UNLIKELY(vlSymsp->_vm_contextp__->debug())) {
        Vintv_phoenix___024root___dump_triggers__ico(vlSelf);
    }
#endif
}

#ifdef VL_DEBUG
VL_ATTR_COLD void Vintv_phoenix___024root___dump_triggers__act(Vintv_phoenix___024root* vlSelf);
#endif  // VL_DEBUG

void Vintv_phoenix___024root___eval_triggers__act(Vintv_phoenix___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vintv_phoenix__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vintv_phoenix___024root___eval_triggers__act\n"); );
    // Body
    vlSelf->__VactTriggered.set(0U, ((IData)(vlSelf->clk25) 
                                     & (~ (IData)(vlSelf->__Vtrigprevexpr___TOP__clk25__0))));
    vlSelf->__VactTriggered.set(1U, ((IData)(vlSelf->clk_i) 
                                     & (~ (IData)(vlSelf->__Vtrigprevexpr___TOP__clk_i__0))));
    vlSelf->__VactTriggered.set(2U, ((IData)(vlSelf->clk_g) 
                                     & (~ (IData)(vlSelf->__Vtrigprevexpr___TOP__clk_g__0))));
    vlSelf->__VactTriggered.set(3U, (((IData)(vlSelf->clk_g) 
                                      & (~ (IData)(vlSelf->__Vtrigprevexpr___TOP__clk_g__0))) 
                                     | ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___551_) 
                                        & (~ (IData)(vlSelf->__Vtrigprevexpr___TOP__intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___551___0)))));
    vlSelf->__VactTriggered.set(4U, (((IData)(vlSelf->clk_g) 
                                      & (~ (IData)(vlSelf->__Vtrigprevexpr___TOP__clk_g__0))) 
                                     | ((IData)(vlSelf->intv_phoenix__DOT____Vcellinp__boot_cpu__reset) 
                                        & (~ (IData)(vlSelf->__Vtrigprevexpr___TOP__intv_phoenix__DOT____Vcellinp__boot_cpu__reset__0)))));
    vlSelf->__Vtrigprevexpr___TOP__clk25__0 = vlSelf->clk25;
    vlSelf->__Vtrigprevexpr___TOP__clk_i__0 = vlSelf->clk_i;
    vlSelf->__Vtrigprevexpr___TOP__clk_g__0 = vlSelf->clk_g;
    vlSelf->__Vtrigprevexpr___TOP__intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___551___0 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___551_;
    vlSelf->__Vtrigprevexpr___TOP__intv_phoenix__DOT____Vcellinp__boot_cpu__reset__0 
        = vlSelf->intv_phoenix__DOT____Vcellinp__boot_cpu__reset;
#ifdef VL_DEBUG
    if (VL_UNLIKELY(vlSymsp->_vm_contextp__->debug())) {
        Vintv_phoenix___024root___dump_triggers__act(vlSelf);
    }
#endif
}
