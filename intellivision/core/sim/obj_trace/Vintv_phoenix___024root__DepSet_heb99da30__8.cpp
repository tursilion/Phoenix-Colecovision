// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vintv_phoenix.h for the primary calling header

#include "verilated.h"

#include "Vintv_phoenix__Syms.h"
#include "Vintv_phoenix___024root.h"

VL_INLINE_OPT void Vintv_phoenix___024root___nba_comb__TOP__5(Vintv_phoenix___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vintv_phoenix__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vintv_phoenix___024root___nba_comb__TOP__5\n"); );
    // Init
    CData/*7:0*/ intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0429_;
    intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0429_ = 0;
    CData/*0:0*/ intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0436_;
    intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0436_ = 0;
    CData/*7:0*/ intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0647_;
    intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0647_ = 0;
    CData/*0:0*/ intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0657_;
    intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0657_ = 0;
    CData/*7:0*/ __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__Vfuncout;
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__Vfuncout = 0;
    QData/*47:0*/ __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__b;
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__b = 0;
    CData/*5:0*/ __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__s;
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__s = 0;
    CData/*0:0*/ __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__Vfuncout;
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__Vfuncout = 0;
    CData/*5:0*/ __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__b;
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__b = 0;
    CData/*5:0*/ __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__s;
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__s = 0;
    CData/*7:0*/ __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314636__146__Vfuncout;
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314636__146__Vfuncout = 0;
    VlWide<6>/*175:0*/ __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314636__146__b;
    VL_ZERO_W(176, __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314636__146__b);
    IData/*21:0*/ __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314636__146__s;
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314636__146__s = 0;
    CData/*0:0*/ __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314658__156__Vfuncout;
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314658__156__Vfuncout = 0;
    IData/*21:0*/ __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314658__156__b;
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314658__156__b = 0;
    IData/*21:0*/ __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314658__156__s;
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314658__156__s = 0;
    VlWide<3>/*95:0*/ __Vtemp_1;
    VlWide<3>/*95:0*/ __Vtemp_6;
    VlWide<3>/*95:0*/ __Vtemp_11;
    VlWide<6>/*191:0*/ __Vtemp_21;
    // Body
    if (vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___551_) {
        vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0321_ = 0U;
        vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0314_ = 0ULL;
        vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0721_ 
            = vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0722_;
    } else {
        vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0321_ 
            = (0xfU & (VL_GTS_III(32, 8U, (0x3fffU 
                                           & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2991_)))
                        ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3011_)
                        : (VL_GTS_III(32, 0x10U, (0x3fffU 
                                                  & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2991_)))
                            ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3011_)
                            : (VL_GTS_III(32, 0x18U, 
                                          (0x3fffU 
                                           & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2991_)))
                                ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3011_)
                                : (VL_GTS_III(32, 0x20U, 
                                              (0x3fffU 
                                               & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2991_)))
                                    ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3011_)
                                    : ((0x20U == (0x3fffU 
                                                  & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2991_)))
                                        ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3011_)
                                        : ((0x21U == 
                                            (0x3fffU 
                                             & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2991_)))
                                            ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3011_)
                                            : ((0x28U 
                                                == 
                                                (0x3fffU 
                                                 & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2991_)))
                                                ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3011_)
                                                : (
                                                   (0x29U 
                                                    == 
                                                    (0x3fffU 
                                                     & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2991_)))
                                                    ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3011_)
                                                    : 
                                                   ((0x2aU 
                                                     == 
                                                     (0x3fffU 
                                                      & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2991_)))
                                                     ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3011_)
                                                     : 
                                                    ((0x2bU 
                                                      == 
                                                      (0x3fffU 
                                                       & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2991_)))
                                                      ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3011_)
                                                      : 
                                                     (((0x2cU 
                                                        == 
                                                        (0x3fffU 
                                                         & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2991_))) 
                                                       & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3350_))
                                                       ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___549_)
                                                       : (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3011_)))))))))))));
        vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0314_ 
            = (((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2989_) 
                & (((0xfU & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___549_) 
                             >> 0xcU)) == (0xfU & VL_DIVS_III(32, (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2991_), (IData)(0x1000U)))) 
                   & (IData)(((0xa50U == (0xff0U & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___549_))) 
                              & (0xfffU == (0xfffU 
                                            & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2991_)))))))
                ? (((QData)((IData)((0xfU & (((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3120_) 
                                              & ((IData)(1U) 
                                                 - 
                                                 VL_DIVS_III(32, (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2991_), (IData)(0x1000U))))
                                              ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___549_)
                                              : (IData)(
                                                        (vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2975_ 
                                                         >> 0x3cU)))))) 
                    << 0x3cU) | (((QData)((IData)((0xfU 
                                                   & (((~ 
                                                        ((IData)(1U) 
                                                         - 
                                                         VL_DIVS_III(32, (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2991_), (IData)(0x1000U)))) 
                                                       & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3120_))
                                                       ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___549_)
                                                       : (IData)(
                                                                 (vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2975_ 
                                                                  >> 0x38U)))))) 
                                  << 0x38U) | (((QData)((IData)(
                                                                (0xfU 
                                                                 & (((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3119_) 
                                                                     & ((IData)(1U) 
                                                                        - 
                                                                        VL_DIVS_III(32, (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2991_), (IData)(0x1000U))))
                                                                     ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___549_)
                                                                     : (IData)(
                                                                               (vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2975_ 
                                                                                >> 0x34U)))))) 
                                                << 0x34U) 
                                               | (((QData)((IData)(
                                                                   (0xfU 
                                                                    & (((~ 
                                                                         ((IData)(1U) 
                                                                          - 
                                                                          VL_DIVS_III(32, (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2991_), (IData)(0x1000U)))) 
                                                                        & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3119_))
                                                                        ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___549_)
                                                                        : (IData)(
                                                                                (vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2975_ 
                                                                                >> 0x30U)))))) 
                                                   << 0x30U) 
                                                  | (((QData)((IData)(
                                                                      (0xfU 
                                                                       & (((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3118_) 
                                                                           & ((IData)(1U) 
                                                                              - 
                                                                              VL_DIVS_III(32, (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2991_), (IData)(0x1000U))))
                                                                           ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___549_)
                                                                           : (IData)(
                                                                                (vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2975_ 
                                                                                >> 0x2cU)))))) 
                                                      << 0x2cU) 
                                                     | (((QData)((IData)(
                                                                         (0xfU 
                                                                          & (((~ 
                                                                               ((IData)(1U) 
                                                                                - 
                                                                                VL_DIVS_III(32, (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2991_), (IData)(0x1000U)))) 
                                                                              & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3118_))
                                                                              ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___549_)
                                                                              : (IData)(
                                                                                (vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2975_ 
                                                                                >> 0x28U)))))) 
                                                         << 0x28U) 
                                                        | (((QData)((IData)(
                                                                            (0xfU 
                                                                             & (((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3117_) 
                                                                                & ((IData)(1U) 
                                                                                - 
                                                                                VL_DIVS_III(32, (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2991_), (IData)(0x1000U))))
                                                                                 ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___549_)
                                                                                 : (IData)(
                                                                                (vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2975_ 
                                                                                >> 0x24U)))))) 
                                                            << 0x24U) 
                                                           | (((QData)((IData)(
                                                                               (0xfU 
                                                                                & (((~ 
                                                                                ((IData)(1U) 
                                                                                - 
                                                                                VL_DIVS_III(32, (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2991_), (IData)(0x1000U)))) 
                                                                                & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3117_))
                                                                                 ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___549_)
                                                                                 : (IData)(
                                                                                (vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2975_ 
                                                                                >> 0x20U)))))) 
                                                               << 0x20U) 
                                                              | (QData)((IData)(
                                                                                (((((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3116_) 
                                                                                & ((IData)(1U) 
                                                                                - 
                                                                                VL_DIVS_III(32, (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2991_), (IData)(0x1000U))))
                                                                                 ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___549_)
                                                                                 : (IData)(
                                                                                (vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2975_ 
                                                                                >> 0x1cU))) 
                                                                                << 0x1cU) 
                                                                                | ((0xf000000U 
                                                                                & ((((~ 
                                                                                ((IData)(1U) 
                                                                                - 
                                                                                VL_DIVS_III(32, (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2991_), (IData)(0x1000U)))) 
                                                                                & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3116_))
                                                                                 ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___549_)
                                                                                 : (IData)(
                                                                                (vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2975_ 
                                                                                >> 0x18U))) 
                                                                                << 0x18U)) 
                                                                                | ((0xf00000U 
                                                                                & ((((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3115_) 
                                                                                & ((IData)(1U) 
                                                                                - 
                                                                                VL_DIVS_III(32, (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2991_), (IData)(0x1000U))))
                                                                                 ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___549_)
                                                                                 : (IData)(
                                                                                (vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2975_ 
                                                                                >> 0x14U))) 
                                                                                << 0x14U)) 
                                                                                | ((0xf0000U 
                                                                                & ((((~ 
                                                                                ((IData)(1U) 
                                                                                - 
                                                                                VL_DIVS_III(32, (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2991_), (IData)(0x1000U)))) 
                                                                                & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3115_))
                                                                                 ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___549_)
                                                                                 : (IData)(
                                                                                (vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2975_ 
                                                                                >> 0x10U))) 
                                                                                << 0x10U)) 
                                                                                | ((0xf000U 
                                                                                & ((((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3114_) 
                                                                                & ((IData)(1U) 
                                                                                - 
                                                                                VL_DIVS_III(32, (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2991_), (IData)(0x1000U))))
                                                                                 ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___549_)
                                                                                 : (IData)(
                                                                                (vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2975_ 
                                                                                >> 0xcU))) 
                                                                                << 0xcU)) 
                                                                                | ((0xf00U 
                                                                                & ((((~ 
                                                                                ((IData)(1U) 
                                                                                - 
                                                                                VL_DIVS_III(32, (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2991_), (IData)(0x1000U)))) 
                                                                                & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3114_))
                                                                                 ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___549_)
                                                                                 : (IData)(
                                                                                (vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2975_ 
                                                                                >> 8U))) 
                                                                                << 8U)) 
                                                                                | ((0xf0U 
                                                                                & ((((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3113_) 
                                                                                & ((IData)(1U) 
                                                                                - 
                                                                                VL_DIVS_III(32, (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2991_), (IData)(0x1000U))))
                                                                                 ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___549_)
                                                                                 : (IData)(
                                                                                (vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2975_ 
                                                                                >> 4U))) 
                                                                                << 4U)) 
                                                                                | (0xfU 
                                                                                & (((~ 
                                                                                ((IData)(1U) 
                                                                                - 
                                                                                VL_DIVS_III(32, (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2991_), (IData)(0x1000U)))) 
                                                                                & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3113_))
                                                                                 ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___549_)
                                                                                 : (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2975_))))))))))))))))))))
                : vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2975_);
        vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0721_ 
            = ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT___70_) 
               & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0687_) 
                  | ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0659_)
                      ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0617_)
                      : ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0882_)
                          ? (VL_LTES_III(32, 0xaU, vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0676_) 
                             | (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0617_))
                          : (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0617_)))));
    }
    vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0319_ 
        = (1U & ((~ (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___551_)) 
                 & (VL_GTS_III(32, 8U, (0x3fffU & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2991_)))
                     ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3009_)
                     : (VL_GTS_III(32, 0x10U, (0x3fffU 
                                               & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2991_)))
                         ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3009_)
                         : (VL_GTS_III(32, 0x18U, (0x3fffU 
                                                   & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2991_)))
                             ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3009_)
                             : (VL_GTS_III(32, 0x20U, 
                                           (0x3fffU 
                                            & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2991_)))
                                 ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3009_)
                                 : ((0x20U == (0x3fffU 
                                               & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2991_)))
                                     ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3009_)
                                     : ((0x21U == (0x3fffU 
                                                   & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2991_)))
                                         ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3009_)
                                         : ((0x28U 
                                             == (0x3fffU 
                                                 & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2991_)))
                                             ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3009_)
                                             : ((0x29U 
                                                 == 
                                                 (0x3fffU 
                                                  & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2991_)))
                                                 ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3009_)
                                                 : 
                                                ((0x2aU 
                                                  == 
                                                  (0x3fffU 
                                                   & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2991_)))
                                                  ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3009_)
                                                  : 
                                                 ((0x2bU 
                                                   == 
                                                   (0x3fffU 
                                                    & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2991_)))
                                                   ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3009_)
                                                   : 
                                                  ((0x2cU 
                                                    == 
                                                    (0x3fffU 
                                                     & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2991_)))
                                                    ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3009_)
                                                    : 
                                                   ((0x30U 
                                                     == 
                                                     (0x3fffU 
                                                      & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2991_)))
                                                     ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3009_)
                                                     : 
                                                    ((0x31U 
                                                      == 
                                                      (0x3fffU 
                                                       & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2991_)))
                                                      ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3009_)
                                                      : 
                                                     ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0047_)
                                                       ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___549_)
                                                       : (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3009_)))))))))))))))));
    vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0320_ 
        = (1U & ((~ (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___551_)) 
                 & (VL_GTS_III(32, 8U, (0x3fffU & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2991_)))
                     ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3010_)
                     : (VL_GTS_III(32, 0x10U, (0x3fffU 
                                               & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2991_)))
                         ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3010_)
                         : (VL_GTS_III(32, 0x18U, (0x3fffU 
                                                   & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2991_)))
                             ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3010_)
                             : (VL_GTS_III(32, 0x20U, 
                                           (0x3fffU 
                                            & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2991_)))
                                 ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3010_)
                                 : ((0x20U == (0x3fffU 
                                               & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2991_)))
                                     ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3010_)
                                     : ((0x21U == (0x3fffU 
                                                   & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2991_)))
                                         ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3010_)
                                         : ((0x28U 
                                             == (0x3fffU 
                                                 & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2991_)))
                                             ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3010_)
                                             : ((0x29U 
                                                 == 
                                                 (0x3fffU 
                                                  & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2991_)))
                                                 ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3010_)
                                                 : 
                                                ((0x2aU 
                                                  == 
                                                  (0x3fffU 
                                                   & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2991_)))
                                                  ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3010_)
                                                  : 
                                                 ((0x2bU 
                                                   == 
                                                   (0x3fffU 
                                                    & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2991_)))
                                                   ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3010_)
                                                   : 
                                                  ((0x2cU 
                                                    == 
                                                    (0x3fffU 
                                                     & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2991_)))
                                                    ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3010_)
                                                    : 
                                                   ((0x30U 
                                                     == 
                                                     (0x3fffU 
                                                      & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2991_)))
                                                     ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3010_)
                                                     : 
                                                    ((0x31U 
                                                      == 
                                                      (0x3fffU 
                                                       & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2991_)))
                                                      ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3010_)
                                                      : 
                                                     ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0047_)
                                                       ? 
                                                      ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___549_) 
                                                       >> 1U)
                                                       : (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3010_)))))))))))))))));
    __Vtemp_1[1U] = ((((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3246_)
                        ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___549_)
                        : ((vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3026_[2U] 
                            << 8U) | (vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3026_[1U] 
                                      >> 0x18U))) << 0x18U) 
                     | (IData)(((((QData)((IData)((0x3fffU 
                                                   & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3245_)
                                                       ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___549_)
                                                       : 
                                                      ((vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3026_[1U] 
                                                        << 0x16U) 
                                                       | (vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3026_[1U] 
                                                          >> 0xaU)))))) 
                                  << 0x2aU) | (((QData)((IData)(
                                                                (0x3fffU 
                                                                 & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3244_)
                                                                     ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___549_)
                                                                     : 
                                                                    ((vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3026_[1U] 
                                                                      << 4U) 
                                                                     | (vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3026_[0U] 
                                                                        >> 0x1cU)))))) 
                                                << 0x1cU) 
                                               | (QData)((IData)(
                                                                 ((0xfffc000U 
                                                                   & (((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3243_)
                                                                        ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___549_)
                                                                        : 
                                                                       ((vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3026_[0U] 
                                                                         << 0x12U) 
                                                                        | (vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3026_[0U] 
                                                                           >> 0xeU))) 
                                                                      << 0xeU)) 
                                                                  | (0x3fffU 
                                                                     & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3242_)
                                                                         ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___549_)
                                                                         : 
                                                                        vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3026_[0U]))))))) 
                                >> 0x20U)));
    if (vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2967_) {
        vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3025_[0U] 
            = (IData)((((QData)((IData)((0x3fffU & 
                                         ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3245_)
                                           ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___549_)
                                           : ((vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3026_[1U] 
                                               << 0x16U) 
                                              | (vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3026_[1U] 
                                                 >> 0xaU)))))) 
                        << 0x2aU) | (((QData)((IData)(
                                                      (0x3fffU 
                                                       & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3244_)
                                                           ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___549_)
                                                           : 
                                                          ((vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3026_[1U] 
                                                            << 4U) 
                                                           | (vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3026_[0U] 
                                                              >> 0x1cU)))))) 
                                      << 0x1cU) | (QData)((IData)(
                                                                  ((0xfffc000U 
                                                                    & (((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3243_)
                                                                         ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___549_)
                                                                         : 
                                                                        ((vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3026_[0U] 
                                                                          << 0x12U) 
                                                                         | (vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3026_[0U] 
                                                                            >> 0xeU))) 
                                                                       << 0xeU)) 
                                                                   | (0x3fffU 
                                                                      & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3242_)
                                                                          ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___549_)
                                                                          : 
                                                                         vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3026_[0U]))))))));
        vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3025_[1U] 
            = __Vtemp_1[1U];
        vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3025_[2U] 
            = ((((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3248_)
                  ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___549_)
                  : ((vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3026_[3U] 
                      << 0xcU) | (vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3026_[2U] 
                                  >> 0x14U))) << 0x14U) 
               | ((0xfffc0U & (((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3247_)
                                 ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___549_)
                                 : ((vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3026_[2U] 
                                     << 0x1aU) | (vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3026_[2U] 
                                                  >> 6U))) 
                               << 6U)) | (0x3fU & (
                                                   ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3246_)
                                                     ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___549_)
                                                     : 
                                                    ((vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3026_[2U] 
                                                      << 8U) 
                                                     | (vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3026_[1U] 
                                                        >> 0x18U))) 
                                                   >> 8U))));
        vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3025_[3U] 
            = ((0xfffcU & (((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3249_)
                             ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___549_)
                             : ((vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3026_[3U] 
                                 << 0x1eU) | (vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3026_[3U] 
                                              >> 2U))) 
                           << 2U)) | (3U & (((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3248_)
                                              ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___549_)
                                              : ((vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3026_[3U] 
                                                  << 0xcU) 
                                                 | (vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3026_[2U] 
                                                    >> 0x14U))) 
                                            >> 0xcU)));
    } else {
        vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3025_[0U] 
            = vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3026_[0U];
        vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3025_[1U] 
            = vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3026_[1U];
        vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3025_[2U] 
            = vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3026_[2U];
        vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3025_[3U] 
            = vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3026_[3U];
    }
    __Vtemp_6[1U] = ((((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3246_)
                        ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___549_)
                        : ((vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3028_[2U] 
                            << 8U) | (vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3028_[1U] 
                                      >> 0x18U))) << 0x18U) 
                     | (IData)(((((QData)((IData)((0x3fffU 
                                                   & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3245_)
                                                       ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___549_)
                                                       : 
                                                      ((vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3028_[1U] 
                                                        << 0x16U) 
                                                       | (vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3028_[1U] 
                                                          >> 0xaU)))))) 
                                  << 0x2aU) | (((QData)((IData)(
                                                                (0x3fffU 
                                                                 & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3244_)
                                                                     ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___549_)
                                                                     : 
                                                                    ((vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3028_[1U] 
                                                                      << 4U) 
                                                                     | (vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3028_[0U] 
                                                                        >> 0x1cU)))))) 
                                                << 0x1cU) 
                                               | (QData)((IData)(
                                                                 ((0xfffc000U 
                                                                   & (((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3243_)
                                                                        ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___549_)
                                                                        : 
                                                                       ((vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3028_[0U] 
                                                                         << 0x12U) 
                                                                        | (vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3028_[0U] 
                                                                           >> 0xeU))) 
                                                                      << 0xeU)) 
                                                                  | (0x3fffU 
                                                                     & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3242_)
                                                                         ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___549_)
                                                                         : 
                                                                        vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3028_[0U]))))))) 
                                >> 0x20U)));
    if (vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2968_) {
        vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3027_[0U] 
            = (IData)((((QData)((IData)((0x3fffU & 
                                         ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3245_)
                                           ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___549_)
                                           : ((vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3028_[1U] 
                                               << 0x16U) 
                                              | (vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3028_[1U] 
                                                 >> 0xaU)))))) 
                        << 0x2aU) | (((QData)((IData)(
                                                      (0x3fffU 
                                                       & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3244_)
                                                           ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___549_)
                                                           : 
                                                          ((vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3028_[1U] 
                                                            << 4U) 
                                                           | (vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3028_[0U] 
                                                              >> 0x1cU)))))) 
                                      << 0x1cU) | (QData)((IData)(
                                                                  ((0xfffc000U 
                                                                    & (((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3243_)
                                                                         ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___549_)
                                                                         : 
                                                                        ((vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3028_[0U] 
                                                                          << 0x12U) 
                                                                         | (vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3028_[0U] 
                                                                            >> 0xeU))) 
                                                                       << 0xeU)) 
                                                                   | (0x3fffU 
                                                                      & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3242_)
                                                                          ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___549_)
                                                                          : 
                                                                         vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3028_[0U]))))))));
        vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3027_[1U] 
            = __Vtemp_6[1U];
        vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3027_[2U] 
            = ((((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3248_)
                  ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___549_)
                  : ((vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3028_[3U] 
                      << 0xcU) | (vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3028_[2U] 
                                  >> 0x14U))) << 0x14U) 
               | ((0xfffc0U & (((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3247_)
                                 ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___549_)
                                 : ((vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3028_[2U] 
                                     << 0x1aU) | (vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3028_[2U] 
                                                  >> 6U))) 
                               << 6U)) | (0x3fU & (
                                                   ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3246_)
                                                     ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___549_)
                                                     : 
                                                    ((vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3028_[2U] 
                                                      << 8U) 
                                                     | (vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3028_[1U] 
                                                        >> 0x18U))) 
                                                   >> 8U))));
        vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3027_[3U] 
            = ((0xfffcU & (((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3249_)
                             ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___549_)
                             : ((vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3028_[3U] 
                                 << 0x1eU) | (vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3028_[3U] 
                                              >> 2U))) 
                           << 2U)) | (3U & (((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3248_)
                                              ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___549_)
                                              : ((vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3028_[3U] 
                                                  << 0xcU) 
                                                 | (vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3028_[2U] 
                                                    >> 0x14U))) 
                                            >> 0xcU)));
    } else {
        vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3027_[0U] 
            = vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3028_[0U];
        vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3027_[1U] 
            = vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3028_[1U];
        vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3027_[2U] 
            = vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3028_[2U];
        vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3027_[3U] 
            = vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3028_[3U];
    }
    __Vtemp_11[1U] = ((((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3246_)
                         ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___549_)
                         : ((vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3030_[2U] 
                             << 8U) | (vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3030_[1U] 
                                       >> 0x18U))) 
                       << 0x18U) | (IData)(((((QData)((IData)(
                                                              (0x3fffU 
                                                               & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3245_)
                                                                   ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___549_)
                                                                   : 
                                                                  ((vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3030_[1U] 
                                                                    << 0x16U) 
                                                                   | (vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3030_[1U] 
                                                                      >> 0xaU)))))) 
                                              << 0x2aU) 
                                             | (((QData)((IData)(
                                                                 (0x3fffU 
                                                                  & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3244_)
                                                                      ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___549_)
                                                                      : 
                                                                     ((vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3030_[1U] 
                                                                       << 4U) 
                                                                      | (vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3030_[0U] 
                                                                         >> 0x1cU)))))) 
                                                 << 0x1cU) 
                                                | (QData)((IData)(
                                                                  ((0xfffc000U 
                                                                    & (((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3243_)
                                                                         ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___549_)
                                                                         : 
                                                                        ((vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3030_[0U] 
                                                                          << 0x12U) 
                                                                         | (vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3030_[0U] 
                                                                            >> 0xeU))) 
                                                                       << 0xeU)) 
                                                                   | (0x3fffU 
                                                                      & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3242_)
                                                                          ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___549_)
                                                                          : 
                                                                         vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3030_[0U]))))))) 
                                            >> 0x20U)));
    if (vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2969_) {
        vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3029_[0U] 
            = (IData)((((QData)((IData)((0x3fffU & 
                                         ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3245_)
                                           ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___549_)
                                           : ((vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3030_[1U] 
                                               << 0x16U) 
                                              | (vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3030_[1U] 
                                                 >> 0xaU)))))) 
                        << 0x2aU) | (((QData)((IData)(
                                                      (0x3fffU 
                                                       & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3244_)
                                                           ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___549_)
                                                           : 
                                                          ((vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3030_[1U] 
                                                            << 4U) 
                                                           | (vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3030_[0U] 
                                                              >> 0x1cU)))))) 
                                      << 0x1cU) | (QData)((IData)(
                                                                  ((0xfffc000U 
                                                                    & (((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3243_)
                                                                         ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___549_)
                                                                         : 
                                                                        ((vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3030_[0U] 
                                                                          << 0x12U) 
                                                                         | (vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3030_[0U] 
                                                                            >> 0xeU))) 
                                                                       << 0xeU)) 
                                                                   | (0x3fffU 
                                                                      & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3242_)
                                                                          ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___549_)
                                                                          : 
                                                                         vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3030_[0U]))))))));
        vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3029_[1U] 
            = __Vtemp_11[1U];
        vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3029_[2U] 
            = ((((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3248_)
                  ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___549_)
                  : ((vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3030_[3U] 
                      << 0xcU) | (vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3030_[2U] 
                                  >> 0x14U))) << 0x14U) 
               | ((0xfffc0U & (((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3247_)
                                 ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___549_)
                                 : ((vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3030_[2U] 
                                     << 0x1aU) | (vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3030_[2U] 
                                                  >> 6U))) 
                               << 6U)) | (0x3fU & (
                                                   ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3246_)
                                                     ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___549_)
                                                     : 
                                                    ((vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3030_[2U] 
                                                      << 8U) 
                                                     | (vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3030_[1U] 
                                                        >> 0x18U))) 
                                                   >> 8U))));
        vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3029_[3U] 
            = ((0xfffcU & (((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3249_)
                             ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___549_)
                             : ((vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3030_[3U] 
                                 << 0x1eU) | (vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3030_[3U] 
                                              >> 2U))) 
                           << 2U)) | (3U & (((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3248_)
                                              ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___549_)
                                              : ((vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3030_[3U] 
                                                  << 0xcU) 
                                                 | (vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3030_[2U] 
                                                    >> 0x14U))) 
                                            >> 0xcU)));
    } else {
        vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3029_[0U] 
            = vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3030_[0U];
        vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3029_[1U] 
            = vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3030_[1U];
        vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3029_[2U] 
            = vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3030_[2U];
        vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3029_[3U] 
            = vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3030_[3U];
    }
    vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3250_ 
        = (0x3fffU & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3242_)
                       ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___549_)
                       : ((0x3c00U & vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3031_[0U]) 
                          | (((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0364_) 
                              << 9U) | (((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0363_) 
                                         << 8U) | (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0362_))))));
    vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3256_ 
        = (0x3fffU & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3248_)
                       ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___549_)
                       : ((0x3c00U & ((vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3031_[3U] 
                                       << 0xcU) | (0xc00U 
                                                   & (vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3031_[2U] 
                                                      >> 0x14U)))) 
                          | (((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0346_) 
                              << 9U) | (((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0345_) 
                                         << 8U) | (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0344_))))));
    vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3251_ 
        = (0x3fffU & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3243_)
                       ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___549_)
                       : ((0x3c00U & (vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3031_[0U] 
                                      >> 0xeU)) | (
                                                   ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0361_) 
                                                    << 9U) 
                                                   | (((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0360_) 
                                                       << 8U) 
                                                      | (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0359_))))));
    vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3255_ 
        = (0x3fffU & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3247_)
                       ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___549_)
                       : ((0x3c00U & (vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3031_[2U] 
                                      >> 6U)) | (((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0349_) 
                                                  << 9U) 
                                                 | (((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0348_) 
                                                     << 8U) 
                                                    | (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0347_))))));
    vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3254_ 
        = (0x3fffU & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3246_)
                       ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___549_)
                       : ((0x3c00U & (vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3031_[2U] 
                                      << 8U)) | (((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0352_) 
                                                  << 9U) 
                                                 | (((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0351_) 
                                                     << 8U) 
                                                    | (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0350_))))));
    vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3253_ 
        = (0x3fffU & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3245_)
                       ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___549_)
                       : ((0x3c00U & (vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3031_[1U] 
                                      >> 0xaU)) | (
                                                   ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0355_) 
                                                    << 9U) 
                                                   | (((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0354_) 
                                                       << 8U) 
                                                      | (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0353_))))));
    vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3252_ 
        = (0x3fffU & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3244_)
                       ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___549_)
                       : ((0x3c00U & (vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3031_[1U] 
                                      << 4U)) | (((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0358_) 
                                                  << 9U) 
                                                 | (((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0357_) 
                                                     << 8U) 
                                                    | (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0356_))))));
    if (vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2970_) {
        vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0369_ 
            = (0x1fffU & (0x1fffU & (((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3249_)
                                       ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___549_)
                                       : ((0x3c00U 
                                           & (vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3031_[3U] 
                                              >> 2U)) 
                                          | (((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0343_) 
                                              << 9U) 
                                             | (((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0342_) 
                                                 << 8U) 
                                                | (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0341_))))) 
                                     >> 1U)));
        vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0370_ 
            = (0xfffU & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3256_) 
                         >> 2U));
        vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0376_ 
            = ((0xfc0U & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3251_) 
                          << 6U)) | (0x3fU & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3250_) 
                                              >> 8U)));
        vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0371_ 
            = ((0x800U & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3256_) 
                          << 0xbU)) | (0x7ffU & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3255_) 
                                                 >> 3U)));
        vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0372_ 
            = ((0xc00U & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3255_) 
                          << 0xaU)) | (0x3ffU & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3254_) 
                                                 >> 4U)));
        vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0373_ 
            = ((0xe00U & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3254_) 
                          << 9U)) | (0x1ffU & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3253_) 
                                               >> 5U)));
        vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0374_ 
            = ((0xf00U & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3253_) 
                          << 8U)) | (0xffU & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3252_) 
                                              >> 6U)));
        vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0375_ 
            = ((0xf80U & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3252_) 
                          << 7U)) | (0x7fU & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3251_) 
                                              >> 7U)));
    } else {
        vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0369_ 
            = (0x1fffU & ((0x1e00U & (vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3031_[3U] 
                                      >> 3U)) | (((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0343_) 
                                                  << 8U) 
                                                 | (((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0342_) 
                                                     << 7U) 
                                                    | (0x7fU 
                                                       & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0341_) 
                                                          >> 1U))))));
        vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0370_ 
            = (0xfffU & ((0xf00U & ((vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3031_[3U] 
                                     << 0xaU) | (0x300U 
                                                 & (vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3031_[2U] 
                                                    >> 0x16U)))) 
                         | (((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0346_) 
                             << 7U) | (((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0345_) 
                                        << 6U) | (0x3fU 
                                                  & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0344_) 
                                                     >> 2U))))));
        vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0376_ 
            = ((0xfc0U & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0359_) 
                          << 6U)) | ((0x3cU & (vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3031_[0U] 
                                               >> 8U)) 
                                     | (((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0364_) 
                                         << 1U) | (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0363_))));
        vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0371_ 
            = ((0x800U & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0344_) 
                          << 0xbU)) | ((0x780U & (vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3031_[2U] 
                                                  >> 9U)) 
                                       | (((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0349_) 
                                           << 6U) | 
                                          (((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0348_) 
                                            << 5U) 
                                           | (0x1fU 
                                              & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0347_) 
                                                 >> 3U))))));
        vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0372_ 
            = ((0xc00U & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0347_) 
                          << 0xaU)) | ((0x3c0U & (vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3031_[2U] 
                                                  << 4U)) 
                                       | (((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0352_) 
                                           << 5U) | 
                                          (((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0351_) 
                                            << 4U) 
                                           | (0xfU 
                                              & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0350_) 
                                                 >> 4U))))));
        vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0373_ 
            = ((0xe00U & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0350_) 
                          << 9U)) | ((0x1e0U & (vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3031_[1U] 
                                                >> 0xfU)) 
                                     | (((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0355_) 
                                         << 4U) | (
                                                   ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0354_) 
                                                    << 3U) 
                                                   | (7U 
                                                      & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0353_) 
                                                         >> 5U))))));
        vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0374_ 
            = ((0xf00U & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0353_) 
                          << 8U)) | ((0xf0U & (vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3031_[1U] 
                                               >> 2U)) 
                                     | (((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0358_) 
                                         << 3U) | (
                                                   ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0357_) 
                                                    << 2U) 
                                                   | (3U 
                                                      & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0356_) 
                                                         >> 6U))))));
        vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0375_ 
            = ((0xf80U & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0356_) 
                          << 7U)) | ((0x78U & (vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3031_[0U] 
                                               >> 0x15U)) 
                                     | (((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0361_) 
                                         << 2U) | (
                                                   ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0360_) 
                                                    << 1U) 
                                                   | (1U 
                                                      & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0359_) 
                                                         >> 7U))))));
    }
    if (vlSelf->intv_phoenix__DOT__intv__DOT___67_) {
        vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___589_ 
            = vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___547_;
        vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___567_ 
            = (((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___541_) 
                << 3U) | (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___540_));
    } else {
        vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___589_ 
            = vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___590_;
        vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___567_ 
            = vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___568_;
    }
    vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___583_ 
        = ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___596_)
            ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___538_)
            : (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___584_));
    if (vlSelf->intv_phoenix__DOT__intv__DOT___70_) {
        vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0694_ 
            = (0x7ffffU & ((1U & ((~ (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0659_)) 
                                  & (~ (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0882_))))
                            ? (vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0736_ 
                               + (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0658_))
                            : vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0624_));
        vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0702_ 
            = vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0616_;
    } else {
        vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0694_ 
            = (0x7ffffU & vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0159_);
        vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0702_ 
            = vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0703_;
    }
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__s 
        = (((7U == (7U & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___1058_))) 
            << 5U) | (((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0417_) 
                       << 4U) | (((0U == (7U & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___1058_))) 
                                  << 3U) | (((2U == 
                                              (7U & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___1058_))) 
                                             << 2U) 
                                            | (((3U 
                                                 == 
                                                 (7U 
                                                  & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___1058_))) 
                                                << 1U) 
                                               | (1U 
                                                  == 
                                                  (7U 
                                                   & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___1058_))))))));
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__b 
        = (((QData)((IData)((((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0412_) 
                              << 0x10U) | (0xffffU 
                                           & (((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0851_) 
                                               << 8U) 
                                              | (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0851_)))))) 
            << 0x10U) | (QData)((IData)((0xffffU & 
                                         (((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0851_) 
                                           << 8U) | (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0851_))))));
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__Vfuncout 
        = (0xffU & ((0x20U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__s))
                     ? ((0x10U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__s))
                         ? ((8U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__s))
                             ? ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__s))
                                 ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__s))
                                     ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__s))
                                         ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__b)
                                         : (IData)(
                                                   (__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__b 
                                                    >> 8U)))
                                     : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__s))
                                         ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__b)
                                         : (IData)(
                                                   (__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__b 
                                                    >> 0x10U))))
                                 : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__s))
                                     ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__s))
                                         ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__b)
                                         : (IData)(
                                                   (__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__b 
                                                    >> 8U)))
                                     : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__s))
                                         ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__b)
                                         : (IData)(
                                                   (__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__b 
                                                    >> 0x18U)))))
                             : ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__s))
                                 ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__s))
                                     ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__s))
                                         ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__b)
                                         : (IData)(
                                                   (__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__b 
                                                    >> 8U)))
                                     : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__s))
                                         ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__b)
                                         : (IData)(
                                                   (__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__b 
                                                    >> 0x10U))))
                                 : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__s))
                                     ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__s))
                                         ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__b)
                                         : (IData)(
                                                   (__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__b 
                                                    >> 8U)))
                                     : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__s))
                                         ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__b)
                                         : (IData)(
                                                   (__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__b 
                                                    >> 0x20U))))))
                         : ((8U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__s))
                             ? ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__s))
                                 ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__s))
                                     ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__s))
                                         ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__b)
                                         : (IData)(
                                                   (__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__b 
                                                    >> 8U)))
                                     : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__s))
                                         ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__b)
                                         : (IData)(
                                                   (__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__b 
                                                    >> 0x10U))))
                                 : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__s))
                                     ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__s))
                                         ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__b)
                                         : (IData)(
                                                   (__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__b 
                                                    >> 8U)))
                                     : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__s))
                                         ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__b)
                                         : (IData)(
                                                   (__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__b 
                                                    >> 0x18U)))))
                             : ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__s))
                                 ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__s))
                                     ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__s))
                                         ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__b)
                                         : (IData)(
                                                   (__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__b 
                                                    >> 8U)))
                                     : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__s))
                                         ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__b)
                                         : (IData)(
                                                   (__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__b 
                                                    >> 0x10U))))
                                 : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__s))
                                     ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__s))
                                         ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__b)
                                         : (IData)(
                                                   (__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__b 
                                                    >> 8U)))
                                     : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__s))
                                         ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__b)
                                         : (IData)(
                                                   (__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__b 
                                                    >> 0x28U)))))))
                     : ((0x10U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__s))
                         ? ((8U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__s))
                             ? ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__s))
                                 ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__s))
                                     ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__s))
                                         ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__b)
                                         : (IData)(
                                                   (__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__b 
                                                    >> 8U)))
                                     : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__s))
                                         ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__b)
                                         : (IData)(
                                                   (__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__b 
                                                    >> 0x10U))))
                                 : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__s))
                                     ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__s))
                                         ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__b)
                                         : (IData)(
                                                   (__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__b 
                                                    >> 8U)))
                                     : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__s))
                                         ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__b)
                                         : (IData)(
                                                   (__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__b 
                                                    >> 0x18U)))))
                             : ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__s))
                                 ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__s))
                                     ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__s))
                                         ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__b)
                                         : (IData)(
                                                   (__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__b 
                                                    >> 8U)))
                                     : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__s))
                                         ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__b)
                                         : (IData)(
                                                   (__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__b 
                                                    >> 0x10U))))
                                 : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__s))
                                     ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__s))
                                         ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__b)
                                         : (IData)(
                                                   (__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__b 
                                                    >> 8U)))
                                     : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__s))
                                         ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__b)
                                         : (IData)(
                                                   (__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__b 
                                                    >> 0x20U))))))
                         : ((8U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__s))
                             ? ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__s))
                                 ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__s))
                                     ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__s))
                                         ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__b)
                                         : (IData)(
                                                   (__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__b 
                                                    >> 8U)))
                                     : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__s))
                                         ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__b)
                                         : (IData)(
                                                   (__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__b 
                                                    >> 0x10U))))
                                 : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__s))
                                     ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__s))
                                         ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__b)
                                         : (IData)(
                                                   (__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__b 
                                                    >> 8U)))
                                     : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__s))
                                         ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__b)
                                         : (IData)(
                                                   (__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__b 
                                                    >> 0x18U)))))
                             : ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__s))
                                 ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__s))
                                     ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__s))
                                         ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__b)
                                         : (IData)(
                                                   (__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__b 
                                                    >> 8U)))
                                     : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__s))
                                         ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__b)
                                         : (IData)(
                                                   (__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__b 
                                                    >> 0x10U))))
                                 : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__s))
                                     ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__s))
                                         ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__b)
                                         : (IData)(
                                                   (__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__b 
                                                    >> 8U)))
                                     : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__s))
                                         ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__b)
                                         : 0U)))))));
    intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0429_ 
        = __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313738__108__Vfuncout;
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__s 
        = (((7U == (7U & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___1058_))) 
            << 5U) | (((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0417_) 
                       << 4U) | (((0U == (7U & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___1058_))) 
                                  << 3U) | (((2U == 
                                              (7U & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___1058_))) 
                                             << 2U) 
                                            | (((3U 
                                                 == 
                                                 (7U 
                                                  & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___1058_))) 
                                                << 1U) 
                                               | (1U 
                                                  == 
                                                  (7U 
                                                   & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___1058_))))))));
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__b 
        = ((0x30U & ((- (IData)((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0882_))) 
                     << 4U)) | ((((0U == (0xfU & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0873_) 
                                                  >> 4U)))
                                   ? ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0744_)
                                       ? (0x1800U == 
                                          (0xffffU 
                                           & (vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0740_ 
                                              >> 3U)))
                                       : (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0882_))
                                   : (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0882_)) 
                                 << 3U) | (((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0245_) 
                                            << 2U) 
                                           | (((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0245_) 
                                               << 1U) 
                                              | (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0882_)))));
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__Vfuncout 
        = (1U & ((0x20U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__s))
                  ? ((0x10U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__s))
                      ? ((8U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__s))
                          ? ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__s))
                              ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__s))
                                  ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__s))
                                      ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__b)
                                      : ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__b) 
                                         >> 1U)) : 
                                 ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__s))
                                   ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__b)
                                   : ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__b) 
                                      >> 2U))) : ((2U 
                                                   & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__s))
                                                   ? 
                                                  ((1U 
                                                    & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__s))
                                                    ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__b)
                                                    : 
                                                   ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__b) 
                                                    >> 1U))
                                                   : 
                                                  ((1U 
                                                    & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__s))
                                                    ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__b)
                                                    : 
                                                   ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__b) 
                                                    >> 3U))))
                          : ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__s))
                              ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__s))
                                  ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__s))
                                      ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__b)
                                      : ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__b) 
                                         >> 1U)) : 
                                 ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__s))
                                   ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__b)
                                   : ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__b) 
                                      >> 2U))) : ((2U 
                                                   & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__s))
                                                   ? 
                                                  ((1U 
                                                    & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__s))
                                                    ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__b)
                                                    : 
                                                   ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__b) 
                                                    >> 1U))
                                                   : 
                                                  ((1U 
                                                    & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__s))
                                                    ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__b)
                                                    : 
                                                   ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__b) 
                                                    >> 4U)))))
                      : ((8U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__s))
                          ? ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__s))
                              ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__s))
                                  ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__s))
                                      ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__b)
                                      : ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__b) 
                                         >> 1U)) : 
                                 ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__s))
                                   ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__b)
                                   : ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__b) 
                                      >> 2U))) : ((2U 
                                                   & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__s))
                                                   ? 
                                                  ((1U 
                                                    & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__s))
                                                    ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__b)
                                                    : 
                                                   ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__b) 
                                                    >> 1U))
                                                   : 
                                                  ((1U 
                                                    & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__s))
                                                    ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__b)
                                                    : 
                                                   ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__b) 
                                                    >> 3U))))
                          : ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__s))
                              ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__s))
                                  ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__s))
                                      ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__b)
                                      : ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__b) 
                                         >> 1U)) : 
                                 ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__s))
                                   ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__b)
                                   : ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__b) 
                                      >> 2U))) : ((2U 
                                                   & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__s))
                                                   ? 
                                                  ((1U 
                                                    & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__s))
                                                    ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__b)
                                                    : 
                                                   ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__b) 
                                                    >> 1U))
                                                   : 
                                                  ((1U 
                                                    & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__s))
                                                    ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__b)
                                                    : 
                                                   ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__b) 
                                                    >> 5U))))))
                  : ((0x10U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__s))
                      ? ((8U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__s))
                          ? ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__s))
                              ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__s))
                                  ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__s))
                                      ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__b)
                                      : ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__b) 
                                         >> 1U)) : 
                                 ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__s))
                                   ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__b)
                                   : ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__b) 
                                      >> 2U))) : ((2U 
                                                   & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__s))
                                                   ? 
                                                  ((1U 
                                                    & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__s))
                                                    ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__b)
                                                    : 
                                                   ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__b) 
                                                    >> 1U))
                                                   : 
                                                  ((1U 
                                                    & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__s))
                                                    ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__b)
                                                    : 
                                                   ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__b) 
                                                    >> 3U))))
                          : ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__s))
                              ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__s))
                                  ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__s))
                                      ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__b)
                                      : ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__b) 
                                         >> 1U)) : 
                                 ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__s))
                                   ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__b)
                                   : ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__b) 
                                      >> 2U))) : ((2U 
                                                   & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__s))
                                                   ? 
                                                  ((1U 
                                                    & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__s))
                                                    ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__b)
                                                    : 
                                                   ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__b) 
                                                    >> 1U))
                                                   : 
                                                  ((1U 
                                                    & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__s))
                                                    ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__b)
                                                    : 
                                                   ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__b) 
                                                    >> 4U)))))
                      : ((8U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__s))
                          ? ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__s))
                              ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__s))
                                  ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__s))
                                      ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__b)
                                      : ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__b) 
                                         >> 1U)) : 
                                 ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__s))
                                   ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__b)
                                   : ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__b) 
                                      >> 2U))) : ((2U 
                                                   & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__s))
                                                   ? 
                                                  ((1U 
                                                    & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__s))
                                                    ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__b)
                                                    : 
                                                   ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__b) 
                                                    >> 1U))
                                                   : 
                                                  ((1U 
                                                    & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__s))
                                                    ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__b)
                                                    : 
                                                   ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__b) 
                                                    >> 3U))))
                          : ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__s))
                              ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__s))
                                  ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__s))
                                      ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__b)
                                      : ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__b) 
                                         >> 1U)) : 
                                 ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__s))
                                   ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__b)
                                   : ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__b) 
                                      >> 2U))) : ((2U 
                                                   & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__s))
                                                   ? 
                                                  ((1U 
                                                    & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__s))
                                                    ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__b)
                                                    : 
                                                   ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__b) 
                                                    >> 1U))
                                                   : 
                                                  ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__s) 
                                                   & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__b))))))));
    intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0436_ 
        = __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313758__115__Vfuncout;
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314636__146__s 
        = (((0x15U == (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0703_)) 
            << 0x15U) | (((0x14U == (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0703_)) 
                          << 0x14U) | (((0x13U == (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0703_)) 
                                        << 0x13U) | 
                                       (((0x12U == (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0703_)) 
                                         << 0x12U) 
                                        | (((0x11U 
                                             == (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0703_)) 
                                            << 0x11U) 
                                           | (((0x10U 
                                                == (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0703_)) 
                                               << 0x10U) 
                                              | (((0xfU 
                                                   == (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0703_)) 
                                                  << 0xfU) 
                                                 | (((0xeU 
                                                      == (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0703_)) 
                                                     << 0xeU) 
                                                    | (((0xdU 
                                                         == (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0703_)) 
                                                        << 0xdU) 
                                                       | (((0xcU 
                                                            == (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0703_)) 
                                                           << 0xcU) 
                                                          | (((0xbU 
                                                               == (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0703_)) 
                                                              << 0xbU) 
                                                             | (((0xaU 
                                                                  == (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0703_)) 
                                                                 << 0xaU) 
                                                                | (((9U 
                                                                     == (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0703_)) 
                                                                    << 9U) 
                                                                   | (((8U 
                                                                        == (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0703_)) 
                                                                       << 8U) 
                                                                      | (((7U 
                                                                           == (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0703_)) 
                                                                          << 7U) 
                                                                         | (((6U 
                                                                              == (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0703_)) 
                                                                             << 6U) 
                                                                            | (((5U 
                                                                                == (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0703_)) 
                                                                                << 5U) 
                                                                               | (((4U 
                                                                                == (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0703_)) 
                                                                                << 4U) 
                                                                                | (((3U 
                                                                                == (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0703_)) 
                                                                                << 3U) 
                                                                                | (((2U 
                                                                                == (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0703_)) 
                                                                                << 2U) 
                                                                                | (((1U 
                                                                                == (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0703_)) 
                                                                                << 1U) 
                                                                                | (0U 
                                                                                == (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0703_)))))))))))))))))))))));
    __Vtemp_21[2U] = (((0xff00U & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0851_) 
                                   << 8U)) | ((0xffffU 
                                               & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0455_)) 
                                              | ((0xffffU 
                                                  & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0851_) 
                                                     >> 8U)) 
                                                 | ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0455_) 
                                                    >> 0x10U)))) 
                      | (((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0851_) 
                          << 0x18U) | (((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0851_) 
                                        << 0x10U) | 
                                       (0xffff0000U 
                                        & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0851_) 
                                           << 8U)))));
    __Vtemp_21[3U] = ((((0xffU & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0851_)) 
                        | ((0xffU & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0851_) 
                                     >> 8U)) | ((0xffU 
                                                 & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0851_) 
                                                    >> 0x10U)) 
                                                | ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0851_) 
                                                   >> 0x18U)))) 
                       | (0xff00U & (((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0851_) 
                                      << 8U) | ((0xffffU 
                                                 & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0851_)) 
                                                | ((0xffffU 
                                                    & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0851_) 
                                                       >> 8U)) 
                                                   | ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0851_) 
                                                      >> 0x10U)))))) 
                      | (((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0851_) 
                          << 0x18U) | (((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0851_) 
                                        << 0x10U) | 
                                       ((0xffff0000U 
                                         & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0851_) 
                                            << 8U)) 
                                        | ((0xffff0000U 
                                            & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0851_)) 
                                           | (0xff0000U 
                                              & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0851_) 
                                                 >> 8U)))))));
    __Vtemp_21[4U] = ((((0xffU & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0851_)) 
                        | ((0xffU & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0851_) 
                                     >> 8U)) | ((0xffU 
                                                 & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0851_) 
                                                    >> 0x10U)) 
                                                | ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0851_) 
                                                   >> 0x18U)))) 
                       | (0xff00U & (((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0851_) 
                                      << 8U) | ((0xffffU 
                                                 & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0851_)) 
                                                | ((0xffffU 
                                                    & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0851_) 
                                                       >> 8U)) 
                                                   | ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0851_) 
                                                      >> 0x10U)))))) 
                      | (((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0851_) 
                          << 0x18U) | (((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0851_) 
                                        << 0x10U) | 
                                       ((0xffff0000U 
                                         & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0851_) 
                                            << 8U)) 
                                        | ((0xffff0000U 
                                            & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0851_)) 
                                           | (0xff0000U 
                                              & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0851_) 
                                                 >> 8U)))))));
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314636__146__b[0U] 
        = ((0xffff0000U & (((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0851_) 
                            << 0x18U) | ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0851_) 
                                         << 0x10U))) 
           | (0xffffU & (((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0851_) 
                          << 8U) | (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0851_))));
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314636__146__b[1U] 
        = (((0xff00U & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0851_) 
                        << 8U)) | (0xffffU & (IData)(intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0429_))) 
           | (((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0851_) 
               << 0x18U) | ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0455_) 
                            << 0x10U)));
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314636__146__b[2U] 
        = __Vtemp_21[2U];
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314636__146__b[3U] 
        = __Vtemp_21[3U];
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314636__146__b[4U] 
        = __Vtemp_21[4U];
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314636__146__b[5U] 
        = (((0xffU & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0851_)) 
            | ((0xffU & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0851_) 
                         >> 8U)) | ((0xffU & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0851_) 
                                              >> 0x10U)) 
                                    | ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0851_) 
                                       >> 0x18U)))) 
           | (0xff00U & (((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0851_) 
                          << 8U) | ((0xffffU & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0851_)) 
                                    | ((0xffffU & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0851_) 
                                                   >> 8U)) 
                                       | ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0851_) 
                                          >> 0x10U))))));
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314636__146__Vfuncout 
        = (0xffU & (((((((((1U == (1U & __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314636__146__s)) 
                           | (2U == (2U & __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314636__146__s))) 
                          | (4U == (4U & __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314636__146__s))) 
                         | (8U == (8U & __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314636__146__s))) 
                        | (0x10U == (0x10U & __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314636__146__s))) 
                       | (0x20U == (0x20U & __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314636__146__s))) 
                      | (0x40U == (0x40U & __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314636__146__s))) 
                     | (0x80U == (0x80U & __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314636__146__s)))
                     ? ((1U == (1U & __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314636__146__s))
                         ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314636__146__b[0U]
                         : ((2U == (2U & __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314636__146__s))
                             ? ((__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314636__146__b[0U] 
                                 << 0x18U) | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314636__146__b[0U] 
                                              >> 8U))
                             : ((4U == (4U & __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314636__146__s))
                                 ? ((__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314636__146__b[0U] 
                                     << 0x10U) | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314636__146__b[0U] 
                                                  >> 0x10U))
                                 : ((8U == (8U & __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314636__146__s))
                                     ? ((__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314636__146__b[0U] 
                                         << 8U) | (
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314636__146__b[0U] 
                                                   >> 0x18U))
                                     : ((0x10U == (0x10U 
                                                   & __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314636__146__s))
                                         ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314636__146__b[1U]
                                         : ((0x20U 
                                             == (0x20U 
                                                 & __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314636__146__s))
                                             ? ((__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314636__146__b[1U] 
                                                 << 0x18U) 
                                                | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314636__146__b[1U] 
                                                   >> 8U))
                                             : ((0x40U 
                                                 == 
                                                 (0x40U 
                                                  & __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314636__146__s))
                                                 ? 
                                                ((__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314636__146__b[1U] 
                                                  << 0x10U) 
                                                 | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314636__146__b[1U] 
                                                    >> 0x10U))
                                                 : 
                                                ((__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314636__146__b[1U] 
                                                  << 8U) 
                                                 | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314636__146__b[1U] 
                                                    >> 0x18U)))))))))
                     : (((((((((0x100U == (0x100U & __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314636__146__s)) 
                               | (0x200U == (0x200U 
                                             & __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314636__146__s))) 
                              | (0x400U == (0x400U 
                                            & __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314636__146__s))) 
                             | (0x800U == (0x800U & __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314636__146__s))) 
                            | (0x1000U == (0x1000U 
                                           & __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314636__146__s))) 
                           | (0x2000U == (0x2000U & __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314636__146__s))) 
                          | (0x4000U == (0x4000U & __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314636__146__s))) 
                         | (0x8000U == (0x8000U & __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314636__146__s)))
                         ? ((0x100U == (0x100U & __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314636__146__s))
                             ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314636__146__b[2U]
                             : ((0x200U == (0x200U 
                                            & __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314636__146__s))
                                 ? ((__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314636__146__b[2U] 
                                     << 0x18U) | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314636__146__b[2U] 
                                                  >> 8U))
                                 : ((0x400U == (0x400U 
                                                & __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314636__146__s))
                                     ? ((__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314636__146__b[2U] 
                                         << 0x10U) 
                                        | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314636__146__b[2U] 
                                           >> 0x10U))
                                     : ((0x800U == 
                                         (0x800U & __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314636__146__s))
                                         ? ((__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314636__146__b[2U] 
                                             << 8U) 
                                            | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314636__146__b[2U] 
                                               >> 0x18U))
                                         : ((0x1000U 
                                             == (0x1000U 
                                                 & __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314636__146__s))
                                             ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314636__146__b[3U]
                                             : ((0x2000U 
                                                 == 
                                                 (0x2000U 
                                                  & __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314636__146__s))
                                                 ? 
                                                ((__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314636__146__b[3U] 
                                                  << 0x18U) 
                                                 | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314636__146__b[3U] 
                                                    >> 8U))
                                                 : 
                                                ((0x4000U 
                                                  == 
                                                  (0x4000U 
                                                   & __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314636__146__s))
                                                  ? 
                                                 ((__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314636__146__b[3U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314636__146__b[3U] 
                                                     >> 0x10U))
                                                  : 
                                                 ((__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314636__146__b[3U] 
                                                   << 8U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314636__146__b[3U] 
                                                     >> 0x18U)))))))))
                         : ((0x10000U == (0x10000U 
                                          & __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314636__146__s))
                             ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314636__146__b[4U]
                             : ((0x20000U == (0x20000U 
                                              & __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314636__146__s))
                                 ? ((__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314636__146__b[4U] 
                                     << 0x18U) | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314636__146__b[4U] 
                                                  >> 8U))
                                 : ((0x40000U == (0x40000U 
                                                  & __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314636__146__s))
                                     ? ((__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314636__146__b[4U] 
                                         << 0x10U) 
                                        | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314636__146__b[4U] 
                                           >> 0x10U))
                                     : ((0x80000U == 
                                         (0x80000U 
                                          & __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314636__146__s))
                                         ? ((__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314636__146__b[4U] 
                                             << 8U) 
                                            | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314636__146__b[4U] 
                                               >> 0x18U))
                                         : ((0x100000U 
                                             == (0x100000U 
                                                 & __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314636__146__s))
                                             ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314636__146__b[5U]
                                             : ((0x200000U 
                                                 == 
                                                 (0x200000U 
                                                  & __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314636__146__s))
                                                 ? 
                                                ((__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314636__146__b[5U] 
                                                  << 0x18U) 
                                                 | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314636__146__b[5U] 
                                                    >> 8U))
                                                 : 0U)))))))));
    intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0647_ 
        = __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314636__146__Vfuncout;
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314658__156__s 
        = (((0x15U == (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0703_)) 
            << 0x15U) | (((0x14U == (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0703_)) 
                          << 0x14U) | (((0x13U == (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0703_)) 
                                        << 0x13U) | 
                                       (((0x12U == (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0703_)) 
                                         << 0x12U) 
                                        | (((0x11U 
                                             == (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0703_)) 
                                            << 0x11U) 
                                           | (((0x10U 
                                                == (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0703_)) 
                                               << 0x10U) 
                                              | (((0xfU 
                                                   == (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0703_)) 
                                                  << 0xfU) 
                                                 | (((0xeU 
                                                      == (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0703_)) 
                                                     << 0xeU) 
                                                    | (((0xdU 
                                                         == (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0703_)) 
                                                        << 0xdU) 
                                                       | (((0xcU 
                                                            == (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0703_)) 
                                                           << 0xcU) 
                                                          | (((0xbU 
                                                               == (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0703_)) 
                                                              << 0xbU) 
                                                             | (((0xaU 
                                                                  == (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0703_)) 
                                                                 << 0xaU) 
                                                                | (((9U 
                                                                     == (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0703_)) 
                                                                    << 9U) 
                                                                   | (((8U 
                                                                        == (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0703_)) 
                                                                       << 8U) 
                                                                      | (((7U 
                                                                           == (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0703_)) 
                                                                          << 7U) 
                                                                         | (((6U 
                                                                              == (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0703_)) 
                                                                             << 6U) 
                                                                            | (((5U 
                                                                                == (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0703_)) 
                                                                                << 5U) 
                                                                               | (((4U 
                                                                                == (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0703_)) 
                                                                                << 4U) 
                                                                                | (((3U 
                                                                                == (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0703_)) 
                                                                                << 3U) 
                                                                                | (((2U 
                                                                                == (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0703_)) 
                                                                                << 2U) 
                                                                                | (((1U 
                                                                                == (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0703_)) 
                                                                                << 1U) 
                                                                                | (0U 
                                                                                == (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0703_)))))))))))))))))))))));
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314658__156__b 
        = ((0x3fffe0U & ((- (IData)((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0882_))) 
                         << 5U)) | (((IData)(intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0436_) 
                                     << 4U) | (((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0882_) 
                                                << 3U) 
                                               | (((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0882_) 
                                                   << 2U) 
                                                  | (((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0882_) 
                                                      << 1U) 
                                                     | ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0835_)
                                                         ? 
                                                        ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0179_)
                                                          ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0882_)
                                                          : 
                                                         ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0183_)
                                                           ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0882_)
                                                           : 
                                                          ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0868_)
                                                            ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0882_)
                                                            : 
                                                           ((~ (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0840_)) 
                                                            & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0882_)))))
                                                         : (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0882_)))))));
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314658__156__Vfuncout 
        = (1U & (((((((((1U == (1U & __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314658__156__s)) 
                        | (2U == (2U & __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314658__156__s))) 
                       | (4U == (4U & __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314658__156__s))) 
                      | (8U == (8U & __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314658__156__s))) 
                     | (0x10U == (0x10U & __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314658__156__s))) 
                    | (0x20U == (0x20U & __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314658__156__s))) 
                   | (0x40U == (0x40U & __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314658__156__s))) 
                  | (0x80U == (0x80U & __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314658__156__s)))
                  ? ((1U == (1U & __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314658__156__s))
                      ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314658__156__b
                      : ((2U == (2U & __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314658__156__s))
                          ? (__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314658__156__b 
                             >> 1U) : ((4U == (4U & __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314658__156__s))
                                        ? (__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314658__156__b 
                                           >> 2U) : 
                                       ((8U == (8U 
                                                & __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314658__156__s))
                                         ? (__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314658__156__b 
                                            >> 3U) : 
                                        ((0x10U == 
                                          (0x10U & __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314658__156__s))
                                          ? (__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314658__156__b 
                                             >> 4U)
                                          : ((0x20U 
                                              == (0x20U 
                                                  & __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314658__156__s))
                                              ? (__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314658__156__b 
                                                 >> 5U)
                                              : ((0x40U 
                                                  == 
                                                  (0x40U 
                                                   & __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314658__156__s))
                                                  ? 
                                                 (__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314658__156__b 
                                                  >> 6U)
                                                  : 
                                                 (__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314658__156__b 
                                                  >> 7U))))))))
                  : (((((((((0x100U == (0x100U & __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314658__156__s)) 
                            | (0x200U == (0x200U & __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314658__156__s))) 
                           | (0x400U == (0x400U & __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314658__156__s))) 
                          | (0x800U == (0x800U & __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314658__156__s))) 
                         | (0x1000U == (0x1000U & __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314658__156__s))) 
                        | (0x2000U == (0x2000U & __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314658__156__s))) 
                       | (0x4000U == (0x4000U & __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314658__156__s))) 
                      | (0x8000U == (0x8000U & __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314658__156__s)))
                      ? ((0x100U == (0x100U & __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314658__156__s))
                          ? (__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314658__156__b 
                             >> 8U) : ((0x200U == (0x200U 
                                                   & __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314658__156__s))
                                        ? (__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314658__156__b 
                                           >> 9U) : 
                                       ((0x400U == 
                                         (0x400U & __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314658__156__s))
                                         ? (__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314658__156__b 
                                            >> 0xaU)
                                         : ((0x800U 
                                             == (0x800U 
                                                 & __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314658__156__s))
                                             ? (__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314658__156__b 
                                                >> 0xbU)
                                             : ((0x1000U 
                                                 == 
                                                 (0x1000U 
                                                  & __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314658__156__s))
                                                 ? 
                                                (__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314658__156__b 
                                                 >> 0xcU)
                                                 : 
                                                ((0x2000U 
                                                  == 
                                                  (0x2000U 
                                                   & __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314658__156__s))
                                                  ? 
                                                 (__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314658__156__b 
                                                  >> 0xdU)
                                                  : 
                                                 ((0x4000U 
                                                   == 
                                                   (0x4000U 
                                                    & __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314658__156__s))
                                                   ? 
                                                  (__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314658__156__b 
                                                   >> 0xeU)
                                                   : 
                                                  (__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314658__156__b 
                                                   >> 0xfU))))))))
                      : ((0x10000U == (0x10000U & __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314658__156__s))
                          ? (__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314658__156__b 
                             >> 0x10U) : ((0x20000U 
                                           == (0x20000U 
                                               & __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314658__156__s))
                                           ? (__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314658__156__b 
                                              >> 0x11U)
                                           : ((0x40000U 
                                               == (0x40000U 
                                                   & __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314658__156__s))
                                               ? (__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314658__156__b 
                                                  >> 0x12U)
                                               : ((0x80000U 
                                                   == 
                                                   (0x80000U 
                                                    & __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314658__156__s))
                                                   ? 
                                                  (__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314658__156__b 
                                                   >> 0x13U)
                                                   : 
                                                  ((0x100000U 
                                                    == 
                                                    (0x100000U 
                                                     & __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314658__156__s))
                                                    ? 
                                                   (__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314658__156__b 
                                                    >> 0x14U)
                                                    : (IData)(
                                                              ((__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314658__156__s 
                                                                & __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314658__156__b) 
                                                               >> 0x15U))))))))));
    intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0657_ 
        = __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314658__156__Vfuncout;
    if (vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0887_) {
        vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0850_ 
            = intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0647_;
        vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0881_ 
            = intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0657_;
    } else {
        vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0850_ 
            = vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0851_;
        vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0881_ 
            = vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0882_;
    }
}

VL_INLINE_OPT void Vintv_phoenix___024root___nba_sequent__TOP__9(Vintv_phoenix___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vintv_phoenix__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vintv_phoenix___024root___nba_sequent__TOP__9\n"); );
    // Body
    vlSelf->intv_phoenix__DOT__boot_cpu__DOT__state 
        = vlSelf->__Vdly__intv_phoenix__DOT__boot_cpu__DOT__state;
}

extern const VlUnpacked<CData/*0:0*/, 256> Vintv_phoenix__ConstPool__TABLE_hcee92ae2_0;
extern const VlUnpacked<CData/*0:0*/, 512> Vintv_phoenix__ConstPool__TABLE_h5b11bf59_0;
extern const VlUnpacked<CData/*0:0*/, 128> Vintv_phoenix__ConstPool__TABLE_h0824053f_0;
extern const VlUnpacked<CData/*0:0*/, 8192> Vintv_phoenix__ConstPool__TABLE_h319d371e_0;
extern const VlUnpacked<CData/*1:0*/, 2048> Vintv_phoenix__ConstPool__TABLE_h5df50146_0;
extern const VlUnpacked<CData/*3:0*/, 2048> Vintv_phoenix__ConstPool__TABLE_h1d2ed4f1_0;

VL_INLINE_OPT void Vintv_phoenix___024root___nba_comb__TOP__6(Vintv_phoenix___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vintv_phoenix__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vintv_phoenix___024root___nba_comb__TOP__6\n"); );
    // Init
    SData/*8:0*/ __Vtableidx2;
    __Vtableidx2 = 0;
    CData/*6:0*/ __Vtableidx3;
    __Vtableidx3 = 0;
    CData/*7:0*/ __Vtableidx4;
    __Vtableidx4 = 0;
    SData/*10:0*/ __Vtableidx5;
    __Vtableidx5 = 0;
    SData/*10:0*/ __Vtableidx6;
    __Vtableidx6 = 0;
    SData/*12:0*/ __Vtableidx7;
    __Vtableidx7 = 0;
    // Body
    __Vtableidx4 = (((IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__plp) 
                     << 7U) | (((IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__load_reg) 
                                << 6U) | (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__state)));
    vlSelf->intv_phoenix__DOT__boot_cpu__DOT__write_register 
        = Vintv_phoenix__ConstPool__TABLE_hcee92ae2_0
        [__Vtableidx4];
    __Vtableidx2 = (((IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__backwards) 
                     << 8U) | (((IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__CO) 
                                << 7U) | (((IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__NMI_edge) 
                                           << 6U) | (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__state))));
    vlSelf->intv_phoenix__DOT__boot_cpu__DOT__PC_inc 
        = Vintv_phoenix__ConstPool__TABLE_h5b11bf59_0
        [__Vtableidx2];
    __Vtableidx3 = (((IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__store) 
                     << 6U) | (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__state));
    vlSelf->intv_phoenix__DOT__cpu_we = Vintv_phoenix__ConstPool__TABLE_h0824053f_0
        [__Vtableidx3];
    vlSelf->intv_phoenix__DOT__boot_cpu__DOT____Vcellinp__ALU__BCD 
        = ((IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__adc_bcd) 
           & (0xdU == (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__state)));
    vlSelf->intv_phoenix__DOT__boot_cpu__DOT__alu_shift_right 
        = (((0xdU == (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__state)) 
            | ((0x24U == (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__state)) 
               | (0x23U == (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__state)))) 
           & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__shift_right));
    __Vtableidx7 = (((IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__load_only) 
                     << 0xcU) | (((IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__compare) 
                                  << 0xbU) | (((IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__CO) 
                                               << 0xaU) 
                                              | (((IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__inc) 
                                                  << 9U) 
                                                 | (((IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__shift) 
                                                     << 8U) 
                                                    | (((IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__C) 
                                                        << 7U) 
                                                       | (((IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__rotate) 
                                                           << 6U) 
                                                          | (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__state))))))));
    vlSelf->intv_phoenix__DOT__boot_cpu__DOT__CI = 
        Vintv_phoenix__ConstPool__TABLE_h319d371e_0
        [__Vtableidx7];
    __Vtableidx5 = (((IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__dst_reg) 
                     << 9U) | (((IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__index_y) 
                                << 8U) | (((IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__src_reg) 
                                           << 6U) | (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__state))));
    vlSelf->intv_phoenix__DOT__boot_cpu__DOT__regsel 
        = Vintv_phoenix__ConstPool__TABLE_h5df50146_0
        [__Vtableidx5];
    __Vtableidx6 = (((IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__backwards) 
                     << 0xaU) | (((IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__op) 
                                  << 6U) | (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__state)));
    vlSelf->intv_phoenix__DOT__boot_cpu__DOT__alu_op 
        = Vintv_phoenix__ConstPool__TABLE_h1d2ed4f1_0
        [__Vtableidx6];
    vlSelf->intv_phoenix__DOT__boot_cpu__DOT__regfile 
        = vlSelf->intv_phoenix__DOT__boot_cpu__DOT__AXYS
        [vlSelf->intv_phoenix__DOT__boot_cpu__DOT__regsel];
    if ((0x20U & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__state))) {
        if ((0x10U & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__state))) {
            vlSelf->intv_phoenix__DOT__boot_cpu__DOT__PC_temp 
                = vlSelf->intv_phoenix__DOT__boot_cpu__DOT__PC;
            vlSelf->intv_phoenix__DOT__boot_cpu__DOT__BI 
                = (0xffU & (IData)(vlSelf->intv_phoenix__DOT__cpu_di));
            vlSelf->intv_phoenix__DOT__cpu_do = (0xffU 
                                                 & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__regfile));
            if ((8U & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__state))) {
                vlSelf->intv_phoenix__DOT__cpu_a = vlSelf->intv_phoenix__DOT__boot_cpu__DOT__PC;
                vlSelf->intv_phoenix__DOT__boot_cpu__DOT__AI 
                    = (0xffU & 0U);
            } else if ((4U & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__state))) {
                vlSelf->intv_phoenix__DOT__cpu_a = vlSelf->intv_phoenix__DOT__boot_cpu__DOT__PC;
                vlSelf->intv_phoenix__DOT__boot_cpu__DOT__AI 
                    = (0xffU & 0U);
            } else if ((2U & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__state))) {
                vlSelf->intv_phoenix__DOT__cpu_a = vlSelf->intv_phoenix__DOT__boot_cpu__DOT__PC;
                vlSelf->intv_phoenix__DOT__boot_cpu__DOT__AI 
                    = (0xffU & 0U);
            } else if ((1U & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__state))) {
                vlSelf->intv_phoenix__DOT__cpu_a = vlSelf->intv_phoenix__DOT__boot_cpu__DOT__ADD;
                vlSelf->intv_phoenix__DOT__boot_cpu__DOT__AI 
                    = (0xffU & 0U);
            } else {
                vlSelf->intv_phoenix__DOT__cpu_a = vlSelf->intv_phoenix__DOT__boot_cpu__DOT__PC;
                vlSelf->intv_phoenix__DOT__boot_cpu__DOT__AI 
                    = (0xffU & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__regfile));
            }
        } else if ((8U & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__state))) {
            vlSelf->intv_phoenix__DOT__boot_cpu__DOT__PC_temp 
                = ((2U & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__state))
                    ? (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__PC)
                    : ((1U & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__state))
                        ? (((IData)(vlSelf->intv_phoenix__DOT__cpu_di) 
                            << 8U) | (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__ADD))
                        : (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__PC)));
            if ((4U & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__state))) {
                vlSelf->intv_phoenix__DOT__boot_cpu__DOT__BI 
                    = (0xffU & (IData)(vlSelf->intv_phoenix__DOT__cpu_di));
                if ((2U & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__state))) {
                    if ((1U & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__state))) {
                        vlSelf->intv_phoenix__DOT__cpu_do 
                            = (0xffU & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__regfile));
                        vlSelf->intv_phoenix__DOT__cpu_a 
                            = vlSelf->intv_phoenix__DOT__cpu_di;
                    } else {
                        vlSelf->intv_phoenix__DOT__cpu_do 
                            = (0xffU & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__ADD));
                        vlSelf->intv_phoenix__DOT__cpu_a 
                            = (((IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__ABH) 
                                << 8U) | (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__ABL));
                    }
                } else {
                    vlSelf->intv_phoenix__DOT__cpu_do 
                        = (0xffU & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__regfile));
                    vlSelf->intv_phoenix__DOT__cpu_a 
                        = ((1U & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__state))
                            ? (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__PC)
                            : (0x100U | (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__ADD)));
                }
                vlSelf->intv_phoenix__DOT__boot_cpu__DOT__AI 
                    = (0xffU & 0U);
            } else {
                if ((2U & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__state))) {
                    vlSelf->intv_phoenix__DOT__boot_cpu__DOT__BI 
                        = (0xffU & 0U);
                    if ((1U & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__state))) {
                        vlSelf->intv_phoenix__DOT__cpu_a 
                            = (0x100U | (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__ADD));
                        vlSelf->intv_phoenix__DOT__boot_cpu__DOT__AI 
                            = (0xffU & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__ADD));
                    } else {
                        vlSelf->intv_phoenix__DOT__cpu_a 
                            = (0x100U | (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__regfile));
                        vlSelf->intv_phoenix__DOT__boot_cpu__DOT__AI 
                            = (0xffU & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__regfile));
                    }
                } else {
                    vlSelf->intv_phoenix__DOT__boot_cpu__DOT__BI 
                        = (0xffU & (IData)(vlSelf->intv_phoenix__DOT__cpu_di));
                    vlSelf->intv_phoenix__DOT__cpu_a 
                        = ((1U & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__state))
                            ? (((IData)(vlSelf->intv_phoenix__DOT__cpu_di) 
                                << 8U) | (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__ADD))
                            : (0x100U | (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__ADD)));
                    vlSelf->intv_phoenix__DOT__boot_cpu__DOT__AI 
                        = (0xffU & 0U);
                }
                vlSelf->intv_phoenix__DOT__cpu_do = 
                    (0xffU & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__regfile));
            }
        } else {
            vlSelf->intv_phoenix__DOT__boot_cpu__DOT__PC_temp 
                = vlSelf->intv_phoenix__DOT__boot_cpu__DOT__PC;
            if ((4U & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__state))) {
                vlSelf->intv_phoenix__DOT__boot_cpu__DOT__BI 
                    = (0xffU & 0U);
                vlSelf->intv_phoenix__DOT__cpu_do = 
                    (0xffU & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__regfile));
                if ((2U & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__state))) {
                    vlSelf->intv_phoenix__DOT__cpu_a 
                        = (0x100U | (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__ADD));
                    vlSelf->intv_phoenix__DOT__boot_cpu__DOT__AI 
                        = (0xffU & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__ADD));
                } else {
                    vlSelf->intv_phoenix__DOT__cpu_a 
                        = ((1U & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__state))
                            ? (0x100U | (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__regfile))
                            : (((IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__ABH) 
                                << 8U) | (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__ABL)));
                    vlSelf->intv_phoenix__DOT__boot_cpu__DOT__AI 
                        = (0xffU & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__regfile));
                }
            } else if ((2U & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__state))) {
                vlSelf->intv_phoenix__DOT__boot_cpu__DOT__BI 
                    = (0xffU & 0U);
                if ((1U & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__state))) {
                    vlSelf->intv_phoenix__DOT__cpu_do 
                        = (0xffU & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__regfile));
                    vlSelf->intv_phoenix__DOT__cpu_a 
                        = (((IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__ABH) 
                            << 8U) | (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__ABL));
                    vlSelf->intv_phoenix__DOT__boot_cpu__DOT__AI 
                        = (0xffU & (IData)(vlSelf->intv_phoenix__DOT__cpu_di));
                } else {
                    vlSelf->intv_phoenix__DOT__cpu_do 
                        = (0xffU & ((IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__php)
                                     ? (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__P)
                                     : (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__ADD)));
                    vlSelf->intv_phoenix__DOT__cpu_a 
                        = (0x100U | (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__regfile));
                    vlSelf->intv_phoenix__DOT__boot_cpu__DOT__AI 
                        = (0xffU & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__regfile));
                }
            } else {
                if ((1U & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__state))) {
                    vlSelf->intv_phoenix__DOT__boot_cpu__DOT__BI 
                        = (0xffU & 0U);
                    vlSelf->intv_phoenix__DOT__boot_cpu__DOT__AI 
                        = (0xffU & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__regfile));
                } else {
                    vlSelf->intv_phoenix__DOT__boot_cpu__DOT__BI 
                        = (0xffU & (IData)(vlSelf->intv_phoenix__DOT__cpu_di));
                    vlSelf->intv_phoenix__DOT__boot_cpu__DOT__AI 
                        = (0xffU & 0U);
                }
                vlSelf->intv_phoenix__DOT__cpu_do = 
                    (0xffU & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__regfile));
                vlSelf->intv_phoenix__DOT__cpu_a = vlSelf->intv_phoenix__DOT__boot_cpu__DOT__PC;
            }
        }
    } else if ((0x10U & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__state))) {
        if ((8U & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__state))) {
            vlSelf->intv_phoenix__DOT__boot_cpu__DOT__PC_temp 
                = ((2U & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__state))
                    ? (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__PC)
                    : ((1U & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__state))
                        ? (((IData)(vlSelf->intv_phoenix__DOT__cpu_di) 
                            << 8U) | (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__ADD))
                        : (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__PC)));
            if ((4U & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__state))) {
                if ((1U & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__state))) {
                    vlSelf->intv_phoenix__DOT__boot_cpu__DOT__BI 
                        = (0xffU & (IData)(vlSelf->intv_phoenix__DOT__cpu_di));
                    vlSelf->intv_phoenix__DOT__boot_cpu__DOT__AI 
                        = (0xffU & 0U);
                } else {
                    vlSelf->intv_phoenix__DOT__boot_cpu__DOT__BI 
                        = (0xffU & 0U);
                    vlSelf->intv_phoenix__DOT__boot_cpu__DOT__AI 
                        = (0xffU & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__regfile));
                }
                vlSelf->intv_phoenix__DOT__cpu_do = 
                    (0xffU & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__regfile));
                vlSelf->intv_phoenix__DOT__cpu_a = 
                    ((2U & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__state))
                      ? ((1U & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__state))
                          ? (0x100U | (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__ADD))
                          : (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__PC))
                      : (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__PC));
            } else if ((2U & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__state))) {
                vlSelf->intv_phoenix__DOT__boot_cpu__DOT__BI 
                    = (0xffU & 0U);
                if ((1U & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__state))) {
                    vlSelf->intv_phoenix__DOT__cpu_do 
                        = (0xffU & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__PC));
                    vlSelf->intv_phoenix__DOT__cpu_a 
                        = (0x100U | (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__ADD));
                    vlSelf->intv_phoenix__DOT__boot_cpu__DOT__AI 
                        = (0xffU & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__ADD));
                } else {
                    vlSelf->intv_phoenix__DOT__cpu_do 
                        = (0xffU & ((IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__PC) 
                                    >> 8U));
                    vlSelf->intv_phoenix__DOT__cpu_a 
                        = (0x100U | (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__regfile));
                    vlSelf->intv_phoenix__DOT__boot_cpu__DOT__AI 
                        = (0xffU & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__regfile));
                }
            } else {
                vlSelf->intv_phoenix__DOT__boot_cpu__DOT__BI 
                    = (0xffU & (IData)(vlSelf->intv_phoenix__DOT__cpu_di));
                vlSelf->intv_phoenix__DOT__cpu_do = 
                    (0xffU & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__regfile));
                vlSelf->intv_phoenix__DOT__cpu_a = 
                    ((1U & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__state))
                      ? (((IData)(vlSelf->intv_phoenix__DOT__cpu_di) 
                          << 8U) | (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__ADD))
                      : (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__PC));
                vlSelf->intv_phoenix__DOT__boot_cpu__DOT__AI 
                    = (0xffU & 0U);
            }
        } else {
            if ((4U & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__state))) {
                if ((2U & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__state))) {
                    if ((1U & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__state))) {
                        vlSelf->intv_phoenix__DOT__boot_cpu__DOT__PC_temp 
                            = (((IData)(vlSelf->intv_phoenix__DOT__cpu_di) 
                                << 8U) | (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__ADD));
                        vlSelf->intv_phoenix__DOT__cpu_a 
                            = (((IData)(vlSelf->intv_phoenix__DOT__cpu_di) 
                                << 8U) | (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__ADD));
                    } else {
                        vlSelf->intv_phoenix__DOT__boot_cpu__DOT__PC_temp 
                            = vlSelf->intv_phoenix__DOT__boot_cpu__DOT__PC;
                        vlSelf->intv_phoenix__DOT__cpu_a 
                            = vlSelf->intv_phoenix__DOT__boot_cpu__DOT__PC;
                    }
                } else {
                    vlSelf->intv_phoenix__DOT__boot_cpu__DOT__PC_temp 
                        = vlSelf->intv_phoenix__DOT__boot_cpu__DOT__PC;
                    vlSelf->intv_phoenix__DOT__cpu_a 
                        = ((1U & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__state))
                            ? (((IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__ADD) 
                                << 8U) | (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__ABL))
                            : (((IData)(vlSelf->intv_phoenix__DOT__cpu_di) 
                                << 8U) | (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__ADD)));
                }
                vlSelf->intv_phoenix__DOT__boot_cpu__DOT__AI 
                    = (0xffU & 0U);
            } else {
                vlSelf->intv_phoenix__DOT__boot_cpu__DOT__PC_temp 
                    = vlSelf->intv_phoenix__DOT__boot_cpu__DOT__PC;
                if ((2U & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__state))) {
                    if ((1U & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__state))) {
                        vlSelf->intv_phoenix__DOT__cpu_a 
                            = vlSelf->intv_phoenix__DOT__boot_cpu__DOT__ADD;
                        vlSelf->intv_phoenix__DOT__boot_cpu__DOT__AI 
                            = (0xffU & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__regfile));
                    } else {
                        vlSelf->intv_phoenix__DOT__cpu_a 
                            = vlSelf->intv_phoenix__DOT__cpu_di;
                        vlSelf->intv_phoenix__DOT__boot_cpu__DOT__AI 
                            = (0xffU & 0U);
                    }
                } else {
                    vlSelf->intv_phoenix__DOT__cpu_a 
                        = ((1U & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__state))
                            ? (((IData)(vlSelf->intv_phoenix__DOT__cpu_di) 
                                << 8U) | (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__ADD))
                            : (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__ADD));
                    vlSelf->intv_phoenix__DOT__boot_cpu__DOT__AI 
                        = (0xffU & 0U);
                }
            }
            vlSelf->intv_phoenix__DOT__boot_cpu__DOT__BI 
                = (0xffU & (IData)(vlSelf->intv_phoenix__DOT__cpu_di));
            vlSelf->intv_phoenix__DOT__cpu_do = (0xffU 
                                                 & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__regfile));
        }
    } else if ((8U & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__state))) {
        if ((4U & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__state))) {
            if ((2U & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__state))) {
                vlSelf->intv_phoenix__DOT__boot_cpu__DOT__PC_temp 
                    = vlSelf->intv_phoenix__DOT__boot_cpu__DOT__PC;
                if ((1U & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__state))) {
                    vlSelf->intv_phoenix__DOT__boot_cpu__DOT__BI 
                        = (0xffU & 0U);
                    vlSelf->intv_phoenix__DOT__cpu_a 
                        = vlSelf->intv_phoenix__DOT__boot_cpu__DOT__ADD;
                    vlSelf->intv_phoenix__DOT__boot_cpu__DOT__AI 
                        = (0xffU & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__ADD));
                } else {
                    vlSelf->intv_phoenix__DOT__boot_cpu__DOT__BI 
                        = (0xffU & (IData)(vlSelf->intv_phoenix__DOT__cpu_di));
                    vlSelf->intv_phoenix__DOT__cpu_a 
                        = vlSelf->intv_phoenix__DOT__boot_cpu__DOT__PC;
                    vlSelf->intv_phoenix__DOT__boot_cpu__DOT__AI 
                        = (0xffU & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__regfile));
                }
            } else {
                if ((1U & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__state))) {
                    vlSelf->intv_phoenix__DOT__boot_cpu__DOT__PC_temp 
                        = vlSelf->intv_phoenix__DOT__boot_cpu__DOT__PC;
                    vlSelf->intv_phoenix__DOT__boot_cpu__DOT__BI 
                        = (0xffU & (IData)(vlSelf->intv_phoenix__DOT__cpu_di));
                    vlSelf->intv_phoenix__DOT__boot_cpu__DOT__AI 
                        = (0xffU & ((IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__load_only)
                                     ? 0U : (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__regfile)));
                } else {
                    vlSelf->intv_phoenix__DOT__boot_cpu__DOT__PC_temp 
                        = ((IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__NMI_edge)
                            ? (((IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__ABH) 
                                << 8U) | (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__ABL))
                            : (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__PC));
                    vlSelf->intv_phoenix__DOT__boot_cpu__DOT__BI 
                        = (0xffU & 0U);
                    vlSelf->intv_phoenix__DOT__boot_cpu__DOT__AI 
                        = (0xffU & 0U);
                }
                vlSelf->intv_phoenix__DOT__cpu_a = vlSelf->intv_phoenix__DOT__boot_cpu__DOT__PC;
            }
            vlSelf->intv_phoenix__DOT__cpu_do = (0xffU 
                                                 & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__regfile));
        } else if ((2U & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__state))) {
            if ((1U & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__state))) {
                vlSelf->intv_phoenix__DOT__boot_cpu__DOT__PC_temp 
                    = vlSelf->intv_phoenix__DOT__boot_cpu__DOT__PC;
                vlSelf->intv_phoenix__DOT__boot_cpu__DOT__BI 
                    = (0xffU & (IData)(vlSelf->intv_phoenix__DOT__cpu_di));
                vlSelf->intv_phoenix__DOT__cpu_do = 
                    (0xffU & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__regfile));
                vlSelf->intv_phoenix__DOT__cpu_a = vlSelf->intv_phoenix__DOT__boot_cpu__DOT__PC;
                vlSelf->intv_phoenix__DOT__boot_cpu__DOT__AI 
                    = (0xffU & 0U);
            } else {
                vlSelf->intv_phoenix__DOT__boot_cpu__DOT__PC_temp 
                    = ((IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__res)
                        ? 0xfffcU : ((IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__NMI_edge)
                                      ? 0xfffaU : 0xfffeU));
                vlSelf->intv_phoenix__DOT__boot_cpu__DOT__BI 
                    = (0xffU & 0U);
                vlSelf->intv_phoenix__DOT__cpu_do = 
                    (0xffU & ((IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__NMI_edge)
                               ? (0xefU & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__P))
                               : (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__P)));
                vlSelf->intv_phoenix__DOT__cpu_a = 
                    (0x100U | (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__ADD));
                vlSelf->intv_phoenix__DOT__boot_cpu__DOT__AI 
                    = (0xffU & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__ADD));
            }
        } else {
            vlSelf->intv_phoenix__DOT__boot_cpu__DOT__PC_temp 
                = vlSelf->intv_phoenix__DOT__boot_cpu__DOT__PC;
            vlSelf->intv_phoenix__DOT__boot_cpu__DOT__BI 
                = (0xffU & 0U);
            if ((1U & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__state))) {
                vlSelf->intv_phoenix__DOT__cpu_do = 
                    (0xffU & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__PC));
                vlSelf->intv_phoenix__DOT__cpu_a = 
                    (0x100U | (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__ADD));
                vlSelf->intv_phoenix__DOT__boot_cpu__DOT__AI 
                    = (0xffU & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__ADD));
            } else {
                vlSelf->intv_phoenix__DOT__cpu_do = 
                    (0xffU & ((IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__PC) 
                              >> 8U));
                vlSelf->intv_phoenix__DOT__cpu_a = 
                    (0x100U | (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__regfile));
                vlSelf->intv_phoenix__DOT__boot_cpu__DOT__AI 
                    = (0xffU & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__regfile));
            }
        }
    } else {
        if ((4U & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__state))) {
            if ((2U & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__state))) {
                if ((1U & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__state))) {
                    vlSelf->intv_phoenix__DOT__boot_cpu__DOT__PC_temp 
                        = (((IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__ADD) 
                            << 8U) | (0xffU & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__PC)));
                    vlSelf->intv_phoenix__DOT__boot_cpu__DOT__BI 
                        = (0xffU & (IData)(vlSelf->intv_phoenix__DOT__cpu_di));
                    vlSelf->intv_phoenix__DOT__cpu_a 
                        = (((IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__ADD) 
                            << 8U) | (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__ABL));
                    vlSelf->intv_phoenix__DOT__boot_cpu__DOT__AI 
                        = (0xffU & 0U);
                } else {
                    vlSelf->intv_phoenix__DOT__boot_cpu__DOT__PC_temp 
                        = (((IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__ABH) 
                            << 8U) | (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__ADD));
                    vlSelf->intv_phoenix__DOT__boot_cpu__DOT__BI 
                        = (0xffU & 0U);
                    vlSelf->intv_phoenix__DOT__cpu_a 
                        = (((IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__ABH) 
                            << 8U) | (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__ADD));
                    vlSelf->intv_phoenix__DOT__boot_cpu__DOT__AI 
                        = (0xffU & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__ABH));
                }
            } else {
                vlSelf->intv_phoenix__DOT__boot_cpu__DOT__PC_temp 
                    = vlSelf->intv_phoenix__DOT__boot_cpu__DOT__PC;
                if ((1U & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__state))) {
                    vlSelf->intv_phoenix__DOT__boot_cpu__DOT__BI 
                        = (0xffU & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__PC));
                    vlSelf->intv_phoenix__DOT__cpu_a 
                        = vlSelf->intv_phoenix__DOT__boot_cpu__DOT__PC;
                    vlSelf->intv_phoenix__DOT__boot_cpu__DOT__AI 
                        = (0xffU & (IData)(vlSelf->intv_phoenix__DOT__cpu_di));
                } else {
                    vlSelf->intv_phoenix__DOT__boot_cpu__DOT__BI 
                        = (0xffU & (IData)(vlSelf->intv_phoenix__DOT__cpu_di));
                    vlSelf->intv_phoenix__DOT__cpu_a 
                        = (((IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__ADD) 
                            << 8U) | (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__ABL));
                    vlSelf->intv_phoenix__DOT__boot_cpu__DOT__AI 
                        = (0xffU & 0U);
                }
            }
        } else {
            vlSelf->intv_phoenix__DOT__boot_cpu__DOT__PC_temp 
                = vlSelf->intv_phoenix__DOT__boot_cpu__DOT__PC;
            if ((2U & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__state))) {
                vlSelf->intv_phoenix__DOT__boot_cpu__DOT__BI 
                    = (0xffU & (IData)(vlSelf->intv_phoenix__DOT__cpu_di));
                vlSelf->intv_phoenix__DOT__boot_cpu__DOT__AI 
                    = (0xffU & ((1U & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__state))
                                 ? 0U : (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__regfile)));
            } else {
                vlSelf->intv_phoenix__DOT__boot_cpu__DOT__BI 
                    = (0xffU & ((1U & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__state))
                                 ? 0U : (IData)(vlSelf->intv_phoenix__DOT__cpu_di)));
                vlSelf->intv_phoenix__DOT__boot_cpu__DOT__AI 
                    = (0xffU & 0U);
            }
            vlSelf->intv_phoenix__DOT__cpu_a = ((1U 
                                                 & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__state))
                                                 ? 
                                                (((IData)(vlSelf->intv_phoenix__DOT__cpu_di) 
                                                  << 8U) 
                                                 | (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__ADD))
                                                 : (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__PC));
        }
        vlSelf->intv_phoenix__DOT__cpu_do = (0xffU 
                                             & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__regfile));
    }
    vlSelf->intv_phoenix__DOT__io_wr = ((IData)(vlSelf->boot_mode) 
                                        & ((IData)(vlSelf->intv_phoenix__DOT__cpu_we) 
                                           & (0x5000U 
                                              == (0xff00U 
                                                  & (IData)(vlSelf->intv_phoenix__DOT__cpu_a)))));
    vlSelf->intv_phoenix__DOT__boot_cpu__DOT__ALU__DOT__temp_logic 
        = ((2U & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__alu_op))
            ? ((1U & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__alu_op))
                ? (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__AI)
                : ((IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__AI) 
                   ^ (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__BI)))
            : ((1U & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__alu_op))
                ? ((IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__AI) 
                   & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__BI))
                : ((IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__AI) 
                   | (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__BI))));
    if (vlSelf->intv_phoenix__DOT__boot_cpu__DOT__alu_shift_right) {
        vlSelf->intv_phoenix__DOT__boot_cpu__DOT__ALU__DOT__temp_logic 
            = ((0x100U & ((IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__AI) 
                          << 8U)) | (((IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__CI) 
                                      << 7U) | (0x7fU 
                                                & ((IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__AI) 
                                                   >> 1U))));
    }
    vlSelf->intv_phoenix__DOT__boot_cpu__DOT__ALU__DOT__temp_BI 
        = (0xffU & ((8U & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__alu_op))
                     ? ((4U & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__alu_op))
                         ? 0U : (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__ALU__DOT__temp_logic))
                     : ((4U & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__alu_op))
                         ? (~ (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__BI))
                         : (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__BI))));
    vlSelf->intv_phoenix__DOT__boot_cpu__DOT__ALU__DOT__temp_l 
        = (0x1fU & (((0xfU & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__ALU__DOT__temp_logic)) 
                     + (0xfU & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__ALU__DOT__temp_BI))) 
                    + ((~ ((IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__alu_shift_right) 
                           | (3U == (3U & ((IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__alu_op) 
                                           >> 2U))))) 
                       & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__CI))));
    vlSelf->intv_phoenix__DOT__boot_cpu__DOT__ALU__DOT__temp_HC 
        = (1U & (((IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__ALU__DOT__temp_l) 
                  >> 4U) | ((IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT____Vcellinp__ALU__BCD) 
                            & (5U <= (7U & ((IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__ALU__DOT__temp_l) 
                                            >> 1U))))));
    vlSelf->intv_phoenix__DOT__boot_cpu__DOT__ALU__DOT__temp_h 
        = (0x1fU & ((((IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__ALU__DOT__temp_logic) 
                      >> 4U) + (0xfU & ((IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__ALU__DOT__temp_BI) 
                                        >> 4U))) + (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__ALU__DOT__temp_HC)));
    vlSelf->intv_phoenix__DOT__boot_cpu__DOT__ALU__DOT__temp 
        = (((IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__ALU__DOT__temp_h) 
            << 4U) | (0xfU & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__ALU__DOT__temp_l)));
}

void Vintv_phoenix___024root___nba_sequent__TOP__0(Vintv_phoenix___024root* vlSelf);
void Vintv_phoenix___024root___nba_sequent__TOP__1(Vintv_phoenix___024root* vlSelf);
void Vintv_phoenix___024root___nba_sequent__TOP__2(Vintv_phoenix___024root* vlSelf);
void Vintv_phoenix___024root___nba_sequent__TOP__3(Vintv_phoenix___024root* vlSelf);
void Vintv_phoenix___024root___nba_sequent__TOP__4(Vintv_phoenix___024root* vlSelf);
void Vintv_phoenix___024root___nba_sequent__TOP__5(Vintv_phoenix___024root* vlSelf);
void Vintv_phoenix___024root___nba_sequent__TOP__6(Vintv_phoenix___024root* vlSelf);
void Vintv_phoenix___024root___nba_sequent__TOP__7(Vintv_phoenix___024root* vlSelf);
void Vintv_phoenix___024root___nba_sequent__TOP__8(Vintv_phoenix___024root* vlSelf);
void Vintv_phoenix___024root___nba_comb__TOP__0(Vintv_phoenix___024root* vlSelf);
void Vintv_phoenix___024root___nba_comb__TOP__1(Vintv_phoenix___024root* vlSelf);
void Vintv_phoenix___024root___nba_comb__TOP__2(Vintv_phoenix___024root* vlSelf);
void Vintv_phoenix___024root___nba_comb__TOP__3(Vintv_phoenix___024root* vlSelf);
void Vintv_phoenix___024root___nba_comb__TOP__4(Vintv_phoenix___024root* vlSelf);

void Vintv_phoenix___024root___eval_nba(Vintv_phoenix___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vintv_phoenix__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vintv_phoenix___024root___eval_nba\n"); );
    // Body
    if ((4ULL & vlSelf->__VnbaTriggered.word(0U))) {
        Vintv_phoenix___024root___nba_sequent__TOP__0(vlSelf);
        Vintv_phoenix___024root___nba_sequent__TOP__1(vlSelf);
    }
    if ((2ULL & vlSelf->__VnbaTriggered.word(0U))) {
        Vintv_phoenix___024root___nba_sequent__TOP__2(vlSelf);
    }
    if ((1ULL & vlSelf->__VnbaTriggered.word(0U))) {
        Vintv_phoenix___024root___nba_sequent__TOP__3(vlSelf);
    }
    if ((0x10ULL & vlSelf->__VnbaTriggered.word(0U))) {
        Vintv_phoenix___024root___nba_sequent__TOP__4(vlSelf);
    }
    if ((8ULL & vlSelf->__VnbaTriggered.word(0U))) {
        Vintv_phoenix___024root___nba_sequent__TOP__5(vlSelf);
    }
    if ((4ULL & vlSelf->__VnbaTriggered.word(0U))) {
        Vintv_phoenix___024root___nba_sequent__TOP__6(vlSelf);
        Vintv_phoenix___024root___nba_sequent__TOP__7(vlSelf);
        Vintv_phoenix___024root___nba_sequent__TOP__8(vlSelf);
    }
    if ((0xcULL & vlSelf->__VnbaTriggered.word(0U))) {
        Vintv_phoenix___024root___nba_comb__TOP__0(vlSelf);
        Vintv_phoenix___024root___nba_comb__TOP__1(vlSelf);
        Vintv_phoenix___024root___nba_comb__TOP__2(vlSelf);
        Vintv_phoenix___024root___nba_comb__TOP__3(vlSelf);
        Vintv_phoenix___024root___nba_comb__TOP__4(vlSelf);
        Vintv_phoenix___024root___nba_comb__TOP__5(vlSelf);
    }
    if ((0x10ULL & vlSelf->__VnbaTriggered.word(0U))) {
        Vintv_phoenix___024root___nba_sequent__TOP__9(vlSelf);
    }
    if ((0x14ULL & vlSelf->__VnbaTriggered.word(0U))) {
        Vintv_phoenix___024root___nba_comb__TOP__6(vlSelf);
    }
}

void Vintv_phoenix___024root___eval_triggers__ico(Vintv_phoenix___024root* vlSelf);
#ifdef VL_DEBUG
VL_ATTR_COLD void Vintv_phoenix___024root___dump_triggers__ico(Vintv_phoenix___024root* vlSelf);
#endif  // VL_DEBUG
void Vintv_phoenix___024root___eval_ico(Vintv_phoenix___024root* vlSelf);
void Vintv_phoenix___024root___eval_triggers__act(Vintv_phoenix___024root* vlSelf);
#ifdef VL_DEBUG
VL_ATTR_COLD void Vintv_phoenix___024root___dump_triggers__act(Vintv_phoenix___024root* vlSelf);
#endif  // VL_DEBUG
void Vintv_phoenix___024root___eval_act(Vintv_phoenix___024root* vlSelf);
#ifdef VL_DEBUG
VL_ATTR_COLD void Vintv_phoenix___024root___dump_triggers__nba(Vintv_phoenix___024root* vlSelf);
#endif  // VL_DEBUG

void Vintv_phoenix___024root___eval(Vintv_phoenix___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vintv_phoenix__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vintv_phoenix___024root___eval\n"); );
    // Init
    CData/*0:0*/ __VicoContinue;
    VlTriggerVec<5> __VpreTriggered;
    IData/*31:0*/ __VnbaIterCount;
    CData/*0:0*/ __VnbaContinue;
    // Body
    vlSelf->__VicoIterCount = 0U;
    __VicoContinue = 1U;
    while (__VicoContinue) {
        __VicoContinue = 0U;
        Vintv_phoenix___024root___eval_triggers__ico(vlSelf);
        if (vlSelf->__VicoTriggered.any()) {
            __VicoContinue = 1U;
            if (VL_UNLIKELY((0x64U < vlSelf->__VicoIterCount))) {
#ifdef VL_DEBUG
                Vintv_phoenix___024root___dump_triggers__ico(vlSelf);
#endif
                VL_FATAL_MT("../rtl/intv_phoenix.v", 53, "", "Input combinational region did not converge.");
            }
            vlSelf->__VicoIterCount = ((IData)(1U) 
                                       + vlSelf->__VicoIterCount);
            Vintv_phoenix___024root___eval_ico(vlSelf);
        }
    }
    __VnbaIterCount = 0U;
    __VnbaContinue = 1U;
    while (__VnbaContinue) {
        __VnbaContinue = 0U;
        vlSelf->__VnbaTriggered.clear();
        vlSelf->__VactIterCount = 0U;
        vlSelf->__VactContinue = 1U;
        while (vlSelf->__VactContinue) {
            vlSelf->__VactContinue = 0U;
            Vintv_phoenix___024root___eval_triggers__act(vlSelf);
            if (vlSelf->__VactTriggered.any()) {
                vlSelf->__VactContinue = 1U;
                if (VL_UNLIKELY((0x64U < vlSelf->__VactIterCount))) {
#ifdef VL_DEBUG
                    Vintv_phoenix___024root___dump_triggers__act(vlSelf);
#endif
                    VL_FATAL_MT("../rtl/intv_phoenix.v", 53, "", "Active region did not converge.");
                }
                vlSelf->__VactIterCount = ((IData)(1U) 
                                           + vlSelf->__VactIterCount);
                __VpreTriggered.andNot(vlSelf->__VactTriggered, vlSelf->__VnbaTriggered);
                vlSelf->__VnbaTriggered.thisOr(vlSelf->__VactTriggered);
                Vintv_phoenix___024root___eval_act(vlSelf);
            }
        }
        if (vlSelf->__VnbaTriggered.any()) {
            __VnbaContinue = 1U;
            if (VL_UNLIKELY((0x64U < __VnbaIterCount))) {
#ifdef VL_DEBUG
                Vintv_phoenix___024root___dump_triggers__nba(vlSelf);
#endif
                VL_FATAL_MT("../rtl/intv_phoenix.v", 53, "", "NBA region did not converge.");
            }
            __VnbaIterCount = ((IData)(1U) + __VnbaIterCount);
            Vintv_phoenix___024root___eval_nba(vlSelf);
        }
    }
}

#ifdef VL_DEBUG
void Vintv_phoenix___024root___eval_debug_assertions(Vintv_phoenix___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vintv_phoenix__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vintv_phoenix___024root___eval_debug_assertions\n"); );
    // Body
    if (VL_UNLIKELY((vlSelf->clk25 & 0xfeU))) {
        Verilated::overWidthError("clk25");}
    if (VL_UNLIKELY((vlSelf->clk_i & 0xfeU))) {
        Verilated::overWidthError("clk_i");}
    if (VL_UNLIKELY((vlSelf->clk_g & 0xfeU))) {
        Verilated::overWidthError("clk_g");}
    if (VL_UNLIKELY((vlSelf->reset & 0xfeU))) {
        Verilated::overWidthError("reset");}
    if (VL_UNLIKELY((vlSelf->game_reset & 0xfeU))) {
        Verilated::overWidthError("game_reset");}
    if (VL_UNLIKELY((vlSelf->cv1 & 0xfc00U))) {
        Verilated::overWidthError("cv1");}
    if (VL_UNLIKELY((vlSelf->cv2 & 0xfc00U))) {
        Verilated::overWidthError("cv2");}
    if (VL_UNLIKELY((vlSelf->snes & 0xf000U))) {
        Verilated::overWidthError("snes");}
    if (VL_UNLIKELY((vlSelf->kb_joy & 0xe0U))) {
        Verilated::overWidthError("kb_joy");}
    if (VL_UNLIKELY((vlSelf->kb_stb & 0xfeU))) {
        Verilated::overWidthError("kb_stb");}
    if (VL_UNLIKELY((vlSelf->sd_miso & 0xfeU))) {
        Verilated::overWidthError("sd_miso");}
    if (VL_UNLIKELY((vlSelf->sd_cd_n & 0xfeU))) {
        Verilated::overWidthError("sd_cd_n");}
}
#endif  // VL_DEBUG
