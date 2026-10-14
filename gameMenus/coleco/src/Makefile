# Build the Phoenix CV Core SD-Card Menu / Loader.
#
# MUST be run from a 64-bit Windows Command Prompt.  This Makefile will not work
# with MinGW.
#
# SDCC and GNU make.exe have been included, so just type: make
#
# Built with SDCC 4.0.0 64-bit for Windows
# GNU Make.exe from http://ftp.gnu.org/gnu/make/
CFLAGS = -mz80 -c "-I../libti99coleco" "-I../sdcc/include" --opt-code-size --max-allocs-per-node 18000 --std-sdcc99 --vc --fsigned-char

CC = "..\sdcc\bin\sdcc"
AS = "..\sdcc\bin\sdasz80"
AR = "..\sdcc\bin\sdar"
MB = "..\sdcc\bin\makebin"
AFLAGS = -plosgff
RM = cmd /c del /F
EXT=rel

# make sure the crt0 is first!
MAIN_OBJS =\
    crt0_bios.$(EXT)  \
    phoenixBoot.$(EXT)  \
    newmap2.$(EXT)  \
    f18a.$(EXT)  \
    mattfont.$(EXT)  \
    menu.$(EXT)  \
    vdp_memcpyfast.$(EXT) \
    joykey.$(EXT)

# By building FatFS as a library with distinct files, any functions
# we dont use are automatically stripped from the output
FAT_OBJS =\
    fatFS/diskio_diskinit.$(EXT) \
    fatFS/diskio_diskioctl.$(EXT) \
    fatFS/diskio_diskread.$(EXT) \
    fatFS/diskio_diskstatus.$(EXT) \
    fatFS/diskio_diskwrite.$(EXT) \
    fatFS/diskio_dselect.$(EXT) \
    fatFS/diskio_rcvrdatablock.$(EXT) \
    fatFS/diskio_rcvrmmc.$(EXT) \
    fatFS/diskio_select.$(EXT) \
    fatFS/diskio_sendcmd.$(EXT) \
    fatFS/diskio_waitready.$(EXT) \
    fatFS/diskio_xmitdatablock.$(EXT) \
    fatFS/diskio_xmitmmc.$(EXT) \
    fatFS/ff_checkfs.$(EXT) \
    fatFS/ff_chkchr.$(EXT) \
    fatFS/ff_closedir.$(EXT) \
    fatFS/ff_clst2sect.$(EXT) \
    fatFS/ff_cmplfn.$(EXT) \
    fatFS/ff_createchain.$(EXT) \
    fatFS/ff_createname.$(EXT) \
    fatFS/ff_diralloc.$(EXT) \
    fatFS/ff_dirclear.$(EXT) \
    fatFS/ff_dirfind.$(EXT) \
    fatFS/ff_dirnext.$(EXT) \
    fatFS/ff_dirread.$(EXT) \
    fatFS/ff_dirregister.$(EXT) \
    fatFS/ff_dirsdi.$(EXT) \
    fatFS/ff_fchdir.$(EXT) \
    fatFS/ff_fchdrive.$(EXT) \
    fatFS/ff_fclose.$(EXT) \
    fatFS/ff_findvolume.$(EXT) \
    fatFS/ff_fgetfree.$(EXT) \
    fatFS/ff_fmkdir.$(EXT) \
    fatFS/ff_fmount.$(EXT) \
    fatFS/ff_followpath.$(EXT) \
    fatFS/ff_fopen.$(EXT) \
    fatFS/ff_fread.$(EXT) \
    fatFS/ff_frename.$(EXT) \
    fatFS/ff_fsync.$(EXT) \
    fatFS/ff_ftruncate.$(EXT) \
    fatFS/ff_funlink.$(EXT) \
    fatFS/ff_fwrite.$(EXT) \
    fatFS/ff_gennumname.$(EXT) \
    fatFS/ff_getfat.$(EXT) \
    fatFS/ff_getfileinfo.$(EXT) \
    fatFS/ff_getldnumber.$(EXT) \
    fatFS/ff_loadobjxdir.$(EXT) \
    fatFS/ff_ldclust.$(EXT) \
    fatFS/ff_lddword.$(EXT) \
    fatFS/ff_ldword.$(EXT) \
    fatFS/ff_lseek.$(EXT) \
    fatFS/ff_memcmp.$(EXT) \
    fatFS/ff_movewindow.$(EXT) \
    fatFS/ff_opendir.$(EXT) \
    fatFS/ff_picklfn.$(EXT) \
    fatFS/ff_putfat.$(EXT) \
    fatFS/ff_putlfn.$(EXT) \
    fatFS/ff_pututf.$(EXT) \
    fatFS/ff_readdir.$(EXT) \
    fatFS/ff_removechain.$(EXT) \
    fatFS/ff_stclust.$(EXT) \
    fatFS/ff_storexdir.$(EXT) \
    fatFS/ff_stdword.$(EXT) \
    fatFS/ff_stword.$(EXT) \
    fatFS/ff_syncfs.$(EXT) \
    fatFS/ff_syncwindow.$(EXT) \
    fatFS/ff_sumsfn.$(EXT) \
    fatFS/ff_tchar2uni.$(EXT) \
    fatFS/ff_validate.$(EXT) \
    fatFS/ff_vars.$(EXT) \
    fatFS/ff_xsum32.$(EXT) \
    fatFS/ffunicode_cp.$(EXT) \
    fatFS/ffunicode_ffoem2uni.$(EXT) \
    fatFS/ffunicode_ffuni2oem.$(EXT) \
    fatFS/ffunicode_ffwtoupper.$(EXT)

# Recipe to compile the app
.phony all: link

link: bios fatfs
	$(MB) -s 24576 phoenixBoot.ihx >phoenixBoot.rom

# tursi's special link step - requires makemegacart and parsemap tools
# makemegacart does the normal link step in this case but emits debug information
# parsemap just sorts the map file
# these tools are not included as they are not useful to the average person, but
# are available on github
tursi: bios fatfs
	"../makemegacart.exe" -bios phoenixBoot.ihx phoenixBoot.rom
	"../parseMap.exe" phoenixBoot.map

bios: $(MAIN_OBJS) fatfs f18a.h memset.h phoenix.h
	@$(RM) phoenixBoot.ihx
	$(CC) -mz80 --no-std-crt0 --code-loc 0x0090 --data-loc 0x6400 -l../libti99coleco/libti99.a -lfatfs.a $(MAIN_OBJS) -o phoenixBoot.ihx

fatfs: $(FAT_OBJS) fatFs/ff.h fatFs/ffconf.h fatFs/diskio.h
	$(AR) -rc fatfs.a $(FAT_OBJS)

# Recipe to clean all compiled objects
.phony clean:
	@$(RM) *.rel *.map *.lst *.lnk *.sym *.asm *~ *.o *.obj *.ihx *.rom *.rel *.a *.lib
	@$(RM) fatFS/*.rel fatFS/*.map fatFS/*.lst fatFS/*.lnk fatFS/*.sym fatFS/*.asm fatFS/*~ fatFS/*.o fatFS/*.obj fatFS/*.ihx fatFS/*.rom fatFS/*.rel fatFS/*.a fatFS/*.lib

# Recipe to compile all C files
%.rel: %.c
	$(CC) -c $< $(CFLAGS) -o $@

# Recipe to compile all assembly files
%.rel: %.s
	$(AS) -o $@ $<
