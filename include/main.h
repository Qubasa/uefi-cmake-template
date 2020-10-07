// Set function symbol directly without name mangling
void *memcpy(void *dest, const void *src, size_t len) asm ("memcpy");
void *memcpy(void *dest, const void *src, size_t len) {
  char *d = (char*) dest;
  const char *s = (char*) src;
  while (len--)
    *d++ = *s++;
  return dest;
}
