// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    level.action_slot_whistle = 4;
    level.death_counter = 0;
    maps\_utility::template_level( "irons_estate" );
    maps\createart\irons_estate_art::main();
    maps\irons_estate_fx::main();
    maps\irons_estate_precache::main();
    maps\irons_estate_anim::main();
    maps\irons_estate_vo::main();
    irons_estate_starts();
    irons_estate_precache();
    maps\_utility::add_extra_autosave_check( "stealth_meter", ::autosave_stealth_meter_check, "stealth meter is active." );
    maps\_utility::add_extra_autosave_check( "stealth_spotted", ::autosave_stealth_spotted_check, "player is spotted." );
    maps\_utility::add_extra_autosave_check( "hostile_drones", ::autosave_hostile_drone_check, "hostile drones exist." );

    if ( level.currentgen )
        maps\_utility::tff_sync_setup();

    maps\_load::main();
    thread maps\_player_exo::main( "specialist" );
    maps\irons_estate_lighting::main();
    maps\irons_estate_aud::main();
    maps\_stealth::main();
    maps\irons_estate_stealth::irons_estate_stealth_setup();
    maps\_patrol_extended::main();
    maps\irons_estate_stealth::unarmed();
    maps\irons_estate_stealth::investigate();
    maps\irons_estate_stealth::irons_estate_stealth_anims();
    maps\irons_estate_code::drone_investigate_triggers_main();
    maps\irons_estate_plant_tracker::landing_pad_lights_off();
    maps\irons_estate_code::trigger_sprinklervolume_setup();
    maps\irons_estate_code::force_alert_trigger_setup();
    level.player maps\_utility::playerallowalternatemelee( 0 );
    maps\_water::init( "s1_gfl_ump45_viewhands_player" );
    level.visionset_default = "irons_estate";
    level.visionset_underwater = "irons_estate_underwater";
    level.player.no_breath_hud = 1;
    maps\_grapple::main( "s1_gfl_ump45_viewbody", "s1_gfl_ump45_viewhands" );
    level.player setperk( "specialty_exo_blastsuppressor", 1, 0 );
    maps\_stealth_display::main();
    maps\_stealth_display::stealth_display_on();
    maps\_tagging::main();
    maps\_drone_ai::init();
    maps\irons_estate_drone::main();
    thread maps\irons_estate_drone::stealth_spotted_drone_monitor();
    thread maps\irons_estate_drone::stealth_alerted_drone_monitor();
    thread maps\irons_estate_drone::drone_investigate_monitor();
    level.ally_vo_org = spawn( "script_origin", ( 0, 0, 0 ) );
    level.active_civilians = [];
    irons_estate_global_flags();
    thread maps\irons_estate_code::irons_estate_animated_trees_setup();

    if ( !isdefined( self.high_jump_enabled ) )
    {
        setsaveddvar( "bg_fallDamageMinHeight", 400 );
        setsaveddvar( "bg_fallDamageMaxHeight", 550 );
    }

    setdvar( "grapple_magnet_required", 1 );

    if ( level.currentgen )
    {
        setup_transient_transitions();
        tff_vehicles();
    }
}

irons_estate_starts()
{
    common_scripts\utility::flag_init( "player_enters_front_yard_save_1" );
    common_scripts\utility::flag_init( "player_enters_front_yard_save_2" );
    common_scripts\utility::flag_init( "player_enters_front_yard_save_2a" );
    common_scripts\utility::flag_init( "player_enters_front_yard_save_3" );
    common_scripts\utility::flag_init( "player_enters_front_yard_save_4" );
    common_scripts\utility::flag_init( "player_enters_front_yard_save_5" );
    maps\_utility::add_start( "briefing", maps\irons_estate_briefing::briefing_start, "Briefing", maps\irons_estate_briefing::briefing_main );
    maps\_utility::add_start( "intro", maps\irons_estate_intro::intro_start, "Intro", maps\irons_estate_intro::intro_main );
    maps\_utility::add_start( "grapple", maps\irons_estate_grapple::grapple_start, "Grapple", maps\irons_estate_grapple::grapple_main );
    maps\_utility::add_start( "recon", maps\irons_estate_recon::recon_start, "Recon", maps\irons_estate_recon::recon_main );
    maps\_utility::add_start( "infil", maps\irons_estate_infil::infil_start, "Infil", maps\irons_estate_infil::infil_main );
    maps\_utility::add_start( "security_center", maps\irons_estate_security_center::security_center_start, "Security Center", maps\irons_estate_security_center::security_center_main );
    maps\_utility::add_start( "hack_security", maps\irons_estate_hack_security::hack_security_start, "Hack Security", maps\irons_estate_hack_security::hack_security_main );
    maps\_utility::add_start( "meet_cormack", maps\irons_estate_penthouse::penthouse_start, "Meet Cormack", maps\irons_estate_penthouse::penthouse_main );
    maps\_utility::add_start( "penthouse", maps\irons_estate_bedroom::bedroom_start, "Penthouse", maps\irons_estate_bedroom::bedroom_main );
    maps\_utility::add_start( "intel", maps\irons_estate_intel::intel_start, "Intel", maps\irons_estate_intel::intel_main );
    maps\_utility::add_start( "infil_hangar", maps\irons_estate_meet_cormack_pt2::meet_cormack_pt2_start, "Infil Hangar", maps\irons_estate_meet_cormack_pt2::meet_cormack_pt2_main );
    maps\_utility::add_start( "hangar", maps\irons_estate_track_irons::track_irons_start, "Hangar", maps\irons_estate_track_irons::track_irons_main );
    maps\_utility::add_start( "plant_tracker", maps\irons_estate_plant_tracker::plant_tracker_start, "Plant Tracker", maps\irons_estate_plant_tracker::plant_tracker_main );
    maps\_utility::default_start( maps\irons_estate_briefing::briefing_start );
    maps\_utility::set_default_start( "briefing" );

    if ( level.currentgen )
        setup_start_transients();
}

setup_start_transients()
{
    var_0 = [ "irons_estate_briefing_tr" ];
    maps\_utility::set_start_transients( "briefing", var_0 );
    var_0[0] = "irons_estate_cliffs_tr";
    var_0[1] = "irons_estate_lower_tr";
    maps\_utility::set_start_transients( "intro", var_0 );
    maps\_utility::set_start_transients( "grapple", var_0 );
    var_0[0] = "irons_estate_lower_tr";
    var_0[1] = "irons_estate_penthouse_tr";
    maps\_utility::set_start_transients( "recon", var_0 );
    maps\_utility::set_start_transients( "infil", var_0 );
    maps\_utility::set_start_transients( "security_center", var_0 );
    maps\_utility::set_start_transients( "hack_security", var_0 );
    maps\_utility::set_start_transients( "meet_cormack", var_0 );
    maps\_utility::set_start_transients( "penthouse", var_0 );
    maps\_utility::set_start_transients( "intel", var_0 );
    var_0[0] = "irons_estate_upper_tr";
    maps\_utility::set_start_transients( "infil_hangar", var_0 );
    maps\_utility::set_start_transients( "hangar", var_0 );
    maps\_utility::set_start_transients( "plant_tracker", var_0 );
}

setup_transient_transitions()
{
    if ( !istransientloaded( "irons_estate_cliffs_tr" ) )
        thread tff_trans_briefing_to_cliffs();

    if ( !istransientloaded( "irons_estate_lower_tr" ) )
        thread tff_trans_cliffs_to_lower();

    if ( !istransientloaded( "irons_estate_upper_tr" ) )
        thread tff_trans_lower_to_upper();

    if ( !istransientloaded( "irons_estate_cliffs_tr" ) || level.start_point == "intro" || level.start_point == "grapple" )
        thread tff_trans_upper_to_lower_cliffs();
}

tff_trans_briefing_to_cliffs()
{
    common_scripts\utility::flag_wait( "teleport_to_base" );
    level notify( "tff_pre_briefing_to_cliffs" );
    unloadtransient( "irons_estate_briefing_tr" );
    loadtransient( "irons_estate_cliffs_tr" );

    while ( !istransientloaded( "irons_estate_cliffs_tr" ) )
        wait 0.05;

    level notify( "tff_post_briefing_to_cliffs" );
    loadtransient( "irons_estate_lower_tr" );
}

tff_trans_cliffs_to_lower()
{
    common_scripts\utility::flag_wait( "flag_tff_trans_cliffs_to_lower" );
    level notify( "tff_pre_cliffs_to_lower" );
    unloadtransient( "irons_estate_cliffs_tr" );
    loadtransient( "irons_estate_penthouse_tr" );

    while ( !istransientloaded( "irons_estate_penthouse_tr" ) )
        wait 0.05;

    level notify( "tff_post_cliffs_to_lower" );
}

tff_trans_lower_to_upper()
{
    common_scripts\utility::flag_wait( "flag_tff_trans_lower_to_upper" );
    common_scripts\utility::flag_set( "post_penthouse_trees" );
    level notify( "tff_pre_lower_to_upper" );
    unloadtransient( "irons_estate_lower_tr" );
    loadtransient( "irons_estate_upper_tr" );

    while ( !istransientloaded( "irons_estate_upper_tr" ) )
        wait 0.05;

    level notify( "tff_post_lower_to_upper" );
}

tff_trans_upper_to_lower_cliffs()
{
    common_scripts\utility::flag_wait( "player_started_vtol_grapple" );
    level notify( "tff_pre_upper_to_cliffs" );
    unloadtransient( "irons_estate_upper_tr" );
    loadtransient( "irons_estate_cliffs_tr" );

    while ( !istransientloaded( "irons_estate_cliffs_tr" ) )
        wait 0.05;

    level notify( "tff_post_upper_to_cliffs" );
}

tff_vehicles()
{
    var_0 = getentarray( "estate_lower_vehicles", "targetname" );

    foreach ( var_2 in var_0 )
    {
        var_3 = var_2 maps\_utility::spawn_vehicle();
        var_3 thread maps\irons_estate_code::tff_cleanup_vehicle( "lower" );
    }
}

irons_estate_objectives()
{
    if ( level.start_point == "intro" )
        return;

    if ( level.start_point == "grapple" )
        return;

    objective_add( maps\_utility::obj( "grapple_waterfall" ), "invisible", &"IRONS_ESTATE_OBJ_GRAPPLE_WATERFALL" );
    objective_state_nomessage( maps\_utility::obj( "grapple_waterfall" ), "done" );

    if ( level.start_point == "recon" )
        return;

    if ( level.start_point == "infil" )
        return;

    objective_add( maps\_utility::obj( "infil" ), "invisible", &"IRONS_ESTATE_OBJ_INFIL" );
    objective_state_nomessage( maps\_utility::obj( "infil" ), "done" );

    if ( level.start_point == "security_center" )
        return;

    if ( level.start_point == "hack_security" )
        return;

    objective_add( maps\_utility::obj( "security_center" ), "invisible", &"IRONS_ESTATE_OBJ_SECURITY_CENTER" );
    objective_state_nomessage( maps\_utility::obj( "security_center" ), "done" );

    if ( level.start_point == "meet_cormack" )
        return;

    if ( level.start_point == "penthouse" )
        return;

    objective_add( maps\_utility::obj( "penthouse" ), "invisible", &"IRONS_ESTATE_OBJ_PENTHOUSE" );
    objective_state_nomessage( maps\_utility::obj( "penthouse" ), "done" );

    if ( level.start_point == "intel" )
        return;

    objective_add( maps\_utility::obj( "intel" ), "invisible", &"IRONS_ESTATE_OBJ_INTEL" );
    objective_state_nomessage( maps\_utility::obj( "intel" ), "done" );

    if ( level.start_point == "infil_hangar" )
        return;

    objective_add( maps\_utility::obj( "infiltrate_hangar" ), "invisible", &"IRONS_ESTATE_OBJ_INFILTRATE_HANGAR" );
    objective_state_nomessage( maps\_utility::obj( "infiltrate_hangar" ), "done" );

    if ( level.start_point == "hangar" )
        return;

    objective_add( maps\_utility::obj( "monitor_irons" ), "invisible", &"IRONS_ESTATE_OBJ_MONITOR_IRONS" );
    objective_state_nomessage( maps\_utility::obj( "monitor_irons" ), "done" );

    if ( level.start_point == "plant_tracker" )
        return;
}

irons_estate_precache()
{
    precachestring( &"IRONS_ESTATE_INTROSCREEN2_LINE_1" );
    precachestring( &"IRONS_ESTATE_INTROSCREEN2_LINE_2" );
    precachestring( &"IRONS_ESTATE_INTROSCREEN2_LINE_3" );
    precachestring( &"IRONS_ESTATE_INTROSCREEN2_LINE_4" );
    maps\_utility::add_hint_string( "HINT_GRAPPLE", &"IRONS_ESTATE_GRAPPLE", ::hint_grapple_off );
    maps\_utility::add_control_based_hint_strings( "HINT_TAGGING", &"IRONS_ESTATE_TAGGING", ::hint_tagging_off, &"IRONS_ESTATE_TAGGING_PC" );
    maps\_utility::add_hint_string( "HINT_STEALTH_DETECTION", &"IRONS_ESTATE_STEALTH_DETECTION_HINT", ::hint_stealth_detection_off );
    maps\_utility::add_hint_string( "HINT_DECOY", &"IRONS_ESTATE_DECOY_HINT", ::hint_decoy_off );
    maps\_utility::add_hint_string( "HINT_DECOY_EXPOSED_GROUP", &"IRONS_ESTATE_DECOY_HINT", ::hint_decoy_exposed_group_off );
    maps\_utility::add_hint_string( "HINT_CONCEALED_KILL", &"IRONS_ESTATE_CONCEALED_KILL_HINT", ::hint_concealed_kill_one );
    maps\_utility::add_hint_string( "HINT_ABANDON_WARNING", &"IRONS_ESTATE_ABANDON_WARNING", ::hint_abandon_warning_off );
    maps\_utility::add_hint_string( "HINT_RAPPEL", &"IRONS_ESTATE_HINT_RAPPEL", ::hint_rappel_off );
    maps\_utility::add_hint_string( "HINT_MARK_AND_EXECUTE", &"IRONS_ESTATE_HINT_MARK_AND_EXECUTE", ::hint_mark_and_execute_off );
    maps\_utility::add_hint_string( "HINT_PRONE_TOGGLE", &"IRONS_ESTATE_HINT_PRONE_TOGGLE", ::hint_prone_off );
    maps\_utility::add_hint_string( "HINT_PRONE_HOLD", &"IRONS_ESTATE_HINT_PRONE_HOLD", ::hint_prone_off );
    maps\_utility::add_hint_string( "HINT_PRONE", &"IRONS_ESTATE_HINT_PRONE", ::hint_prone_off );
    maps\_utility::add_hint_string( "HINT_COVER_MOUTH", &"IRONS_ESTATE_HINT_COVER_MOUTH", ::hint_cover_mouth_off );
    maps\_utility::add_hint_string( "HINT_UNCOVER_MOUTH", &"IRONS_ESTATE_HINT_UNCOVER_MOUTH", ::hint_uncover_mouth_off );
    maps\_utility::add_hint_string( "HINT_KNOCKOUT", &"IRONS_ESTATE_HINT_KNOCKOUT", ::hint_knockout_off );
    precachemodel( "viewhands_sentinel_udt_mitchell" );
    precachemodel( "viewbody_sentinel_udt_mitchell_grapple" );
    precachemodel( "viewhands_sentinel_udt_mitchell_noscreen" );
    precacheshellshock( "s1_unarmed" );
    precacheshellshock( "iw5_pbwsingleshot_sp" );
    precacheshellshock( "iw5_kf5fullauto_sp" );
    precachemodel( "worldhands_sentinel_udt_mitchell_screen" );
    precachemodel( "worldhands_sentinel_udt_mitchell_grapple" );
    precachemodel( "foliage_fan_palm_tree_01_anim" );
    precachemodel( "foliage_fan_palm_tree_02_anim" );
    precacheshader( "waypoint_threat_friendly" );
    precachemodel( "greece_drone_control_pad" );
    precachemodel( "base_pool_stick_01" );
    precacheshader( "dpad_icon_whistle" );
    precacheshader( "dpad_icon_whistle_off" );

    if ( level.ps4 )
        precacheshader( "icon_hud_dpad_ps4" );
    else if ( level.xb3 )
        precacheshader( "icon_hud_dpad_xb3" );
    else
        precacheshader( "icon_hud_dpad" );

    precacheshader( "hud_dpad_arrow_right" );
    precachemodel( "mutecharge_obj" );
    precachemodel( "mutecharge" );
    precachemodel( "viewhands_sentinel_udt_mitchell_thumb_print" );
    precachemodel( "viewhands_sentinel_udt_mitchell_index_print" );
    precachemodel( "viewhands_sentinel_udt_mitchell_middle_print" );
    precachemodel( "viewhands_sentinel_udt_mitchell_ring_print" );
    precachemodel( "viewhands_sentinel_udt_mitchell_pinky_print" );

    if ( level.nextgen )
    {
        precacheshader( "m/mtl_base_fingerprint_01" );
        precacheshader( "m/mtl_base_fingerprint_02" );
        precacheshader( "m/mtl_base_fingerprint_03" );
        precacheshader( "m/mtl_base_fingerprint_04" );
        precacheshader( "m/mtl_base_fingerprint_05" );
        precacheshader( "m/mtl_base_fingerprint_06" );
        precacheshader( "m/mtl_base_fingerprint_07" );
        precacheshader( "m/mtl_base_fingerprint_08" );
        precacheshader( "m/mtl_base_fingerprint_09" );
        precacheshader( "m/mtl_base_fingerprint_10" );
        precacheshader( "m/mtl_base_fingerprint_11" );
        precacheshader( "m/mtl_base_fingerprint_12" );
    }
    else
    {
        precacheshader( "mq/mtl_base_fingerprint_01" );
        precacheshader( "mq/mtl_base_fingerprint_02" );
        precacheshader( "mq/mtl_base_fingerprint_03" );
        precacheshader( "mq/mtl_base_fingerprint_04" );
        precacheshader( "mq/mtl_base_fingerprint_05" );
        precacheshader( "mq/mtl_base_fingerprint_06" );
        precacheshader( "mq/mtl_base_fingerprint_07" );
        precacheshader( "mq/mtl_base_fingerprint_08" );
        precacheshader( "mq/mtl_base_fingerprint_09" );
        precacheshader( "mq/mtl_base_fingerprint_10" );
        precacheshader( "mq/mtl_base_fingerprint_11" );
        precacheshader( "mq/mtl_base_fingerprint_12" );
    }

    precacheshader( "ac130_overlay_pip_vignette" );
    precachemodel( "generic_prop_raven" );
    precachemodel( "generic_prop_raven_x3" );
    precachemodel( "cellphone_kit_03" );
    precachemodel( "atlas_vtol_cargo_plane_ext_ai" );
    precachemodel( "atlas_stabilize_crate" );
    precachemodel( "door_single_01_estate_anim" );
    precachemodel( "door_single_right_01_estate_anim" );
    precachemodel( "office_chair_conference_01_alt_red" );
    precachemodel( "dem_tablet_pc_01" );
    precacheshader( "objective_onscreen" );
    precacheshader( "objective_onscreen_arrow" );
    precacheshader( "stealth_eq_01" );
    precacheshader( "stealth_eq_02" );
    precacheshader( "stealth_eq_03" );
    precacheshader( "stealth_eq_04" );
    precacheshader( "stealth_eq_05" );
    precacheshader( "stealth_eq_06" );
    precacheshader( "stealth_eq_07" );
    precacheshader( "stealth_eq_08" );
    precacheshader( "cinematic" );
    precacheshader( "cinematic_add" );
    precacheshader( "cinematic_screen_add" );
    precachemodel( "civ_humvee_ai" );
    precachemodel( "mil_gaz_chassis_vm" );
    precacheshellshock( "rsass_silenced" );
    precachemodel( "tag_laser" );
    precachelaser( "ie_ilona_laser" );
    precachemodel( "tracking_device" );
    precachemodel( "udt_respirator_small" );
    precachemodel( "machinery_welder_handle" );
    precachemodel( "vehicle_ind_personal_forklift_ai" );
    precachemodel( "base_grapple_scale_rope" );
    precacherumble( "light_1s" );
    precacherumble( "ie_cave_rumble" );
    precacherumble( "steady_rumble" );
    precacherumble( "ie_vtol_rumble" );
    precacherumble( "ie_vtol_ride_rumble" );
    precacherumble( "ie_vtol_ride_rumble_low" );
    precachemodel( "npc_dronelaunchpad" );
    precachemodel( "genericprop_x5" );
    precachemodel( "atlas_stabilize_vial_static" );
    precachemodel( "base_hack_device_01" );
    precacherumble( "ie_desk_right_tap" );
    precacherumble( "ie_desk_right_swipe" );
    precacherumble( "ie_desk_left_tap" );
    precacherumble( "ie_desk_left_swipe" );
    precachemodel( "head_m_gen_cau_clark" );
    precachemodel( "head_m_gen_cau_anderson" );
}

irons_estate_global_flags()
{
    common_scripts\utility::flag_init( "briefing_end" );
    common_scripts\utility::flag_init( "intro_begin" );
    common_scripts\utility::flag_init( "intro_end" );
    common_scripts\utility::flag_init( "grapple_begin" );
    common_scripts\utility::flag_init( "grapple_end" );
    common_scripts\utility::flag_init( "recon_end" );
    common_scripts\utility::flag_init( "infil_begin" );
    common_scripts\utility::flag_init( "infil_end" );
    common_scripts\utility::flag_init( "poolhouse_end" );
    common_scripts\utility::flag_init( "security_center_begin" );
    common_scripts\utility::flag_init( "security_center_end" );
    common_scripts\utility::flag_init( "hack_security_begin" );
    common_scripts\utility::flag_init( "hack_security_end" );
    common_scripts\utility::flag_init( "intel_begin" );
    common_scripts\utility::flag_init( "intel_end" );
    common_scripts\utility::flag_init( "penthouse_start" );
    common_scripts\utility::flag_init( "penthouse_end" );
    common_scripts\utility::flag_init( "bedroom_start" );
    common_scripts\utility::flag_init( "bedroom_end" );
    common_scripts\utility::flag_init( "meet_ilana_start" );
    common_scripts\utility::flag_init( "meet_ilana_end" );
    common_scripts\utility::flag_init( "identify_irons_start" );
    common_scripts\utility::flag_init( "identify_irons_end" );
    common_scripts\utility::flag_init( "descend_start" );
    common_scripts\utility::flag_init( "descend_end" );
    common_scripts\utility::flag_init( "meet_cormack_start" );
    common_scripts\utility::flag_init( "meet_cormack_end" );
    common_scripts\utility::flag_init( "meet_cormack_pt2_start" );
    common_scripts\utility::flag_init( "meet_cormack_pt2_end" );
    common_scripts\utility::flag_init( "track_irons_start" );
    common_scripts\utility::flag_init( "track_irons_end" );
    common_scripts\utility::flag_init( "plant_tracker_start" );
    common_scripts\utility::flag_init( "plant_tracker_end" );
    common_scripts\utility::flag_init( "ie_west_poolhouse_trees" );
    common_scripts\utility::flag_init( "ie_west_central_garden_trees" );
    common_scripts\utility::flag_init( "ie_west_driveway_trees" );
    common_scripts\utility::flag_init( "post_penthouse_trees" );
    common_scripts\utility::flag_init( "remove_pre_penthouse_trees" );
    common_scripts\utility::flag_init( "cleanup_drones_and_enemies_in_backyard" );
    common_scripts\utility::flag_init( "introscreen1_complete" );
    common_scripts\utility::flag_init( "briefing_table_start" );
    common_scripts\utility::flag_init( "teleport_to_base" );
    common_scripts\utility::flag_init( "all_in" );
    common_scripts\utility::flag_init( "drone_passed" );
    common_scripts\utility::flag_init( "grapple_disabled" );
    common_scripts\utility::flag_init( "ENTITY_TAGGED" );
    common_scripts\utility::flag_init( "AR_OPTICS_ACTIVATED" );
    common_scripts\utility::flag_init( "AR_OPTICS_DEACTIVATED" );
    common_scripts\utility::flag_init( "HINT_STEALTH_DETECTION" );
    common_scripts\utility::flag_init( "HINT_DECOY" );
    common_scripts\utility::flag_init( "HINT_DECOY_STOP" );
    common_scripts\utility::flag_init( "HINT_CONCEALED_KILL" );
    common_scripts\utility::flag_init( "HINT_CONCEALED_KILL_STOP" );
    common_scripts\utility::flag_init( "HINT_ABANDON_WARNING_STOP" );
    common_scripts\utility::flag_init( "tutorial_guard_alerted" );
    common_scripts\utility::flag_init( "stealth_display_tutorial_over" );
    common_scripts\utility::flag_init( "security_center_guard_right" );
    common_scripts\utility::flag_init( "security_center_guard_left" );
    common_scripts\utility::flag_init( "player_entering_ie_west" );
    common_scripts\utility::flag_init( "player_planting_emp" );
    common_scripts\utility::flag_init( "emp_detonated" );
    common_scripts\utility::flag_init( "security_center_enter_anim_done" );
    common_scripts\utility::flag_init( "handprint_start" );
    common_scripts\utility::flag_init( "security_center_hack_complete" );
    common_scripts\utility::flag_init( "player_is_exiting_security_center" );
    common_scripts\utility::flag_init( "player_is_out_of_security_center" );
    common_scripts\utility::flag_init( "guards_break_stealth" );
    common_scripts\utility::flag_init( "gather_intel" );
    common_scripts\utility::flag_init( "intel_download_interruption" );
    common_scripts\utility::flag_init( "intel_download_complete" );
    common_scripts\utility::flag_init( "intel_download_complete_started" );
    common_scripts\utility::flag_init( "grab_assistant_enabled" );
    common_scripts\utility::flag_init( "assistant_enter_room" );
    common_scripts\utility::flag_init( "grab_assistant_fail" );
    common_scripts\utility::flag_init( "player_covered_mouth" );
    common_scripts\utility::flag_init( "player_uncovered_mouth" );
    common_scripts\utility::flag_init( "cover_hint_off" );
    common_scripts\utility::flag_init( "uncover_hint_off" );
    common_scripts\utility::flag_init( "knockout_hint_off" );
    common_scripts\utility::flag_init( "player_knocked_out_assistant" );
    common_scripts\utility::flag_init( "marked_enemy" );
    common_scripts\utility::flag_init( "someone_became_alert" );
    common_scripts\utility::flag_init( "clean_kill" );
    common_scripts\utility::flag_init( "sloppy_kill" );
    common_scripts\utility::flag_init( "move_to_penthouse_balcony" );
    common_scripts\utility::flag_init( "balcony_entrance_doors_opened" );
    common_scripts\utility::flag_init( "player_entered_balcony_door" );
    common_scripts\utility::flag_init( "balcony_exit_doors_opened" );
    common_scripts\utility::flag_init( "woman_playing_vo" );
    common_scripts\utility::flag_init( "ATTACHED_TRACKER" );
    common_scripts\utility::flag_init( "DETACHED_FROM_VTOL" );
    common_scripts\utility::flag_init( "player_started_vtol_grapple" );
    common_scripts\utility::flag_init( "gaz_intro_finished" );
    common_scripts\utility::flag_init( "cormack_under_car" );
    common_scripts\utility::flag_init( "player_under_car" );
    common_scripts\utility::flag_init( "in_position_vo_done" );
    common_scripts\utility::flag_init( "player_used_intel_trigger" );
    common_scripts\utility::flag_init( "at_listening_position" );
    common_scripts\utility::flag_init( "cormack_in_hangar_position" );
    common_scripts\utility::flag_init( "player_grappled_to_vtol" );
    common_scripts\utility::flag_init( "start_exfil_moment_final" );
    common_scripts\utility::flag_init( "player_finished_desk_anim" );
    common_scripts\utility::flag_init( "mission_failing" );
    common_scripts\utility::flag_init( "landing_pad_workers_01_a_end" );
    common_scripts\utility::flag_init( "landing_pad_workers_01_b_end" );
    common_scripts\utility::flag_init( "increase_grapple_dist_max" );
    common_scripts\utility::flag_init( "start_exfil_moment_final_liftoff_started" );
}

autosave_stealth_meter_check()
{
    if ( isdefined( level.player.stealth_display_active ) && level.player.stealth_display_active )
        return 0;

    return 1;
}

autosave_stealth_spotted_check()
{
    if ( common_scripts\utility::flag( "_stealth_spotted" ) )
        return 0;

    return 1;
}

autosave_hostile_drone_check()
{
    if ( !isdefined( level.active_drones ) )
        return 1;

    foreach ( var_1 in level.active_drones )
    {
        if ( var_1.mode == "attack" )
            return 0;
    }

    return 1;
}

hint_grapple_off()
{
    return common_scripts\utility::flag( "GRAPPLE" ) || common_scripts\utility::flag( "HINT_GRAPPLE_STOP" );
}

hint_tagging_off()
{
    return common_scripts\utility::flag( "ENTITY_TAGGED" );
}

hint_ar_optics_deactivate_off()
{
    return common_scripts\utility::flag( "AR_OPTICS_DEACTIVATED" ) || common_scripts\utility::flag( "_stealth_spotted" );
}

hint_stealth_detection_off()
{
    return common_scripts\utility::flag( "HINT_STEALTH_DETECTION" ) || common_scripts\utility::flag( "_stealth_spotted" );
}

hint_decoy_off()
{
    return common_scripts\utility::flag( "HINT_DECOY" ) || common_scripts\utility::flag( "_stealth_spotted" ) || common_scripts\utility::flag( "concealed_kill_spawner_dead" ) || common_scripts\utility::flag( "player_skipping_concealed_kill_tutorial" ) || common_scripts\utility::flag( "tutorial_guard_alerted" ) || common_scripts\utility::flag( "HINT_DECOY_STOP" );
}

hint_decoy_exposed_group_off()
{
    return common_scripts\utility::flag( "HINT_DECOY" ) || common_scripts\utility::flag( "_stealth_spotted" ) || common_scripts\utility::flag( "HINT_DECOY_STOP" );
}

hint_concealed_kill_one()
{
    return common_scripts\utility::flag( "HINT_CONCEALED_KILL" ) || common_scripts\utility::flag( "_stealth_spotted" ) || common_scripts\utility::flag( "concealed_kill_spawner_dead" ) || common_scripts\utility::flag( "player_skipping_concealed_kill_tutorial" ) || common_scripts\utility::flag( "HINT_CONCEALED_KILL_STOP" );
}

hint_abandon_warning_off()
{
    return common_scripts\utility::flag( "HINT_ABANDON_WARNING_STOP" ) || common_scripts\utility::flag( "_stealth_spotted" );
}

hint_rappel_off()
{
    return common_scripts\utility::flag( "descend_end" ) || abs( level.player getnormalizedmovement()[0] ) > 0;
}

hint_mark_and_execute_off()
{
    return common_scripts\utility::flag( "marked_enemy" );
}

hint_prone_off()
{
    return level.player getstance() == "prone";
}

hint_cover_mouth_off()
{
    return level.player adsbuttonpressed() || common_scripts\utility::flag( "player_covered_mouth" ) || common_scripts\utility::flag( "cover_hint_off" );
}

hint_uncover_mouth_off()
{
    return !level.player adsbuttonpressed() || common_scripts\utility::flag( "player_uncovered_mouth" ) || common_scripts\utility::flag( "uncover_hint_off" );
}

hint_knockout_off()
{
    return level.player meleebuttonpressed() || level.player attackbuttonpressed() || common_scripts\utility::flag( "knockout_hint_off" );
}
