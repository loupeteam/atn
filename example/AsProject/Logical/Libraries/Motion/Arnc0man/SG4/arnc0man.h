/* arnc0man.h V5.15.1 */
/* COPYRIGHT (C) B&R Industrial Automation GmbH */
#ifndef ARNC0MAN_H_VERSION
#define ARNC0MAN_H_VERSION 0x5151

#include <ncglobal.h>
#include <acp10par.h>

/*** DATA TYPES *************************************************************/

typedef struct ARNC0SWVER_typ {               /* Software Version ID */
   USINT              NOT_USE_1[2];
   UINT               nc_system_device;       /* ACOPOS operating system */
   UINT               nc_manager;             /* NC manager */
   UINT               nc_system;              /* NC operating system */
} ARNC0SWVER_typ;

typedef struct ARNC0OBIHW_typ {               /* Hardware information */
   USINT              init;                   /* Initialized */
   USINT              reserve1;               /* Reserved */
   USINT              acp_id;                 /* ACOPOS ID */
   USINT              acp_id_nr;              /* ACOPOS ID production number */
   USINT              acp_typ;                /* ACOPOS type */
   USINT              ax_num;                 /* Number of axes (power stages) */
   UINT               reserve2;               /* Reserved */
   UDINT              product_code;           /* Product code */
   UDINT              serial_nr;              /* Serial number */
} ARNC0OBIHW_typ;

typedef struct ARNC0OBINF_typ {               /* NC Object Information */
   UINT               net_if_typ;             /* Network interface type */
   UINT               net_if_idx;             /* Network interface index */
   UINT               node_nr;                /* Drive node number */
   UINT               nc_obj_typ;             /* NC object type */
   UINT               nc_obj_idx;             /* NC object index */
   UINT               reserve;                /* Reserved */
   USINT              nc_obj_name[48];        /* NC object name */
   ARNC0OBIHW_typ     hardware;               /* Hardware information */
} ARNC0OBINF_typ;

typedef struct ARNC0AXSIM_typ {               /* Simulation mode */
   USINT              NOT_USE_1[4];
   UINT               status;                 /* Status */
   UINT               mode;                   /* Mode */
   USINT              NOT_USE_2[48];
} ARNC0AXSIM_typ;

typedef struct ARNC0GLIPA_typ {               /* INIT Parameters */
   USINT              ok;                     /* Operation complete */
   USINT              error;                  /* Error */
   UINT               reserve;                /* Reserved */
   UDINT              datobj_ident;           /* Data object ident */
   USINT              data_modul[12];         /* Name of the data module */
} ARNC0GLIPA_typ;

typedef struct ARNC0GLINI_typ {               /* Global Initialization */
   USINT              init;                   /* Global Initialization complete */
   USINT              NOT_USE_1[3];
   ARNC0GLIPA_typ     init_par;               /* INIT Parameters */
} ARNC0GLINI_typ;

typedef struct ARNC0NSVRQ_typ {               /* Request (to the drive) */
   UINT               par_id;                 /* Parameter ID */
   USINT              NOT_USE_1[2];
} ARNC0NSVRQ_typ;

typedef struct ARNC0NSVRS_typ {               /* Response (from the drive) */
   UINT               par_id;                 /* Parameter ID */
   USINT              NOT_USE_1[2];
} ARNC0NSVRS_typ;

typedef struct ARNC0NETSV_typ {               /* Service Interface */
   UDINT              data_adr;               /* Data address */
   USINT              data_text[32];          /* Data in text format */
   ARNC0NSVRQ_typ     request;                /* Request (to the drive) */
   ARNC0NSVRS_typ     response;               /* Response (from the drive) */
} ARNC0NETSV_typ;

typedef struct ARNC0NETAX_typ {               /* Network */
   USINT              init;                   /* Network initialized */
   USINT              phase;                  /* Phase */
   USINT              NOT_USE_1;
   USINT              nc_sys_restart;         /* A Restart of the NC operating system was executed */
   UINT               reserve;                /* Reserved */
   UINT               reserve1;               /* Reserved */
   ARNC0NETSV_typ     service;                /* Service Interface */
} ARNC0NETAX_typ;

typedef struct ARNC0AXDBS_typ {               /* Status */
   USINT              ok;                     /* Operation complete */
   USINT              error;                  /* Error */
   USINT              reserve1;               /* Reserved */
   USINT              reserve2;               /* Reserved */
   UDINT              data_len;               /* Length of data */
   UDINT              datobj_ident;           /* Data object ident */
   UDINT              datobj_datadr;          /* Address of the data object data */
} ARNC0AXDBS_typ;

typedef struct ARNC0AXDBP_typ {               /* Parameters */
   USINT              file_device[32];        /* Name of File Device */
   USINT              datobj_name[32];        /* Name of the data object */
   UINT               datobj_type;            /* Type of the data object */
   UINT               datblock_par_id;        /* Parameter ID of the data block */
   UINT               idx1_par_id;            /* Parameter ID of data block index 1 */
   UINT               idx1;                   /* Data block index 1 */
   UINT               idx2_par_id;            /* Parameter ID of data block index 2 */
   UINT               idx2;                   /* Data block index 2 */
   USINT              NOT_USE_1[8];
} ARNC0AXDBP_typ;

typedef struct ARNC0AXDBL_typ {               /* Data block operation */
   ARNC0AXDBS_typ     status;                 /* Status */
   ARNC0AXDBP_typ     parameter;              /* Parameters */
} ARNC0AXDBL_typ;

typedef struct ARNC0DISTA_typ {               /* Status */
   USINT              reference;              /* Reference switch */
   USINT              pos_hw_end;             /* Positive HW end switch */
   USINT              neg_hw_end;             /* Negative HW end switch */
   USINT              trigger1;               /* Trigger1 */
   USINT              trigger2;               /* Trigger2 */
   USINT              enable;                 /* Enable */
   USINT              NOT_USE_1[2];
} ARNC0DISTA_typ;

typedef struct ARNC0DILEV_typ {               /* Active Input Level */
   UINT               reference;              /* Reference switch */
   UINT               pos_hw_end;             /* Positive HW end switch */
   UINT               neg_hw_end;             /* Negative HW end switch */
   UINT               trigger1;               /* Trigger1 */
   UINT               trigger2;               /* Trigger2 */
   USINT              NOT_USE_1[2];
} ARNC0DILEV_typ;

typedef struct ARNC0DIFRC_typ {               /* Set status of digital inputs via force function */
   USINT              reference;              /* Reference switch */
   USINT              pos_hw_end;             /* Positive HW end switch */
   USINT              neg_hw_end;             /* Negative HW end switch */
   USINT              trigger1;               /* Trigger1 */
   USINT              trigger2;               /* Trigger2 */
   USINT              reserve1;               /* Reserved */
   UINT               reserve2;               /* Reserved */
} ARNC0DIFRC_typ;

typedef struct ARNC0DIGIN_typ {               /* Digital Inputs */
   USINT              init;                   /* Digital inputs initialized */
   USINT              NOT_USE_1[3];
   ARNC0DISTA_typ     status;                 /* Status */
   ARNC0DILEV_typ     level;                  /* Active Input Level */
   ARNC0DIFRC_typ     force;                  /* Set status of digital inputs via force function */
} ARNC0DIGIN_typ;

typedef struct ARNC0ENCSL_typ {               /* Load */
   UDINT              units;                  /* Units at the load */
   UDINT              rev_motor;              /* Motor revolutions */
} ARNC0ENCSL_typ;

typedef struct ARNC0ENCSC_typ {               /* Scale of encoder interface */
   ARNC0ENCSL_typ     load;                   /* Load */
} ARNC0ENCSC_typ;

typedef struct ARNC0ENCPA_typ {               /* Parameters of encoder interface */
   USINT              count_dir;              /* Count direction */
   USINT              NOT_USE_1[3];
   ARNC0ENCSC_typ     scaling;                /* Scaling */
} ARNC0ENCPA_typ;

typedef struct ARNC0ENCIF_typ {               /* Encoder interface */
   USINT              init;                   /* Encoder interface initialized */
   USINT              NOT_USE_1[3];
   ARNC0ENCPA_typ     parameter;              /* Parameters */
} ARNC0ENCIF_typ;

typedef struct ARNC0AXLPA_typ {               /* Parameters */
   REAL               v_pos;                  /* Speed in positive direction */
   REAL               v_neg;                  /* Speed in negative direction */
   REAL               a1_pos;                 /* Acceleration in positive direction */
   REAL               a2_pos;                 /* Deceleration in positive direction */
   REAL               a1_neg;                 /* Acceleration in negative direction */
   REAL               a2_neg;                 /* Deceleration in negative direction */
   REAL               t_jolt;                 /* Jolt time */
   REAL               t_in_pos;               /* Settling time before message "In Position" */
   DINT               pos_sw_end;             /* Positive SW end */
   DINT               neg_sw_end;             /* Negative SW end */
   USINT              sw_end_enable;          /* Control byte for limit monitor */
   USINT              sl_chain;               /* Slaves in a chain or ncOFF */
   USINT              NOT_USE_1[2];
   REAL               ds_warning;             /* Lag error limit for display of a warning */
   REAL               ds_stop;                /* Lag error limit for stop of a movement */
   REAL               a_stop;                 /* Acceleration limit for stop of a movement */
   REAL               dv_stop;                /* Speed error limit for stop of a movement */
   UDINT              dv_stop_mode;           /* Mode for speed error monitoring */
} ARNC0AXLPA_typ;

typedef struct ARNC0AXLIM_typ {               /* Limit values */
   USINT              init;                   /* Axis limit values initialized */
   USINT              status;                 /* Status */
   USINT              NOT_USE_1[2];
   ARNC0AXLPA_typ     parameter;              /* Parameters */
} ARNC0AXLIM_typ;

typedef struct ARNC0CTRPO_typ {               /* Position controller */
   REAL               kv;                     /* Proportional amplification */
   REAL               tn;                     /* Integral action time */
   REAL               t_predict;              /* Prediction time */
   REAL               t_total;                /* Total time */
   REAL               p_max;                  /* Maximum proportional action */
   REAL               i_max;                  /* Maximum integral action */
} ARNC0CTRPO_typ;

typedef struct ARNC0ISQFI_typ {               /* ISQ Filter */
   UINT               type;                   /* Type */
   UINT               reserve;                /* Reserved */
   REAL               a0;                     /* Coefficient a0 */
   REAL               a1;                     /* Coefficient a1 */
   REAL               b0;                     /* Coefficient b0 */
   REAL               b1;                     /* Coefficient b1 */
   REAL               b2;                     /* Coefficient b2 */
   UINT               c0_par_id;              /* Parameter ID for coefficient c0 */
   UINT               c1_par_id;              /* Parameter ID for coefficient c1 */
} ARNC0ISQFI_typ;

typedef struct ARNC0CTRSP_typ {               /* Speed controller */
   REAL               kv;                     /* Proportional amplification */
   REAL               tn;                     /* Integral action time */
   REAL               t_filter;               /* Filter time constant */
   ARNC0ISQFI_typ     isq_filter1;            /* ISQ Filter1 */
   ARNC0ISQFI_typ     isq_filter2;            /* ISQ Filter2 */
   ARNC0ISQFI_typ     isq_filter3;            /* ISQ Filter3 */
} ARNC0CTRSP_typ;

typedef struct ARNC0CTRUF_typ {               /* U/f Control */
   USINT              type;                   /* Type */
   USINT              auto_config;            /* Automatic configuration */
   UINT               reserve;                /* Reserved */
   REAL               u0;                     /* Boost voltage */
   REAL               un;                     /* Rated voltage */
   REAL               fn;                     /* Rated frequency */
   REAL               k_f_slip;               /* Slip compensation: Multiplication factor of compensated frequency */
} ARNC0CTRUF_typ;

typedef struct ARNC0CTRFF_typ {               /* Feed Forward Control */
   USINT              NOT_USE_1[4];
   REAL               torque_load;            /* Load torque */
   REAL               torque_pos;             /* Torque in positive direction */
   REAL               torque_neg;             /* Torque in negative direction */
   REAL               kv_torque;              /* Speed torque factor */
   REAL               inertia;                /* Mass moment of inertia */
   REAL               t_filter_a;             /* Acceleration filter time constant */
} ARNC0CTRFF_typ;

typedef struct ARNC0CTRL_typ {                /* Controller */
   USINT              init;                   /* Controller initialized */
   USINT              ready;                  /* Ready */
   USINT              status;                 /* Status */
   USINT              mode;                   /* Mode */
   ARNC0CTRPO_typ     position;               /* Position Controller */
   ARNC0CTRSP_typ     speed;                  /* Speed Controller */
   ARNC0CTRUF_typ     uf;                     /* U/f Control */
   ARNC0CTRFF_typ     ff;                     /* Feed Forward Control */
   USINT              NOT_USE_1[36];
} ARNC0CTRL_typ;

typedef struct ARNC0AXSTI_typ {               /* Index of Parameter Record */
   USINT              command;                /* for the next stop command */
   USINT              NOT_USE_1[3];
} ARNC0AXSTI_typ;

typedef struct ARNC0AXSTP_typ {               /* Parameter Records */
   USINT              decel_ramp;             /* Deceleration ramp */
   USINT              controller;             /* Controller state after movement abortion */
   USINT              NOT_USE_1[2];
} ARNC0AXSTP_typ;

typedef struct ARNC0AXSTQ_typ {               /* Quickstop */
   USINT              decel_ramp;             /* Deceleration ramp */
   USINT              NOT_USE_1;
   UINT               reserve2;               /* Reserved */
   USINT              NOT_USE_2[4];
} ARNC0AXSTQ_typ;

typedef struct ARNC0AXSTD_typ {               /* Drive error */
   USINT              decel_ramp;             /* Deceleration ramp */
   USINT              reserve1;               /* Reserved */
   UINT               reserve2;               /* Reserved */
} ARNC0AXSTD_typ;

typedef struct ARNC0AXSTO_typ {               /* Stop Movement */
   USINT              init;                   /* Stop initialized */
   USINT              NOT_USE_1[3];
   ARNC0AXSTI_typ     index;                  /* Index */
   ARNC0AXSTP_typ     parameter[4];           /* Parameter record */
   ARNC0AXSTQ_typ     quickstop;              /* Quickstop */
   ARNC0AXSTD_typ     drive_error;            /* Drive error */
} ARNC0AXSTO_typ;

typedef struct ARNC0HOMST_typ {               /* Status */
   USINT              ok;                     /* Reference position valid */
   USINT              NOT_USE_1[3];
   REAL               tr_s_rel;               /* Distance between activation of "triggering reference pulse" and the occurrence of the reference pulse */
   DINT               offset;                 /* Home offset after completion of homing procedure */
} ARNC0HOMST_typ;

typedef struct ARNC0HOMPA_typ {               /* Parameters */
   DINT               s;                      /* Reference position */
   REAL               v_switch;               /* Speed for searching the reference switch */
   REAL               v_trigger;              /* Trigger speed (after ref. switch has been reached) */
   REAL               a;                      /* Acceleration */
   USINT              mode;                   /* Mode */
   USINT              edge;                   /* Edge of reference switch */
   USINT              start_dir;              /* Start direction */
   USINT              trigg_dir;              /* Trigger direction */
   USINT              ref_pulse;              /* Reference pulse */
   USINT              fix_dir;                /* Fixed direction */
   USINT              reserve1;               /* Reserved */
   USINT              reserve2;               /* Reserved */
   REAL               tr_s_block;             /* Reference pulse block distance */
   REAL               torque_lim;             /* Torque limit for homing on block */
   REAL               ds_block;               /* Lag error for block detection */
   REAL               ds_stop;                /* Lag error for stop of a movement */
} ARNC0HOMPA_typ;

typedef struct ARNC0HOME_typ {                /* Homing */
   USINT              init;                   /* Homing procedure initialized */
   USINT              NOT_USE_1[3];
   ARNC0HOMST_typ     status;                 /* Status */
   ARNC0HOMPA_typ     parameter;              /* Parameters */
} ARNC0HOME_typ;

typedef struct ARNC0BMVST_typ {               /* Status */
   USINT              in_pos;                 /* "In Position" (target position reached) */
   USINT              reserve[3];             /* Reserved */
} ARNC0BMVST_typ;

typedef struct ARNC0BMVOV_typ {               /* Override */
   UINT               v;                      /* Speed override */
   USINT              NOT_USE_1[2];
} ARNC0BMVOV_typ;

typedef struct ARNC0BMVPA_typ {               /* Parameters */
   DINT               s;                      /* Target position or relative move distance */
   REAL               v_pos;                  /* Speed in positive direction */
   REAL               v_neg;                  /* Speed in negative direction */
   REAL               a1_pos;                 /* Acceleration in positive direction */
   REAL               a2_pos;                 /* Deceleration in positive direction */
   REAL               a1_neg;                 /* Acceleration in negative direction */
   REAL               a2_neg;                 /* Deceleration in negative direction */
} ARNC0BMVPA_typ;

typedef struct ARNC0TRG_typ {                 /* Source for Hardware Trigger */
   UDINT              nc_object;              /* NC object or ncOFF */
   USINT              NOT_USE_1[8];
} ARNC0TRG_typ;

typedef struct ARNC0TRSTP_typ {               /* Mode "Stop after trigger" */
   USINT              init;                   /* Initialized */
   USINT              event;                  /* Event */
   USINT              NOT_USE_1[2];
   DINT               s_rest;                 /* Remaining distance after trigger */
   ARNC0TRG_typ       trg_source;             /* Trigger Source */
} ARNC0TRSTP_typ;

typedef struct ARNC0BAMOV_typ {               /* Basis Movements */
   USINT              init;                   /* Initialized */
   USINT              reserve0[3];            /* Reserved */
   ARNC0BMVST_typ     status;                 /* Status */
   ARNC0BMVOV_typ     override;               /* Override */
   ARNC0BMVPA_typ     parameter;              /* Parameters */
   ARNC0TRSTP_typ     trg_stop;               /* Mode "Stop after trigger" */
} ARNC0BAMOV_typ;

typedef struct ARNC0AXMOV_typ {               /* Axis Movement */
   UINT               mode;                   /* Mode */
   UINT               detail;                 /* Detail */
   ARNC0AXSTO_typ     stop;                   /* Stop Movement */
   ARNC0HOME_typ      homing;                 /* Homing procedure */
   ARNC0BAMOV_typ     basis;                  /* Basis movements */
} ARNC0AXMOV_typ;

typedef struct ARNC0SUOST_typ {               /* Status */
   UDINT              ident;                  /* Ident of data object */
   USINT              ok;                     /* Operation complete */
   USINT              error;                  /* Error */
   USINT              reserve1;               /* Reserved */
   USINT              reserve2;               /* Reserved */
} ARNC0SUOST_typ;

typedef struct ARNC0SUOPA_typ {               /* Parameters */
   USINT              name[12];               /* Name of data object */
} ARNC0SUOPA_typ;

typedef struct ARNC0SUOBJ_typ {               /* Data object */
   ARNC0SUOST_typ     status;                 /* Status */
   ARNC0SUOPA_typ     parameter;              /* Parameters */
} ARNC0SUOBJ_typ;

typedef struct ARNC0SUMAS_typ {               /* Status */
   UINT               mode;                   /* Mode */
   USINT              ok;                     /* Operation complete */
   USINT              error;                  /* Error */
   REAL               quality;                /* Quality of parameter identification */
} ARNC0SUMAS_typ;

typedef struct ARNC0SUMAO_typ {               /* Optional parameters */
   USINT              z_p;                    /* Number of polepairs */
   USINT              phase;                  /* Phase */
   UINT               reserve2;               /* Reserved */
   REAL               u_const;                /* Voltage constant */
   REAL               v_max;                  /* Maximum speed */
   REAL               trq_0;                  /* Stall  torque */
   REAL               trq_n;                  /* Rated torque */
   REAL               trq_max;                /* Peak  torque */
   REAL               trq_const;              /* Torque constant */
   REAL               i_0;                    /* Stall current */
   REAL               i_max;                  /* Peak current */
   REAL               i_m;                    /* Magnetizing current */
   REAL               phase_cross_sect ;      /* Cross section of a phase */
   REAL               invcl_a1;               /* Inverter characteristic: Gain factor */
   REAL               invcl_a2;               /* Inverter characteristic: Exponent */
} ARNC0SUMAO_typ;

typedef struct ARNC0SUMAP_typ {               /* Parameters */
   UINT               mode;                   /* Mode */
   UINT               reserve;                /* Reserved */
   REAL               u_n;                    /* Rated voltage */
   REAL               i_n;                    /* Rated current */
   REAL               v_n;                    /* Rated speed */
   REAL               f_n;                    /* Rated frequency */
   REAL               cos_phi;                /* Active power factor */
   REAL               t_tripping_therm;       /* Tripping time at thermal overload */
   ARNC0SUMAO_typ     optional;               /* Optional parameters */
} ARNC0SUMAP_typ;

typedef struct ARNC0SUMA_typ {                /* Induction motor */
   ARNC0SUMAS_typ     status;                 /* Status */
   ARNC0SUMAP_typ     parameter;              /* Parameters */
} ARNC0SUMA_typ;

typedef struct ARNC0SUMSS_typ {               /* Status */
   UINT               mode;                   /* Mode */
   USINT              ok;                     /* Operation complete */
   USINT              error;                  /* Error */
   REAL               quality;                /* Quality of parameter identification */
} ARNC0SUMSS_typ;

typedef struct ARNC0SUMSO_typ {               /* Optional parameters */
   USINT              phase;                  /* Phase */
   USINT              reserve1;               /* Reserved */
   UINT               reserve2;               /* Reserved */
   REAL               u_const;                /* Voltage constant */
   REAL               v_max;                  /* Maximum speed */
   REAL               trq_0;                  /* Stall  torque */
   REAL               trq_const;              /* Torque constant */
   REAL               i_0;                    /* Stall current */
   REAL               phase_cross_sect ;      /* Cross section of a phase */
   REAL               invcl_a1;               /* Inverter characteristic: Gain factor */
   REAL               invcl_a2;               /* Inverter characteristic: Exponent */
} ARNC0SUMSO_typ;

typedef struct ARNC0SUMSP_typ {               /* Parameters */
   UINT               mode;                   /* Mode */
   USINT              z_p;                    /* Number of polepairs */
   USINT              reserve;                /* Reserved */
   REAL               u_n;                    /* Rated voltage */
   REAL               i_n;                    /* Rated current */
   REAL               v_n;                    /* Rated speed */
   REAL               trq_n;                  /* Rated torque */
   REAL               trq_max;                /* Peak  torque */
   REAL               i_max;                  /* Peak current */
   REAL               t_tripping_therm;       /* Tripping time at thermal overload */
   ARNC0SUMSO_typ     optional;               /* Optional parameters */
} ARNC0SUMSP_typ;

typedef struct ARNC0SUMS_typ {                /* Synchronous motor */
   ARNC0SUMSS_typ     status;                 /* Status */
   ARNC0SUMSP_typ     parameter;              /* Parameters */
} ARNC0SUMS_typ;

typedef struct ARNC0SUPHS_typ {               /* Status */
   UINT               mode;                   /* Mode */
   USINT              ok;                     /* Operation complete */
   USINT              error;                  /* Error */
   REAL               rho_0;                  /* Commutation offset */
   USINT              z_p;                    /* Number of polepairs */
   USINT              reserve1;               /* Reserved */
   UINT               reserve2;               /* Reserved */
} ARNC0SUPHS_typ;

typedef struct ARNC0SUPHP_typ {               /* Parameters */
   UINT               mode;                   /* Mode */
   UINT               reserve;                /* Reserved */
   REAL               i;                      /* Current */
   REAL               t;                      /* Time */
} ARNC0SUPHP_typ;

typedef struct ARNC0SUPH_typ {                /* Motor phasing */
   ARNC0SUPHS_typ     status;                 /* Status */
   ARNC0SUPHP_typ     parameter;              /* Parameters */
} ARNC0SUPH_typ;

typedef struct ARNC0SUCST_typ {               /* Status */
   UINT               mode;                   /* Mode */
   USINT              ok;                     /* Operation complete */
   USINT              error;                  /* Error */
} ARNC0SUCST_typ;

typedef struct ARNC0SUCPA_typ {               /* Parameters */
   UINT               mode;                   /* Mode */
   USINT              orientation;            /* Orientation */
   USINT              operating_point;        /* Operating point */
   REAL               i_max_percent;          /* Maximum percentage for rated current */
   REAL               v_max_percent;          /* Maximum percentage for speed limit value */
   DINT               s_max;                  /* Maximum move distance */
   REAL               ds_max;                 /* Maximum lag error */
   REAL               kv_percent;             /* Percentage for proportional amplification */
   UDINT              signal_order;           /* Order of excitation signal */
   REAL               kv_max;                 /* Maximum proportional amplification */
   REAL               a;                      /* Acceleration */
   UINT               signal_type;            /* Type of the excitation signal */
   UINT               reserve;                /* Reserved */
   REAL               signal_f_start;         /* Start frequency of the excitation signal */
   REAL               signal_f_stop;          /* Stop frequency of the excitation signal */
   REAL               signal_time;            /* Duration of the excitation signal */
} ARNC0SUCPA_typ;

typedef struct ARNC0SUCTR_typ {               /* Controller */
   ARNC0SUCST_typ     status;                 /* Status */
   ARNC0SUCPA_typ     parameter;              /* Parameters */
} ARNC0SUCTR_typ;

typedef struct ARNC0SUIRS_typ {               /* Status */
   UINT               mode;                   /* Mode */
   USINT              ok;                     /* Operation complete */
   USINT              error;                  /* Error */
   REAL               quality;                /* Quality of parameter identification */
} ARNC0SUIRS_typ;

typedef struct ARNC0SUIRP_typ {               /* Parameters */
   UINT               mode;                   /* Mode */
   USINT              reserve;                /* Reserved */
   USINT              ref_system;             /* Reference system */
   REAL               pos_offset;             /* Position offset */
   REAL               v;                      /* Speed */
} ARNC0SUIRP_typ;

typedef struct ARNC0SUIR_typ {                /* ISQ-Ripple */
   ARNC0SUIRS_typ     status;                 /* Status */
   ARNC0SUIRP_typ     parameter;              /* Parameters */
} ARNC0SUIR_typ;

typedef struct ARNC0SETUP_typ {               /* Setup */
   USINT              status;                 /* Status */
   USINT              reserve;                /* Reserved */
   UINT               detail;                 /* Detail */
   ARNC0SUOBJ_typ     datobj;                 /* Data object */
   ARNC0SUMA_typ      motor_induction;        /* Induction motor */
   ARNC0SUMS_typ      motor_synchron;         /* Synchronous motor */
   ARNC0SUPH_typ      motor_phasing;          /* Motor phasing */
   ARNC0SUCTR_typ     controller;             /* Controller */
   ARNC0SUIR_typ      isq_ripple;             /* ISQ-Ripple */
   USINT              NOT_USE_1[12];
} ARNC0SETUP_typ;

typedef struct ARNC0PLCOPENAX_typ {           /* PLCopen */
   USINT              PLCopen_AxState;        /* PLCopen axis state */
   USINT              NOT_USE_1[3];
} ARNC0PLCOPENAX_typ;

typedef struct ARNC0ACTST_typ {               /* Status */
   USINT              active;                 /* Active */
   USINT              complete;               /* Complete */
   USINT              NOT_USE_1[2];
} ARNC0ACTST_typ;

typedef struct ARNC0LATCH_typ {               /* Position latch */
   ARNC0ACTST_typ     status;                 /* Status */
   DINT               position;               /* Latchposition */
   DINT               position2;              /* Second latchposition */
   USINT              event;                  /* Event */
   USINT              reserve[3];             /* Reserved */
   DINT               window;                 /* Latch window */
   DINT               w_position;             /* Position of the latch window */
} ARNC0LATCH_typ;

typedef struct ARNC0POS_L_typ {               /* Position latches */
   ARNC0LATCH_typ     latch1;                 /* Positioning latch 1 */
   ARNC0LATCH_typ     latch2;                 /* Positioning latch 2 */
} ARNC0POS_L_typ;

typedef struct ARNC0CPRST_typ {               /* Status */
   USINT              active;                 /* Active */
   USINT              index;                  /* Index */
   USINT              cnt_start;              /* Number of not acknowledged start commands */
   USINT              reserve;                /* Reserved */
   USINT              curr_prof[12];          /* Name of current cam profile */
} ARNC0CPRST_typ;

typedef struct ARNC0CPRPA_typ {               /* Parameters */
   USINT              mode;                   /* Mode */
   USINT              reserve0[3];            /* Reserved */
   UDINT              ma_ax;                  /* NC object of the master axis */
   UDINT              ma_add_ax;              /* NC object of the additive axis of the master axis */
   UDINT              sl_add_ax;              /* NC object of the additive axis of the slave  axis */
   DINT               ma_s_start;             /* Start position of the master axis */
   UDINT              ma_ivstart;             /* Start interval of the master axis */
   REAL               ma_add_el;              /* "Additive" element of the master axis */
   REAL               ma_factor;              /* Multiplication factor for the master axis */
   REAL               ma_add_fa;              /* Multiplication factor for the "additive" axis of the master axis */
   REAL               sl_add_el;              /* "Additive" element of the slave axis */
   REAL               sl_factor;              /* Multiplication factor for the slave  axis */
   REAL               sl_add_fa;              /* Multiplication factor for the "additive" axis of the slave axis */
   USINT              factor_set;             /* Set multiplication factors "ma/sl_factor" */
   USINT              reserve[3];             /* Reserved */
   UDINT              reserve1[6];            /* Reserved */
} ARNC0CPRPA_typ;

typedef struct ARNC0CPRDM_typ {               /* Data Modules */
   USINT              single[12];             /* Name of the entry cam profile */
   USINT              cyclic[12];             /* Name of the cyclic cam profile */
} ARNC0CPRDM_typ;

typedef struct ARNC0CPINF_typ {               /* INFO Function */
   ARNC0ACTST_typ     status;                 /* Status */
   DINT               sl_s_rel;               /* Relative position of slave axis in the cam profile */
   UDINT              ma_s_rel;               /* Relative position of master axis in the cam profile */
} ARNC0CPINF_typ;

typedef struct ARNC0CPRCG_typ {               /* Compensation Gears */
   REAL               ma_v_max;               /* Maximum speed of the master axis */
   DINT               ma_s_comp;              /* Compensation distance of master axis */
   DINT               sl_s_comp;              /* Compensation distance of slave axis */
} ARNC0CPRCG_typ;

typedef struct ARNC0CAMPR_typ {               /* Electronic Cam Profile */
   ARNC0CPRST_typ     status;                 /* Status */
   ARNC0CPRPA_typ     parameter;              /* Parameters */
   ARNC0CPRDM_typ     data_modul;             /* Data Modules */
   ARNC0CPINF_typ     info;                   /* INFO-function */
   ARNC0CPRCG_typ     co_gears;               /* Compensation gear */
} ARNC0CAMPR_typ;

typedef struct ARNC0AUTSP_typ {               /* Parameters */
   USINT              index;                  /* Index */
   USINT              reserve[3];             /* Reserved */
} ARNC0AUTSP_typ;

typedef struct ARNC0AUTST_typ {               /* Status */
   USINT              init;                   /* Initialized */
   USINT              active;                 /* Active */
   USINT              st_type;                /* Type of the actual state */
   USINT              st_index;               /* Index of the actual state */
   ARNC0AUTSP_typ     cam_prof;               /* Cam profile */
} ARNC0AUTST_typ;

typedef struct ARNC0AUTID_typ {               /* INIT State */
   USINT              st_type;                /* Type of the state to initialize */
   USINT              st_index;               /* Type of the state to initialize */
   USINT              NOT_USE_1[2];
} ARNC0AUTID_typ;

typedef struct ARNC0AUTCC_typ {               /* Coupling Configuration */
   UDINT              ma_ax;                  /* NC object of the master axis */
   UDINT              ma_add_ax;              /* NC object of the additive axis of the master axis */
   UDINT              sl_add_ax;              /* NC object of the additive axis of the slave  axis */
} ARNC0AUTCC_typ;

typedef struct ARNC0AUTGL_typ {               /* Global Parameters */
   REAL               ma_add_el;              /* "Additive" element of the master axis */
   REAL               sl_add_el;              /* "Additive" element of the slave axis */
} ARNC0AUTGL_typ;

typedef struct ARNC0AUTEB_typ {               /* Events for basis state */
   USINT              type;                   /* Type */
   USINT              NOT_USE_1[3];
   ARNC0TRG_typ       trg_source;             /* Trigger Source */
   USINT              attribute;              /* Attribute */
   USINT              st_type;                /* Type of the next state */
   USINT              st_index;               /* Index  of the next state */
   USINT              NOT_USE_2;
} ARNC0AUTEB_typ;

typedef struct ARNC0AUTBA_typ {               /* Basis State */
   DINT               ma_s_start;             /* Start position of the master axis */
   UDINT              ma_ivstart;             /* Start interval of the master axis */
   ARNC0AUTEB_typ     event[6];               /* Event */
} ARNC0AUTBA_typ;

typedef struct ARNC0AUTCG_typ {               /* Compensation Gears */
   REAL               ma_v_max;               /* Maximum speed of the master axis */
   DINT               ma_s_rel;               /* Relative distance of the master axis */
   DINT               sl_s_rel;               /* Relative distance of the slave axis */
   DINT               ma_s_min;               /* Minimum distance of the master axis */
   USINT              mode;                   /* Mode */
   USINT              reserve[3];             /* Reserved */
} ARNC0AUTCG_typ;

typedef struct ARNC0AUTCP_typ {               /* Cam Profile */
   USINT              name[12];               /* Name of the NC data module */
   REAL               ma_factor;              /* Multiplication factor for the master axis */
   REAL               sl_factor;              /* Multiplication factor for the slave  axis */
} ARNC0AUTCP_typ;

typedef struct ARNC0AUTER_typ {               /* Events for automat states */
   USINT              type;                   /* Type */
   USINT              NOT_USE_1[3];
   ARNC0TRG_typ       trg_source;             /* Trigger Source */
   USINT              attribute;              /* Attribute */
   USINT              st_type;                /* Type of the next state */
   USINT              st_index;               /* Index  of the next state */
   USINT              NOT_USE_2;
} ARNC0AUTER_typ;

typedef struct ARNC0AUTSC_typ {               /* States */
   UINT               count;                  /* Count */
   USINT              NOT_USE_1[2];
   ARNC0AUTCG_typ     co_gears;               /* Compensation gear */
   ARNC0AUTCP_typ     cam_prof;               /* Cam profile */
   ARNC0AUTER_typ     event[6];               /* Event */
} ARNC0AUTSC_typ;

typedef struct ARNC0AUTOM_typ {               /* Cam Profile Automat */
   ARNC0AUTST_typ     status;                 /* Status */
   USINT              signal1;                /* Signal 1 from the PLC to the cam profile automat */
   USINT              signal2;                /* Signal 2 from the PLC to the cam profile automat */
   USINT              signal3;                /* Signal 3 from the PLC to the cam profile automat */
   USINT              signal4;                /* Signal 4 from the PLC to the cam profile automat */
   ARNC0AUTID_typ     init_stat;              /* INIT State (for INIT of a certain state) */
   ARNC0AUTCC_typ     coupling;               /* Coupling configuration */
   ARNC0AUTGL_typ     global;                 /* Global Parameters */
   ARNC0AUTBA_typ     basis;                  /* Basis state */
   ARNC0AUTSC_typ     state[6];               /* State */
} ARNC0AUTOM_typ;

typedef struct ARNC0AXCMPST_typ {             /* Status */
   USINT              init;                   /* Initialized */
   USINT              mode;                   /* Mode */
   UINT               reserve0;               /* Reserved */
} ARNC0AXCMPST_typ;

typedef struct ARNC0AXCMPSSE_typ {            /* Slope error compensation */
   USINT              data_modul1[12];        /* Name of data module 1 */
   USINT              data_modul2[12];        /* Name of data module 2 */
   REAL               set_factor;             /* Multiplication factor for set values */
   REAL               corr_factor;            /* Multiplication factor for corrected values */
   REAL               start_offset;           /* Start offset */
} ARNC0AXCMPSSE_typ;

typedef struct ARNC0AXCMPBL_typ {             /* Backlash compensation */
   REAL               s_init;                 /* Initial relative movement to mesh */
   REAL               s;                      /* Backlash */
   REAL               v;                      /* Velocity */
   REAL               a;                      /* Acceleration */
} ARNC0AXCMPBL_typ;

typedef struct ARNC0AXCMPPA_typ {             /* Compensation parameter */
   USINT              mode;                   /* Mode */
   USINT              reserve0[3];            /* Reserved */
   ARNC0AXCMPSSE_typ  slope;                  /* Slope error compensation */
   ARNC0AXCMPBL_typ   backlash;               /* Backlash compensation */
} ARNC0AXCMPPA_typ;

typedef struct ARNC0AXCMP_typ {               /* Axis Compensation */
   ARNC0AXCMPST_typ   status;                 /* Status */
   ARNC0AXCMPPA_typ   parameter;              /* Parameters */
} ARNC0AXCMP_typ;

typedef struct ARNC0AXMOV2_typ {              /* Extended Axis movement */
   ARNC0CAMPR_typ     cam_prof;               /* Cam profile */
   ARNC0AUTOM_typ     automat;                /* Cam profile automat */
   ARNC0AXCMP_typ     compensation;           /* Compensation of axis errors */
} ARNC0AXMOV2_typ;

typedef struct ARNC0AXMOS_typ {               /* Status Bits */
   USINT              ds_warning;             /* Lag error greater than "limit.ds_warning" */
   USINT              reserve[3];             /* Reserved */
} ARNC0AXMOS_typ;

typedef struct ARNC0AXMON_typ {               /* Axis monitor */
   DINT               s_act;                  /* Actual position */
   DINT               s_set;                  /* Set position */
   REAL               s_set_comp;             /* Compensated set position */
   REAL               v_set;                  /* Set speed */
   REAL               v_set_comp;             /* Compensated set speed */
   ARNC0AXMOS_typ     status;                 /* Status bits */
   UDINT              reserve0[3];            /* Reserved */
} ARNC0AXMON_typ;

typedef struct ARNC0MSSTA_typ {               /* Status */
   USINT              err_cl0;                /* Error class 0 */
   USINT              NOT_USE_1[3];
} ARNC0MSSTA_typ;

typedef struct ARNC0MSCNT_typ {               /* Number of not acknowledged messages */
   UINT               error;                  /* Count of not acknowledged errors */
   USINT              NOT_USE_1[6];
} ARNC0MSCNT_typ;

typedef struct ARNC0MSREC_typ {               /* Current message record */
   UDINT              number;                 /* Number */
   USINT              info[12];               /* Additional Info */
   USINT              NOT_USE_1[2];
   UINT               errorclass;             /* Error class */
   UDINT              reserve;                /* Reserved */
} ARNC0MSREC_typ;

typedef struct ARNC0MTXST_typ {               /* Status of text determination */
   UINT               lines;                  /* Lines of the determined text */
   UINT               error;                  /* Error */
} ARNC0MTXST_typ;

typedef struct ARNC0MTXPA_typ {               /* Parameters for text determination */
   UINT               format;                 /* Format */
   UINT               columns;                /* Number of columns per line */
   USINT              data_modul[12];         /* Name of the data module */
   UINT               data_len;               /* Length of data buffer in application program */
   UINT               reserve;                /* Reserved */
   UDINT              data_adr;               /* Address of data buffer in application program */
} ARNC0MTXPA_typ;

typedef struct ARNC0MSTXT_typ {               /* Text determination for current message record */
   ARNC0MTXST_typ     status;                 /* Status */
   ARNC0MTXPA_typ     parameter;              /* Parameters */
} ARNC0MSTXT_typ;

typedef struct ARNC0MSG_typ {                 /* Messages */
   ARNC0MSSTA_typ     status;                 /* Status */
   ARNC0MSCNT_typ     count;                  /* Count of not acknowledged messages */
   ARNC0MSREC_typ     record;                 /* Current message record */
   ARNC0MSTXT_typ     text;                   /* Text determination for current message record */
} ARNC0MSG_typ;

typedef struct ARNC0NCTST_typ {               /* NC Test */
   USINT              Open_UseApplNcObj;      /* Open test: Use the same NC object as the application */
   USINT              Close_NoMoveAbort;      /* Close test: No move abortion */
   USINT              reserve1;               /* Reserved */
   USINT              reserve2;               /* Reserved */
} ARNC0NCTST_typ;

typedef struct ARNC0AXIS_typ {                /* ARNC0 - Axis */
   USINT              NOT_USE_1[6];
   UINT               size;                   /* Size of the corresponding NC manager data type */
   ARNC0SWVER_typ     sw_version;             /* Software Version ID */
   ARNC0OBINF_typ     nc_obj_inf;             /* NC Object Information */
   ARNC0AXSIM_typ     simulation;             /* Simulation Mode */
   ARNC0GLINI_typ     global;                 /* Global Parameters */
   ARNC0NETAX_typ     network;                /* Network */
   ARNC0AXDBL_typ     datblock;               /* Data block operation */
   ARNC0DIGIN_typ     dig_in;                 /* Digital Inputs */
   ARNC0ENCIF_typ     encoder_if;             /* Encoder Interface */
   ARNC0AXLIM_typ     limit;                  /* Limit value */
   ARNC0CTRL_typ      controller;             /* Controller */
   ARNC0AXMOV_typ     move;                   /* Axis movement */
   ARNC0SETUP_typ     setup;                  /* Setup */
   USINT              NOT_USE_2[120];
   ARNC0PLCOPENAX_typ PLCopen_MC;             /* PLCopen for Motion Components */
   ARNC0POS_L_typ     pos_latch;              /* Positioning latch */
   ARNC0AXMOV2_typ    move2;                  /* Extended axis movement */
   ARNC0AXMON_typ     monitor;                /* Monitor */
   ARNC0MSG_typ       message;                /* Messages (errors, warnings) */
   ARNC0NCTST_typ     nc_test;                /* NC Test */
   USINT              NOT_USE_3[48];
} ARNC0AXIS_typ;

typedef struct ARNC0CNCSIM_typ {              /* Simulation mode */
   USINT              status;                 /* Status */
   USINT              reserve[3];             /* Reserved */
} ARNC0CNCSIM_typ;

typedef struct ARNC0ACCADEX_typ {             /* Reference Address */
   UDINT              access_adr;             /* Address for "access" */
} ARNC0ACCADEX_typ;

typedef struct ARNC0NCLIM_typ {               /* CNC limits */
   USINT              init;                   /* Initialization complete */
   USINT              reserve[3];             /* Reserved */
   REAL               v;                      /* Velocity */
   REAL               a_pos;                  /* Positive acceleration */
   REAL               a_neg;                  /* Negative acceleration */
   REAL               t_jolt;                 /* Jolt time */
   USINT              blocktransition;        /* Mode for block transitions */
   USINT              reserve0[3];            /* Reserved */
   REAL               v_jump;                 /* Speed jump */
   REAL               a_jump;                 /* Acceleration jump */
   REAL               v_jump_t;               /* Speed jump for tangential axis */
   REAL               s_jump_t;               /* Tangential deviation for subsequent path elements */
   UINT               s_sync1_t;              /* Synchrone M-Function at end of path element */
   UINT               s_sync2_t;              /* Synchrone M-Function at beginn of path element */
   REAL               radius_err;             /* Error of radius */
   UDINT              block_buffer;           /* Block buffer for backtracing the CNC path */
   UINT               elements;               /* Calculated elements before starting */
   UINT               lookahead;              /* Size of lookahead buffer */
   USINT              halt;                   /* Stop at passing beyond the submission values */
   USINT              reserve1[3];            /* Reserved */
   REAL               filter_err;             /* Maximum contour error caused by "axis[i],t_axfilter" */
   REAL               filter_err_trans;       /* Maximum contour error at block transition caused by "axis[i],t_axfilter" */
   ARNC0ACCADEX_typ   plot;                   /* Plot buffer */
   ARNC0ACCADEX_typ   dynamic;                /* Dynamic buffer */
} ARNC0NCLIM_typ;

typedef struct ARNC0SKPLM_typ {               /* Interpreter skip level */
   USINT              level_0;                /* Skip level 0 */
   USINT              level_1;                /* Skip level 1 */
   USINT              level_2;                /* Skip level 2 */
   USINT              level_3;                /* Skip level 3 */
   USINT              level_4;                /* Skip level 4 */
   USINT              level_5;                /* Skip level 5 */
   USINT              level_6;                /* Skip level 6 */
   USINT              level_7;                /* Skip level 7 */
   USINT              level_8;                /* Skip level 8 */
   USINT              level_9;                /* Skip level 9 */
   USINT              reserve0[2];            /* Reserved */
} ARNC0SKPLM_typ;

typedef struct ARNC0NCMST_typ {               /* Status CNC movement */
   UINT               cnt_ncprog;             /* Number of started CNC programs/blocks */
   USINT              halt;                   /* State "halt" */
   USINT              halt_info;              /* INFO aboute cause of "Halt" state */
   USINT              m1_stop;                /* Operating mode "Stop at M1" */
   USINT              single_s;               /* Operating mode "Single step" */
   USINT              skip_fcn;               /* Operating mode "Skip Function" */
   USINT              dpr_ovr;                /* "normal" override \  DPR-override */
   ARNC0SKPLM_typ     skip_level;             /* Skip level */
} ARNC0NCMST_typ;

typedef struct ARNC0NCSTO_typ {               /* Stop Movement */
   USINT              decel_ramp;             /* Deceleration ramp */
   USINT              reserve0;               /* Reserved */
   UINT               reserve1;               /* Reserved */
} ARNC0NCSTO_typ;

typedef struct ARNC0NCESTO_typ {              /* Emergency Stop */
   USINT              path;                   /* Path behaviour */
   USINT              reserve0;               /* Reserved */
   UINT               reserve1;               /* Reserved */
} ARNC0NCESTO_typ;

typedef struct ARNC0NCPRG_typ {               /* CNC program */
   USINT              name[100];              /* Name of the NC data module */
   USINT              init_prg[100];          /* Name of initial CNC program */
   USINT              start_pos_type;         /* Type of start position */
   USINT              start_mode;             /* Start mode for CNC program */
   USINT              NOT_USE_1;
   USINT              delete_mode;            /* Mode for deleting a CNC program */
   DINT               start_pos;              /* Starting position */
   USINT              restart_type;           /* Type of restart point */
   USINT              reserve1[3];            /* Reserved */
   UDINT              block_ncprog;           /* Block number in CNC program */
   UDINT              offset_ncprog;          /* Offset (Byte) in current CNC program */
   REAL               s_ncprog;               /* Path position in current CNC program */
   REAL               s_start[15];            /* Starting position */
} ARNC0NCPRG_typ;

typedef struct ARNC0ACCAD_typ {               /* Address for evaluation with "access" */
   UDINT              access_adr;             /* Address for "access" */
} ARNC0ACCAD_typ;

typedef struct ARNC0SSTEP_typ {               /* Single step */
   USINT              mode;                   /* Mode */
   USINT              reserve0[3];            /* Reserved */
   UDINT              bit_pattern;            /* Bit pattern */
} ARNC0SSTEP_typ;

typedef struct ARNC0SKPL_typ {                /* Interpreter skip level */
   USINT              level_0;                /* Skip level 0 */
   USINT              level_1;                /* Skip level 1 */
   USINT              level_2;                /* Skip level 2 */
   USINT              level_3;                /* Skip level 3 */
   USINT              level_4;                /* Skip level 4 */
   USINT              level_5;                /* Skip level 5 */
   USINT              level_6;                /* Skip level 6 */
   USINT              level_7;                /* Skip level 7 */
   USINT              level_8;                /* Skip level 8 */
   USINT              level_9;                /* Skip level 9 */
   USINT              reserve0[2];            /* Reserved */
} ARNC0SKPL_typ;

typedef struct ARNC0NCMOV_typ {               /* CNC movement */
   ARNC0NCMST_typ     status;                 /* Status */
   ARNC0NCSTO_typ     stop;                   /* Stop Movement */
   ARNC0NCESTO_typ    e_stop;                 /* Emergency stop */
   INT                override;               /* Override */
   UINT               R_override;             /* Rapid override affects CNC path */
   UDINT              F_override;             /* Feedrate override affects CNC path */
   ARNC0NCPRG_typ     ncprogram;              /* NC program */
   USINT              ncblock[52];            /* NC block */
   ARNC0ACCAD_typ     dpr_ovr;                /* "normal" override \  DPR-override */
   ARNC0ACCAD_typ     dpr_if;                 /* DPR-interface */
   ARNC0SSTEP_typ     single_s;               /* Operating mode "Single step" */
   ARNC0SKPL_typ      skip_level;             /* Skip level */
} ARNC0NCMOV_typ;

typedef struct ARNC0NCDST_typ {               /* CNC decoder status */
   USINT              halt;                   /* State "halt" */
   USINT              sync;                   /* State "Waiting for SYNC" */
   USINT              breakpt_halt;           /* State "Halt at breakpoint" */
   USINT              single_s_halt;          /* State "Halt in single step mode" */
   UINT               single_s;               /* Operating mode "Single step" */
   UINT               reserve;                /* Reserved */
   UINT               program_load;           /* Status of 'program load' */
   UINT               program_unload;         /* Status of 'program unload' */
   USINT              mp_log;                 /* Motion packet log */
   USINT              reserve1[3];            /* Reserved */
} ARNC0NCDST_typ;

typedef struct ARNC0DCHLTINFO_typ {           /* Interpreter halt info (e.g. breakpoint, single step) */
   USINT              file_name[100];         /* File name */
   USINT              program_name[100];      /* Program name */
   USINT              subprog_name[100];      /* Sub program name */
   UDINT              line_nr;                /* Line number */
   UDINT              block_nr;               /* Block number */
} ARNC0DCHLTINFO_typ;

typedef struct ARNC0DCCDC_typ {               /* Cutting Diameter Correction */
   USINT              side;                   /* Processing side Cutting Diameter Compensation */
   USINT              entry;                  /* Select/deselect Cutting Diameter Compensation */
   USINT              circ_transition;        /* Insert Circular Transitions */
   USINT              circ_replace;           /* Replace arc with straight line */
   USINT              contour_violation;      /* Accept contour violations */
   USINT              intersection_path;      /* Additional intersection path calculation */
   USINT              NOT_USE_1[2];
   UDINT              feedrate;               /* Feedrate on Transition Circles */
   USINT              v_path_contour;         /* Feedrate affects CNC path */
   USINT              exit;                   /* Deselection Mode Cutting Diameter Compensation */
   USINT              NOT_USE_2[2];
} ARNC0DCCDC_typ;

typedef struct ARNC0DCPAR_typ {               /* CNC decoder parameter */
   USINT              move_cmd;               /* Movement command */
   USINT              plane;                  /* Plane */
   USINT              co_ords;                /* Co-ordinate definition */
   USINT              center;                 /* Center point definition */
   UDINT              v_path;                 /* Path speed */
   ARNC0DCCDC_typ     cdc;                    /* Tool radius correction */
   USINT              t_ax_period;            /* Operating mode for  tangential axis */
   USINT              system_unit;            /* Measurement unit for CNC system */
   USINT              v_path_mode;            /* Mode for feed rate calculation */
   USINT              reserve1;               /* Reserved */
   USINT              rot_pref_dir;           /* Preferable direction of rotary axes */
   USINT              limit_switch_mode;      /* Mode for axis limit switch */
   USINT              reserve0[2];            /* Reserved */
} ARNC0DCPAR_typ;

typedef struct ARNC0DCDMO_typ {               /* CNC decoder datamodule */
   ARNC0ACTST_typ     status;                 /* Status */
   USINT              zero_tab[12];           /* Data module name of zero point offset table */
   USINT              tool_tab[12];           /* Data module name of tool data table */
   USINT              rpar_tab[12];           /* Data module name of R parameter  table */
} ARNC0DCDMO_typ;

typedef struct ARNC0R_PAR_typ {               /* CNC decorder R-parameters */
   ARNC0ACTST_typ     status;                 /* Status */
   UINT               index;                  /* Index */
   USINT              NOT_USE_1[2];
   REAL               value;                  /* R-Parameter-Value */
} ARNC0R_PAR_typ;

typedef struct ARNC0DCSST_typ {               /* Step mode debugger */
   UINT               mode;                   /* Mode */
   UINT               number;                 /* Number of blocks to halt after */
} ARNC0DCSST_typ;

typedef struct ARNC0DCBRKPT_typ {             /* Set Breakpoint */
   USINT              file_name[100];         /* File name */
   USINT              program_name[100];      /* Program name */
   UDINT              block_nr;               /* Block number */
   UDINT              line_nr;                /* Line number */
} ARNC0DCBRKPT_typ;

typedef struct ARNC0DCBRKINFO_typ {           /* Breakpoint info */
   UDINT              total_nr;               /* Total number of currently set breakpoints */
   ARNC0DCBRKPT_typ   breakpoint_set[5];      /* Info to currently set breakpoints */
} ARNC0DCBRKINFO_typ;

typedef struct ARNC0DCBRKPAR_typ {            /* Breakpoint Parameter */
   USINT              file_name[100];         /* File name */
   UDINT              pos_type;               /* Type of break point */
   UDINT              position;               /* Block or line number */
   UDINT              break_count;            /* Halt on n’th hit */
} ARNC0DCBRKPAR_typ;

typedef struct ARNC0DCBRK_typ {               /* Breakpoint */
   ARNC0ACTST_typ     status;                 /* Status */
   ARNC0DCBRKINFO_typ info;                   /* INFO-function */
   ARNC0DCBRKPAR_typ  parameter;              /* Parameters */
} ARNC0DCBRK_typ;

typedef struct ARNC0DCEXPR_typ {              /* Expression */
   ARNC0ACTST_typ     status;                 /* Status */
   USINT              query[64];              /* Variable/expression to evaluate */
   USINT              result[64];             /* Result */
} ARNC0DCEXPR_typ;

typedef struct ARNC0DCVACCINFO_typ {          /* Info for access to variables */
   UDINT              address;                /* Access address to interpreter variable */
   UDINT              length;                 /* Variable size (total number of byte) */
   UDINT              array_dim1;             /* First array dimension */
   UDINT              array_dim2;             /* Second array dimension */
   UINT               data_type;              /* Data type (see AS library “sys_lib”) */
   UINT               scope;                  /* Variable scope */
   UINT               synch_type;             /* Synchronization type */
   UINT               reserve0;               /* Reserved */
} ARNC0DCVACCINFO_typ;

typedef struct ARNC0RVARACC_typ {             /* Access to variables */
   ARNC0ACTST_typ      status;                /* Status */
   USINT               name[32];              /* Name of variable */
   ARNC0DCVACCINFO_typ info;                  /* INFO-function */
} ARNC0RVARACC_typ;

typedef struct ARNC0NCDEC_typ {               /* CNC decoder */
   USINT              init;                   /* Initialization complete */
   USINT              reserve[3];             /* Reserved */
   ARNC0NCDST_typ     status;                 /* Status */
   ARNC0DCHLTINFO_typ halt_info;              /* INFO aboute cause of "Halt" state */
   ARNC0DCPAR_typ     parameter;              /* Parameters */
   ARNC0DCDMO_typ     data_modul;             /* Data Modules */
   ARNC0R_PAR_typ     r_param;                /* R-parameter */
   ARNC0DCSST_typ     s_step;                 /* Interpreter single step mode */
   ARNC0DCBRK_typ     breakpoint;             /* Breakpoints in CNC program */
   ARNC0DCEXPR_typ    expression;             /* Variable/Expression watch and force function */
   ARNC0RVARACC_typ   var_access;             /* Direct access to Interpreter Variables */
} ARNC0NCDEC_typ;

typedef struct ARNC0NCAXST_typ {              /* Status */
   UINT               add_par_id;             /* Parameter ID of the additive element for the cyclic set position */
   USINT              reserve[2];             /* Reserved */
} ARNC0NCAXST_typ;

typedef struct ARNC0TRC_typ {                 /* Trigger Configuration */
   USINT              trigger1_pos;           /* Trigger1: Positive edge */
   USINT              trigger1_neg;           /* Trigger1: Negative edge */
   USINT              trigger2_pos;           /* Trigger2: Positive edge */
   USINT              trigger2_neg;           /* Trigger2: Negative edge */
} ARNC0TRC_typ;

typedef struct ARNC0NCTRG_typ {               /* Source for Hardware Trigger */
   UDINT              nc_object;              /* NC object or ncOFF */
   UDINT              nc_object_plcopen;      /* NC object or ncOFF */
   USINT              NOT_USE_1[4];
   ARNC0TRC_typ       trg_conf;               /* Trigger Configuration */
} ARNC0NCTRG_typ;

typedef struct ARNC0NCAXSSE_typ {             /* Axes error compensation */
   USINT              active;                 /* Active */
   USINT              reserve[3];             /* Reserved */
   ARNC0ACCADEX_typ   cmp_data;               /* Compensation data */
} ARNC0NCAXSSE_typ;

typedef struct ARNC0NCAXP_typ {               /* CNC-axis settings */
   USINT              NOT_USE_1[72];
   ARNC0NCAXST_typ    status;                 /* Status */
   UDINT              nc_object;              /* NC object or ncOFF */
   UDINT              nc_object_plcopen;      /* NC object or ncOFF */
   USINT              name[14];               /* Name of the axis in the CNC program */
   USINT              reserve3[2];            /* Reserved */
   UDINT              type;                   /* Type */
   USINT              ipl_mode;               /* Interpolation mode */
   USINT              reserve4[3];            /* Reserved */
   REAL               unitfactor;             /* Multiplication factor of the units */
   REAL               t_axfilter;             /* Filter time for axis jolt filter */
   USINT              drive_axfilter;         /* Axis jolt filter on the drive during CNC movement */
   USINT              reserve2[3];            /* Reserved */
   REAL               rot_period;             /* Period of rotary axis */
   REAL               rot_offset;             /* Start of period for rotary axis */
   UINT               add_par_id;             /* Parameter ID of the additive element for the cyclic set position */
   USINT              reserve5[2];            /* Reserved */
   ARNC0NCTRG_typ     trg_source;             /* Trigger Source */
   ARNC0NCAXSSE_typ   ax_compensation;        /* Axis error compensatioin */
} ARNC0NCAXP_typ;

typedef struct ARNC0NCEXAXP_typ {             /* External CNC axis parameters */
   UDINT              nc_object[15];          /* NC object or ncOFF */
} ARNC0NCEXAXP_typ;

typedef struct ARNC0NCAXCMP_typ {             /* Compensation parameter for Cartesian axes */
   REAL               matrix_el[9];           /* Element of compensation matrix */
} ARNC0NCAXCMP_typ;

typedef struct ARNC0NCAXTRF_typ {             /* Kinematic transformation parameters */
   USINT              name[100];              /* Name of the NC data module */
   USINT              trf_full;               /* Full kinematic transformation */
   USINT              trf_type;               /* Type of kinematic transformation */
   USINT              reserve0[2];            /* Reserved */
   USINT              axes_tcp[12];           /* Index of path axes */
   USINT              axes_joint[12];         /* Index of joint axes */
   USINT              axes_frame[6];          /* Index of frame axis [dx, dy, dz, phi, theta, psi] */
   USINT              reserve1[2];            /* Reserved */
   REAL               tcp_add_el[12];         /* Additive element of path axes */
   REAL               joint_add_el[12];       /* Additive element of joint axes */
   REAL               frame_add_el[6];        /* Additive element of frame axes */
   REAL               d_full_add_el[6];       /* Additive element of general tools (D_FULL) */
   REAL               in_pos_tolerance;       /* Position tolerance for path axes at beginning of a movement */
} ARNC0NCAXTRF_typ;

typedef struct ARNC0AXP_ARR_typ {             /* Datatype for the AXP-array */
   USINT              init;                   /* Initialization complete */
   USINT              reserve[3];             /* Reserved */
   ARNC0NCAXP_typ     axis[15];               /* NC axis */
   ARNC0NCEXAXP_typ   ext_ax_parameter;       /* External CNC axis parameters */
   ARNC0NCAXCMP_typ   compensation;           /* Compensation parameter for Cartesian axes */
   ARNC0NCAXTRF_typ   transformation;         /* Kinematic Transformation */
} ARNC0AXP_ARR_typ;

typedef struct ARNC0PLCPA_typ {               /* CNC-PLC parameters */
   USINT              t_fcn_init;             /* Initialize T function with CNC-Reset */
   USINT              s_fcn_init;             /* Initialize S function with CNC-Reset */
   UINT               first_M;                /* Index of first M function without synchronization */
   UINT               last_M;                 /* Index of last M function without synchronization */
   UINT               first_M_S;              /* Index of first M function with synchronization */
   UINT               last_M_S;               /* Index of last M function with synchronization */
   USINT              NOT_USE_1[2];
} ARNC0PLCPA_typ;

typedef struct ARNC0PLCDA_typ {               /* CNC-PLC data */
   UINT               t_funct;                /* T function value */
   USINT              NOT_USE_1[2];
   UDINT              s_funct[4];             /* S function values */
   USINT              m_funct[1024];          /* Display for "Execute M Function" */
} ARNC0PLCDA_typ;

typedef struct ARNC0EXP_typ {                 /* External CNC-PLC parameters */
   USINT              status;                 /* Status */
   USINT              reserve[3];             /* Reserved */
   UDINT              access_adr;             /* Address for "access" */
} ARNC0EXP_typ;

typedef struct ARNC0NCPLC_typ {               /* CNC-PLC data */
   USINT              init;                   /* Initialization complete */
   USINT              reserve[3];             /* Reserved */
   ARNC0PLCPA_typ     parameter;              /* Parameters */
   ARNC0PLCDA_typ     data;                   /* Data */
   ARNC0EXP_typ       ex_param;               /* External parameter */
   ARNC0ACCAD_typ     m_param;                /* M parameters */
} ARNC0NCPLC_typ;

typedef struct ARNC0ENST_typ {                /* Status */
   USINT              enabled;                /* Enabled */
   USINT              active;                 /* Active */
   USINT              data_valid;             /* Valid restart data available */
   USINT              data_saved;             /* Restart data saved (since last program start) */
} ARNC0ENST_typ;

typedef struct ARNC0NCRSR_typ {               /* Result */
   USINT              name[100];              /* Name of the NC data module */
   USINT              init_prg[100];          /* Name of initial CNC program */
   USINT              start_pos_type;         /* Type of start position */
   USINT              start_mode;             /* Start mode for CNC program */
   UINT               reserve;                /* Reserved */
   DINT               start_pos;              /* Starting position */
   USINT              restart_type;           /* Type of restart point */
   USINT              reserve1[3];            /* Reserved */
   UDINT              block_ncprog;           /* Block number in CNC program */
   UDINT              offset_ncprog;          /* Offset (Byte) in current CNC program */
   UDINT              line_ncprog;            /* Line number in CNC program */
   REAL               s_ncprog;               /* Path position in current CNC program */
   REAL               s_set[15];              /* Set position */
} ARNC0NCRSR_typ;

typedef struct ARNC0NCRSP_typ {               /* Parameter */
   USINT              restart_type;           /* Type of restart point */
   USINT              NOT_USE_1[3];
   UDINT              block_ncprog;           /* Block number in CNC program */
   UDINT              offset_ncprog;          /* Offset (Byte) in current CNC program */
   REAL               s_ncprog;               /* Path position in current CNC program */
} ARNC0NCRSP_typ;

typedef struct ARNC0NCRSI_typ {               /* INFO-function */
   ARNC0ACTST_typ     status;                 /* Status */
   ARNC0NCRSR_typ     result;                 /* Result */
   ARNC0NCRSP_typ     parameter;              /* Parameters */
} ARNC0NCRSI_typ;

typedef struct ARNC0NCRPA_typ {               /* General restart parameters */
   UDINT              param_buffer;           /* Buffer size for R- and EX- parameters */
   UDINT              trigger_buffer;         /* Buffer size for trigger blocks */
} ARNC0NCRPA_typ;

typedef struct ARNC0NCRST_typ {               /* Restart of a NC-program */
   ARNC0ENST_typ      status;                 /* Status */
   ARNC0NCRSI_typ     info;                   /* INFO-function */
   ARNC0NCRPA_typ     parameter;              /* Parameters */
} ARNC0NCRST_typ;

typedef struct ARNC0RDMOD_typ {               /* Datamodule handling */
   ARNC0ACTST_typ     status;                 /* Status */
   USINT              name[12];               /* Name of the NC data module */
} ARNC0RDMOD_typ;

typedef struct ARNC0NCMNPAR_typ {             /* CNC monitor parameter */
   USINT              pos_mode;               /* CNC Position monitor */
   USINT              block_mode;             /* Blocks display mode */
   USINT              line_nr_mode;           /* Display line numbers */
   USINT              max_call_level;         /* Max. call level for extended block numbers */
   UDINT              access_adr;             /* Address for "access" */
} ARNC0NCMNPAR_typ;

typedef struct ARNC0NCMNS_typ {               /* CNC monitor status */
   USINT              zeropoff;               /* Mode "Subtract zero point offset from positions" */
   USINT              pos_mode;               /* CNC Position monitor */
   USINT              NOT_USE_1;
   USINT              block_mode;             /* Blocks display mode */
   USINT              line_nr_mode;           /* Display line numbers */
   USINT              s_set_valid;            /* Set positions valid in the CNC monitor */
   USINT              NOT_USE_2[2];
} ARNC0NCMNS_typ;

typedef struct ARNC0NCMON_typ {               /* CNC monitor */
   ARNC0NCMNPAR_typ   parameter;              /* Parameters */
   ARNC0NCMNS_typ     status;                 /* Status */
   REAL               s_set[15];              /* Set position */
   REAL               s_ncblock[15];          /* Axis distance until end of current NC block */
   REAL               v_path;                 /* Path speed */
   UDINT              nr_ncprog;              /* Number of current CNC program */
   USINT              name_ncprog[100];       /* Name of current CNC program */
   UDINT              pos_ncprog;             /* Position in current CNC program */
   UDINT              block_ncprog;           /* Block number in CNC program */
   UDINT              line_ncprog;            /* Line number in CNC program */
   USINT              call_level;             /* Current call level for sub-programs */
   USINT              reserve1[3];            /* Reserved */
   REAL               t_ncprog;               /* Run-Time of current CNC program */
   REAL               s_ncprog;               /* Path position in current CNC program */
   REAL               v_ncprog;               /* Path speed currently defined in CNC program */
   REAL               d_full[6];              /* Active D_FULL data */
   UINT               tool_nr;                /* Number of active tool data record */
   UINT               zero_idx;               /* Index of active absolute zero point offset */
   UINT               type_ncblock;           /* Type of current NC block */
   UINT               PSM_phase;              /* Path speed mode, phase */
   REAL               t_dwell;                /* Remaining time for G04 (dwell) */
   ARNC0ACCAD_typ     ncblocks;               /* Display of CNC blocks */
   ARNC0ACCAD_typ     c_transform;            /* Transformation matrices for coordinate systems */
   ARNC0ACCAD_typ     ip_monitor;             /* Interpreter monitor */
   ARNC0ACCAD_typ     ext_monitor;            /* Extended CNC Monitor */
} ARNC0NCMON_typ;

typedef struct ARNC0ERRCL0_typ {              /* Error class 0 */
   UDINT              number[20];             /* Number */
} ARNC0ERRCL0_typ;

typedef struct ARNC0CNC_typ {                 /* ARNC0 - CNC-System */
   USINT              NOT_USE_1[4];
   UINT               size;                   /* Size of the corresponding NC manager data type */
   UINT               reserve0;               /* Reserved */
   ARNC0SWVER_typ     sw_version;             /* Software Version ID */
   ARNC0OBINF_typ     nc_obj_inf;             /* NC Object Information */
   ARNC0CNCSIM_typ    simulation;             /* Simulation Mode */
   ARNC0GLINI_typ     global;                 /* Global Parameters */
   ARNC0NCLIM_typ     limit;                  /* Limit value */
   ARNC0NCMOV_typ     move;                   /* Movement */
   ARNC0NCDEC_typ     decoder;                /* Decoder */
   ARNC0AXP_ARR_typ   axis;                   /* NC axis */
   ARNC0NCPLC_typ     cnc_plc;                /* CNC-PLC-Data */
   ARNC0NCRST_typ     restart;                /* RESTART of a CNC program */
   ARNC0RDMOD_typ     data_modul;             /* Data Modules */
   ARNC0NCMON_typ     monitor;                /* Monitor */
   ARNC0MSG_typ       message;                /* Messages (errors, warnings) */
   ARNC0ERRCL0_typ    err_cl0;                /* Error class 0 */
   USINT              NOT_USE_2[8];
   ARNC0NCTST_typ     nc_test;                /* NC Test */
   USINT              NOT_USE_3[48];
} ARNC0CNC_typ;

typedef struct ARNC0EXPAR_typ {               /* External CNC parameters */
   SINT               EXB[100];               /* EX(ternal) B(yte)-Parameters */
   INT                EXW[100];               /* EX(terne) W(ord)-Parameters */
   DINT               EXL[100];               /* EX(terne) L(ong)-Parameters */
   REAL               EXF[100];               /* EX(terne) F(loat)-Parameters */
} ARNC0EXPAR_typ;

typedef struct ARNC0EXESL_typ {               /* Scaling for the load */
   UDINT              units;                  /* Units at the load */
   UDINT              rev_encod;              /* Encoder revolutions */
} ARNC0EXESL_typ;

typedef struct ARNC0EXESC_typ {               /* Scaling for encoder interface */
   ARNC0EXESL_typ     load;                   /* Load */
} ARNC0EXESC_typ;

typedef struct ARNC0EXEPA_typ {               /* Parameters for encoder interface */
   USINT              count_dir;              /* Count direction */
   USINT              NOT_USE_1[3];
   ARNC0EXESC_typ     scaling;                /* Scaling */
} ARNC0EXEPA_typ;

typedef struct ARNC0EXEIF_typ {               /* Encoder interface */
   USINT              init;                   /* Encoder interface initialized */
   USINT              NOT_USE_1[3];
   ARNC0EXEPA_typ     parameter;              /* Parameters */
} ARNC0EXEIF_typ;

typedef struct ARNC0EXENW_typ {               /* Network */
   USINT              phase;                  /* Phase */
   USINT              init;                   /* Network initialized */
   USINT              NOT_USE_1[2];
} ARNC0EXENW_typ;

typedef struct ARNC0EXEHST_typ {              /* Homing Status */
   USINT              ok;                     /* Reference position valid */
   USINT              NOT_USE_1[3];
} ARNC0EXEHST_typ;

typedef struct ARNC0EXEHPA_typ {              /* Homing Parameter */
   DINT               s;                      /* Reference position */
   USINT              ref_pulse;              /* Reference pulse */
   USINT              NOT_USE_1[3];
} ARNC0EXEHPA_typ;

typedef struct ARNC0EXEHOM_typ {              /* Homing */
   USINT              init;                   /* Homing procedure initialized */
   USINT              NOT_USE_1[3];
   ARNC0EXEHST_typ    status;                 /* Status */
   ARNC0EXEHPA_typ    parameter;              /* Parameters */
} ARNC0EXEHOM_typ;

typedef struct ARNC0EXEMOV_typ {              /* Movement */
   ARNC0EXEHOM_typ    homing;                 /* Homing procedure */
} ARNC0EXEMOV_typ;

typedef struct ARNC0EXEPOS_typ {              /* Filter for actual positions */
   USINT              status;                 /* Status */
   USINT              NOT_USE_1[3];
   REAL               t_filter;               /* Filter time for extrapolation filter */
   REAL               t_filter2;              /* Filter time for disturbance filter */
} ARNC0EXEPOS_typ;

typedef struct ARNC0EXMON_typ {               /* Monitor */
   DINT               s_act;                  /* Actual position */
   REAL               v_act;                  /* Actual speed */
} ARNC0EXMON_typ;

typedef struct ARNC0EXTEN_typ {               /* ARNC0 - External Encoder */
   USINT              NOT_USE_1[4];
   UINT               size;                   /* Size of the corresponding NC manager data type */
   USINT              NOT_USE_2[2];
   ARNC0SWVER_typ     sw_version;             /* Software Version ID */
   ARNC0OBINF_typ     nc_obj_inf;             /* NC Object Information */
   ARNC0EXEIF_typ     encoder_if;             /* Encoder Interface */
   ARNC0EXENW_typ     network;                /* Network */
   ARNC0EXEMOV_typ    move;                   /* Movement */
   ARNC0EXEPOS_typ    act_pos;                /* Filter for actual position */
   ARNC0EXMON_typ     monitor;                /* Monitor */
   ARNC0MSG_typ       message;                /* Messages (errors, warnings) */
   USINT              NOT_USE_3[48];
} ARNC0EXTEN_typ;

typedef struct ARNC0M_PAR_typ {               /* CNC M parameters */
   INT                MW[100];                /* M-W(ord)-Parameters */
   DINT               ML[100];                /* M-L(ong)-Parameters */
   REAL               MF[100];                /* M-F(loat)-Parameters */
} ARNC0M_PAR_typ;

typedef struct ARNC0INIST_typ {               /* Status */
   USINT              init;                   /* Network initialized */
   USINT              reserve[3];             /* Reserved */
} ARNC0INIST_typ;

typedef struct ARNC0NETMO_typ {               /* Network */
   ARNC0INIST_typ     status;                 /* Status */
} ARNC0NETMO_typ;

typedef struct ARNC0DATMO_typ {               /* Datamodule handling */
   ARNC0ACTST_typ     status;                 /* Status */
   USINT              NOT_USE_1;
   USINT              type;                   /* Type */
   USINT              reserve[2];             /* Reserved */
   USINT              name[12];               /* Name of the NC data module */
} ARNC0DATMO_typ;

typedef struct ARNC0TRTRI_typ {               /* Trace trigger-point */
   UDINT              nc_object;              /* NC object or ncOFF */
   USINT              type;                   /* Type of the point */
   USINT              event;                  /* Event */
   USINT              NOT_USE_1[2];
   REAL               threshold;              /* Threshold */
} ARNC0TRTRI_typ;

typedef struct ARNC0TRTST_typ {               /* Trace test-point */
   UDINT              nc_object;              /* NC object or ncOFF */
   USINT              type;                   /* Type of the point */
   USINT              reserve[3];             /* Reserved */
} ARNC0TRTST_typ;

typedef struct ARNC0TRACE_typ {               /* Trace */
   USINT              status;                 /* Status */
   USINT              reserve[3];             /* Reserved */
   REAL               t_trace;                /* Recording time */
   REAL               t_sampling;             /* Sampling time */
   REAL               t_delay;                /* Time of delay */
   ARNC0TRTRI_typ     trigger;                /* Trigger */
   ARNC0TRTST_typ     test_dat[10];           /* Test data */
   UDINT              access_adr;             /* Address for "access" */
} ARNC0TRACE_typ;

typedef struct ARNC0MODUL_typ {               /* For object-type ncMODUL */
   USINT              NOT_USE_1[4];
   UINT               size;                   /* Size of the corresponding NC manager data type */
   UINT               reserve0;               /* Reserved */
   ARNC0SWVER_typ     sw_version;             /* Software Version ID */
   ARNC0OBINF_typ     nc_obj_inf;             /* NC Object Information */
   ARNC0NETMO_typ     network;                /* Network */
   ARNC0DATMO_typ     data_modul;             /* Data Modules */
   USINT              NOT_USE_2[4];
   ARNC0MSG_typ       message;                /* Messages (errors, warnings) */
   ARNC0ACCAD_typ     command;                /* Command interface */
   ARNC0ACCAD_typ     response;               /* Response interface */
   ARNC0ACCAD_typ     usertask;               /* UserTask */
   ARNC0TRACE_typ     trace;                  /* Trace */
   USINT              NOT_USE_3[52];
} ARNC0MODUL_typ;

typedef struct ARNC0NCCTR_typ {               /* Transformations coordniate system */
   UINT               handshake;              /* Handshake */
   USINT              NOT_USE_1[2];
   REAL               G92_matrix[9];          /* G92 matrix */
   REAL               G192_matrix[9];         /* G192 matrix */
   REAL               G292_matrix[9];         /* G292 matrix */
   REAL               comp_matrix[9];         /* Compensation matrix */
   REAL               offset[15];             /* Offset */
} ARNC0NCCTR_typ;

typedef struct ARNC0NCDPR_typ {               /* NC DPR */
   USINT              halt_ncsz;              /* Halt the CNC move at the end of an NC record */
   USINT              halt;                   /* Halt the CNC move */
   USINT              NOT_USE_1[2];
} ARNC0NCDPR_typ;

typedef struct ARNC0NCSMO_typ {               /* NC Monitor */
   UINT               handshake;              /* Handshake */
   USINT              NOT_USE_1[2];
   USINT              ncblock_l2[80];         /* NC block */
   USINT              ncblock_l1[80];         /* NC block */
   USINT              ncblock[80];            /* NC block */
   USINT              ncblock_n1[80];         /* NC block */
   USINT              ncblock_n2[80];         /* NC block */
   REAL               s_ncblock;              /* Remaining path length until end of current NC block */
   REAL               s_ncblock_tot;          /* Path length of current NC block */
   REAL               s_ncblock_n1;           /* Path length of next NC block */
} ARNC0NCSMO_typ;

typedef struct ARNC0PTRTR_typ {               /* Trigger */
   UINT               par_id;                 /* Parameter ID */
   USINT              event;                  /* Event */
   USINT              reserve;                /* Reserved */
   REAL               threshold;              /* Threshold */
   REAL               window;                 /* Latch window */
} ARNC0PTRTR_typ;

typedef struct ARNC0PTRDA_typ {               /* Test data */
   UINT               par_id;                 /* Parameter ID */
   UINT               reserve;                /* Reserved */
} ARNC0PTRDA_typ;

typedef struct ARNC0PTRSV_typ {               /* Operating System Variable */
   USINT              data_type;              /* Data type */
   USINT              reserve1;               /* Reserved */
   UINT               reserve2;               /* Reserved */
   UDINT              address;                /* Address */
} ARNC0PTRSV_typ;

typedef struct ARNC0PTRSY_typ {               /* Configuration of Operating System Variables */
   ARNC0PTRSV_typ     trigger;                /* Trigger */
   ARNC0PTRSV_typ     test_dat[10];           /* Test data */
} ARNC0PTRSY_typ;

typedef struct ARNC0PATRC_typ {               /* Trace */
   USINT              status;                 /* Status */
   USINT              reserve[3];             /* Reserved */
   UDINT              buf_size;               /* Size of trace data buffer on the drive */
   USINT              NOT_USE_1[4];
   REAL               t_trace;                /* Recording time */
   REAL               t_sampling;             /* Sampling time */
   REAL               t_delay;                /* Start delay */
   ARNC0PTRTR_typ     trigger;                /* Trigger */
   ARNC0PTRDA_typ     test_dat[10];           /* Test data */
   ARNC0PTRSY_typ     system_var;             /* Configuration of Operating System Variables */
} ARNC0PATRC_typ;

typedef struct ARNC0PTRIN_typ {               /* Internal for Parameter Trace */
   USINT              errortext;              /* Error text */
   USINT              err_cl0;                /* Error class 0 */
   UINT               reserve;                /* Reserved */
} ARNC0PTRIN_typ;

typedef struct ARNC0PARTRACE_typ {            /* ncPARID_TRACE-structure for ARNC0 */
   USINT              NOT_USE_1[4];
   UINT               size;                   /* Size of the corresponding NC manager data type */
   UINT               reserve0;               /* Reserved */
   ARNC0SWVER_typ     sw_version;             /* Software Version ID */
   ARNC0OBINF_typ     nc_obj_inf;             /* NC Object Information */
   ARNC0NETMO_typ     network;                /* Network */
   ARNC0PATRC_typ     trace;                  /* Trace */
   ARNC0MSG_typ       message;                /* Messages (errors, warnings) */
   ARNC0PTRIN_typ     intern;                 /* Intern */
   USINT              NOT_USE_2[48];
} ARNC0PARTRACE_typ;

typedef struct ARNC0MATRIX_typ {              /* Rotation matrix */
   REAL               matrix_el[9];           /* Element of compensation matrix */
} ARNC0MATRIX_typ;

typedef struct ARNC0PLOTDATA_typ {            /* Plot data in buffer */
   UDINT              block_ncprog;           /* Block number in CNC program */
   USINT              cmd_code;               /* Code of the command */
   USINT              reserve0;               /* Reserved */
   USINT              info;                   /* Additional Info */
   USINT              plane;                  /* Plane */
   REAL               end[3];                 /* End Point */
   REAL               center[3];              /* Center point definition */
   ARNC0MATRIX_typ    rotation;               /* Rotation matrix */
   REAL               v_ncprog;               /* Path speed currently defined in CNC program */
} ARNC0PLOTDATA_typ;

typedef struct ARNC0PLOTFOOTER_typ {          /* End of plot buffer */
   UDINT              buffer_end;             /* End of buffer */
} ARNC0PLOTFOOTER_typ;

typedef struct ARNC0PLOTHEADER_typ {          /* Header for plot buffer */
   UDINT              size;                   /* Size of the corresponding NC manager data type */
   USINT              format;                 /* Format */
   USINT              status;                 /* Status */
   UINT               reserve0;               /* Reserved */
   ARNC0SWVER_typ     sw_version;             /* Software Version ID */
   UDINT              start;                  /* Start */
   UDINT              write;                  /* Reference for write access */
   UDINT              read;                   /* Reference for read access */
} ARNC0PLOTHEADER_typ;

typedef struct ARNC0DBLST_typ {               /* Status */
   UDINT              data_len;               /* Length of data */
   USINT              init;                   /* Data block initialized */
   USINT              ok;                     /* Operation complete */
   USINT              error;                  /* Error */
   USINT              reserve1;               /* Reserved */
   UDINT              reserve2;               /* Reserved */
} ARNC0DBLST_typ;

typedef struct ARNC0DBLPA_typ {               /* Parameters */
   UDINT              data_len;               /* Length of data */
   UDINT              data_adr;               /* Data address */
   USINT              data_modul[12];         /* Name of the data module */
   UINT               index;                  /* Index */
   UINT               mode;                   /* Mode */
   UINT               format;                 /* Format */
   UINT               reserve;                /* Reserved */
} ARNC0DBLPA_typ;

typedef struct ARNC0DATBL_typ {               /* Data block operation */
   ARNC0DBLST_typ     status;                 /* Status */
   ARNC0DBLPA_typ     parameter;              /* Parameters */
} ARNC0DATBL_typ;

typedef struct ARNC0DNCHEADER_typ {           /* Header of DNC Interface */
   USINT              status;                 /* Status */
   USINT              reserve[3];             /* Reserved */
   UDINT              start_adr;              /* Start address of CNC data area */
   UDINT              write_adr;              /* Write address (write pointer) */
   UDINT              read_adr;               /* Read address (read pointer) */
   UDINT              size;                   /* Size of CNC data area */
} ARNC0DNCHEADER_typ;

typedef struct ARNC0TYPES_typ {               /* Data structure for additional data types */
   ARNC0DATBL_typ     data_block;             /* Data block operation */
   ARNC0DNCHEADER_typ dnc_header;             /* Header of DNC Interface */
} ARNC0TYPES_typ;


typedef struct ARNC0FILEMONENTRY_typ
{	unsigned long name;
	unsigned long path_name;
	unsigned long dir_name;
	unsigned long device_name;
	unsigned long prog_nr;
	unsigned long storage_type;
	unsigned long time_stamp;
	plcbit precompiled_lcf;
	unsigned char NOT_USE_1[3];
	unsigned long next;
} ARNC0FILEMONENTRY_typ;

typedef struct ARNC0FILEMONBASIC_typ
{	plcstring name[32];
	unsigned long prog_nr;
	unsigned long storage_type;
} ARNC0FILEMONBASIC_typ;

typedef struct ARNC0FILEMONACCESS_typ
{	plcbit valid;
	unsigned char NOT_USE_1[3];
	unsigned long first;
} ARNC0FILEMONACCESS_typ;

typedef struct ARNC0FILEMON_typ
{	unsigned long set_offset;
	unsigned long offset;
	struct ARNC0FILEMONBASIC_typ file[32];
	struct ARNC0FILEMONACCESS_typ direct_access;
	plcbit handshake;
	unsigned char NOT_USE_1[3];
} ARNC0FILEMON_typ;

typedef struct ARNC0EXTWMCOL_typ
{	unsigned long result;
	unsigned long index1;
	unsigned long shape1;
} ARNC0EXTWMCOL_typ;

typedef struct ARNC0EXTWM_typ
{	double joint_position[12];
	double xyz_position[3];
	double D_FULL[6];
	double local_frame[6];
	struct ARNC0EXTWMCOL_typ collision;
} ARNC0EXTWM_typ;

typedef struct OPTMOT_SEG_CONFIG_typ
{	double distance;
	double increase_num_seg_from_radius;
	double increase_num_seg_orient_factor;
	unsigned long G126_num_seg;
	unsigned long G126_num_seg_PTP_Interp;
} OPTMOT_SEG_CONFIG_typ;

typedef struct OPTMOT_AXES_typ
{	unsigned long ax_count;
	unsigned char ax_index[15];
	unsigned char NOT_USE_1;
	double ax_factor[15];
} OPTMOT_AXES_typ;

typedef struct OPTMOT_PATHDEF_typ
{	unsigned short type;
	unsigned short ax_count;
	unsigned char ax_index[15];
	unsigned char NOT_USE_1;
	double ax_factor[15];
} OPTMOT_PATHDEF_typ;

typedef struct OPTMOT_TRF_VAR_INSTANCES_typ
{	unsigned long trf_var_ip;
	unsigned long trf_var_ip_wm;
	unsigned long trf_var_pp1;
	unsigned long trf_var_pp2;
	unsigned long trf_var_bgen;
} OPTMOT_TRF_VAR_INSTANCES_typ;

typedef struct OPTMOT_ACCESS_POINTS_typ
{	unsigned long pp_context;
	unsigned long wm_function;
	unsigned long address_debug_data;
	struct OPTMOT_TRF_VAR_INSTANCES_typ trf_var_instances;
} OPTMOT_ACCESS_POINTS_typ;

typedef struct OPTMOT_INTERNAL_typ
{	unsigned long buffer_nc_block;
	unsigned long buffer_geometric_data;
	unsigned char disable_optmot_for_channel;
	unsigned char Ts_multiple;
	unsigned char linear_feed;
	unsigned char bypass_optmot;
	unsigned long addr_dyn_model;
	unsigned short der_num_poly_points;
	unsigned short geometric_pos_filter;
	unsigned short buffer_level_lookahead;
	unsigned short G220_reduce_to_max_in_buffer;
	double sigma_diff_compute;
	double max_angle;
	struct OPTMOT_ACCESS_POINTS_typ access_points;
	double reserve1[10];
	signed long reserve2[10];
} OPTMOT_INTERNAL_typ;

typedef struct OPTMOT_LIMITS_typ
{	double v_joint_min[15];
	double v_joint_max[15];
	double a_joint_min[15];
	double a_joint_max[15];
	double j_joint_min[15];
	double j_joint_max[15];
	double torque_min[15];
	double torque_max[15];
	unsigned long torque_limits_in_generator_mode;
	double torque_gen_factor_min[15];
	double torque_gen_factor_max[15];
	double v_path_min[32];
	double v_path_max[32];
	double a_path_min[32];
	double a_path_max[32];
	double j_path_min[32];
	double j_path_max[32];
} OPTMOT_LIMITS_typ;

typedef struct OPTMOT_ACTIVE_LIMIT_typ
{	unsigned char type;
	unsigned char source;
	signed char min_max;
	unsigned char index;
} OPTMOT_ACTIVE_LIMIT_typ;

typedef struct OPTMOT_UNFILTERED_MONITOR_typ
{	double s_joint[15];
	double v_joint[15];
	double a_joint[15];
	double j_joint[15];
} OPTMOT_UNFILTERED_MONITOR_typ;

typedef struct OPTMOT_MONITOR_typ
{	double s_joint[15];
	double v_joint[15];
	double a_joint[15];
	double j_joint[15];
	double feed_forward_torque[15];
	double v_path[32];
	struct OPTMOT_UNFILTERED_MONITOR_typ unfiltered_monitor;
	struct OPTMOT_ACTIVE_LIMIT_typ active_limit;
	unsigned short data_valid;
	unsigned short fill_level_lookahead;
	unsigned long reserve[2];
} OPTMOT_MONITOR_typ;

typedef struct OPTMOT_COND_STOP_typ
{	unsigned short active;
	unsigned short call_stop_internal;
	unsigned long identifier;
	unsigned long select_overlapped_identifier;
	unsigned long select_identifier_stop_internal;
} OPTMOT_COND_STOP_typ;

typedef struct OPTMOT_COND_STOP_OPTMOT_typ
{	unsigned long identifier_aktiv;
	unsigned long identifier_fulfilled;
} OPTMOT_COND_STOP_OPTMOT_typ;

typedef struct OPTMOT_STOPPING_typ
{	unsigned short G126_skip_if_stop;
	unsigned short trajectory;
	struct OPTMOT_COND_STOP_typ conditional_stop;
	struct OPTMOT_COND_STOP_OPTMOT_typ conditional_stop_optmot;
} OPTMOT_STOPPING_typ;

typedef struct OPTMOT_PATH_typ
{	double G126_skip_smaller_radius;
	unsigned long G126_round_whole_line;
	unsigned long count;
	struct OPTMOT_PATHDEF_typ definition[32];
	struct OPTMOT_STOPPING_typ stopping;
	unsigned long reserve1[171];
} OPTMOT_PATH_typ;

typedef struct OPTMOT_CONFIG_typ
{	struct OPTMOT_AXES_typ axes;
	struct OPTMOT_PATH_typ path;
	struct OPTMOT_LIMITS_typ limits[32];
	struct OPTMOT_SEG_CONFIG_typ segmentation;
	struct OPTMOT_MONITOR_typ monitor;
	struct OPTMOT_INTERNAL_typ internals;
} OPTMOT_CONFIG_typ;

typedef struct OPTMOT_MONITOR_ADVANCED_typ
{	double s_joint[15];
	double v_joint[15];
	double a_joint[15];
	double j_joint[15];
	double feed_forward_torque[15];
	double v_path[32];
	struct OPTMOT_UNFILTERED_MONITOR_typ unfiltered_monitor;
	struct OPTMOT_ACTIVE_LIMIT_typ active_limit;
	unsigned short data_valid;
	unsigned short fill_level_lookahead;
	unsigned short tracking_active;
	unsigned short tracking_synch;
	unsigned short tracking_index;
	unsigned short reserve;
} OPTMOT_MONITOR_ADVANCED_typ;

typedef struct OPTMOT_TRACKING_ORIENTATION_typ
{	double phi;
	double theta;
	double psi;
} OPTMOT_TRACKING_ORIENTATION_typ;

typedef struct OPTMOT_TRACKING_ORIENT_PARAM_typ
{	unsigned long measure;
	unsigned long angles_type;
} OPTMOT_TRACKING_ORIENT_PARAM_typ;

typedef struct OPTMOT_TRACKING_LIMITS_typ
{	double maxVelocity;
} OPTMOT_TRACKING_LIMITS_typ;

typedef struct OPTMOT_TRACKING_CYCLIC_typ
{	double position;
	double velocity;
} OPTMOT_TRACKING_CYCLIC_typ;

typedef struct OPTMOT_TRACKING_CONVEYOR_typ
{	struct OPTMOT_TRACKING_LIMITS_typ limits;
	struct OPTMOT_TRACKING_ORIENTATION_typ orientation;
	struct OPTMOT_TRACKING_CYCLIC_typ cyclicData;
} OPTMOT_TRACKING_CONVEYOR_typ;

typedef struct OPTMOT_TRACKING_CONVEYORDATA_typ
{	struct OPTMOT_TRACKING_ORIENT_PARAM_typ orientationParameter;
	struct OPTMOT_TRACKING_CONVEYOR_typ conveyor[10];
} OPTMOT_TRACKING_CONVEYORDATA_typ;

typedef struct OPTMOT_TRACKING_typ
{	unsigned long enable;
	struct OPTMOT_TRACKING_CONVEYORDATA_typ conveyorData;
	double feedrateMode;
	double reserve1[7];
	unsigned long reserve2[32];
} OPTMOT_TRACKING_typ;

typedef struct OPTMOT_PATH_ADVANCED_typ
{	double G126_skip_smaller_radius;
	unsigned long G126_round_whole_line;
	unsigned long count;
	struct OPTMOT_PATHDEF_typ definition[32];
	struct OPTMOT_STOPPING_typ stopping;
	struct OPTMOT_TRACKING_typ tracking;
} OPTMOT_PATH_ADVANCED_typ;

typedef struct OPTMOT_CONFIG_ADVANCED_typ
{	struct OPTMOT_AXES_typ axes;
	struct OPTMOT_PATH_ADVANCED_typ path;
	struct OPTMOT_LIMITS_typ limits[32];
	struct OPTMOT_SEG_CONFIG_typ segmentation;
	struct OPTMOT_MONITOR_ADVANCED_typ monitor;
	struct OPTMOT_INTERNAL_typ internals;
} OPTMOT_CONFIG_ADVANCED_typ;

typedef struct ARNC0PLOTDATA01_typ
{	unsigned long block_ncprog;
	unsigned long line_ncprog;
	unsigned long MpId;
	unsigned long MpSubId;
	unsigned short cmd_code;
	unsigned short reserve;
	unsigned char data[52];
} ARNC0PLOTDATA01_typ;

typedef struct ARNC0PLOTDATA02_typ
{	unsigned long block_ncprog;
	unsigned long line_ncprog;
	unsigned long MpId;
	unsigned long MpSubId;
	unsigned short cmd_code;
	unsigned short reserve;
	unsigned char data[52];
} ARNC0PLOTDATA02_typ;

typedef struct ARNC0PLDMOVE_typ
{	float ep[3];
	float cp[3];
	float radius;
	float v_ncprog;
	unsigned long info;
} ARNC0PLDMOVE_typ;

typedef struct ARNC0PLDMOVE02_typ
{	float ep[3];
	float cp[3];
	float radius;
	float v_ncprog;
	float t;
	float s;
	float s_all;
	unsigned long info;
} ARNC0PLDMOVE02_typ;

typedef struct ARNC0PLDPROGEND_typ
{	float t;
	float s;
	float s_all;
} ARNC0PLDPROGEND_typ;

typedef struct ARNC0PLDPROGSTART_typ
{	unsigned long ProgNumber;
} ARNC0PLDPROGSTART_typ;

typedef struct ARNC0PLDTOOL_typ
{	float radius;
	float length;
	float offset[3];
	unsigned short index;
	unsigned short reserve;
} ARNC0PLDTOOL_typ;

typedef struct ARNC0PLDCSTRF_typ
{	float matrix[9];
	float offset[3];
	unsigned long info;
} ARNC0PLDCSTRF_typ;

typedef struct ARNC0PLDUSER_typ
{	unsigned char data[52];
} ARNC0PLDUSER_typ;

typedef struct ARNC0TRFIODATA_typ
{	unsigned long status;
	double in_pos[12];
	double in_pos_ext[12];
	double out_pos[72];
	unsigned long info[9];
} ARNC0TRFIODATA_typ;

typedef struct ARNC0WSCTRL_typ
{	unsigned long link_index;
	unsigned long link2_index;
	unsigned long area_index;
} ARNC0WSCTRL_typ;

typedef struct ARNC0NCMON_EXT_AX_typ
{	unsigned long nc_object;
	unsigned long nc_object_plcopen;
	float v;
	float a;
	float t_jolt;
	signed long pos_sw_end;
	signed long neg_sw_end;
	float unitfactor;
	float plcopen_factor;
	unsigned long type;
	float rot_period;
	float rot_offset;
	unsigned char ipl_mode;
	unsigned char drive_axfilter;
	unsigned char nc_obj_name[14];
	unsigned char cnc_ax_name[14];
	unsigned char reserve[2];
} ARNC0NCMON_EXT_AX_typ;

typedef struct ARNC0NCMON_EXT_G113_typ
{	float k_alpha_max;
	float alpha_min;
	float alpha_max;
} ARNC0NCMON_EXT_G113_typ;

typedef struct ARNC0NCMON_EXT_CNC_typ
{	unsigned long nc_object;
	float v;
	float a_pos;
	float a_neg;
	float t_jolt;
	float feed;
	float v_jump[15];
	float a_jump[15];
	float v_jump_t;
	float s_jump_t;
	float filter_err_cir;
	float filter_err_trans;
	float radius_err;
	unsigned long elements;
	unsigned long block_buffer;
	unsigned long lookahead;
	unsigned short first_M;
	unsigned short last_M;
	unsigned short first_M_S;
	unsigned short last_M_S;
	unsigned short s_sync1_t;
	unsigned short s_sync2_t;
	unsigned char blocktransition;
	unsigned char reserve;
	unsigned char nc_obj_name[14];
	struct ARNC0NCMON_EXT_G113_typ g113_data;
} ARNC0NCMON_EXT_CNC_typ;

typedef struct ARNC0NCMON_EXT_G705_typ
{	unsigned long ident;
	struct ARNC0NCMON_EXT_AX_typ axis[15];
	struct ARNC0NCMON_EXT_CNC_typ cnc;
	unsigned long block_ncprog;
	unsigned long line_ncprog;
	unsigned short cnc_channel;
	unsigned short reserve;
} ARNC0NCMON_EXT_G705_typ;

typedef struct ARNC0NCMON_EXT_typ
{	double s_set[15];
	double s_ncprog;
	struct ARNC0NCMON_EXT_G705_typ g705_data;
	unsigned long reserve[2];
} ARNC0NCMON_EXT_typ;

typedef struct ARNC0WFM_SERIAL_typ
{	unsigned long nr_of_points;
	double point[21][3];
	unsigned long nr_of_arms;
	double arm_diameter[20];
	double safe_distance;
} ARNC0WFM_SERIAL_typ;

typedef struct ARNC0WFM_COMPLETE_typ
{	unsigned long data[330];
} ARNC0WFM_COMPLETE_typ;

typedef struct ARNC0WFM_typ
{	unsigned long use_complete;
	struct ARNC0WFM_COMPLETE_typ complete;
	unsigned long use_serial;
	struct ARNC0WFM_SERIAL_typ serial;
} ARNC0WFM_typ;

typedef struct ARNC0WFM_BFS
{	unsigned long enable;
	double dx;
	double dy;
	double dz;
	double phi;
	double theta;
	double psi;
	unsigned long angles_type;
} ARNC0WFM_BFS;

typedef struct ARNC0WFM_MON_typ
{	unsigned long valid_data;
	unsigned long invalid_data;
} ARNC0WFM_MON_typ;

typedef struct ARNC0WFM_EXT_typ
{	struct ARNC0WFM_typ* p_wire_frame_model;
	struct ARNC0WFM_BFS base_frame_shift;
	struct ARNC0WFM_MON_typ monitor;
} ARNC0WFM_EXT_typ;

typedef struct ARNC0INTERACTION_typ
{	struct ARNC0WFM_typ wire_frame_model;
	struct ARNC0WFM_EXT_typ wire_frame_models_to_check[24];
} ARNC0INTERACTION_typ;







typedef struct ARNC0IP_MON_typ
{	unsigned char enable;
	unsigned char reserve[3];
	unsigned char status_msg[80];
	unsigned char last_error_msg[120];
	unsigned short last_error_code;
	unsigned short loaded_prog_count;
	unsigned char prog_name[80];
	unsigned char ncblock_l2[80];
	unsigned char ncblock_l1[80];
	unsigned char ncblock[80];
	unsigned char ncblock_n1[80];
	unsigned char ncblock_n2[80];
	unsigned long cur_line_num;
	unsigned long cur_block_num;
	unsigned long intern1;
	unsigned long intern2;
	unsigned long intern3;
	unsigned long intern4;
	unsigned long intern5;
	unsigned long breakpoint_count;
	unsigned long ipvar_access_count;
	unsigned long intern6;
	unsigned long intern7;
	unsigned long num_parallel_events;
	unsigned long parallel_cycle_count;
	unsigned char parallel_action_text[12][80];
	unsigned long parallel_eval_count[12];
	unsigned long parallel_exec_count[12];
	unsigned long num_fubs_exec_ipsynch;
	unsigned long num_fubs_exec_ppsynch;
	unsigned char callstack[12][80];
	unsigned long shared_mem_size;
	unsigned long ip_mem_size;
	unsigned long ip_cur_file_mem_size;
	unsigned long sys_free_mem;
	unsigned long intern8;
	unsigned long intern9;
	unsigned long intern10;
	unsigned long intern11;
	unsigned char parallel_enabled;
	unsigned char parallel_rdisable_set;
	unsigned char intern12;
	unsigned char intern13;
	unsigned char cur_prog_file_name[80];
	unsigned char cur_prog_name[80];
} ARNC0IP_MON_typ;







#endif /* ARNC0MAN_H_VERSION */
