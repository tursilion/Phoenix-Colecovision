# ROM cache test HuCard (cc65): CACHETST.PCE, 1M.

CL65 ?= cl65

all: CACHETST.PCE

bank0.bin: crt0.s main.c page.s font.c cache.cfg
	$(CL65) -t none -Oirs --cpu huc6280 -C cache.cfg -m cache.map -o $@ crt0.s main.c page.s font.c

CACHETST.PCE: bank0.bin mkcache.py
	python3 mkcache.py $< $@

clean:
	rm -f *.o bank0.bin cache.map CACHETST.PCE

.PHONY: all clean
