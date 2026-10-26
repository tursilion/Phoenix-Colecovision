// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Primary model header
//
// This header should be included by all source files instantiating the design.
// The class here is then constructed to instantiate the design.
// See the Verilator manual for examples.

#ifndef VERILATED_VINTV_PHOENIX_H_
#define VERILATED_VINTV_PHOENIX_H_  // guard

#include "verilated.h"

class Vintv_phoenix__Syms;
class Vintv_phoenix___024root;

// This class is the main interface to the Verilated model
class alignas(VL_CACHE_LINE_BYTES) Vintv_phoenix VL_NOT_FINAL : public VerilatedModel {
  private:
    // Symbol table holding complete model state (owned by this class)
    Vintv_phoenix__Syms* const vlSymsp;

  public:

    // PORTS
    // The application code writes and reads these signals to
    // propagate new values into/out from the Verilated model.
    VL_IN8(&clk25,0,0);
    VL_IN8(&clk_i,0,0);
    VL_IN8(&clk_g,0,0);
    VL_OUT8(&run,0,0);
    VL_IN8(&reset,0,0);
    VL_IN8(&game_reset,0,0);
    VL_IN8(&kb_joy,4,0);
    VL_IN8(&kb_byte,7,0);
    VL_IN8(&kb_stb,0,0);
    VL_OUT8(&sram_dout,7,0);
    VL_IN8(&sram_din,7,0);
    VL_OUT8(&sram_doe,0,0);
    VL_OUT8(&sram_we_n,0,0);
    VL_OUT8(&sram_oe_n,0,0);
    VL_OUT8(&sd_cs_n,0,0);
    VL_OUT8(&sd_sclk,0,0);
    VL_OUT8(&sd_mosi,0,0);
    VL_IN8(&sd_miso,0,0);
    VL_IN8(&sd_cd_n,0,0);
    VL_OUT8(&vid_r,7,0);
    VL_OUT8(&vid_g,7,0);
    VL_OUT8(&vid_b,7,0);
    VL_OUT8(&vid_hsync_n,0,0);
    VL_OUT8(&vid_vsync_n,0,0);
    VL_OUT8(&vid_blank,0,0);
    VL_OUT8(&boot_mode,0,0);
    VL_OUT8(&led_err,0,0);
    VL_IN16(&cv1,9,0);
    VL_IN16(&cv2,9,0);
    VL_IN16(&snes,11,0);
    VL_IN16(&kb_keys,15,0);
    VL_OUT16(&audio,15,0);
    VL_OUT(&sram_addr,18,0);

    // CELLS
    // Public to allow access to /* verilator public */ items.
    // Otherwise the application code can consider these internals.

    // Root instance pointer to allow access to model internals,
    // including inlined /* verilator public_flat_* */ items.
    Vintv_phoenix___024root* const rootp;

    // CONSTRUCTORS
    /// Construct the model; called by application code
    /// If contextp is null, then the model will use the default global context
    /// If name is "", then makes a wrapper with a
    /// single model invisible with respect to DPI scope names.
    explicit Vintv_phoenix(VerilatedContext* contextp, const char* name = "TOP");
    explicit Vintv_phoenix(const char* name = "TOP");
    /// Destroy the model; called (often implicitly) by application code
    virtual ~Vintv_phoenix();
  private:
    VL_UNCOPYABLE(Vintv_phoenix);  ///< Copying not allowed

  public:
    // API METHODS
    /// Evaluate the model.  Application must call when inputs change.
    void eval() { eval_step(); }
    /// Evaluate when calling multiple units/models per time step.
    void eval_step();
    /// Evaluate at end of a timestep for tracing, when using eval_step().
    /// Application must call after all eval() and before time changes.
    void eval_end_step() {}
    /// Simulation complete, run final blocks.  Application must call on completion.
    void final();
    /// Are there scheduled events to handle?
    bool eventsPending();
    /// Returns time at next time slot. Aborts if !eventsPending()
    uint64_t nextTimeSlot();
    /// Trace signals in the model; called by application code
    void trace(VerilatedVcdC* tfp, int levels, int options = 0);
    /// Retrieve name of this model instance (as passed to constructor).
    const char* name() const;

    // Abstract methods from VerilatedModel
    const char* hierName() const override final;
    const char* modelName() const override final;
    unsigned threads() const override final;
    /// Prepare for cloning the model at the process level (e.g. fork in Linux)
    /// Release necessary resources. Called before cloning.
    void prepareClone() const;
    /// Re-init after cloning the model at the process level (e.g. fork in Linux)
    /// Re-allocate necessary resources. Called after cloning.
    void atClone() const;
};

#endif  // guard
