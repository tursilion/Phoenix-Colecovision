You can just install it as CORE10

When it comes up, it will check for a cartridge and for a FAT32 (only) SD card.

Press 1 to dump a normal, 32k or less cart.
Press 2 to dump a Megacart.
Press 3 to dump a Super Game Cartridge.

The system doesn't try to guess the size of the cartridge, meaning it will usually overdump it. Use the tool fixDump (provided for Windows, but trivial to port to Linux - just delete stdafx and fix the dumb fopen_s calls back to normal fopen). It will remove duplicate and empty data as written by the Phoenix.
