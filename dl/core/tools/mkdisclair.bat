@rem set up a path so the script can find ffmpeg
@path=%path%;..\..\ffmpeg-master-latest-win64-gpl-shared\bin
rem install some libraries the script needs - numpy is a python number library, pillow is for graphics
rem after the first time, you'll already have these
pip install numpy pillow
rem now run the conversion - this will take a moment
python3 mkdisc.py LAIR.LD --game lair --rom dl_f2_u1.bin dl_f2_u2.bin dl_f2_u3.bin dl_f2_u4.bin --framefile lair.txt
pause
