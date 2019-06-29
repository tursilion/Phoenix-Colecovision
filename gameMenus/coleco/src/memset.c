// string functions

void *memset (void *buf, unsigned char ch, int cnt) 
{
    unsigned char *ret = buf;

    while (cnt--) {
        *(ret++) = ch;
    }

    return buf ;
}

#if 0
// using asm memcpy which is in crt0.s
void *memcpy (void *dst, void *src, int cnt) 
{
    char *d = dst;
    char *s = src;
	
    while (cnt--) {
        *d++ = *s++;
    }

    return dst;
}
#endif

void *memmove (void *dst, void *src, int cnt) 
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
