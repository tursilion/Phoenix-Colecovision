// string functions

void *memset (void *buf, unsigned char ch, int count) 
{
  register unsigned char *ret = buf;

    while (count--) {
      *(unsigned char *) ret = ch;
      ret++;
    }

  return buf ;
}

void *memcpy (void *dst, void *src, int acount) 
{
  char *d = dst;
  char *s = src;
	
  /*
   * copy from lower addresses to higher addresses
   */
  while (acount--)
    *d++ = *s++;

  return dst;
}

void *memmove (void *dst, void *src, int acount) 
{
  char *d;
  char *s;

  if (((int)src < (int)dst) && ((((int)src) + acount) > (int)dst))
    {
      /*
       * copy from higher addresses to lower addresses
       */
      d = ((char *)dst) + acount - 1;
      s = ((char *)src) + acount - 1;
      while (acount--)
      	*d-- = *s--;
    }
  else
    {
      /*
       * copy from lower addresses to higher addresses
       */
      d = dst;
      s = src;
      while (acount--)
      	*d++ = *s++;
    }

  return dst;
}
