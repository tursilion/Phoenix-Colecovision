# Verilator test of the ColecoVision core's ROM cache (cv_cache.v) on its
# own: make, then obj_dir/Vcv_cache.  Without verilator on the PATH,
# Verilator runs in the docked-ise-147 Docker image and the C++ is compiled
# here against tools/verilator.

ROOT           := $(abspath ../../..)
VERILATOR      ?= $(shell command -v verilator)
DOCKER_IMAGE   ?= docked-ise-147
VERILATOR_ROOT ?= $(ROOT)/tools/verilator
DOCKER    := docker run --rm -u $$(id -u):$$(id -g) -v $(ROOT):/w -w /w/rtl/sim/cache $(DOCKER_IMAGE)

SIM   := obj_dir/Vcv_cache
VARGS := --cc --exe -O3 -Wno-fatal -Wno-lint -Wno-style --top-module cv_cache ../../cv_cache.v tb.cpp

all: $(SIM)

$(SIM): ../../cv_cache.v tb.cpp
ifneq ($(VERILATOR),)
	$(VERILATOR) $(VARGS) --build -j 0
else
	$(DOCKER) verilator $(VARGS)
	$(MAKE) -C obj_dir -f Vcv_cache.mk -j 8 VERILATOR_ROOT=$(VERILATOR_ROOT)
endif

test: $(SIM)
	$(SIM)

clean:
	rm -rf obj_dir

.PHONY: all test clean
