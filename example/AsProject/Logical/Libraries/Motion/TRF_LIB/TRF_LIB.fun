(********************************************************************
 * COPYRIGHT (C) B&R Industrial Automation GmbH
 ********************************************************************
 * Library: TRF_LIB
 * File: TRF_LIB.fun
 ********************************************************************
 * Functions and function blocks in library TRF_LIB
 ********************************************************************)
FUNCTION TRF_init_instance    : UDINT (*Initialization of everything*)
    VAR_INPUT
        addr_var_name : UDINT ;
    END_VAR
END_FUNCTION
FUNCTION TRF_generic          : UDINT (*Generic function*)
    VAR_INPUT
        addr_trf_data : UDINT ;
        cmd_code      : UDINT ;
        in_data       : UDINT ;
        out_data      : UDINT ;
        info          : UDINT ;
    END_VAR
END_FUNCTION
FUNCTION TRF_direct           : UDINT (*Direct transformation*)
    VAR_INPUT
        addr_trf_data : UDINT ;
        in_pos        : UDINT ;
        in_pos_ext    : UDINT ;
        out_pos       : UDINT ;
        info          : UDINT ;
    END_VAR
END_FUNCTION
FUNCTION TRF_direct2          : UDINT (*Another type of direct transformation*)
    VAR_INPUT
        addr_trf_data : UDINT ;
        in_pos        : UDINT ;
        in_pos_ext    : UDINT ;
        out_pos       : UDINT ;
        info          : UDINT ;
    END_VAR
END_FUNCTION
FUNCTION TRF_inverse          : UDINT (*Inverse transformation*)
    VAR_INPUT
        addr_trf_data : UDINT ;
        in_pos        : UDINT ;
        in_pos_ext    : UDINT ;
        out_pos       : UDINT ;
        info          : UDINT ;
    END_VAR
END_FUNCTION
FUNCTION TRF_inverse2         : UDINT (*Another type of inverse transformation*)
    VAR_INPUT
        addr_trf_data : UDINT ;
        in_pos        : UDINT ;
        in_pos_ext    : UDINT ;
        out_pos       : UDINT ;
        info          : UDINT ;
    END_VAR
END_FUNCTION
FUNCTION TRF_get_joints_pos   : UDINT (*Positions of joints*)
    VAR_INPUT
        addr_trf_data : UDINT ;
        in_pos        : UDINT ;
        in_pos_ext    : UDINT ;
        out_pos       : UDINT ;
        info          : UDINT ;
    END_VAR
END_FUNCTION
FUNCTION TRF_get_size         : UDINT (*Size of mechanical system in zero position*)
    VAR_INPUT
        addr_trf_data : UDINT ;
        in_pos        : UDINT ;
        in_pos_ext    : UDINT ;
        out_pos       : UDINT ;
        info          : UDINT ;
    END_VAR
END_FUNCTION
FUNCTION TRF_get_mode         : UDINT (*Mode*)
    VAR_INPUT
        addr_trf_data : UDINT ;
        in_pos        : UDINT ;
        in_pos_ext    : UDINT ;
        out_pos       : UDINT ;
        info          : UDINT ;
    END_VAR
END_FUNCTION
FUNCTION TRF_direct3          : UDINT (*Another type of direct transformation*)
    VAR_INPUT
        addr_trf_data : UDINT ;
        in_pos        : UDINT ;
        in_pos_ext    : UDINT ;
        out_pos       : UDINT ;
        info          : UDINT ;
    END_VAR
END_FUNCTION
FUNCTION TRF_inverse3         : UDINT (*Another type of inverse transformation*)
    VAR_INPUT
        addr_trf_data : UDINT ;
        in_pos        : UDINT ;
        in_pos_ext    : UDINT ;
        out_pos       : UDINT ;
        info          : UDINT ;
    END_VAR
END_FUNCTION






