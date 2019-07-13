// string functions
// These are all in crt0.s now
// TODO: check for 0 counts...

#if 0
void *memset(void *buf, unsigned int ch, unsigned int cnt) 
{
    unsigned char *work = buf;

    while (cnt&0x03) {
        *(work++) = ch;
        --cnt;
    }

    while (cnt) {
        *(work++) = ch;
        *(work++) = ch;
        *(work++) = ch;
        *(work++) = ch;
        cnt -= 4;
    }

    return buf ;
}
#endif

#if 0
// using asm memcpy which is in crt0.s
void *memcpy (void *dst, void *src, unsigned int cnt) 
{
    char *d = dst;
    char *s = src;
	
    while (cnt--) {
        *d++ = *s++;
    }

    return dst;
}
#endif

#if 0
void *memmove (void *dst, void *src, unsigned int cnt) 
{
    char *d;
    char *s;

    if (((int)src < (int)dst) && ((((int)src) + cnt) > (int)dst))
    {
        // overlapped copy with src less than dest
        d = ((char *)dst) + cnt - 1;
        s = ((char *)src) + cnt - 1;
        while (cnt--) {
            *d-- = *s--;
        }
    } else {
        // non-overlapped copy or src greater than dest
        d = dst;
        s = src;
        while (cnt--) {
            *d++ = *s++;
        }
    }

    return dst;
}
#endif
