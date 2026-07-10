/*
 * File: atnApi.h
 * Copyright (c) 2023 Loupe
 * https://loupe.team
 *
 * This file is part of All Together Now - ATN, licensed under the MIT License.
 *
 */

#include "atn.h"

#ifdef __cplusplus
	extern "C"
	{
#endif

void atnSetDirector( void *director );

unsigned short PLCOpenStatus( const STRING *command );

bool forCommandGetPLCOpenStatus(plcstring* command, signed short index, unsigned short *status);

#ifdef __cplusplus
	};
#endif

#include <iostream>

class outbuf : public std::streambuf {
	private:
	char * _front;
	char * _current;
	size_t _sz;
	bool rolled;
	bool hasBeenReset;
	public:
	outbuf( char * data, size_t sz );

	virtual int_type overflow(int_type c = traits_type::eof());
	void reset();
};
