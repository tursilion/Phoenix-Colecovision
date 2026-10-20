@rem set up a path so the script can find ffmpeg
@path=%path%;..\..\ffmpeg-master-latest-win64-gpl-shared\bin
rem install some libraries the script needs - numpy is a python number library, pillow is for graphics
rem after the first time, you'll already have these
pip install numpy pillow
rem now run the conversion - this will take a moment
python3 mkdisc.py ACE.LD --game ace --rom sa_a3_u1.bin sa_a3_u2.bin sa_a3_u3.bin sa_a3_u4.bin sa_a3_u5.bin --framefile ace.txt
pause



