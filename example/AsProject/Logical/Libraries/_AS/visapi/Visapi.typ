
TYPE
	display_info : STRUCT
		width				: UINT;
		height				: UINT;
		func1				: UDINT;
		func2				: UDINT;
		bpp					: USINT;
	END_STRUCT;

	VCHANDLE : UDINT;

	TouchAction : STRUCT
		status				: UDINT;
		y					: UDINT;
		x					: UDINT;
	END_STRUCT;

	sVCBitmap : STRUCT
		vpInternalData		: UDINT;
		vpData				: UDINT;
		iBPP				: DINT;
		iHeight				: DINT;
		iWidth				: DINT;
		ulFlags				: UDINT;
	END_STRUCT;

END_TYPE
