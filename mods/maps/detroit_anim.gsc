// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    level.transient_zone = "";
    level.cg_noterack_delay_count = 0;

    if ( level.currentgen )
    {
        if ( istransientloaded( "detroit_intro_tr" ) )
            level.transient_zone = "intro";
        else if ( istransientloaded( "detroit_middle_tr" ) )
            level.transient_zone = "middle";

        if ( istransientloaded( "detroit_gatetrans_tr" ) )
            level.transient_zone += "_gate";
        else if ( istransientloaded( "detroit_school_interior_tr" ) )
            level.transient_zone += "_school";
        else if ( istransientloaded( "detroit_nightclub_interior_tr" ) )
            level.transient_zone += "_nightclub";
        else if ( istransientloaded( "detroit_hospital_interior_tr" ) )
            level.transient_zone += "_hospital";
        else if ( istransientloaded( "detroit_outro_tr" ) )
            level.transient_zone += "_outro";
    }

    if ( level.nextgen )
        anim.forced_s1_motionset = 1;

    aftermath_anims();
    civilian_anims();
    vehicle_anims_toload();
    dog_anims_toload();
    player_anims_toload();
    script_model_anims();
    destructible_anims();

    if ( level.currentgen )
    {
        thread setup_outro_notetracks();
        thread setup_middle_notetracks();
        thread setup_school_notetracks();
        thread setup_nightclub_notetracks();
        thread setup_hospital_notetracks();
    }
}

cg_gate_anim_notetrack_load_stall()
{
    if ( level.cg_noterack_delay_count < 1 )
    {
        level waittill( "tff_post_gatetrans_entry" );
        maps\_anim::addnotetrack_customfunction( "burke", "burke_hoverbike_land", maps\detroit_fx::det_hoverbike_shutdown_burke, "hoverbike_meet_up" );
        maps\_anim::addnotetrack_customfunction( "burke", "burke_hoverbike_lift", maps\detroit_fx::det_hoverbike_startup_burke, "hoverbike_meet_up" );
        maps\_anim::addnotetrack_customfunction( "mech1", "mech_scanner", maps\detroit_fx::det_mech_scanner_fx, "hoverbike_meet_up" );
        maps\_anim::addnotetrack_customfunction( "entrance_gate", "gate_open", maps\detroit_lighting::gate_lights_off_toggle_on, "hoverbike_meet_up" );
        maps\_anim::addnotetrack_customfunction( "entrance_gate", "gate_open", maps\detroit_fx::gate_open_rain_fall_fx, "hoverbike_meet_up" );
        maps\_anim::addnotetrack_customfunction( "entrance_gate", "gate_open", maps\_utility::tff_sync_notetrack, "hoverbike_meet_up" );
    }
}

setup_outro_notetracks()
{
    level waittill( "tff_post_remove_hospital_add_exit" );
    maps\_anim::addnotetrack_customfunction( "littlebird", "heli_shot", maps\detroit_fx::det_helicopter_shot, "det_exit_drive_ending" );
    maps\_anim::addnotetrack_customfunction( "littlebird", "heli_impact", maps\detroit_fx::det_helicopter_explo, "det_exit_drive_ending" );
    maps\_anim::addnotetrack_customfunction( "joker_bike", "hoverbike_fx1", maps\detroit_fx::det_joker_bike_end_fx, "det_exit_drive_ending" );
    maps\_anim::addnotetrack_customfunction( "bones_bike", "hoverbike_fx2", maps\detroit_fx::det_bones_bike_end_fx, "det_exit_drive_ending" );
    maps\_anim::addnotetrack_notify( "world_body", "spotlight_off", "detroit_final_chopper_hit", "det_exit_drive_ending" );
    maps\_anim::addnotetrack_notify( "world_body", "detroit_final_VO", "detroit_ending_VO", "det_exit_drive_ending" );
    maps\_anim::addnotetrack_notify( "world_body", "fadeout", "detroit_level_fadeout", "det_exit_drive_ending" );
}

setup_middle_notetracks()
{
    if ( level.transient_zone == "middle" )
        return;

    level waittill( "tff_post_intro_to_middle" );
    maps\_anim::addnotetrack_customfunction( "burke", "finish", ::begin_stealth_walk, "dismount_rollout" );
    maps\_anim::addnotetrack_customfunction( "world_body", "fovchange", ::change_fov_back_to_65, "bike_dismount" );
    maps\_anim::addnotetrack_customfunction( "world_body", "playerbikevmswitch", ::player_bike_to_ai_model, "bike_dismount" );
    maps\_anim::addnotetrack_notify( "world_body", "off_button", "intro_drive_off_button_pressed", "bike_dismount" );
}

setup_school_notetracks()
{
    if ( issubstr( level.transient_zone, "_school" ) )
        return;

    level waittill( "tff_post_middle_add_school" );
    maps\_anim::addnotetrack_customfunction( "world_body", "fall_school_int", maps\detroit_fx::det_fall_through_ceiling, "school_fall" );
    maps\_anim::addnotetrack_customfunction( "generic", "helmet_swap", ::helmet_swap, "wall_pull" );
    maps\_anim::addnotetrack_customfunction( "generic", "helmet_swap", maps\detroit_fx::det_helmet_smash_fx, "wall_pull" );
    maps\_anim::addnotetrack_customfunction( "generic", "stab", maps\detroit_fx::det_knife_stab_fx, "wall_pull" );
    maps\_anim::addnotetrack_customfunction( "generic", "Knife_fx", maps\detroit_fx::det_knife_pull, "wall_pull" );
    maps\_anim::addnotetrack_customfunction( "world_body", "weapon_up", ::give_weapon_knife, "wall_pull" );
    maps\_anim::addnotetrack_customfunction( "world_body", "slowmo_start", ::begin_wallpull_slowmo, "wall_pull" );
}

setup_nightclub_notetracks()
{
    if ( issubstr( level.transient_zone, "_nightclub" ) )
        return;

    level waittill( "tff_post_middle_add_nightclub" );
}

setup_hospital_notetracks()
{
    if ( issubstr( level.transient_zone, "_hospital" ) )
        return;

    level waittill( "tff_post_middle_add_hospital" );
    maps\_anim::addnotetrack_customfunction( "guy1", "decloak_1", ::sentinel_reveal_guy1_decloak, "sentinel_kva_reveal" );
    maps\_anim::addnotetrack_customfunction( "guy2", "decloak_2", ::sentinel_reveal_guy2_decloak, "sentinel_kva_reveal" );
    maps\_anim::addnotetrack_customfunction( "guy3", "decloak_3", ::sentinel_reveal_guy3_decloak, "sentinel_kva_reveal" );
    maps\_anim::addnotetrack_customfunction( "generic", "hadoken", ::hospital_breach_punch, "det_hos_breach_success_guy4" );
    maps\_anim::addnotetrack_customfunction( "world_body", "slowmo_start", ::hospital_slowmo_start, "det_hos_breach_vm" );
    maps\_anim::addnotetrack_customfunction( "shelf", "shelf_papers", maps\detroit_fx::det_shelf_papers_fx, "det_hos_breach_success_shelf01" );
    maps\_anim::addnotetrack_customfunction( "doctor", "swap_bag_head", ::doc_capture_headswap, "carry_doc_lift" );
    maps\_anim::addnotetrack_customfunction( "capture_bag", "spawn_bag", ::doc_capture_bagspawn, "doctor_capture" );
}

#using_animtree("generic_human");

aftermath_anims()
{
    level.scr_anim["burke"]["burke_turntable"][0] = %edge_walk_gideon;
    level.scr_anim["burke"]["det_casual_gestures_l_shakehead_burke"] = %det_casual_gestures_l_shakehead_burke;
    level.scr_anim["burke"]["det_casual_gestures_r_alt_look_burke"] = %det_casual_gestures_r_alt_look_burke;
    level.scr_anim["joker"]["det_casual_gestures_r_looklow_joker"] = %det_casual_gestures_r_looklow_joker;
    level.scr_anim["burke"]["hoverbike_pre_mount"][0] = %det_motorpool_meet_up_idle_burke;
    level.scr_anim["joker"]["hoverbike_pre_mount"][0] = %det_motorpool_meet_up_idle_joker;
    level.scr_anim["bones"]["hoverbike_pre_mount"][0] = %det_motorpool_meet_up_idle_bones;
    level.scr_anim["burke"]["hoverbike_mount"] = %det_hoverbike_mount_burke;
    maps\_anim::addnotetrack_customfunction( "burke", "hoverbike_start_1", maps\detroit_fx::det_hoverbike_mount_burke, "hoverbike_mount" );
    level.scr_anim["joker"]["hoverbike_mount"] = %det_hoverbike_mount_joker;
    level.scr_anim["bones"]["hoverbike_mount"] = %det_hoverbike_mount_bones;
    level.scr_anim["burke"]["hoverbike_meet_up"] = %det_motorpool_meet_up_burke;

    if ( level.nextgen )
    {
        maps\_anim::addnotetrack_customfunction( "burke", "burke_hoverbike_land", maps\detroit_fx::det_hoverbike_shutdown_burke, "hoverbike_meet_up" );
        maps\_anim::addnotetrack_customfunction( "burke", "burke_hoverbike_lift", maps\detroit_fx::det_hoverbike_startup_burke, "hoverbike_meet_up" );
    }
    else if ( level.currentgen && level.transient_zone == "intro" )
    {
        thread cg_gate_anim_notetrack_load_stall();
        level.cg_noterack_delay_count += 1;
    }

    level.scr_anim["bones"]["hoverbike_meet_up"] = %det_motorpool_meet_up_joker;
    level.scr_anim["joker"]["hoverbike_meet_up"] = %det_motorpool_meet_up_bones;
    level.scr_anim["mech1"]["hoverbike_meet_up"] = %det_motorpool_meet_up_mech1;

    if ( level.nextgen )
        maps\_anim::addnotetrack_customfunction( "mech1", "mech_scanner", maps\detroit_fx::det_mech_scanner_fx, "hoverbike_meet_up" );
    else if ( level.currentgen && level.transient_zone == "intro" )
    {
        thread cg_gate_anim_notetrack_load_stall();
        level.cg_noterack_delay_count += 1;
    }

    level.scr_anim["mech2"]["hoverbike_meet_up"] = %det_motorpool_meet_up_mech2;
    level.scr_anim["burke"]["burke_wall_walk"] = %det_school_fall_guy1;
    level.scr_anim["burke"]["burke_shimmey_wait_idle"][0] = %det_school_fall_wait_idle_guy1;
    level.scr_anim["burke"]["burke_shimmey_wait_idle_out"] = %det_school_fall_wait_2_idle_guy1;
    level.scr_anim["burke"]["burke_wall_walk_idle"][0] = %det_school_fall_idle_guy1;
    level.scr_anim["burke"]["school_fall"] = %det_school_fall_guy1_pt2;
    level.scr_anim["burke"]["breach_react_blowback_v3"] = %breach_react_blowback_v3;
    level.scr_anim["burke"]["grenade"] = %exposed_grenadethrowb;
    level.scr_anim["burke"]["school_stair_walk"] = %det_school_gate_peek_burke;
    level.scr_anim["burke"]["wall_stack_idle"][0] = %africa_stack_on_wall_idle;
    level.scr_anim["burke"]["wait_by_door"] = [ %det_school_enter_pt1_idle_burke ];
    level.scr_anim["burke"]["go_into_deadroom"] = %det_school_enter_pt2_burke;
    level.scr_anim["burke"]["deadroom_idle"][0] = %det_school_enter_pt2_idle_burke;
    level.scr_anim["generic"]["touch_dead_npc"] = %det_school_enter_pt2_npc_dead_01;
    level.scr_anim["burke"]["burke_school_approach"] = %det_school_wall_burke_schoolapproach;
    level.scr_anim["burke"]["burke_school_approach_into"] = %det_school_wall_burke_schoolapproach_into;
    level.scr_anim["burke"]["burke_school_approach_idle"][0] = %det_school_wall_burke_schoolapproach_idle;
    level.scr_anim["burke"]["burke_school_approach_out"] = %det_school_wall_burke_schoolapproach_out;
    level.scr_anim["burke"]["burke_wall_wait_into"] = %det_school_wall_burke_idle_into;
    level.scr_anim["burke"]["burke_wall_wait_idle"][0] = %det_school_wall_burke_idle;
    level.scr_anim["burke"]["burke_wall_wait_out"] = %det_school_wall_burke_idle_out;
    level.scr_anim["burke"]["burke_goto_trash"] = %det_school_wall_burke_pt1;
    level.scr_anim["burke"]["burke_goto_school"] = %det_school_wall_burke_pt2;
    level.scr_anim["burke"]["burke_stairs_idle"][0] = %det_school_wall_burke_pt2_idle;
    level.scr_anim["burke"]["burke_goto_corner"] = %det_school_enter_pt1_beforecorner_burke;
    level.scr_anim["burke"]["burke_corner_idle"][0] = %det_school_enter_pt1_corner_idle_burke;
    level.scr_anim["burke"]["burke_goto_bodies"] = %det_school_enter_pt1_aftercorner_burke;
    level.scr_anim["burke"]["burke_corner_left_idle"][0] = %det_corner_check_left_loop;
    level.scr_anim["burke"]["burke_stairs_idle_inside"][0] = %det_school_gate_peek_crouch_idle_loop_burke;
    level.scr_anim["burke"]["level_intro_cinematic"] = %det_camp_intro_burke;
    level.scr_anim["joker"]["level_intro_cinematic"] = %det_camp_intro_joker;
    level.scr_anim["intro_guy1"]["level_intro_cinematic"] = %det_camp_intro_guy1;
    level.scr_anim["intro_guy2"]["level_intro_cinematic"] = %det_camp_intro_guy2;
    level.scr_anim["intro_guy3"]["level_intro_cinematic"] = %det_camp_intro_guy3;
    level.scr_anim["intro_guy3"]["post_level_intro_cinematic_idle"][0] = %det_camp_intro_idle_guy3;
    level.scr_anim["burke"]["exit_burke"] = %det_school_enter_pt3_exit_burke;
    level.scr_anim["bones"]["corner_standr_trans_cqb_in_1"] = %corner_standr_trans_cqb_in_1;
    level.scr_anim["bones"]["london_fence_drop"] = %london_fence_drop;
    level.scr_anim["joker"]["africa_stack_on_wall_idle"] = %africa_stack_on_wall_idle;
    level.scr_anim["joker"]["london_fence_drop"] = %london_fence_drop;
    level.scr_anim["doctor"]["research"][0] = %hijack_intro_worker_checklist_loop;
    level.scr_anim["doctor"]["run_away"][0] = %civilian_run_upright;
    level.scr_anim["doctor"]["run_away_reaction"] = %run_react_stumble_non_loop;
    level.scr_anim["burke"]["bike_dismount"] = %det_school_splitup_burke_pt1;
    level.scr_anim["bones"]["bike_dismount"] = %det_school_splitup_bones;
    level.scr_anim["joker"]["bike_dismount"] = %det_school_splitup_joker;
    level.scr_anim["burke"]["dismount_idle"][0] = %det_school_splitup_burke_idle;
    level.scr_anim["burke"]["dismount_rollout"] = %det_school_splitup_burke_pt2;
    level.scr_anim["burke"]["sentinel_reveal"] = %det_meeting_sentinel_burke_part1;
    level.scr_anim["doctor"]["sentinel_reveal"] = %det_meeting_sentinel_doc_part1;
    level.scr_anim["joker"]["sentinel_reveal"] = %det_meeting_sentinel_joker_part1;
    level.scr_anim["burke"]["sentinel_kva_reveal"] = %det_hos_sent_meet_burke;
    level.scr_anim["joker"]["sentinel_kva_reveal"] = %det_hos_sent_meet_joker;
    level.scr_anim["guy1"]["sentinel_kva_reveal"] = %det_hos_sent_meet_guy1;
    level.scr_anim["guy2"]["sentinel_kva_reveal"] = %det_hos_sent_meet_guy2;
    level.scr_anim["guy3"]["sentinel_kva_reveal"] = %det_hos_sent_meet_guy3;
    level.scr_anim["guy1"]["sentinel_kva_reveal_idle"][0] = %det_hos_sent_meet_idle_guy1;
    level.scr_anim["guy2"]["sentinel_kva_reveal_idle"][0] = %det_hos_sent_meet_idle_guy2;
    level.scr_anim["guy3"]["sentinel_kva_reveal_idle"][0] = %det_hos_sent_meet_idle_guy3;
    level.scr_anim["kva1"]["sentinel_kva_reveal"] = %det_hos_sent_meet_kva1;
    maps\_anim::addnotetrack_customfunction( "kva1", "fx_blood01", maps\detroit_fx::det_blood_impact_burst01, "sentinel_kva_reveal" );
    level.scr_anim["kva2"]["sentinel_kva_reveal"] = %det_hos_sent_meet_kva2;
    maps\_anim::addnotetrack_customfunction( "kva2", "fx_blood02", maps\detroit_fx::det_blood_impact_burst02, "sentinel_kva_reveal" );
    level.scr_anim["kva3"]["sentinel_kva_reveal"] = %det_hos_sent_meet_kva3;
    maps\_anim::addnotetrack_customfunction( "kva3", "fx_blood03", maps\detroit_fx::det_blood_impact_burst03, "sentinel_kva_reveal" );
    maps\_anim::addnotetrack_customfunction( "world_body", "slowMo_start", ::sentinel_reveal_slowmo_start, "sentinel_kva_reveal" );
    maps\_anim::addnotetrack_customfunction( "world_body", "slowMo_stop", ::sentinel_reveal_slowmo_stop, "sentinel_kva_reveal" );
    maps\_anim::addnotetrack_customfunction( "world_body", "aud_start_aft_sentinel_meetup", ::sentinel_reveal_dialogue_continue, "sentinel_kva_reveal" );

    if ( level.nextgen || issubstr( level.transient_zone, "_hospital" ) )
    {
        maps\_anim::addnotetrack_customfunction( "guy1", "decloak_1", ::sentinel_reveal_guy1_decloak, "sentinel_kva_reveal" );
        maps\_anim::addnotetrack_customfunction( "guy2", "decloak_2", ::sentinel_reveal_guy2_decloak, "sentinel_kva_reveal" );
        maps\_anim::addnotetrack_customfunction( "guy3", "decloak_3", ::sentinel_reveal_guy3_decloak, "sentinel_kva_reveal" );
    }

    level.scr_anim["burke"]["det_hos_cover180_burke"] = %det_hos_cover180_burke;
    level.scr_anim["burke"]["det_hos_cover180_idle_burke"][0] = %det_hos_cover180_idle_burke;

    if ( level.nextgen || level.transient_zone == "middle" )
        maps\_anim::addnotetrack_customfunction( "burke", "finish", ::begin_stealth_walk, "dismount_rollout" );

    level.scr_anim["generic"]["civilian_run_upright_turnr90"] = %civilian_run_upright_turnr90;
    level.scr_anim["generic"]["civilian_run_upright_turnl90"] = %civilian_run_upright_turnl90;
    level.scr_anim["generic"]["run_and_shoot_behind"] = %flee_run_shoot_behind;
    level.scr_anim["generic"]["hospital_mantle"] = %traverse_mantle_over_low_cover_40_var2;
    level.scr_anim["generic"]["hospital_mantle_2"] = %traverse_mantle_over_low_cover_40_var1;
    level.scr_anim["generic"]["corner_standl_look_2_alert_fast_v1"] = %corner_standl_look_2_alert_fast_v1;
    level.scr_anim["generic"]["covercrouch_hide_look"] = %covercrouch_hide_look;
    level.scr_anim["generic"]["wall_pull"] = %det_school_wall_pull_guy1;

    if ( level.nextgen || issubstr( level.transient_zone, "_school" ) )
    {
        maps\_anim::addnotetrack_customfunction( "generic", "helmet_swap", ::helmet_swap, "wall_pull" );
        maps\_anim::addnotetrack_customfunction( "generic", "helmet_swap", maps\detroit_fx::det_helmet_smash_fx, "wall_pull" );
        maps\_anim::addnotetrack_customfunction( "generic", "stab", maps\detroit_fx::det_knife_stab_fx, "wall_pull" );
        maps\_anim::addnotetrack_customfunction( "generic", "Knife_fx", maps\detroit_fx::det_knife_pull, "wall_pull" );
    }

    level.scr_anim["kva"]["door_open_basement"] = %det_school_patrol_npc;
    level.scr_anim["kva"]["search_flashlight_low_basement_loop"][0] = %so_hijack_search_flashlight_low_loop;
    level.scr_anim["kva"]["so_hijack_search_flashlight_high_loop"][0] = %so_hijack_search_flashlight_high_loop;
    level.scr_anim["kva"]["basement_flashlight_idle"][0] = %det_school_investigate_idle;
    level.scr_anim["kva"]["school_investigate"] = %det_school_investigate;

    if ( level.currentgen && issubstr( level.transient_zone, "_school" ) )
    {

    }

    level.scr_anim["generic"]["paris_npc_dead_poses_v05"] = %paris_npc_dead_poses_v05;
    level.scr_anim["generic"]["paris_npc_dead_poses_v08"] = %paris_npc_dead_poses_v08;
    level.scr_anim["generic"]["deadpose_1"] = %det_school_enter_pt2_npc_deadbody_01;
    level.scr_anim["generic"]["deadpose_2"] = %det_school_enter_pt2_npc_deadbody_02;
    level.scr_anim["generic"]["deadpose_3"] = %det_school_enter_pt2_npc_deadbody_03;
    level.scr_anim["generic"]["deadpose_4"] = %det_school_enter_pt2_npc_deadbody_04;
    level.scr_anim["generic"]["deadpose_5"] = %det_school_enter_pt2_npc_deadbody_05;
    level.scr_anim["generic"]["deadpose_6"] = %det_school_enter_pt2_npc_deadbody_06;
    level.scr_anim["generic"]["deadpose_7"] = %det_school_enter_pt2_npc_deadbody_07;
    level.scr_anim["generic"]["deadpose_8"] = %det_school_enter_pt2_npc_deadbody_08;
    level.scr_anim["generic"]["deadpose_9"] = %det_school_enter_pt2_npc_deadbody_09;
    level.scr_anim["generic"]["deadpose_10"] = %det_school_enter_pt2_npc_deadbody_10;
    level.scr_anim["generic"]["deadpose_11"] = %det_school_enter_pt2_npc_deadbody_11;
    level.scr_anim["generic"]["deadpose_12"] = %det_school_enter_pt2_npc_deadbody_12;
    level.scr_anim["generic"]["civilian_sitting_business_lunch_a_1"][0] = %civilian_sitting_business_lunch_a_1;
    level.scr_anim["generic"]["civilian_sitting_business_lunch_b_1"][0] = %civilian_sitting_business_lunch_b_1;
    level.scr_anim["generic"]["civilian_sitting_talking_a_2"][0] = %civilian_sitting_talking_a_2;
    level.scr_anim["generic"]["civilian_sitting_talking_b_1"][0] = %civilian_sitting_talking_b_1;
    level.scr_anim["generic"]["civilian_sitting_talking_b_2"][0] = %civilian_sitting_talking_b_2;
    level.scr_anim["generic"]["civilian_stand_idle"][0] = %civilian_stand_idle;
    level.scr_anim["generic"]["patrol_bored_idle_cellphone"][0] = %patrol_bored_idle_cellphone;
    level.scr_anim["generic"]["patrol_bored_idle"][0] = %patrol_bored_idle;
    level.scr_anim["generic"]["patrol_bored_idle_smoke"][0] = %patrol_bored_idle_smoke;
    level.scr_anim["generic"]["patrolstand_idle"][0] = %patrolstand_idle;
    level.scr_anim["generic"]["casual_crouch_idle"][0] = %casual_crouch_idle;
    level.scr_anim["generic"]["casual_stand_idle"][0] = %casual_stand_idle;
    maps\_anim::addnotetrack_customfunction( "generic", "attach cig", ::cig_hide, "patrol_bored_idle_smoke" );
    maps\_anim::addnotetrack_customfunction( "generic", "detach cig", ::cig_show, "patrol_bored_idle_smoke" );
    level.scr_anim["generic"]["door_kick_in"] = %door_kick_in;
    level.scr_anim["generic"]["window_smash_stop_inside"] = %window_smash_stop_inside;
    level.scr_anim["generic"]["talking_guard_1"][0] = %hms_greece_cc_talking_guards_1;
    level.scr_anim["generic"]["talking_guard_2"][0] = %hms_greece_cc_talking_guards_2;
    level.scr_anim["generic"]["active_patrolwalk_v1"][0] = %active_patrolwalk_v1;
    level.scr_anim["generic"]["active_patrolwalk_v2"][0] = %active_patrolwalk_v2;
    level.scr_anim["generic"]["active_patrolwalk_v3"][0] = %active_patrolwalk_v3;
    level.scr_anim["generic"]["active_patrolwalk_v4"][0] = %active_patrolwalk_v4;
    level.scr_anim["generic"]["active_patrolwalk_v5"][0] = %active_patrolwalk_v5;
    level.scr_anim["generic"]["crouch_up"] = %crouch2stand;
    level.scr_anim["generic"]["crouch_over"] = %covercrouch_hide_2_shufflel;
    level.patrol_anims = [ "active_patrolwalk_v1", "active_patrolwalk_v2", "active_patrolwalk_v3", "active_patrolwalk_v4", "active_patrolwalk_v5" ];
    level.scr_anim["generic"]["bored_patrolwalk_1"][0] = %patrol_bored_2_walk;
    level.scr_anim["generic"]["bored_patrolwalk_2"][0] = %patrol_bored_patrolwalk_twitch;
    level.scr_anim["generic"]["bored_patrolwalk_3"][0] = %patrol_boredwalk_lookcycle_a;
    level.scr_anim["generic"]["bored_patrolwalk_4"][0] = %patrol_boredwalk_lookcycle_b;
    level.bored_patrol_anims = [ "bored_patrolwalk_1", "bored_patrolwalk_2", "bored_patrolwalk_3", "bored_patrolwalk_4" ];
    level.scr_anim["generic"]["urinate_hold"][0] = %escalator_down_briefcase_guy_idle;
    level.scr_anim["crash_anim"]["crash_guy1"] = %det_finale_crash_guy1;
    level.scr_anim["generic"]["det_camp_stagespeech_guy01"][0] = %det_camp_stagespeech_guy01;
    level.scr_anim["Atlas_Commander"]["det_camp_stagespeech_guy01"] = %det_camp_stagespeech_guy01;
    level.scr_anim["Atlas_Commander"]["det_camp_stagespeech_walk"] = %det_camp_foodtruck_civ_grab_walk_loop;
    level.scr_anim["generic"]["so_hijack_search_flashlight_high_loop"][0] = %so_hijack_search_flashlight_high_loop;
    level.scr_anim["generic"]["so_hijack_search_flashlight_high_loop_single"] = %so_hijack_search_flashlight_high_loop;
    level.scr_anim["generic"]["so_hijack_search_flashlight_low_loop"][0] = %so_hijack_search_flashlight_low_loop;
    level.scr_anim["generic"]["so_hijack_search_flashlight_low_single"] = %so_hijack_search_flashlight_low_loop;
    level.scr_anim["generic"]["spraypaint_idle"][0] = %det_camp_spraypaint_civ_idle_guy01;
    level.scr_anim["generic"]["spraypaint"] = %det_camp_spraypaint_civ_guy01;
    level.scr_anim["generic"]["chase_away"] = %det_camp_spraypaint_civ_guy02;
    level.scr_anim["generic"]["casual_killer_walk_wave"] = %casual_killer_walk_wave;
    level.scr_anim["generic"]["depressed_walk"][0] = %det_camp_depressedwalk_civ_d;
    level.scr_anim["generic"]["depressed_walk"][1] = %det_camp_depressedwalk_civ_pickup;
    level.scr_anim["generic"]["depressed_walk"][2] = %det_depressedwalk_alt_lookl;
    level.scr_anim["generic"]["depressed_walk"][3] = %det_depressedwalk_alt_lookup;
    level.scr_anim["generic"]["det_school_flashlight_loop"][0] = %det_school_flashlight_loop;
    level.scr_anim["generic"]["det_school_flashlight_single"] = %det_school_flashlight_loop;
    level.scr_anim["generic"]["stealth_walk"][0] = %stealth_walk;
    level.scr_anim["generic"]["_stealth_look_around"][0] = %det_school_flashlight_loop;
    level.scr_anim["generic"]["_stealth_look_around"][1] = %so_hijack_search_flashlight_low_loop;
    level.scr_anim["generic"]["exposed_death_flop"] = %exposed_death_flop;
    level.scr_anim["generic"]["airport_civ_pillar_exit_death"] = %airport_civ_pillar_exit_death;
    level.scr_anim["burke"]["doctor_capture"] = %det_doctor_capture_burke_hit_doc;
    level.scr_anim["burke"]["doctor_capture_idle"][0] = %det_doctor_capture_burke_idle;
    level.scr_anim["doctor"]["doctor_capture_idle"][0] = %det_doctor_capture_doc_idle;
    level.scr_anim["doctor"]["doctor_capture"] = %det_doctor_capture_doc_react;
    level.scr_anim["joker"]["doctor_capture"] = %det_doctor_capture_joker_grab_doc;
    level.scr_anim["joker"]["doctor_capture_idle"][0] = %det_doctor_capture_joker_idle;
    level.scr_anim["generic"]["det_hos_breach_guy1"] = %det_hos_breach_guy1;
    level.scr_anim["generic"]["det_hos_breach_guy3"] = %det_hos_breach_guy3;
    level.scr_anim["generic"]["det_hos_breach_guy4"] = %det_hos_breach_guy4;
    level.scr_anim["doctor"]["det_hos_breach_idle_doctor"][0] = %det_hos_breach_idle_doctor;
    level.scr_anim["generic"]["det_hos_breach_success_guy1"] = %det_hos_breach_success_guy1;
    level.scr_anim["generic"]["det_hos_breach_success_guy3"] = %det_hos_breach_success_guy3;
    level.scr_anim["generic"]["det_hos_breach_success_guy4"] = %det_hos_breach_success_guy4;

    if ( level.nextgen || issubstr( level.transient_zone, "_hospital" ) )
        maps\_anim::addnotetrack_customfunction( "generic", "hadoken", ::hospital_breach_punch, "det_hos_breach_success_guy4" );

    level.scr_goaltime["generic"]["det_hos_breach_success_guy4"] = 0;
    level.scr_anim["generic"]["det_hos_breach_aim_idle_guy1"][0] = %det_hos_breach_aim_idle_guy1;
    level.scr_anim["generic"]["det_hos_breach_aim_idle_guy3"][0] = %det_hos_breach_aim_idle_guy3;
    level.scr_anim["generic"]["casual_walk_fast_burke"] = %det_casual_walk_fast_burke;
    level.scr_anim["generic"]["casual_walk_fast_joker"] = %det_casual_walk_fast_joker;
    level.scr_anim["burke"]["refugee_camp_walk_fast"] = %det_casual_walk_fast_burke;
    level.scr_anim["joker"]["refugee_camp_walk_fast"] = %det_casual_walk_fast_joker;
    level.scr_anim["burke"]["refugee_camp_idle"][0] = %det_casual_stopstarts_idle_burke;
    level.scr_anim["joker"]["refugee_camp_idle"][0] = %det_casual_stopstarts_idle_joker;
    level.scr_anim["burke"]["refugee_camp_idle_to_walk"] = %det_casual_stopstarts_idle_to_walk_burke;
    level.scr_anim["joker"]["refugee_camp_idle_to_walk"] = %det_casual_stopstarts_idle_to_walk_joker;
    level.scr_anim["burke"]["refugee_camp_walk_to_idle"] = %det_casual_stopstarts_walk_to_idle_burke;
    level.scr_anim["joker"]["refugee_camp_walk_to_idle"] = %det_casual_stopstarts_walk_to_idle_joker;
    level.scr_anim["burke"]["det_hos_breach_burke"] = %det_hos_breach_burke;
    level.scr_anim["doctor"]["det_hos_breach_doctor"] = %det_hos_breach_doctor;
    level.scr_anim["generic"]["det_hos_breach_fail_guy4"] = %det_hos_breach_fail_guy4;
    level.scr_anim["doctor"]["carry_doc_lift"] = %det_doctor_capture_pickup_doc;

    if ( level.nextgen || issubstr( level.transient_zone, "_hospital" ) )
        maps\_anim::addnotetrack_customfunction( "doctor", "swap_bag_head", ::doc_capture_headswap, "carry_doc_lift" );

    level.scr_anim["joker"]["carry_doc_lift"] = %det_doctor_capture_pickup_joker;
    level.scr_anim["doctor"]["carry_doc_downstairs_loop"] = %det_hos_carry_doc_downstairs_guy1;
    level.scr_anim["joker"]["carry_doc_downstairs_loop"] = %det_hos_carry_doc_downstairs_guy2;
    level.scr_anim["doctor"]["carry_doc_upstairs_loop"] = %det_hos_carry_doc_upstairs_guy1;
    level.scr_anim["joker"]["carry_doc_upstairs_loop"] = %det_hos_carry_doc_upstairs_guy2;
    level.scr_anim["doctor"]["carry_doc_stop"] = %det_hos_carry_doc_walkstop_idle_guy1;
    level.scr_anim["joker"]["carry_doc_stop"] = %det_hos_carry_doc_walkstop_idle_guy2;
    level.scr_anim["doctor"]["carry_doc_walk"] = %det_hos_carry_doc_walk_guy1;
    level.scr_anim["joker"]["carry_doc_walk"] = %det_hos_carry_doc_walk_guy2;
    level.scr_anim["burke"]["det_exit_drive_starting_anim_1"] = %det_exfil_droponbike_enter_burke;
    level.scr_anim["burke"]["det_exit_drive_starting_idle_1"][0] = %det_exfil_droponbike_enteridle_burke;
    level.scr_anim["burke"]["det_exit_drive_starting_anim_2"] = %det_exfil_droponbike_drop_burke;
    level.scr_anim["joker"]["det_exit_drive_starting_anim_2"] = %det_exfil_droponbike_drop_joker;
    level.scr_anim["doctor"]["det_exit_drive_starting_anim_2"] = %det_exfil_droponbike_drop_doc;
    level.scr_anim["doctor"]["det_exit_drive_starting_idle_2"][0] = %det_exfil_droponbike_dropidle_doc;
    level.scr_anim["joker"]["det_exit_drive_starting_idle_2"][0] = %det_exfil_droponbike_dropidle_joker;
    level.scr_anim["burke"]["det_exit_drive_ending"] = %det_mech_laydown_cover_burke;
    level.scr_anim["bones"]["det_exit_drive_ending"] = %det_mech_laydown_cover_bones;
    level.scr_anim["joker"]["det_exit_drive_ending"] = %det_mech_laydown_cover_joker;
    level.scr_anim["doctor"]["det_exit_drive_ending"] = %det_mech_laydown_cover_doc;
    level.scr_anim["exitdrive_mech1"]["det_exit_drive_ending"] = %det_mech_laydown_cover_mech1;
    level.scr_anim["exitdrive_mech1"]["det_exit_drive_ending_idle"][0] = %det_mech_laydown_cover_mech1_idle;
    level.scr_anim["exitdrive_mech2"]["det_exit_drive_ending"] = %det_mech_laydown_cover_mech2;
    level.scr_anim["exitdrive_mech2"]["det_exit_drive_ending_idle"][0] = %det_mech_laydown_cover_mech2_idle;
    level.scr_anim["exitdrive_mech3"]["det_exit_drive_ending"] = %det_mech_laydown_cover_mech3;
    level.scr_anim["exitdrive_mech3"]["det_exit_drive_ending_idle"][0] = %det_mech_laydown_cover_mech3_idle;
    level.scr_anim["burke"]["exo_push_exit"] = %det_hos_vehicle_push_burke_push_exit;
    level.scr_anim["burke"]["exo_push_burke_attach"] = %det_hos_vehicle_push_burke_push_intro;
    level.scr_anim["burke"]["exo_push_burke_wait"][0] = %det_hos_vehicle_push_burke_push_intro_idle;
    level.scr_anim["burke"]["exo_push_loop"][0] = %det_hos_vehicle_push_burke_push_loop;
    level.scr_anim["burke"]["exo_push_idle"][0] = %det_hos_vehicle_push_burke_push_loop;
    level.scr_anim["burke"]["exo_push_loop_to_idle"] = %det_hos_vehicle_push_burke_push_trans_out;
    level.scr_anim["burke"]["gate_decon"] = %det_gate_decon_burke;
    level.scr_anim["joker"]["gate_decon"] = %det_gate_decon_joker;
    level.scr_anim["bones"]["gate_decon_b"] = %det_gate_decon_bones;
    level.scr_anim["burke"]["gate_decon_idle"][0] = %det_gate_decon_wait_burke;
    level.scr_anim["joker"]["gate_decon_idle"][0] = %det_gate_decon_wait_joker;
    level.scr_anim["burke"]["gate_decon_b"] = %det_gate_decon_burke_b;
    level.scr_anim["joker"]["gate_decon_b"] = %det_gate_decon_joker_b;

    if ( level.nextgen || level.transient_zone == "intro" )
    {
        maps\_anim::addnotetrack_customfunction( "bones", "finish", maps\detroit_refugee_camp::notify_guy_mounted, "gate_decon_b" );
        maps\_anim::addnotetrack_customfunction( "joker", "finish", maps\detroit_refugee_camp::notify_guy_mounted, "gate_decon_b" );
    }

    level.scr_anim["scanner_guard_animated_spawner"]["gate_decon"] = %det_gate_decon_guard2;
    level.scr_anim["scanner_guard_animated_spawner"]["gate_decon_b"] = %det_gate_decon_guard2_b;
    level.scr_anim["scanner_guard_animated_spawner"]["gate_decon_idle"][0] = %casual_stand_idle;
    level.scr_anim["scanner_guy_animated_spawner01"]["gate_decon"] = %det_gate_decon_guy1;
    level.scr_anim["scanner_guy_animated_spawner02"]["gate_decon"] = %det_gate_decon_guy2;
    level.scr_anim["scanner_guy_animated_spawner03"]["gate_decon"] = %det_gate_decon_guy3;
    level.scr_anim["scanner_guy_animated_spawner04"]["gate_decon"] = %det_gate_decon_guy4;
    level.scr_anim["scanner_guy_animated_spawner05"]["gate_decon"] = %det_gate_decon_guy5;
    level.scr_anim["scanner_guy_animated_spawner06"]["gate_decon"] = %det_gate_decon_guy6;
    level.scr_anim["scanner_guy_animated_spawner01"]["gate_decon_idle"][0] = %det_unarmed_casual_idle;
    level.scr_anim["scanner_guy_animated_spawner02"]["gate_decon_idle"][0] = %det_unarmed_casual_idle;
    level.scr_anim["scanner_guy_animated_spawner03"]["gate_decon_idle"][0] = %det_unarmed_casual_idle;
    level.scr_anim["scanner_guy_animated_spawner04"]["gate_decon_idle"][0] = %det_unarmed_casual_idle;
    level.scr_anim["scanner_guy_animated_spawner05"]["gate_decon_idle"][0] = %det_unarmed_casual_idle;
    level.scr_anim["scanner_guy_animated_spawner06"]["gate_decon_idle"][0] = %det_unarmed_casual_idle;
    level.scr_anim["scanner_guard_animated_spawner01"]["gate_decon_idle"][0] = %casual_stand_idle;
    level.scr_anim["scanner_guard_animated_spawner01"]["gate_decon"] = %det_gate_decon_guard1;
    level.scr_anim["scanner_guy_animated_spawner01"]["gate_decon_walk"] = %det_motorpool_casual_walk;
    level.scr_anim["scanner_guy_animated_spawner02"]["gate_decon_walk"] = %det_motorpool_casual_walk;
    level.scr_anim["scanner_guy_animated_spawner03"]["gate_decon_walk"] = %det_motorpool_casual_walk;
    level.scr_anim["scanner_guy_animated_spawner04"]["gate_decon_walk"] = %det_motorpool_casual_walk;
    level.scr_anim["scanner_guy_animated_spawner05"]["gate_decon_walk"] = %det_motorpool_casual_walk;
    level.scr_anim["scanner_guy_animated_spawner06"]["gate_decon_walk"] = %det_motorpool_casual_walk;
    level.scr_anim["generic"]["gate_decon_walk"] = %det_motorpool_casual_walk;
    maps\_anim::addnotetrack_notify( "scanner_guard_animated_spawner01", "group1_start", "decon_a", "gate_decon" );
    maps\_anim::addnotetrack_notify( "scanner_guard_animated_spawner01", "group2_start", "decon_b", "gate_decon" );
    maps\_anim::addnotetrack_notify( "scanner_guard_animated_spawner01", "group2_2_start", "decon_c", "gate_decon" );
    maps\_anim::addnotetrack_notify( "scanner_guard_animated_spawner01", "group3_start", "decon_d", "gate_decon" );
    maps\_anim::addnotetrack_notify( "scanner_guard_animated_spawner01", "group3_2_start", "decon_e", "gate_decon" );
}

civilian_anims()
{
    level.scr_anim["civilian_looper"]["civilian_walk"] = [ %civilian_briefcase_walk, %civilian_cellphonewalk, %civilian_crazywalker_loop, %civilian_crazywalker_twitcha, %civilian_crazywalker_twitchb, %civilian_crazywalker_twitchc, %civilian_walk_coffee, %civilian_walk_cool, %civilian_walk_hurried_1, %civilian_walk_hurried_2, %civilian_walk_nervous, %civilian_walk_paper, %civilian_walk_pda, %civilian_walk_backpack ];
    level.scr_anim["civilian_looper"]["civilian_stand"] = [ %civilian_smoking_a, %civilian_smoking_b, %civilian_atm, %civilian_stand_idle, %london_civ_idle_checkwatch, %london_civ_idle_foldarms2, %london_civ_idle_foldarms_scratchass, %london_civ_idle_lookbehind, %london_civ_idle_lookover, %london_civ_idle_scratchnose, %london_civ_idle_sneeze ];
    level.scr_anim["civilian_looper"]["civilian_sit"] = [ %civilian_sitting_business_lunch_a_1, %civilian_sitting_business_lunch_b_1, %civilian_sitting_talking_a_1, %civilian_sitting_talking_a_2, %civilian_sitting_talking_b_1, %civilian_sitting_talking_b_2, %civilian_texting_sitting, %civilian_reader_1, %sitting_guard_loadak_idle, %guarda_sit_sleeper_idle, %parabolic_leaning_guy_idle, %det_camp_box_seated_civ_guy01, %det_camp_box_seated_civ_guy02, %det_camp_box_seated_civ_guy02, %civilian_reader_2 ];
    level.scr_animtree["drone_civs"] = #animtree;
    level.scr_anim["drone_civs"]["civilian_cellphonewalk"][0] = %civilian_cellphonewalk;
    level.scr_anim["drone_civs"]["civilian_crazywalker_loop"][0] = %civilian_crazywalker_loop;
    level.scr_anim["drone_civs"]["civilian_walk_backpack"][0] = %civilian_walk_backpack;
    level.scr_anim["drone_civs"]["civilian_walk_pda"][0] = %civilian_walk_pda;
    level.scr_anim["drone_civs"]["civilian_walk_nervous"][0] = %civilian_walk_nervous;
    level.scr_anim["drone_civs"]["civilian_walk_hurried_2"][0] = %civilian_walk_hurried_2;
    level.scr_anim["drone_civs"]["civilian_walk_cool"][0] = %civilian_walk_cool;
    level.scr_anim["drone_civs"]["civilian_walk_coffee"][0] = %civilian_walk_coffee;
    level.scr_anim["drone_civs"]["civilian_walk_hurried_1"][0] = %civilian_walk_hurried_1;
    level.scr_anim["drone_civs"]["civilian_smoking_a"][0] = %civilian_smoking_a;
    level.scr_anim["drone_civs"]["civilian_smoking_b"][0] = %civilian_smoking_b;
    level.scr_anim["drone_civs"]["civilian_atm"][0] = %civilian_atm;
    level.scr_anim["drone_civs"]["civilian_stand_idle"][0] = %civilian_stand_idle;
    level.scr_anim["drone_civs"]["london_civ_idle_checkwatch"][0] = %london_civ_idle_checkwatch;
    level.scr_anim["drone_civs"]["london_civ_idle_foldarms2"][0] = %london_civ_idle_foldarms2;
    level.scr_anim["drone_civs"]["london_civ_idle_lookbehind"][0] = %london_civ_idle_lookbehind;
    level.scr_anim["drone_civs"]["london_civ_idle_foldarms_scratchass"][0] = %london_civ_idle_foldarms_scratchass;
    level.scr_anim["drone_civs"]["london_civ_idle_scratchnose"][0] = %london_civ_idle_scratchnose;
    level.scr_anim["drone_civs"]["civilian_sitting_business_lunch_a_1"][0] = %civilian_sitting_business_lunch_a_1;
    level.scr_anim["drone_civs"]["civilian_sitting_business_lunch_b_1"][0] = %civilian_sitting_business_lunch_b_1;
    level.scr_anim["drone_civs"]["civilian_sitting_talking_a_1"][0] = %civilian_sitting_talking_a_1;
    level.scr_anim["drone_civs"]["civilian_sitting_talking_a_2"][0] = %civilian_sitting_talking_a_2;
    level.scr_anim["drone_civs"]["civilian_sitting_talking_b_1"][0] = %civilian_sitting_talking_b_1;
    level.scr_anim["drone_civs"]["civilian_sitting_talking_b_2"][0] = %civilian_sitting_talking_b_2;
    level.scr_anim["drone_civs"]["civilian_texting_sitting"][0] = %civilian_texting_sitting;
    level.scr_anim["drone_civs"]["civilian_reader_1"][0] = %civilian_reader_1;
    level.scr_anim["drone_civs"]["civilian_reader_2"][0] = %civilian_reader_2;
    level.scr_anim["drone_civs"]["sitting_guard_loadak_idle"][0] = %sitting_guard_loadak_idle;
    level.scr_anim["drone_civs"]["guarda_sit_sleeper_idle"][0] = %guarda_sit_sleeper_idle;
    level.scr_anim["drone_civs"]["parabolic_leaning_guy_idle"][0] = %parabolic_leaning_guy_idle;
    level.scr_anim["drone_civs"]["civilian_stand_idle"][0] = %civilian_stand_idle;
    level.scr_anim["drone_civs"]["det_camp_box_seated_civ_guy01"][0] = %det_camp_box_seated_civ_guy01;
    level.scr_anim["drone_civs"]["det_camp_box_seated_civ_guy02"][0] = %det_camp_box_seated_civ_guy02;
    level.scr_anim["drone_civs"]["det_camp_seated_civ_guy01"][0] = %det_camp_seated_civ_guy01;
    level.scr_anim["drone_civs"]["det_camp_seated_civ_guy02"][0] = %det_camp_seated_civ_guy02;
    level.scr_anim["drone_civs"]["fence_spawner1"][0] = %det_camp_handsonfence_guy01;
    level.scr_anim["drone_civs"]["fence_spawner2"][0] = %det_camp_handsonfence_guy02;
    level.scr_anim["drone_civs"]["fence_spawner3"][0] = %det_camp_leanfence_guy01;
    level.scr_anim["drone_civs"]["fence_spawner4"][0] = %det_camp_leanfence_guy02_a;
    level.scr_anim["drone_civs"]["fence_spawner5"][0] = %det_camp_leanfence_guy02_b;
    level.scr_anim["drone_civs"]["fence_spawner6"][0] = %det_camp_sitfence_guy01;
    level.scr_anim["drone_civs"]["fence_spawner7"][0] = %det_camp_leanfence_guy02_b;
    level.scr_anim["drone_civs"]["fence_spawner8"][0] = %det_camp_handsonfence_guy02;
    level.scr_anim["drone_civs"]["fence_spawner9_idle_start"][0] = %det_camp_leanfence_guy01;
    level.scr_anim["drone_civs"]["fence_spawner9_transition"] = %det_camp_leanfence_2_sitfence;
    level.scr_anim["drone_civs"]["fence_spawner9_idle_end"][0] = %det_camp_sitfence_guy01;
    level.scr_anim["drone_civs"]["fence_spawner10"][0] = %det_camp_leanfence_guy01;
    level.scr_anim["drone_civs"]["fence_spawner11"][0] = %det_camp_leanfence_guy01;
    level.scr_anim["drone_civs"]["baseball1"][0] = %det_camp_baseball_guy01;
    level.scr_anim["drone_civs"]["baseball2"][0] = %det_camp_baseball_guy02;
    level.scr_anim["drone_civs"]["civtalking1"] = %det_standtalk_civ_guy1;
    level.scr_anim["drone_civs"]["civtalking2"] = %det_standtalk_civ_guy2;
    level.scr_anim["drone_civs"]["foodtruck1"][0] = %det_camp_foodtruck_civ_01;
    level.scr_anim["drone_civs"]["foodtruck2"][0] = %det_camp_foodtruck_civ_02;
    level.scr_anim["drone_civs"]["foodtruck3"][0] = %det_camp_foodtruck_civ_03;
    level.scr_anim["drone_civs"]["foodtruck4"][0] = %det_camp_foodtruck_civ_04;
    level.scr_anim["drone_civs"]["foodtruck5"][0] = %det_camp_foodtruck_civ_05;
    level.scr_anim["drone_civs"]["foodtruck6"][0] = %det_camp_foodtruck_civ_06;
    level.scr_anim["drone_civs"]["foodtruck7"][0] = %det_camp_foodtruck_civ_07;
    level.scr_anim["drone_civs"]["foodtruck8"][0] = %det_camp_foodtruck_civ_08;
    level.scr_anim["drone_civs"]["foodtruck9"][0] = %det_camp_foodtruck_civ_09;
    level.scr_anim["drone_civs"]["foodtruck10"][0] = %det_camp_foodtruck_civ_10;
    level.scr_anim["drone_civs"]["foodtruck11"][0] = %det_camp_foodtruck_civ_11;
    level.scr_anim["drone_civs"]["foodtruck12"][0] = %det_camp_foodtruck_civ_12;
    level.scr_anim["drone_civs"]["foodtruck13"][0] = %det_camp_foodtruck_civ_13;
    level.scr_anim["drone_civs"]["foodtruck14"][0] = %det_camp_foodtruck_civ_14;
    level.scr_anim["drone_civs"]["foodtruck_grab"] = %det_camp_foodtruck_civ_grab;
    level.scr_anim["drone_civs"]["foodtruck_grab_left"] = %det_camp_foodtruck_civ_grab_left;
    level.scr_anim["drone_civs"]["foodtruck_grab_walk"] = %det_camp_foodtruck_civ_grab_walk_loop;
    level.scr_anim["drone_civs"]["foodtruck17"][0] = %det_camp_foodtruck_handoutguy_01;
    level.scr_anim["drone_civs"]["foodtruck18"][0] = %det_camp_foodtruck_handoutguy_02;
    maps\_anim::addnotetrack_notify( "drone_civs", "grab_walk", "food_walker_go", "foodtruck17" );
    level.scr_anim["drone_civs"]["sign1_spawner"][0] = %london_civ_idle_lookover;
    level.scr_anim["drone_civs"]["sign2_spawner"][0] = %det_camp_trans_alley_gawk_pair_01;
    level.scr_anim["drone_civs"]["sign3_spawner"][0] = %det_camp_trans_alley_gawk_pair_02;
    level.scr_anim["drone_civs"]["sign4_spawner"][0] = %london_civ_idle_foldarms2;
    level.scr_animtree["hospital_drone"] = #animtree;
    level.scr_anim["hospital_drone"]["paris_npc_dead_poses_v05"] = %paris_npc_dead_poses_v05;
    level.scr_anim["hospital_drone"]["paris_npc_dead_poses_v08"] = %paris_npc_dead_poses_v08;
    level.drone_anims["civ_team1"]["stand"]["run"] = %civilian_cellphonewalk;
    level.drone_anims["civ_team2"]["stand"]["run"] = %civilian_crazywalker_loop;
    level.drone_anims["civ_team3"]["stand"]["run"] = %civilian_walk_backpack;
    level.drone_anims["civ_team4"]["stand"]["run"] = %civilian_walk_pda;
    level.drone_anims["civ_team5"]["stand"]["run"] = %civilian_walk_nervous;
    level.drone_anims["civ_team6"]["stand"]["run"] = %civilian_walk_hurried_2;
    level.drone_anims["civ_team7"]["stand"]["run"] = %civilian_walk_cool;
    level.drone_anims["civ_team8"]["stand"]["run"] = %civilian_walk_coffee;
    level.drone_anims["civ_team9"]["stand"]["run"] = %civilian_walk_hurried_1;
    level.drone_anims["civ_team1"]["stand"]["idle"] = %civilian_smoking_a;
    level.drone_anims["civ_team2"]["stand"]["idle"] = %civilian_smoking_b;
    level.drone_anims["civ_team3"]["stand"]["idle"] = %civilian_atm;
    level.drone_anims["civ_team4"]["stand"]["idle"] = %civilian_stand_idle;
    level.drone_anims["civ_team5"]["stand"]["idle"] = %london_civ_idle_checkwatch;
    level.drone_anims["civ_team6"]["stand"]["idle"] = %london_civ_idle_foldarms2;
    level.drone_anims["civ_team7"]["stand"]["idle"] = %london_civ_idle_lookbehind;
    level.drone_anims["civ_team8"]["stand"]["idle"] = %london_civ_idle_foldarms_scratchass;
    level.drone_anims["civ_team9"]["stand"]["idle"] = %london_civ_idle_scratchnose;
    level.drone_anims["civ_idle1"]["stand"]["idle"] = %civilian_sitting_business_lunch_a_1;
    level.drone_anims["civ_idle2"]["stand"]["idle"] = %civilian_sitting_business_lunch_b_1;
    level.drone_anims["civ_idle3"]["stand"]["idle"] = %civilian_sitting_talking_a_1;
    level.drone_anims["civ_idle4"]["stand"]["idle"] = %civilian_sitting_talking_a_2;
    level.drone_anims["civ_idle5"]["stand"]["idle"] = %civilian_sitting_talking_b_1;
    level.drone_anims["civ_idle6"]["stand"]["idle"] = %civilian_sitting_talking_b_2;
    level.drone_anims["civ_idle7"]["stand"]["idle"] = %civilian_texting_sitting;
    level.drone_anims["civ_idle8"]["stand"]["idle"] = %civilian_reader_1;
    level.drone_anims["civ_idle9"]["stand"]["idle"] = %civilian_reader_2;
}

#using_animtree("vehicles");

vehicle_anims_toload()
{
    level.scr_animtree["ambulance"] = #animtree;
    level.scr_model["ambulance"] = "vehicle_atlas_suv";
    level.scr_anim["ambulance"]["exo_push_path"] = %det_hos_vehicle_push_vehicle_path;
    level.scr_anim["ambulance"]["exo_push_burke_attach"] = %det_hos_vehicle_push_vehicle_push_intro;
    level.scr_anim["ambulance"]["exo_push_attach"] = %det_hos_vehicle_push_vehicle_rest;
    level.scr_anim["ambulance"]["exo_push_loop"][0] = %det_hos_vehicle_push_vehicle_push_loop;
    level.scr_anim["ambulance"]["exo_push_idle"][0] = %det_hos_vehicle_push_vehicle_rest;
    level.scr_anim["ambulance"]["exo_push_idle_to_loop"] = %det_hos_vehicle_push_vehicle_trans_in;
    level.scr_anim["ambulance"]["exo_push_loop_to_idle"] = %det_hos_vehicle_push_vehicle_trans_out;
    level.scr_animtree["player_bike"] = #animtree;
    level.scr_anim["player_bike"]["hoverbike_pre_mount"][0] = %det_motorpool_meet_up_idle_hoverbike;
    level.scr_anim["burke_bike"]["hoverbike_pre_mount"][0] = %det_motorpool_meet_up_idle_hoverbike1;
    level.scr_anim["bones_bike"]["hoverbike_pre_mount"][0] = %det_motorpool_meet_up_idle_hoverbike2;
    level.scr_anim["joker_bike"]["hoverbike_pre_mount"][0] = %det_motorpool_meet_up_idle_hoverbike3;
    level.scr_anim["bones_bike"]["hoverbike_kickstand"] = %det_hoverbike_mount_hoverbike2;
    level.scr_anim["joker_bike"]["hoverbike_kickstand"] = %det_hoverbike_mount_hoverbike3;
    maps\_anim::addnotetrack_customfunction( "bones_bike", "bike_powerup", maps\detroit_refugee_camp::notify_bike_hover, "hoverbike_kickstand" );
    maps\_anim::addnotetrack_customfunction( "joker_bike", "bike_powerup", maps\detroit_refugee_camp::notify_bike_hover, "hoverbike_kickstand" );
    level.scr_anim["player_bike"]["hoverbike_mount"] = %det_hoverbike_mount_hoverbike;
    level.scr_anim["player_bike"]["hoverbike_mount_left"] = %det_hoverbike_mount_left_hoverbike;
    level.scr_anim["burke_bike"]["hoverbike_mount"] = %det_hoverbike_mount_hoverbike1;
    level.scr_anim["bones_bike"]["hoverbike_mount"] = %det_hoverbike_mount_hoverbike2;
    level.scr_anim["joker_bike"]["hoverbike_mount"] = %det_hoverbike_mount_hoverbike3;
    maps\_anim::addnotetrack_customfunction( "player_bike", "hoverbike_VM_swap", ::player_bike_to_vm_model, "hoverbike_mount" );
    maps\_anim::addnotetrack_customfunction( "player_bike", "hoverbike_VM_swap", ::player_bike_to_vm_model, "hoverbike_mount_left" );
    level.scr_anim["player_bike"]["hoverbike_meet_up"] = %det_motorpool_meet_up_hoverbike;
    level.scr_anim["burke_bike"]["hoverbike_meet_up"] = %det_motorpool_meet_up_hoverbike1;
    level.scr_anim["bones_bike"]["hoverbike_meet_up"] = %det_motorpool_meet_up_hoverbike2;
    level.scr_anim["joker_bike"]["hoverbike_meet_up"] = %det_motorpool_meet_up_hoverbike3;
    level.scr_animtree["warbird_ext"] = #animtree;
    level.scr_model["warbird_ext"] = "vehicle_xh9_warbird_mp";
    level.scr_anim["warbird_ext"]["level_intro_cinematic"] = %det_camp_intro_warbird;
    level.scr_animtree["warbird_int"] = #animtree;
    level.scr_model["warbird_int"] = "vehicle_xh9_warbird_interior_only";
    level.scr_anim["warbird_int"]["level_intro_cinematic"] = %det_camp_intro_warbird;
    level.scr_anim["burke_bike"]["bike_dismount"] = %det_school_splitup_burkebike;
    level.scr_anim["bones_bike"]["bike_dismount"] = %det_school_splitup_bonesbike;
    level.scr_anim["joker_bike"]["bike_dismount"] = %det_school_splitup_jokerbike;
    level.scr_anim["player_bike"]["bike_dismount"] = %det_school_splitup_vmbike;
    level.scr_anim["burke_bike"]["det_exit_drive_starting_anim_1"] = %det_exfil_droponbike_enter_burkebike;
    level.scr_anim["burke_bike"]["det_exit_drive_starting_idle_1"][0] = %det_exfil_droponbike_enteridle_burkebike;
    level.scr_anim["player_bike"]["det_exit_drive_starting_idle_1"][0] = %det_exfil_droponbike_enteridle_playerbike;
    level.scr_anim["joker_bike"]["det_exit_drive_starting_idle_1"][0] = %det_exfil_droponbike_enteridle_jokerbike;
    level.scr_anim["bones_bike"]["det_exit_drive_starting_idle_1"][0] = %det_exfil_droponbike_enteridle_bonesbike;
    level.scr_anim["burke_bike"]["det_exit_drive_starting_anim_2"] = %det_exfil_droponbike_drop_burkebike;
    level.scr_anim["joker_bike"]["det_exit_drive_starting_anim_2"] = %det_exfil_droponbike_drop_jokerbike;
    level.scr_anim["joker_bike"]["det_exit_drive_starting_idle_2"][0] = %det_exfil_droponbike_dropidle_jokerbike;
    level.scr_animtree["littlebird"] = #animtree;
    level.scr_model["littlebird"] = "vehicle_mil_helicopter_littlebird_kva_ai";
    level.scr_anim["littlebird"]["det_exit_drive_ending"] = %det_mech_laydown_cover_helicopter;

    if ( level.nextgen || issubstr( level.transient_zone, "_outro" ) )
    {
        maps\_anim::addnotetrack_customfunction( "littlebird", "heli_shot", maps\detroit_fx::det_helicopter_shot, "det_exit_drive_ending" );
        maps\_anim::addnotetrack_customfunction( "littlebird", "heli_impact", maps\detroit_fx::det_helicopter_explo, "det_exit_drive_ending" );
    }

    level.scr_anim["player_bike"]["det_exit_drive_ending"] = %det_mech_laydown_cover_vmbike;
    level.scr_anim["burke_bike"]["det_exit_drive_ending"] = %det_mech_laydown_cover_burkebike;
    level.scr_anim["joker_bike"]["det_exit_drive_ending"] = %det_mech_laydown_cover_jokerbike;

    if ( level.nextgen && issubstr( level.transient_zone, "_outro" ) )
        maps\_anim::addnotetrack_customfunction( "joker_bike", "hoverbike_fx1", maps\detroit_fx::det_joker_bike_end_fx, "det_exit_drive_ending" );

    level.scr_anim["bones_bike"]["det_exit_drive_ending"] = %det_mech_laydown_cover_bonesbike;

    if ( level.nextgen && issubstr( level.transient_zone, "_outro" ) )
        maps\_anim::addnotetrack_customfunction( "bones_bike", "hoverbike_fx2", maps\detroit_fx::det_bones_bike_end_fx, "det_exit_drive_ending" );

    level.scr_animtree["foodtruck"] = #animtree;
    level.scr_anim["foodtruck"]["foodtruck_door"][0] = %det_camp_foodtruck_truck;
}

#using_animtree("dog");

dog_anims_toload()
{
    level.scr_animtree["dog"] = #animtree;
}

#using_animtree("player");

player_anims_toload()
{
    level.scr_model["world_body"] = "s1_gfl_ump45_viewbody";
    level.scr_animtree["world_body"] = #animtree;
    level.scr_model["player_rig"] = "s1_gfl_ump45_viewbody";
    level.scr_animtree["player_rig"] = #animtree;
    level.scr_model["world_hands"] = "s1_gfl_ump45_viewhands_player";
    level.scr_animtree["world_hands"] = #animtree;
    level.scr_anim["world_body"]["player_turntable"][0] = %edge_walk_vm;
    level.scr_anim["world_body"]["hoverbike_mount"] = %det_hoverbike_mount_vm;
    maps\_anim::addnotetrack_notify( "world_body", "on_button", "intro_drive_on_button_pressed", "hoverbike_mount" );
    level.scr_anim["world_body"]["hoverbike_mount_left"] = %det_hoverbike_mount_left_vm;
    maps\_anim::addnotetrack_notify( "world_body", "on_button", "intro_drive_on_button_pressed", "hoverbike_mount_left" );
    level.scr_anim["world_body"]["hoverbike_meet_up"] = %det_motorpool_meet_up_vm;
    level.scr_anim["world_hands"]["sentinel_reveal"] = %det_meeting_sentinel_vm;
    level.scr_anim["world_body"]["sentinel_kva_reveal"] = %det_hos_sent_meet_vm;
    level.scr_anim["world_body"]["doctor_capture"] = %det_doctor_capture_grab_vm;
    level.scr_anim["world_body"]["school_fall_stand_2_shuffle"] = %det_school_fall_stand_2_shuffle_vm;
    level.scr_anim["world_body"]["det_school_fall_stand_2_shuffle_slow_vm"] = %det_school_fall_stand_2_shuffle_slow_vm;
    level.scr_anim["world_body"]["school_fall_shuffle_pt0_idle"][0] = %det_school_fall_shuffle_vm_pt0_idle;
    level.scr_anim["world_body"]["school_fall_shuffle_pt1"] = %det_school_fall_shuffle_vm_pt1;
    level.scr_anim["world_body"]["school_fall_shuffle_pt1_idle"][0] = %det_school_fall_shuffle_vm_pt1_idle;
    level.scr_anim["world_body"]["school_fall_shuffle_pt2"] = %det_school_fall_shuffle_vm_pt2;
    level.scr_anim["world_body"]["school_fall_shuffle_pt2_idle"][0] = %det_school_fall_shuffle_vm_pt2_idle;
    level.scr_anim["world_body"]["school_fall_shuffle_pt3"] = %det_school_fall_shuffle_vm_pt3;
    level.scr_anim["world_body"]["school_fall_shuffle_pt3_idle"][0] = %det_school_fall_shuffle_vm_pt3_idle;
    level.scr_anim["world_body"]["school_fall_shuffle_pt4"] = %det_school_fall_shuffle_vm_pt4;
    level.scr_anim["world_body"]["school_fall_shuffle_pt4_idle"][0] = %det_school_fall_shuffle_vm_pt4_idle;
    level.scr_anim["world_body"]["school_fall"] = %det_school_fall_vm;

    if ( level.nextgen || issubstr( level.transient_zone, "_school" ) )
        maps\_anim::addnotetrack_customfunction( "world_body", "fall_school_int", maps\detroit_fx::det_fall_through_ceiling, "school_fall" );

    level.scr_anim["world_body"]["bike_dismount"] = %det_school_splitup_vm;

    if ( level.nextgen || level.transient_zone == "middle" )
    {
        maps\_anim::addnotetrack_customfunction( "world_body", "fovchange", ::change_fov_back_to_65, "bike_dismount" );
        maps\_anim::addnotetrack_customfunction( "world_body", "playerbikevmswitch", ::player_bike_to_ai_model, "bike_dismount" );
        maps\_anim::addnotetrack_notify( "world_body", "off_button", "intro_drive_off_button_pressed", "bike_dismount" );
    }

    level.scr_anim["world_body"]["wall_pull"] = %det_school_wall_pull_vm;

    if ( level.nextgen || issubstr( level.transient_zone, "_school" ) )
    {
        maps\_anim::addnotetrack_customfunction( "world_body", "weapon_up", ::give_weapon_knife, "wall_pull" );
        maps\_anim::addnotetrack_customfunction( "world_body", "slowmo_start", ::begin_wallpull_slowmo, "wall_pull" );
    }

    level.scr_anim["world_body"]["vm_crash_anim"] = %det_finale_crash_vm;
    level.scr_anim["world_body"]["level_intro_cinematic"] = %det_camp_intro_vm;
    maps\_anim::addnotetrack_notify( "world_body", "fovchange", "opening_fovchange", "level_intro_cinematic" );
    level.scr_anim["world_hands"]["body_room_exit"] = %det_school_enter_vm;
    level.scr_anim["world_body"]["det_hos_breach_fail_vm"] = %det_hos_breach_fail_vm;
    level.scr_anim["world_body"]["det_hos_breach_success_vm"] = %det_hos_breach_success_vm;
    level.scr_goaltime["world_body"]["det_hos_breach_success_vm"] = 0;
    level.scr_anim["world_body"]["det_hos_breach_vm"] = %det_hos_breach_vm;
    maps\_anim::addnotetrack_customfunction( "world_body", "gun_butt", ::doctor_capture_player_melee_and_hit, "det_hos_breach_fail_vm" );
    maps\_anim::addnotetrack_customfunction( "world_body", "player_death", ::doctor_capture_player_killed, "det_hos_breach_fail_vm" );
    maps\_anim::addnotetrack_customfunction( "world_body", "rumble", ::controller_rumble_heavy_long, "det_hos_breach_vm" );

    if ( level.nextgen || issubstr( level.transient_zone, "_hospital" ) )
        maps\_anim::addnotetrack_customfunction( "world_body", "slowmo_start", ::hospital_slowmo_start, "det_hos_breach_vm" );

    level.scr_anim["world_body"]["det_exit_drive_ending"] = %det_mech_laydown_cover_vm;

    if ( level.nextgen || issubstr( level.transient_zone, "_outro" ) )
    {
        maps\_anim::addnotetrack_notify( "world_body", "spotlight_off", "detroit_final_chopper_hit", "det_exit_drive_ending" );
        maps\_anim::addnotetrack_notify( "world_body", "detroit_final_VO", "detroit_ending_VO", "det_exit_drive_ending" );
        maps\_anim::addnotetrack_notify( "world_body", "fadeout", "detroit_level_fadeout", "det_exit_drive_ending" );
    }

    level.scr_anim["world_body"]["exo_push_idle"][0] = %det_hos_vehicle_push_vm_push_idle;
    level.scr_anim["world_body"]["exo_push_loop"][0] = %det_hos_vehicle_push_vm_push_loop;
    level.scr_anim["world_body"]["exo_push_attach"] = %det_hos_vehicle_push_vm_push_trans_in;
    level.scr_anim["world_body"]["exo_push_idle_to_loop"] = %det_hos_vehicle_push_vm_push_trans_into_push;
    level.scr_anim["world_body"]["exo_push_detach"] = %det_hos_vehicle_push_vm_push_trans_out;
    level.scr_anim["world_body"]["exo_push_loop_to_idle"] = %det_hos_vehicle_push_vm_push_trans_out_push;
}

change_fov_back_to_65( var_0 )
{
    level.player lerpfov( 65, 2 );
}

begin_wallpull_slowmo( var_0 )
{
    level notify( "begin_slowmo_lerp_in" );
}

helmet_swap( var_0 )
{
    level notify( "helmet_swap_time" );
}

hospital_slowmo_start( var_0 )
{
    maps\_utility::slowmo_lerp_in();
}

hospital_breach_punch( var_0 )
{
    var_1 = earthquake( 0.6, 0.2, level.player.origin, 1000 );
    level.player playrumbleonentity( "light_1s" );
}

doctor_capture_player_melee_and_hit( var_0 )
{
    level.player dodamage( level.player.maxhealth / 4, level.player.origin );
    controller_rumble_heavy_long( var_0 );
}

doctor_capture_player_killed( var_0 )
{
    level.player dodamage( level.player.maxhealth, level.player.origin );
    level.player kill();
    maps\_player_death::set_deadquote( &"DETROIT_QTE_FAIL" );
    maps\_utility::missionfailedwrapper();
}

controller_rumble_heavy_long( var_0 )
{
    level.player playrumbleonentity( "heavy_1s" );
}

controller_rumble_light_long( var_0 )
{
    level.player playrumbleonentity( "light_1s" );
}

controller_rumble_heavy( var_0 )
{
    level.player playrumbleonentity( "damage_heavy" );
}

controller_rumble_light( var_0 )
{
    level.player playrumbleonentity( "damage_light" );
}

give_weapon_knife( var_0 )
{
    if ( maps\_utility::player_has_weapon( "iw5_titan45_sp" ) )
    {
        level.player takeweapon( "iw5_titan45_sp" );
        wait 1.2;
        level.player giveweapon( "iw5_bal27_sp_silencer01_variablereddot" );
        level.player switchtoweapon( "iw5_bal27_sp_silencer01_variablereddot" );
    }

    maps\_variable_grenade::give_player_variable_grenade();
}

player_bike_to_ai_model( var_0 )
{
    level.player_bike setmodel( "vehicle_mil_hoverbike_ai" );
    level notify( "switch_bikes_to_ai" );
}

player_bike_to_vm_model( var_0 )
{
    level.player_bike setmodel( "vehicle_mil_hoverbike_vm" );
    level notify( "switch_bikes_to_vm" );
}

doc_capture_bagspawn( var_0 )
{
    common_scripts\utility::flag_set( "show_capture_bag" );
}

doc_capture_headswap( var_0 )
{
    common_scripts\utility::flag_set( "show_capture_head" );
}

begin_stealth_walk( var_0 )
{
    level.burke maps\_utility::set_generic_run_anim( "stealth_walk", 0 );
}

sentinel_reveal_slowmo_start( var_0 )
{
    wait 1.3;
    setslowmotion( level.slowmo.speed_norm, level.slowmo.speed_slow, level.slowmo.lerp_time_in );
}

sentinel_reveal_slowmo_stop( var_0 )
{
    maps\_utility::slowmo_lerp_out();
    common_scripts\utility::flag_set( "sentinel_kva_fov_lerp_out" );
}

sentinel_reveal_dialogue_continue( var_0 )
{
    common_scripts\utility::flag_set( "vo_sentinel_reveal" );
}

sentinel_reveal_guy1_decloak( var_0 )
{
    common_scripts\utility::flag_set( "sentinel_reveal_guy1_decloak" );
}

sentinel_reveal_guy2_decloak( var_0 )
{
    common_scripts\utility::flag_set( "sentinel_reveal_guy2_decloak" );
}

sentinel_reveal_guy3_decloak( var_0 )
{
    common_scripts\utility::flag_set( "sentinel_reveal_guy3_decloak" );
}

#using_animtree("script_model");

script_model_anims()
{
    level.scr_animtree["floorboards"] = #animtree;
    level.scr_model["floorboards"] = "det_shimmy_panels_01_anim";
    level.scr_anim["floorboards"]["det_school_fall_beams"] = %det_school_fall_beams;
    level.scr_anim["floorboards"]["det_school_fall_shuffle_pt0_idle_beams"][0] = %det_school_fall_shuffle_pt0_idle_beams;
    level.scr_anim["floorboards"]["det_school_fall_shuffle_pt1_beams"] = %det_school_fall_shuffle_pt1_beams;
    level.scr_anim["floorboards"]["det_school_fall_shuffle_pt1_idle_beams"][0] = %det_school_fall_shuffle_pt1_idle_beams;
    level.scr_anim["floorboards"]["det_school_fall_shuffle_pt2_beams"] = %det_school_fall_shuffle_pt2_beams;
    level.scr_anim["floorboards"]["det_school_fall_shuffle_pt2_idle_beams"][0] = %det_school_fall_shuffle_pt2_idle_beams;
    level.scr_anim["floorboards"]["det_school_fall_shuffle_pt3_beams"] = %det_school_fall_shuffle_pt3_beams;
    level.scr_anim["floorboards"]["det_school_fall_shuffle_pt3_idle_beams"][0] = %det_school_fall_shuffle_pt3_idle_beams;
    level.scr_anim["floorboards"]["det_school_fall_shuffle_pt4_beams"] = %det_school_fall_shuffle_pt4_beams;
    level.scr_anim["floorboards"]["det_school_fall_shuffle_pt4_idle_beams"][0] = %det_school_fall_shuffle_pt4_idle_beams;
    level.scr_anim["floorboards"]["det_school_fall_stand_2_shuffle_beams"] = %det_school_fall_stand_2_shuffle_beams;
    level.scr_animtree["knife"] = #animtree;
    level.scr_anim["knife"]["wall_pull"] = %det_school_wall_pull_knife;
    level.scr_animtree["shelf"] = #animtree;
    level.scr_model["shelf"] = "det_hospital_shelf_01_anim";
    level.scr_anim["shelf"]["det_hos_breach_success_shelf01"] = %det_hos_breach_success_shelf01;

    if ( level.nextgen || issubstr( level.transient_zone, "_hospital" ) )
        maps\_anim::addnotetrack_customfunction( "shelf", "shelf_papers", maps\detroit_fx::det_shelf_papers_fx, "det_hos_breach_success_shelf01" );

    level.scr_anim["shelf"]["det_hos_breach_success_shelf02"] = %det_hos_breach_success_shelf02;
    level.scr_animtree["butress"] = #animtree;
    level.scr_anim["butress"]["close"] = %det_retractable_car_barricade_close;
    level.scr_anim["butress"]["open"] = %det_retractable_car_barricade_open;
    level.scr_animtree["gun"] = #animtree;
    level.scr_model["gun"] = "npc_bal_27_grey";
    level.scr_anim["gun"]["school_fall"] = %det_school_fall_bal27;
    level.scr_animtree["brick"] = #animtree;
    level.scr_model["brick"] = "det_brick_01";
    level.scr_anim["brick"]["wall_pull"] = %det_school_wall_pull_brick;
    level.scr_animtree["basement_door"] = #animtree;
    level.scr_model["basement_door"] = "det_school_door_01_anim";
    level.scr_anim["basement_door"]["door_open_basement"] = %det_school_patrol_door;

    if ( level.nextgen || issubstr( level.transient_zone, "_school" ) )
        maps\_anim::addnotetrack_customfunction( "brick", "brick_pull", maps\detroit_fx::det_brick_pull_fx, "wall_pull" );

    level.scr_animtree["valve"] = #animtree;
    level.scr_model["valve"] = "det_basement_valve_01_anim";
    level.scr_anim["valve"]["school_investigate"] = %det_school_investigate_valve;
    level.scr_animtree["baseball_glove"] = #animtree;
    level.scr_model["baseball_glove"] = "ehq_baseball_glove_01";
    level.scr_anim["baseball_glove"]["baseball_glove1"][0] = %det_camp_baseball_glove01;
    level.scr_anim["baseball_glove"]["baseball_glove2"][0] = %det_camp_baseball_glove02;
    level.scr_animtree["decon_gate"] = #animtree;
    level.scr_model["decon_gate"] = "det_security_checkpoint_01";
    level.scr_anim["decon_gate"]["decon_scanner_front"] = %det_gate_decon_scanner_a;
    level.scr_anim["decon_gate"]["decon_scanner_back"] = %det_gate_decon_scanner_b;
    level.scr_anim["decon_gate"]["det_gate_decon_station"] = %det_gate_decon_station;

    if ( level.nextgen )
    {
        maps\_anim::addnotetrack_notify( "decon_gate", "door_open", "scanner_doors_open", "decon_scanner_back" );
        maps\_anim::addnotetrack_customfunction( "decon_gate", "scanner_start", maps\detroit_fx::det_scanner_fx, "decon_scanner_back" );
        maps\_anim::addnotetrack_customfunction( "decon_gate", "scan_1", maps\detroit_fx::det_scanner_fx_bg, "det_gate_decon_station" );
        maps\_anim::addnotetrack_customfunction( "decon_gate", "scan_2", maps\detroit_fx::det_scanner_fx_bg, "det_gate_decon_station" );
        maps\_anim::addnotetrack_customfunction( "decon_gate", "scan_3", maps\detroit_fx::det_scanner_fx_bg, "det_gate_decon_station" );
    }
    else if ( level.currentgen && level.transient_zone == "intro" )
    {
        maps\_anim::addnotetrack_notify( "decon_gate", "door_open", "scanner_doors_open", "decon_scanner_back" );
        maps\_anim::addnotetrack_customfunction( "decon_gate", "scanner_start", maps\detroit_fx::det_scanner_fx, "decon_scanner_back" );
        maps\_anim::addnotetrack_customfunction( "decon_gate", "scan_1", maps\detroit_fx::det_scanner_fx_bg, "det_gate_decon_station" );
        maps\_anim::addnotetrack_customfunction( "decon_gate", "scan_2", maps\detroit_fx::det_scanner_fx_bg, "det_gate_decon_station" );
        maps\_anim::addnotetrack_customfunction( "decon_gate", "scan_3", maps\detroit_fx::det_scanner_fx_bg, "det_gate_decon_station" );
    }

    level.scr_animtree["entrance_gate"] = #animtree;
    level.scr_model["entrance_gate"] = "refugee_gate_main_rigged";
    level.scr_anim["entrance_gate"]["hoverbike_meet_up"] = %det_motorpool_meet_up_gate;

    if ( level.nextgen )
    {
        maps\_anim::addnotetrack_customfunction( "entrance_gate", "gate_open", maps\detroit_lighting::gate_lights_off_toggle_on, "hoverbike_meet_up" );
        maps\_anim::addnotetrack_customfunction( "entrance_gate", "gate_open", maps\detroit_fx::gate_open_rain_fall_fx, "hoverbike_meet_up" );
    }
    else if ( level.currentgen && level.transient_zone == "intro" )
    {
        thread cg_gate_anim_notetrack_load_stall();
        level.cg_noterack_delay_count += 1;
    }

    level.scr_animtree["school_door"] = #animtree;
    level.scr_model["school_door"] = "det_school_door_01_anim";
    level.scr_anim["school_door"]["burke_school_door"] = %det_school_enter_pt2_bodies_door;
    level.scr_animtree["body_room_exit_door"] = #animtree;
    level.scr_model["body_room_exit_door"] = "det_school_door_01_anim";
    level.scr_anim["body_room_exit_door"]["body_room_exit"] = %det_school_enter_door_vm;
    level.scr_animtree["joker_fence"] = #animtree;
    level.scr_model["joker_fence"] = "det_fence_lrg_01_animated_01";
    level.scr_anim["joker_fence"]["bike_dismount"] = %det_school_splitup_joker_fence;
    level.scr_animtree["bones_fence"] = #animtree;
    level.scr_model["bones_fence"] = "det_fence_lrg_01_animated_01";
    level.scr_anim["bones_fence"]["bike_dismount"] = %det_school_splitup_bones_fence;
    level.scr_animtree["generic_prop"] = #animtree;
    level.scr_model["generic_prop"] = "genericprop";
    level.scr_anim["generic_prop"]["school_investigate"] = %det_school_investigate_door;
    level.scr_animtree["animated_door"] = #animtree;
    level.scr_model["animated_door"] = "det_hospital_door_02";
    level.scr_anim["animated_door"]["det_exit_drive_starting_anim_1"] = %det_exfil_droponbike_enter_door;
    level.scr_animtree["gate"] = #animtree;
    level.scr_model["gate"] = "refugee_gate_main_rigged";
    level.scr_anim["gate"]["det_exit_drive_ending"] = %det_mech_laydown_cover_gate;
    level.scr_animtree["foodtruck_mre"] = #animtree;
    level.scr_model["foodtruck_mre"] = "det_cargo_box_single_01";
    level.scr_anim["foodtruck_mre"]["foodtruck_mre1"][0] = %det_camp_foodtruck_pack_01;
    level.scr_anim["foodtruck_mre"]["foodtruck_mre2"][0] = %det_camp_foodtruck_pack_02;
    level.scr_animtree["school_floor"] = #animtree;
    level.scr_model["school_floor"] = "det_floor_collapse_01_anim";
    level.scr_anim["school_floor"]["school_fall"] = %det_school_fall_floors;
    level.scr_animtree["pay_machine"] = #animtree;
    level.scr_model["pay_machine"] = "det_ticketmachine_damaged_rigged";
    level.scr_anim["pay_machine"]["sentinel_kva_reveal"] = %det_hos_sent_meet_paymachine;
    level.scr_animtree["school_blockage"] = #animtree;
    level.scr_model["school_blockage"] = "det_pre_shimmy_beam";
    level.scr_anim["school_blockage"]["burke_wall_walk"] = %det_school_fall_barricade;
    level.scr_animtree["capture_bag"] = #animtree;
    level.scr_model["capture_bag"] = "det_doctor_prop_bagA";
    level.scr_anim["capture_bag"]["doctor_capture"] = %det_doctor_capture_bag;

    if ( level.nextgen || issubstr( level.transient_zone, "_hospital" ) )
        maps\_anim::addnotetrack_customfunction( "capture_bag", "spawn_bag", ::doc_capture_bagspawn, "doctor_capture" );

    level.scr_animtree["hospital_door"] = #animtree;
    level.scr_model["hospital_door"] = "det_hospital_door_02";
    level.scr_anim["hospital_door"]["hospital_breach"] = %det_hos_breach_damaged_door;
}

#using_animtree("destructibles");

destructible_anims()
{
    level.scr_animtree["busted_light"] = #animtree;
    level.scr_model["busted_light"] = "me_lightfluohang_double_destroyed";
    level.scr_anim["busted_light"]["busted_light_gag"] = %light_fluorescent_swing_02;
    level.scr_animtree["working_light"] = #animtree;
    level.scr_model["working_light"] = "s1_lightfluohang_double_on_dim";
    level.scr_anim["working_light"]["busted_light_gag"] = %light_fluorescent_swing_02;
}

cig_hide( var_0 )
{
    level notify( "show special cig" );
}

cig_show( var_0 )
{
    level notify( "hide special cig" );
}
