import os as _os
_os.chdir(_os.path.dirname(_os.path.abspath(__file__)))   # images/ and the ROMs live next to this script
import glob, os, time
from simtest import load, Machine
pay=open('images/payload.bin','rb').read()
roms={'original':open('svc.rom','rb').read(),'patched':open('svc_fat16.rom','rb').read()}
cases=[(os.path.basename(p)[:-4],p,True) for p in sorted(glob.glob('images/*.img'))]+[('fat16_mbr (SDSC byte-addr)','images/fat16_mbr.img',False),('fat32_mbr_frag (SDSC byte-addr)','images/fat32_mbr_frag.img',False)]
for name,path,sdhc in cases:
    img=open(path,'rb').read()
    row=[]
    for rn,rom in roms.items():
        t=time.time()
        try:
            st,data=load(rom,img,b'CORE01  PHX',len(pay),sdhc)
            if st=='ok': st='READ OK' if data==pay else 'DATA MISMATCH'
            st2,_=load(rom,img,b'CORE02  PHX',512,sdhc)
            st+=' / missing file: '+('not found (correct)' if st2=='file not found' else st2)
        except RuntimeError as e: st='HANG: '+str(e)
        row.append('%s: %s'%(rn,st))
    print('%-32s %s'%(name,' | '.join(row)),flush=True)
