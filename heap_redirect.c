#include <stdlib.h>
#include "tlsf.h"

//Redirect memory allocation calls:
struct _reent;
#define REENT struct _reent * _r __attribute__((__unused__))

void *	malloc(size_t size) { return tlsf_malloc(size); }
void	free(void* ptr) { tlsf_free(ptr); }
void *	realloc(void* ptr, size_t size) { return tlsf_realloc(ptr, size); }
void *	calloc(size_t items, size_t size) { return tlsf_calloc(items, size); }

#ifndef __CYGWIN__
void *	_malloc_r(REENT, size_t size) { return tlsf_malloc(size); }
void	_free_r(REENT, void* ptr) { tlsf_free(ptr); }
void *	_realloc_r(REENT, void* ptr, size_t size) { return tlsf_realloc(ptr, size); }
void *	_calloc_r(REENT, size_t items, size_t size) { return tlsf_calloc(items, size); }
#endif

int const _force_tlfs_malloc = (int) malloc;

__attribute__((weak,visibility("hidden"))) size_t bur_heap_size = 0; /* variable 'bur_heap_size' as dummy */
