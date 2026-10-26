// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Model implementation (design independent parts)

#include "Vintv_phoenix.h"
#include "Vintv_phoenix__Syms.h"

//============================================================
// Constructors

Vintv_phoenix::Vintv_phoenix(VerilatedContext* _vcontextp__, const char* _vcname__)
    : VerilatedModel{*_vcontextp__}
    , vlSymsp{new Vintv_phoenix__Syms(contextp(), _vcname__, this)}
    , clk25{vlSymsp->TOP.clk25}
    , clk_i{vlSymsp->TOP.clk_i}
    , clk_g{vlSymsp->TOP.clk_g}
    , run{vlSymsp->TOP.run}
    , reset{vlSymsp->TOP.reset}
    , game_reset{vlSymsp->TOP.game_reset}
    , kb_joy{vlSymsp->TOP.kb_joy}
    , kb_byte{vlSymsp->TOP.kb_byte}
    , kb_stb{vlSymsp->TOP.kb_stb}
    , sram_dout{vlSymsp->TOP.sram_dout}
    , sram_din{vlSymsp->TOP.sram_din}
    , sram_doe{vlSymsp->TOP.sram_doe}
    , sram_we_n{vlSymsp->TOP.sram_we_n}
    , sram_oe_n{vlSymsp->TOP.sram_oe_n}
    , sd_cs_n{vlSymsp->TOP.sd_cs_n}
    , sd_sclk{vlSymsp->TOP.sd_sclk}
    , sd_mosi{vlSymsp->TOP.sd_mosi}
    , sd_miso{vlSymsp->TOP.sd_miso}
    , sd_cd_n{vlSymsp->TOP.sd_cd_n}
    , vid_r{vlSymsp->TOP.vid_r}
    , vid_g{vlSymsp->TOP.vid_g}
    , vid_b{vlSymsp->TOP.vid_b}
    , vid_hsync_n{vlSymsp->TOP.vid_hsync_n}
    , vid_vsync_n{vlSymsp->TOP.vid_vsync_n}
    , vid_blank{vlSymsp->TOP.vid_blank}
    , boot_mode{vlSymsp->TOP.boot_mode}
    , led_err{vlSymsp->TOP.led_err}
    , cv1{vlSymsp->TOP.cv1}
    , cv2{vlSymsp->TOP.cv2}
    , snes{vlSymsp->TOP.snes}
    , kb_keys{vlSymsp->TOP.kb_keys}
    , audio{vlSymsp->TOP.audio}
    , sram_addr{vlSymsp->TOP.sram_addr}
    , rootp{&(vlSymsp->TOP)}
{
    // Register model with the context
    contextp()->addModel(this);
}

Vintv_phoenix::Vintv_phoenix(const char* _vcname__)
    : Vintv_phoenix(Verilated::threadContextp(), _vcname__)
{
}

//============================================================
// Destructor

Vintv_phoenix::~Vintv_phoenix() {
    delete vlSymsp;
}

//============================================================
// Evaluation function

#ifdef VL_DEBUG
void Vintv_phoenix___024root___eval_debug_assertions(Vintv_phoenix___024root* vlSelf);
#endif  // VL_DEBUG
void Vintv_phoenix___024root___eval_static(Vintv_phoenix___024root* vlSelf);
void Vintv_phoenix___024root___eval_initial(Vintv_phoenix___024root* vlSelf);
void Vintv_phoenix___024root___eval_settle(Vintv_phoenix___024root* vlSelf);
void Vintv_phoenix___024root___eval(Vintv_phoenix___024root* vlSelf);

void Vintv_phoenix::eval_step() {
    VL_DEBUG_IF(VL_DBG_MSGF("+++++TOP Evaluate Vintv_phoenix::eval_step\n"); );
#ifdef VL_DEBUG
    // Debug assertions
    Vintv_phoenix___024root___eval_debug_assertions(&(vlSymsp->TOP));
#endif  // VL_DEBUG
    vlSymsp->__Vm_deleter.deleteAll();
    if (VL_UNLIKELY(!vlSymsp->__Vm_didInit)) {
        vlSymsp->__Vm_didInit = true;
        VL_DEBUG_IF(VL_DBG_MSGF("+ Initial\n"););
        Vintv_phoenix___024root___eval_static(&(vlSymsp->TOP));
        Vintv_phoenix___024root___eval_initial(&(vlSymsp->TOP));
        Vintv_phoenix___024root___eval_settle(&(vlSymsp->TOP));
    }
    // MTask 0 start
    VL_DEBUG_IF(VL_DBG_MSGF("MTask0 starting\n"););
    Verilated::mtaskId(0);
    VL_DEBUG_IF(VL_DBG_MSGF("+ Eval\n"););
    Vintv_phoenix___024root___eval(&(vlSymsp->TOP));
    // Evaluate cleanup
    Verilated::endOfThreadMTask(vlSymsp->__Vm_evalMsgQp);
    Verilated::endOfEval(vlSymsp->__Vm_evalMsgQp);
}

//============================================================
// Events and timing
bool Vintv_phoenix::eventsPending() { return false; }

uint64_t Vintv_phoenix::nextTimeSlot() {
    VL_FATAL_MT(__FILE__, __LINE__, "", "%Error: No delays in the design");
    return 0;
}

//============================================================
// Utilities

const char* Vintv_phoenix::name() const {
    return vlSymsp->name();
}

//============================================================
// Invoke final blocks

void Vintv_phoenix___024root___eval_final(Vintv_phoenix___024root* vlSelf);

VL_ATTR_COLD void Vintv_phoenix::final() {
    Vintv_phoenix___024root___eval_final(&(vlSymsp->TOP));
}

//============================================================
// Implementations of abstract methods from VerilatedModel

const char* Vintv_phoenix::hierName() const { return vlSymsp->name(); }
const char* Vintv_phoenix::modelName() const { return "Vintv_phoenix"; }
unsigned Vintv_phoenix::threads() const { return 1; }
void Vintv_phoenix::prepareClone() const { contextp()->prepareClone(); }
void Vintv_phoenix::atClone() const {
    contextp()->threadPoolpOnClone();
}

//============================================================
// Trace configuration

VL_ATTR_COLD void Vintv_phoenix::trace(VerilatedVcdC* tfp, int levels, int options) {
    vl_fatal(__FILE__, __LINE__, __FILE__,"'Vintv_phoenix::trace()' called on model that was Verilated without --trace option");
}
