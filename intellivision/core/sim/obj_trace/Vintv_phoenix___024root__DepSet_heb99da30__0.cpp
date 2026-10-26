// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vintv_phoenix.h for the primary calling header

#include "verilated.h"

#include "Vintv_phoenix__Syms.h"
#include "Vintv_phoenix___024root.h"

extern const VlUnpacked<CData/*0:0*/, 512> Vintv_phoenix__ConstPool__TABLE_h141476a9_0;
extern const VlUnpacked<CData/*5:0*/, 512> Vintv_phoenix__ConstPool__TABLE_h33ea9740_0;

VL_INLINE_OPT void Vintv_phoenix___024root___ico_sequent__TOP__0(Vintv_phoenix___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vintv_phoenix__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vintv_phoenix___024root___ico_sequent__TOP__0\n"); );
    // Init
    SData/*8:0*/ __Vtableidx1;
    __Vtableidx1 = 0;
    // Body
    __Vtableidx1 = (((IData)(vlSelf->kb_byte) << 1U) 
                    | (IData)(vlSelf->intv_phoenix__DOT__kb_ext));
    vlSelf->intv_phoenix__DOT__kb_hit = Vintv_phoenix__ConstPool__TABLE_h141476a9_0
        [__Vtableidx1];
    vlSelf->intv_phoenix__DOT__kb_pos = Vintv_phoenix__ConstPool__TABLE_h33ea9740_0
        [__Vtableidx1];
    vlSelf->intv_phoenix__DOT__snes_pad = (((((((([&]() {
                                        vlSelf->__Vfunc_intv_phoenix__DOT__disc__0__right 
                                            = (1U & 
                                               ((IData)(vlSelf->snes) 
                                                >> 0xbU));
                                        vlSelf->__Vfunc_intv_phoenix__DOT__disc__0__left 
                                            = (1U & 
                                               ((IData)(vlSelf->snes) 
                                                >> 0xaU));
                                        vlSelf->__Vfunc_intv_phoenix__DOT__disc__0__down 
                                            = (1U & 
                                               ((IData)(vlSelf->snes) 
                                                >> 9U));
                                        vlSelf->__Vfunc_intv_phoenix__DOT__disc__0__up 
                                            = (1U & 
                                               ((IData)(vlSelf->snes) 
                                                >> 8U));
                                        vlSelf->__Vfunc_intv_phoenix__DOT__disc__0__Vfuncout 
                                            = ((IData)(vlSelf->__Vfunc_intv_phoenix__DOT__disc__0__up)
                                                ? ((IData)(vlSelf->__Vfunc_intv_phoenix__DOT__disc__0__down)
                                                    ? 
                                                   ((IData)(vlSelf->__Vfunc_intv_phoenix__DOT__disc__0__left)
                                                     ? 
                                                    ((IData)(vlSelf->__Vfunc_intv_phoenix__DOT__disc__0__right)
                                                      ? 0U
                                                      : 8U)
                                                     : 
                                                    ((IData)(vlSelf->__Vfunc_intv_phoenix__DOT__disc__0__right)
                                                      ? 2U
                                                      : 0U))
                                                    : 
                                                   ((IData)(vlSelf->__Vfunc_intv_phoenix__DOT__disc__0__left)
                                                     ? 
                                                    ((IData)(vlSelf->__Vfunc_intv_phoenix__DOT__disc__0__right)
                                                      ? 4U
                                                      : 0x1cU)
                                                     : 
                                                    ((IData)(vlSelf->__Vfunc_intv_phoenix__DOT__disc__0__right)
                                                      ? 0x16U
                                                      : 4U)))
                                                : ((IData)(vlSelf->__Vfunc_intv_phoenix__DOT__disc__0__down)
                                                    ? 
                                                   ((IData)(vlSelf->__Vfunc_intv_phoenix__DOT__disc__0__left)
                                                     ? 
                                                    ((IData)(vlSelf->__Vfunc_intv_phoenix__DOT__disc__0__right)
                                                      ? 1U
                                                      : 0x19U)
                                                     : 
                                                    ((IData)(vlSelf->__Vfunc_intv_phoenix__DOT__disc__0__right)
                                                      ? 0x13U
                                                      : 1U))
                                                    : 
                                                   ((IData)(vlSelf->__Vfunc_intv_phoenix__DOT__disc__0__left)
                                                     ? 
                                                    ((IData)(vlSelf->__Vfunc_intv_phoenix__DOT__disc__0__right)
                                                      ? 0U
                                                      : 8U)
                                                     : 
                                                    ((IData)(vlSelf->__Vfunc_intv_phoenix__DOT__disc__0__right)
                                                      ? 2U
                                                      : 0U))));
                                    }(), (IData)(vlSelf->__Vfunc_intv_phoenix__DOT__disc__0__Vfuncout)) 
                                                 | ((IData)(
                                                            (0U 
                                                             != 
                                                             (0xcU 
                                                              & (IData)(vlSelf->snes))))
                                                     ? 0xa0U
                                                     : 0U)) 
                                                | ((2U 
                                                    & (IData)(vlSelf->snes))
                                                    ? 0x60U
                                                    : 0U)) 
                                               | ((1U 
                                                   & (IData)(vlSelf->snes))
                                                   ? 0xc0U
                                                   : 0U)) 
                                              | ((0x10U 
                                                  & (IData)(vlSelf->snes))
                                                  ? 0x28U
                                                  : 0U)) 
                                             | ((0x20U 
                                                 & (IData)(vlSelf->snes))
                                                 ? 0x88U
                                                 : 0U)) 
                                            | ((0x40U 
                                                & (IData)(vlSelf->snes))
                                                ? 0x81U
                                                : 0U)) 
                                           | ((0x80U 
                                               & (IData)(vlSelf->snes))
                                               ? 0x41U
                                               : 0U));
    vlSelf->intv_phoenix__DOT__kb_pad = (((((((((((
                                                   ((([&]() {
                                                                vlSelf->__Vfunc_intv_phoenix__DOT__disc__1__right 
                                                                    = 
                                                                    (1U 
                                                                     & ((IData)(vlSelf->kb_joy) 
                                                                        >> 3U));
                                                                vlSelf->__Vfunc_intv_phoenix__DOT__disc__1__left 
                                                                    = 
                                                                    (1U 
                                                                     & ((IData)(vlSelf->kb_joy) 
                                                                        >> 2U));
                                                                vlSelf->__Vfunc_intv_phoenix__DOT__disc__1__down 
                                                                    = 
                                                                    (1U 
                                                                     & ((IData)(vlSelf->kb_joy) 
                                                                        >> 1U));
                                                                vlSelf->__Vfunc_intv_phoenix__DOT__disc__1__up 
                                                                    = 
                                                                    (1U 
                                                                     & (IData)(vlSelf->kb_joy));
                                                                vlSelf->__Vfunc_intv_phoenix__DOT__disc__1__Vfuncout 
                                                                    = 
                                                                    ((IData)(vlSelf->__Vfunc_intv_phoenix__DOT__disc__1__up)
                                                                      ? 
                                                                     ((IData)(vlSelf->__Vfunc_intv_phoenix__DOT__disc__1__down)
                                                                       ? 
                                                                      ((IData)(vlSelf->__Vfunc_intv_phoenix__DOT__disc__1__left)
                                                                        ? 
                                                                       ((IData)(vlSelf->__Vfunc_intv_phoenix__DOT__disc__1__right)
                                                                         ? 0U
                                                                         : 8U)
                                                                        : 
                                                                       ((IData)(vlSelf->__Vfunc_intv_phoenix__DOT__disc__1__right)
                                                                         ? 2U
                                                                         : 0U))
                                                                       : 
                                                                      ((IData)(vlSelf->__Vfunc_intv_phoenix__DOT__disc__1__left)
                                                                        ? 
                                                                       ((IData)(vlSelf->__Vfunc_intv_phoenix__DOT__disc__1__right)
                                                                         ? 4U
                                                                         : 0x1cU)
                                                                        : 
                                                                       ((IData)(vlSelf->__Vfunc_intv_phoenix__DOT__disc__1__right)
                                                                         ? 0x16U
                                                                         : 4U)))
                                                                      : 
                                                                     ((IData)(vlSelf->__Vfunc_intv_phoenix__DOT__disc__1__down)
                                                                       ? 
                                                                      ((IData)(vlSelf->__Vfunc_intv_phoenix__DOT__disc__1__left)
                                                                        ? 
                                                                       ((IData)(vlSelf->__Vfunc_intv_phoenix__DOT__disc__1__right)
                                                                         ? 1U
                                                                         : 0x19U)
                                                                        : 
                                                                       ((IData)(vlSelf->__Vfunc_intv_phoenix__DOT__disc__1__right)
                                                                         ? 0x13U
                                                                         : 1U))
                                                                       : 
                                                                      ((IData)(vlSelf->__Vfunc_intv_phoenix__DOT__disc__1__left)
                                                                        ? 
                                                                       ((IData)(vlSelf->__Vfunc_intv_phoenix__DOT__disc__1__right)
                                                                         ? 0U
                                                                         : 8U)
                                                                        : 
                                                                       ((IData)(vlSelf->__Vfunc_intv_phoenix__DOT__disc__1__right)
                                                                         ? 2U
                                                                         : 0U))));
                                                            }(), (IData)(vlSelf->__Vfunc_intv_phoenix__DOT__disc__1__Vfuncout)) 
                                                     | ([&]() {
                                                                vlSelf->__Vfunc_intv_phoenix__DOT__fires__2__r 
                                                                    = 
                                                                    (1U 
                                                                     & (IData)(vlSelf->kb_keys));
                                                                vlSelf->__Vfunc_intv_phoenix__DOT__fires__2__l 
                                                                    = 
                                                                    (1U 
                                                                     & ((IData)(vlSelf->kb_joy) 
                                                                        >> 4U));
                                                                vlSelf->__Vfunc_intv_phoenix__DOT__fires__2__Vfuncout 
                                                                    = 
                                                                    (((IData)(vlSelf->__Vfunc_intv_phoenix__DOT__fires__2__l) 
                                                                      & (IData)(vlSelf->__Vfunc_intv_phoenix__DOT__fires__2__r))
                                                                      ? 0xc0U
                                                                      : 
                                                                     ((IData)(vlSelf->__Vfunc_intv_phoenix__DOT__fires__2__l)
                                                                       ? 0xa0U
                                                                       : 
                                                                      ((IData)(vlSelf->__Vfunc_intv_phoenix__DOT__fires__2__r)
                                                                        ? 0x60U
                                                                        : 0U)));
                                                            }(), (IData)(vlSelf->__Vfunc_intv_phoenix__DOT__fires__2__Vfuncout))) 
                                                    | ((0x2000U 
                                                        & (IData)(vlSelf->kb_keys))
                                                        ? 0x81U
                                                        : 0U)) 
                                                   | ((0x80U 
                                                       & (IData)(vlSelf->kb_keys))
                                                       ? 0x41U
                                                       : 0U)) 
                                                  | ((0x1000U 
                                                      & (IData)(vlSelf->kb_keys))
                                                      ? 0x21U
                                                      : 0U)) 
                                                 | ((4U 
                                                     & (IData)(vlSelf->kb_keys))
                                                     ? 0x82U
                                                     : 0U)) 
                                                | ((8U 
                                                    & (IData)(vlSelf->kb_keys))
                                                    ? 0x42U
                                                    : 0U)) 
                                               | ((0x4000U 
                                                   & (IData)(vlSelf->kb_keys))
                                                   ? 0x22U
                                                   : 0U)) 
                                              | ((0x20U 
                                                  & (IData)(vlSelf->kb_keys))
                                                  ? 0x84U
                                                  : 0U)) 
                                             | ((2U 
                                                 & (IData)(vlSelf->kb_keys))
                                                 ? 0x44U
                                                 : 0U)) 
                                            | ((0x800U 
                                                & (IData)(vlSelf->kb_keys))
                                                ? 0x24U
                                                : 0U)) 
                                           | ((0x400U 
                                               & (IData)(vlSelf->kb_keys))
                                               ? 0x48U
                                               : 0U)) 
                                          | ((0x200U 
                                              & (IData)(vlSelf->kb_keys))
                                              ? 0x88U
                                              : 0U)) 
                                         | ((0x40U 
                                             & (IData)(vlSelf->kb_keys))
                                             ? 0x28U
                                             : 0U));
}

void Vintv_phoenix___024root___eval_ico(Vintv_phoenix___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vintv_phoenix__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vintv_phoenix___024root___eval_ico\n"); );
    // Body
    if ((1ULL & vlSelf->__VicoTriggered.word(0U))) {
        Vintv_phoenix___024root___ico_sequent__TOP__0(vlSelf);
    }
}

void Vintv_phoenix___024root___eval_act(Vintv_phoenix___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vintv_phoenix__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vintv_phoenix___024root___eval_act\n"); );
}

extern const VlUnpacked<CData/*0:0*/, 16384> Vintv_phoenix__ConstPool__TABLE_h76191c68_0;
extern const VlUnpacked<CData/*3:0*/, 16384> Vintv_phoenix__ConstPool__TABLE_h03b5aaa5_0;

VL_INLINE_OPT void Vintv_phoenix___024root___nba_sequent__TOP__0(Vintv_phoenix___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vintv_phoenix__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vintv_phoenix___024root___nba_sequent__TOP__0\n"); );
    // Init
    CData/*7:0*/ intv_phoenix__DOT__kb_cols;
    intv_phoenix__DOT__kb_cols = 0;
    CData/*0:0*/ intv_phoenix__DOT__intv__DOT__i_jlp__DOT___301_;
    intv_phoenix__DOT__intv__DOT__i_jlp__DOT___301_ = 0;
    CData/*0:0*/ intv_phoenix__DOT__intv__DOT__i_jlp__DOT___302_;
    intv_phoenix__DOT__intv__DOT__i_jlp__DOT___302_ = 0;
    CData/*0:0*/ intv_phoenix__DOT__intv__DOT__i_jlp__DOT___303_;
    intv_phoenix__DOT__intv__DOT__i_jlp__DOT___303_ = 0;
    CData/*0:0*/ intv_phoenix__DOT__intv__DOT__i_jlp__DOT___304_;
    intv_phoenix__DOT__intv__DOT__i_jlp__DOT___304_ = 0;
    IData/*31:0*/ __Vfunc_intv_phoenix__DOT__crc32_byte__13__Vfuncout;
    __Vfunc_intv_phoenix__DOT__crc32_byte__13__Vfuncout = 0;
    IData/*31:0*/ __Vfunc_intv_phoenix__DOT__crc32_byte__13__c;
    __Vfunc_intv_phoenix__DOT__crc32_byte__13__c = 0;
    CData/*7:0*/ __Vfunc_intv_phoenix__DOT__crc32_byte__13__d;
    __Vfunc_intv_phoenix__DOT__crc32_byte__13__d = 0;
    SData/*15:0*/ __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__a;
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__a = 0;
    VlWide<4>/*111:0*/ __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b;
    VL_ZERO_W(112, __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b);
    CData/*6:0*/ __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s;
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s = 0;
    SData/*15:0*/ __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__Vfuncout;
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__Vfuncout = 0;
    SData/*15:0*/ __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__a;
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__a = 0;
    VlWide<4>/*111:0*/ __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b;
    VL_ZERO_W(112, __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b);
    CData/*6:0*/ __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s;
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s = 0;
    SData/*15:0*/ __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031321__36__Vfuncout;
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031321__36__Vfuncout = 0;
    SData/*15:0*/ __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031321__36__a;
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031321__36__a = 0;
    QData/*47:0*/ __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031321__36__b;
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031321__36__b = 0;
    CData/*2:0*/ __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031321__36__s;
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031321__36__s = 0;
    CData/*0:0*/ __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031324__37__Vfuncout;
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031324__37__Vfuncout = 0;
    CData/*2:0*/ __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031324__37__b;
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031324__37__b = 0;
    CData/*2:0*/ __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031324__37__s;
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031324__37__s = 0;
    SData/*15:0*/ __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031325__38__Vfuncout;
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031325__38__Vfuncout = 0;
    SData/*15:0*/ __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031325__38__a;
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031325__38__a = 0;
    QData/*47:0*/ __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031325__38__b;
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031325__38__b = 0;
    CData/*2:0*/ __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031325__38__s;
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031325__38__s = 0;
    SData/*15:0*/ __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__Vfuncout;
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__Vfuncout = 0;
    SData/*15:0*/ __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__a;
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__a = 0;
    VlWide<4>/*111:0*/ __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b;
    VL_ZERO_W(112, __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b);
    CData/*6:0*/ __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s;
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s = 0;
    SData/*15:0*/ __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__Vfuncout;
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__Vfuncout = 0;
    SData/*15:0*/ __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__a;
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__a = 0;
    VlWide<4>/*111:0*/ __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b;
    VL_ZERO_W(112, __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b);
    CData/*6:0*/ __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s;
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s = 0;
    CData/*0:0*/ __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03236__75__Vfuncout;
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03236__75__Vfuncout = 0;
    CData/*7:0*/ __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03236__75__s;
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03236__75__s = 0;
    CData/*5:0*/ __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03277__76__Vfuncout;
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03277__76__Vfuncout = 0;
    CData/*0:0*/ __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03277__76__s;
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03277__76__s = 0;
    SData/*15:0*/ __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__Vfuncout;
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__Vfuncout = 0;
    SData/*15:0*/ __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__a;
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__a = 0;
    VlWide<4>/*111:0*/ __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b;
    VL_ZERO_W(112, __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b);
    CData/*6:0*/ __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s;
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s = 0;
    CData/*0:0*/ __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03855__96__Vfuncout;
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03855__96__Vfuncout = 0;
    CData/*0:0*/ __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03855__96__a;
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03855__96__a = 0;
    SData/*14:0*/ __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03855__96__b;
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03855__96__b = 0;
    SData/*14:0*/ __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03855__96__s;
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03855__96__s = 0;
    CData/*3:0*/ __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0312818__100__Vfuncout;
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0312818__100__Vfuncout = 0;
    CData/*3:0*/ __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0312818__100__a;
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0312818__100__a = 0;
    SData/*15:0*/ __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0312818__100__s;
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0312818__100__s = 0;
    CData/*0:0*/ __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__Vfuncout;
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__Vfuncout = 0;
    CData/*5:0*/ __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__b;
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__b = 0;
    CData/*5:0*/ __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__s;
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__s = 0;
    CData/*0:0*/ __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313735__107__Vfuncout;
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313735__107__Vfuncout = 0;
    CData/*5:0*/ __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313735__107__s;
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313735__107__s = 0;
    CData/*0:0*/ __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313743__109__Vfuncout;
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313743__109__Vfuncout = 0;
    CData/*5:0*/ __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313743__109__s;
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313743__109__s = 0;
    CData/*0:0*/ __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__Vfuncout;
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__Vfuncout = 0;
    CData/*5:0*/ __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__b;
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__b = 0;
    CData/*5:0*/ __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__s;
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__s = 0;
    CData/*0:0*/ __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__Vfuncout;
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__Vfuncout = 0;
    CData/*5:0*/ __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__b;
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__b = 0;
    CData/*5:0*/ __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__s;
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__s = 0;
    IData/*18:0*/ __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314697__159__Vfuncout;
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314697__159__Vfuncout = 0;
    QData/*56:0*/ __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314697__159__b;
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314697__159__b = 0;
    CData/*0:0*/ __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310004__252__Vfuncout;
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310004__252__Vfuncout = 0;
    CData/*4:0*/ __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310004__252__b;
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310004__252__b = 0;
    CData/*4:0*/ __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310004__252__s;
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310004__252__s = 0;
    SData/*8:0*/ __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310006__253__Vfuncout;
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310006__253__Vfuncout = 0;
    SData/*8:0*/ __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310006__253__a;
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310006__253__a = 0;
    QData/*44:0*/ __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310006__253__b;
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310006__253__b = 0;
    CData/*4:0*/ __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310006__253__s;
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310006__253__s = 0;
    SData/*8:0*/ __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310007__254__Vfuncout;
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310007__254__Vfuncout = 0;
    SData/*8:0*/ __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310007__254__a;
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310007__254__a = 0;
    QData/*44:0*/ __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310007__254__b;
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310007__254__b = 0;
    CData/*4:0*/ __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310007__254__s;
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310007__254__s = 0;
    CData/*1:0*/ __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310012__257__Vfuncout;
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310012__257__Vfuncout = 0;
    CData/*1:0*/ __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310012__257__a;
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310012__257__a = 0;
    SData/*9:0*/ __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310012__257__b;
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310012__257__b = 0;
    CData/*4:0*/ __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310012__257__s;
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310012__257__s = 0;
    CData/*3:0*/ __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__Vfuncout;
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__Vfuncout = 0;
    CData/*3:0*/ __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__a;
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__a = 0;
    IData/*27:0*/ __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b;
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b = 0;
    CData/*6:0*/ __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s;
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s = 0;
    CData/*3:0*/ __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__a;
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__a = 0;
    IData/*27:0*/ __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b;
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b = 0;
    CData/*6:0*/ __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s;
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s = 0;
    CData/*3:0*/ __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____035204__355__Vfuncout;
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____035204__355__Vfuncout = 0;
    SData/*9:0*/ __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____035204__355__s;
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____035204__355__s = 0;
    SData/*13:0*/ __Vtableidx8;
    __Vtableidx8 = 0;
    CData/*2:0*/ __Vdly__intv_phoenix__DOT__game_reset_s;
    __Vdly__intv_phoenix__DOT__game_reset_s = 0;
    CData/*7:0*/ __Vdly__intv_phoenix__DOT__intv_rst_cnt;
    __Vdly__intv_phoenix__DOT__intv_rst_cnt = 0;
    SData/*10:0*/ __Vdlyvdim0__intv_phoenix__DOT__ram0__v0;
    __Vdlyvdim0__intv_phoenix__DOT__ram0__v0 = 0;
    CData/*7:0*/ __Vdlyvval__intv_phoenix__DOT__ram0__v0;
    __Vdlyvval__intv_phoenix__DOT__ram0__v0 = 0;
    CData/*0:0*/ __Vdlyvset__intv_phoenix__DOT__ram0__v0;
    __Vdlyvset__intv_phoenix__DOT__ram0__v0 = 0;
    SData/*12:0*/ __Vdlyvdim0__intv_phoenix__DOT__ram6__v0;
    __Vdlyvdim0__intv_phoenix__DOT__ram6__v0 = 0;
    CData/*7:0*/ __Vdlyvval__intv_phoenix__DOT__ram6__v0;
    __Vdlyvval__intv_phoenix__DOT__ram6__v0 = 0;
    CData/*0:0*/ __Vdlyvset__intv_phoenix__DOT__ram6__v0;
    __Vdlyvset__intv_phoenix__DOT__ram6__v0 = 0;
    CData/*7:0*/ __Vdly__intv_phoenix__DOT__spi_tx;
    __Vdly__intv_phoenix__DOT__spi_tx = 0;
    CData/*0:0*/ __Vdly__intv_phoenix__DOT__spi_busy;
    __Vdly__intv_phoenix__DOT__spi_busy = 0;
    CData/*2:0*/ __Vdly__intv_phoenix__DOT__spi_bit;
    __Vdly__intv_phoenix__DOT__spi_bit = 0;
    CData/*0:0*/ __Vdly__intv_phoenix__DOT__spi_sclk_r;
    __Vdly__intv_phoenix__DOT__spi_sclk_r = 0;
    CData/*7:0*/ __Vdly__intv_phoenix__DOT__spi_rx;
    __Vdly__intv_phoenix__DOT__spi_rx = 0;
    CData/*0:0*/ __Vdly__intv_phoenix__DOT__spi_start;
    __Vdly__intv_phoenix__DOT__spi_start = 0;
    CData/*0:0*/ __Vdly__intv_phoenix__DOT__fwd_feed;
    __Vdly__intv_phoenix__DOT__fwd_feed = 0;
    CData/*0:0*/ __Vdly__intv_phoenix__DOT__fwd_feed_wait;
    __Vdly__intv_phoenix__DOT__fwd_feed_wait = 0;
    SData/*15:0*/ __Vdly__intv_phoenix__DOT__fwd_count;
    __Vdly__intv_phoenix__DOT__fwd_count = 0;
    CData/*0:0*/ __Vdly__intv_phoenix__DOT__fwd_active;
    __Vdly__intv_phoenix__DOT__fwd_active = 0;
    IData/*31:0*/ __Vdly__intv_phoenix__DOT__crc;
    __Vdly__intv_phoenix__DOT__crc = 0;
    IData/*18:0*/ __Vdly__intv_phoenix__DOT__ld_addr;
    __Vdly__intv_phoenix__DOT__ld_addr = 0;
    CData/*0:0*/ __Vdly__intv_phoenix__DOT__mem_ack;
    __Vdly__intv_phoenix__DOT__mem_ack = 0;
    CData/*0:0*/ __Vdly__intv_phoenix__DOT__ld_done;
    __Vdly__intv_phoenix__DOT__ld_done = 0;
    CData/*2:0*/ __Vdly__intv_phoenix__DOT__ms;
    __Vdly__intv_phoenix__DOT__ms = 0;
    CData/*2:0*/ __Vdlyvdim0__intv_phoenix__DOT__intv__DOT__i_cp1610__DOT__regs__v0;
    __Vdlyvdim0__intv_phoenix__DOT__intv__DOT__i_cp1610__DOT__regs__v0 = 0;
    SData/*15:0*/ __Vdlyvval__intv_phoenix__DOT__intv__DOT__i_cp1610__DOT__regs__v0;
    __Vdlyvval__intv_phoenix__DOT__intv__DOT__i_cp1610__DOT__regs__v0 = 0;
    CData/*0:0*/ __Vdlyvset__intv_phoenix__DOT__intv__DOT__i_cp1610__DOT__regs__v0;
    __Vdlyvset__intv_phoenix__DOT__intv__DOT__i_cp1610__DOT__regs__v0 = 0;
    CData/*3:0*/ __Vdlyvdim0__intv_phoenix__DOT__intv__DOT__i_ivoice__DOT__regs__v0;
    __Vdlyvdim0__intv_phoenix__DOT__intv__DOT__i_ivoice__DOT__regs__v0 = 0;
    CData/*7:0*/ __Vdlyvval__intv_phoenix__DOT__intv__DOT__i_ivoice__DOT__regs__v0;
    __Vdlyvval__intv_phoenix__DOT__intv__DOT__i_ivoice__DOT__regs__v0 = 0;
    CData/*0:0*/ __Vdlyvset__intv_phoenix__DOT__intv__DOT__i_ivoice__DOT__regs__v0;
    __Vdlyvset__intv_phoenix__DOT__intv__DOT__i_ivoice__DOT__regs__v0 = 0;
    CData/*3:0*/ __Vdlyvdim0__intv_phoenix__DOT__intv__DOT__i_jlp__DOT__shadow__v0;
    __Vdlyvdim0__intv_phoenix__DOT__intv__DOT__i_jlp__DOT__shadow__v0 = 0;
    SData/*15:0*/ __Vdlyvval__intv_phoenix__DOT__intv__DOT__i_jlp__DOT__shadow__v0;
    __Vdlyvval__intv_phoenix__DOT__intv__DOT__i_jlp__DOT__shadow__v0 = 0;
    CData/*0:0*/ __Vdlyvset__intv_phoenix__DOT__intv__DOT__i_jlp__DOT__shadow__v0;
    __Vdlyvset__intv_phoenix__DOT__intv__DOT__i_jlp__DOT__shadow__v0 = 0;
    SData/*10:0*/ __Vdlyvdim0__intv_phoenix__DOT__intv__DOT__i_stic__DOT__ecsram__v0;
    __Vdlyvdim0__intv_phoenix__DOT__intv__DOT__i_stic__DOT__ecsram__v0 = 0;
    CData/*7:0*/ __Vdlyvval__intv_phoenix__DOT__intv__DOT__i_stic__DOT__ecsram__v0;
    __Vdlyvval__intv_phoenix__DOT__intv__DOT__i_stic__DOT__ecsram__v0 = 0;
    CData/*0:0*/ __Vdlyvset__intv_phoenix__DOT__intv__DOT__i_stic__DOT__ecsram__v0;
    __Vdlyvset__intv_phoenix__DOT__intv__DOT__i_stic__DOT__ecsram__v0 = 0;
    SData/*8:0*/ __Vdlyvdim0__intv_phoenix__DOT__intv__DOT__i_stic__DOT__gram__v0;
    __Vdlyvdim0__intv_phoenix__DOT__intv__DOT__i_stic__DOT__gram__v0 = 0;
    CData/*7:0*/ __Vdlyvval__intv_phoenix__DOT__intv__DOT__i_stic__DOT__gram__v0;
    __Vdlyvval__intv_phoenix__DOT__intv__DOT__i_stic__DOT__gram__v0 = 0;
    CData/*0:0*/ __Vdlyvset__intv_phoenix__DOT__intv__DOT__i_stic__DOT__gram__v0;
    __Vdlyvset__intv_phoenix__DOT__intv__DOT__i_stic__DOT__gram__v0 = 0;
    CData/*7:0*/ __Vdlyvdim0__intv_phoenix__DOT__intv__DOT__i_stic__DOT__scram__v0;
    __Vdlyvdim0__intv_phoenix__DOT__intv__DOT__i_stic__DOT__scram__v0 = 0;
    CData/*7:0*/ __Vdlyvval__intv_phoenix__DOT__intv__DOT__i_stic__DOT__scram__v0;
    __Vdlyvval__intv_phoenix__DOT__intv__DOT__i_stic__DOT__scram__v0 = 0;
    CData/*0:0*/ __Vdlyvset__intv_phoenix__DOT__intv__DOT__i_stic__DOT__scram__v0;
    __Vdlyvset__intv_phoenix__DOT__intv__DOT__i_stic__DOT__scram__v0 = 0;
    SData/*8:0*/ __Vdlyvdim0__intv_phoenix__DOT__intv__DOT__i_stic__DOT__sysram__v0;
    __Vdlyvdim0__intv_phoenix__DOT__intv__DOT__i_stic__DOT__sysram__v0 = 0;
    SData/*15:0*/ __Vdlyvval__intv_phoenix__DOT__intv__DOT__i_stic__DOT__sysram__v0;
    __Vdlyvval__intv_phoenix__DOT__intv__DOT__i_stic__DOT__sysram__v0 = 0;
    CData/*0:0*/ __Vdlyvset__intv_phoenix__DOT__intv__DOT__i_stic__DOT__sysram__v0;
    __Vdlyvset__intv_phoenix__DOT__intv__DOT__i_stic__DOT__sysram__v0 = 0;
    CData/*1:0*/ __Vdlyvdim0__intv_phoenix__DOT__boot_cpu__DOT__AXYS__v0;
    __Vdlyvdim0__intv_phoenix__DOT__boot_cpu__DOT__AXYS__v0 = 0;
    CData/*7:0*/ __Vdlyvval__intv_phoenix__DOT__boot_cpu__DOT__AXYS__v0;
    __Vdlyvval__intv_phoenix__DOT__boot_cpu__DOT__AXYS__v0 = 0;
    CData/*0:0*/ __Vdlyvset__intv_phoenix__DOT__boot_cpu__DOT__AXYS__v0;
    __Vdlyvset__intv_phoenix__DOT__boot_cpu__DOT__AXYS__v0 = 0;
    // Body
    __Vdly__intv_phoenix__DOT__game_reset_s = vlSelf->intv_phoenix__DOT__game_reset_s;
    vlSelf->__Vdly__intv_phoenix__DOT__reset_s = vlSelf->intv_phoenix__DOT__reset_s;
    vlSelf->__Vdlyvset__intv_phoenix__DOT__text__v0 = 0U;
    __Vdlyvset__intv_phoenix__DOT__ram6__v0 = 0U;
    __Vdlyvset__intv_phoenix__DOT__ram0__v0 = 0U;
    __Vdly__intv_phoenix__DOT__ld_addr = vlSelf->intv_phoenix__DOT__ld_addr;
    vlSelf->__Vdlyvset__intv_phoenix__DOT__linebuf__v0 = 0U;
    __Vdlyvset__intv_phoenix__DOT__intv__DOT__i_ivoice__DOT__regs__v0 = 0U;
    __Vdly__intv_phoenix__DOT__crc = vlSelf->intv_phoenix__DOT__crc;
    __Vdly__intv_phoenix__DOT__fwd_active = vlSelf->intv_phoenix__DOT__fwd_active;
    __Vdly__intv_phoenix__DOT__fwd_count = vlSelf->intv_phoenix__DOT__fwd_count;
    __Vdly__intv_phoenix__DOT__fwd_feed = vlSelf->intv_phoenix__DOT__fwd_feed;
    __Vdly__intv_phoenix__DOT__spi_start = vlSelf->intv_phoenix__DOT__spi_start;
    __Vdly__intv_phoenix__DOT__fwd_feed_wait = vlSelf->intv_phoenix__DOT__fwd_feed_wait;
    __Vdly__intv_phoenix__DOT__spi_rx = vlSelf->intv_phoenix__DOT__spi_rx;
    __Vdly__intv_phoenix__DOT__spi_bit = vlSelf->intv_phoenix__DOT__spi_bit;
    __Vdly__intv_phoenix__DOT__spi_sclk_r = vlSelf->intv_phoenix__DOT__spi_sclk_r;
    __Vdly__intv_phoenix__DOT__spi_tx = vlSelf->intv_phoenix__DOT__spi_tx;
    __Vdly__intv_phoenix__DOT__spi_busy = vlSelf->intv_phoenix__DOT__spi_busy;
    if (VL_UNLIKELY((((~ (IData)(vlSelf->boot_mode)) 
                      & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT___67_)) 
                     & ((1U == (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___550_)) 
                        | (4U == (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___550_)))))) {
        VL_WRITEF("%s %04x\n",24,((1U == (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___550_))
                                   ? 0x424152U : 0x414452U),
                  16,(IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___549_));
    }
    __Vdlyvset__intv_phoenix__DOT__intv__DOT__i_cp1610__DOT__regs__v0 = 0U;
    __Vdly__intv_phoenix__DOT__ms = vlSelf->intv_phoenix__DOT__ms;
    __Vdly__intv_phoenix__DOT__ld_done = vlSelf->intv_phoenix__DOT__ld_done;
    __Vdly__intv_phoenix__DOT__mem_ack = vlSelf->intv_phoenix__DOT__mem_ack;
    __Vdly__intv_phoenix__DOT__intv_rst_cnt = vlSelf->intv_phoenix__DOT__intv_rst_cnt;
    __Vdlyvset__intv_phoenix__DOT__boot_cpu__DOT__AXYS__v0 = 0U;
    __Vdlyvset__intv_phoenix__DOT__intv__DOT__i_stic__DOT__sysram__v0 = 0U;
    __Vdlyvset__intv_phoenix__DOT__intv__DOT__i_stic__DOT__gram__v0 = 0U;
    __Vdlyvset__intv_phoenix__DOT__intv__DOT__i_stic__DOT__scram__v0 = 0U;
    __Vdlyvset__intv_phoenix__DOT__intv__DOT__i_stic__DOT__ecsram__v0 = 0U;
    __Vdlyvset__intv_phoenix__DOT__intv__DOT__i_jlp__DOT__shadow__v0 = 0U;
    __Vdly__intv_phoenix__DOT__game_reset_s = ((6U 
                                                & ((IData)(vlSelf->intv_phoenix__DOT__game_reset_s) 
                                                   << 1U)) 
                                               | (IData)(vlSelf->game_reset));
    vlSelf->intv_phoenix__DOT__spi_div = ((IData)(vlSelf->intv_phoenix__DOT__spi_tick)
                                           ? 0U : (0x7fU 
                                                   & ((IData)(1U) 
                                                      + (IData)(vlSelf->intv_phoenix__DOT__spi_div))));
    if (vlSelf->intv_phoenix__DOT__spi_start) {
        vlSelf->intv_phoenix__DOT__spi_div = 0U;
        __Vdly__intv_phoenix__DOT__spi_tx = vlSelf->intv_phoenix__DOT__spi_txd;
        __Vdly__intv_phoenix__DOT__spi_busy = 1U;
        __Vdly__intv_phoenix__DOT__spi_bit = 0U;
        __Vdly__intv_phoenix__DOT__spi_sclk_r = 0U;
    } else if (((IData)(vlSelf->intv_phoenix__DOT__spi_busy) 
                & (IData)(vlSelf->intv_phoenix__DOT__spi_tick))) {
        if (vlSelf->intv_phoenix__DOT__spi_sclk_r) {
            __Vdly__intv_phoenix__DOT__spi_tx = (1U 
                                                 | (0xfeU 
                                                    & ((IData)(vlSelf->intv_phoenix__DOT__spi_tx) 
                                                       << 1U)));
            __Vdly__intv_phoenix__DOT__spi_bit = (7U 
                                                  & ((IData)(1U) 
                                                     + (IData)(vlSelf->intv_phoenix__DOT__spi_bit)));
            __Vdly__intv_phoenix__DOT__spi_sclk_r = 0U;
            if ((7U == (IData)(vlSelf->intv_phoenix__DOT__spi_bit))) {
                __Vdly__intv_phoenix__DOT__spi_busy = 0U;
            }
        } else {
            __Vdly__intv_phoenix__DOT__spi_rx = ((0xfeU 
                                                  & ((IData)(vlSelf->intv_phoenix__DOT__spi_rx) 
                                                     << 1U)) 
                                                 | (IData)(vlSelf->sd_miso));
            __Vdly__intv_phoenix__DOT__spi_sclk_r = 1U;
        }
    }
    vlSelf->__Vdly__intv_phoenix__DOT__reset_s = ((6U 
                                                   & ((IData)(vlSelf->intv_phoenix__DOT__reset_s) 
                                                      << 1U)) 
                                                  | (IData)(vlSelf->reset));
    if (((IData)(vlSelf->intv_phoenix__DOT__cpu_we) 
         & (0x4000U == (0xfc00U & (IData)(vlSelf->intv_phoenix__DOT__cpu_a))))) {
        vlSelf->__Vdlyvval__intv_phoenix__DOT__text__v0 
            = vlSelf->intv_phoenix__DOT__cpu_do;
        vlSelf->__Vdlyvset__intv_phoenix__DOT__text__v0 = 1U;
        vlSelf->__Vdlyvdim0__intv_phoenix__DOT__text__v0 
            = (0x3ffU & (IData)(vlSelf->intv_phoenix__DOT__cpu_a));
    }
    if (((IData)(vlSelf->intv_phoenix__DOT__cpu_we) 
         & (0x6000U == (0xe000U & (IData)(vlSelf->intv_phoenix__DOT__cpu_a))))) {
        __Vdlyvval__intv_phoenix__DOT__ram6__v0 = vlSelf->intv_phoenix__DOT__cpu_do;
        __Vdlyvset__intv_phoenix__DOT__ram6__v0 = 1U;
        __Vdlyvdim0__intv_phoenix__DOT__ram6__v0 = 
            (0x1fffU & (IData)(vlSelf->intv_phoenix__DOT__cpu_a));
    }
    if (((IData)(vlSelf->intv_phoenix__DOT__cpu_we) 
         & (0U == (0xf800U & (IData)(vlSelf->intv_phoenix__DOT__cpu_a))))) {
        __Vdlyvval__intv_phoenix__DOT__ram0__v0 = vlSelf->intv_phoenix__DOT__cpu_do;
        __Vdlyvset__intv_phoenix__DOT__ram0__v0 = 1U;
        __Vdlyvdim0__intv_phoenix__DOT__ram0__v0 = 
            (0x7ffU & (IData)(vlSelf->intv_phoenix__DOT__cpu_a));
    }
    if ((((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3069_) 
          & (0xf0U > (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3081_))) 
         & (0x100U > (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3077_)))) {
        vlSelf->__Vdlyvval__intv_phoenix__DOT__linebuf__v0 
            = vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3073_;
        vlSelf->__Vdlyvset__intv_phoenix__DOT__linebuf__v0 = 1U;
        vlSelf->__Vdlyvdim0__intv_phoenix__DOT__linebuf__v0 
            = ((0x700U & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3081_) 
                          << 8U)) | (0xffU & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3077_)));
    }
    if (((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0821_) 
         & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0855_))) {
        __Vdlyvval__intv_phoenix__DOT__intv__DOT__i_ivoice__DOT__regs__v0 
            = vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0851_;
        __Vdlyvset__intv_phoenix__DOT__intv__DOT__i_ivoice__DOT__regs__v0 = 1U;
        __Vdlyvdim0__intv_phoenix__DOT__intv__DOT__i_ivoice__DOT__regs__v0 
            = vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0155_;
    }
    if (((IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__NMI_edge) 
         & (0xbU == (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__state)))) {
        vlSelf->intv_phoenix__DOT__boot_cpu__DOT__NMI_edge = 0U;
    }
    if (((~ (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___551_)) 
         & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT___68_) 
            & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___539_)))) {
        __Vdlyvval__intv_phoenix__DOT__intv__DOT__i_cp1610__DOT__regs__v0 
            = vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___538_;
        __Vdlyvset__intv_phoenix__DOT__intv__DOT__i_cp1610__DOT__regs__v0 = 1U;
        __Vdlyvdim0__intv_phoenix__DOT__intv__DOT__i_cp1610__DOT__regs__v0 
            = vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___537_;
    }
    if ((IData)((((((IData)(vlSelf->intv_phoenix__DOT__reset_s) 
                    >> 2U) | (IData)(vlSelf->intv_phoenix__DOT__start_game)) 
                  | (IData)(vlSelf->boot_mode)) | ((IData)(vlSelf->intv_phoenix__DOT__game_reset_s) 
                                                   >> 2U)))) {
        __Vdly__intv_phoenix__DOT__intv_rst_cnt = 0xffU;
    } else if ((0U != (IData)(vlSelf->intv_phoenix__DOT__intv_rst_cnt))) {
        __Vdly__intv_phoenix__DOT__intv_rst_cnt = (0xffU 
                                                   & ((IData)(vlSelf->intv_phoenix__DOT__intv_rst_cnt) 
                                                      - (IData)(1U)));
    }
    if (vlSelf->intv_phoenix__DOT__boot_cpu__DOT__write_register) {
        __Vdlyvval__intv_phoenix__DOT__boot_cpu__DOT__AXYS__v0 
            = ((0x1aU == (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__state))
                ? (IData)(vlSelf->intv_phoenix__DOT__cpu_di)
                : ((0xf0U & ((((IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__ADD) 
                               >> 4U) + ((IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__adj_bcd)
                                          ? ((IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__adc_bcd)
                                              ? ((IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__CO)
                                                  ? 6U
                                                  : 0U)
                                              : ((IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__CO)
                                                  ? 0U
                                                  : 0xaU))
                                          : 0U)) << 4U)) 
                   | (0xfU & ((IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__ADD) 
                              + ((IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__adj_bcd)
                                  ? ((IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__adc_bcd)
                                      ? ((IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__HC)
                                          ? 6U : 0U)
                                      : ((IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__HC)
                                          ? 0U : 0xaU))
                                  : 0U)))));
        __Vdlyvset__intv_phoenix__DOT__boot_cpu__DOT__AXYS__v0 = 1U;
        __Vdlyvdim0__intv_phoenix__DOT__boot_cpu__DOT__AXYS__v0 
            = vlSelf->intv_phoenix__DOT__boot_cpu__DOT__regsel;
    }
    if (vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2971_) {
        __Vdlyvval__intv_phoenix__DOT__intv__DOT__i_stic__DOT__sysram__v0 
            = vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___549_;
        __Vdlyvset__intv_phoenix__DOT__intv__DOT__i_stic__DOT__sysram__v0 = 1U;
        __Vdlyvdim0__intv_phoenix__DOT__intv__DOT__i_stic__DOT__sysram__v0 
            = (0x1ffU & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2991_));
    }
    if (vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2972_) {
        __Vdlyvval__intv_phoenix__DOT__intv__DOT__i_stic__DOT__gram__v0 
            = (0xffU & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___549_));
        __Vdlyvset__intv_phoenix__DOT__intv__DOT__i_stic__DOT__gram__v0 = 1U;
        __Vdlyvdim0__intv_phoenix__DOT__intv__DOT__i_stic__DOT__gram__v0 
            = (0x1ffU & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2991_));
    }
    if (vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2973_) {
        __Vdlyvval__intv_phoenix__DOT__intv__DOT__i_stic__DOT__scram__v0 
            = (0xffU & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___549_));
        __Vdlyvset__intv_phoenix__DOT__intv__DOT__i_stic__DOT__scram__v0 = 1U;
        __Vdlyvdim0__intv_phoenix__DOT__intv__DOT__i_stic__DOT__scram__v0 
            = (0xffU & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2991_));
    }
    if (vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2974_) {
        __Vdlyvval__intv_phoenix__DOT__intv__DOT__i_stic__DOT__ecsram__v0 
            = (0xffU & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___549_));
        __Vdlyvset__intv_phoenix__DOT__intv__DOT__i_stic__DOT__ecsram__v0 = 1U;
        __Vdlyvdim0__intv_phoenix__DOT__intv__DOT__i_stic__DOT__ecsram__v0 
            = (0x7ffU & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2991_));
    }
    if ((IData)(((0x9f80U == (0xfff0U & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2991_))) 
                 & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3060_)))) {
        __Vdlyvval__intv_phoenix__DOT__intv__DOT__i_jlp__DOT__shadow__v0 
            = vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3059_;
        __Vdlyvset__intv_phoenix__DOT__intv__DOT__i_jlp__DOT__shadow__v0 = 1U;
        __Vdlyvdim0__intv_phoenix__DOT__intv__DOT__i_jlp__DOT__shadow__v0 
            = (0xfU & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2991_));
    }
    vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2957_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2956_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_snd2__DOT___371_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_snd2__DOT___370_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_snd__DOT___371_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_snd__DOT___370_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3034_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3033_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_snd2__DOT___367_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_snd2__DOT___366_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_snd__DOT___367_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_snd__DOT___366_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0827_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0826_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0843_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0842_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0730_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0729_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___280_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___202_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___275_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___274_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0706_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0705_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0824_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0823_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2966_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2965_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3051_ = 1U;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___564_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___563_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___560_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___559_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_snd2__DOT___363_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_snd2__DOT___362_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_snd2__DOT___360_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_snd2__DOT___359_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_snd2__DOT___357_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_snd2__DOT___356_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_snd__DOT___363_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_snd__DOT___362_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_snd__DOT___360_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_snd__DOT___359_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_snd__DOT___357_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_snd__DOT___356_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_snd2__DOT___293_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_snd2__DOT___292_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_snd2__DOT___290_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_snd2__DOT___289_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_snd2__DOT___287_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_snd2__DOT___286_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_snd__DOT___293_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_snd__DOT___292_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_snd__DOT___290_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_snd__DOT___289_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_snd__DOT___287_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_snd__DOT___286_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___284_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___283_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___281_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___203_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_snd2__DOT___374_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_snd2__DOT___373_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_snd__DOT___374_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_snd__DOT___373_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___279_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___278_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0847_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0846_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_snd2__DOT___348_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_snd2__DOT___347_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_snd__DOT___348_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_snd__DOT___347_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___276_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___201_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0755_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0754_;
    vlSelf->intv_phoenix__DOT__boot_cpu__DOT__cond_code 
        = (7U & ((IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__IR) 
                 >> 5U));
    vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0722_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0721_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_snd2__DOT___354_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_snd2__DOT___353_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_snd__DOT___354_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_snd__DOT___353_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3058_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0267_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3018_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3017_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_snd2__DOT___351_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_snd2__DOT___350_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_snd__DOT___351_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_snd__DOT___350_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_cart__DOT___098_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_cart__DOT___097_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0719_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0718_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___262_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___261_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___256_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___255_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_snd2__DOT___333_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_snd2__DOT___332_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_snd__DOT___333_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_snd__DOT___332_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___222_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___221_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___219_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___218_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___290_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___289_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___287_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___286_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2988_ 
        = ((~ (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3310_)) 
           & ((3U != (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___550_)) 
              & (6U == (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___550_))));
    vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___228_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___227_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___225_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___224_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2999_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2998_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0716_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0715_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___259_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___258_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___241_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___240_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___594_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___593_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___580_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___579_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2987_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2986_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2984_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2983_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2981_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2980_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2978_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2977_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0831_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0830_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0885_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0884_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0839_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0838_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0814_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0813_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___272_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___271_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0863_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0862_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___1057_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0315168
        [(0x3fU & ((IData)(0x3fU) - (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0859_)))];
    vlSelf->intv_phoenix__DOT__intv__DOT__i_snd2__DOT___281_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_snd2__DOT___280_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_cart__DOT___092_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_cart__DOT___091_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___253_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___252_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2963_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2962_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_snd__DOT___281_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_snd__DOT___280_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_snd__DOT___278_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_snd__DOT___277_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0818_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0817_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___250_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___249_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___247_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___246_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3062_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0269_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0867_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0866_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_snd2__DOT___345_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_snd2__DOT___344_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_snd2__DOT___383_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_snd2__DOT___382_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3046_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3045_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_snd__DOT___345_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_snd__DOT___344_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0810_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0809_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___268_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___267_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_snd2__DOT___342_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_snd2__DOT___341_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_snd2__DOT___339_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_snd2__DOT___338_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_snd2__DOT___336_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_snd2__DOT___335_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_snd2__DOT___323_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_snd2__DOT___322_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_snd2__DOT___320_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_snd2__DOT___319_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_snd2__DOT___317_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_snd2__DOT___316_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_snd2__DOT___302_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_snd2__DOT___301_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_snd2__DOT___299_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_snd2__DOT___298_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_snd2__DOT___296_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_snd2__DOT___295_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_snd__DOT___342_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_snd__DOT___341_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_snd__DOT___339_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_snd__DOT___338_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_snd__DOT___336_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_snd__DOT___335_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_snd__DOT___323_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_snd__DOT___322_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_snd__DOT___320_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_snd__DOT___319_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_snd__DOT___317_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_snd__DOT___316_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_snd__DOT___302_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_snd__DOT___301_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_snd__DOT___299_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_snd__DOT___298_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_snd__DOT___296_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_snd__DOT___295_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___238_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___237_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3063_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0270_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___584_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___583_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___244_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___243_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2993_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0280_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_snd2__DOT___314_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_snd2__DOT___313_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_snd2__DOT___311_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_snd2__DOT___310_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_snd2__DOT___308_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_snd2__DOT___307_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_snd2__DOT___377_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_snd2__DOT___376_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_snd__DOT___314_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_snd__DOT___313_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_snd__DOT___311_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_snd__DOT___310_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_snd__DOT___308_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_snd__DOT___307_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_snd__DOT___377_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_snd__DOT___376_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___265_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___264_;
    vlSelf->intv_phoenix__DOT__ecs_keys_g = vlSelf->intv_phoenix__DOT__ecs_keys_m;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_snd2__DOT___278_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_snd2__DOT___277_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___234_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___233_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3011_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0321_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2996_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2995_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3024_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3023_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3021_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3020_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0740_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0739_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2992_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0315_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___215_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___214_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___212_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___211_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_cart__DOT___101_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_cart__DOT___100_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_cart__DOT___095_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_cart__DOT___094_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___209_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___208_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___206_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___205_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0744_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0743_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2960_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2959_;
    vlSelf->intv_phoenix__DOT__boot_cpu__DOT__PC = 
        (0xffffU & ((IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__PC_temp) 
                    + (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__PC_inc)));
    vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3015_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3014_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3057_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___549_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_snd2__DOT___329_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_snd2__DOT___328_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_snd__DOT___329_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_snd__DOT___328_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0835_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0834_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0807_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0806_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0799_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0798_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0791_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0790_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0783_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0782_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0775_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0774_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0767_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0766_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3061_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___549_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0748_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0747_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2954_ 
        = ((7U == (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___550_)) 
           & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT___67_));
    vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2989_ 
        = ((~ (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3310_)) 
           & (3U == (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___550_)));
    vlSelf->intv_phoenix__DOT__sel_q = ((0U == (0x1fU 
                                                & ((IData)(vlSelf->intv_phoenix__DOT__cpu_a) 
                                                   >> 0xbU)))
                                         ? 0U : ((3U 
                                                  == 
                                                  (7U 
                                                   & ((IData)(vlSelf->intv_phoenix__DOT__cpu_a) 
                                                      >> 0xdU)))
                                                  ? 1U
                                                  : 
                                                 ((0x50U 
                                                   == 
                                                   (0xffU 
                                                    & ((IData)(vlSelf->intv_phoenix__DOT__cpu_a) 
                                                       >> 8U)))
                                                   ? 2U
                                                   : 
                                                  ((0x8000U 
                                                    & (IData)(vlSelf->intv_phoenix__DOT__cpu_a))
                                                    ? 3U
                                                    : 4U))));
    vlSelf->intv_phoenix__DOT__rom_q = vlSelf->intv_phoenix__DOT__bootrom
        [(0x3fffU & (IData)(vlSelf->intv_phoenix__DOT__cpu_a))];
    vlSelf->intv_phoenix__DOT__ram6_q = vlSelf->intv_phoenix__DOT__ram6
        [(0x1fffU & (IData)(vlSelf->intv_phoenix__DOT__cpu_a))];
    vlSelf->intv_phoenix__DOT__ram0_q = vlSelf->intv_phoenix__DOT__ram0
        [(0x7ffU & (IData)(vlSelf->intv_phoenix__DOT__cpu_a))];
    vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3650_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310890
        [(0x7ffU & ((IData)(0x7ffU) - (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0741_)))];
    vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3657_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT__gram
        [(0x1ffU & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0741_))];
    vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0803_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0802_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0795_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0794_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0787_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0786_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0779_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0778_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0771_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0770_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0763_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0762_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2975_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0314_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0873_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0872_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0878_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0877_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0726_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0725_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0710_[0U] 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0709_[0U];
    vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0710_[1U] 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0709_[1U];
    vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0710_[2U] 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0709_[2U];
    vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0710_[3U] 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0709_[3U];
    vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0710_[4U] 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0709_[4U];
    vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0710_[5U] 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0709_[5U];
    vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0710_[6U] 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0709_[6U];
    vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0710_[7U] 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0709_[7U];
    vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0710_[8U] 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0709_[8U];
    vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0710_[9U] 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0709_[9U];
    vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0710_[0xaU] 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0709_[0xaU];
    vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0710_[0xbU] 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0709_[0xbU];
    vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0710_[0xcU] 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0709_[0xcU];
    vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0710_[0xdU] 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0709_[0xdU];
    vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0710_[0xeU] 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0709_[0xeU];
    vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0710_[0xfU] 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0709_[0xfU];
    vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0710_[0x10U] 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0709_[0x10U];
    vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0710_[0x11U] 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0709_[0x11U];
    vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0710_[0x12U] 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0709_[0x12U];
    vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0710_[0x13U] 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0709_[0x13U];
    vlSelf->intv_phoenix__DOT__intv__DOT___69_ = ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT___67_) 
                                                  & (0U 
                                                     == (IData)(vlSelf->intv_phoenix__DOT__intv__DOT___64_)));
    vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3049_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3048_;
    if (vlSelf->intv_phoenix__DOT____Vcellinp__boot_cpu__reset) {
        vlSelf->intv_phoenix__DOT__boot_cpu__DOT__IRHOLD_valid = 0U;
        vlSelf->intv_phoenix__DOT__boot_cpu__DOT__res = 1U;
    } else {
        if (((0x1eU == (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__state)) 
             | (0x21U == (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__state)))) {
            vlSelf->intv_phoenix__DOT__boot_cpu__DOT__IRHOLD_valid = 1U;
        } else if ((0xcU == (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__state))) {
            vlSelf->intv_phoenix__DOT__boot_cpu__DOT__IRHOLD_valid = 0U;
        }
        if ((0xcU == (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__state))) {
            vlSelf->intv_phoenix__DOT__boot_cpu__DOT__res = 0U;
        }
    }
    vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0751_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0750_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3054_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0265_;
    if ((((((0x21U != (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__state)) 
            & (0x22U != (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__state))) 
           & (0x1eU != (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__state))) 
          & (0x1fU != (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__state))) 
         & (0x20U != (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__state)))) {
        vlSelf->intv_phoenix__DOT__boot_cpu__DOT__ABL 
            = (0xffU & (IData)(vlSelf->intv_phoenix__DOT__cpu_a));
        vlSelf->intv_phoenix__DOT__boot_cpu__DOT__ABH 
            = (0xffU & ((IData)(vlSelf->intv_phoenix__DOT__cpu_a) 
                        >> 8U));
    }
    vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3056_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0266_;
    if ((1U & (~ (IData)(vlSelf->intv_phoenix__DOT____Vcellinp__boot_cpu__reset)))) {
        if (((0x1eU == (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__state)) 
             | (0x21U == (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__state)))) {
            vlSelf->intv_phoenix__DOT__boot_cpu__DOT__IRHOLD 
                = vlSelf->intv_phoenix__DOT__cpu_di;
        }
    }
    vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___231_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___230_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3053_ 
        = (0xffU & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___549_));
    vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3055_ 
        = (0xffU & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___549_));
    __Vtableidx8 = (((IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__IR) 
                     << 6U) | (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__state));
    if (Vintv_phoenix__ConstPool__TABLE_h76191c68_0
        [__Vtableidx8]) {
        vlSelf->intv_phoenix__DOT__boot_cpu__DOT__op 
            = Vintv_phoenix__ConstPool__TABLE_h03b5aaa5_0
            [__Vtableidx8];
    }
    vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___598_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___597_;
    vlSelf->intv_phoenix__DOT__io_q = (((((((((0U == 
                                               (0xffU 
                                                & (IData)(vlSelf->intv_phoenix__DOT__cpu_a))) 
                                              | (1U 
                                                 == 
                                                 (0xffU 
                                                  & (IData)(vlSelf->intv_phoenix__DOT__cpu_a)))) 
                                             | (0x10U 
                                                == 
                                                (0xffU 
                                                 & (IData)(vlSelf->intv_phoenix__DOT__cpu_a)))) 
                                            | (0x11U 
                                               == (0xffU 
                                                   & (IData)(vlSelf->intv_phoenix__DOT__cpu_a)))) 
                                           | (0x12U 
                                              == (0xffU 
                                                  & (IData)(vlSelf->intv_phoenix__DOT__cpu_a)))) 
                                          | (0x13U 
                                             == (0xffU 
                                                 & (IData)(vlSelf->intv_phoenix__DOT__cpu_a)))) 
                                         | (0x14U == 
                                            (0xffU 
                                             & (IData)(vlSelf->intv_phoenix__DOT__cpu_a)))) 
                                        | (0x15U == 
                                           (0xffU & (IData)(vlSelf->intv_phoenix__DOT__cpu_a))))
                                        ? (0xffU & 
                                           ((0U == 
                                             (0xffU 
                                              & (IData)(vlSelf->intv_phoenix__DOT__cpu_a)))
                                             ? (IData)(vlSelf->intv_phoenix__DOT__spi_rx)
                                             : ((1U 
                                                 == 
                                                 (0xffU 
                                                  & (IData)(vlSelf->intv_phoenix__DOT__cpu_a)))
                                                 ? 
                                                ((((((((IData)(vlSelf->intv_phoenix__DOT__spi_busy) 
                                                       | (IData)(vlSelf->intv_phoenix__DOT__spi_start)) 
                                                      | (IData)(vlSelf->intv_phoenix__DOT__fwd_active)) 
                                                     | (IData)(vlSelf->intv_phoenix__DOT__fwd_feed)) 
                                                    | (IData)(vlSelf->intv_phoenix__DOT__fwd_feed_wait)) 
                                                   | (IData)(vlSelf->intv_phoenix__DOT__ld_pend)) 
                                                  << 7U) 
                                                 | ((0x40U 
                                                     & ((~ (IData)(vlSelf->sd_cd_n)) 
                                                        << 6U)) 
                                                    | (0x20U 
                                                       & ((IData)(vlSelf->intv_phoenix__DOT__vblank_s) 
                                                          << 3U))))
                                                 : 
                                                ((0x10U 
                                                  == 
                                                  (0xffU 
                                                   & (IData)(vlSelf->intv_phoenix__DOT__cpu_a)))
                                                  ? (IData)(vlSelf->intv_phoenix__DOT__menu_g)
                                                  : 
                                                 ((0x11U 
                                                   == 
                                                   (0xffU 
                                                    & (IData)(vlSelf->intv_phoenix__DOT__cpu_a)))
                                                   ? 
                                                  (~ vlSelf->intv_phoenix__DOT__crc)
                                                   : 
                                                  ((0x12U 
                                                    == 
                                                    (0xffU 
                                                     & (IData)(vlSelf->intv_phoenix__DOT__cpu_a)))
                                                    ? 
                                                   (~ 
                                                    (vlSelf->intv_phoenix__DOT__crc 
                                                     >> 8U))
                                                    : 
                                                   ((0x13U 
                                                     == 
                                                     (0xffU 
                                                      & (IData)(vlSelf->intv_phoenix__DOT__cpu_a)))
                                                     ? 
                                                    (~ 
                                                     (vlSelf->intv_phoenix__DOT__crc 
                                                      >> 0x10U))
                                                     : 
                                                    ((0x14U 
                                                      == 
                                                      (0xffU 
                                                       & (IData)(vlSelf->intv_phoenix__DOT__cpu_a)))
                                                      ? 
                                                     (~ 
                                                      (vlSelf->intv_phoenix__DOT__crc 
                                                       >> 0x18U))
                                                      : (IData)(vlSelf->intv_phoenix__DOT__mkey_g)))))))))
                                        : 0xffU);
    vlSelf->intv_phoenix__DOT__vblank_s = ((6U & ((IData)(vlSelf->intv_phoenix__DOT__vblank_s) 
                                                  << 1U)) 
                                           | (0x1e0U 
                                              <= (IData)(vlSelf->intv_phoenix__DOT__vc)));
    vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3040_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3039_;
    __Vdly__intv_phoenix__DOT__mem_ack = 0U;
    __Vdly__intv_phoenix__DOT__ld_done = 0U;
    if ((4U & (IData)(vlSelf->intv_phoenix__DOT__ms))) {
        if ((2U & (IData)(vlSelf->intv_phoenix__DOT__ms))) {
            if ((1U & (IData)(vlSelf->intv_phoenix__DOT__ms))) {
                __Vdly__intv_phoenix__DOT__ms = 0U;
            } else {
                vlSelf->sram_doe = 0U;
                __Vdly__intv_phoenix__DOT__mem_ack 
                    = (1U & (~ (IData)(vlSelf->boot_mode)));
                __Vdly__intv_phoenix__DOT__ld_done 
                    = vlSelf->boot_mode;
                __Vdly__intv_phoenix__DOT__ms = 0U;
            }
        } else if ((1U & (IData)(vlSelf->intv_phoenix__DOT__ms))) {
            vlSelf->sram_we_n = 1U;
            __Vdly__intv_phoenix__DOT__ms = 6U;
        } else {
            __Vdly__intv_phoenix__DOT__ms = 5U;
        }
    } else if ((2U & (IData)(vlSelf->intv_phoenix__DOT__ms))) {
        if ((1U & (IData)(vlSelf->intv_phoenix__DOT__ms))) {
            vlSelf->sram_we_n = 0U;
            __Vdly__intv_phoenix__DOT__ms = 4U;
        } else {
            vlSelf->intv_phoenix__DOT__mem_rdata = vlSelf->sram_din;
            __Vdly__intv_phoenix__DOT__mem_ack = 1U;
            __Vdly__intv_phoenix__DOT__ms = 0U;
        }
    } else if ((1U & (IData)(vlSelf->intv_phoenix__DOT__ms))) {
        __Vdly__intv_phoenix__DOT__ms = 2U;
    } else {
        vlSelf->sram_we_n = 1U;
        vlSelf->sram_doe = 0U;
        vlSelf->sram_oe_n = 0U;
        if ((((IData)(vlSelf->intv_phoenix__DOT__m_req) 
              & (~ (IData)(vlSelf->intv_phoenix__DOT__mem_ack))) 
             & (~ (IData)(vlSelf->intv_phoenix__DOT__ld_done)))) {
            if (vlSelf->boot_mode) {
                vlSelf->sram_addr = vlSelf->intv_phoenix__DOT__ld_addr;
                vlSelf->sram_dout = vlSelf->intv_phoenix__DOT__ld_data;
            } else {
                vlSelf->sram_addr = vlSelf->intv_phoenix__DOT__intv__DOT__i_cart__DOT___109_;
                vlSelf->sram_dout = vlSelf->intv_phoenix__DOT__intv__DOT__i_cart__DOT___112_;
            }
            if (((IData)(vlSelf->boot_mode) | (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cart__DOT___106_))) {
                vlSelf->sram_doe = 1U;
                vlSelf->sram_oe_n = 1U;
                __Vdly__intv_phoenix__DOT__ms = 3U;
            } else {
                __Vdly__intv_phoenix__DOT__ms = 1U;
            }
        }
    }
    vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3002_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3001_;
    if (((IData)(vlSelf->intv_phoenix__DOT__ctl1_s) 
         == (IData)(vlSelf->intv_phoenix__DOT__ctl1_m))) {
        vlSelf->intv_phoenix__DOT__ctl1_g = vlSelf->intv_phoenix__DOT__ctl1_s;
    }
    vlSelf->intv_phoenix__DOT__ctl1_s = vlSelf->intv_phoenix__DOT__ctl1_m;
    if (((IData)(vlSelf->intv_phoenix__DOT__ctl2_s) 
         == (IData)(vlSelf->intv_phoenix__DOT__ctl2_m))) {
        vlSelf->intv_phoenix__DOT__ctl2_g = vlSelf->intv_phoenix__DOT__ctl2_s;
    }
    vlSelf->intv_phoenix__DOT__ctl2_s = vlSelf->intv_phoenix__DOT__ctl2_m;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3037_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3036_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3010_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0320_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3009_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0319_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___1058_ 
        = ((0x1c8U >= (0x1ffU & ((IData)(0x1c8U) - (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0735_))))
            ? vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0315171
           [(0x1ffU & ((IData)(0x1c8U) - (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0735_)))]
            : 0U);
    vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___1056_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0315165
        [(0x7ffU & ((IData)(0x7ffU) - (0xffffU & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0821_)
                                                   ? 
                                                  (vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0736_ 
                                                   >> 3U)
                                                   : 
                                                  ((IData)(1U) 
                                                   + 
                                                   (vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0736_ 
                                                    >> 3U))))))];
    vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3043_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3042_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3007_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0317_;
    if ((0xbU == (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__state))) {
        vlSelf->intv_phoenix__DOT__boot_cpu__DOT__I = 1U;
    } else if ((0x27U == (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__state))) {
        vlSelf->intv_phoenix__DOT__boot_cpu__DOT__I 
            = (1U & ((IData)(vlSelf->intv_phoenix__DOT__cpu_di) 
                     >> 2U));
    } else if ((0x24U == (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__state))) {
        if (vlSelf->intv_phoenix__DOT__boot_cpu__DOT__sei) {
            vlSelf->intv_phoenix__DOT__boot_cpu__DOT__I = 1U;
        }
        if (vlSelf->intv_phoenix__DOT__boot_cpu__DOT__cli) {
            vlSelf->intv_phoenix__DOT__boot_cpu__DOT__I = 0U;
        }
    } else if ((0xcU == (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__state))) {
        if (vlSelf->intv_phoenix__DOT__boot_cpu__DOT__plp) {
            vlSelf->intv_phoenix__DOT__boot_cpu__DOT__I 
                = (1U & ((IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__ADD) 
                         >> 2U));
        }
    }
    if ((1U & (~ (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___551_)))) {
        vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___648_ 
            = vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT__regs
            [vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___535_];
        vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___649_ 
            = vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT__regs
            [vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___536_];
    }
    vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___576_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___575_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0759_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0758_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2953_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2952_;
    if ((0x2eU == (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__state))) {
        vlSelf->intv_phoenix__DOT__boot_cpu__DOT__Z 
            = (1U & (~ (IData)((0U != (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__ADD)))));
        vlSelf->intv_phoenix__DOT__boot_cpu__DOT__N 
            = vlSelf->intv_phoenix__DOT__boot_cpu__DOT__AN;
    } else if ((0x27U == (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__state))) {
        vlSelf->intv_phoenix__DOT__boot_cpu__DOT__Z 
            = (1U & ((IData)(vlSelf->intv_phoenix__DOT__cpu_di) 
                     >> 1U));
        vlSelf->intv_phoenix__DOT__boot_cpu__DOT__N 
            = (1U & ((IData)(vlSelf->intv_phoenix__DOT__cpu_di) 
                     >> 7U));
    } else if ((0xcU == (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__state))) {
        if (vlSelf->intv_phoenix__DOT__boot_cpu__DOT__plp) {
            vlSelf->intv_phoenix__DOT__boot_cpu__DOT__Z 
                = (1U & ((IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__ADD) 
                         >> 1U));
            vlSelf->intv_phoenix__DOT__boot_cpu__DOT__N 
                = (1U & ((IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__ADD) 
                         >> 7U));
        } else {
            if (((((IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__load_reg) 
                   & (1U != (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__regsel))) 
                  | (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__compare)) 
                 | (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__bit_ins))) {
                vlSelf->intv_phoenix__DOT__boot_cpu__DOT__Z 
                    = (1U & (~ (IData)((0U != (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__ADD)))));
            }
            if ((((IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__load_reg) 
                  & (1U != (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__regsel))) 
                 | (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__compare))) {
                vlSelf->intv_phoenix__DOT__boot_cpu__DOT__N 
                    = vlSelf->intv_phoenix__DOT__boot_cpu__DOT__AN;
            }
        }
    } else if (((0xdU == (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__state)) 
                & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__bit_ins))) {
        vlSelf->intv_phoenix__DOT__boot_cpu__DOT__N 
            = (1U & ((IData)(vlSelf->intv_phoenix__DOT__cpu_di) 
                     >> 7U));
    }
    vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2950_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2949_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3660_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT__sysram
        [(0x1ffU & (VL_DIVS_III(32, ((((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2947_) 
                                       - (IData)(8U)) 
                                      - (IData)(6U)) 
                                     - (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3006_)), (IData)(8U)) 
                    + VL_MULS_III(32, (IData)(0x14U), 
                                  VL_DIVS_III(32, vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0902_, (IData)(8U)))))];
    if (((IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__shift) 
         & (0x2eU == (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__state)))) {
        vlSelf->intv_phoenix__DOT__boot_cpu__DOT__C 
            = vlSelf->intv_phoenix__DOT__boot_cpu__DOT__CO;
    } else if ((0x27U == (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__state))) {
        vlSelf->intv_phoenix__DOT__boot_cpu__DOT__C 
            = (1U & (IData)(vlSelf->intv_phoenix__DOT__cpu_di));
    } else if (((~ (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__write_back)) 
                & (0xcU == (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__state)))) {
        if ((((IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__adc_sbc) 
              | (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__shift)) 
             | (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__compare))) {
            vlSelf->intv_phoenix__DOT__boot_cpu__DOT__C 
                = vlSelf->intv_phoenix__DOT__boot_cpu__DOT__CO;
        } else if (vlSelf->intv_phoenix__DOT__boot_cpu__DOT__plp) {
            vlSelf->intv_phoenix__DOT__boot_cpu__DOT__C 
                = (1U & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__ADD));
        } else {
            if (vlSelf->intv_phoenix__DOT__boot_cpu__DOT__sec) {
                vlSelf->intv_phoenix__DOT__boot_cpu__DOT__C = 1U;
            }
            if (vlSelf->intv_phoenix__DOT__boot_cpu__DOT__clc) {
                vlSelf->intv_phoenix__DOT__boot_cpu__DOT__C = 0U;
            }
        }
    }
    if ((0xcU == (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__state))) {
        vlSelf->intv_phoenix__DOT__boot_cpu__DOT__php 
            = (8U == (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__IR));
        vlSelf->intv_phoenix__DOT__boot_cpu__DOT__shift_right 
            = (0x42U == (0xc3U & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__IR)));
        vlSelf->intv_phoenix__DOT__boot_cpu__DOT__rotate 
            = ((0x2aU == (0xafU & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__IR))) 
               | (0x26U == (0xa7U & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__IR))));
        vlSelf->intv_phoenix__DOT__boot_cpu__DOT__inc 
            = ((0xe6U == (0xe7U & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__IR))) 
               | (0xc8U == (0xdfU & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__IR))));
        vlSelf->intv_phoenix__DOT__boot_cpu__DOT__index_y 
            = (((0x11U == (0x1fU & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__IR))) 
                | (0x96U == (0xd7U & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__IR)))) 
               | (9U == (0xfU & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__IR))));
        vlSelf->intv_phoenix__DOT__boot_cpu__DOT__src_reg 
            = ((0xbaU == (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__IR))
                ? 1U : (((((0x86U == (0xe7U & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__IR))) 
                           | (0x8aU == (0xebU & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__IR)))) 
                          | (0xe0U == (0xf3U & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__IR)))) 
                         | (0xcaU == (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__IR)))
                         ? 2U : (((((0x84U == (0xe7U 
                                               & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__IR))) 
                                    | (0x98U == (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__IR))) 
                                   | (0xc0U == (0xf3U 
                                                & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__IR)))) 
                                  | (0x88U == (0xbfU 
                                               & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__IR))))
                                  ? 3U : 0U)));
        vlSelf->intv_phoenix__DOT__boot_cpu__DOT__dst_reg 
            = ((((0xe8U == (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__IR)) 
                 | (0xcaU == (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__IR))) 
                | (0xa2U == (0xe3U & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__IR))))
                ? 2U : (((8U == (0xbfU & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__IR))) 
                         | (0x9aU == (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__IR)))
                         ? 1U : ((((0x88U == (0xbfU 
                                              & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__IR))) 
                                   | (0xa4U == (0xe7U 
                                                & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__IR)))) 
                                  | (0xa0U == (0xf7U 
                                               & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__IR))))
                                  ? 3U : 0U)));
        vlSelf->intv_phoenix__DOT__boot_cpu__DOT__load_only 
            = (0xa0U == (0xe0U & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__IR)));
        vlSelf->intv_phoenix__DOT__boot_cpu__DOT__sei 
            = (0x78U == (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__IR));
        vlSelf->intv_phoenix__DOT__boot_cpu__DOT__cli 
            = (0x58U == (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__IR));
        vlSelf->intv_phoenix__DOT__boot_cpu__DOT__load_reg 
            = (((((((((0xaU == (0x9fU & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__IR))) 
                      | (1U == (0x83U & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__IR)))) 
                     | (0x88U == (0xedU & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__IR)))) 
                    | (0xa0U == (0xf1U & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__IR)))) 
                   | (0xbaU == (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__IR))) 
                  | (0xb4U == (0xf5U & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__IR)))) 
                 | (0xcaU == (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__IR))) 
                | (0xa1U == (0xa3U & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__IR)))) 
               | (8U == (0x1fU & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__IR))));
    }
    if ((0x27U == (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__state))) {
        vlSelf->intv_phoenix__DOT__boot_cpu__DOT__V 
            = (1U & ((IData)(vlSelf->intv_phoenix__DOT__cpu_di) 
                     >> 6U));
    } else if ((0xcU == (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__state))) {
        if (vlSelf->intv_phoenix__DOT__boot_cpu__DOT__adc_sbc) {
            vlSelf->intv_phoenix__DOT__boot_cpu__DOT__V 
                = ((IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__ALU__DOT__AI7) 
                   ^ ((IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__ALU__DOT__BI7) 
                      ^ ((IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__AN) 
                         ^ (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__CO))));
        }
        if (vlSelf->intv_phoenix__DOT__boot_cpu__DOT__clv) {
            vlSelf->intv_phoenix__DOT__boot_cpu__DOT__V = 0U;
        }
        if (vlSelf->intv_phoenix__DOT__boot_cpu__DOT__plp) {
            vlSelf->intv_phoenix__DOT__boot_cpu__DOT__V 
                = (1U & ((IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__ADD) 
                         >> 6U));
        }
    } else if (((0xdU == (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__state)) 
                & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__bit_ins))) {
        vlSelf->intv_phoenix__DOT__boot_cpu__DOT__V 
            = (1U & ((IData)(vlSelf->intv_phoenix__DOT__cpu_di) 
                     >> 6U));
    }
    if ((0xcU == (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__state))) {
        vlSelf->intv_phoenix__DOT__boot_cpu__DOT__clv 
            = (0xb8U == (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__IR));
        vlSelf->intv_phoenix__DOT__boot_cpu__DOT__bit_ins 
            = (0x24U == (0xf7U & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__IR)));
        vlSelf->intv_phoenix__DOT__boot_cpu__DOT__sec 
            = (0x38U == (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__IR));
        vlSelf->intv_phoenix__DOT__boot_cpu__DOT__clc 
            = (0x18U == (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__IR));
        vlSelf->intv_phoenix__DOT__boot_cpu__DOT__shift 
            = ((6U == (0x87U & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__IR))) 
               | (0xaU == (0x8fU & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__IR))));
        vlSelf->intv_phoenix__DOT__boot_cpu__DOT__compare 
            = (((0xc0U == (0xdbU & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__IR))) 
                | (0xccU == (0xdfU & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__IR)))) 
               | (0xc1U == (0xe3U & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__IR))));
    }
    vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___572_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___571_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3050_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0312_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___1059_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0315177
        [(0x7fU & ((IData)(0x7fU) - ((0x80U & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___1060_))
                                      ? (- (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___1060_))
                                      : (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___1060_))))];
    vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2969_ 
        = (VL_LTES_III(32, 8U, (0x3fffU & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2991_))) 
           & (VL_LTES_III(32, 0x10U, (0x3fffU & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2991_))) 
              & (VL_GTS_III(32, 0x18U, (0x3fffU & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2991_))) 
                 & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3350_))));
    vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2968_ 
        = (VL_LTES_III(32, 8U, (0x3fffU & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2991_))) 
           & (VL_GTS_III(32, 0x10U, (0x3fffU & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2991_))) 
              & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3350_)));
    vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2967_ 
        = (VL_GTS_III(32, 8U, (0x3fffU & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2991_))) 
           & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3350_));
    vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3651_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310895
        [(0xfffU & ((IData)(0xfffU) - (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2991_)))];
    vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3649_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310890
        [(0x7ffU & ((IData)(0x7ffU) - (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2991_)))];
    vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3658_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT__scram
        [(0xffU & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2991_))];
    vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3655_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT__ecsram
        [(0x7ffU & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2991_))];
    vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___362_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT__shadow
        [(0xfU & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2991_))];
    vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3659_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT__sysram
        [(0x1ffU & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2991_))];
    vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3656_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT__gram
        [(0x1ffU & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2991_))];
    vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3654_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310908
        [(0xfffU & ((IData)(0xfffU) - (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2991_)))];
    vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3653_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310905
        [(0xfffU & ((IData)(0xfffU) - (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2991_)))];
    vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3652_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310902
        [(0xfffU & ((IData)(0xfffU) - (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2991_)))];
    vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3008_ 
        = ((~ (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___551_)) 
           & (VL_GTS_III(32, 8U, (0x3fffU & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2991_)))
               ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3319_)
               : (VL_GTS_III(32, 0x10U, (0x3fffU & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2991_)))
                   ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3319_)
                   : (VL_GTS_III(32, 0x18U, (0x3fffU 
                                             & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2991_)))
                       ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3319_)
                       : (VL_GTS_III(32, 0x20U, (0x3fffU 
                                                 & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2991_)))
                           ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3319_)
                           : (((0x20U == (0x3fffU & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2991_))) 
                               & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3350_)) 
                              | (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3319_)))))));
    vlSelf->intv_phoenix__DOT__spi_bit = __Vdly__intv_phoenix__DOT__spi_bit;
    if ((4U & (IData)(vlSelf->intv_phoenix__DOT__reset_s))) {
        __Vdly__intv_phoenix__DOT__spi_busy = 0U;
        __Vdly__intv_phoenix__DOT__spi_sclk_r = 0U;
        __Vdly__intv_phoenix__DOT__spi_tx = 0xffU;
    }
    vlSelf->intv_phoenix__DOT__spi_tx = __Vdly__intv_phoenix__DOT__spi_tx;
    vlSelf->intv_phoenix__DOT__spi_sclk_r = __Vdly__intv_phoenix__DOT__spi_sclk_r;
    vlSelf->intv_phoenix__DOT__game_reset_s = __Vdly__intv_phoenix__DOT__game_reset_s;
    vlSelf->intv_phoenix__DOT__intv_rst_cnt = __Vdly__intv_phoenix__DOT__intv_rst_cnt;
    if (__Vdlyvset__intv_phoenix__DOT__boot_cpu__DOT__AXYS__v0) {
        vlSelf->intv_phoenix__DOT__boot_cpu__DOT__AXYS[__Vdlyvdim0__intv_phoenix__DOT__boot_cpu__DOT__AXYS__v0] 
            = __Vdlyvval__intv_phoenix__DOT__boot_cpu__DOT__AXYS__v0;
    }
    if (__Vdlyvset__intv_phoenix__DOT__ram6__v0) {
        vlSelf->intv_phoenix__DOT__ram6[__Vdlyvdim0__intv_phoenix__DOT__ram6__v0] 
            = __Vdlyvval__intv_phoenix__DOT__ram6__v0;
    }
    if (__Vdlyvset__intv_phoenix__DOT__ram0__v0) {
        vlSelf->intv_phoenix__DOT__ram0[__Vdlyvdim0__intv_phoenix__DOT__ram0__v0] 
            = __Vdlyvval__intv_phoenix__DOT__ram0__v0;
    }
    vlSelf->intv_phoenix__DOT__ms = __Vdly__intv_phoenix__DOT__ms;
    if (vlSelf->intv_phoenix__DOT__io_wr) {
        if ((1U & (~ ((IData)(vlSelf->intv_phoenix__DOT__cpu_a) 
                      >> 7U)))) {
            if ((1U & (~ ((IData)(vlSelf->intv_phoenix__DOT__cpu_a) 
                          >> 6U)))) {
                if ((1U & (~ ((IData)(vlSelf->intv_phoenix__DOT__cpu_a) 
                              >> 5U)))) {
                    if ((1U & (~ ((IData)(vlSelf->intv_phoenix__DOT__cpu_a) 
                                  >> 4U)))) {
                        if ((8U & (IData)(vlSelf->intv_phoenix__DOT__cpu_a))) {
                            if ((1U & (~ ((IData)(vlSelf->intv_phoenix__DOT__cpu_a) 
                                          >> 2U)))) {
                                if ((2U & (IData)(vlSelf->intv_phoenix__DOT__cpu_a))) {
                                    if ((1U & (~ (IData)(vlSelf->intv_phoenix__DOT__cpu_a)))) {
                                        __Vdly__intv_phoenix__DOT__ld_addr 
                                            = ((0xffffU 
                                                & __Vdly__intv_phoenix__DOT__ld_addr) 
                                               | (0x70000U 
                                                  & ((IData)(vlSelf->intv_phoenix__DOT__cpu_do) 
                                                     << 0x10U)));
                                    }
                                } else {
                                    __Vdly__intv_phoenix__DOT__ld_addr 
                                        = ((1U & (IData)(vlSelf->intv_phoenix__DOT__cpu_a))
                                            ? ((0x700ffU 
                                                & __Vdly__intv_phoenix__DOT__ld_addr) 
                                               | ((IData)(vlSelf->intv_phoenix__DOT__cpu_do) 
                                                  << 8U))
                                            : ((0x7ff00U 
                                                & __Vdly__intv_phoenix__DOT__ld_addr) 
                                               | (IData)(vlSelf->intv_phoenix__DOT__cpu_do)));
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    if (vlSelf->intv_phoenix__DOT__ld_done) {
        __Vdly__intv_phoenix__DOT__ld_addr = (0x7ffffU 
                                              & ((IData)(1U) 
                                                 + vlSelf->intv_phoenix__DOT__ld_addr));
    }
    vlSelf->intv_phoenix__DOT__ld_addr = __Vdly__intv_phoenix__DOT__ld_addr;
    vlSelf->intv_phoenix__DOT__mem_ack = __Vdly__intv_phoenix__DOT__mem_ack;
    if (__Vdlyvset__intv_phoenix__DOT__intv__DOT__i_stic__DOT__scram__v0) {
        vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT__scram[__Vdlyvdim0__intv_phoenix__DOT__intv__DOT__i_stic__DOT__scram__v0] 
            = __Vdlyvval__intv_phoenix__DOT__intv__DOT__i_stic__DOT__scram__v0;
    }
    if (__Vdlyvset__intv_phoenix__DOT__intv__DOT__i_stic__DOT__ecsram__v0) {
        vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT__ecsram[__Vdlyvdim0__intv_phoenix__DOT__intv__DOT__i_stic__DOT__ecsram__v0] 
            = __Vdlyvval__intv_phoenix__DOT__intv__DOT__i_stic__DOT__ecsram__v0;
    }
    if (__Vdlyvset__intv_phoenix__DOT__intv__DOT__i_jlp__DOT__shadow__v0) {
        vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT__shadow[__Vdlyvdim0__intv_phoenix__DOT__intv__DOT__i_jlp__DOT__shadow__v0] 
            = __Vdlyvval__intv_phoenix__DOT__intv__DOT__i_jlp__DOT__shadow__v0;
    }
    if (__Vdlyvset__intv_phoenix__DOT__intv__DOT__i_stic__DOT__sysram__v0) {
        vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT__sysram[__Vdlyvdim0__intv_phoenix__DOT__intv__DOT__i_stic__DOT__sysram__v0] 
            = __Vdlyvval__intv_phoenix__DOT__intv__DOT__i_stic__DOT__sysram__v0;
    }
    if (__Vdlyvset__intv_phoenix__DOT__intv__DOT__i_stic__DOT__gram__v0) {
        vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT__gram[__Vdlyvdim0__intv_phoenix__DOT__intv__DOT__i_stic__DOT__gram__v0] 
            = __Vdlyvval__intv_phoenix__DOT__intv__DOT__i_stic__DOT__gram__v0;
    }
    if (__Vdlyvset__intv_phoenix__DOT__intv__DOT__i_cp1610__DOT__regs__v0) {
        vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT__regs[__Vdlyvdim0__intv_phoenix__DOT__intv__DOT__i_cp1610__DOT__regs__v0] 
            = __Vdlyvval__intv_phoenix__DOT__intv__DOT__i_cp1610__DOT__regs__v0;
    }
    vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3069_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3068_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3081_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3080_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3077_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3076_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3073_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3072_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0855_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0854_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0851_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0850_;
    vlSelf->sd_mosi = (1U & ((IData)(vlSelf->intv_phoenix__DOT__spi_tx) 
                             >> 7U));
    vlSelf->sd_sclk = vlSelf->intv_phoenix__DOT__spi_sclk_r;
    __Vdly__intv_phoenix__DOT__spi_start = 0U;
    __Vdly__intv_phoenix__DOT__fwd_feed = 0U;
    if (vlSelf->intv_phoenix__DOT__fwd_feed) {
        __Vdly__intv_phoenix__DOT__fwd_feed_wait = 1U;
    } else if (vlSelf->intv_phoenix__DOT__fwd_byte_ready) {
        __Vdly__intv_phoenix__DOT__fwd_feed_wait = 0U;
    }
    if (vlSelf->intv_phoenix__DOT__io_wr) {
        if ((1U & (~ ((IData)(vlSelf->intv_phoenix__DOT__cpu_a) 
                      >> 7U)))) {
            if ((1U & (~ ((IData)(vlSelf->intv_phoenix__DOT__cpu_a) 
                          >> 6U)))) {
                if ((1U & (~ ((IData)(vlSelf->intv_phoenix__DOT__cpu_a) 
                              >> 5U)))) {
                    if ((1U & (~ ((IData)(vlSelf->intv_phoenix__DOT__cpu_a) 
                                  >> 4U)))) {
                        if ((1U & (~ ((IData)(vlSelf->intv_phoenix__DOT__cpu_a) 
                                      >> 3U)))) {
                            if ((4U & (IData)(vlSelf->intv_phoenix__DOT__cpu_a))) {
                                if ((1U & (~ ((IData)(vlSelf->intv_phoenix__DOT__cpu_a) 
                                              >> 1U)))) {
                                    if ((1U & (IData)(vlSelf->intv_phoenix__DOT__cpu_a))) {
                                        vlSelf->led_err 
                                            = (1U & (IData)(vlSelf->intv_phoenix__DOT__cpu_do));
                                    }
                                }
                                if ((2U & (IData)(vlSelf->intv_phoenix__DOT__cpu_a))) {
                                    if ((1U & (IData)(vlSelf->intv_phoenix__DOT__cpu_a))) {
                                        __Vdly__intv_phoenix__DOT__fwd_count 
                                            = (((IData)(vlSelf->intv_phoenix__DOT__cpu_do) 
                                                << 8U) 
                                               | (IData)(vlSelf->intv_phoenix__DOT__fwd_lo));
                                        __Vdly__intv_phoenix__DOT__fwd_active = 1U;
                                    }
                                }
                            } else if ((1U & (~ ((IData)(vlSelf->intv_phoenix__DOT__cpu_a) 
                                                 >> 1U)))) {
                                if ((1U & (~ (IData)(vlSelf->intv_phoenix__DOT__cpu_a)))) {
                                    vlSelf->intv_phoenix__DOT__spi_txd 
                                        = vlSelf->intv_phoenix__DOT__cpu_do;
                                    __Vdly__intv_phoenix__DOT__spi_start = 1U;
                                }
                            }
                            if ((1U & (~ ((IData)(vlSelf->intv_phoenix__DOT__cpu_a) 
                                          >> 2U)))) {
                                if ((1U & (~ ((IData)(vlSelf->intv_phoenix__DOT__cpu_a) 
                                              >> 1U)))) {
                                    if ((1U & (IData)(vlSelf->intv_phoenix__DOT__cpu_a))) {
                                        vlSelf->intv_phoenix__DOT__spi_sel 
                                            = (1U & (IData)(vlSelf->intv_phoenix__DOT__cpu_do));
                                        vlSelf->intv_phoenix__DOT__spi_slow 
                                            = (1U & 
                                               ((IData)(vlSelf->intv_phoenix__DOT__cpu_do) 
                                                >> 1U));
                                    }
                                }
                            }
                        }
                        if ((8U & (IData)(vlSelf->intv_phoenix__DOT__cpu_a))) {
                            if ((4U & (IData)(vlSelf->intv_phoenix__DOT__cpu_a))) {
                                if ((1U & (~ ((IData)(vlSelf->intv_phoenix__DOT__cpu_a) 
                                              >> 1U)))) {
                                    if ((1U & (IData)(vlSelf->intv_phoenix__DOT__cpu_a))) {
                                        vlSelf->intv_phoenix__DOT__swap 
                                            = (1U & (IData)(vlSelf->intv_phoenix__DOT__cpu_do));
                                    }
                                    if ((1U & (~ (IData)(vlSelf->intv_phoenix__DOT__cpu_a)))) {
                                        vlSelf->intv_phoenix__DOT__paged_mask 
                                            = (((IData)(vlSelf->intv_phoenix__DOT__cpu_do) 
                                                << 8U) 
                                               | (IData)(vlSelf->intv_phoenix__DOT__mask_lo));
                                    }
                                }
                                if ((2U & (IData)(vlSelf->intv_phoenix__DOT__cpu_a))) {
                                    if ((1U & (~ (IData)(vlSelf->intv_phoenix__DOT__cpu_a)))) {
                                        vlSelf->intv_phoenix__DOT__jlp_g 
                                            = (1U & 
                                               ((IData)(vlSelf->intv_phoenix__DOT__cpu_do) 
                                                >> 1U));
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    if (((((((IData)(vlSelf->intv_phoenix__DOT__fwd_active) 
             & (~ (IData)(vlSelf->intv_phoenix__DOT__spi_busy))) 
            & (~ (IData)(vlSelf->intv_phoenix__DOT__spi_start))) 
           & (~ (IData)(vlSelf->intv_phoenix__DOT__fwd_feed))) 
          & (~ (IData)(vlSelf->intv_phoenix__DOT__fwd_feed_wait))) 
         & (~ (IData)(vlSelf->intv_phoenix__DOT__ld_pend)))) {
        if ((0U == (IData)(vlSelf->intv_phoenix__DOT__fwd_count))) {
            __Vdly__intv_phoenix__DOT__fwd_active = 0U;
        } else {
            __Vdly__intv_phoenix__DOT__fwd_count = 
                (0xffffU & ((IData)(vlSelf->intv_phoenix__DOT__fwd_count) 
                            - (IData)(1U)));
            vlSelf->intv_phoenix__DOT__spi_txd = 0xffU;
            __Vdly__intv_phoenix__DOT__spi_start = 1U;
            __Vdly__intv_phoenix__DOT__fwd_feed = 1U;
        }
    }
    if (vlSelf->intv_phoenix__DOT__ld_done) {
        vlSelf->intv_phoenix__DOT__ld_pend = 0U;
    }
    if (vlSelf->intv_phoenix__DOT__io_wr) {
        if ((1U & (~ ((IData)(vlSelf->intv_phoenix__DOT__cpu_a) 
                      >> 7U)))) {
            if ((1U & (~ ((IData)(vlSelf->intv_phoenix__DOT__cpu_a) 
                          >> 6U)))) {
                if ((1U & (~ ((IData)(vlSelf->intv_phoenix__DOT__cpu_a) 
                              >> 5U)))) {
                    if ((1U & (~ ((IData)(vlSelf->intv_phoenix__DOT__cpu_a) 
                                  >> 4U)))) {
                        if ((8U & (IData)(vlSelf->intv_phoenix__DOT__cpu_a))) {
                            if ((1U & (~ ((IData)(vlSelf->intv_phoenix__DOT__cpu_a) 
                                          >> 2U)))) {
                                if ((2U & (IData)(vlSelf->intv_phoenix__DOT__cpu_a))) {
                                    if ((1U & (IData)(vlSelf->intv_phoenix__DOT__cpu_a))) {
                                        vlSelf->intv_phoenix__DOT__mask_lo 
                                            = vlSelf->intv_phoenix__DOT__cpu_do;
                                    }
                                }
                            }
                        }
                        if ((1U & (~ ((IData)(vlSelf->intv_phoenix__DOT__cpu_a) 
                                      >> 3U)))) {
                            if ((4U & (IData)(vlSelf->intv_phoenix__DOT__cpu_a))) {
                                if ((2U & (IData)(vlSelf->intv_phoenix__DOT__cpu_a))) {
                                    if ((1U & (~ (IData)(vlSelf->intv_phoenix__DOT__cpu_a)))) {
                                        vlSelf->intv_phoenix__DOT__fwd_lo 
                                            = vlSelf->intv_phoenix__DOT__cpu_do;
                                    }
                                }
                            }
                            if ((1U & (~ ((IData)(vlSelf->intv_phoenix__DOT__cpu_a) 
                                          >> 2U)))) {
                                if ((2U & (IData)(vlSelf->intv_phoenix__DOT__cpu_a))) {
                                    if ((1U & (IData)(vlSelf->intv_phoenix__DOT__cpu_a))) {
                                        __Vdly__intv_phoenix__DOT__crc = 0xffffffffU;
                                    } else {
                                        vlSelf->intv_phoenix__DOT__ld_data 
                                            = vlSelf->intv_phoenix__DOT__cpu_do;
                                        vlSelf->intv_phoenix__DOT__ld_pend = 1U;
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    vlSelf->intv_phoenix__DOT__boot_cpu__DOT__HC = vlSelf->intv_phoenix__DOT__boot_cpu__DOT__ALU__DOT__temp_HC;
    vlSelf->intv_phoenix__DOT__boot_cpu__DOT__adj_bcd 
        = ((IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__adc_sbc) 
           & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__D));
    if (((0xcU == (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__state)) 
         | (8U == (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__state)))) {
        vlSelf->intv_phoenix__DOT__boot_cpu__DOT__adc_bcd 
            = ((0x61U == (0xe3U & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__IR))) 
               & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__D));
    }
    if ((0x27U == (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__state))) {
        vlSelf->intv_phoenix__DOT__boot_cpu__DOT__D 
            = (1U & ((IData)(vlSelf->intv_phoenix__DOT__cpu_di) 
                     >> 3U));
    } else if ((0xcU == (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__state))) {
        if (vlSelf->intv_phoenix__DOT__boot_cpu__DOT__sed) {
            vlSelf->intv_phoenix__DOT__boot_cpu__DOT__D = 1U;
        }
        if (vlSelf->intv_phoenix__DOT__boot_cpu__DOT__cld) {
            vlSelf->intv_phoenix__DOT__boot_cpu__DOT__D = 0U;
        }
        if (vlSelf->intv_phoenix__DOT__boot_cpu__DOT__plp) {
            vlSelf->intv_phoenix__DOT__boot_cpu__DOT__D 
                = (1U & ((IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__ADD) 
                         >> 3U));
        }
    }
    if (((0xcU == (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__state)) 
         | (8U == (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__state)))) {
        vlSelf->intv_phoenix__DOT__boot_cpu__DOT__adc_sbc 
            = (0x61U == (0x63U & (IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__IR)));
    }
    vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2971_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0275_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2972_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0299_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2973_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0277_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2974_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0278_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3059_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___549_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3060_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0268_;
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314697__159__b 
        = (((QData)((IData)((1U & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0755_) 
                                   >> 0xfU)))) << 0x38U) 
           | (((QData)((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0755_)) 
               << 0x28U) | (((QData)((IData)((1U & 
                                              ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0755_) 
                                               >> 0xfU)))) 
                             << 0x25U) | (((QData)((IData)(
                                                           (1U 
                                                            & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0755_) 
                                                               >> 0xfU)))) 
                                           << 0x24U) 
                                          | (((QData)((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0755_)) 
                                              << 0x14U) 
                                             | (QData)((IData)(
                                                               ((0x40000U 
                                                                 & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0755_) 
                                                                    << 3U)) 
                                                                | ((0x20000U 
                                                                    & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0755_) 
                                                                       << 2U)) 
                                                                   | ((0x10000U 
                                                                       & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0755_) 
                                                                          << 1U)) 
                                                                      | (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0755_)))))))))));
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314697__159__Vfuncout 
        = (0x7ffffU & (IData)((__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314697__159__b 
                               >> 0x13U)));
    vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0663_ 
        = __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0314697__159__Vfuncout;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0098_ 
        = ((~ (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0719_)) 
           & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0716_));
    vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0102_ 
        = ((~ (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0716_)) 
           & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0719_));
    vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___271_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___270_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0859_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0858_;
    if ((4U & (IData)(vlSelf->intv_phoenix__DOT__reset_s))) {
        vlSelf->led_err = 0U;
        vlSelf->intv_phoenix__DOT__spi_sel = 0U;
    }
    vlSelf->sd_cs_n = (1U & (~ (IData)(vlSelf->intv_phoenix__DOT__spi_sel)));
    vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___143_ 
        = ((~ ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___244_) 
               & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___247_))) 
           & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___244_) 
              | (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___247_)));
    if ((4U & (IData)(vlSelf->intv_phoenix__DOT__reset_s))) {
        vlSelf->intv_phoenix__DOT__spi_slow = 1U;
    }
    vlSelf->intv_phoenix__DOT__spi_tick = (1U & ((IData)(vlSelf->intv_phoenix__DOT__spi_slow)
                                                  ? 
                                                 (0x3fU 
                                                  == (IData)(vlSelf->intv_phoenix__DOT__spi_div))
                                                  : (IData)(vlSelf->intv_phoenix__DOT__spi_div)));
    vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___135_ 
        = (0x1ffffffffULL & (vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___265_ 
                             - vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___268_));
    intv_phoenix__DOT__kb_cols = 0U;
    if ((1U & (~ (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_snd2__DOT___383_)))) {
        intv_phoenix__DOT__kb_cols = (0xffU & ((IData)(intv_phoenix__DOT__kb_cols) 
                                               | (IData)(vlSelf->intv_phoenix__DOT__ecs_keys_g)));
    }
    if ((1U & (~ ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_snd2__DOT___383_) 
                  >> 1U)))) {
        intv_phoenix__DOT__kb_cols = (0xffU & ((IData)(intv_phoenix__DOT__kb_cols) 
                                               | (IData)(
                                                         (vlSelf->intv_phoenix__DOT__ecs_keys_g 
                                                          >> 8U))));
    }
    if ((1U & (~ ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_snd2__DOT___383_) 
                  >> 2U)))) {
        intv_phoenix__DOT__kb_cols = (0xffU & ((IData)(intv_phoenix__DOT__kb_cols) 
                                               | (IData)(
                                                         (vlSelf->intv_phoenix__DOT__ecs_keys_g 
                                                          >> 0x10U))));
    }
    if ((1U & (~ ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_snd2__DOT___383_) 
                  >> 3U)))) {
        intv_phoenix__DOT__kb_cols = (0xffU & ((IData)(intv_phoenix__DOT__kb_cols) 
                                               | (IData)(
                                                         (vlSelf->intv_phoenix__DOT__ecs_keys_g 
                                                          >> 0x18U))));
    }
    if ((1U & (~ ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_snd2__DOT___383_) 
                  >> 4U)))) {
        intv_phoenix__DOT__kb_cols = (0xffU & ((IData)(intv_phoenix__DOT__kb_cols) 
                                               | (IData)(
                                                         (vlSelf->intv_phoenix__DOT__ecs_keys_g 
                                                          >> 0x20U))));
    }
    if ((1U & (~ ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_snd2__DOT___383_) 
                  >> 5U)))) {
        intv_phoenix__DOT__kb_cols = (0xffU & ((IData)(intv_phoenix__DOT__kb_cols) 
                                               | (IData)(
                                                         (vlSelf->intv_phoenix__DOT__ecs_keys_g 
                                                          >> 0x28U))));
    }
    if ((1U & (~ ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_snd2__DOT___383_) 
                  >> 6U)))) {
        intv_phoenix__DOT__kb_cols = (0xffU & ((IData)(intv_phoenix__DOT__kb_cols) 
                                               | (IData)(
                                                         (vlSelf->intv_phoenix__DOT__ecs_keys_g 
                                                          >> 0x30U))));
    }
    if ((1U & (~ ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_snd2__DOT___383_) 
                  >> 7U)))) {
        intv_phoenix__DOT__kb_cols = (0xffU & ((IData)(intv_phoenix__DOT__kb_cols) 
                                               | (IData)(
                                                         (vlSelf->intv_phoenix__DOT__ecs_keys_g 
                                                          >> 0x38U))));
    }
    vlSelf->intv_phoenix__DOT__ecs_keys_m = vlSelf->intv_phoenix__DOT__ecs_keys;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_cart__DOT___056_ 
        = ((~ (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cart__DOT___101_)) 
           & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cart__DOT___095_) 
              >> 7U));
    vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___124_ 
        = (((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___209_) 
            >> 0xfU) & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___215_));
    vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___121_ 
        = (((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___206_) 
            >> 0xfU) & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___212_));
    vlSelf->intv_phoenix__DOT__intv__DOT__i_snd2__DOT___195_ 
        = ((0U == (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_snd2__DOT___329_)) 
           | ((1U == (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_snd2__DOT___329_)) 
              | ((2U == (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_snd2__DOT___329_)) 
                 | ((3U == (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_snd2__DOT___329_)) 
                    | (9U == (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_snd2__DOT___329_))))));
    vlSelf->intv_phoenix__DOT__intv__DOT__i_snd__DOT___195_ 
        = ((0U == (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_snd__DOT___329_)) 
           | ((1U == (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_snd__DOT___329_)) 
              | ((2U == (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_snd__DOT___329_)) 
                 | ((3U == (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_snd__DOT___329_)) 
                    | (9U == (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_snd__DOT___329_))))));
    vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0298_ 
        = ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2963_) 
           & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2989_));
    vlSelf->intv_phoenix__DOT__intv__DOT___64_ = vlSelf->intv_phoenix__DOT__intv__DOT___63_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_snd__DOT___140_ 
        = ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT___69_) 
           & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_snd__DOT___374_));
    vlSelf->intv_phoenix__DOT__intv__DOT__i_snd2__DOT___140_ 
        = ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT___69_) 
           & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_snd2__DOT___374_));
    vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0778_ 
        = ((0x800U & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3049_))
            ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3657_)
            : (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3650_));
    vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0160_ 
        = ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0751_)
            ? 1U : (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0810_));
    vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___134_ 
        = ((1U & ((0x10U & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___231_))
                   ? (vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___219_ 
                      >> 0x10U) : ((8U & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___231_))
                                    ? ((4U & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___231_))
                                        ? ((2U & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___231_))
                                            ? ((1U 
                                                & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___231_))
                                                ? (vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___219_ 
                                                   >> 0xfU)
                                                : (vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___219_ 
                                                   >> 0xeU))
                                            : ((1U 
                                                & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___231_))
                                                ? (vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___219_ 
                                                   >> 0xdU)
                                                : (vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___219_ 
                                                   >> 0xcU)))
                                        : ((2U & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___231_))
                                            ? ((1U 
                                                & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___231_))
                                                ? (vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___219_ 
                                                   >> 0xbU)
                                                : (vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___219_ 
                                                   >> 0xaU))
                                            : ((1U 
                                                & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___231_))
                                                ? (vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___219_ 
                                                   >> 9U)
                                                : (vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___219_ 
                                                   >> 8U))))
                                    : ((4U & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___231_))
                                        ? ((2U & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___231_))
                                            ? ((1U 
                                                & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___231_))
                                                ? (vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___219_ 
                                                   >> 7U)
                                                : (vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___219_ 
                                                   >> 6U))
                                            : ((1U 
                                                & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___231_))
                                                ? (vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___219_ 
                                                   >> 5U)
                                                : (vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___219_ 
                                                   >> 4U)))
                                        : ((2U & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___231_))
                                            ? ((1U 
                                                & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___231_))
                                                ? (vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___219_ 
                                                   >> 3U)
                                                : (vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___219_ 
                                                   >> 2U))
                                            : ((1U 
                                                & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___231_))
                                                ? (vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___219_ 
                                                   >> 1U)
                                                : vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___219_))))))
            ? (vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___222_ 
               + vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___250_)
            : vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___250_);
    intv_phoenix__DOT__intv__DOT__i_jlp__DOT___301_ 
        = (1U & ((~ (((IData)(0xfU) - (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___231_)) 
                     >> 3U)) & (~ (((IData)(0xfU) - (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___231_)) 
                                   >> 2U))));
    intv_phoenix__DOT__intv__DOT__i_jlp__DOT___302_ 
        = (1U & ((~ (((IData)(0xfU) - (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___231_)) 
                     >> 3U)) & (((IData)(0xfU) - (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___231_)) 
                                >> 2U)));
    intv_phoenix__DOT__intv__DOT__i_jlp__DOT___303_ 
        = (1U & ((~ (((IData)(0xfU) - (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___231_)) 
                     >> 2U)) & (((IData)(0xfU) - (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___231_)) 
                                >> 3U)));
    intv_phoenix__DOT__intv__DOT__i_jlp__DOT___304_ 
        = (1U & ((((IData)(0xfU) - (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___231_)) 
                  >> 3U) & (((IData)(0xfU) - (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___231_)) 
                            >> 2U)));
    if (((IData)(vlSelf->intv_phoenix__DOT__menu_s) 
         == (IData)(vlSelf->intv_phoenix__DOT__menu_m))) {
        vlSelf->intv_phoenix__DOT__menu_g = vlSelf->intv_phoenix__DOT__menu_s;
    }
    vlSelf->intv_phoenix__DOT__menu_s = vlSelf->intv_phoenix__DOT__menu_m;
    if (((IData)(vlSelf->intv_phoenix__DOT__mkey_s) 
         == (IData)(vlSelf->intv_phoenix__DOT__mkey_m))) {
        vlSelf->intv_phoenix__DOT__mkey_g = vlSelf->intv_phoenix__DOT__mkey_s;
    }
    vlSelf->intv_phoenix__DOT__mkey_s = vlSelf->intv_phoenix__DOT__mkey_m;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0723_ 
        = VL_MULS_III(32, (IData)(8U), (((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3046_) 
                                         >> 3U) & (0xfeU 
                                                   | (1U 
                                                      & (~ 
                                                         ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3040_) 
                                                          >> 7U))))));
    vlSelf->intv_phoenix__DOT__intv__DOT__i_cart__DOT___112_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_cart__DOT___111_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_cart__DOT___106_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_cart__DOT___105_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_cart__DOT___109_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_cart__DOT___108_;
    vlSelf->intv_phoenix__DOT__ctl1_m = vlSelf->intv_phoenix__DOT__ctl1;
    vlSelf->intv_phoenix__DOT__ctl2_m = vlSelf->intv_phoenix__DOT__ctl2;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0735_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0734_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0406_ 
        = ((7U & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___1058_) 
                  >> 7U)) + (0xfU & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___1058_) 
                                     >> 3U)));
    vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0417_ 
        = ((4U == (7U & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___1058_))) 
           | ((5U == (7U & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___1058_))) 
              | (6U == (7U & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___1058_)))));
    vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0821_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0820_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____VdfgTmp_hf9d8f3b7__0 
        = ((0x80000000U & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0759_) 
                           << 0x10U)) | ((0x40000000U 
                                          & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0759_) 
                                             << 0xfU)) 
                                         | ((0x20000000U 
                                             & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0759_) 
                                                << 0xeU)) 
                                            | ((0x10000000U 
                                                & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0759_) 
                                                   << 0xdU)) 
                                               | ((0x8000000U 
                                                   & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0759_) 
                                                      << 0xcU)) 
                                                  | ((0x4000000U 
                                                      & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0759_) 
                                                         << 0xbU)) 
                                                     | ((0x2000000U 
                                                         & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0759_) 
                                                            << 0xaU)) 
                                                        | ((0x1000000U 
                                                            & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0759_) 
                                                               << 9U)) 
                                                           | ((0x800000U 
                                                               & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0759_) 
                                                                  << 8U)) 
                                                              | ((0x400000U 
                                                                  & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0759_) 
                                                                     << 7U)) 
                                                                 | ((0x200000U 
                                                                     & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0759_) 
                                                                        << 6U)) 
                                                                    | ((0x100000U 
                                                                        & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0759_) 
                                                                           << 5U)) 
                                                                       | ((0x80000U 
                                                                           & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0759_) 
                                                                              << 4U)) 
                                                                          | ((0x40000U 
                                                                              & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0759_) 
                                                                                << 3U)) 
                                                                             | ((0x20000U 
                                                                                & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0759_) 
                                                                                << 2U)) 
                                                                                | ((0x10000U 
                                                                                & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0759_) 
                                                                                << 1U)) 
                                                                                | (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0759_)))))))))))))))));
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____035204__355__s 
        = (((9U == (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2953_)) 
            << 9U) | (((8U == (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2953_)) 
                       << 8U) | (((7U == (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2953_)) 
                                  << 7U) | (((6U == (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2953_)) 
                                             << 6U) 
                                            | (((5U 
                                                 == (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2953_)) 
                                                << 5U) 
                                               | (((4U 
                                                    == (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2953_)) 
                                                   << 4U) 
                                                  | (((3U 
                                                       == (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2953_)) 
                                                      << 3U) 
                                                     | (((2U 
                                                          == (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2953_)) 
                                                         << 2U) 
                                                        | (((1U 
                                                             == (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2953_)) 
                                                            << 1U) 
                                                           | (0U 
                                                              == (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2953_)))))))))));
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____035204__355__Vfuncout 
        = (((((((((1U == (1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____035204__355__s))) 
                  | (2U == (2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____035204__355__s)))) 
                 | (4U == (4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____035204__355__s)))) 
                | (8U == (8U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____035204__355__s)))) 
               | (0x10U == (0x10U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____035204__355__s)))) 
              | (0x20U == (0x20U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____035204__355__s)))) 
             | (0x40U == (0x40U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____035204__355__s)))) 
            | (0x80U == (0x80U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____035204__355__s))))
            ? ((1U == (1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____035204__355__s)))
                ? 0U : ((2U == (2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____035204__355__s)))
                         ? 1U : ((4U == (4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____035204__355__s)))
                                  ? 2U : ((8U == (8U 
                                                  & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____035204__355__s)))
                                           ? 3U : (
                                                   (0x10U 
                                                    == 
                                                    (0x10U 
                                                     & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____035204__355__s)))
                                                    ? 4U
                                                    : 
                                                   ((0x20U 
                                                     == 
                                                     (0x20U 
                                                      & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____035204__355__s)))
                                                     ? 5U
                                                     : 
                                                    ((0x40U 
                                                      == 
                                                      (0x40U 
                                                       & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____035204__355__s)))
                                                      ? 6U
                                                      : 7U)))))))
            : 0U);
    vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0740_ 
        = __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____035204__355__Vfuncout;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3275_ 
        = (1U & ((((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2953_) 
                   - (IData)(2U)) >> 2U) & (((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2953_) 
                                             - (IData)(2U)) 
                                            >> 1U)));
    vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3274_ 
        = (1U & ((~ (((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2953_) 
                      - (IData)(2U)) >> 1U)) & (((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2953_) 
                                                 - (IData)(2U)) 
                                                >> 2U)));
    vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3273_ 
        = (1U & ((~ (((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2953_) 
                      - (IData)(2U)) >> 2U)) & (((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2953_) 
                                                 - (IData)(2U)) 
                                                >> 1U)));
    vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3272_ 
        = (1U & ((~ (((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2953_) 
                      - (IData)(2U)) >> 2U)) & (~ (
                                                   ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2953_) 
                                                    - (IData)(2U)) 
                                                   >> 1U))));
    vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0857_ 
        = ((2U <= (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2953_)) 
           & (9U >= (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2953_)));
    vlSelf->intv_phoenix__DOT__boot_cpu__DOT__AN = 
        (1U & ((IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__ALU__DOT__temp) 
               >> 7U));
    vlSelf->intv_phoenix__DOT__boot_cpu__DOT__ALU__DOT__BI7 
        = (1U & ((IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__ALU__DOT__temp_BI) 
                 >> 7U));
    vlSelf->intv_phoenix__DOT__boot_cpu__DOT__ALU__DOT__AI7 
        = (1U & ((IData)(vlSelf->intv_phoenix__DOT__boot_cpu__DOT__AI) 
                 >> 7U));
    vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2939_ 
        = ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2950_) 
           == ((IData)(0xcdU) + (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3007_)));
    vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT____VdfgTmp_hbce12e88__0 
        = (7U & (VL_DIVS_III(32, ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2950_) 
                                  - (IData)(0xcU)), (IData)(2U)) 
                 - (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3007_)));
    vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0902_ 
        = ((VL_DIVS_III(32, ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2950_) 
                             - (IData)(0xcU)), (IData)(2U)) 
            - (IData)(8U)) - (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3007_));
    vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0946_ 
        = (VL_GTS_III(32, 0xdbU, (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2950_)) 
           & VL_LTES_III(32, 0x1cU, (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2950_)));
    vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2668_ 
        = (VL_GTS_III(32, 0xddU, (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2950_)) 
           & VL_LTES_III(32, 0x2bU, (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2950_)));
    vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2665_ 
        = (VL_GTS_III(32, 0xddU, (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2950_)) 
           & VL_LTES_III(32, 0x1bU, (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2950_)));
    vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0887_ 
        = (((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2950_) 
            - (IData)(0xcU)) - VL_MULS_III(32, (IData)(2U), (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3007_)));
    vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0894_ 
        = ((0x800U & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3660_))
            ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3657_)
            : (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3650_));
    vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT____VdfgTmp_h677ae353__0 
        = ((4U & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3660_) 
                  >> 0xbU)) | (3U & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3660_) 
                                     >> 9U)));
    vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3006_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0316_;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2947_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2946_;
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03855__96__s 
        = (((0xeU == (0xfU & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___572_) 
                              >> 2U))) << 0xeU) | (
                                                   ((0xdU 
                                                     == 
                                                     (0xfU 
                                                      & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___572_) 
                                                         >> 2U))) 
                                                    << 0xdU) 
                                                   | (((0xcU 
                                                        == 
                                                        (0xfU 
                                                         & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___572_) 
                                                            >> 2U))) 
                                                       << 0xcU) 
                                                      | (((0xbU 
                                                           == 
                                                           (0xfU 
                                                            & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___572_) 
                                                               >> 2U))) 
                                                          << 0xbU) 
                                                         | (((0xaU 
                                                              == 
                                                              (0xfU 
                                                               & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___572_) 
                                                                  >> 2U))) 
                                                             << 0xaU) 
                                                            | (((9U 
                                                                 == 
                                                                 (0xfU 
                                                                  & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___572_) 
                                                                     >> 2U))) 
                                                                << 9U) 
                                                               | (((8U 
                                                                    == 
                                                                    (0xfU 
                                                                     & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___572_) 
                                                                        >> 2U))) 
                                                                   << 8U) 
                                                                  | (((7U 
                                                                       == 
                                                                       (0xfU 
                                                                        & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___572_) 
                                                                           >> 2U))) 
                                                                      << 7U) 
                                                                     | (((6U 
                                                                          == 
                                                                          (0xfU 
                                                                           & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___572_) 
                                                                              >> 2U))) 
                                                                         << 6U) 
                                                                        | (((5U 
                                                                             == 
                                                                             (0xfU 
                                                                              & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___572_) 
                                                                                >> 2U))) 
                                                                            << 5U) 
                                                                           | (((4U 
                                                                                == 
                                                                                (0xfU 
                                                                                & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___572_) 
                                                                                >> 2U))) 
                                                                               << 4U) 
                                                                              | (((3U 
                                                                                == 
                                                                                (0xfU 
                                                                                & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___572_) 
                                                                                >> 2U))) 
                                                                                << 3U) 
                                                                                | (((2U 
                                                                                == 
                                                                                (0xfU 
                                                                                & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___572_) 
                                                                                >> 2U))) 
                                                                                << 2U) 
                                                                                | (((1U 
                                                                                == 
                                                                                (0xfU 
                                                                                & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___572_) 
                                                                                >> 2U))) 
                                                                                << 1U) 
                                                                                | (0U 
                                                                                == 
                                                                                (0xfU 
                                                                                & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___572_) 
                                                                                >> 2U)))))))))))))))));
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03855__96__b 
        = ((0x4000U & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___648_) 
                       << 6U)) | ((0x3000U & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___648_) 
                                              << 4U)) 
                                  | ((0xc00U & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___648_) 
                                                << 2U)) 
                                     | ((0x300U & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___648_)) 
                                        | ((0x80U & 
                                            ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___648_) 
                                             >> 6U)) 
                                           | ((0x60U 
                                               & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___648_) 
                                                  >> 8U)) 
                                              | ((0x18U 
                                                  & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___648_) 
                                                     >> 0xaU)) 
                                                 | ((4U 
                                                     & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___648_) 
                                                        >> 0xcU)) 
                                                    | ((2U 
                                                        & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___648_) 
                                                           >> 6U)) 
                                                       | (1U 
                                                          & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___648_) 
                                                             >> 0xfU)))))))))));
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03855__96__a 
        = (1U & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___648_) 
                 >> 9U));
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03855__96__Vfuncout 
        = (1U & (((((((((1U == (1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03855__96__s))) 
                        | (2U == (2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03855__96__s)))) 
                       | (4U == (4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03855__96__s)))) 
                      | (8U == (8U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03855__96__s)))) 
                     | (0x10U == (0x10U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03855__96__s)))) 
                    | (0x20U == (0x20U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03855__96__s)))) 
                   | (0x40U == (0x40U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03855__96__s)))) 
                  | (0x80U == (0x80U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03855__96__s))))
                  ? ((1U == (1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03855__96__s)))
                      ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03855__96__b)
                      : ((2U == (2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03855__96__s)))
                          ? ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03855__96__b) 
                             >> 1U) : ((4U == (4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03855__96__s)))
                                        ? ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03855__96__b) 
                                           >> 2U) : 
                                       ((8U == (8U 
                                                & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03855__96__s)))
                                         ? ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03855__96__b) 
                                            >> 3U) : 
                                        ((0x10U == 
                                          (0x10U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03855__96__s)))
                                          ? ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03855__96__b) 
                                             >> 4U)
                                          : ((0x20U 
                                              == (0x20U 
                                                  & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03855__96__s)))
                                              ? ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03855__96__b) 
                                                 >> 5U)
                                              : ((0x40U 
                                                  == 
                                                  (0x40U 
                                                   & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03855__96__s)))
                                                  ? 
                                                 ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03855__96__b) 
                                                  >> 6U)
                                                  : 
                                                 ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03855__96__b) 
                                                  >> 7U))))))))
                  : ((0x100U == (0x100U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03855__96__s)))
                      ? ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03855__96__b) 
                         >> 8U) : ((0x200U == (0x200U 
                                               & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03855__96__s)))
                                    ? ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03855__96__b) 
                                       >> 9U) : ((0x400U 
                                                  == 
                                                  (0x400U 
                                                   & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03855__96__s)))
                                                  ? 
                                                 ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03855__96__b) 
                                                  >> 0xaU)
                                                  : 
                                                 ((0x800U 
                                                   == 
                                                   (0x800U 
                                                    & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03855__96__s)))
                                                   ? 
                                                  ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03855__96__b) 
                                                   >> 0xbU)
                                                   : 
                                                  ((0x1000U 
                                                    == 
                                                    (0x1000U 
                                                     & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03855__96__s)))
                                                    ? 
                                                   ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03855__96__b) 
                                                    >> 0xcU)
                                                    : 
                                                   ((0x2000U 
                                                     == 
                                                     (0x2000U 
                                                      & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03855__96__s)))
                                                     ? 
                                                    ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03855__96__b) 
                                                     >> 0xdU)
                                                     : 
                                                    ((0x4000U 
                                                      == 
                                                      (0x4000U 
                                                       & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03855__96__s)))
                                                      ? 
                                                     ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03855__96__b) 
                                                      >> 0xeU)
                                                      : (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03855__96__a))))))))));
    vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___182_ 
        = __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03855__96__Vfuncout;
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03277__76__s 
        = (0U == (7U & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___572_) 
                        >> 3U)));
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03277__76__Vfuncout 
        = ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03277__76__s)
            ? 0x10U : 0x18U);
    vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___035_ 
        = __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03277__76__Vfuncout;
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03236__75__s 
        = (((7U == (7U & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___572_))) 
            << 7U) | (((6U == (7U & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___572_))) 
                       << 6U) | (((5U == (7U & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___572_))) 
                                  << 5U) | (((4U == 
                                              (7U & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___572_))) 
                                             << 4U) 
                                            | (((3U 
                                                 == 
                                                 (7U 
                                                  & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___572_))) 
                                                << 3U) 
                                               | (((2U 
                                                    == 
                                                    (7U 
                                                     & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___572_))) 
                                                   << 2U) 
                                                  | (((1U 
                                                       == 
                                                       (7U 
                                                        & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___572_))) 
                                                      << 1U) 
                                                     | (0U 
                                                        == 
                                                        (7U 
                                                         & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___572_))))))))));
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03236__75__Vfuncout 
        = (((((((((1U == (1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03236__75__s))) 
                  | (2U == (2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03236__75__s)))) 
                 | (4U == (4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03236__75__s)))) 
                | (8U == (8U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03236__75__s)))) 
               | (0x10U == (0x10U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03236__75__s)))) 
              | (0x20U == (0x20U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03236__75__s)))) 
             | (0x40U == (0x40U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03236__75__s)))) 
            | (0x80U == (0x80U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03236__75__s)))) 
           & (IData)((((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03236__75__s) 
                       >> 1U) & (1U != (1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03236__75__s))))));
    vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___013_ 
        = __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03236__75__Vfuncout;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___098_ 
        = ((4U == (7U & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___572_))) 
           | (5U == (7U & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___572_))));
    vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___095_ 
        = ((0U == (7U & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___572_))) 
           | ((1U == (7U & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___572_))) 
              | ((2U == (7U & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___572_))) 
                 | (3U == (7U & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___572_))))));
    vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___048_ 
        = ((9U == (0xfU & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___572_) 
                           >> 6U))) | ((0xaU == (0xfU 
                                                 & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___572_) 
                                                    >> 6U))) 
                                       | ((0xbU == 
                                           (0xfU & 
                                            ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___572_) 
                                             >> 6U))) 
                                          | ((0xcU 
                                              == (0xfU 
                                                  & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___572_) 
                                                     >> 6U))) 
                                             | ((0xdU 
                                                 == 
                                                 (0xfU 
                                                  & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___572_) 
                                                     >> 6U))) 
                                                | ((0xeU 
                                                    == 
                                                    (0xfU 
                                                     & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___572_) 
                                                        >> 6U))) 
                                                   | (0xfU 
                                                      == 
                                                      (0xfU 
                                                       & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___572_) 
                                                          >> 6U)))))))));
    vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___032_ 
        = ((2U == (0xfU & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___572_) 
                           >> 6U))) | ((3U == (0xfU 
                                               & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___572_) 
                                                  >> 6U))) 
                                       | ((4U == (0xfU 
                                                  & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___572_) 
                                                     >> 6U))) 
                                          | ((5U == 
                                              (0xfU 
                                               & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___572_) 
                                                  >> 6U))) 
                                             | ((6U 
                                                 == 
                                                 (0xfU 
                                                  & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___572_) 
                                                     >> 6U))) 
                                                | (7U 
                                                   == 
                                                   (0xfU 
                                                    & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___572_) 
                                                       >> 6U))))))));
    vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___321_ 
        = ((4U == (7U & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___572_) 
                         >> 3U))) | ((5U == (7U & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___572_) 
                                                   >> 3U))) 
                                     | (7U == (7U & 
                                               ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___572_) 
                                                >> 3U)))));
    vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___315_ 
        = ((1U == (7U & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___572_) 
                         >> 3U))) | ((2U == (7U & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___572_) 
                                                   >> 3U))) 
                                     | (3U == (7U & 
                                               ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___572_) 
                                                >> 3U)))));
    vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____VdfgTmp_h3057e3d3__0 
        = ((0xff00U & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3050_) 
                       << 8U)) | (0xffU & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___576_)));
    vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___1060_ 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT__regs
        [vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0155_];
    vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___141_ 
        = (1U & (((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___648_) 
                  ^ (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___649_)) 
                 >> 0xfU));
    vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___150_ 
        = ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___648_) 
           ^ (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___649_));
    vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___146_ 
        = ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___648_) 
           & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___649_));
    vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___120_ 
        = (0x1ffffU & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___649_) 
                       + (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___648_)));
    vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___130_ 
        = (0x1ffffU & ((IData)(1U) + ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___649_) 
                                      + (0xffffU & 
                                         (~ (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___648_))))));
    vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___218_ 
        = (1U & (((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3050_) 
                  >> 7U) ^ ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___649_) 
                            >> 0xfU)));
    vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___404_ 
        = (1U & (((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3050_) 
                  ^ (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___649_)) 
                 >> 0xfU));
    vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___277_ 
        = ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___649_) 
           ^ (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3050_));
    vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___273_ 
        = ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___649_) 
           & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3050_));
    vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___257_ 
        = (0x1ffffU & ((IData)(1U) + ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___649_) 
                                      + (0xffffU & 
                                         (~ (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3050_))))));
    vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___247_ 
        = (0x1ffffU & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___649_) 
                       + (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3050_)));
    vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3319_ 
        = ((~ (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2954_)) 
           & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3008_));
    vlSelf->intv_phoenix__DOT__fwd_feed = __Vdly__intv_phoenix__DOT__fwd_feed;
    vlSelf->intv_phoenix__DOT__fwd_count = __Vdly__intv_phoenix__DOT__fwd_count;
    if ((4U & (IData)(vlSelf->intv_phoenix__DOT__reset_s))) {
        vlSelf->intv_phoenix__DOT__paged_mask = 0U;
        __Vdly__intv_phoenix__DOT__fwd_active = 0U;
        __Vdly__intv_phoenix__DOT__fwd_feed_wait = 0U;
    }
    vlSelf->intv_phoenix__DOT__fwd_active = __Vdly__intv_phoenix__DOT__fwd_active;
    vlSelf->intv_phoenix__DOT__spi_start = __Vdly__intv_phoenix__DOT__spi_start;
    vlSelf->intv_phoenix__DOT__fwd_feed_wait = __Vdly__intv_phoenix__DOT__fwd_feed_wait;
    vlSelf->intv_phoenix__DOT__spi_busy = __Vdly__intv_phoenix__DOT__spi_busy;
    vlSelf->intv_phoenix__DOT__pa2_in = ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_snd2__DOT___278_)
                                          ? 0xffU : 
                                         (0xffU & (~ (IData)(intv_phoenix__DOT__kb_cols))));
    vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___307_ 
        = ((IData)(intv_phoenix__DOT__intv__DOT__i_jlp__DOT___301_) 
           & (((IData)(0xfU) - (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___231_)) 
              >> 1U));
    vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___306_ 
        = ((~ (((IData)(0xfU) - (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___231_)) 
               >> 1U)) & (IData)(intv_phoenix__DOT__intv__DOT__i_jlp__DOT___301_));
    vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___309_ 
        = ((IData)(intv_phoenix__DOT__intv__DOT__i_jlp__DOT___302_) 
           & (((IData)(0xfU) - (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___231_)) 
              >> 1U));
    vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___308_ 
        = ((~ (((IData)(0xfU) - (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___231_)) 
               >> 1U)) & (IData)(intv_phoenix__DOT__intv__DOT__i_jlp__DOT___302_));
    vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___311_ 
        = ((IData)(intv_phoenix__DOT__intv__DOT__i_jlp__DOT___303_) 
           & (((IData)(0xfU) - (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___231_)) 
              >> 1U));
    vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___310_ 
        = ((~ (((IData)(0xfU) - (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___231_)) 
               >> 1U)) & (IData)(intv_phoenix__DOT__intv__DOT__i_jlp__DOT___303_));
    vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___313_ 
        = ((IData)(intv_phoenix__DOT__intv__DOT__i_jlp__DOT___304_) 
           & (((IData)(0xfU) - (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___231_)) 
              >> 1U));
    vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___312_ 
        = ((~ (((IData)(0xfU) - (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___231_)) 
               >> 1U)) & (IData)(intv_phoenix__DOT__intv__DOT__i_jlp__DOT___304_));
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313735__107__s 
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
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313735__107__Vfuncout 
        = (1U & ((0x20U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313735__107__s))
                  ? ((0x10U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313735__107__s))
                      ? (IData)((0U != (0xfU & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313735__107__s))))
                      : (IData)((0U != (0xfU & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313735__107__s)))))
                  : ((0x10U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313735__107__s))
                      ? (IData)((0U != (0xfU & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313735__107__s))))
                      : (IData)((0U != (0xfU & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313735__107__s)))))));
    vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0428_ 
        = __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313735__107__Vfuncout;
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313743__109__s 
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
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313743__109__Vfuncout 
        = (1U & ((0x20U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313743__109__s))
                  ? ((0x10U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313743__109__s))
                      ? (IData)((0U == (0xfU & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313743__109__s))))
                      : (IData)((0U == (0xfU & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313743__109__s)))))
                  : (IData)((0x10U == (0x1fU & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313743__109__s))))));
    vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0430_ 
        = __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313743__109__Vfuncout;
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__s 
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
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__b 
        = (((0U == (0xfU & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___1058_) 
                            >> 0xaU))) << 5U) | (0xfU 
                                                 & (- (IData)((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0867_)))));
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__Vfuncout 
        = (1U & ((0x20U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__s))
                  ? ((0x10U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__s))
                      ? ((8U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__s))
                          ? ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__s))
                              ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__s))
                                  ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__s))
                                      ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__b)
                                      : ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__b) 
                                         >> 1U)) : 
                                 ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__s))
                                   ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__b)
                                   : ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__b) 
                                      >> 2U))) : ((2U 
                                                   & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__s))
                                                   ? 
                                                  ((1U 
                                                    & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__s))
                                                    ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__b)
                                                    : 
                                                   ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__b) 
                                                    >> 1U))
                                                   : 
                                                  ((1U 
                                                    & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__s))
                                                    ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__b)
                                                    : 
                                                   ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__b) 
                                                    >> 3U))))
                          : ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__s))
                              ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__s))
                                  ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__s))
                                      ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__b)
                                      : ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__b) 
                                         >> 1U)) : 
                                 ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__s))
                                   ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__b)
                                   : ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__b) 
                                      >> 2U))) : ((2U 
                                                   & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__s))
                                                   ? 
                                                  ((1U 
                                                    & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__s))
                                                    ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__b)
                                                    : 
                                                   ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__b) 
                                                    >> 1U))
                                                   : 
                                                  ((1U 
                                                    & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__s))
                                                    ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__b)
                                                    : 
                                                   ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__b) 
                                                    >> 4U)))))
                      : ((8U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__s))
                          ? ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__s))
                              ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__s))
                                  ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__s))
                                      ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__b)
                                      : ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__b) 
                                         >> 1U)) : 
                                 ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__s))
                                   ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__b)
                                   : ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__b) 
                                      >> 2U))) : ((2U 
                                                   & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__s))
                                                   ? 
                                                  ((1U 
                                                    & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__s))
                                                    ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__b)
                                                    : 
                                                   ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__b) 
                                                    >> 1U))
                                                   : 
                                                  ((1U 
                                                    & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__s))
                                                    ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__b)
                                                    : 
                                                   ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__b) 
                                                    >> 3U))))
                          : ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__s))
                              ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__s))
                                  ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__s))
                                      ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__b)
                                      : ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__b) 
                                         >> 1U)) : 
                                 ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__s))
                                   ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__b)
                                   : ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__b) 
                                      >> 2U))) : ((2U 
                                                   & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__s))
                                                   ? 
                                                  ((1U 
                                                    & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__s))
                                                    ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__b)
                                                    : 
                                                   ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__b) 
                                                    >> 1U))
                                                   : 
                                                  ((1U 
                                                    & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__s))
                                                    ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__b)
                                                    : 
                                                   ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__b) 
                                                    >> 5U))))))
                  : ((0x10U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__s))
                      ? ((8U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__s))
                          ? ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__s))
                              ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__s))
                                  ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__s))
                                      ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__b)
                                      : ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__b) 
                                         >> 1U)) : 
                                 ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__s))
                                   ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__b)
                                   : ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__b) 
                                      >> 2U))) : ((2U 
                                                   & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__s))
                                                   ? 
                                                  ((1U 
                                                    & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__s))
                                                    ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__b)
                                                    : 
                                                   ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__b) 
                                                    >> 1U))
                                                   : 
                                                  ((1U 
                                                    & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__s))
                                                    ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__b)
                                                    : 
                                                   ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__b) 
                                                    >> 3U))))
                          : ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__s))
                              ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__s))
                                  ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__s))
                                      ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__b)
                                      : ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__b) 
                                         >> 1U)) : 
                                 ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__s))
                                   ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__b)
                                   : ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__b) 
                                      >> 2U))) : ((2U 
                                                   & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__s))
                                                   ? 
                                                  ((1U 
                                                    & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__s))
                                                    ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__b)
                                                    : 
                                                   ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__b) 
                                                    >> 1U))
                                                   : 
                                                  ((1U 
                                                    & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__s))
                                                    ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__b)
                                                    : 
                                                   ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__b) 
                                                    >> 4U)))))
                      : ((8U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__s))
                          ? ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__s))
                              ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__s))
                                  ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__s))
                                      ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__b)
                                      : ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__b) 
                                         >> 1U)) : 
                                 ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__s))
                                   ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__b)
                                   : ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__b) 
                                      >> 2U))) : ((2U 
                                                   & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__s))
                                                   ? 
                                                  ((1U 
                                                    & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__s))
                                                    ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__b)
                                                    : 
                                                   ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__b) 
                                                    >> 1U))
                                                   : 
                                                  ((1U 
                                                    & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__s))
                                                    ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__b)
                                                    : 
                                                   ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__b) 
                                                    >> 3U))))
                          : ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__s))
                              ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__s))
                                  ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__s))
                                      ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__b)
                                      : ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__b) 
                                         >> 1U)) : 
                                 ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__s))
                                   ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__b)
                                   : ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__b) 
                                      >> 2U))) : ((2U 
                                                   & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__s))
                                                   ? 
                                                  ((1U 
                                                    & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__s))
                                                    ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__b)
                                                    : 
                                                   ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__b) 
                                                    >> 1U))
                                                   : 
                                                  ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__s) 
                                                   & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__b))))))));
    vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0431_ 
        = __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313746__110__Vfuncout;
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__s 
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
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__b 
        = (4U | ((0x30U & ((- (IData)((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0744_))) 
                           << 4U)) | ((((0U != (0xfU 
                                                & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0873_) 
                                                   >> 4U))) 
                                        & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0744_)) 
                                       << 3U) | (3U 
                                                 & (- (IData)((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0744_)))))));
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__Vfuncout 
        = (1U & ((0x20U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__s))
                  ? ((0x10U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__s))
                      ? ((8U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__s))
                          ? ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__s))
                              ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__s))
                                  ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__s))
                                      ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__b)
                                      : ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__b) 
                                         >> 1U)) : 
                                 ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__s))
                                   ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__b)
                                   : ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__b) 
                                      >> 2U))) : ((2U 
                                                   & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__s))
                                                   ? 
                                                  ((1U 
                                                    & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__s))
                                                    ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__b)
                                                    : 
                                                   ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__b) 
                                                    >> 1U))
                                                   : 
                                                  ((1U 
                                                    & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__s))
                                                    ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__b)
                                                    : 
                                                   ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__b) 
                                                    >> 3U))))
                          : ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__s))
                              ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__s))
                                  ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__s))
                                      ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__b)
                                      : ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__b) 
                                         >> 1U)) : 
                                 ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__s))
                                   ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__b)
                                   : ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__b) 
                                      >> 2U))) : ((2U 
                                                   & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__s))
                                                   ? 
                                                  ((1U 
                                                    & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__s))
                                                    ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__b)
                                                    : 
                                                   ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__b) 
                                                    >> 1U))
                                                   : 
                                                  ((1U 
                                                    & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__s))
                                                    ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__b)
                                                    : 
                                                   ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__b) 
                                                    >> 4U)))))
                      : ((8U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__s))
                          ? ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__s))
                              ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__s))
                                  ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__s))
                                      ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__b)
                                      : ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__b) 
                                         >> 1U)) : 
                                 ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__s))
                                   ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__b)
                                   : ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__b) 
                                      >> 2U))) : ((2U 
                                                   & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__s))
                                                   ? 
                                                  ((1U 
                                                    & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__s))
                                                    ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__b)
                                                    : 
                                                   ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__b) 
                                                    >> 1U))
                                                   : 
                                                  ((1U 
                                                    & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__s))
                                                    ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__b)
                                                    : 
                                                   ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__b) 
                                                    >> 3U))))
                          : ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__s))
                              ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__s))
                                  ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__s))
                                      ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__b)
                                      : ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__b) 
                                         >> 1U)) : 
                                 ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__s))
                                   ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__b)
                                   : ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__b) 
                                      >> 2U))) : ((2U 
                                                   & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__s))
                                                   ? 
                                                  ((1U 
                                                    & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__s))
                                                    ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__b)
                                                    : 
                                                   ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__b) 
                                                    >> 1U))
                                                   : 
                                                  ((1U 
                                                    & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__s))
                                                    ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__b)
                                                    : 
                                                   ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__b) 
                                                    >> 5U))))))
                  : ((0x10U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__s))
                      ? ((8U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__s))
                          ? ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__s))
                              ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__s))
                                  ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__s))
                                      ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__b)
                                      : ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__b) 
                                         >> 1U)) : 
                                 ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__s))
                                   ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__b)
                                   : ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__b) 
                                      >> 2U))) : ((2U 
                                                   & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__s))
                                                   ? 
                                                  ((1U 
                                                    & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__s))
                                                    ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__b)
                                                    : 
                                                   ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__b) 
                                                    >> 1U))
                                                   : 
                                                  ((1U 
                                                    & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__s))
                                                    ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__b)
                                                    : 
                                                   ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__b) 
                                                    >> 3U))))
                          : ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__s))
                              ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__s))
                                  ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__s))
                                      ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__b)
                                      : ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__b) 
                                         >> 1U)) : 
                                 ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__s))
                                   ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__b)
                                   : ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__b) 
                                      >> 2U))) : ((2U 
                                                   & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__s))
                                                   ? 
                                                  ((1U 
                                                    & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__s))
                                                    ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__b)
                                                    : 
                                                   ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__b) 
                                                    >> 1U))
                                                   : 
                                                  ((1U 
                                                    & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__s))
                                                    ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__b)
                                                    : 
                                                   ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__b) 
                                                    >> 4U)))))
                      : ((8U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__s))
                          ? ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__s))
                              ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__s))
                                  ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__s))
                                      ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__b)
                                      : ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__b) 
                                         >> 1U)) : 
                                 ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__s))
                                   ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__b)
                                   : ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__b) 
                                      >> 2U))) : ((2U 
                                                   & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__s))
                                                   ? 
                                                  ((1U 
                                                    & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__s))
                                                    ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__b)
                                                    : 
                                                   ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__b) 
                                                    >> 1U))
                                                   : 
                                                  ((1U 
                                                    & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__s))
                                                    ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__b)
                                                    : 
                                                   ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__b) 
                                                    >> 3U))))
                          : ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__s))
                              ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__s))
                                  ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__s))
                                      ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__b)
                                      : ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__b) 
                                         >> 1U)) : 
                                 ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__s))
                                   ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__b)
                                   : ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__b) 
                                      >> 2U))) : ((2U 
                                                   & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__s))
                                                   ? 
                                                  ((1U 
                                                    & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__s))
                                                    ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__b)
                                                    : 
                                                   ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__b) 
                                                    >> 1U))
                                                   : 
                                                  ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__s) 
                                                   & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__b))))))));
    vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0427_ 
        = __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313727__106__Vfuncout;
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__s 
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
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__b 
        = (6U | ((0U == (0xfU & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0873_) 
                                 >> 4U))) << 3U));
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__Vfuncout 
        = (1U & ((0x20U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__s))
                  ? ((0x10U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__s))
                      ? ((8U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__s))
                          ? ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__s))
                              ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__s))
                                  ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__s))
                                      ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__b)
                                      : ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__b) 
                                         >> 1U)) : 
                                 ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__s))
                                   ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__b)
                                   : ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__b) 
                                      >> 2U))) : ((2U 
                                                   & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__s))
                                                   ? 
                                                  ((1U 
                                                    & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__s))
                                                    ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__b)
                                                    : 
                                                   ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__b) 
                                                    >> 1U))
                                                   : 
                                                  ((1U 
                                                    & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__s))
                                                    ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__b)
                                                    : 
                                                   ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__b) 
                                                    >> 3U))))
                          : ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__s))
                              ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__s))
                                  ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__s))
                                      ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__b)
                                      : ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__b) 
                                         >> 1U)) : 
                                 ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__s))
                                   ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__b)
                                   : ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__b) 
                                      >> 2U))) : ((2U 
                                                   & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__s))
                                                   ? 
                                                  ((1U 
                                                    & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__s))
                                                    ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__b)
                                                    : 
                                                   ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__b) 
                                                    >> 1U))
                                                   : 
                                                  ((1U 
                                                    & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__s))
                                                    ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__b)
                                                    : 
                                                   ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__b) 
                                                    >> 4U)))))
                      : ((8U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__s))
                          ? ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__s))
                              ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__s))
                                  ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__s))
                                      ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__b)
                                      : ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__b) 
                                         >> 1U)) : 
                                 ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__s))
                                   ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__b)
                                   : ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__b) 
                                      >> 2U))) : ((2U 
                                                   & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__s))
                                                   ? 
                                                  ((1U 
                                                    & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__s))
                                                    ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__b)
                                                    : 
                                                   ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__b) 
                                                    >> 1U))
                                                   : 
                                                  ((1U 
                                                    & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__s))
                                                    ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__b)
                                                    : 
                                                   ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__b) 
                                                    >> 3U))))
                          : ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__s))
                              ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__s))
                                  ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__s))
                                      ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__b)
                                      : ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__b) 
                                         >> 1U)) : 
                                 ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__s))
                                   ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__b)
                                   : ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__b) 
                                      >> 2U))) : ((2U 
                                                   & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__s))
                                                   ? 
                                                  ((1U 
                                                    & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__s))
                                                    ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__b)
                                                    : 
                                                   ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__b) 
                                                    >> 1U))
                                                   : 
                                                  ((1U 
                                                    & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__s))
                                                    ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__b)
                                                    : 
                                                   ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__b) 
                                                    >> 5U))))))
                  : ((0x10U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__s))
                      ? ((8U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__s))
                          ? ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__s))
                              ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__s))
                                  ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__s))
                                      ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__b)
                                      : ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__b) 
                                         >> 1U)) : 
                                 ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__s))
                                   ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__b)
                                   : ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__b) 
                                      >> 2U))) : ((2U 
                                                   & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__s))
                                                   ? 
                                                  ((1U 
                                                    & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__s))
                                                    ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__b)
                                                    : 
                                                   ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__b) 
                                                    >> 1U))
                                                   : 
                                                  ((1U 
                                                    & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__s))
                                                    ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__b)
                                                    : 
                                                   ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__b) 
                                                    >> 3U))))
                          : ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__s))
                              ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__s))
                                  ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__s))
                                      ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__b)
                                      : ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__b) 
                                         >> 1U)) : 
                                 ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__s))
                                   ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__b)
                                   : ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__b) 
                                      >> 2U))) : ((2U 
                                                   & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__s))
                                                   ? 
                                                  ((1U 
                                                    & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__s))
                                                    ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__b)
                                                    : 
                                                   ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__b) 
                                                    >> 1U))
                                                   : 
                                                  ((1U 
                                                    & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__s))
                                                    ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__b)
                                                    : 
                                                   ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__b) 
                                                    >> 4U)))))
                      : ((8U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__s))
                          ? ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__s))
                              ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__s))
                                  ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__s))
                                      ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__b)
                                      : ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__b) 
                                         >> 1U)) : 
                                 ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__s))
                                   ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__b)
                                   : ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__b) 
                                      >> 2U))) : ((2U 
                                                   & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__s))
                                                   ? 
                                                  ((1U 
                                                    & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__s))
                                                    ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__b)
                                                    : 
                                                   ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__b) 
                                                    >> 1U))
                                                   : 
                                                  ((1U 
                                                    & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__s))
                                                    ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__b)
                                                    : 
                                                   ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__b) 
                                                    >> 3U))))
                          : ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__s))
                              ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__s))
                                  ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__s))
                                      ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__b)
                                      : ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__b) 
                                         >> 1U)) : 
                                 ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__s))
                                   ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__b)
                                   : ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__b) 
                                      >> 2U))) : ((2U 
                                                   & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__s))
                                                   ? 
                                                  ((1U 
                                                    & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__s))
                                                    ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__b)
                                                    : 
                                                   ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__b) 
                                                    >> 1U))
                                                   : 
                                                  ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__s) 
                                                   & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__b))))))));
    vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0437_ 
        = __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0313769__116__Vfuncout;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0604_ 
        = (VL_GTES_III(32, 0x7fU, VL_DIVS_III(32, vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____VdfgTmp_hf9d8f3b7__0, (IData)(4U))) 
           & VL_GTS_III(32, 0xffffff80U, VL_DIVS_III(32, vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____VdfgTmp_hf9d8f3b7__0, (IData)(4U))));
    vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0693_ 
        = (vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0887_ 
           - VL_MULS_III(32, (IData)(2U), (0x7fU & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3040_))));
    vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0806_ 
        = (vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0887_ 
           - VL_MULS_III(32, (IData)(2U), (0x7fU & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3043_))));
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031324__37__s 
        = (((6U == (7U & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___572_) 
                          >> 3U))) << 2U) | (((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___321_) 
                                              << 1U) 
                                             | (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___315_)));
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031324__37__b 
        = (2U | ((1U != (7U & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___572_) 
                               >> 6U))) << 2U));
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031324__37__Vfuncout 
        = (1U & ((1U == (1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031324__37__s)))
                  ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031324__37__b)
                  : ((2U == (2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031324__37__s)))
                      ? ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031324__37__b) 
                         >> 1U) : (IData)((((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031324__37__s) 
                                            & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031324__37__b)) 
                                           >> 2U)))));
    vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___330_ 
        = __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031324__37__Vfuncout;
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031321__36__s 
        = (((6U == (7U & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___572_) 
                          >> 3U))) << 2U) | (((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___321_) 
                                              << 1U) 
                                             | (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___315_)));
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031321__36__b 
        = (((QData)((IData)(((((1U != (7U & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___572_) 
                                             >> 6U)))
                                ? ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___648_) 
                                   - (IData)(1U)) : (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___584_)) 
                              << 0x10U) | (0xffffU 
                                           & ((IData)(1U) 
                                              + (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___648_)))))) 
            << 0x10U) | (QData)((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___584_)));
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031321__36__a 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___584_;
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031321__36__Vfuncout 
        = (0xffffU & ((1U == (1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031321__36__s)))
                       ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031321__36__b)
                       : ((2U == (2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031321__36__s)))
                           ? (IData)((__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031321__36__b 
                                      >> 0x10U)) : 
                          ((4U == (4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031321__36__s)))
                            ? (IData)((__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031321__36__b 
                                       >> 0x20U)) : (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031321__36__a)))));
    vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___329_ 
        = __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031321__36__Vfuncout;
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031325__38__s 
        = (((6U == (7U & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___572_) 
                          >> 3U))) << 2U) | (((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___321_) 
                                              << 1U) 
                                             | (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___315_)));
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031325__38__b 
        = (((QData)((IData)(((((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___648_) 
                               - (1U != (7U & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___572_) 
                                               >> 6U)))) 
                              << 0x10U) | (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___648_)))) 
            << 0x10U) | (QData)((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___648_)));
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031325__38__a 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___648_;
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031325__38__Vfuncout 
        = (0xffffU & ((1U == (1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031325__38__s)))
                       ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031325__38__b)
                       : ((2U == (2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031325__38__s)))
                           ? (IData)((__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031325__38__b 
                                      >> 0x10U)) : 
                          ((4U == (4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031325__38__s)))
                            ? (IData)((__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031325__38__b 
                                       >> 0x20U)) : (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031325__38__a)))));
    vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___331_ 
        = __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031325__38__Vfuncout;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___236_ 
        = ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____VdfgTmp_h3057e3d3__0) 
           ^ (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___649_));
    vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___232_ 
        = ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____VdfgTmp_h3057e3d3__0) 
           & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___649_));
    vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___216_ 
        = (0x1ffffU & ((IData)(1U) + ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___649_) 
                                      + (0xffffU & 
                                         (~ (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____VdfgTmp_h3057e3d3__0))))));
    vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___206_ 
        = (0x1ffffU & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___649_) 
                       + (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____VdfgTmp_h3057e3d3__0)));
    if (__Vdlyvset__intv_phoenix__DOT__intv__DOT__i_ivoice__DOT__regs__v0) {
        vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT__regs[__Vdlyvdim0__intv_phoenix__DOT__intv__DOT__i_ivoice__DOT__regs__v0] 
            = __Vdlyvval__intv_phoenix__DOT__intv__DOT__i_ivoice__DOT__regs__v0;
    }
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0312818__100__s 
        = (((0x14U == (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0706_)) 
            << 0xfU) | (((0x13U == (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0706_)) 
                         << 0xeU) | (((0x12U == (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0706_)) 
                                      << 0xdU) | ((
                                                   (0x11U 
                                                    == (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0706_)) 
                                                   << 0xcU) 
                                                  | (((0x10U 
                                                       == (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0706_)) 
                                                      << 0xbU) 
                                                     | (((0xfU 
                                                          == (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0706_)) 
                                                         << 0xaU) 
                                                        | (((0xeU 
                                                             == (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0706_)) 
                                                            << 9U) 
                                                           | (((0xdU 
                                                                == (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0706_)) 
                                                               << 8U) 
                                                              | (((0xcU 
                                                                   == (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0706_)) 
                                                                  << 7U) 
                                                                 | (((0xbU 
                                                                      == (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0706_)) 
                                                                     << 6U) 
                                                                    | (((0xaU 
                                                                         == (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0706_)) 
                                                                        << 5U) 
                                                                       | (((9U 
                                                                            == (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0706_)) 
                                                                           << 4U) 
                                                                          | (((8U 
                                                                               == (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0706_)) 
                                                                              << 3U) 
                                                                             | (((7U 
                                                                                == (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0706_)) 
                                                                                << 2U) 
                                                                                | (((6U 
                                                                                == (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0706_)) 
                                                                                << 1U) 
                                                                                | (5U 
                                                                                == (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0706_)))))))))))))))));
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0312818__100__a 
        = (0xfU & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___1058_) 
                   >> 0xaU));
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0312818__100__Vfuncout 
        = (((((((((1U == (1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0312818__100__s))) 
                  | (2U == (2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0312818__100__s)))) 
                 | (4U == (4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0312818__100__s)))) 
                | (8U == (8U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0312818__100__s)))) 
               | (0x10U == (0x10U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0312818__100__s)))) 
              | (0x20U == (0x20U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0312818__100__s)))) 
             | (0x40U == (0x40U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0312818__100__s)))) 
            | (0x80U == (0x80U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0312818__100__s))))
            ? ((1U == (1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0312818__100__s)))
                ? 0xfU : ((2U == (2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0312818__100__s)))
                           ? 1U : ((4U == (4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0312818__100__s)))
                                    ? 0xeU : ((8U == 
                                               (8U 
                                                & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0312818__100__s)))
                                               ? 0U
                                               : ((0x10U 
                                                   == 
                                                   (0x10U 
                                                    & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0312818__100__s)))
                                                   ? 2U
                                                   : 
                                                  ((0x20U 
                                                    == 
                                                    (0x20U 
                                                     & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0312818__100__s)))
                                                    ? 3U
                                                    : 
                                                   ((0x40U 
                                                     == 
                                                     (0x40U 
                                                      & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0312818__100__s)))
                                                     ? 4U
                                                     : 5U)))))))
            : (((((((((0x100U == (0x100U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0312818__100__s))) 
                      | (0x200U == (0x200U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0312818__100__s)))) 
                     | (0x400U == (0x400U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0312818__100__s)))) 
                    | (0x800U == (0x800U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0312818__100__s)))) 
                   | (0x1000U == (0x1000U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0312818__100__s)))) 
                  | (0x2000U == (0x2000U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0312818__100__s)))) 
                 | (0x4000U == (0x4000U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0312818__100__s)))) 
                | (0x8000U == (0x8000U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0312818__100__s))))
                ? ((0x100U == (0x100U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0312818__100__s)))
                    ? 6U : ((0x200U == (0x200U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0312818__100__s)))
                             ? 7U : ((0x400U == (0x400U 
                                                 & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0312818__100__s)))
                                      ? 8U : ((0x800U 
                                               == (0x800U 
                                                   & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0312818__100__s)))
                                               ? 9U
                                               : ((0x1000U 
                                                   == 
                                                   (0x1000U 
                                                    & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0312818__100__s)))
                                                   ? 0xaU
                                                   : 
                                                  ((0x2000U 
                                                    == 
                                                    (0x2000U 
                                                     & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0312818__100__s)))
                                                    ? 0xbU
                                                    : 
                                                   ((0x4000U 
                                                     == 
                                                     (0x4000U 
                                                      & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0312818__100__s)))
                                                     ? 0xcU
                                                     : 0xdU)))))))
                : (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0312818__100__a)));
    vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0155_ 
        = __Vfunc_intv_phoenix__DOT__intv__DOT__i_ivoice__DOT____0312818__100__Vfuncout;
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s 
        = (((6U == (7U & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___572_) 
                          >> 6U))) << 6U) | (((5U == 
                                               (7U 
                                                & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___572_) 
                                                   >> 6U))) 
                                              << 5U) 
                                             | (((4U 
                                                  == 
                                                  (7U 
                                                   & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___572_) 
                                                      >> 6U))) 
                                                 << 4U) 
                                                | (((3U 
                                                     == 
                                                     (7U 
                                                      & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___572_) 
                                                         >> 6U))) 
                                                    << 3U) 
                                                   | (((2U 
                                                        == 
                                                        (7U 
                                                         & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___572_) 
                                                            >> 6U))) 
                                                       << 2U) 
                                                      | (((1U 
                                                           == 
                                                           (7U 
                                                            & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___572_) 
                                                               >> 6U))) 
                                                          << 1U) 
                                                         | (0U 
                                                            == 
                                                            (7U 
                                                             & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___572_) 
                                                                >> 6U)))))))));
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U] 
        = (((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___648_) 
            << 0x10U) | (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___648_));
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[1U] 
        = (((0xffffU & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___648_)) 
            | ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___648_) 
               >> 0x10U)) | ((IData)((((QData)((IData)(
                                                       (((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___146_) 
                                                         << 0x10U) 
                                                        | (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___649_)))) 
                                       << 0x20U) | (QData)((IData)(
                                                                   ((vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___130_ 
                                                                     << 0x10U) 
                                                                    | (0xffffU 
                                                                       & vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___120_)))))) 
                             << 0x10U));
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[2U] 
        = (((IData)((((QData)((IData)((((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___146_) 
                                        << 0x10U) | (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___649_)))) 
                      << 0x20U) | (QData)((IData)((
                                                   (vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___130_ 
                                                    << 0x10U) 
                                                   | (0xffffU 
                                                      & vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___120_)))))) 
            >> 0x10U) | ((IData)(((((QData)((IData)(
                                                    (((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___146_) 
                                                      << 0x10U) 
                                                     | (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___649_)))) 
                                    << 0x20U) | (QData)((IData)(
                                                                ((vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___130_ 
                                                                  << 0x10U) 
                                                                 | (0xffffU 
                                                                    & vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___120_))))) 
                                  >> 0x20U)) << 0x10U));
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[3U] 
        = ((IData)(((((QData)((IData)((((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___146_) 
                                        << 0x10U) | (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___649_)))) 
                      << 0x20U) | (QData)((IData)((
                                                   (vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___130_ 
                                                    << 0x10U) 
                                                   | (0xffffU 
                                                      & vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___120_))))) 
                    >> 0x20U)) >> 0x10U);
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__a 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___150_;
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__Vfuncout 
        = (0xffffU & ((0x40U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                       ? ((0x20U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                           ? ((0x10U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                               ? ((8U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                   ? ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                       ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U]
                                               : __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[1U]))
                                       : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[1U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[1U] 
                                                     >> 0x10U)))))
                                   : ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                       ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U]
                                               : __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[1U]))
                                       : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U]
                                               : __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[2U]))))
                               : ((8U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                   ? ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                       ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U]
                                               : __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[1U]))
                                       : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[1U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[1U] 
                                                     >> 0x10U)))))
                                   : ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                       ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U]
                                               : __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[1U]))
                                       : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[2U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[2U] 
                                                     >> 0x10U)))))))
                           : ((0x10U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                               ? ((8U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                   ? ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                       ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U]
                                               : __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[1U]))
                                       : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[1U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[1U] 
                                                     >> 0x10U)))))
                                   : ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                       ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U]
                                               : __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[1U]))
                                       : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U]
                                               : __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[2U]))))
                               : ((8U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                   ? ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                       ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U]
                                               : __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[1U]))
                                       : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[1U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[1U] 
                                                     >> 0x10U)))))
                                   : ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                       ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U]
                                               : __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[1U]))
                                       : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U]
                                               : __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[3U]))))))
                       : ((0x20U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                           ? ((0x10U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                               ? ((8U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                   ? ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                       ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U]
                                               : __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[1U]))
                                       : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[1U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[1U] 
                                                     >> 0x10U)))))
                                   : ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                       ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U]
                                               : __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[1U]))
                                       : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U]
                                               : __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[2U]))))
                               : ((8U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                   ? ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                       ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U]
                                               : __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[1U]))
                                       : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[1U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[1U] 
                                                     >> 0x10U)))))
                                   : ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                       ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U]
                                               : __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[1U]))
                                       : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[2U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[2U] 
                                                     >> 0x10U)))))))
                           : ((0x10U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                               ? ((8U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                   ? ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                       ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U]
                                               : __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[1U]))
                                       : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[1U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[1U] 
                                                     >> 0x10U)))))
                                   : ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                       ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U]
                                               : __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[1U]))
                                       : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U]
                                               : __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[2U]))))
                               : ((8U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                   ? ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                       ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U]
                                               : __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[1U]))
                                       : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[1U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[1U] 
                                                     >> 0x10U)))))
                                   : ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                       ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U]
                                               : __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[1U]))
                                       : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__b[0U]
                                               : (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__a)))))))));
    vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___153_ 
        = __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____03686__91__Vfuncout;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___133_ 
        = ((((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___649_) 
             ^ vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___130_) 
            >> 0xfU) & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___141_));
    vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___260_ 
        = ((((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___649_) 
             ^ vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___257_) 
            >> 0xfU) & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___404_));
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s 
        = (((6U == (7U & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___572_) 
                          >> 6U))) << 6U) | (((5U == 
                                               (7U 
                                                & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___572_) 
                                                   >> 6U))) 
                                              << 5U) 
                                             | (((4U 
                                                  == 
                                                  (7U 
                                                   & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___572_) 
                                                      >> 6U))) 
                                                 << 4U) 
                                                | (((3U 
                                                     == 
                                                     (7U 
                                                      & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___572_) 
                                                         >> 6U))) 
                                                    << 3U) 
                                                   | (((2U 
                                                        == 
                                                        (7U 
                                                         & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___572_) 
                                                            >> 6U))) 
                                                       << 2U) 
                                                      | (((1U 
                                                           == 
                                                           (7U 
                                                            & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___572_) 
                                                               >> 6U))) 
                                                          << 1U) 
                                                         | (0U 
                                                            == 
                                                            (7U 
                                                             & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___572_) 
                                                                >> 6U)))))))));
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U] 
        = (((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3050_) 
            << 0x10U) | (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3050_));
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[1U] 
        = (((0xffffU & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3050_)) 
            | ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3050_) 
               >> 0x10U)) | ((IData)((((QData)((IData)(
                                                       (((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___273_) 
                                                         << 0x10U) 
                                                        | (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___649_)))) 
                                       << 0x20U) | (QData)((IData)(
                                                                   ((vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___257_ 
                                                                     << 0x10U) 
                                                                    | (0xffffU 
                                                                       & vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___247_)))))) 
                             << 0x10U));
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[2U] 
        = (((IData)((((QData)((IData)((((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___273_) 
                                        << 0x10U) | (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___649_)))) 
                      << 0x20U) | (QData)((IData)((
                                                   (vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___257_ 
                                                    << 0x10U) 
                                                   | (0xffffU 
                                                      & vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___247_)))))) 
            >> 0x10U) | ((IData)(((((QData)((IData)(
                                                    (((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___273_) 
                                                      << 0x10U) 
                                                     | (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___649_)))) 
                                    << 0x20U) | (QData)((IData)(
                                                                ((vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___257_ 
                                                                  << 0x10U) 
                                                                 | (0xffffU 
                                                                    & vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___247_))))) 
                                  >> 0x20U)) << 0x10U));
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[3U] 
        = ((IData)(((((QData)((IData)((((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___273_) 
                                        << 0x10U) | (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___649_)))) 
                      << 0x20U) | (QData)((IData)((
                                                   (vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___257_ 
                                                    << 0x10U) 
                                                   | (0xffffU 
                                                      & vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___247_))))) 
                    >> 0x20U)) >> 0x10U);
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__a 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___277_;
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__Vfuncout 
        = (0xffffU & ((0x40U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                       ? ((0x20U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                           ? ((0x10U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                               ? ((8U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                   ? ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                       ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U]
                                               : __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[1U]))
                                       : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[1U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[1U] 
                                                     >> 0x10U)))))
                                   : ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                       ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U]
                                               : __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[1U]))
                                       : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U]
                                               : __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[2U]))))
                               : ((8U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                   ? ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                       ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U]
                                               : __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[1U]))
                                       : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[1U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[1U] 
                                                     >> 0x10U)))))
                                   : ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                       ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U]
                                               : __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[1U]))
                                       : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[2U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[2U] 
                                                     >> 0x10U)))))))
                           : ((0x10U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                               ? ((8U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                   ? ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                       ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U]
                                               : __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[1U]))
                                       : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[1U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[1U] 
                                                     >> 0x10U)))))
                                   : ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                       ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U]
                                               : __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[1U]))
                                       : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U]
                                               : __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[2U]))))
                               : ((8U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                   ? ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                       ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U]
                                               : __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[1U]))
                                       : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[1U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[1U] 
                                                     >> 0x10U)))))
                                   : ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                       ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U]
                                               : __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[1U]))
                                       : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U]
                                               : __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[3U]))))))
                       : ((0x20U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                           ? ((0x10U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                               ? ((8U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                   ? ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                       ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U]
                                               : __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[1U]))
                                       : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[1U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[1U] 
                                                     >> 0x10U)))))
                                   : ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                       ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U]
                                               : __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[1U]))
                                       : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U]
                                               : __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[2U]))))
                               : ((8U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                   ? ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                       ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U]
                                               : __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[1U]))
                                       : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[1U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[1U] 
                                                     >> 0x10U)))))
                                   : ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                       ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U]
                                               : __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[1U]))
                                       : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[2U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[2U] 
                                                     >> 0x10U)))))))
                           : ((0x10U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                               ? ((8U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                   ? ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                       ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U]
                                               : __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[1U]))
                                       : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[1U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[1U] 
                                                     >> 0x10U)))))
                                   : ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                       ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U]
                                               : __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[1U]))
                                       : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U]
                                               : __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[2U]))))
                               : ((8U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                   ? ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                       ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U]
                                               : __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[1U]))
                                       : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[1U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[1U] 
                                                     >> 0x10U)))))
                                   : ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                       ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U]
                                               : __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[1U]))
                                       : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__b[0U]
                                               : (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__a)))))))));
    vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___280_ 
        = __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031215__31__Vfuncout;
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s 
        = (((6U == (7U & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___572_) 
                          >> 6U))) << 6U) | (((5U == 
                                               (7U 
                                                & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___572_) 
                                                   >> 6U))) 
                                              << 5U) 
                                             | (((4U 
                                                  == 
                                                  (7U 
                                                   & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___572_) 
                                                      >> 6U))) 
                                                 << 4U) 
                                                | (((3U 
                                                     == 
                                                     (7U 
                                                      & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___572_) 
                                                         >> 6U))) 
                                                    << 3U) 
                                                   | (((2U 
                                                        == 
                                                        (7U 
                                                         & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___572_) 
                                                            >> 6U))) 
                                                       << 2U) 
                                                      | (((1U 
                                                           == 
                                                           (7U 
                                                            & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___572_) 
                                                               >> 6U))) 
                                                          << 1U) 
                                                         | (0U 
                                                            == 
                                                            (7U 
                                                             & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___572_) 
                                                                >> 6U)))))))));
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U] 
        = (((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3050_) 
            << 0x10U) | (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3050_));
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[1U] 
        = (((0xffffU & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3050_)) 
            | ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3050_) 
               >> 0x10U)) | ((IData)((((QData)((IData)(
                                                       (((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___273_) 
                                                         << 0x10U) 
                                                        | (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___649_)))) 
                                       << 0x20U) | (QData)((IData)(
                                                                   ((vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___257_ 
                                                                     << 0x10U) 
                                                                    | (0xffffU 
                                                                       & vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___247_)))))) 
                             << 0x10U));
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[2U] 
        = (((IData)((((QData)((IData)((((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___273_) 
                                        << 0x10U) | (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___649_)))) 
                      << 0x20U) | (QData)((IData)((
                                                   (vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___257_ 
                                                    << 0x10U) 
                                                   | (0xffffU 
                                                      & vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___247_)))))) 
            >> 0x10U) | ((IData)(((((QData)((IData)(
                                                    (((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___273_) 
                                                      << 0x10U) 
                                                     | (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___649_)))) 
                                    << 0x20U) | (QData)((IData)(
                                                                ((vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___257_ 
                                                                  << 0x10U) 
                                                                 | (0xffffU 
                                                                    & vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___247_))))) 
                                  >> 0x20U)) << 0x10U));
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[3U] 
        = ((IData)(((((QData)((IData)((((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___273_) 
                                        << 0x10U) | (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___649_)))) 
                      << 0x20U) | (QData)((IData)((
                                                   (vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___257_ 
                                                    << 0x10U) 
                                                   | (0xffffU 
                                                      & vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___247_))))) 
                    >> 0x20U)) >> 0x10U);
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__a 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___277_;
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__Vfuncout 
        = (0xffffU & ((0x40U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                       ? ((0x20U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                           ? ((0x10U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                               ? ((8U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                   ? ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                       ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U]
                                               : __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[1U]))
                                       : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[1U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[1U] 
                                                     >> 0x10U)))))
                                   : ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                       ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U]
                                               : __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[1U]))
                                       : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U]
                                               : __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[2U]))))
                               : ((8U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                   ? ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                       ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U]
                                               : __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[1U]))
                                       : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[1U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[1U] 
                                                     >> 0x10U)))))
                                   : ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                       ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U]
                                               : __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[1U]))
                                       : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[2U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[2U] 
                                                     >> 0x10U)))))))
                           : ((0x10U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                               ? ((8U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                   ? ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                       ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U]
                                               : __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[1U]))
                                       : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[1U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[1U] 
                                                     >> 0x10U)))))
                                   : ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                       ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U]
                                               : __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[1U]))
                                       : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U]
                                               : __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[2U]))))
                               : ((8U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                   ? ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                       ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U]
                                               : __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[1U]))
                                       : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[1U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[1U] 
                                                     >> 0x10U)))))
                                   : ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                       ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U]
                                               : __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[1U]))
                                       : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U]
                                               : __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[3U]))))))
                       : ((0x20U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                           ? ((0x10U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                               ? ((8U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                   ? ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                       ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U]
                                               : __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[1U]))
                                       : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[1U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[1U] 
                                                     >> 0x10U)))))
                                   : ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                       ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U]
                                               : __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[1U]))
                                       : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U]
                                               : __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[2U]))))
                               : ((8U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                   ? ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                       ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U]
                                               : __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[1U]))
                                       : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[1U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[1U] 
                                                     >> 0x10U)))))
                                   : ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                       ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U]
                                               : __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[1U]))
                                       : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[2U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[2U] 
                                                     >> 0x10U)))))))
                           : ((0x10U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                               ? ((8U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                   ? ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                       ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U]
                                               : __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[1U]))
                                       : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[1U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[1U] 
                                                     >> 0x10U)))))
                                   : ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                       ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U]
                                               : __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[1U]))
                                       : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U]
                                               : __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[2U]))))
                               : ((8U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                   ? ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                       ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U]
                                               : __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[1U]))
                                       : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[1U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[1U] 
                                                     >> 0x10U)))))
                                   : ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                       ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U]
                                               : __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[1U]))
                                       : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__b[0U]
                                               : (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__a)))))))));
    vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___416_ 
        = __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031645__44__Vfuncout;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___251_ 
        = (1U & ((~ (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___404_)) 
                 & (((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___649_) 
                     ^ vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___247_) 
                    >> 0xfU)));
    if (((IData)(vlSelf->intv_phoenix__DOT__fwd_byte_ready) 
         & (~ (IData)(vlSelf->intv_phoenix__DOT__fwd_discard)))) {
        __Vfunc_intv_phoenix__DOT__crc32_byte__13__d 
            = vlSelf->intv_phoenix__DOT__spi_rx;
        __Vfunc_intv_phoenix__DOT__crc32_byte__13__c 
            = vlSelf->intv_phoenix__DOT__crc;
        vlSelf->intv_phoenix__DOT__ld_data = vlSelf->intv_phoenix__DOT__spi_rx;
        vlSelf->intv_phoenix__DOT__ld_pend = 1U;
        vlSelf->intv_phoenix__DOT__crc32_byte__Vstatic__r 
            = (__Vfunc_intv_phoenix__DOT__crc32_byte__13__c 
               ^ (IData)(__Vfunc_intv_phoenix__DOT__crc32_byte__13__d));
        vlSelf->intv_phoenix__DOT__crc32_byte__Vstatic__r 
            = ((1U & vlSelf->intv_phoenix__DOT__crc32_byte__Vstatic__r)
                ? (0xedb88320U ^ (vlSelf->intv_phoenix__DOT__crc32_byte__Vstatic__r 
                                  >> 1U)) : (vlSelf->intv_phoenix__DOT__crc32_byte__Vstatic__r 
                                             >> 1U));
        vlSelf->intv_phoenix__DOT__crc32_byte__Vstatic__r 
            = ((1U & vlSelf->intv_phoenix__DOT__crc32_byte__Vstatic__r)
                ? (0xedb88320U ^ (vlSelf->intv_phoenix__DOT__crc32_byte__Vstatic__r 
                                  >> 1U)) : (vlSelf->intv_phoenix__DOT__crc32_byte__Vstatic__r 
                                             >> 1U));
        vlSelf->intv_phoenix__DOT__crc32_byte__Vstatic__r 
            = ((1U & vlSelf->intv_phoenix__DOT__crc32_byte__Vstatic__r)
                ? (0xedb88320U ^ (vlSelf->intv_phoenix__DOT__crc32_byte__Vstatic__r 
                                  >> 1U)) : (vlSelf->intv_phoenix__DOT__crc32_byte__Vstatic__r 
                                             >> 1U));
        vlSelf->intv_phoenix__DOT__crc32_byte__Vstatic__r 
            = ((1U & vlSelf->intv_phoenix__DOT__crc32_byte__Vstatic__r)
                ? (0xedb88320U ^ (vlSelf->intv_phoenix__DOT__crc32_byte__Vstatic__r 
                                  >> 1U)) : (vlSelf->intv_phoenix__DOT__crc32_byte__Vstatic__r 
                                             >> 1U));
        vlSelf->intv_phoenix__DOT__crc32_byte__Vstatic__r 
            = ((1U & vlSelf->intv_phoenix__DOT__crc32_byte__Vstatic__r)
                ? (0xedb88320U ^ (vlSelf->intv_phoenix__DOT__crc32_byte__Vstatic__r 
                                  >> 1U)) : (vlSelf->intv_phoenix__DOT__crc32_byte__Vstatic__r 
                                             >> 1U));
        vlSelf->intv_phoenix__DOT__crc32_byte__Vstatic__r 
            = ((1U & vlSelf->intv_phoenix__DOT__crc32_byte__Vstatic__r)
                ? (0xedb88320U ^ (vlSelf->intv_phoenix__DOT__crc32_byte__Vstatic__r 
                                  >> 1U)) : (vlSelf->intv_phoenix__DOT__crc32_byte__Vstatic__r 
                                             >> 1U));
        vlSelf->intv_phoenix__DOT__crc32_byte__Vstatic__r 
            = ((1U & vlSelf->intv_phoenix__DOT__crc32_byte__Vstatic__r)
                ? (0xedb88320U ^ (vlSelf->intv_phoenix__DOT__crc32_byte__Vstatic__r 
                                  >> 1U)) : (vlSelf->intv_phoenix__DOT__crc32_byte__Vstatic__r 
                                             >> 1U));
        vlSelf->intv_phoenix__DOT__crc32_byte__Vstatic__r 
            = ((1U & vlSelf->intv_phoenix__DOT__crc32_byte__Vstatic__r)
                ? (0xedb88320U ^ (vlSelf->intv_phoenix__DOT__crc32_byte__Vstatic__r 
                                  >> 1U)) : (vlSelf->intv_phoenix__DOT__crc32_byte__Vstatic__r 
                                             >> 1U));
        __Vfunc_intv_phoenix__DOT__crc32_byte__13__Vfuncout 
            = vlSelf->intv_phoenix__DOT__crc32_byte__Vstatic__r;
        __Vdly__intv_phoenix__DOT__crc = __Vfunc_intv_phoenix__DOT__crc32_byte__13__Vfuncout;
    }
    if ((4U & (IData)(vlSelf->intv_phoenix__DOT__reset_s))) {
        vlSelf->intv_phoenix__DOT__ld_pend = 0U;
    }
    if (vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3060_) {
        vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___031_ 
            = vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3059_;
        vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___036_ 
            = vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3059_;
    } else {
        vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___031_ 
            = vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___206_;
        vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___036_ 
            = vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___209_;
    }
    vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___052_ 
        = ((~ (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3060_)) 
           & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___212_));
    vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___032_ 
        = ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___212_) 
           | (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3060_));
    vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___047_ 
        = ((~ (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3060_)) 
           & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___215_));
    vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___037_ 
        = ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___215_) 
           | (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3060_));
    vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___075_ 
        = ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___234_) 
           | (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3060_));
    vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___034_ 
        = ((~ (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3060_)) 
           & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___234_));
    vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___187_ 
        = ((~ (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___272_)) 
           & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_jlp__DOT___271_));
    vlSelf->intv_phoenix__DOT__menu_m = vlSelf->intv_phoenix__DOT__menu_pad;
    vlSelf->intv_phoenix__DOT__mkey_m = vlSelf->intv_phoenix__DOT__menu_key;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0398_ 
        = ((IData)(0x4000U) + ((0x80000000U & (vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0693_ 
                                               << 0x11U)) 
                               | ((0x40000000U & (vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0693_ 
                                                  << 0x10U)) 
                                  | ((0x20000000U & 
                                      (vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0693_ 
                                       << 0xfU)) | 
                                     ((0x10000000U 
                                       & (vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0693_ 
                                          << 0xeU)) 
                                      | ((0x8000000U 
                                          & (vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0693_ 
                                             << 0xdU)) 
                                         | ((0x4000000U 
                                             & (vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0693_ 
                                                << 0xcU)) 
                                            | ((0x2000000U 
                                                & (vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0693_ 
                                                   << 0xbU)) 
                                               | ((0x1000000U 
                                                   & (vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0693_ 
                                                      << 0xaU)) 
                                                  | ((0x800000U 
                                                      & (vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0693_ 
                                                         << 9U)) 
                                                     | ((0x400000U 
                                                         & (vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0693_ 
                                                            << 8U)) 
                                                        | ((0x200000U 
                                                            & (vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0693_ 
                                                               << 7U)) 
                                                           | ((0x100000U 
                                                               & (vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0693_ 
                                                                  << 6U)) 
                                                              | ((0x80000U 
                                                                  & (vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0693_ 
                                                                     << 5U)) 
                                                                 | ((0x40000U 
                                                                     & (vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0693_ 
                                                                        << 4U)) 
                                                                    | ((0x20000U 
                                                                        & (vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0693_ 
                                                                           << 3U)) 
                                                                       | ((0x10000U 
                                                                           & (vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0693_ 
                                                                              << 2U)) 
                                                                          | ((0x8000U 
                                                                              & (vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0693_ 
                                                                                << 1U)) 
                                                                             | (0x7fffU 
                                                                                & vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0693_)))))))))))))))))));
    vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT____VdfgTmp_hdfca5609__0 
        = ((0x80000000U & (vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0806_ 
                           << 0x15U)) | ((0x40000000U 
                                          & (vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0806_ 
                                             << 0x14U)) 
                                         | ((0x20000000U 
                                             & (vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0806_ 
                                                << 0x13U)) 
                                            | ((0x10000000U 
                                                & (vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0806_ 
                                                   << 0x12U)) 
                                               | ((0x8000000U 
                                                   & (vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0806_ 
                                                      << 0x11U)) 
                                                  | ((0x4000000U 
                                                      & (vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0806_ 
                                                         << 0x10U)) 
                                                     | ((0x2000000U 
                                                         & (vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0806_ 
                                                            << 0xfU)) 
                                                        | ((0x1000000U 
                                                            & (vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0806_ 
                                                               << 0xeU)) 
                                                           | ((0x800000U 
                                                               & (vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0806_ 
                                                                  << 0xdU)) 
                                                              | ((0x400000U 
                                                                  & (vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0806_ 
                                                                     << 0xcU)) 
                                                                 | ((0x200000U 
                                                                     & (vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0806_ 
                                                                        << 0xbU)) 
                                                                    | ((0x100000U 
                                                                        & (vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0806_ 
                                                                           << 0xaU)) 
                                                                       | ((0x80000U 
                                                                           & (vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0806_ 
                                                                              << 9U)) 
                                                                          | ((0x40000U 
                                                                              & (vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0806_ 
                                                                                << 8U)) 
                                                                             | ((0x20000U 
                                                                                & (vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0806_ 
                                                                                << 7U)) 
                                                                                | ((0x10000U 
                                                                                & (vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0806_ 
                                                                                << 6U)) 
                                                                                | ((0x8000U 
                                                                                & (vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0806_ 
                                                                                << 5U)) 
                                                                                | ((0x4000U 
                                                                                & (vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0806_ 
                                                                                << 4U)) 
                                                                                | ((0x2000U 
                                                                                & (vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0806_ 
                                                                                << 3U)) 
                                                                                | ((0x1000U 
                                                                                & (vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0806_ 
                                                                                << 2U)) 
                                                                                | ((0x800U 
                                                                                & (vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0806_ 
                                                                                << 1U)) 
                                                                                | (0x7ffU 
                                                                                & vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0806_))))))))))))))))))))));
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310004__252__s 
        = (((0xbU == (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2953_)) 
            << 4U) | (((0xaU == (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2953_)) 
                       << 3U) | (((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0857_) 
                                  << 2U) | (((1U == (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2953_)) 
                                             << 1U) 
                                            | (0U == (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2953_))))));
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310004__252__b 
        = (1U & (~ (VL_GTS_III(32, 0xe3U, (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2947_)) 
                    | VL_GTS_III(32, 0x105U, (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2950_)))));
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310004__252__Vfuncout 
        = (1U & ((0x10U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310004__252__s))
                  ? ((8U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310004__252__s))
                      ? ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310004__252__s))
                          ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310004__252__s))
                              ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310004__252__s))
                                  ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310004__252__b)
                                  : ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310004__252__b) 
                                     >> 1U)) : ((1U 
                                                 & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310004__252__s))
                                                 ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310004__252__b)
                                                 : 
                                                ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310004__252__b) 
                                                 >> 2U)))
                          : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310004__252__s))
                              ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310004__252__s))
                                  ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310004__252__b)
                                  : ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310004__252__b) 
                                     >> 1U)) : ((1U 
                                                 & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310004__252__s))
                                                 ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310004__252__b)
                                                 : 
                                                ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310004__252__b) 
                                                 >> 3U))))
                      : ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310004__252__s))
                          ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310004__252__s))
                              ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310004__252__s))
                                  ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310004__252__b)
                                  : ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310004__252__b) 
                                     >> 1U)) : ((1U 
                                                 & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310004__252__s))
                                                 ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310004__252__b)
                                                 : 
                                                ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310004__252__b) 
                                                 >> 2U)))
                          : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310004__252__s))
                              ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310004__252__s))
                                  ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310004__252__b)
                                  : ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310004__252__b) 
                                     >> 1U)) : ((1U 
                                                 & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310004__252__s))
                                                 ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310004__252__b)
                                                 : 
                                                ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310004__252__b) 
                                                 >> 4U)))))
                  : ((8U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310004__252__s))
                      ? ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310004__252__s))
                          ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310004__252__s))
                              ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310004__252__s))
                                  ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310004__252__b)
                                  : ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310004__252__b) 
                                     >> 1U)) : ((1U 
                                                 & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310004__252__s))
                                                 ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310004__252__b)
                                                 : 
                                                ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310004__252__b) 
                                                 >> 2U)))
                          : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310004__252__s))
                              ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310004__252__s))
                                  ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310004__252__b)
                                  : ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310004__252__b) 
                                     >> 1U)) : ((1U 
                                                 & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310004__252__s))
                                                 ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310004__252__b)
                                                 : 
                                                ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310004__252__b) 
                                                 >> 3U))))
                      : ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310004__252__s))
                          ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310004__252__s))
                              ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310004__252__s))
                                  ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310004__252__b)
                                  : ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310004__252__b) 
                                     >> 1U)) : ((1U 
                                                 & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310004__252__s))
                                                 ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310004__252__b)
                                                 : 
                                                ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310004__252__b) 
                                                 >> 2U)))
                          : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310004__252__s))
                              ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310004__252__s))
                                  ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310004__252__b)
                                  : ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310004__252__b) 
                                     >> 1U)) : ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310004__252__s) 
                                                & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310004__252__b)))))));
    vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2694_ 
        = __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310004__252__Vfuncout;
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310006__253__s 
        = (((0xbU == (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2953_)) 
            << 4U) | (((0xaU == (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2953_)) 
                       << 3U) | (((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0857_) 
                                  << 2U) | (((1U == (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2953_)) 
                                             << 1U) 
                                            | (0U == (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2953_))))));
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310006__253__b 
        = ((0x1ffffffffe00ULL & (((QData)((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2947_)) 
                                  << 0x24U) | (((QData)((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2947_)) 
                                                << 0x1bU) 
                                               | (((QData)((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2947_)) 
                                                   << 0x12U) 
                                                  | ((QData)((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2947_)) 
                                                     << 9U))))) 
           | (QData)((IData)((VL_GTS_III(32, 0xe3U, (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2947_))
                               ? (0x1ffU & ((IData)(1U) 
                                            + (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2947_)))
                               : 0U))));
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310006__253__a 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2947_;
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310006__253__Vfuncout 
        = (0x1ffU & ((0x10U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310006__253__s))
                      ? ((8U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310006__253__s))
                          ? ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310006__253__s))
                              ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310006__253__s))
                                  ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310006__253__s))
                                      ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310006__253__b)
                                      : (IData)((__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310006__253__b 
                                                 >> 9U)))
                                  : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310006__253__s))
                                      ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310006__253__b)
                                      : (IData)((__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310006__253__b 
                                                 >> 0x12U))))
                              : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310006__253__s))
                                  ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310006__253__s))
                                      ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310006__253__b)
                                      : (IData)((__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310006__253__b 
                                                 >> 9U)))
                                  : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310006__253__s))
                                      ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310006__253__b)
                                      : (IData)((__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310006__253__b 
                                                 >> 0x1bU)))))
                          : ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310006__253__s))
                              ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310006__253__s))
                                  ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310006__253__s))
                                      ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310006__253__b)
                                      : (IData)((__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310006__253__b 
                                                 >> 9U)))
                                  : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310006__253__s))
                                      ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310006__253__b)
                                      : (IData)((__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310006__253__b 
                                                 >> 0x12U))))
                              : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310006__253__s))
                                  ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310006__253__s))
                                      ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310006__253__b)
                                      : (IData)((__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310006__253__b 
                                                 >> 9U)))
                                  : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310006__253__s))
                                      ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310006__253__b)
                                      : (IData)((__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310006__253__b 
                                                 >> 0x24U))))))
                      : ((8U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310006__253__s))
                          ? ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310006__253__s))
                              ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310006__253__s))
                                  ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310006__253__s))
                                      ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310006__253__b)
                                      : (IData)((__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310006__253__b 
                                                 >> 9U)))
                                  : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310006__253__s))
                                      ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310006__253__b)
                                      : (IData)((__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310006__253__b 
                                                 >> 0x12U))))
                              : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310006__253__s))
                                  ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310006__253__s))
                                      ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310006__253__b)
                                      : (IData)((__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310006__253__b 
                                                 >> 9U)))
                                  : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310006__253__s))
                                      ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310006__253__b)
                                      : (IData)((__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310006__253__b 
                                                 >> 0x1bU)))))
                          : ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310006__253__s))
                              ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310006__253__s))
                                  ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310006__253__s))
                                      ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310006__253__b)
                                      : (IData)((__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310006__253__b 
                                                 >> 9U)))
                                  : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310006__253__s))
                                      ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310006__253__b)
                                      : (IData)((__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310006__253__b 
                                                 >> 0x12U))))
                              : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310006__253__s))
                                  ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310006__253__s))
                                      ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310006__253__b)
                                      : (IData)((__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310006__253__b 
                                                 >> 9U)))
                                  : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310006__253__s))
                                      ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310006__253__b)
                                      : (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310006__253__a)))))));
    vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2695_ 
        = __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310006__253__Vfuncout;
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310007__254__s 
        = (((0xbU == (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2953_)) 
            << 4U) | (((0xaU == (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2953_)) 
                       << 3U) | (((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0857_) 
                                  << 2U) | (((1U == (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2953_)) 
                                             << 1U) 
                                            | (0U == (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2953_))))));
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310007__254__b 
        = ((0x1ffffffffe00ULL & (((QData)((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2950_)) 
                                  << 0x24U) | (((QData)((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2950_)) 
                                                << 0x1bU) 
                                               | (((QData)((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2950_)) 
                                                   << 0x12U) 
                                                  | ((QData)((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2950_)) 
                                                     << 9U))))) 
           | (QData)((IData)((0x1ffU & (VL_GTS_III(32, 0xe3U, (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2947_))
                                         ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2950_)
                                         : (VL_GTS_III(32, 0x105U, (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2950_))
                                             ? ((IData)(1U) 
                                                + (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2950_))
                                             : 0U))))));
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310007__254__a 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2950_;
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310007__254__Vfuncout 
        = (0x1ffU & ((0x10U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310007__254__s))
                      ? ((8U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310007__254__s))
                          ? ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310007__254__s))
                              ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310007__254__s))
                                  ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310007__254__s))
                                      ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310007__254__b)
                                      : (IData)((__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310007__254__b 
                                                 >> 9U)))
                                  : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310007__254__s))
                                      ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310007__254__b)
                                      : (IData)((__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310007__254__b 
                                                 >> 0x12U))))
                              : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310007__254__s))
                                  ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310007__254__s))
                                      ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310007__254__b)
                                      : (IData)((__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310007__254__b 
                                                 >> 9U)))
                                  : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310007__254__s))
                                      ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310007__254__b)
                                      : (IData)((__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310007__254__b 
                                                 >> 0x1bU)))))
                          : ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310007__254__s))
                              ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310007__254__s))
                                  ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310007__254__s))
                                      ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310007__254__b)
                                      : (IData)((__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310007__254__b 
                                                 >> 9U)))
                                  : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310007__254__s))
                                      ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310007__254__b)
                                      : (IData)((__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310007__254__b 
                                                 >> 0x12U))))
                              : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310007__254__s))
                                  ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310007__254__s))
                                      ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310007__254__b)
                                      : (IData)((__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310007__254__b 
                                                 >> 9U)))
                                  : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310007__254__s))
                                      ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310007__254__b)
                                      : (IData)((__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310007__254__b 
                                                 >> 0x24U))))))
                      : ((8U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310007__254__s))
                          ? ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310007__254__s))
                              ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310007__254__s))
                                  ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310007__254__s))
                                      ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310007__254__b)
                                      : (IData)((__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310007__254__b 
                                                 >> 9U)))
                                  : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310007__254__s))
                                      ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310007__254__b)
                                      : (IData)((__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310007__254__b 
                                                 >> 0x12U))))
                              : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310007__254__s))
                                  ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310007__254__s))
                                      ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310007__254__b)
                                      : (IData)((__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310007__254__b 
                                                 >> 9U)))
                                  : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310007__254__s))
                                      ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310007__254__b)
                                      : (IData)((__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310007__254__b 
                                                 >> 0x1bU)))))
                          : ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310007__254__s))
                              ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310007__254__s))
                                  ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310007__254__s))
                                      ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310007__254__b)
                                      : (IData)((__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310007__254__b 
                                                 >> 9U)))
                                  : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310007__254__s))
                                      ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310007__254__b)
                                      : (IData)((__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310007__254__b 
                                                 >> 0x12U))))
                              : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310007__254__s))
                                  ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310007__254__s))
                                      ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310007__254__b)
                                      : (IData)((__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310007__254__b 
                                                 >> 9U)))
                                  : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310007__254__s))
                                      ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310007__254__b)
                                      : (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310007__254__a)))))));
    vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2696_ 
        = __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310007__254__Vfuncout;
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310012__257__s 
        = (((0xbU == (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2953_)) 
            << 4U) | (((0xaU == (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2953_)) 
                       << 3U) | (((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0857_) 
                                  << 2U) | (((1U == (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2953_)) 
                                             << 1U) 
                                            | (0U == (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2953_))))));
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310012__257__b 
        = (((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2999_) 
            << 8U) | (((((0U == (0xfU & vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0887_)) 
                         & (0U == (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2947_)))
                         ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2996_)
                         : (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2999_)) 
                       << 6U) | (((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2999_) 
                                  << 4U) | (((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2999_) 
                                             << 2U) 
                                            | (VL_GTS_III(32, 0xe3U, (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2947_))
                                                ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2999_)
                                                : (
                                                   VL_GTS_III(32, 0x105U, (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2950_))
                                                    ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2999_)
                                                    : 0U))))));
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310012__257__a 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2999_;
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310012__257__Vfuncout 
        = (3U & ((0x10U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310012__257__s))
                  ? ((8U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310012__257__s))
                      ? ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310012__257__s))
                          ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310012__257__s))
                              ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310012__257__s))
                                  ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310012__257__b)
                                  : ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310012__257__b) 
                                     >> 2U)) : ((1U 
                                                 & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310012__257__s))
                                                 ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310012__257__b)
                                                 : 
                                                ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310012__257__b) 
                                                 >> 4U)))
                          : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310012__257__s))
                              ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310012__257__s))
                                  ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310012__257__b)
                                  : ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310012__257__b) 
                                     >> 2U)) : ((1U 
                                                 & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310012__257__s))
                                                 ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310012__257__b)
                                                 : 
                                                ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310012__257__b) 
                                                 >> 6U))))
                      : ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310012__257__s))
                          ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310012__257__s))
                              ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310012__257__s))
                                  ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310012__257__b)
                                  : ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310012__257__b) 
                                     >> 2U)) : ((1U 
                                                 & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310012__257__s))
                                                 ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310012__257__b)
                                                 : 
                                                ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310012__257__b) 
                                                 >> 4U)))
                          : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310012__257__s))
                              ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310012__257__s))
                                  ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310012__257__b)
                                  : ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310012__257__b) 
                                     >> 2U)) : ((1U 
                                                 & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310012__257__s))
                                                 ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310012__257__b)
                                                 : 
                                                ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310012__257__b) 
                                                 >> 8U)))))
                  : ((8U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310012__257__s))
                      ? ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310012__257__s))
                          ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310012__257__s))
                              ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310012__257__s))
                                  ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310012__257__b)
                                  : ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310012__257__b) 
                                     >> 2U)) : ((1U 
                                                 & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310012__257__s))
                                                 ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310012__257__b)
                                                 : 
                                                ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310012__257__b) 
                                                 >> 4U)))
                          : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310012__257__s))
                              ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310012__257__s))
                                  ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310012__257__b)
                                  : ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310012__257__b) 
                                     >> 2U)) : ((1U 
                                                 & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310012__257__s))
                                                 ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310012__257__b)
                                                 : 
                                                ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310012__257__b) 
                                                 >> 6U))))
                      : ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310012__257__s))
                          ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310012__257__s))
                              ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310012__257__s))
                                  ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310012__257__b)
                                  : ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310012__257__b) 
                                     >> 2U)) : ((1U 
                                                 & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310012__257__s))
                                                 ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310012__257__b)
                                                 : 
                                                ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310012__257__b) 
                                                 >> 4U)))
                          : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310012__257__s))
                              ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310012__257__s))
                                  ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310012__257__b)
                                  : ((IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310012__257__b) 
                                     >> 2U)) : ((1U 
                                                 & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310012__257__s))
                                                 ? (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310012__257__b)
                                                 : (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310012__257__a)))))));
    vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2699_ 
        = __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____0310012__257__Vfuncout;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0769_ 
        = ((0xdcU == (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2950_)) 
           & (0U == (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2947_)));
    vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT____VdfgTmp_h7dbc3dfb__0 
        = (7U & (((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2947_) 
                  - (IData)(6U)) - (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3006_)));
    vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0938_ 
        = (VL_GTS_III(32, 0xadU, (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2947_)) 
           & VL_LTES_III(32, 0xeU, (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2947_)));
    if (vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3009_) {
        vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2489_ 
            = ((0x15U == (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2947_)) 
               | (0xadU == (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2947_)));
        vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2661_ 
            = (VL_GTS_III(32, 0xaeU, (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2947_)) 
               & VL_LTES_III(32, 0x15U, (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2947_)));
    } else {
        vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2489_ 
            = ((0xdU == (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2947_)) 
               | (0xadU == (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2947_)));
        vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2661_ 
            = (VL_GTS_III(32, 0xaeU, (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2947_)) 
               & VL_LTES_III(32, 0xdU, (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2947_)));
    }
    vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2690_ 
        = (((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3010_)
             ? (VL_GTS_III(32, 0xdaU, (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2950_)) 
                & VL_LTS_III(32, 0x2cU, (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2950_)))
             : (VL_GTS_III(32, 0xdaU, (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2950_)) 
                & VL_LTS_III(32, 0x1cU, (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2950_)))) 
           & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3009_)
               ? (VL_GTS_III(32, 0xaeU, (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2947_)) 
                  & VL_LTS_III(32, 0x16U, (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2947_)))
               : (VL_GTS_III(32, 0xaeU, (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2947_)) 
                  & VL_LTS_III(32, 0xeU, (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2947_)))));
    vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0862_ 
        = (((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___2947_) 
            - (IData)(6U)) - (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3006_));
    vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___219_ 
        = ((((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___649_) 
             ^ vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___216_) 
            >> 0xfU) & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___218_));
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s 
        = (((6U == (7U & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___572_) 
                          >> 6U))) << 6U) | (((5U == 
                                               (7U 
                                                & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___572_) 
                                                   >> 6U))) 
                                              << 5U) 
                                             | (((4U 
                                                  == 
                                                  (7U 
                                                   & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___572_) 
                                                      >> 6U))) 
                                                 << 4U) 
                                                | (((3U 
                                                     == 
                                                     (7U 
                                                      & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___572_) 
                                                         >> 6U))) 
                                                    << 3U) 
                                                   | (((2U 
                                                        == 
                                                        (7U 
                                                         & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___572_) 
                                                            >> 6U))) 
                                                       << 2U) 
                                                      | (((1U 
                                                           == 
                                                           (7U 
                                                            & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___572_) 
                                                               >> 6U))) 
                                                          << 1U) 
                                                         | (0U 
                                                            == 
                                                            (7U 
                                                             & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___572_) 
                                                                >> 6U)))))))));
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U] 
        = ((((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3050_) 
             << 0x18U) | (0xff0000U & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___576_) 
                                       << 0x10U))) 
           | ((0xff00U & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3050_) 
                          << 8U)) | (0xffU & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___576_))));
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[1U] 
        = (((0xff00U & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3050_) 
                        << 8U)) | (0xffU & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___576_))) 
           | ((IData)((((QData)((IData)((((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___232_) 
                                          << 0x10U) 
                                         | (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___649_)))) 
                        << 0x20U) | (QData)((IData)(
                                                    ((vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___216_ 
                                                      << 0x10U) 
                                                     | (0xffffU 
                                                        & vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___206_)))))) 
              << 0x10U));
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[2U] 
        = (((IData)((((QData)((IData)((((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___232_) 
                                        << 0x10U) | (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___649_)))) 
                      << 0x20U) | (QData)((IData)((
                                                   (vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___216_ 
                                                    << 0x10U) 
                                                   | (0xffffU 
                                                      & vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___206_)))))) 
            >> 0x10U) | ((IData)(((((QData)((IData)(
                                                    (((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___232_) 
                                                      << 0x10U) 
                                                     | (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___649_)))) 
                                    << 0x20U) | (QData)((IData)(
                                                                ((vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___216_ 
                                                                  << 0x10U) 
                                                                 | (0xffffU 
                                                                    & vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___206_))))) 
                                  >> 0x20U)) << 0x10U));
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[3U] 
        = ((IData)(((((QData)((IData)((((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___232_) 
                                        << 0x10U) | (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___649_)))) 
                      << 0x20U) | (QData)((IData)((
                                                   (vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___216_ 
                                                    << 0x10U) 
                                                   | (0xffffU 
                                                      & vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___206_))))) 
                    >> 0x20U)) >> 0x10U);
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__a 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___236_;
    vlSelf->__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__Vfuncout 
        = (0xffffU & ((0x40U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                       ? ((0x20U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                           ? ((0x10U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                               ? ((8U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                   ? ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                       ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U]
                                               : __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[1U]))
                                       : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[1U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[1U] 
                                                     >> 0x10U)))))
                                   : ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                       ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U]
                                               : __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[1U]))
                                       : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U]
                                               : __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[2U]))))
                               : ((8U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                   ? ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                       ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U]
                                               : __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[1U]))
                                       : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[1U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[1U] 
                                                     >> 0x10U)))))
                                   : ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                       ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U]
                                               : __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[1U]))
                                       : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[2U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[2U] 
                                                     >> 0x10U)))))))
                           : ((0x10U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                               ? ((8U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                   ? ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                       ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U]
                                               : __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[1U]))
                                       : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[1U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[1U] 
                                                     >> 0x10U)))))
                                   : ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                       ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U]
                                               : __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[1U]))
                                       : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U]
                                               : __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[2U]))))
                               : ((8U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                   ? ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                       ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U]
                                               : __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[1U]))
                                       : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[1U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[1U] 
                                                     >> 0x10U)))))
                                   : ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                       ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U]
                                               : __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[1U]))
                                       : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U]
                                               : __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[3U]))))))
                       : ((0x20U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                           ? ((0x10U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                               ? ((8U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                   ? ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                       ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U]
                                               : __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[1U]))
                                       : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[1U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[1U] 
                                                     >> 0x10U)))))
                                   : ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                       ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U]
                                               : __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[1U]))
                                       : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U]
                                               : __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[2U]))))
                               : ((8U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                   ? ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                       ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U]
                                               : __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[1U]))
                                       : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[1U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[1U] 
                                                     >> 0x10U)))))
                                   : ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                       ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U]
                                               : __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[1U]))
                                       : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[2U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[2U] 
                                                     >> 0x10U)))))))
                           : ((0x10U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                               ? ((8U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                   ? ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                       ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U]
                                               : __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[1U]))
                                       : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[1U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[1U] 
                                                     >> 0x10U)))))
                                   : ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                       ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U]
                                               : __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[1U]))
                                       : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U]
                                               : __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[2U]))))
                               : ((8U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                   ? ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                       ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U]
                                               : __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[1U]))
                                       : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[1U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[1U] 
                                                     >> 0x10U)))))
                                   : ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                       ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U]
                                               : __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[1U]))
                                       : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__b[0U]
                                               : (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__a)))))))));
    vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___239_ 
        = vlSelf->__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031061__26__Vfuncout;
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s 
        = (((6U == (7U & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___572_) 
                          >> 6U))) << 6U) | (((5U == 
                                               (7U 
                                                & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___572_) 
                                                   >> 6U))) 
                                              << 5U) 
                                             | (((4U 
                                                  == 
                                                  (7U 
                                                   & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___572_) 
                                                      >> 6U))) 
                                                 << 4U) 
                                                | (((3U 
                                                     == 
                                                     (7U 
                                                      & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___572_) 
                                                         >> 6U))) 
                                                    << 3U) 
                                                   | (((2U 
                                                        == 
                                                        (7U 
                                                         & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___572_) 
                                                            >> 6U))) 
                                                       << 2U) 
                                                      | (((1U 
                                                           == 
                                                           (7U 
                                                            & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___572_) 
                                                               >> 6U))) 
                                                          << 1U) 
                                                         | (0U 
                                                            == 
                                                            (7U 
                                                             & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___572_) 
                                                                >> 6U)))))))));
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U] 
        = ((((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3050_) 
             << 0x18U) | (0xff0000U & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___576_) 
                                       << 0x10U))) 
           | ((0xff00U & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3050_) 
                          << 8U)) | (0xffU & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___576_))));
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[1U] 
        = (((0xff00U & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3050_) 
                        << 8U)) | (0xffU & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___576_))) 
           | ((IData)((((QData)((IData)((((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___232_) 
                                          << 0x10U) 
                                         | (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___649_)))) 
                        << 0x20U) | (QData)((IData)(
                                                    ((vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___216_ 
                                                      << 0x10U) 
                                                     | (0xffffU 
                                                        & vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___206_)))))) 
              << 0x10U));
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[2U] 
        = (((IData)((((QData)((IData)((((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___232_) 
                                        << 0x10U) | (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___649_)))) 
                      << 0x20U) | (QData)((IData)((
                                                   (vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___216_ 
                                                    << 0x10U) 
                                                   | (0xffffU 
                                                      & vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___206_)))))) 
            >> 0x10U) | ((IData)(((((QData)((IData)(
                                                    (((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___232_) 
                                                      << 0x10U) 
                                                     | (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___649_)))) 
                                    << 0x20U) | (QData)((IData)(
                                                                ((vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___216_ 
                                                                  << 0x10U) 
                                                                 | (0xffffU 
                                                                    & vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___206_))))) 
                                  >> 0x20U)) << 0x10U));
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[3U] 
        = ((IData)(((((QData)((IData)((((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___232_) 
                                        << 0x10U) | (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___649_)))) 
                      << 0x20U) | (QData)((IData)((
                                                   (vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___216_ 
                                                    << 0x10U) 
                                                   | (0xffffU 
                                                      & vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___206_))))) 
                    >> 0x20U)) >> 0x10U);
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__a 
        = vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___236_;
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__Vfuncout 
        = (0xffffU & ((0x40U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                       ? ((0x20U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                           ? ((0x10U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                               ? ((8U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                   ? ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                       ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U]
                                               : __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[1U]))
                                       : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[1U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[1U] 
                                                     >> 0x10U)))))
                                   : ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                       ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U]
                                               : __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[1U]))
                                       : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U]
                                               : __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[2U]))))
                               : ((8U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                   ? ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                       ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U]
                                               : __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[1U]))
                                       : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[1U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[1U] 
                                                     >> 0x10U)))))
                                   : ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                       ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U]
                                               : __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[1U]))
                                       : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[2U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[2U] 
                                                     >> 0x10U)))))))
                           : ((0x10U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                               ? ((8U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                   ? ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                       ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U]
                                               : __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[1U]))
                                       : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[1U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[1U] 
                                                     >> 0x10U)))))
                                   : ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                       ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U]
                                               : __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[1U]))
                                       : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U]
                                               : __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[2U]))))
                               : ((8U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                   ? ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                       ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U]
                                               : __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[1U]))
                                       : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[1U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[1U] 
                                                     >> 0x10U)))))
                                   : ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                       ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U]
                                               : __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[1U]))
                                       : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U]
                                               : __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[3U]))))))
                       : ((0x20U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                           ? ((0x10U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                               ? ((8U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                   ? ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                       ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U]
                                               : __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[1U]))
                                       : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[1U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[1U] 
                                                     >> 0x10U)))))
                                   : ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                       ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U]
                                               : __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[1U]))
                                       : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U]
                                               : __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[2U]))))
                               : ((8U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                   ? ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                       ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U]
                                               : __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[1U]))
                                       : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[1U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[1U] 
                                                     >> 0x10U)))))
                                   : ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                       ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U]
                                               : __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[1U]))
                                       : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[2U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[2U] 
                                                     >> 0x10U)))))))
                           : ((0x10U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                               ? ((8U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                   ? ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                       ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U]
                                               : __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[1U]))
                                       : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[1U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[1U] 
                                                     >> 0x10U)))))
                                   : ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                       ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U]
                                               : __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[1U]))
                                       : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U]
                                               : __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[2U]))))
                               : ((8U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                   ? ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                       ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U]
                                               : __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[1U]))
                                       : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[1U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[1U] 
                                                     >> 0x10U)))))
                                   : ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                       ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U]
                                               : __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[1U]))
                                       : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                           ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U]
                                               : ((
                                                   __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U] 
                                                   << 0x10U) 
                                                  | (__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U] 
                                                     >> 0x10U)))
                                           : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__s))
                                               ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__b[0U]
                                               : (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__a)))))))));
    vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___375_ 
        = __Vfunc_intv_phoenix__DOT__intv__DOT__i_cp1610__DOT____031490__39__Vfuncout;
    vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___210_ 
        = (1U & ((~ (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___218_)) 
                 & (((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___649_) 
                     ^ vlSelf->intv_phoenix__DOT__intv__DOT__i_cp1610__DOT___206_) 
                    >> 0xfU)));
    vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0455_ 
        = (0xffU & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0814_) 
                    + (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___1060_)));
    vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___0469_ 
        = (0xfffU & ((0x1fU & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___1060_)) 
                     << (7U & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___1060_) 
                               >> 5U))));
    vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT__coef 
        = (0x3ffU & ((0x80U & (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___1060_))
                      ? (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___1059_)
                      : (- (IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_ivoice__DOT___1059_))));
    vlSelf->intv_phoenix__DOT__crc = __Vdly__intv_phoenix__DOT__crc;
    vlSelf->intv_phoenix__DOT__fwd_byte_ready = ((~ (IData)(vlSelf->intv_phoenix__DOT__spi_busy)) 
                                                 & (IData)(vlSelf->intv_phoenix__DOT__fwd_feed_wait));
    vlSelf->intv_phoenix__DOT__spi_rx = __Vdly__intv_phoenix__DOT__spi_rx;
    vlSelf->intv_phoenix__DOT__ld_done = __Vdly__intv_phoenix__DOT__ld_done;
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s 
        = (((6U == (7U & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3040_) 
                          >> 7U))) << 6U) | (((5U == 
                                               (7U 
                                                & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3040_) 
                                                   >> 7U))) 
                                              << 5U) 
                                             | (((4U 
                                                  == 
                                                  (7U 
                                                   & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3040_) 
                                                      >> 7U))) 
                                                 << 4U) 
                                                | (((3U 
                                                     == 
                                                     (7U 
                                                      & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3040_) 
                                                         >> 7U))) 
                                                    << 3U) 
                                                   | (((2U 
                                                        == 
                                                        (7U 
                                                         & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3040_) 
                                                            >> 7U))) 
                                                       << 2U) 
                                                      | (((1U 
                                                           == 
                                                           (7U 
                                                            & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3040_) 
                                                               >> 7U))) 
                                                          << 1U) 
                                                         | (0U 
                                                            == 
                                                            (7U 
                                                             & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3040_) 
                                                                >> 7U)))))))));
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b 
        = ((0x7000000U & (VL_DIVS_III(32, vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0398_, (IData)(8U)) 
                          << 0x18U)) | ((0xf00000U 
                                         & (VL_DIVS_III(32, vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0398_, (IData)(4U)) 
                                            << 0x14U)) 
                                        | ((0x70000U 
                                            & (VL_DIVS_III(32, vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0398_, (IData)(4U)) 
                                               << 0x10U)) 
                                           | ((0xf000U 
                                               & (VL_DIVS_III(32, vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0398_, (IData)(2U)) 
                                                  << 0xcU)) 
                                              | ((0x700U 
                                                  & (VL_DIVS_III(32, vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0398_, (IData)(2U)) 
                                                     << 8U)) 
                                                 | ((0xf0U 
                                                     & (vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0398_ 
                                                        << 4U)) 
                                                    | (7U 
                                                       & vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0398_)))))));
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__a 
        = (0xfU & VL_DIVS_III(32, vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0398_, (IData)(8U)));
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__Vfuncout 
        = (0xfU & ((0x40U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                    ? ((0x20U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                        ? ((0x10U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                            ? ((8U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                ? ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                    ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                        ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b 
                                               >> 4U))
                                        : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b 
                                               >> 8U)))
                                    : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                        ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b 
                                               >> 4U))
                                        : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b 
                                               >> 0xcU))))
                                : ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                    ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                        ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b 
                                               >> 4U))
                                        : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b 
                                               >> 8U)))
                                    : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                        ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b 
                                               >> 4U))
                                        : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b 
                                               >> 0x10U)))))
                            : ((8U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                ? ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                    ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                        ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b 
                                               >> 4U))
                                        : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b 
                                               >> 8U)))
                                    : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                        ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b 
                                               >> 4U))
                                        : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b 
                                               >> 0xcU))))
                                : ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                    ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                        ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b 
                                               >> 4U))
                                        : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b 
                                               >> 8U)))
                                    : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                        ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b 
                                               >> 4U))
                                        : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b 
                                               >> 0x14U))))))
                        : ((0x10U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                            ? ((8U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                ? ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                    ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                        ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b 
                                               >> 4U))
                                        : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b 
                                               >> 8U)))
                                    : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                        ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b 
                                               >> 4U))
                                        : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b 
                                               >> 0xcU))))
                                : ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                    ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                        ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b 
                                               >> 4U))
                                        : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b 
                                               >> 8U)))
                                    : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                        ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b 
                                               >> 4U))
                                        : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b 
                                               >> 0x10U)))))
                            : ((8U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                ? ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                    ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                        ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b 
                                               >> 4U))
                                        : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b 
                                               >> 8U)))
                                    : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                        ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b 
                                               >> 4U))
                                        : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b 
                                               >> 0xcU))))
                                : ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                    ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                        ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b 
                                               >> 4U))
                                        : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b 
                                               >> 8U)))
                                    : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                        ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b 
                                               >> 4U))
                                        : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b 
                                               >> 0x18U)))))))
                    : ((0x20U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                        ? ((0x10U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                            ? ((8U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                ? ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                    ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                        ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b 
                                               >> 4U))
                                        : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b 
                                               >> 8U)))
                                    : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                        ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b 
                                               >> 4U))
                                        : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b 
                                               >> 0xcU))))
                                : ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                    ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                        ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b 
                                               >> 4U))
                                        : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b 
                                               >> 8U)))
                                    : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                        ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b 
                                               >> 4U))
                                        : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b 
                                               >> 0x10U)))))
                            : ((8U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                ? ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                    ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                        ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b 
                                               >> 4U))
                                        : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b 
                                               >> 8U)))
                                    : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                        ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b 
                                               >> 4U))
                                        : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b 
                                               >> 0xcU))))
                                : ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                    ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                        ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b 
                                               >> 4U))
                                        : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b 
                                               >> 8U)))
                                    : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                        ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b 
                                               >> 4U))
                                        : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b 
                                               >> 0x14U))))))
                        : ((0x10U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                            ? ((8U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                ? ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                    ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                        ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b 
                                               >> 4U))
                                        : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b 
                                               >> 8U)))
                                    : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                        ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b 
                                               >> 4U))
                                        : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b 
                                               >> 0xcU))))
                                : ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                    ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                        ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b 
                                               >> 4U))
                                        : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b 
                                               >> 8U)))
                                    : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                        ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b 
                                               >> 4U))
                                        : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b 
                                               >> 0x10U)))))
                            : ((8U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                ? ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                    ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                        ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b 
                                               >> 4U))
                                        : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b 
                                               >> 8U)))
                                    : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                        ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b 
                                               >> 4U))
                                        : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b 
                                               >> 0xcU))))
                                : ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                    ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                        ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b 
                                               >> 4U))
                                        : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b 
                                               >> 8U)))
                                    : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                        ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b 
                                               >> 4U))
                                        : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__b
                                            : (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__a)))))))));
    vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0456_ 
        = __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034243__347__Vfuncout;
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s 
        = (((6U == (7U & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3040_) 
                          >> 7U))) << 6U) | (((5U == 
                                               (7U 
                                                & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3040_) 
                                                   >> 7U))) 
                                              << 5U) 
                                             | (((4U 
                                                  == 
                                                  (7U 
                                                   & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3040_) 
                                                      >> 7U))) 
                                                 << 4U) 
                                                | (((3U 
                                                     == 
                                                     (7U 
                                                      & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3040_) 
                                                         >> 7U))) 
                                                    << 3U) 
                                                   | (((2U 
                                                        == 
                                                        (7U 
                                                         & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3040_) 
                                                            >> 7U))) 
                                                       << 2U) 
                                                      | (((1U 
                                                           == 
                                                           (7U 
                                                            & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3040_) 
                                                               >> 7U))) 
                                                          << 1U) 
                                                         | (0U 
                                                            == 
                                                            (7U 
                                                             & ((IData)(vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___3040_) 
                                                                >> 7U)))))))));
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b 
        = ((0x7000000U & (VL_DIVS_III(32, vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0398_, (IData)(8U)) 
                          << 0x18U)) | ((0xf00000U 
                                         & (VL_DIVS_III(32, vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0398_, (IData)(4U)) 
                                            << 0x14U)) 
                                        | ((0x70000U 
                                            & (VL_DIVS_III(32, vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0398_, (IData)(4U)) 
                                               << 0x10U)) 
                                           | ((0xf000U 
                                               & (VL_DIVS_III(32, vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0398_, (IData)(2U)) 
                                                  << 0xcU)) 
                                              | ((0x700U 
                                                  & (VL_DIVS_III(32, vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0398_, (IData)(2U)) 
                                                     << 8U)) 
                                                 | ((0xf0U 
                                                     & (vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0398_ 
                                                        << 4U)) 
                                                    | (7U 
                                                       & vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0398_)))))));
    __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__a 
        = (0xfU & VL_DIVS_III(32, vlSelf->intv_phoenix__DOT__intv__DOT__i_stic__DOT___0398_, (IData)(8U)));
    vlSelf->__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__Vfuncout 
        = (0xfU & ((0x40U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                    ? ((0x20U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                        ? ((0x10U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                            ? ((8U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                ? ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                    ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                        ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b 
                                               >> 4U))
                                        : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b 
                                               >> 8U)))
                                    : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                        ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b 
                                               >> 4U))
                                        : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b 
                                               >> 0xcU))))
                                : ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                    ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                        ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b 
                                               >> 4U))
                                        : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b 
                                               >> 8U)))
                                    : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                        ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b 
                                               >> 4U))
                                        : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b 
                                               >> 0x10U)))))
                            : ((8U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                ? ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                    ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                        ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b 
                                               >> 4U))
                                        : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b 
                                               >> 8U)))
                                    : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                        ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b 
                                               >> 4U))
                                        : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b 
                                               >> 0xcU))))
                                : ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                    ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                        ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b 
                                               >> 4U))
                                        : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b 
                                               >> 8U)))
                                    : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                        ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b 
                                               >> 4U))
                                        : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b 
                                               >> 0x14U))))))
                        : ((0x10U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                            ? ((8U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                ? ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                    ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                        ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b 
                                               >> 4U))
                                        : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b 
                                               >> 8U)))
                                    : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                        ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b 
                                               >> 4U))
                                        : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b 
                                               >> 0xcU))))
                                : ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                    ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                        ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b 
                                               >> 4U))
                                        : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b 
                                               >> 8U)))
                                    : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                        ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b 
                                               >> 4U))
                                        : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b 
                                               >> 0x10U)))))
                            : ((8U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                ? ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                    ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                        ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b 
                                               >> 4U))
                                        : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b 
                                               >> 8U)))
                                    : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                        ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b 
                                               >> 4U))
                                        : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b 
                                               >> 0xcU))))
                                : ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                    ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                        ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b 
                                               >> 4U))
                                        : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b 
                                               >> 8U)))
                                    : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                        ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b 
                                               >> 4U))
                                        : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b 
                                               >> 0x18U)))))))
                    : ((0x20U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                        ? ((0x10U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                            ? ((8U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                ? ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                    ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                        ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b 
                                               >> 4U))
                                        : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b 
                                               >> 8U)))
                                    : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                        ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b 
                                               >> 4U))
                                        : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b 
                                               >> 0xcU))))
                                : ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                    ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                        ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b 
                                               >> 4U))
                                        : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b 
                                               >> 8U)))
                                    : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                        ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b 
                                               >> 4U))
                                        : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b 
                                               >> 0x10U)))))
                            : ((8U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                ? ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                    ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                        ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b 
                                               >> 4U))
                                        : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b 
                                               >> 8U)))
                                    : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                        ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b 
                                               >> 4U))
                                        : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b 
                                               >> 0xcU))))
                                : ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                    ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                        ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b 
                                               >> 4U))
                                        : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b 
                                               >> 8U)))
                                    : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                        ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b 
                                               >> 4U))
                                        : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b 
                                               >> 0x14U))))))
                        : ((0x10U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                            ? ((8U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                ? ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                    ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                        ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b 
                                               >> 4U))
                                        : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b 
                                               >> 8U)))
                                    : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                        ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b 
                                               >> 4U))
                                        : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b 
                                               >> 0xcU))))
                                : ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                    ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                        ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b 
                                               >> 4U))
                                        : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b 
                                               >> 8U)))
                                    : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                        ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b 
                                               >> 4U))
                                        : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b 
                                               >> 0x10U)))))
                            : ((8U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                ? ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                    ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                        ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b 
                                               >> 4U))
                                        : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b 
                                               >> 8U)))
                                    : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                        ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b 
                                               >> 4U))
                                        : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b 
                                               >> 0xcU))))
                                : ((4U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                    ? ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                        ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b 
                                               >> 4U))
                                        : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b 
                                               >> 8U)))
                                    : ((2U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                        ? ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b
                                            : (__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b 
                                               >> 4U))
                                        : ((1U & (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__s))
                                            ? __Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__b
                                            : (IData)(__Vfunc_intv_phoenix__DOT__intv__DOT__i_stic__DOT____034368__348__a)))))))));
}
