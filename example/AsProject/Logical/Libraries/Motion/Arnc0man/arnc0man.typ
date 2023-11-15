TYPE
ARNC0SWVER_typ : STRUCT                                     (* Software Version ID *)
   NOT_USE_1            : ARRAY [0..1] OF USINT ;
   nc_system_device     : UINT ;                            (* ACOPOS operating system *)
   nc_manager           : UINT ;                            (* NC manager *)
   nc_system            : UINT ;                            (* NC operating system *)
END_STRUCT;
ARNC0OBIHW_typ : STRUCT                                     (* Hardware information *)
   init                 : USINT ;                           (* Initialized *)
   reserve1             : USINT ;                           (* Reserved *)
   acp_id               : USINT ;                           (* ACOPOS ID *)
   acp_id_nr            : USINT ;                           (* ACOPOS ID production number *)
   acp_typ              : USINT ;                           (* ACOPOS type *)
   ax_num               : USINT ;                           (* Number of axes (power stages) *)
   reserve2             : UINT ;                            (* Reserved *)
   product_code         : UDINT ;                           (* Product code *)
   serial_nr            : UDINT ;                           (* Serial number *)
END_STRUCT;
ARNC0OBINF_typ : STRUCT                                     (* NC Object Information *)
   net_if_typ           : UINT ;                            (* Network interface type *)
   net_if_idx           : UINT ;                            (* Network interface index *)
   node_nr              : UINT ;                            (* Drive node number *)
   nc_obj_typ           : UINT ;                            (* NC object type *)
   nc_obj_idx           : UINT ;                            (* NC object index *)
   reserve              : UINT ;                            (* Reserved *)
   nc_obj_name          : ARRAY [0..47] OF USINT ;          (* NC object name *)
   hardware             : ARNC0OBIHW_typ ;                  (* Hardware information *)
END_STRUCT;
ARNC0AXSIM_typ : STRUCT                                     (* Simulation mode *)
   NOT_USE_1            : ARRAY [0..3] OF USINT ;
   status               : UINT ;                            (* Status *)
   mode                 : UINT ;                            (* Mode *)
   NOT_USE_2            : ARRAY [0..47] OF USINT ;
END_STRUCT;
ARNC0GLIPA_typ : STRUCT                                     (* INIT Parameters *)
   ok                   : USINT ;                           (* Operation complete *)
   error                : USINT ;                           (* Error *)
   reserve              : UINT ;                            (* Reserved *)
   datobj_ident         : UDINT ;                           (* Data object ident *)
   data_modul           : ARRAY [0..11] OF USINT ;          (* Name of the data module *)
END_STRUCT;
ARNC0GLINI_typ : STRUCT                                     (* Global Initialization *)
   init                 : USINT ;                           (* Global Initialization complete *)
   NOT_USE_1            : ARRAY [0..2] OF USINT ;
   init_par             : ARNC0GLIPA_typ ;                  (* INIT Parameters *)
END_STRUCT;
ARNC0NSVRQ_typ : STRUCT                                     (* Request (to the drive) *)
   par_id               : UINT ;                            (* Parameter ID *)
   NOT_USE_1            : ARRAY [0..1] OF USINT ;
END_STRUCT;
ARNC0NSVRS_typ : STRUCT                                     (* Response (from the drive) *)
   par_id               : UINT ;                            (* Parameter ID *)
   NOT_USE_1            : ARRAY [0..1] OF USINT ;
END_STRUCT;
ARNC0NETSV_typ : STRUCT                                     (* Service Interface *)
   data_adr             : UDINT ;                           (* Data address *)
   data_text            : ARRAY [0..31] OF USINT ;          (* Data in text format *)
   request              : ARNC0NSVRQ_typ ;                  (* Request (to the drive) *)
   response             : ARNC0NSVRS_typ ;                  (* Response (from the drive) *)
END_STRUCT;
ARNC0NETAX_typ : STRUCT                                     (* Network *)
   init                 : USINT ;                           (* Network initialized *)
   phase                : USINT ;                           (* Phase *)
   NOT_USE_1            : USINT ;
   nc_sys_restart       : USINT ;                           (* A Restart of the NC operating system was executed *)
   reserve              : UINT ;                            (* Reserved *)
   reserve1             : UINT ;                            (* Reserved *)
   service              : ARNC0NETSV_typ ;                  (* Service Interface *)
END_STRUCT;
ARNC0AXDBS_typ : STRUCT                                     (* Status *)
   ok                   : USINT ;                           (* Operation complete *)
   error                : USINT ;                           (* Error *)
   reserve1             : USINT ;                           (* Reserved *)
   reserve2             : USINT ;                           (* Reserved *)
   data_len             : UDINT ;                           (* Length of data *)
   datobj_ident         : UDINT ;                           (* Data object ident *)
   datobj_datadr        : UDINT ;                           (* Address of the data object data *)
END_STRUCT;
ARNC0AXDBP_typ : STRUCT                                     (* Parameters *)
   file_device          : ARRAY [0..31] OF USINT ;          (* Name of File Device *)
   datobj_name          : ARRAY [0..31] OF USINT ;          (* Name of the data object *)
   datobj_type          : UINT ;                            (* Type of the data object *)
   datblock_par_id      : UINT ;                            (* Parameter ID of the data block *)
   idx1_par_id          : UINT ;                            (* Parameter ID of data block index 1 *)
   idx1                 : UINT ;                            (* Data block index 1 *)
   idx2_par_id          : UINT ;                            (* Parameter ID of data block index 2 *)
   idx2                 : UINT ;                            (* Data block index 2 *)
   NOT_USE_1            : ARRAY [0..7] OF USINT ;
END_STRUCT;
ARNC0AXDBL_typ : STRUCT                                     (* Data block operation *)
   status               : ARNC0AXDBS_typ ;                  (* Status *)
   parameter            : ARNC0AXDBP_typ ;                  (* Parameters *)
END_STRUCT;
ARNC0DISTA_typ : STRUCT                                     (* Status *)
   reference            : USINT ;                           (* Reference switch *)
   pos_hw_end           : USINT ;                           (* Positive HW end switch *)
   neg_hw_end           : USINT ;                           (* Negative HW end switch *)
   trigger1             : USINT ;                           (* Trigger1 *)
   trigger2             : USINT ;                           (* Trigger2 *)
   enable               : USINT ;                           (* Enable *)
   NOT_USE_1            : ARRAY [0..1] OF USINT ;
END_STRUCT;
ARNC0DILEV_typ : STRUCT                                     (* Active Input Level *)
   reference            : UINT ;                            (* Reference switch *)
   pos_hw_end           : UINT ;                            (* Positive HW end switch *)
   neg_hw_end           : UINT ;                            (* Negative HW end switch *)
   trigger1             : UINT ;                            (* Trigger1 *)
   trigger2             : UINT ;                            (* Trigger2 *)
   NOT_USE_1            : ARRAY [0..1] OF USINT ;
END_STRUCT;
ARNC0DIFRC_typ : STRUCT                                     (* Set status of digital inputs via force function *)
   reference            : USINT ;                           (* Reference switch *)
   pos_hw_end           : USINT ;                           (* Positive HW end switch *)
   neg_hw_end           : USINT ;                           (* Negative HW end switch *)
   trigger1             : USINT ;                           (* Trigger1 *)
   trigger2             : USINT ;                           (* Trigger2 *)
   reserve1             : USINT ;                           (* Reserved *)
   reserve2             : UINT ;                            (* Reserved *)
END_STRUCT;
ARNC0DIGIN_typ : STRUCT                                     (* Digital Inputs *)
   init                 : USINT ;                           (* Digital inputs initialized *)
   NOT_USE_1            : ARRAY [0..2] OF USINT ;
   status               : ARNC0DISTA_typ ;                  (* Status *)
   level                : ARNC0DILEV_typ ;                  (* Active Input Level *)
   force                : ARNC0DIFRC_typ ;                  (* Set status of digital inputs via force function *)
END_STRUCT;
ARNC0ENCSL_typ : STRUCT                                     (* Load *)
   units                : UDINT ;                           (* Units at the load *)
   rev_motor            : UDINT ;                           (* Motor revolutions *)
END_STRUCT;
ARNC0ENCSC_typ : STRUCT                                     (* Scale of encoder interface *)
   load                 : ARNC0ENCSL_typ ;                  (* Load *)
END_STRUCT;
ARNC0ENCPA_typ : STRUCT                                     (* Parameters of encoder interface *)
   count_dir            : USINT ;                           (* Count direction *)
   NOT_USE_1            : ARRAY [0..2] OF USINT ;
   scaling              : ARNC0ENCSC_typ ;                  (* Scaling *)
END_STRUCT;
ARNC0ENCIF_typ : STRUCT                                     (* Encoder interface *)
   init                 : USINT ;                           (* Encoder interface initialized *)
   NOT_USE_1            : ARRAY [0..2] OF USINT ;
   parameter            : ARNC0ENCPA_typ ;                  (* Parameters *)
END_STRUCT;
ARNC0AXLPA_typ : STRUCT                                     (* Parameters *)
   v_pos                : REAL ;                            (* Speed in positive direction *)
   v_neg                : REAL ;                            (* Speed in negative direction *)
   a1_pos               : REAL ;                            (* Acceleration in positive direction *)
   a2_pos               : REAL ;                            (* Deceleration in positive direction *)
   a1_neg               : REAL ;                            (* Acceleration in negative direction *)
   a2_neg               : REAL ;                            (* Deceleration in negative direction *)
   t_jolt               : REAL ;                            (* Jolt time *)
   t_in_pos             : REAL ;                            (* Settling time before message "In Position" *)
   pos_sw_end           : DINT ;                            (* Positive SW end *)
   neg_sw_end           : DINT ;                            (* Negative SW end *)
   sw_end_enable        : USINT ;                           (* Control byte for limit monitor *)
   sl_chain             : USINT ;                           (* Slaves in a chain or ncOFF *)
   NOT_USE_1            : ARRAY [0..1] OF USINT ;
   ds_warning           : REAL ;                            (* Lag error limit for display of a warning *)
   ds_stop              : REAL ;                            (* Lag error limit for stop of a movement *)
   a_stop               : REAL ;                            (* Acceleration limit for stop of a movement *)
   dv_stop              : REAL ;                            (* Speed error limit for stop of a movement *)
   dv_stop_mode         : UDINT ;                           (* Mode for speed error monitoring *)
END_STRUCT;
ARNC0AXLIM_typ : STRUCT                                     (* Limit values *)
   init                 : USINT ;                           (* Axis limit values initialized *)
   status               : USINT ;                           (* Status *)
   NOT_USE_1            : ARRAY [0..1] OF USINT ;
   parameter            : ARNC0AXLPA_typ ;                  (* Parameters *)
END_STRUCT;
ARNC0CTRPO_typ : STRUCT                                     (* Position controller *)
   kv                   : REAL ;                            (* Proportional amplification *)
   tn                   : REAL ;                            (* Integral action time *)
   t_predict            : REAL ;                            (* Prediction time *)
   t_total              : REAL ;                            (* Total time *)
   p_max                : REAL ;                            (* Maximum proportional action *)
   i_max                : REAL ;                            (* Maximum integral action *)
END_STRUCT;
ARNC0ISQFI_typ : STRUCT                                     (* ISQ Filter *)
   type                 : UINT ;                            (* Type *)
   reserve              : UINT ;                            (* Reserved *)
   a0                   : REAL ;                            (* Coefficient a0 *)
   a1                   : REAL ;                            (* Coefficient a1 *)
   b0                   : REAL ;                            (* Coefficient b0 *)
   b1                   : REAL ;                            (* Coefficient b1 *)
   b2                   : REAL ;                            (* Coefficient b2 *)
   c0_par_id            : UINT ;                            (* Parameter ID for coefficient c0 *)
   c1_par_id            : UINT ;                            (* Parameter ID for coefficient c1 *)
END_STRUCT;
ARNC0CTRSP_typ : STRUCT                                     (* Speed controller *)
   kv                   : REAL ;                            (* Proportional amplification *)
   tn                   : REAL ;                            (* Integral action time *)
   t_filter             : REAL ;                            (* Filter time constant *)
   isq_filter1          : ARNC0ISQFI_typ ;                  (* ISQ Filter1 *)
   isq_filter2          : ARNC0ISQFI_typ ;                  (* ISQ Filter2 *)
   isq_filter3          : ARNC0ISQFI_typ ;                  (* ISQ Filter3 *)
END_STRUCT;
ARNC0CTRUF_typ : STRUCT                                     (* U/f Control *)
   type                 : USINT ;                           (* Type *)
   auto_config          : USINT ;                           (* Automatic configuration *)
   reserve              : UINT ;                            (* Reserved *)
   u0                   : REAL ;                            (* Boost voltage *)
   un                   : REAL ;                            (* Rated voltage *)
   fn                   : REAL ;                            (* Rated frequency *)
   k_f_slip             : REAL ;                            (* Slip compensation: Multiplication factor of compensated frequency *)
END_STRUCT;
ARNC0CTRFF_typ : STRUCT                                     (* Feed Forward Control *)
   NOT_USE_1            : ARRAY [0..3] OF USINT ;
   torque_load          : REAL ;                            (* Load torque *)
   torque_pos           : REAL ;                            (* Torque in positive direction *)
   torque_neg           : REAL ;                            (* Torque in negative direction *)
   kv_torque            : REAL ;                            (* Speed torque factor *)
   inertia              : REAL ;                            (* Mass moment of inertia *)
   t_filter_a           : REAL ;                            (* Acceleration filter time constant *)
END_STRUCT;
ARNC0CTRL_typ : STRUCT                                      (* Controller *)
   init                 : USINT ;                           (* Controller initialized *)
   ready                : USINT ;                           (* Ready *)
   status               : USINT ;                           (* Status *)
   mode                 : USINT ;                           (* Mode *)
   position             : ARNC0CTRPO_typ ;                  (* Position Controller *)
   speed                : ARNC0CTRSP_typ ;                  (* Speed Controller *)
   uf                   : ARNC0CTRUF_typ ;                  (* U/f Control *)
   ff                   : ARNC0CTRFF_typ ;                  (* Feed Forward Control *)
   NOT_USE_1            : ARRAY [0..35] OF USINT ;
END_STRUCT;
ARNC0AXSTI_typ : STRUCT                                     (* Index of Parameter Record *)
   command              : USINT ;                           (* for the next stop command *)
   NOT_USE_1            : ARRAY [0..2] OF USINT ;
END_STRUCT;
ARNC0AXSTP_typ : STRUCT                                     (* Parameter Records *)
   decel_ramp           : USINT ;                           (* Deceleration ramp *)
   controller           : USINT ;                           (* Controller state after movement abortion *)
   NOT_USE_1            : ARRAY [0..1] OF USINT ;
END_STRUCT;
ARNC0AXSTQ_typ : STRUCT                                     (* Quickstop *)
   decel_ramp           : USINT ;                           (* Deceleration ramp *)
   NOT_USE_1            : USINT ;
   reserve2             : UINT ;                            (* Reserved *)
   NOT_USE_2            : ARRAY [0..3] OF USINT ;
END_STRUCT;
ARNC0AXSTD_typ : STRUCT                                     (* Drive error *)
   decel_ramp           : USINT ;                           (* Deceleration ramp *)
   reserve1             : USINT ;                           (* Reserved *)
   reserve2             : UINT ;                            (* Reserved *)
END_STRUCT;
ARNC0AXSTO_typ : STRUCT                                     (* Stop Movement *)
   init                 : USINT ;                           (* Stop initialized *)
   NOT_USE_1            : ARRAY [0..2] OF USINT ;
   index                : ARNC0AXSTI_typ ;                  (* Index *)
   parameter            : ARRAY [0..3] OF ARNC0AXSTP_typ ;  (* Parameter record *)
   quickstop            : ARNC0AXSTQ_typ ;                  (* Quickstop *)
   drive_error          : ARNC0AXSTD_typ ;                  (* Drive error *)
END_STRUCT;
ARNC0HOMST_typ : STRUCT                                     (* Status *)
   ok                   : USINT ;                           (* Reference position valid *)
   NOT_USE_1            : ARRAY [0..2] OF USINT ;
   tr_s_rel             : REAL ;                            (* Distance between activation of "triggering reference pulse" and the occurrence of the reference pulse *)
   offset               : DINT ;                            (* Home offset after completion of homing procedure *)
END_STRUCT;
ARNC0HOMPA_typ : STRUCT                                     (* Parameters *)
   s                    : DINT ;                            (* Reference position *)
   v_switch             : REAL ;                            (* Speed for searching the reference switch *)
   v_trigger            : REAL ;                            (* Trigger speed (after ref. switch has been reached) *)
   a                    : REAL ;                            (* Acceleration *)
   mode                 : USINT ;                           (* Mode *)
   edge                 : USINT ;                           (* Edge of reference switch *)
   start_dir            : USINT ;                           (* Start direction *)
   trigg_dir            : USINT ;                           (* Trigger direction *)
   ref_pulse            : USINT ;                           (* Reference pulse *)
   fix_dir              : USINT ;                           (* Fixed direction *)
   reserve1             : USINT ;                           (* Reserved *)
   reserve2             : USINT ;                           (* Reserved *)
   tr_s_block           : REAL ;                            (* Reference pulse block distance *)
   torque_lim           : REAL ;                            (* Torque limit for homing on block *)
   ds_block             : REAL ;                            (* Lag error for block detection *)
   ds_stop              : REAL ;                            (* Lag error for stop of a movement *)
END_STRUCT;
ARNC0HOME_typ : STRUCT                                      (* Homing *)
   init                 : USINT ;                           (* Homing procedure initialized *)
   NOT_USE_1            : ARRAY [0..2] OF USINT ;
   status               : ARNC0HOMST_typ ;                  (* Status *)
   parameter            : ARNC0HOMPA_typ ;                  (* Parameters *)
END_STRUCT;
ARNC0BMVST_typ : STRUCT                                     (* Status *)
   in_pos               : USINT ;                           (* "In Position" (target position reached) *)
   reserve              : ARRAY [0..2] OF USINT ;           (* Reserved *)
END_STRUCT;
ARNC0BMVOV_typ : STRUCT                                     (* Override *)
   v                    : UINT ;                            (* Speed override *)
   NOT_USE_1            : ARRAY [0..1] OF USINT ;
END_STRUCT;
ARNC0BMVPA_typ : STRUCT                                     (* Parameters *)
   s                    : DINT ;                            (* Target position or relative move distance *)
   v_pos                : REAL ;                            (* Speed in positive direction *)
   v_neg                : REAL ;                            (* Speed in negative direction *)
   a1_pos               : REAL ;                            (* Acceleration in positive direction *)
   a2_pos               : REAL ;                            (* Deceleration in positive direction *)
   a1_neg               : REAL ;                            (* Acceleration in negative direction *)
   a2_neg               : REAL ;                            (* Deceleration in negative direction *)
END_STRUCT;
ARNC0TRG_typ : STRUCT                                       (* Source for Hardware Trigger *)
   nc_object            : UDINT ;                           (* NC object or ncOFF *)
   NOT_USE_1            : ARRAY [0..7] OF USINT ;
END_STRUCT;
ARNC0TRSTP_typ : STRUCT                                     (* Mode "Stop after trigger" *)
   init                 : USINT ;                           (* Initialized *)
   event                : USINT ;                           (* Event *)
   NOT_USE_1            : ARRAY [0..1] OF USINT ;
   s_rest               : DINT ;                            (* Remaining distance after trigger *)
   trg_source           : ARNC0TRG_typ ;                    (* Trigger Source *)
END_STRUCT;
ARNC0BAMOV_typ : STRUCT                                     (* Basis Movements *)
   init                 : USINT ;                           (* Initialized *)
   reserve0             : ARRAY [0..2] OF USINT ;           (* Reserved *)
   status               : ARNC0BMVST_typ ;                  (* Status *)
   override             : ARNC0BMVOV_typ ;                  (* Override *)
   parameter            : ARNC0BMVPA_typ ;                  (* Parameters *)
   trg_stop             : ARNC0TRSTP_typ ;                  (* Mode "Stop after trigger" *)
END_STRUCT;
ARNC0AXMOV_typ : STRUCT                                     (* Axis Movement *)
   mode                 : UINT ;                            (* Mode *)
   detail               : UINT ;                            (* Detail *)
   stop                 : ARNC0AXSTO_typ ;                  (* Stop Movement *)
   homing               : ARNC0HOME_typ ;                   (* Homing procedure *)
   basis                : ARNC0BAMOV_typ ;                  (* Basis movements *)
END_STRUCT;
ARNC0SUOST_typ : STRUCT                                     (* Status *)
   ident                : UDINT ;                           (* Ident of data object *)
   ok                   : USINT ;                           (* Operation complete *)
   error                : USINT ;                           (* Error *)
   reserve1             : USINT ;                           (* Reserved *)
   reserve2             : USINT ;                           (* Reserved *)
END_STRUCT;
ARNC0SUOPA_typ : STRUCT                                     (* Parameters *)
   name                 : ARRAY [0..11] OF USINT ;          (* Name of data object *)
END_STRUCT;
ARNC0SUOBJ_typ : STRUCT                                     (* Data object *)
   status               : ARNC0SUOST_typ ;                  (* Status *)
   parameter            : ARNC0SUOPA_typ ;                  (* Parameters *)
END_STRUCT;
ARNC0SUMAS_typ : STRUCT                                     (* Status *)
   mode                 : UINT ;                            (* Mode *)
   ok                   : USINT ;                           (* Operation complete *)
   error                : USINT ;                           (* Error *)
   quality              : REAL ;                            (* Quality of parameter identification *)
END_STRUCT;
ARNC0SUMAO_typ : STRUCT                                     (* Optional parameters *)
   z_p                  : USINT ;                           (* Number of polepairs *)
   phase                : USINT ;                           (* Phase *)
   reserve2             : UINT ;                            (* Reserved *)
   u_const              : REAL ;                            (* Voltage constant *)
   v_max                : REAL ;                            (* Maximum speed *)
   trq_0                : REAL ;                            (* Stall  torque *)
   trq_n                : REAL ;                            (* Rated torque *)
   trq_max              : REAL ;                            (* Peak  torque *)
   trq_const            : REAL ;                            (* Torque constant *)
   i_0                  : REAL ;                            (* Stall current *)
   i_max                : REAL ;                            (* Peak current *)
   i_m                  : REAL ;                            (* Magnetizing current *)
   phase_cross_sect     : REAL ;                            (* Cross section of a phase *)
   invcl_a1             : REAL ;                            (* Inverter characteristic: Gain factor *)
   invcl_a2             : REAL ;                            (* Inverter characteristic: Exponent *)
END_STRUCT;
ARNC0SUMAP_typ : STRUCT                                     (* Parameters *)
   mode                 : UINT ;                            (* Mode *)
   reserve              : UINT ;                            (* Reserved *)
   u_n                  : REAL ;                            (* Rated voltage *)
   i_n                  : REAL ;                            (* Rated current *)
   v_n                  : REAL ;                            (* Rated speed *)
   f_n                  : REAL ;                            (* Rated frequency *)
   cos_phi              : REAL ;                            (* Active power factor *)
   t_tripping_therm     : REAL ;                            (* Tripping time at thermal overload *)
   optional             : ARNC0SUMAO_typ ;                  (* Optional parameters *)
END_STRUCT;
ARNC0SUMA_typ : STRUCT                                      (* Induction motor *)
   status               : ARNC0SUMAS_typ ;                  (* Status *)
   parameter            : ARNC0SUMAP_typ ;                  (* Parameters *)
END_STRUCT;
ARNC0SUMSS_typ : STRUCT                                     (* Status *)
   mode                 : UINT ;                            (* Mode *)
   ok                   : USINT ;                           (* Operation complete *)
   error                : USINT ;                           (* Error *)
   quality              : REAL ;                            (* Quality of parameter identification *)
END_STRUCT;
ARNC0SUMSO_typ : STRUCT                                     (* Optional parameters *)
   phase                : USINT ;                           (* Phase *)
   reserve1             : USINT ;                           (* Reserved *)
   reserve2             : UINT ;                            (* Reserved *)
   u_const              : REAL ;                            (* Voltage constant *)
   v_max                : REAL ;                            (* Maximum speed *)
   trq_0                : REAL ;                            (* Stall  torque *)
   trq_const            : REAL ;                            (* Torque constant *)
   i_0                  : REAL ;                            (* Stall current *)
   phase_cross_sect     : REAL ;                            (* Cross section of a phase *)
   invcl_a1             : REAL ;                            (* Inverter characteristic: Gain factor *)
   invcl_a2             : REAL ;                            (* Inverter characteristic: Exponent *)
END_STRUCT;
ARNC0SUMSP_typ : STRUCT                                     (* Parameters *)
   mode                 : UINT ;                            (* Mode *)
   z_p                  : USINT ;                           (* Number of polepairs *)
   reserve              : USINT ;                           (* Reserved *)
   u_n                  : REAL ;                            (* Rated voltage *)
   i_n                  : REAL ;                            (* Rated current *)
   v_n                  : REAL ;                            (* Rated speed *)
   trq_n                : REAL ;                            (* Rated torque *)
   trq_max              : REAL ;                            (* Peak  torque *)
   i_max                : REAL ;                            (* Peak current *)
   t_tripping_therm     : REAL ;                            (* Tripping time at thermal overload *)
   optional             : ARNC0SUMSO_typ ;                  (* Optional parameters *)
END_STRUCT;
ARNC0SUMS_typ : STRUCT                                      (* Synchronous motor *)
   status               : ARNC0SUMSS_typ ;                  (* Status *)
   parameter            : ARNC0SUMSP_typ ;                  (* Parameters *)
END_STRUCT;
ARNC0SUPHS_typ : STRUCT                                     (* Status *)
   mode                 : UINT ;                            (* Mode *)
   ok                   : USINT ;                           (* Operation complete *)
   error                : USINT ;                           (* Error *)
   rho_0                : REAL ;                            (* Commutation offset *)
   z_p                  : USINT ;                           (* Number of polepairs *)
   reserve1             : USINT ;                           (* Reserved *)
   reserve2             : UINT ;                            (* Reserved *)
END_STRUCT;
ARNC0SUPHP_typ : STRUCT                                     (* Parameters *)
   mode                 : UINT ;                            (* Mode *)
   reserve              : UINT ;                            (* Reserved *)
   i                    : REAL ;                            (* Current *)
   t                    : REAL ;                            (* Time *)
END_STRUCT;
ARNC0SUPH_typ : STRUCT                                      (* Motor phasing *)
   status               : ARNC0SUPHS_typ ;                  (* Status *)
   parameter            : ARNC0SUPHP_typ ;                  (* Parameters *)
END_STRUCT;
ARNC0SUCST_typ : STRUCT                                     (* Status *)
   mode                 : UINT ;                            (* Mode *)
   ok                   : USINT ;                           (* Operation complete *)
   error                : USINT ;                           (* Error *)
END_STRUCT;
ARNC0SUCPA_typ : STRUCT                                     (* Parameters *)
   mode                 : UINT ;                            (* Mode *)
   orientation          : USINT ;                           (* Orientation *)
   operating_point      : USINT ;                           (* Operating point *)
   i_max_percent        : REAL ;                            (* Maximum percentage for rated current *)
   v_max_percent        : REAL ;                            (* Maximum percentage for speed limit value *)
   s_max                : DINT ;                            (* Maximum move distance *)
   ds_max               : REAL ;                            (* Maximum lag error *)
   kv_percent           : REAL ;                            (* Percentage for proportional amplification *)
   signal_order         : UDINT ;                           (* Order of excitation signal *)
   kv_max               : REAL ;                            (* Maximum proportional amplification *)
   a                    : REAL ;                            (* Acceleration *)
   signal_type          : UINT ;                            (* Type of the excitation signal *)
   reserve              : UINT ;                            (* Reserved *)
   signal_f_start       : REAL ;                            (* Start frequency of the excitation signal *)
   signal_f_stop        : REAL ;                            (* Stop frequency of the excitation signal *)
   signal_time          : REAL ;                            (* Duration of the excitation signal *)
END_STRUCT;
ARNC0SUCTR_typ : STRUCT                                     (* Controller *)
   status               : ARNC0SUCST_typ ;                  (* Status *)
   parameter            : ARNC0SUCPA_typ ;                  (* Parameters *)
END_STRUCT;
ARNC0SUIRS_typ : STRUCT                                     (* Status *)
   mode                 : UINT ;                            (* Mode *)
   ok                   : USINT ;                           (* Operation complete *)
   error                : USINT ;                           (* Error *)
   quality              : REAL ;                            (* Quality of parameter identification *)
END_STRUCT;
ARNC0SUIRP_typ : STRUCT                                     (* Parameters *)
   mode                 : UINT ;                            (* Mode *)
   reserve              : USINT ;                           (* Reserved *)
   ref_system           : USINT ;                           (* Reference system *)
   pos_offset           : REAL ;                            (* Position offset *)
   v                    : REAL ;                            (* Speed *)
END_STRUCT;
ARNC0SUIR_typ : STRUCT                                      (* ISQ-Ripple *)
   status               : ARNC0SUIRS_typ ;                  (* Status *)
   parameter            : ARNC0SUIRP_typ ;                  (* Parameters *)
END_STRUCT;
ARNC0SETUP_typ : STRUCT                                     (* Setup *)
   status               : USINT ;                           (* Status *)
   reserve              : USINT ;                           (* Reserved *)
   detail               : UINT ;                            (* Detail *)
   datobj               : ARNC0SUOBJ_typ ;                  (* Data object *)
   motor_induction      : ARNC0SUMA_typ ;                   (* Induction motor *)
   motor_synchron       : ARNC0SUMS_typ ;                   (* Synchronous motor *)
   motor_phasing        : ARNC0SUPH_typ ;                   (* Motor phasing *)
   controller           : ARNC0SUCTR_typ ;                  (* Controller *)
   isq_ripple           : ARNC0SUIR_typ ;                   (* ISQ-Ripple *)
   NOT_USE_1            : ARRAY [0..11] OF USINT ;
END_STRUCT;
ARNC0PLCOPENAX_typ : STRUCT                                 (* PLCopen *)
   PLCopen_AxState      : USINT ;                           (* PLCopen axis state *)
   NOT_USE_1            : ARRAY [0..2] OF USINT ;
END_STRUCT;
ARNC0ACTST_typ : STRUCT                                     (* Status *)
   active               : USINT ;                           (* Active *)
   complete             : USINT ;                           (* Complete *)
   NOT_USE_1            : ARRAY [0..1] OF USINT ;
END_STRUCT;
ARNC0LATCH_typ : STRUCT                                     (* Position latch *)
   status               : ARNC0ACTST_typ ;                  (* Status *)
   position             : DINT ;                            (* Latchposition *)
   position2            : DINT ;                            (* Second latchposition *)
   event                : USINT ;                           (* Event *)
   reserve              : ARRAY [0..2] OF USINT ;           (* Reserved *)
   window               : DINT ;                            (* Latch window *)
   w_position           : DINT ;                            (* Position of the latch window *)
END_STRUCT;
ARNC0POS_L_typ : STRUCT                                     (* Position latches *)
   latch1               : ARNC0LATCH_typ ;                  (* Positioning latch 1 *)
   latch2               : ARNC0LATCH_typ ;                  (* Positioning latch 2 *)
END_STRUCT;
ARNC0CPRST_typ : STRUCT                                     (* Status *)
   active               : USINT ;                           (* Active *)
   index                : USINT ;                           (* Index *)
   cnt_start            : USINT ;                           (* Number of not acknowledged start commands *)
   reserve              : USINT ;                           (* Reserved *)
   curr_prof            : ARRAY [0..11] OF USINT ;          (* Name of current cam profile *)
END_STRUCT;
ARNC0CPRPA_typ : STRUCT                                     (* Parameters *)
   mode                 : USINT ;                           (* Mode *)
   reserve0             : ARRAY [0..2] OF USINT ;           (* Reserved *)
   ma_ax                : UDINT ;                           (* NC object of the master axis *)
   ma_add_ax            : UDINT ;                           (* NC object of the additive axis of the master axis *)
   sl_add_ax            : UDINT ;                           (* NC object of the additive axis of the slave  axis *)
   ma_s_start           : DINT ;                            (* Start position of the master axis *)
   ma_ivstart           : UDINT ;                           (* Start interval of the master axis *)
   ma_add_el            : REAL ;                            (* "Additive" element of the master axis *)
   ma_factor            : REAL ;                            (* Multiplication factor for the master axis *)
   ma_add_fa            : REAL ;                            (* Multiplication factor for the "additive" axis of the master axis *)
   sl_add_el            : REAL ;                            (* "Additive" element of the slave axis *)
   sl_factor            : REAL ;                            (* Multiplication factor for the slave  axis *)
   sl_add_fa            : REAL ;                            (* Multiplication factor for the "additive" axis of the slave axis *)
   factor_set           : USINT ;                           (* Set multiplication factors "ma/sl_factor" *)
   reserve              : ARRAY [0..2] OF USINT ;           (* Reserved *)
   reserve1             : ARRAY [0..5] OF UDINT ;           (* Reserved *)
END_STRUCT;
ARNC0CPRDM_typ : STRUCT                                     (* Data Modules *)
   single               : ARRAY [0..11] OF USINT ;          (* Name of the entry cam profile *)
   cyclic               : ARRAY [0..11] OF USINT ;          (* Name of the cyclic cam profile *)
END_STRUCT;
ARNC0CPINF_typ : STRUCT                                     (* INFO Function *)
   status               : ARNC0ACTST_typ ;                  (* Status *)
   sl_s_rel             : DINT ;                            (* Relative position of slave axis in the cam profile *)
   ma_s_rel             : UDINT ;                           (* Relative position of master axis in the cam profile *)
END_STRUCT;
ARNC0CPRCG_typ : STRUCT                                     (* Compensation Gears *)
   ma_v_max             : REAL ;                            (* Maximum speed of the master axis *)
   ma_s_comp            : DINT ;                            (* Compensation distance of master axis *)
   sl_s_comp            : DINT ;                            (* Compensation distance of slave axis *)
END_STRUCT;
ARNC0CAMPR_typ : STRUCT                                     (* Electronic Cam Profile *)
   status               : ARNC0CPRST_typ ;                  (* Status *)
   parameter            : ARNC0CPRPA_typ ;                  (* Parameters *)
   data_modul           : ARNC0CPRDM_typ ;                  (* Data Modules *)
   info                 : ARNC0CPINF_typ ;                  (* INFO-function *)
   co_gears             : ARNC0CPRCG_typ ;                  (* Compensation gear *)
END_STRUCT;
ARNC0AUTSP_typ : STRUCT                                     (* Parameters *)
   index                : USINT ;                           (* Index *)
   reserve              : ARRAY [0..2] OF USINT ;           (* Reserved *)
END_STRUCT;
ARNC0AUTST_typ : STRUCT                                     (* Status *)
   init                 : USINT ;                           (* Initialized *)
   active               : USINT ;                           (* Active *)
   st_type              : USINT ;                           (* Type of the actual state *)
   st_index             : USINT ;                           (* Index of the actual state *)
   cam_prof             : ARNC0AUTSP_typ ;                  (* Cam profile *)
END_STRUCT;
ARNC0AUTID_typ : STRUCT                                     (* INIT State *)
   st_type              : USINT ;                           (* Type of the state to initialize *)
   st_index             : USINT ;                           (* Type of the state to initialize *)
   NOT_USE_1            : ARRAY [0..1] OF USINT ;
END_STRUCT;
ARNC0AUTCC_typ : STRUCT                                     (* Coupling Configuration *)
   ma_ax                : UDINT ;                           (* NC object of the master axis *)
   ma_add_ax            : UDINT ;                           (* NC object of the additive axis of the master axis *)
   sl_add_ax            : UDINT ;                           (* NC object of the additive axis of the slave  axis *)
END_STRUCT;
ARNC0AUTGL_typ : STRUCT                                     (* Global Parameters *)
   ma_add_el            : REAL ;                            (* "Additive" element of the master axis *)
   sl_add_el            : REAL ;                            (* "Additive" element of the slave axis *)
END_STRUCT;
ARNC0AUTEB_typ : STRUCT                                     (* Events for basis state *)
   type                 : USINT ;                           (* Type *)
   NOT_USE_1            : ARRAY [0..2] OF USINT ;
   trg_source           : ARNC0TRG_typ ;                    (* Trigger Source *)
   attribute            : USINT ;                           (* Attribute *)
   st_type              : USINT ;                           (* Type of the next state *)
   st_index             : USINT ;                           (* Index  of the next state *)
   NOT_USE_2            : USINT ;
END_STRUCT;
ARNC0AUTBA_typ : STRUCT                                     (* Basis State *)
   ma_s_start           : DINT ;                            (* Start position of the master axis *)
   ma_ivstart           : UDINT ;                           (* Start interval of the master axis *)
   event                : ARRAY [0..5] OF ARNC0AUTEB_typ ;  (* Event *)
END_STRUCT;
ARNC0AUTCG_typ : STRUCT                                     (* Compensation Gears *)
   ma_v_max             : REAL ;                            (* Maximum speed of the master axis *)
   ma_s_rel             : DINT ;                            (* Relative distance of the master axis *)
   sl_s_rel             : DINT ;                            (* Relative distance of the slave axis *)
   ma_s_min             : DINT ;                            (* Minimum distance of the master axis *)
   mode                 : USINT ;                           (* Mode *)
   reserve              : ARRAY [0..2] OF USINT ;           (* Reserved *)
END_STRUCT;
ARNC0AUTCP_typ : STRUCT                                     (* Cam Profile *)
   name                 : ARRAY [0..11] OF USINT ;          (* Name of the NC data module *)
   ma_factor            : REAL ;                            (* Multiplication factor for the master axis *)
   sl_factor            : REAL ;                            (* Multiplication factor for the slave  axis *)
END_STRUCT;
ARNC0AUTER_typ : STRUCT                                     (* Events for automat states *)
   type                 : USINT ;                           (* Type *)
   NOT_USE_1            : ARRAY [0..2] OF USINT ;
   trg_source           : ARNC0TRG_typ ;                    (* Trigger Source *)
   attribute            : USINT ;                           (* Attribute *)
   st_type              : USINT ;                           (* Type of the next state *)
   st_index             : USINT ;                           (* Index  of the next state *)
   NOT_USE_2            : USINT ;
END_STRUCT;
ARNC0AUTSC_typ : STRUCT                                     (* States *)
   count                : UINT ;                            (* Count *)
   NOT_USE_1            : ARRAY [0..1] OF USINT ;
   co_gears             : ARNC0AUTCG_typ ;                  (* Compensation gear *)
   cam_prof             : ARNC0AUTCP_typ ;                  (* Cam profile *)
   event                : ARRAY [0..5] OF ARNC0AUTER_typ ;  (* Event *)
END_STRUCT;
ARNC0AUTOM_typ : STRUCT                                     (* Cam Profile Automat *)
   status               : ARNC0AUTST_typ ;                  (* Status *)
   signal1              : USINT ;                           (* Signal 1 from the PLC to the cam profile automat *)
   signal2              : USINT ;                           (* Signal 2 from the PLC to the cam profile automat *)
   signal3              : USINT ;                           (* Signal 3 from the PLC to the cam profile automat *)
   signal4              : USINT ;                           (* Signal 4 from the PLC to the cam profile automat *)
   init_stat            : ARNC0AUTID_typ ;                  (* INIT State (for INIT of a certain state) *)
   coupling             : ARNC0AUTCC_typ ;                  (* Coupling configuration *)
   global               : ARNC0AUTGL_typ ;                  (* Global Parameters *)
   basis                : ARNC0AUTBA_typ ;                  (* Basis state *)
   state                : ARRAY [0..5] OF ARNC0AUTSC_typ ;  (* State *)
END_STRUCT;
ARNC0AXCMPST_typ : STRUCT                                   (* Status *)
   init                 : USINT ;                           (* Initialized *)
   mode                 : USINT ;                           (* Mode *)
   reserve0             : UINT ;                            (* Reserved *)
END_STRUCT;
ARNC0AXCMPSSE_typ : STRUCT                                  (* Slope error compensation *)
   data_modul1          : ARRAY [0..11] OF USINT ;          (* Name of data module 1 *)
   data_modul2          : ARRAY [0..11] OF USINT ;          (* Name of data module 2 *)
   set_factor           : REAL ;                            (* Multiplication factor for set values *)
   corr_factor          : REAL ;                            (* Multiplication factor for corrected values *)
   start_offset         : REAL ;                            (* Start offset *)
END_STRUCT;
ARNC0AXCMPBL_typ : STRUCT                                   (* Backlash compensation *)
   s_init               : REAL ;                            (* Initial relative movement to mesh *)
   s                    : REAL ;                            (* Backlash *)
   v                    : REAL ;                            (* Velocity *)
   a                    : REAL ;                            (* Acceleration *)
END_STRUCT;
ARNC0AXCMPPA_typ : STRUCT                                   (* Compensation parameter *)
   mode                 : USINT ;                           (* Mode *)
   reserve0             : ARRAY [0..2] OF USINT ;           (* Reserved *)
   slope                : ARNC0AXCMPSSE_typ ;               (* Slope error compensation *)
   backlash             : ARNC0AXCMPBL_typ ;                (* Backlash compensation *)
END_STRUCT;
ARNC0AXCMP_typ : STRUCT                                     (* Axis Compensation *)
   status               : ARNC0AXCMPST_typ ;                (* Status *)
   parameter            : ARNC0AXCMPPA_typ ;                (* Parameters *)
END_STRUCT;
ARNC0AXMOV2_typ : STRUCT                                    (* Extended Axis movement *)
   cam_prof             : ARNC0CAMPR_typ ;                  (* Cam profile *)
   automat              : ARNC0AUTOM_typ ;                  (* Cam profile automat *)
   compensation         : ARNC0AXCMP_typ ;                  (* Compensation of axis errors *)
END_STRUCT;
ARNC0AXMOS_typ : STRUCT                                     (* Status Bits *)
   ds_warning           : USINT ;                           (* Lag error greater than "limit.ds_warning" *)
   reserve              : ARRAY [0..2] OF USINT ;           (* Reserved *)
END_STRUCT;
ARNC0AXMON_typ : STRUCT                                     (* Axis monitor *)
   s_act                : DINT ;                            (* Actual position *)
   s_set                : DINT ;                            (* Set position *)
   s_set_comp           : REAL ;                            (* Compensated set position *)
   v_set                : REAL ;                            (* Set speed *)
   v_set_comp           : REAL ;                            (* Compensated set speed *)
   status               : ARNC0AXMOS_typ ;                  (* Status bits *)
   reserve0             : ARRAY [0..2] OF UDINT ;           (* Reserved *)
END_STRUCT;
ARNC0MSSTA_typ : STRUCT                                     (* Status *)
   err_cl0              : USINT ;                           (* Error class 0 *)
   NOT_USE_1            : ARRAY [0..2] OF USINT ;
END_STRUCT;
ARNC0MSCNT_typ : STRUCT                                     (* Number of not acknowledged messages *)
   error                : UINT ;                            (* Count of not acknowledged errors *)
   NOT_USE_1            : ARRAY [0..5] OF USINT ;
END_STRUCT;
ARNC0MSREC_typ : STRUCT                                     (* Current message record *)
   number               : UDINT ;                           (* Number *)
   info                 : ARRAY [0..11] OF USINT ;          (* Additional Info *)
   NOT_USE_1            : ARRAY [0..1] OF USINT ;
   errorclass           : UINT ;                            (* Error class *)
   reserve              : UDINT ;                           (* Reserved *)
END_STRUCT;
ARNC0MTXST_typ : STRUCT                                     (* Status of text determination *)
   lines                : UINT ;                            (* Lines of the determined text *)
   error                : UINT ;                            (* Error *)
END_STRUCT;
ARNC0MTXPA_typ : STRUCT                                     (* Parameters for text determination *)
   format               : UINT ;                            (* Format *)
   columns              : UINT ;                            (* Number of columns per line *)
   data_modul           : ARRAY [0..11] OF USINT ;          (* Name of the data module *)
   data_len             : UINT ;                            (* Length of data buffer in application program *)
   reserve              : UINT ;                            (* Reserved *)
   data_adr             : UDINT ;                           (* Address of data buffer in application program *)
END_STRUCT;
ARNC0MSTXT_typ : STRUCT                                     (* Text determination for current message record *)
   status               : ARNC0MTXST_typ ;                  (* Status *)
   parameter            : ARNC0MTXPA_typ ;                  (* Parameters *)
END_STRUCT;
ARNC0MSG_typ : STRUCT                                       (* Messages *)
   status               : ARNC0MSSTA_typ ;                  (* Status *)
   count                : ARNC0MSCNT_typ ;                  (* Count of not acknowledged messages *)
   record               : ARNC0MSREC_typ ;                  (* Current message record *)
   text                 : ARNC0MSTXT_typ ;                  (* Text determination for current message record *)
END_STRUCT;
ARNC0NCTST_typ : STRUCT                                     (* NC Test *)
   Open_UseApplNcObj    : USINT ;                           (* Open test: Use the same NC object as the application *)
   Close_NoMoveAbort    : USINT ;                           (* Close test: No move abortion *)
   reserve1             : USINT ;                           (* Reserved *)
   reserve2             : USINT ;                           (* Reserved *)
END_STRUCT;
ARNC0AXIS_typ : STRUCT                                      (* ARNC0 - Axis *)
   NOT_USE_1            : ARRAY [0..5] OF USINT ;
   size                 : UINT ;                            (* Size of the corresponding NC manager data type *)
   sw_version           : ARNC0SWVER_typ ;                  (* Software Version ID *)
   nc_obj_inf           : ARNC0OBINF_typ ;                  (* NC Object Information *)
   simulation           : ARNC0AXSIM_typ ;                  (* Simulation Mode *)
   global               : ARNC0GLINI_typ ;                  (* Global Parameters *)
   network              : ARNC0NETAX_typ ;                  (* Network *)
   datblock             : ARNC0AXDBL_typ ;                  (* Data block operation *)
   dig_in               : ARNC0DIGIN_typ ;                  (* Digital Inputs *)
   encoder_if           : ARNC0ENCIF_typ ;                  (* Encoder Interface *)
   limit                : ARNC0AXLIM_typ ;                  (* Limit value *)
   controller           : ARNC0CTRL_typ ;                   (* Controller *)
   move                 : ARNC0AXMOV_typ ;                  (* Axis movement *)
   setup                : ARNC0SETUP_typ ;                  (* Setup *)
   NOT_USE_2            : ARRAY [0..119] OF USINT ;
   PLCopen_MC           : ARNC0PLCOPENAX_typ ;              (* PLCopen for Motion Components *)
   pos_latch            : ARNC0POS_L_typ ;                  (* Positioning latch *)
   move2                : ARNC0AXMOV2_typ ;                 (* Extended axis movement *)
   monitor              : ARNC0AXMON_typ ;                  (* Monitor *)
   message              : ARNC0MSG_typ ;                    (* Messages (errors, warnings) *)
   nc_test              : ARNC0NCTST_typ ;                  (* NC Test *)
   NOT_USE_3            : ARRAY [0..47] OF USINT ;
END_STRUCT;
ARNC0CNCSIM_typ : STRUCT                                    (* Simulation mode *)
   status               : USINT ;                           (* Status *)
   reserve              : ARRAY [0..2] OF USINT ;           (* Reserved *)
END_STRUCT;
ARNC0ACCADEX_typ : STRUCT                                   (* Reference Address *)
   access_adr           : UDINT ;                           (* Address for "access" *)
END_STRUCT;
ARNC0NCLIM_typ : STRUCT                                     (* CNC limits *)
   init                 : USINT ;                           (* Initialization complete *)
   reserve              : ARRAY [0..2] OF USINT ;           (* Reserved *)
   v                    : REAL ;                            (* Velocity *)
   a_pos                : REAL ;                            (* Positive acceleration *)
   a_neg                : REAL ;                            (* Negative acceleration *)
   t_jolt               : REAL ;                            (* Jolt time *)
   blocktransition      : USINT ;                           (* Mode for block transitions *)
   reserve0             : ARRAY [0..2] OF USINT ;           (* Reserved *)
   v_jump               : REAL ;                            (* Speed jump *)
   a_jump               : REAL ;                            (* Acceleration jump *)
   v_jump_t             : REAL ;                            (* Speed jump for tangential axis *)
   s_jump_t             : REAL ;                            (* Tangential deviation for subsequent path elements *)
   s_sync1_t            : UINT ;                            (* Synchrone M-Function at end of path element *)
   s_sync2_t            : UINT ;                            (* Synchrone M-Function at beginn of path element *)
   radius_err           : REAL ;                            (* Error of radius *)
   block_buffer         : UDINT ;                           (* Block buffer for backtracing the CNC path *)
   elements             : UINT ;                            (* Calculated elements before starting *)
   lookahead            : UINT ;                            (* Size of lookahead buffer *)
   halt                 : USINT ;                           (* Stop at passing beyond the submission values *)
   reserve1             : ARRAY [0..2] OF USINT ;           (* Reserved *)
   filter_err           : REAL ;                            (* Maximum contour error caused by "axis[i],t_axfilter" *)
   filter_err_trans     : REAL ;                            (* Maximum contour error at block transition caused by "axis[i],t_axfilter" *)
   plot                 : ARNC0ACCADEX_typ ;                (* Plot buffer *)
   dynamic              : ARNC0ACCADEX_typ ;                (* Dynamic buffer *)
END_STRUCT;
ARNC0SKPLM_typ : STRUCT                                     (* Interpreter skip level *)
   level_0              : USINT ;                           (* Skip level 0 *)
   level_1              : USINT ;                           (* Skip level 1 *)
   level_2              : USINT ;                           (* Skip level 2 *)
   level_3              : USINT ;                           (* Skip level 3 *)
   level_4              : USINT ;                           (* Skip level 4 *)
   level_5              : USINT ;                           (* Skip level 5 *)
   level_6              : USINT ;                           (* Skip level 6 *)
   level_7              : USINT ;                           (* Skip level 7 *)
   level_8              : USINT ;                           (* Skip level 8 *)
   level_9              : USINT ;                           (* Skip level 9 *)
   reserve0             : ARRAY [0..1] OF USINT ;           (* Reserved *)
END_STRUCT;
ARNC0NCMST_typ : STRUCT                                     (* Status CNC movement *)
   cnt_ncprog           : UINT ;                            (* Number of started CNC programs/blocks *)
   halt                 : USINT ;                           (* State "halt" *)
   halt_info            : USINT ;                           (* INFO aboute cause of "Halt" state *)
   m1_stop              : USINT ;                           (* Operating mode "Stop at M1" *)
   single_s             : USINT ;                           (* Operating mode "Single step" *)
   skip_fcn             : USINT ;                           (* Operating mode "Skip Function" *)
   dpr_ovr              : USINT ;                           (* "normal" override \  DPR-override *)
   skip_level           : ARNC0SKPLM_typ ;                  (* Skip level *)
END_STRUCT;
ARNC0NCSTO_typ : STRUCT                                     (* Stop Movement *)
   decel_ramp           : USINT ;                           (* Deceleration ramp *)
   reserve0             : USINT ;                           (* Reserved *)
   reserve1             : UINT ;                            (* Reserved *)
END_STRUCT;
ARNC0NCESTO_typ : STRUCT                                    (* Emergency Stop *)
   path                 : USINT ;                           (* Path behaviour *)
   reserve0             : USINT ;                           (* Reserved *)
   reserve1             : UINT ;                            (* Reserved *)
END_STRUCT;
ARNC0NCPRG_typ : STRUCT                                     (* CNC program *)
   name                 : ARRAY [0..99] OF USINT ;          (* Name of the NC data module *)
   init_prg             : ARRAY [0..99] OF USINT ;          (* Name of initial CNC program *)
   start_pos_type       : USINT ;                           (* Type of start position *)
   start_mode           : USINT ;                           (* Start mode for CNC program *)
   NOT_USE_1            : USINT ;
   delete_mode          : USINT ;                           (* Mode for deleting a CNC program *)
   start_pos            : DINT ;                            (* Starting position *)
   restart_type         : USINT ;                           (* Type of restart point *)
   reserve1             : ARRAY [0..2] OF USINT ;           (* Reserved *)
   block_ncprog         : UDINT ;                           (* Block number in CNC program *)
   offset_ncprog        : UDINT ;                           (* Offset (Byte) in current CNC program *)
   s_ncprog             : REAL ;                            (* Path position in current CNC program *)
   s_start              : ARRAY [0..14] OF REAL ;           (* Starting position *)
END_STRUCT;
ARNC0ACCAD_typ : STRUCT                                     (* Address for evaluation with "access" *)
   access_adr           : UDINT ;                           (* Address for "access" *)
END_STRUCT;
ARNC0SSTEP_typ : STRUCT                                     (* Single step *)
   mode                 : USINT ;                           (* Mode *)
   reserve0             : ARRAY [0..2] OF USINT ;           (* Reserved *)
   bit_pattern          : UDINT ;                           (* Bit pattern *)
END_STRUCT;
ARNC0SKPL_typ : STRUCT                                      (* Interpreter skip level *)
   level_0              : USINT ;                           (* Skip level 0 *)
   level_1              : USINT ;                           (* Skip level 1 *)
   level_2              : USINT ;                           (* Skip level 2 *)
   level_3              : USINT ;                           (* Skip level 3 *)
   level_4              : USINT ;                           (* Skip level 4 *)
   level_5              : USINT ;                           (* Skip level 5 *)
   level_6              : USINT ;                           (* Skip level 6 *)
   level_7              : USINT ;                           (* Skip level 7 *)
   level_8              : USINT ;                           (* Skip level 8 *)
   level_9              : USINT ;                           (* Skip level 9 *)
   reserve0             : ARRAY [0..1] OF USINT ;           (* Reserved *)
END_STRUCT;
ARNC0NCMOV_typ : STRUCT                                     (* CNC movement *)
   status               : ARNC0NCMST_typ ;                  (* Status *)
   stop                 : ARNC0NCSTO_typ ;                  (* Stop Movement *)
   e_stop               : ARNC0NCESTO_typ ;                 (* Emergency stop *)
   override             : INT ;                             (* Override *)
   R_override           : UINT ;                            (* Rapid override affects CNC path *)
   F_override           : UDINT ;                           (* Feedrate override affects CNC path *)
   ncprogram            : ARNC0NCPRG_typ ;                  (* NC program *)
   ncblock              : ARRAY [0..51] OF USINT ;          (* NC block *)
   dpr_ovr              : ARNC0ACCAD_typ ;                  (* "normal" override \  DPR-override *)
   dpr_if               : ARNC0ACCAD_typ ;                  (* DPR-interface *)
   single_s             : ARNC0SSTEP_typ ;                  (* Operating mode "Single step" *)
   skip_level           : ARNC0SKPL_typ ;                   (* Skip level *)
END_STRUCT;
ARNC0NCDST_typ : STRUCT                                     (* CNC decoder status *)
   halt                 : USINT ;                           (* State "halt" *)
   sync                 : USINT ;                           (* State "Waiting for SYNC" *)
   breakpt_halt         : USINT ;                           (* State "Halt at breakpoint" *)
   single_s_halt        : USINT ;                           (* State "Halt in single step mode" *)
   single_s             : UINT ;                            (* Operating mode "Single step" *)
   reserve              : UINT ;                            (* Reserved *)
   program_load         : UINT ;                            (* Status of 'program load' *)
   program_unload       : UINT ;                            (* Status of 'program unload' *)
   mp_log               : USINT ;                           (* Motion packet log *)
   reserve1             : ARRAY [0..2] OF USINT ;           (* Reserved *)
END_STRUCT;
ARNC0DCHLTINFO_typ : STRUCT                                 (* Interpreter halt info (e.g. breakpoint, single step) *)
   file_name            : ARRAY [0..99] OF USINT ;          (* File name *)
   program_name         : ARRAY [0..99] OF USINT ;          (* Program name *)
   subprog_name         : ARRAY [0..99] OF USINT ;          (* Sub program name *)
   line_nr              : UDINT ;                           (* Line number *)
   block_nr             : UDINT ;                           (* Block number *)
END_STRUCT;
ARNC0DCCDC_typ : STRUCT                                     (* Cutting Diameter Correction *)
   side                 : USINT ;                           (* Processing side Cutting Diameter Compensation *)
   entry                : USINT ;                           (* Select/deselect Cutting Diameter Compensation *)
   circ_transition      : USINT ;                           (* Insert Circular Transitions *)
   circ_replace         : USINT ;                           (* Replace arc with straight line *)
   contour_violation    : USINT ;                           (* Accept contour violations *)
   intersection_path    : USINT ;                           (* Additional intersection path calculation *)
   NOT_USE_1            : ARRAY [0..1] OF USINT ;
   feedrate             : UDINT ;                           (* Feedrate on Transition Circles *)
   v_path_contour       : USINT ;                           (* Feedrate affects CNC path *)
   exit                 : USINT ;                           (* Deselection Mode Cutting Diameter Compensation *)
   NOT_USE_2            : ARRAY [0..1] OF USINT ;
END_STRUCT;
ARNC0DCPAR_typ : STRUCT                                     (* CNC decoder parameter *)
   move_cmd             : USINT ;                           (* Movement command *)
   plane                : USINT ;                           (* Plane *)
   co_ords              : USINT ;                           (* Co-ordinate definition *)
   center               : USINT ;                           (* Center point definition *)
   v_path               : UDINT ;                           (* Path speed *)
   cdc                  : ARNC0DCCDC_typ ;                  (* Tool radius correction *)
   t_ax_period          : USINT ;                           (* Operating mode for  tangential axis *)
   system_unit          : USINT ;                           (* Measurement unit for CNC system *)
   v_path_mode          : USINT ;                           (* Mode for feed rate calculation *)
   reserve1             : USINT ;                           (* Reserved *)
   rot_pref_dir         : USINT ;                           (* Preferable direction of rotary axes *)
   limit_switch_mode    : USINT ;                           (* Mode for axis limit switch *)
   reserve0             : ARRAY [0..1] OF USINT ;           (* Reserved *)
END_STRUCT;
ARNC0DCDMO_typ : STRUCT                                     (* CNC decoder datamodule *)
   status               : ARNC0ACTST_typ ;                  (* Status *)
   zero_tab             : ARRAY [0..11] OF USINT ;          (* Data module name of zero point offset table *)
   tool_tab             : ARRAY [0..11] OF USINT ;          (* Data module name of tool data table *)
   rpar_tab             : ARRAY [0..11] OF USINT ;          (* Data module name of R parameter  table *)
END_STRUCT;
ARNC0R_PAR_typ : STRUCT                                     (* CNC decorder R-parameters *)
   status               : ARNC0ACTST_typ ;                  (* Status *)
   index                : UINT ;                            (* Index *)
   NOT_USE_1            : ARRAY [0..1] OF USINT ;
   value                : REAL ;                            (* R-Parameter-Value *)
END_STRUCT;
ARNC0DCSST_typ : STRUCT                                     (* Step mode debugger *)
   mode                 : UINT ;                            (* Mode *)
   number               : UINT ;                            (* Number of blocks to halt after *)
END_STRUCT;
ARNC0DCBRKPT_typ : STRUCT                                   (* Set Breakpoint *)
   file_name            : ARRAY [0..99] OF USINT ;          (* File name *)
   program_name         : ARRAY [0..99] OF USINT ;          (* Program name *)
   block_nr             : UDINT ;                           (* Block number *)
   line_nr              : UDINT ;                           (* Line number *)
END_STRUCT;
ARNC0DCBRKINFO_typ : STRUCT                                 (* Breakpoint info *)
   total_nr             : UDINT ;                           (* Total number of currently set breakpoints *)
   breakpoint_set       : ARRAY [0..4] OF ARNC0DCBRKPT_typ ;  (* Info to currently set breakpoints *)
END_STRUCT;
ARNC0DCBRKPAR_typ : STRUCT                                  (* Breakpoint Parameter *)
   file_name            : ARRAY [0..99] OF USINT ;          (* File name *)
   pos_type             : UDINT ;                           (* Type of break point *)
   position             : UDINT ;                           (* Block or line number *)
   break_count          : UDINT ;                           (* Halt on n’th hit *)
END_STRUCT;
ARNC0DCBRK_typ : STRUCT                                     (* Breakpoint *)
   status               : ARNC0ACTST_typ ;                  (* Status *)
   info                 : ARNC0DCBRKINFO_typ ;              (* INFO-function *)
   parameter            : ARNC0DCBRKPAR_typ ;               (* Parameters *)
END_STRUCT;
ARNC0DCEXPR_typ : STRUCT                                    (* Expression *)
   status               : ARNC0ACTST_typ ;                  (* Status *)
   query                : ARRAY [0..63] OF USINT ;          (* Variable/expression to evaluate *)
   result               : ARRAY [0..63] OF USINT ;          (* Result *)
END_STRUCT;
ARNC0DCVACCINFO_typ : STRUCT                                (* Info for access to variables *)
   address              : UDINT ;                           (* Access address to interpreter variable *)
   length               : UDINT ;                           (* Variable size (total number of byte) *)
   array_dim1           : UDINT ;                           (* First array dimension *)
   array_dim2           : UDINT ;                           (* Second array dimension *)
   data_type            : UINT ;                            (* Data type (see AS library “sys_lib”) *)
   scope                : UINT ;                            (* Variable scope *)
   synch_type           : UINT ;                            (* Synchronization type *)
   reserve0             : UINT ;                            (* Reserved *)
END_STRUCT;
ARNC0RVARACC_typ : STRUCT                                   (* Access to variables *)
   status               : ARNC0ACTST_typ ;                  (* Status *)
   name                 : ARRAY [0..31] OF USINT ;          (* Name of variable *)
   info                 : ARNC0DCVACCINFO_typ ;             (* INFO-function *)
END_STRUCT;
ARNC0NCDEC_typ : STRUCT                                     (* CNC decoder *)
   init                 : USINT ;                           (* Initialization complete *)
   reserve              : ARRAY [0..2] OF USINT ;           (* Reserved *)
   status               : ARNC0NCDST_typ ;                  (* Status *)
   halt_info            : ARNC0DCHLTINFO_typ ;              (* INFO aboute cause of "Halt" state *)
   parameter            : ARNC0DCPAR_typ ;                  (* Parameters *)
   data_modul           : ARNC0DCDMO_typ ;                  (* Data Modules *)
   r_param              : ARNC0R_PAR_typ ;                  (* R-parameter *)
   s_step               : ARNC0DCSST_typ ;                  (* Interpreter single step mode *)
   breakpoint           : ARNC0DCBRK_typ ;                  (* Breakpoints in CNC program *)
   expression           : ARNC0DCEXPR_typ ;                 (* Variable/Expression watch and force function *)
   var_access           : ARNC0RVARACC_typ ;                (* Direct access to Interpreter Variables *)
END_STRUCT;
ARNC0NCAXST_typ : STRUCT                                    (* Status *)
   add_par_id           : UINT ;                            (* Parameter ID of the additive element for the cyclic set position *)
   reserve              : ARRAY [0..1] OF USINT ;           (* Reserved *)
END_STRUCT;
ARNC0TRC_typ : STRUCT                                       (* Trigger Configuration *)
   trigger1_pos         : USINT ;                           (* Trigger1: Positive edge *)
   trigger1_neg         : USINT ;                           (* Trigger1: Negative edge *)
   trigger2_pos         : USINT ;                           (* Trigger2: Positive edge *)
   trigger2_neg         : USINT ;                           (* Trigger2: Negative edge *)
END_STRUCT;
ARNC0NCTRG_typ : STRUCT                                     (* Source for Hardware Trigger *)
   nc_object            : UDINT ;                           (* NC object or ncOFF *)
   nc_object_plcopen    : UDINT ;                           (* NC object or ncOFF *)
   NOT_USE_1            : ARRAY [0..3] OF USINT ;
   trg_conf             : ARNC0TRC_typ ;                    (* Trigger Configuration *)
END_STRUCT;
ARNC0NCAXSSE_typ : STRUCT                                   (* Axes error compensation *)
   active               : USINT ;                           (* Active *)
   reserve              : ARRAY [0..2] OF USINT ;           (* Reserved *)
   cmp_data             : ARNC0ACCADEX_typ ;                (* Compensation data *)
END_STRUCT;
ARNC0NCAXP_typ : STRUCT                                     (* CNC-axis settings *)
   NOT_USE_1            : ARRAY [0..71] OF USINT ;
   status               : ARNC0NCAXST_typ ;                 (* Status *)
   nc_object            : UDINT ;                           (* NC object or ncOFF *)
   nc_object_plcopen    : UDINT ;                           (* NC object or ncOFF *)
   name                 : ARRAY [0..13] OF USINT ;          (* Name of the axis in the CNC program *)
   reserve3             : ARRAY [0..1] OF USINT ;           (* Reserved *)
   type                 : UDINT ;                           (* Type *)
   ipl_mode             : USINT ;                           (* Interpolation mode *)
   reserve4             : ARRAY [0..2] OF USINT ;           (* Reserved *)
   unitfactor           : REAL ;                            (* Multiplication factor of the units *)
   t_axfilter           : REAL ;                            (* Filter time for axis jolt filter *)
   drive_axfilter       : USINT ;                           (* Axis jolt filter on the drive during CNC movement *)
   reserve2             : ARRAY [0..2] OF USINT ;           (* Reserved *)
   rot_period           : REAL ;                            (* Period of rotary axis *)
   rot_offset           : REAL ;                            (* Start of period for rotary axis *)
   add_par_id           : UINT ;                            (* Parameter ID of the additive element for the cyclic set position *)
   reserve5             : ARRAY [0..1] OF USINT ;           (* Reserved *)
   trg_source           : ARNC0NCTRG_typ ;                  (* Trigger Source *)
   ax_compensation      : ARNC0NCAXSSE_typ ;                (* Axis error compensatioin *)
END_STRUCT;
ARNC0NCEXAXP_typ : STRUCT                                   (* External CNC axis parameters *)
   nc_object            : ARRAY [0..14] OF UDINT ;          (* NC object or ncOFF *)
END_STRUCT;
ARNC0NCAXCMP_typ : STRUCT                                   (* Compensation parameter for Cartesian axes *)
   matrix_el            : ARRAY [0..8] OF REAL ;            (* Element of compensation matrix *)
END_STRUCT;
ARNC0NCAXTRF_typ : STRUCT                                   (* Kinematic transformation parameters *)
   name                 : ARRAY [0..99] OF USINT ;          (* Name of the NC data module *)
   trf_full             : USINT ;                           (* Full kinematic transformation *)
   trf_type             : USINT ;                           (* Type of kinematic transformation *)
   reserve0             : ARRAY [0..1] OF USINT ;           (* Reserved *)
   axes_tcp             : ARRAY [0..11] OF USINT ;          (* Index of path axes *)
   axes_joint           : ARRAY [0..11] OF USINT ;          (* Index of joint axes *)
   axes_frame           : ARRAY [0..5] OF USINT ;           (* Index of frame axis [dx, dy, dz, phi, theta, psi] *)
   reserve1             : ARRAY [0..1] OF USINT ;           (* Reserved *)
   tcp_add_el           : ARRAY [0..11] OF REAL ;           (* Additive element of path axes *)
   joint_add_el         : ARRAY [0..11] OF REAL ;           (* Additive element of joint axes *)
   frame_add_el         : ARRAY [0..5] OF REAL ;            (* Additive element of frame axes *)
   d_full_add_el        : ARRAY [0..5] OF REAL ;            (* Additive element of general tools (D_FULL) *)
   in_pos_tolerance     : REAL ;                            (* Position tolerance for path axes at beginning of a movement *)
END_STRUCT;
ARNC0AXP_ARR_typ : STRUCT                                   (* Datatype for the AXP-array *)
   init                 : USINT ;                           (* Initialization complete *)
   reserve              : ARRAY [0..2] OF USINT ;           (* Reserved *)
   axis                 : ARRAY [0..14] OF ARNC0NCAXP_typ ;  (* NC axis *)
   ext_ax_parameter     : ARNC0NCEXAXP_typ ;                (* External CNC axis parameters *)
   compensation         : ARNC0NCAXCMP_typ ;                (* Compensation parameter for Cartesian axes *)
   transformation       : ARNC0NCAXTRF_typ ;                (* Kinematic Transformation *)
END_STRUCT;
ARNC0PLCPA_typ : STRUCT                                     (* CNC-PLC parameters *)
   t_fcn_init           : USINT ;                           (* Initialize T function with CNC-Reset *)
   s_fcn_init           : USINT ;                           (* Initialize S function with CNC-Reset *)
   first_M              : UINT ;                            (* Index of first M function without synchronization *)
   last_M               : UINT ;                            (* Index of last M function without synchronization *)
   first_M_S            : UINT ;                            (* Index of first M function with synchronization *)
   last_M_S             : UINT ;                            (* Index of last M function with synchronization *)
   NOT_USE_1            : ARRAY [0..1] OF USINT ;
END_STRUCT;
ARNC0PLCDA_typ : STRUCT                                     (* CNC-PLC data *)
   t_funct              : UINT ;                            (* T function value *)
   NOT_USE_1            : ARRAY [0..1] OF USINT ;
   s_funct              : ARRAY [0..3] OF UDINT ;           (* S function values *)
   m_funct              : ARRAY [0..1023] OF USINT ;        (* Display for "Execute M Function" *)
END_STRUCT;
ARNC0EXP_typ : STRUCT                                       (* External CNC-PLC parameters *)
   status               : USINT ;                           (* Status *)
   reserve              : ARRAY [0..2] OF USINT ;           (* Reserved *)
   access_adr           : UDINT ;                           (* Address for "access" *)
END_STRUCT;
ARNC0NCPLC_typ : STRUCT                                     (* CNC-PLC data *)
   init                 : USINT ;                           (* Initialization complete *)
   reserve              : ARRAY [0..2] OF USINT ;           (* Reserved *)
   parameter            : ARNC0PLCPA_typ ;                  (* Parameters *)
   data                 : ARNC0PLCDA_typ ;                  (* Data *)
   ex_param             : ARNC0EXP_typ ;                    (* External parameter *)
   m_param              : ARNC0ACCAD_typ ;                  (* M parameters *)
END_STRUCT;
ARNC0ENST_typ : STRUCT                                      (* Status *)
   enabled              : USINT ;                           (* Enabled *)
   active               : USINT ;                           (* Active *)
   data_valid           : USINT ;                           (* Valid restart data available *)
   data_saved           : USINT ;                           (* Restart data saved (since last program start) *)
END_STRUCT;
ARNC0NCRSR_typ : STRUCT                                     (* Result *)
   name                 : ARRAY [0..99] OF USINT ;          (* Name of the NC data module *)
   init_prg             : ARRAY [0..99] OF USINT ;          (* Name of initial CNC program *)
   start_pos_type       : USINT ;                           (* Type of start position *)
   start_mode           : USINT ;                           (* Start mode for CNC program *)
   reserve              : UINT ;                            (* Reserved *)
   start_pos            : DINT ;                            (* Starting position *)
   restart_type         : USINT ;                           (* Type of restart point *)
   reserve1             : ARRAY [0..2] OF USINT ;           (* Reserved *)
   block_ncprog         : UDINT ;                           (* Block number in CNC program *)
   offset_ncprog        : UDINT ;                           (* Offset (Byte) in current CNC program *)
   line_ncprog          : UDINT ;                           (* Line number in CNC program *)
   s_ncprog             : REAL ;                            (* Path position in current CNC program *)
   s_set                : ARRAY [0..14] OF REAL ;           (* Set position *)
END_STRUCT;
ARNC0NCRSP_typ : STRUCT                                     (* Parameter *)
   restart_type         : USINT ;                           (* Type of restart point *)
   NOT_USE_1            : ARRAY [0..2] OF USINT ;
   block_ncprog         : UDINT ;                           (* Block number in CNC program *)
   offset_ncprog        : UDINT ;                           (* Offset (Byte) in current CNC program *)
   s_ncprog             : REAL ;                            (* Path position in current CNC program *)
END_STRUCT;
ARNC0NCRSI_typ : STRUCT                                     (* INFO-function *)
   status               : ARNC0ACTST_typ ;                  (* Status *)
   result               : ARNC0NCRSR_typ ;                  (* Result *)
   parameter            : ARNC0NCRSP_typ ;                  (* Parameters *)
END_STRUCT;
ARNC0NCRPA_typ : STRUCT                                     (* General restart parameters *)
   param_buffer         : UDINT ;                           (* Buffer size for R- and EX- parameters *)
   trigger_buffer       : UDINT ;                           (* Buffer size for trigger blocks *)
END_STRUCT;
ARNC0NCRST_typ : STRUCT                                     (* Restart of a NC-program *)
   status               : ARNC0ENST_typ ;                   (* Status *)
   info                 : ARNC0NCRSI_typ ;                  (* INFO-function *)
   parameter            : ARNC0NCRPA_typ ;                  (* Parameters *)
END_STRUCT;
ARNC0RDMOD_typ : STRUCT                                     (* Datamodule handling *)
   status               : ARNC0ACTST_typ ;                  (* Status *)
   name                 : ARRAY [0..11] OF USINT ;          (* Name of the NC data module *)
END_STRUCT;
ARNC0NCMNPAR_typ : STRUCT                                   (* CNC monitor parameter *)
   pos_mode             : USINT ;                           (* CNC Position monitor *)
   block_mode           : USINT ;                           (* Blocks display mode *)
   line_nr_mode         : USINT ;                           (* Display line numbers *)
   max_call_level       : USINT ;                           (* Max. call level for extended block numbers *)
   access_adr           : UDINT ;                           (* Address for "access" *)
END_STRUCT;
ARNC0NCMNS_typ : STRUCT                                     (* CNC monitor status *)
   zeropoff             : USINT ;                           (* Mode "Subtract zero point offset from positions" *)
   pos_mode             : USINT ;                           (* CNC Position monitor *)
   NOT_USE_1            : USINT ;
   block_mode           : USINT ;                           (* Blocks display mode *)
   line_nr_mode         : USINT ;                           (* Display line numbers *)
   s_set_valid          : USINT ;                           (* Set positions valid in the CNC monitor *)
   NOT_USE_2            : ARRAY [0..1] OF USINT ;
END_STRUCT;
ARNC0NCMON_typ : STRUCT                                     (* CNC monitor *)
   parameter            : ARNC0NCMNPAR_typ ;                (* Parameters *)
   status               : ARNC0NCMNS_typ ;                  (* Status *)
   s_set                : ARRAY [0..14] OF REAL ;           (* Set position *)
   s_ncblock            : ARRAY [0..14] OF REAL ;           (* Axis distance until end of current NC block *)
   v_path               : REAL ;                            (* Path speed *)
   nr_ncprog            : UDINT ;                           (* Number of current CNC program *)
   name_ncprog          : ARRAY [0..99] OF USINT ;          (* Name of current CNC program *)
   pos_ncprog           : UDINT ;                           (* Position in current CNC program *)
   block_ncprog         : UDINT ;                           (* Block number in CNC program *)
   line_ncprog          : UDINT ;                           (* Line number in CNC program *)
   call_level           : USINT ;                           (* Current call level for sub-programs *)
   reserve1             : ARRAY [0..2] OF USINT ;           (* Reserved *)
   t_ncprog             : REAL ;                            (* Run-Time of current CNC program *)
   s_ncprog             : REAL ;                            (* Path position in current CNC program *)
   v_ncprog             : REAL ;                            (* Path speed currently defined in CNC program *)
   d_full               : ARRAY [0..5] OF REAL ;            (* Active D_FULL data *)
   tool_nr              : UINT ;                            (* Number of active tool data record *)
   zero_idx             : UINT ;                            (* Index of active absolute zero point offset *)
   type_ncblock         : UINT ;                            (* Type of current NC block *)
   PSM_phase            : UINT ;                            (* Path speed mode, phase *)
   t_dwell              : REAL ;                            (* Remaining time for G04 (dwell) *)
   ncblocks             : ARNC0ACCAD_typ ;                  (* Display of CNC blocks *)
   c_transform          : ARNC0ACCAD_typ ;                  (* Transformation matrices for coordinate systems *)
   ip_monitor           : ARNC0ACCAD_typ ;                  (* Interpreter monitor *)
   ext_monitor          : ARNC0ACCAD_typ ;                  (* Extended CNC Monitor *)
END_STRUCT;
ARNC0ERRCL0_typ : STRUCT                                    (* Error class 0 *)
   number               : ARRAY [0..19] OF UDINT ;          (* Number *)
END_STRUCT;
ARNC0CNC_typ : STRUCT                                       (* ARNC0 - CNC-System *)
   NOT_USE_1            : ARRAY [0..3] OF USINT ;
   size                 : UINT ;                            (* Size of the corresponding NC manager data type *)
   reserve0             : UINT ;                            (* Reserved *)
   sw_version           : ARNC0SWVER_typ ;                  (* Software Version ID *)
   nc_obj_inf           : ARNC0OBINF_typ ;                  (* NC Object Information *)
   simulation           : ARNC0CNCSIM_typ ;                 (* Simulation Mode *)
   global               : ARNC0GLINI_typ ;                  (* Global Parameters *)
   limit                : ARNC0NCLIM_typ ;                  (* Limit value *)
   move                 : ARNC0NCMOV_typ ;                  (* Movement *)
   decoder              : ARNC0NCDEC_typ ;                  (* Decoder *)
   axis                 : ARNC0AXP_ARR_typ ;                (* NC axis *)
   cnc_plc              : ARNC0NCPLC_typ ;                  (* CNC-PLC-Data *)
   restart              : ARNC0NCRST_typ ;                  (* RESTART of a CNC program *)
   data_modul           : ARNC0RDMOD_typ ;                  (* Data Modules *)
   monitor              : ARNC0NCMON_typ ;                  (* Monitor *)
   message              : ARNC0MSG_typ ;                    (* Messages (errors, warnings) *)
   err_cl0              : ARNC0ERRCL0_typ ;                 (* Error class 0 *)
   NOT_USE_2            : ARRAY [0..7] OF USINT ;
   nc_test              : ARNC0NCTST_typ ;                  (* NC Test *)
   NOT_USE_3            : ARRAY [0..47] OF USINT ;
END_STRUCT;
ARNC0EXPAR_typ : STRUCT                                     (* External CNC parameters *)
   EXB                  : ARRAY [0..99] OF SINT ;           (* EX(ternal) B(yte)-Parameters *)
   EXW                  : ARRAY [0..99] OF INT ;            (* EX(terne) W(ord)-Parameters *)
   EXL                  : ARRAY [0..99] OF DINT ;           (* EX(terne) L(ong)-Parameters *)
   EXF                  : ARRAY [0..99] OF REAL ;           (* EX(terne) F(loat)-Parameters *)
END_STRUCT;
ARNC0EXESL_typ : STRUCT                                     (* Scaling for the load *)
   units                : UDINT ;                           (* Units at the load *)
   rev_encod            : UDINT ;                           (* Encoder revolutions *)
END_STRUCT;
ARNC0EXESC_typ : STRUCT                                     (* Scaling for encoder interface *)
   load                 : ARNC0EXESL_typ ;                  (* Load *)
END_STRUCT;
ARNC0EXEPA_typ : STRUCT                                     (* Parameters for encoder interface *)
   count_dir            : USINT ;                           (* Count direction *)
   NOT_USE_1            : ARRAY [0..2] OF USINT ;
   scaling              : ARNC0EXESC_typ ;                  (* Scaling *)
END_STRUCT;
ARNC0EXEIF_typ : STRUCT                                     (* Encoder interface *)
   init                 : USINT ;                           (* Encoder interface initialized *)
   NOT_USE_1            : ARRAY [0..2] OF USINT ;
   parameter            : ARNC0EXEPA_typ ;                  (* Parameters *)
END_STRUCT;
ARNC0EXENW_typ : STRUCT                                     (* Network *)
   phase                : USINT ;                           (* Phase *)
   init                 : USINT ;                           (* Network initialized *)
   NOT_USE_1            : ARRAY [0..1] OF USINT ;
END_STRUCT;
ARNC0EXEHST_typ : STRUCT                                    (* Homing Status *)
   ok                   : USINT ;                           (* Reference position valid *)
   NOT_USE_1            : ARRAY [0..2] OF USINT ;
END_STRUCT;
ARNC0EXEHPA_typ : STRUCT                                    (* Homing Parameter *)
   s                    : DINT ;                            (* Reference position *)
   ref_pulse            : USINT ;                           (* Reference pulse *)
   NOT_USE_1            : ARRAY [0..2] OF USINT ;
END_STRUCT;
ARNC0EXEHOM_typ : STRUCT                                    (* Homing *)
   init                 : USINT ;                           (* Homing procedure initialized *)
   NOT_USE_1            : ARRAY [0..2] OF USINT ;
   status               : ARNC0EXEHST_typ ;                 (* Status *)
   parameter            : ARNC0EXEHPA_typ ;                 (* Parameters *)
END_STRUCT;
ARNC0EXEMOV_typ : STRUCT                                    (* Movement *)
   homing               : ARNC0EXEHOM_typ ;                 (* Homing procedure *)
END_STRUCT;
ARNC0EXEPOS_typ : STRUCT                                    (* Filter for actual positions *)
   status               : USINT ;                           (* Status *)
   NOT_USE_1            : ARRAY [0..2] OF USINT ;
   t_filter             : REAL ;                            (* Filter time for extrapolation filter *)
   t_filter2            : REAL ;                            (* Filter time for disturbance filter *)
END_STRUCT;
ARNC0EXMON_typ : STRUCT                                     (* Monitor *)
   s_act                : DINT ;                            (* Actual position *)
   v_act                : REAL ;                            (* Actual speed *)
END_STRUCT;
ARNC0EXTEN_typ : STRUCT                                     (* ARNC0 - External Encoder *)
   NOT_USE_1            : ARRAY [0..3] OF USINT ;
   size                 : UINT ;                            (* Size of the corresponding NC manager data type *)
   NOT_USE_2            : ARRAY [0..1] OF USINT ;
   sw_version           : ARNC0SWVER_typ ;                  (* Software Version ID *)
   nc_obj_inf           : ARNC0OBINF_typ ;                  (* NC Object Information *)
   encoder_if           : ARNC0EXEIF_typ ;                  (* Encoder Interface *)
   network              : ARNC0EXENW_typ ;                  (* Network *)
   move                 : ARNC0EXEMOV_typ ;                 (* Movement *)
   act_pos              : ARNC0EXEPOS_typ ;                 (* Filter for actual position *)
   monitor              : ARNC0EXMON_typ ;                  (* Monitor *)
   message              : ARNC0MSG_typ ;                    (* Messages (errors, warnings) *)
   NOT_USE_3            : ARRAY [0..47] OF USINT ;
END_STRUCT;
ARNC0M_PAR_typ : STRUCT                                     (* CNC M parameters *)
   MW                   : ARRAY [0..99] OF INT ;            (* M-W(ord)-Parameters *)
   ML                   : ARRAY [0..99] OF DINT ;           (* M-L(ong)-Parameters *)
   MF                   : ARRAY [0..99] OF REAL ;           (* M-F(loat)-Parameters *)
END_STRUCT;
ARNC0INIST_typ : STRUCT                                     (* Status *)
   init                 : USINT ;                           (* Network initialized *)
   reserve              : ARRAY [0..2] OF USINT ;           (* Reserved *)
END_STRUCT;
ARNC0NETMO_typ : STRUCT                                     (* Network *)
   status               : ARNC0INIST_typ ;                  (* Status *)
END_STRUCT;
ARNC0DATMO_typ : STRUCT                                     (* Datamodule handling *)
   status               : ARNC0ACTST_typ ;                  (* Status *)
   NOT_USE_1            : USINT ;
   type                 : USINT ;                           (* Type *)
   reserve              : ARRAY [0..1] OF USINT ;           (* Reserved *)
   name                 : ARRAY [0..11] OF USINT ;          (* Name of the NC data module *)
END_STRUCT;
ARNC0TRTRI_typ : STRUCT                                     (* Trace trigger-point *)
   nc_object            : UDINT ;                           (* NC object or ncOFF *)
   type                 : USINT ;                           (* Type of the point *)
   event                : USINT ;                           (* Event *)
   NOT_USE_1            : ARRAY [0..1] OF USINT ;
   threshold            : REAL ;                            (* Threshold *)
END_STRUCT;
ARNC0TRTST_typ : STRUCT                                     (* Trace test-point *)
   nc_object            : UDINT ;                           (* NC object or ncOFF *)
   type                 : USINT ;                           (* Type of the point *)
   reserve              : ARRAY [0..2] OF USINT ;           (* Reserved *)
END_STRUCT;
ARNC0TRACE_typ : STRUCT                                     (* Trace *)
   status               : USINT ;                           (* Status *)
   reserve              : ARRAY [0..2] OF USINT ;           (* Reserved *)
   t_trace              : REAL ;                            (* Recording time *)
   t_sampling           : REAL ;                            (* Sampling time *)
   t_delay              : REAL ;                            (* Time of delay *)
   trigger              : ARNC0TRTRI_typ ;                  (* Trigger *)
   test_dat             : ARRAY [0..9] OF ARNC0TRTST_typ ;  (* Test data *)
   access_adr           : UDINT ;                           (* Address for "access" *)
END_STRUCT;
ARNC0MODUL_typ : STRUCT                                     (* For object-type ncMODUL *)
   NOT_USE_1            : ARRAY [0..3] OF USINT ;
   size                 : UINT ;                            (* Size of the corresponding NC manager data type *)
   reserve0             : UINT ;                            (* Reserved *)
   sw_version           : ARNC0SWVER_typ ;                  (* Software Version ID *)
   nc_obj_inf           : ARNC0OBINF_typ ;                  (* NC Object Information *)
   network              : ARNC0NETMO_typ ;                  (* Network *)
   data_modul           : ARNC0DATMO_typ ;                  (* Data Modules *)
   NOT_USE_2            : ARRAY [0..3] OF USINT ;
   message              : ARNC0MSG_typ ;                    (* Messages (errors, warnings) *)
   command              : ARNC0ACCAD_typ ;                  (* Command interface *)
   response             : ARNC0ACCAD_typ ;                  (* Response interface *)
   usertask             : ARNC0ACCAD_typ ;                  (* UserTask *)
   trace                : ARNC0TRACE_typ ;                  (* Trace *)
   NOT_USE_3            : ARRAY [0..51] OF USINT ;
END_STRUCT;
ARNC0NCCTR_typ : STRUCT                                     (* Transformations coordniate system *)
   handshake            : UINT ;                            (* Handshake *)
   NOT_USE_1            : ARRAY [0..1] OF USINT ;
   G92_matrix           : ARRAY [0..8] OF REAL ;            (* G92 matrix *)
   G192_matrix          : ARRAY [0..8] OF REAL ;            (* G192 matrix *)
   G292_matrix          : ARRAY [0..8] OF REAL ;            (* G292 matrix *)
   comp_matrix          : ARRAY [0..8] OF REAL ;            (* Compensation matrix *)
   offset               : ARRAY [0..14] OF REAL ;           (* Offset *)
END_STRUCT;
ARNC0NCDPR_typ : STRUCT                                     (* NC DPR *)
   halt_ncsz            : USINT ;                           (* Halt the CNC move at the end of an NC record *)
   halt                 : USINT ;                           (* Halt the CNC move *)
   NOT_USE_1            : ARRAY [0..1] OF USINT ;
END_STRUCT;
ARNC0NCSMO_typ : STRUCT                                     (* NC Monitor *)
   handshake            : UINT ;                            (* Handshake *)
   NOT_USE_1            : ARRAY [0..1] OF USINT ;
   ncblock_l2           : ARRAY [0..79] OF USINT ;          (* NC block *)
   ncblock_l1           : ARRAY [0..79] OF USINT ;          (* NC block *)
   ncblock              : ARRAY [0..79] OF USINT ;          (* NC block *)
   ncblock_n1           : ARRAY [0..79] OF USINT ;          (* NC block *)
   ncblock_n2           : ARRAY [0..79] OF USINT ;          (* NC block *)
   s_ncblock            : REAL ;                            (* Remaining path length until end of current NC block *)
   s_ncblock_tot        : REAL ;                            (* Path length of current NC block *)
   s_ncblock_n1         : REAL ;                            (* Path length of next NC block *)
END_STRUCT;
ARNC0PTRTR_typ : STRUCT                                     (* Trigger *)
   par_id               : UINT ;                            (* Parameter ID *)
   event                : USINT ;                           (* Event *)
   reserve              : USINT ;                           (* Reserved *)
   threshold            : REAL ;                            (* Threshold *)
   window               : REAL ;                            (* Latch window *)
END_STRUCT;
ARNC0PTRDA_typ : STRUCT                                     (* Test data *)
   par_id               : UINT ;                            (* Parameter ID *)
   reserve              : UINT ;                            (* Reserved *)
END_STRUCT;
ARNC0PTRSV_typ : STRUCT                                     (* Operating System Variable *)
   data_type            : USINT ;                           (* Data type *)
   reserve1             : USINT ;                           (* Reserved *)
   reserve2             : UINT ;                            (* Reserved *)
   address              : UDINT ;                           (* Address *)
END_STRUCT;
ARNC0PTRSY_typ : STRUCT                                     (* Configuration of Operating System Variables *)
   trigger              : ARNC0PTRSV_typ ;                  (* Trigger *)
   test_dat             : ARRAY [0..9] OF ARNC0PTRSV_typ ;  (* Test data *)
END_STRUCT;
ARNC0PATRC_typ : STRUCT                                     (* Trace *)
   status               : USINT ;                           (* Status *)
   reserve              : ARRAY [0..2] OF USINT ;           (* Reserved *)
   buf_size             : UDINT ;                           (* Size of trace data buffer on the drive *)
   NOT_USE_1            : ARRAY [0..3] OF USINT ;
   t_trace              : REAL ;                            (* Recording time *)
   t_sampling           : REAL ;                            (* Sampling time *)
   t_delay              : REAL ;                            (* Start delay *)
   trigger              : ARNC0PTRTR_typ ;                  (* Trigger *)
   test_dat             : ARRAY [0..9] OF ARNC0PTRDA_typ ;  (* Test data *)
   system_var           : ARNC0PTRSY_typ ;                  (* Configuration of Operating System Variables *)
END_STRUCT;
ARNC0PTRIN_typ : STRUCT                                     (* Internal for Parameter Trace *)
   errortext            : USINT ;                           (* Error text *)
   err_cl0              : USINT ;                           (* Error class 0 *)
   reserve              : UINT ;                            (* Reserved *)
END_STRUCT;
ARNC0PARTRACE_typ : STRUCT                                  (* ncPARID_TRACE-structure for ARNC0 *)
   NOT_USE_1            : ARRAY [0..3] OF USINT ;
   size                 : UINT ;                            (* Size of the corresponding NC manager data type *)
   reserve0             : UINT ;                            (* Reserved *)
   sw_version           : ARNC0SWVER_typ ;                  (* Software Version ID *)
   nc_obj_inf           : ARNC0OBINF_typ ;                  (* NC Object Information *)
   network              : ARNC0NETMO_typ ;                  (* Network *)
   trace                : ARNC0PATRC_typ ;                  (* Trace *)
   message              : ARNC0MSG_typ ;                    (* Messages (errors, warnings) *)
   intern               : ARNC0PTRIN_typ ;                  (* Intern *)
   NOT_USE_2            : ARRAY [0..47] OF USINT ;
END_STRUCT;
ARNC0MATRIX_typ : STRUCT                                    (* Rotation matrix *)
   matrix_el            : ARRAY [0..8] OF REAL ;            (* Element of compensation matrix *)
END_STRUCT;
ARNC0PLOTDATA_typ : STRUCT                                  (* Plot data in buffer *)
   block_ncprog         : UDINT ;                           (* Block number in CNC program *)
   cmd_code             : USINT ;                           (* Code of the command *)
   reserve0             : USINT ;                           (* Reserved *)
   info                 : USINT ;                           (* Additional Info *)
   plane                : USINT ;                           (* Plane *)
   end                  : ARRAY [0..2] OF REAL ;            (* End Point *)
   center               : ARRAY [0..2] OF REAL ;            (* Center point definition *)
   rotation             : ARNC0MATRIX_typ ;                 (* Rotation matrix *)
   v_ncprog             : REAL ;                            (* Path speed currently defined in CNC program *)
END_STRUCT;
ARNC0PLOTFOOTER_typ : STRUCT                                (* End of plot buffer *)
   buffer_end           : UDINT ;                           (* End of buffer *)
END_STRUCT;
ARNC0PLOTHEADER_typ : STRUCT                                (* Header for plot buffer *)
   size                 : UDINT ;                           (* Size of the corresponding NC manager data type *)
   format               : USINT ;                           (* Format *)
   status               : USINT ;                           (* Status *)
   reserve0             : UINT ;                            (* Reserved *)
   sw_version           : ARNC0SWVER_typ ;                  (* Software Version ID *)
   start                : UDINT ;                           (* Start *)
   write                : UDINT ;                           (* Reference for write access *)
   read                 : UDINT ;                           (* Reference for read access *)
END_STRUCT;
ARNC0DBLST_typ : STRUCT                                     (* Status *)
   data_len             : UDINT ;                           (* Length of data *)
   init                 : USINT ;                           (* Data block initialized *)
   ok                   : USINT ;                           (* Operation complete *)
   error                : USINT ;                           (* Error *)
   reserve1             : USINT ;                           (* Reserved *)
   reserve2             : UDINT ;                           (* Reserved *)
END_STRUCT;
ARNC0DBLPA_typ : STRUCT                                     (* Parameters *)
   data_len             : UDINT ;                           (* Length of data *)
   data_adr             : UDINT ;                           (* Data address *)
   data_modul           : ARRAY [0..11] OF USINT ;          (* Name of the data module *)
   index                : UINT ;                            (* Index *)
   mode                 : UINT ;                            (* Mode *)
   format               : UINT ;                            (* Format *)
   reserve              : UINT ;                            (* Reserved *)
END_STRUCT;
ARNC0DATBL_typ : STRUCT                                     (* Data block operation *)
   status               : ARNC0DBLST_typ ;                  (* Status *)
   parameter            : ARNC0DBLPA_typ ;                  (* Parameters *)
END_STRUCT;
ARNC0DNCHEADER_typ : STRUCT                                 (* Header of DNC Interface *)
   status               : USINT ;                           (* Status *)
   reserve              : ARRAY [0..2] OF USINT ;           (* Reserved *)
   start_adr            : UDINT ;                           (* Start address of CNC data area *)
   write_adr            : UDINT ;                           (* Write address (write pointer) *)
   read_adr             : UDINT ;                           (* Read address (read pointer) *)
   size                 : UDINT ;                           (* Size of CNC data area *)
END_STRUCT;
ARNC0TYPES_typ : STRUCT                                     (* Data structure for additional data types *)
   data_block           : ARNC0DATBL_typ ;                  (* Data block operation *)
   dnc_header           : ARNC0DNCHEADER_typ ;              (* Header of DNC Interface *)
END_STRUCT;
END_TYPE

TYPE
    ARNC0FILEMONENTRY_typ : STRUCT
        name                            : UDINT;                                 (* File name (address) *)
        path_name                       : UDINT;                                 (* Full path file name (address) *)
        dir_name                        : UDINT;                                 (* Directory name (address) *)
        device_name                     : UDINT;                                 (* Device name (address) *)
        prog_nr                         : UDINT;                                 (* Number of loaded program *)
        storage_type                    : UDINT;                                 (* Storage type: 1-file, 2-module *)
        time_stamp                      : UDINT;                                 (* File time stamp *)
        precompiled_lcf                 : BOOL;                                  (* Loaded file is laguage configuration file *)
        NOT_USE_1                       : ARRAY[0..2] OF USINT;
        next                            : UDINT;                                 (* Next element in file list *)
    END_STRUCT;
    ARNC0FILEMONBASIC_typ : STRUCT 
        name                            : STRING[31];                            (* Name of loaded file *)
        prog_nr                         : UDINT;                                 (* Number of loaded program *)
        storage_type                    : UDINT;                                 (* Storage type: 1-file, 2-module *)
    END_STRUCT;
    ARNC0FILEMONACCESS_typ : STRUCT 
        valid                           : BOOL;                                  (* Extended data can be accessed *)
        NOT_USE_1                       : ARRAY[0..2] OF USINT;
        first                           : UDINT;                                 (* Begin of the file list *)
    END_STRUCT;
    ARNC0FILEMON_typ : STRUCT
        set_offset                      : UDINT;                                 (* Required file offset *)
        offset                          : UDINT;                                 (* Offset of displayed files *)
        file                            : ARRAY[0..31] OF ARNC0FILEMONBASIC_typ; (* File monitor *)
        direct_access                   : ARNC0FILEMONACCESS_typ;                (* Access to extended data *)
        handshake                       : BOOL;                                  (* Set to update data *)
        NOT_USE_1                       : ARRAY[0..2] OF USINT;
    END_STRUCT;
    ARNC0EXTWMCOL_typ : STRUCT
        result                          : UDINT;                                 (* WM result *)
        index1                          : UDINT;                                 (* Index of 1st found colliding area *)
        shape1                          : UDINT;                                 (* Shape of colliding area: 1-block, 2-hspace *)
    END_STRUCT;
    ARNC0EXTWM_typ : STRUCT
        joint_position                  : ARRAY[0..11] OF LREAL;                 (* Joint coordinate *)
        xyz_position                    : ARRAY[0..2] OF LREAL;                  (* TCP position if joints cannot be used *)
        D_FULL                          : ARRAY[0..5] OF LREAL;                  (* General tool *)
        local_frame                     : ARRAY[0..5] OF LREAL;                  (* Local (base) frame *)
        collision                       : ARNC0EXTWMCOL_typ;                     (* Additional information about collisions *)
    END_STRUCT;
    OPTMOT_SEG_CONFIG_typ : STRUCT 
        distance                        : LREAL;                                 (* Length of the path segments in CNC units *)
        increase_num_seg_from_radius    : LREAL;                                 (* Finer segmentation of circles with smaller radius *)
        increase_num_seg_orient_factor  : LREAL;                                 (* Finer segmentation of orientation change *)
        G126_num_seg                    : UDINT;                                 (* Finer segmentation of rounding edge *)
        G126_num_seg_PTP_Interp         : UDINT;                                 (* Finer segmentation of rounding edge *)
    END_STRUCT;
    OPTMOT_AXES_typ : STRUCT 
        ax_count                        : UDINT;                                 (* Number of axes for optimization *)
        ax_index                        : ARRAY [0..14] OF USINT;                (* Index of CNC-axis *)
        NOT_USE_1                       : USINT;
        ax_factor                       : ARRAY [0..14] OF LREAL;                (* Scaling factor *)
    END_STRUCT;
    OPTMOT_PATHDEF_typ : STRUCT 
        type                            : UINT;                                  (* Type of path definition *)
        ax_count                        : UINT;                                  (* Number of axes for path computation *)
        ax_index                        : ARRAY [0..14] OF USINT;                (* Index of CNC-axis *)
        NOT_USE_1                       : USINT;
        ax_factor                       : ARRAY [0..14] OF LREAL;                (* Scaling factor *)
    END_STRUCT;
    OPTMOT_TRF_VAR_INSTANCES_typ : STRUCT 
        trf_var_ip                      : UDINT;                                 (* For developers only *)
        trf_var_ip_wm                   : UDINT;                                 (* For developers only *)
        trf_var_pp1                     : UDINT;                                 (* For developers only *)
        trf_var_pp2                     : UDINT;                                 (* For developers only *)
        trf_var_bgen                    : UDINT;                                 (* For developers only *)
    END_STRUCT;
    OPTMOT_ACCESS_POINTS_typ : STRUCT 
        pp_context                      : UDINT;                                 (* Access of data for external workspace monitoring *)
        wm_function                     : UDINT;                                 (* Access for external call of workspace monitoring *)
        address_debug_data              : UDINT;                                 (* For developers only *)
        trf_var_instances               : OPTMOT_TRF_VAR_INSTANCES_typ;          (* Structure of access points for developers only *)
    END_STRUCT;
    OPTMOT_INTERNAL_typ : STRUCT 
        buffer_nc_block                 : UDINT;                                 (* Size of a buffer containing NC-blocks *)
        buffer_geometric_data           : UDINT;                                 (* Size of a buffer containing geometric data of the path *)
        disable_optmot_for_channel      : USINT;                                 (* Deactivation of optimizer for current CNC channel *)                            
        Ts_multiple                     : USINT;                                 (* Sample time of trajectory planer *)
        linear_feed                     : USINT;                                 (* Behavior of path acceleration *)
        bypass_optmot                   : USINT;                                 (* Simulation mode *)
        addr_dyn_model                  : UDINT;                                 (* Pointer to the dynamic model *)
        der_num_poly_points             : UINT;                                  (* Number of segments used for derivatives computation *)
        geometric_pos_filter            : UINT;                                  (* Number of segments used for position filter *)
        buffer_level_lookahead          : UINT;                                  (* Minimal fill level of lookahead buffer *)
        G220_reduce_to_max_in_buffer    : UINT;                                  (* Reduction of G220 time *)
        sigma_diff_compute              : LREAL;                                 (* Lookahead of segmentation *)
        max_angle                       : LREAL;                                 (* Angle to detect stops on path *)
        access_points                   : OPTMOT_ACCESS_POINTS_typ;              (* Structure of access points for developers only *)
        reserve1                        : ARRAY [0..9] OF LREAL;                 (* For developers only *)
        reserve2                        : ARRAY [0..9] OF DINT;                  (* For developers only *)
    END_STRUCT;
    OPTMOT_LIMITS_typ : STRUCT 
        v_joint_min                     : ARRAY [0..14] OF LREAL;                (* Minimal velocity limits of the joint axes *)
        v_joint_max                     : ARRAY [0..14] OF LREAL;                (* Maximal velocity limits of the joint axes *)
        a_joint_min                     : ARRAY [0..14] OF LREAL;                (* Minimal acceleration limits of the joint axes *)
        a_joint_max                     : ARRAY [0..14] OF LREAL;                (* Maximal acceleration limits of the joint axes *)
        j_joint_min                     : ARRAY [0..14] OF LREAL;                (* Minimal jerk limits of the joint axes *)
        j_joint_max                     : ARRAY [0..14] OF LREAL;                (* Maximal jerk limits of the joint axes *)
        torque_min                      : ARRAY [0..14] OF LREAL;                (* Minimal torque limits of the joint axes *)
        torque_max                      : ARRAY [0..14] OF LREAL;                (* Maximal torque limits of the joint axes *)
        torque_limits_in_generator_mode : UDINT;                                 (* Activation of generator mode *)
        torque_gen_factor_min           : ARRAY [0..14] OF LREAL;                (* Factor for minimal torque limit in generator mode *)
        torque_gen_factor_max           : ARRAY [0..14] OF LREAL;                (* Factor for maximal torque limit in generator mode *)
        v_path_min                      : ARRAY [0..31] OF LREAL;                (* Minimal velocity limits of the path definitions *)
        v_path_max                      : ARRAY [0..31] OF LREAL;                (* Maximal velocity limits of the path definitions *)
        a_path_min                      : ARRAY [0..31] OF LREAL;                (* Minimal acceleration limits of the path definitions *)
        a_path_max                      : ARRAY [0..31] OF LREAL;                (* Maximal acceleration limits of the path definitions *)
        j_path_min                      : ARRAY [0..31] OF LREAL;                (* Minimal jerk limits of the path definitions *)
        j_path_max                      : ARRAY [0..31] OF LREAL;                (* Maximal jerk limits of the path definitions *)
    END_STRUCT;
    OPTMOT_ACTIVE_LIMIT_typ : STRUCT 
        type                            : USINT;                                 (* Type of the active limit *)
        source                          : USINT;                                 (* Source of the active limit *)
        min_max                         : SINT;                                  (* Positive or negative range of the active limit *)
        index                           : USINT;                                 (* Index of the axis or path definition of the active limit *)
    END_STRUCT;
    OPTMOT_UNFILTERED_MONITOR_typ : STRUCT 
        s_joint                         : ARRAY [0..14] OF LREAL;                (* Cyclical joint position in CNC units *)
        v_joint                         : ARRAY [0..14] OF LREAL;                (* Cyclical joint velocity in CNC units *)
        a_joint                         : ARRAY [0..14] OF LREAL;                (* Cyclical joint acceleration in CNC units *)
        j_joint                         : ARRAY [0..14] OF LREAL;                (* Cyclical joint jerk in CNC units *)
    END_STRUCT;
    OPTMOT_MONITOR_typ : STRUCT 
        s_joint                         : ARRAY [0..14] OF LREAL;                (* Cyclical joint position in CNC units *)
        v_joint                         : ARRAY [0..14] OF LREAL;                (* Cyclical joint velocity in CNC units *)
        a_joint                         : ARRAY [0..14] OF LREAL;                (* Cyclical joint acceleration in CNC units *)
        j_joint                         : ARRAY [0..14] OF LREAL;                (* Cyclical joint jerk in CNC units *)
        feed_forward_torque             : ARRAY [0..14] OF LREAL;                (* Cyclical joint torque/force *)
        v_path                          : ARRAY [0..31] OF LREAL;                (* Cyclical path velocity in CNC units *)
        unfiltered_monitor              : OPTMOT_UNFILTERED_MONITOR_typ;         (* Monitor data without filters and override *)
        active_limit                    : OPTMOT_ACTIVE_LIMIT_typ;               (* Structure of information about current limitation *)
        data_valid                      : UINT;                                  (* Feed forward data is valid *)
        fill_level_lookahead            : UINT;                                  (* Fill level of lookahead buffer *)
        reserve                         : ARRAY [0..1] OF UDINT;
    END_STRUCT;
    OPTMOT_COND_STOP_typ : STRUCT 
        active                          : UINT;                                  (* Conditional stop active *)
        call_stop_internal              : UINT;                                  (* Internal execution of the conditional stop *)
        identifier                      : UDINT;                                 (* Identifier of the conditional stop *)
        select_overlapped_identifier    : UDINT;                                 (* Selection of identifier in overlapping conditional stops *)
        select_identifier_stop_internal : UDINT;                                 (* Selection of identifier if conditional stop is executed internally *)
    END_STRUCT;
    OPTMOT_COND_STOP_OPTMOT_typ : STRUCT 
        identifier_aktiv                : UDINT;                                 (* Output of aktive identifier *)
        identifier_fulfilled            : UDINT;                                 (* Input of fulfilled identifier *)
    END_STRUCT;
    OPTMOT_STOPPING_typ : STRUCT 
        G126_skip_if_stop               : UINT;                                  (* Skip G126 if a stop on path occurs *)
        trajectory                      : UINT;                                  (* Definition of stopping trajectory *)
        conditional_stop                : OPTMOT_COND_STOP_typ;                  (* Structure of conditional stop *)
        conditional_stop_optmot         : OPTMOT_COND_STOP_OPTMOT_typ;           (* Structure of optmot synchronal conditional stop *)
    END_STRUCT;
    OPTMOT_PATH_typ : STRUCT 
        G126_skip_smaller_radius        : LREAL;                                 (* Skip G126 if programmed radius is smaller *)
        G126_round_whole_line           : UDINT;                                 (* Round whole first/last line *)
        count                           : UDINT;                                 (* Number of path definitions *)
        definition                      : ARRAY [0..31] OF OPTMOT_PATHDEF_typ;   (* Structure of path definitions parameters *)
        stopping                        : OPTMOT_STOPPING_typ;                   (* Structure of stopping parameters *)
        reserve1                        : ARRAY [0..170] OF UDINT;
    END_STRUCT;
    OPTMOT_CONFIG_typ : STRUCT 
        axes                            : OPTMOT_AXES_typ;                       (* Structure of joint axes parameters *)
        path                            : OPTMOT_PATH_typ;                       (* Structure of path parameters *)
        limits                          : ARRAY [0..31] OF OPTMOT_LIMITS_typ;    (* Structure of limit parameters *)
        segmentation                    : OPTMOT_SEG_CONFIG_typ;                 (* Structure of segmentation parameters *)
        monitor                         : OPTMOT_MONITOR_typ;                    (* Structure of monitor parameters *)
        internals                       : OPTMOT_INTERNAL_typ;                   (* Structure of internal parameters *)
    END_STRUCT;
    OPTMOT_MONITOR_ADVANCED_typ : STRUCT 
        s_joint                         : ARRAY [0..14] OF LREAL;                (* Cyclical joint position in CNC units *)
        v_joint                         : ARRAY [0..14] OF LREAL;                (* Cyclical joint velocity in CNC units *)
        a_joint                         : ARRAY [0..14] OF LREAL;                (* Cyclical joint acceleration in CNC units *)
        j_joint                         : ARRAY [0..14] OF LREAL;                (* Cyclical joint jerk in CNC units *)
        feed_forward_torque             : ARRAY [0..14] OF LREAL;                (* Cyclical joint torque/force *)
        v_path                          : ARRAY [0..31] OF LREAL;                (* Cyclical path velocity in CNC units *)
        unfiltered_monitor              : OPTMOT_UNFILTERED_MONITOR_typ;         (* Monitor data without filters and override *)
        active_limit                    : OPTMOT_ACTIVE_LIMIT_typ;               (* Structure of information about current limitation *)
        data_valid                      : UINT;                                  (* Feed forward data is valid *)
        fill_level_lookahead            : UINT;                                  (* Fill level of lookahead buffer *)
        tracking_active                 : UINT;                                  (* Tracking active *)
        tracking_synch                  : UINT;                                  (* Robot synchronized with conveyor *)
        tracking_index                  : UINT;                                  (* Active tracking index *)
        reserve                         : UINT;
    END_STRUCT;
    OPTMOT_TRACKING_ORIENTATION_typ : STRUCT 
        phi                             : LREAL;                                 (* Phi-component of a rotation *)
        theta                           : LREAL;                                 (* Theta-component of a rotation *)
        psi                             : LREAL;                                 (* Psi-component of a rotation *)
    END_STRUCT;
    OPTMOT_TRACKING_ORIENT_PARAM_typ : STRUCT
        measure                         : UDINT;                                 (* Unit of measurement of the angles *)
        angles_type                     : UDINT;                                 (* Angles type *)
    END_STRUCT;
    OPTMOT_TRACKING_LIMITS_typ : STRUCT
        maxVelocity                     : LREAL;                                 (* Maximal velocity of the conveyor belt *)
    END_STRUCT;
    OPTMOT_TRACKING_CYCLIC_typ : STRUCT
        position                        : LREAL;                                 (* Cyclical position of the conveyor belt *)
        velocity                        : LREAL;                                 (* Cyclical velocity of the conveyor belt *)
    END_STRUCT;
    OPTMOT_TRACKING_CONVEYOR_typ : STRUCT
        limits                          : OPTMOT_TRACKING_LIMITS_typ;            (* Structure of conveyor limits *)
        orientation                     : OPTMOT_TRACKING_ORIENTATION_typ;       (* Structure of orientation between global basic frame and conveyor belt frame *)
        cyclicData                      : OPTMOT_TRACKING_CYCLIC_typ;            (* Structure of cyclic data *)
    END_STRUCT;
    OPTMOT_TRACKING_CONVEYORDATA_typ : STRUCT
        orientationParameter            : OPTMOT_TRACKING_ORIENT_PARAM_typ;      (* Structure of general orientation parameters *)
        conveyor                        : ARRAY [0..9] OF OPTMOT_TRACKING_CONVEYOR_typ; (* Structure of conveyor belt data *)
    END_STRUCT;
    OPTMOT_TRACKING_typ : STRUCT 
        enable                          : UDINT;                                 (* Enable tracking *)
        conveyorData                    : OPTMOT_TRACKING_CONVEYORDATA_typ;      (* Structure of conveyor belt tracking *)
        feedrateMode					: LREAL;								 (* Define Feedrate in MCS(=0) or in Moving Frame(=1) *)
        reserve1                        : ARRAY [0..6] OF LREAL;                 (* For developers only *)
        reserve2                        : ARRAY [0..31] OF UDINT;                (* For developers only *)
    END_STRUCT;
    OPTMOT_PATH_ADVANCED_typ : STRUCT 
        G126_skip_smaller_radius        : LREAL;                                 (* Skip G126 if programmed radius is smaller *)
        G126_round_whole_line           : UDINT;                                 (* Round whole first/last line *)
        count                           : UDINT;                                 (* Number of path definitions *)
        definition                      : ARRAY [0..31] OF OPTMOT_PATHDEF_typ;   (* Structure of path definitions parameters *)
        stopping                        : OPTMOT_STOPPING_typ;                   (* Structure of stopping parameters *)
        tracking                        : OPTMOT_TRACKING_typ;                   (* Structure of tracking parameters *)
    END_STRUCT;
    OPTMOT_CONFIG_ADVANCED_typ : STRUCT 
        axes                            : OPTMOT_AXES_typ;                       (* Structure of joint axes parameters *)
        path                            : OPTMOT_PATH_ADVANCED_typ;              (* Structure of path parameters *)
        limits                          : ARRAY [0..31] OF OPTMOT_LIMITS_typ;    (* Structure of limit parameters *)
        segmentation                    : OPTMOT_SEG_CONFIG_typ;                 (* Structure of segmentation parameters *)
        monitor                         : OPTMOT_MONITOR_ADVANCED_typ;           (* Structure of monitor parameters *)
        internals                       : OPTMOT_INTERNAL_typ;                   (* Structure of internal parameters *)
    END_STRUCT;
    ARNC0PLOTDATA01_typ : STRUCT 
        block_ncprog                    : UDINT;                       			 (* Block number *)
        line_ncprog                     : UDINT;                       			 (* Line number *)
        MpId                            : UDINT;                       			 (* Motion packet ident *)
        MpSubId                         : UDINT;                       			 (* Motion packet subident *)
        cmd_code                        : UINT;                       			 (* Command *)
        reserve                         : UINT;                       			 (* don't use *)
        data                            : ARRAY [0..51] OF USINT;                (* Data *)
    END_STRUCT;
    ARNC0PLOTDATA02_typ : STRUCT 
        block_ncprog                    : UDINT;                       			 (* Block number *)
        line_ncprog                     : UDINT;                       			 (* Line number *)
        MpId                            : UDINT;                       			 (* Motion packet ident *)
        MpSubId                         : UDINT;                       			 (* Motion packet subident *)
        cmd_code                        : UINT;                       			 (* Command *)
        reserve                         : UINT;                       			 (* don't use *)
        data                            : ARRAY [0..51] OF USINT;                (* Data *)
    END_STRUCT;	
    ARNC0PLDMOVE_typ : STRUCT 
        ep                              : ARRAY [0..2] OF REAL;                  (* End point *)
        cp                              : ARRAY [0..2] OF REAL;                  (* Center point *)
        radius                          : REAL;                                  (* Tool radius *)
        v_ncprog                        : REAL;                                  (* Programmed feedrate *)
        info                            : UDINT;                                 (* Info bits *)
    END_STRUCT;	
    ARNC0PLDMOVE02_typ : STRUCT 
        ep                              : ARRAY [0..2] OF REAL;                  (* End point *)
        cp                              : ARRAY [0..2] OF REAL;                  (* Center point *)
        radius                          : REAL;                                  (* Tool radius *)
        v_ncprog                        : REAL;                                  (* Programmed feedrate *)
        t                               : REAL;                                  (* block runtime *)
        s                               : REAL;                                  (* block length, interpolated axes *)
        s_all                           : REAL;                                  (* block length, all axes *)
        info                            : UDINT;                                 (* Info bits *)
    END_STRUCT;
    ARNC0PLDPROGEND_typ : STRUCT 
        t                               : REAL;                                  (* estimated runtime *)
        s                               : REAL;                                  (* path length, interpolated axes *)
        s_all                           : REAL;                                  (* path length, all axes *)
    END_STRUCT;
    ARNC0PLDPROGSTART_typ : STRUCT 
        ProgNumber                      : UDINT;                                 (* program number *)
    END_STRUCT;
    ARNC0PLDTOOL_typ : STRUCT 
        radius                          : REAL;                                  (* Tool radius *)
        length                          : REAL;                                  (* Tool length *)
        offset                          : ARRAY [0..2] OF REAL;                  (* Tool offset *)
        index                           : UINT;                                  (* Tool index, tool data number *)
        reserve                         : UINT;                                  (* don't use *)
    END_STRUCT;	
    ARNC0PLDCSTRF_typ : STRUCT 
        matrix                          : ARRAY [0..8] OF REAL;                  (* Rotation matrix *)
        offset                          : ARRAY [0..2] OF REAL;                  (* Offset (cs + tool) *)
        info                            : UDINT;                                 (* Info bits *)		
    END_STRUCT;	
    ARNC0PLDUSER_typ : STRUCT 
        data                            : ARRAY [0..51] OF USINT;                (* User data *)
    END_STRUCT;
    ARNC0TRFIODATA_typ : STRUCT
        status                          : UDINT;                                 (* Return status of the last call of the transformation function *)
        in_pos                          : ARRAY [0..11] OF LREAL;                (* Input positions of the transformation function *)
        in_pos_ext                      : ARRAY [0..11] OF LREAL;                (* Extended input positions of the transformation function *)
        out_pos                         : ARRAY [0..71] OF LREAL;                (* Output positions of the transformation function *)
        info                            : ARRAY [0..8] OF UDINT;                 (* Information about the last call of the transformation function *)
    END_STRUCT;
    ARNC0WSCTRL_typ : STRUCT
        link_index                      : UDINT;                                 (* index of colliding link *)
        link2_index                     : UDINT;                                 (* index of colliding link for self-collision *)
        area_index                      : UDINT;                                 (* index of colliding area *)
    END_STRUCT; 
    ARNC0NCMON_EXT_AX_typ : STRUCT
        nc_object                       : UDINT;
        nc_object_plcopen               : UDINT;
        v                               : REAL;                                  (* axis limit [cnc unit/s] *)
        a                               : REAL;                                  (* axis limit [cnc unit/s2] *)
        t_jolt                          : REAL;                                  (* axis jolt filter [s] (cnc system) *)
        pos_sw_end                      : DINT;                                  (* [cnc unit] *)
        neg_sw_end                      : DINT;                                  (* [cnc unit] *)
        unitfactor                      : REAL;                                  (* cnc unit factor *)
        plcopen_factor                  : REAL;                                  (* PLCopen unit factor *)
        type                            : UDINT;                                 (* axis type *)
        rot_period                      : REAL;                                  (* period of the rotary axis [cnc unit] *)
        rot_offset                      : REAL;                                  (* period start offsetof the rotary axis [cnc unit] *)
        ipl_mode                        : USINT;                                 (* interpolation mode *)
        drive_axfilter                  : USINT;                                 (* axis jolt filter on drive enable/disable *)
        nc_obj_name                     : ARRAY [0..13] OF USINT;
        cnc_ax_name                     : ARRAY [0..13] OF USINT;
        reserve                         : ARRAY [0..1] OF USINT;
    END_STRUCT;
    ARNC0NCMON_EXT_G113_typ : STRUCT
        k_alpha_max                     : REAL;                                  (* G113 parameter *)
        alpha_min                       : REAL;                                  (* G113 parameter *)
        alpha_max                       : REAL;                                  (* G113 parameter *)
    END_STRUCT;
    ARNC0NCMON_EXT_CNC_typ : STRUCT
        nc_object                       : UDINT;                                 (* nc object (cnc) *)
        v                               : REAL;                                  (* path limit [cnc unit/s] *)
        a_pos                           : REAL;                                  (* path limit [cnc unit/s2] *)
        a_neg                           : REAL;                                  (* path limit [cnc unit/s] *)
        t_jolt                          : REAL;                                  (* path jolt filter [s] *)
        feed                            : REAL;                                  (* programmed feed [cnc unit/s] *)
        v_jump                          : ARRAY [0..14] OF REAL;                 (* speed jump [cnc unit/s] *)
        a_jump                          : ARRAY [0..14] OF REAL;                 (* acceleration jump [cnc unit/s] *)
        v_jump_t                        : REAL;                                  (* speed jump for tangential axes [cnc unit/s] *)
        s_jump_t                        : REAL;                                  (* blocktransition tangential / non tangential [deg] *)
        filter_err_cir                  : REAL;                                  (* allowed radius error (jolt filter) [cnc unit] *)
        filter_err_trans                : REAL;                                  (* contour violation (jolt filter) [cnc unit] *)
        radius_err                      : REAL;                                  (* center point prgramming [cnc unit] *)
        elements                        : UDINT;                                 (* calculated elements before start *)
        block_buffer                    : UDINT;                                 (* block buffer for backtracing *)
        lookahead                       : UDINT;                                 (* look ahead buffer (dynamics calculation) *)
        first_M                         : UINT;                                  (* index of 1st M function (without sync) *)
        last_M                          : UINT;                                  (* index of last M function (without sync) *)
        first_M_S                       : UINT;                                  (* index of 1st M function (with sync) *)
        last_M_S                        : UINT;                                  (* index of last M function (with sync) *)
        s_sync1_t                       : UINT;                                  (* 1st sync M function (G141) *)
        s_sync2_t                       : UINT;                                  (* 2nd sync M function (G141) *)
        blocktransition                 : USINT;                                 (* block transition mode *)
        reserve                         : USINT;
        nc_obj_name                     : ARRAY [0..13] OF USINT;
        g113_data                       : ARNC0NCMON_EXT_G113_typ;
    END_STRUCT;
    ARNC0NCMON_EXT_G705_typ : STRUCT
        ident                           : UDINT;                                 (* G705 ident *)
        axis                            : ARRAY[0..14] OF ARNC0NCMON_EXT_AX_typ;
        cnc                             : ARNC0NCMON_EXT_CNC_typ;
        block_ncprog                    : UDINT;                                 (* block number (G705) *)
        line_ncprog                     : UDINT;                                 (* line number (G705) *)
        cnc_channel                     : UINT;                                  (* cnc channel (idndex) *)
        reserve                         : UINT;
    END_STRUCT;
    ARNC0NCMON_EXT_typ : STRUCT 
        s_set                           : ARRAY [0..14] OF LREAL;                (* set position *)
        s_ncprog                        : LREAL;                                 (* path position in current CNC program *)
        g705_data                       : ARNC0NCMON_EXT_G705_typ;               (* parameter at program start, at G705 *)
        reserve                         : ARRAY[0..1] OF UDINT;
    END_STRUCT;
    ARNC0WFM_SERIAL_typ : STRUCT 
        nr_of_points : UDINT;                                                    (* number of points of wire-frame model *)
        point : ARRAY[0..20, 0..2] OF LREAL;                                     (* points of wire-frame model *)
        nr_of_arms : UDINT;                                                      (* number of arm diameters *)
        arm_diameter : ARRAY[0..19] OF LREAL;                                    (* arm diameters *)
        safe_distance : LREAL;                                                   (* safe distance *)
    END_STRUCT;
    ARNC0WFM_COMPLETE_typ : STRUCT
        data : ARRAY[0..329] OF UDINT;                                           (* internal data of complete wire-frame model *)
    END_STRUCT;
    ARNC0WFM_typ : STRUCT 
        use_complete : UDINT;                                                    (* use complete type of wire-frame model *)
        complete : ARNC0WFM_COMPLETE_typ;                                        (* complete wire-frame model data *)
        use_serial : UDINT;                                                      (* use serial type of wire-frame model *)
        serial : ARNC0WFM_SERIAL_typ;                                            (* serial wire-frame model data *)
    END_STRUCT;
    ARNC0WFM_BFS : STRUCT 
        enable : UDINT;                                                          (* enable frame *)
        dx : LREAL;                                                              (* x transition *)
        dy : LREAL;                                                              (* y transition *)
        dz : LREAL;                                                              (* z transition *)
        phi : LREAL;                                                             (* angle in meaning of angles type *)
        theta : LREAL;                                                           (* angle in meaning of angles type *)
        psi : LREAL;                                                             (* angle in meaning of angles type *)
        angles_type : UDINT;                                                     (* angles type *)
    END_STRUCT;
    ARNC0WFM_MON_typ : STRUCT 
        valid_data : UDINT;                                                      (* number of calls with valid data *)
        invalid_data : UDINT;                                                    (* number of calls with invalid data *)
    END_STRUCT;
    ARNC0WFM_EXT_typ : STRUCT 
        p_wire_frame_model : REFERENCE TO ARNC0WFM_typ;                          (* reference to wire-frame model data *)
        base_frame_shift : ARNC0WFM_BFS;                                         (* frame *)
        monitor : ARNC0WFM_MON_typ;                                              (* monitor *)
    END_STRUCT;
    ARNC0INTERACTION_typ : STRUCT 
        wire_frame_model : ARNC0WFM_typ;                                         (* wire-frame model data *)
        wire_frame_models_to_check : ARRAY[0..23]OF ARNC0WFM_EXT_typ;            (* array of wire-frame models data *)
    END_STRUCT;
END_TYPE
TYPE
  ARNC0IP_MON_typ : STRUCT
    enable : USINT;                             (*Enable cyclic update *)
    reserve : ARRAY[0..2] OF USINT;             (*[RESERVE] *)
    status_msg : ARRAY[0..79] OF USINT;         (*String: current status of interpreter e.g. Running/Waiting/Finished *)
    last_error_msg : ARRAY[0..119] OF USINT;    (*String: last error message issued *)
    last_error_code : UINT ;                    (*Last status message code issued *)
    loaded_prog_count : UINT ;                  (*Number of files loaded *)
    prog_name : ARRAY[0..79] OF USINT;          (*Name of start-program *)
    ncblock_l2 : ARRAY[0..79] OF USINT;         (*Interpeter block monitor: current line -2 *)
    ncblock_l1 : ARRAY[0..79] OF USINT;         (*Interpeter block monitor: current line -1 *)
    ncblock : ARRAY[0..79] OF USINT;            (*Interpeter block monitor: current line *)
    ncblock_n1 : ARRAY[0..79] OF USINT;         (*Interpeter block monitor: current line +1 *)
    ncblock_n2 : ARRAY[0..79] OF USINT;         (*Interpeter block monitor: current line +2 *)
    cur_line_num : UDINT ;                      (*Interpeter block monitor: current line number *)
    cur_block_num : UDINT ;                     (*Interpeter block monitor: current line N-block number *)
    intern1 : UDINT ;                           (*[INTERNAL] *)
    intern2 : UDINT ;                           (*[INTERNAL] *)
    intern3 : UDINT ;                           (*[INTERNAL] *)
    intern4 : UDINT ;                           (*[INTERNAL] *)
    intern5 : UDINT ;                           (*[INTERNAL] *)
    breakpoint_count : UDINT ;                  (*Number of breakpoints set *)
    ipvar_access_count : UDINT ;                (*Number of IP variables being directly accessed by PLC *)
    intern6 : UDINT ;                           (*[INTERNAL] *)
    intern7 : UDINT ;                           (*[INTERNAL] *)
    num_parallel_events : UDINT ;               (*Number of cyclic jobs currently active *)
    parallel_cycle_count : UDINT ;              (*Number of execution cycles of all cyclic jobs *)
    parallel_action_text : ARRAY[0..11, 0..79] OF USINT; (*cyclic execution monitor - cyclic job source line text *)
    parallel_eval_count : ARRAY[0..11] OF UDINT ;   (*number of times the cyclic job has been evaluated (tested) *)
    parallel_exec_count : ARRAY[0..11] OF UDINT ;   (*number of times a Synchronised Action has executed (not relevant to FUBs) *)
    num_fubs_exec_ipsynch : UDINT ;             (*Number of interpreter synchronous FUBs executing *)
    num_fubs_exec_ppsynch : UDINT ;             (*Number of path synchronous FUBs executing *)
    callstack : ARRAY[0..11, 0..79] OF USINT;   (*Program callstack *)
    shared_mem_size : UDINT ;                   (*Memory consumed by shared library data (partitions will be larger) *)
    ip_mem_size : UDINT ;                       (*Memory consumed by interpreter instance (partitions will be larger) *)
    ip_cur_file_mem_size : UDINT ;              (*Memory consumed by start program (or last loaded program) file (partitions will be larger) *)
    sys_free_mem : UDINT ;                      (*Available system memory *)
    intern8 : UDINT ;                           (*[INTERNAL] *)
    intern9 : UDINT ;                           (*[INTERNAL] *)
    intern10 : UDINT ;                          (*[INTERNAL] *)
    intern11 : UDINT ;                          (*[INTERNAL] *)
    parallel_enabled : USINT ;                  (*Bool: cyclic execution enabled *)
    parallel_rdisable_set : USINT ;             (*Bool: cyclic jobs set the keep-alive (rdisable) flag *)
    intern12 : USINT ;                          (*[INTERNAL] *)
    intern13 : USINT ;                          (*[INTERNAL] *)
    cur_prog_file_name : ARRAY[0..79] OF USINT ;(*File name of the current program*)
    cur_prog_name : ARRAY[0..79] OF USINT ;     (*Name of the current program*)
  END_STRUCT;
END_TYPE