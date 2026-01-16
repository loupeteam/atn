/*
 * File: heap_redirect.c
 * Copyright (c) 2023 Loupe
 * https://loupe.team
 * 
 * This file is part of All Together Now - ATN, licensed under the MIT License.
 * 
 */

#include <stdlib.h>

__attribute__((weak,visibility("hidden"))) size_t bur_heap_size = 0; /* variable 'bur_heap_size' as dummy */
