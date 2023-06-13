// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    maps\_utility::template_level( "lab" );
    maps\_utility::add_hint_string( "left_climb_hint", &"LAB_PRESS_CLIMB_LEFT", maps\lab_utility::break_left_climb_hint );
    maps\_utility::add_hint_string( "right_climb_hint", &"LAB_PRESS_CLIMB_RIGHT", maps\lab_utility::break_right_climb_hint );
    maps\_utility::add_control_based_hint_strings( "both_climb_hint", &"LAB_PRESS_CLIMB_BOTH", maps\lab_utility::break_both_climb_hint, &"LAB_PRESS_CLIMB_BOTH_PC", undefined );
    maps\_utility::add_hint_string( "exo_cloak_hint", &"LAB_ACTIVATE_CLOAK_HINT", maps\lab_code::break_exo_cloak_hint );
    maps\_utility::add_hint_string( "exo_toggle_hint", &"LAB_TOGGLE_CLOAK_HINT", maps\lab_code::break_exo_cloak_hint );
    maps\_utility::add_hint_string( "detonate_frb", &"LAB_EXPLOSIVE_DETONATE_HINT", maps\lab_code::break_detonate_frb_hint );
    maps\_utility::add_hint_string( "takedown_hint", &"LAB_TAKEDOWN_HINT", maps\lab_utility::takedown_hint_off );
    maps\_utility::add_control_based_hint_strings( "hovertank_missile_hint", &"LAB_HOVERTANK_SWITCH_MISSILES", maps\lab_utility::hovertank_missile_hint_off, &"LAB_HOVERTANK_SWITCH_MISSILES_PC" );
    maps\_utility::add_control_based_hint_strings( "hovertank_cannon_hint", &"LAB_HOVERTANK_SWITCH_CANNON", maps\lab_utility::hovertank_cannon_hint_off, &"LAB_HOVERTANK_SWITCH_CANNON_PC" );
    var_0 = getdvarint( "loc_language", 0 );

    if ( ( level.ps3 || level.ps4 ) && ( var_0 == 10 || var_0 == 5 ) )
        maps\_utility::add_control_based_hint_strings( "hovertank_emp_hint", &"LAB_HOVERTANK_SWITCH_EMP_J", maps\lab_utility::hovertank_emp_hint_off, &"LAB_HOVERTANK_SWITCH_EMP_PC" );
    else
        maps\_utility::add_control_based_hint_strings( "hovertank_emp_hint", &"LAB_HOVERTANK_SWITCH_EMP", maps\lab_utility::hovertank_emp_hint_off, &"LAB_HOVERTANK_SWITCH_EMP_PC" );

    maps\_utility::add_hint_string( "hint_dont_leave_mission", &"LAB_LEAVING_MISSION_AREA", maps\lab_code::break_exfil_out_bounds );
    maps\_utility::add_control_based_hint_strings( "prone_hint", &"LAB_PRONE_HINT", maps\lab_code::break_prone_hint, &"LAB_PRONE_HINT_PC", undefined );
    maps\_utility::add_control_based_hint_strings( "player_input_rappel_hint", &"LAB_RAPPEL_B_HINT_CONTROLLER", maps\lab_code::player_input_rappel_hint_off, &"LAB_RAPPEL_B_HINT_PC", &"LAB_RAPPEL_B_HINT_CONTROLLER_SP" );
    maps\_utility::add_start( "crash", ::debug_start_crash, "Crash", ::crash_logic );
    maps\_utility::add_start( "forest_start", ::debug_start_forest_start, "Forest Start", ::forest_start_logic );
    maps\_utility::add_start( "forest_takedown", ::debug_start_forest_takedown, "Forest Takedown", ::forest_takedown_start_logic );
    maps\_utility::add_start( "logging_road", ::debug_start_logging_road, "Logging Road", ::logging_road_logic );
    maps\_utility::add_start( "mech_march", ::debug_start_mech_march, "Mech March", ::mech_march_logic );
    maps\_utility::add_start( "cliff_rappel", ::debug_start_cliff_rappel, "Cliff Rappel", ::cliff_rappel_logic );
    maps\_utility::add_start( "facility_breach", ::debug_start_facility_breach, "Facility Breach", ::facility_breach_logic );
    maps\_utility::add_start( "server_room_promo", ::debug_start_server_room_promo, "Server Room Promo", ::server_room_promo_logic );
    maps\_utility::add_start( "server_room", ::debug_start_server_room, "Server Room", ::server_room_logic );
    maps\_utility::add_start( "research_facility_bridge", ::debug_start_research_facility_bridge, "Research Facility Bridge", ::research_facility_bridge_logic );
    maps\_utility::add_start( "foam_room", ::debug_start_foam_room, "Foam Room", ::foam_room_logic );
    maps\_utility::add_start( "courtyard", ::debug_start_courtyard, "Courtyard", ::courtyard_logic );
    maps\_utility::add_start( "courtyard_jammer", ::debug_start_courtyard_jammer, "Courtyard Jammer", ::courtyard_jammer_logic );
    maps\_utility::add_start( "tank_hangar", ::debug_start_tank_hangar, "Tank Hangar", ::tank_hangar_logic );
    maps\_utility::add_start( "tank_board", ::debug_start_tank_board, "Tank Board", ::tank_board_logic );
    maps\_utility::add_start( "tank_road", ::debug_start_tank_road, "Tank Road", ::tank_road_logic );
    maps\_utility::add_start( "tank_field", ::debug_start_tank_field, "Tank Field", undefined );
    maps\_utility::add_start( "tank_field_left_fork", ::debug_start_tank_field_left_fork, "Tank Field Left Fork", undefined );
    maps\_utility::add_start( "tank_field_right_fork", ::debug_start_tank_field_right_fork, "Tank Field Right Fork", ::tank_field_logic );
    maps\_utility::add_start( "tank_ascent", ::debug_start_tank_ascent, "Tank Ascent", ::tank_ascent_logic );
    maps\_utility::add_start( "exfil", ::debug_start_exfil, "Exfil", ::exfil_logic );
    // level.start_point = "forest_start";

    if ( level.currentgen )
        tff_setup_start_points();

    maps\createart\lab_art::main();
    maps\lab_fx::main();
    maps\lab_precache::main();
    maps\_load::main();
    thread maps\_player_exo::main( "specialist", 0, 0 );
    maps\lab_anim::main();
    maps\lab_lighting::main();
    maps\lab_aud::main();
    maps\_car_door_shield::init_door_shield();
    maps\_drone_ai::init();
    maps\_microdronelauncher::init();
    maps\_microwave_grenade::main();
    precachemodel( "body_hero_burke_sentinel_covert_cloak" );
    precachemodel( "body_hero_cormack_sentinel_covert_cloak" );
    precachemodel( "viewhands_player_sentinel_cloak" );
    precachemodel( "viewbody_sentinel_covert" );
    precachemodel( "viewbody_sentinel_covert_cloak" );
    precachemodel( "worldhands_player_sentinel" );
    precachemodel( "com_blackhawk_spotlight_on_mg_setup" );
    precachemodel( "genericprop" );
    precachemodel( "fullbody_deer_c" );
    precachemodel( "lab_tank_battle_sequoia_02_1b" );
    precachemodel( "lab_tank_battle_sequoia_02_1t" );
    precacheshellshock( "barrett" );
    precacheshellshock( "iw5_bal27_sp" );
    precacheshellshock( "iw5_hbra3_sp" );
    precacheshellshock( "iw5_microdronelauncher_sp" );
    precacheturret( "heli_spotlight_so_castle" );
    // precacheshellshock( "iw5_unarmed_nullattach" );
    // precacheshellshock( "s1_unarmed_water" );
    // precacheshellshock( "s1_lab_heli_railgun_sp" );
    // precacheshellshock( "rpg_straight" );
    // precacheshellshock( "rpg" );
    // precacheshellshock( "iw5_mors_sp" );
    precachemodel( "weapon_rappel_rope_long" );
    precachemodel( "vm_jamming_device_obj" );
    precachemodel( "safety_ladder_196_obj" );
    precachemodel( "npc_variable_grenade_lethal" );
    precachemodel( "npc_foam_grenade" );
    precachemodel( "rope_carabiner" );
    precachemodel( "lab_anchor_system" );
    precachemodel( "rope30ft_120j" );
    precachemodel( "rope30ft_240j" );
    precachemodel( "rope150ft_240j" );
    precachemodel( "lab_server_monitor_01_opc" );
    precachemodel( "lab_server_monitor_01_obj" );
    precachemodel( "vehicle_civ_boxtruck_destroyed" );
    precachemodel( "vehicle_mil_hovertank_dstrypv" );
    precachestring( &"LAB_DSM_PLANT_HINT_PC" );
    precachestring( &"LAB_EXPLOSIVE_PLANT_HINT_PC" );
    precachestring( &"LAB_ENTER_HOVERTANK_HINT_PC" );
    precachestring( &"LAB_DISABLE_SCRAMBLER_HINT_PC" );
    precachestring( &"LAB_CLIMB_WALL_HINT_PC" );
    precachestring( &"LAB_RAPPEL_HINT_PC" );
    precachestring( &"LAB_PLANT_MUTE_HINT_PC" );
    precachestring( &"LAB_PRONE_HINT_PC" );
    precachestring( &"LAB_RAPPEL_B_HINT_PC" );
    precacherumble( "damage_light" );
    precacherumble( "light_1s" );
    precacherumble( "light_2s" );
    precacherumble( "light_3s" );
    precacherumble( "damage_heavy" );
    precacherumble( "heavy_1s" );
    precacherumble( "heavy_2s" );
    precacherumble( "heavy_3s" );
    precacherumble( "steady_rumble" );
    maps\lab_utility::precache_scanner_turret();
    common_scripts\utility::flag_init( "flag_escape_the_sniper_obj_give" );
    common_scripts\utility::flag_init( "flag_demo_itiot_start" );
    common_scripts\utility::flag_init( "player_climbing_wall" );
    common_scripts\utility::flag_init( "flag_player_climb_succeeded" );
    common_scripts\utility::flag_init( "flag_burke_says_exo_is_on" );
    common_scripts\utility::flag_init( "flag_enable_battle_chatter" );
    common_scripts\utility::flag_init( "flag_player_exo_enabled" );
    common_scripts\utility::flag_init( "flag_cloak_fail_kill_player" );
    common_scripts\utility::flag_init( "lab_intro_screen_complete" );
    common_scripts\utility::flag_init( "flag_burke_intro_react_se_start" );
    common_scripts\utility::flag_init( "flag_burke_shack_se_start" );
    common_scripts\utility::flag_init( "flag_burke_hill_slide_start" );
    common_scripts\utility::flag_init( "flag_forest_climb_wall_complete" );
    common_scripts\utility::flag_init( "flag_forest_climb_wall_start" );
    common_scripts\utility::flag_init( "flag_search_drone_se_complete" );
    common_scripts\utility::flag_init( "flag_se_takedown_01_started" );
    common_scripts\utility::flag_init( "flag_se_takedown_01_complete" );
    common_scripts\utility::flag_init( "flag_se_takedown_02_complete" );
    common_scripts\utility::flag_init( "flag_patroler_takedown_02_ready" );
    common_scripts\utility::flag_init( "flag_recharge_cloak_01" );
    common_scripts\utility::flag_init( "flag_move_to_vrap_takedown" );
    common_scripts\utility::flag_init( "flag_vehicle_takedown_01_start" );
    common_scripts\utility::flag_init( "flag_se_vehicle_takedown_01_complete" );
    common_scripts\utility::flag_init( "flag_se_vehicle_takedown_01_failed" );
    common_scripts\utility::flag_init( "flag_seeker_patrol_01_clear" );
    common_scripts\utility::flag_init( "flag_move_up_seeker_01" );
    common_scripts\utility::flag_init( "flag_move_up_seeker_02" );
    common_scripts\utility::flag_init( "flag_seeker_cone_safe_left" );
    common_scripts\utility::flag_init( "flag_seeker_cone_safe_right" );
    common_scripts\utility::flag_init( "flag_logging_road_loud_combat" );
    common_scripts\utility::flag_init( "flag_obj_crawl_under_log" );
    common_scripts\utility::flag_init( "flag_rappel_player_input_start" );
    common_scripts\utility::flag_init( "flag_rappel_player_input_stop" );
    common_scripts\utility::flag_init( "flag_player_ready_to_rappel" );
    common_scripts\utility::flag_init( "flag_aproach_vehicle_dialogue_complete" );
    common_scripts\utility::flag_init( "flag_breach_guards_alerted" );
    common_scripts\utility::flag_init( "flag_breach_guards_clear" );
    common_scripts\utility::flag_init( "flag_facility_breach_complete" );
    common_scripts\utility::flag_init( "flag_breach_patrol_01_dead" );
    common_scripts\utility::flag_init( "flag_breach_patrol_02_dead" );
    common_scripts\utility::flag_init( "flag_post_breach_patrol_alerted" );
    common_scripts\utility::flag_init( "flag_combat_facility_bridge_seek_player" );
    common_scripts\utility::flag_init( "flag_sever_room_guy_kill" );
    common_scripts\utility::flag_init( "flag_server_room_enemy_killed_by_knox" );
    common_scripts\utility::flag_init( "flag_server_room_enemy_killed_by_player" );
    common_scripts\utility::flag_init( "flag_obj_bio_weapons_hack" );
    common_scripts\utility::flag_init( "flag_server_room_promo" );
    common_scripts\utility::flag_init( "flag_guys_pool_bldg_01_seek_player" );
    common_scripts\utility::flag_init( "flag_guys_research_left_01_seek_player" );
    common_scripts\utility::flag_init( "flag_guys_research_right_01_seek_player" );
    common_scripts\utility::flag_init( "flag_combat_research_retreat_foam_room" );
    common_scripts\utility::flag_init( "flag_foam_room_combat_clear_out" );
    common_scripts\utility::flag_init( "flag_foam_room_clear" );
    common_scripts\utility::flag_init( "flag_research_building_combat_complete" );
    common_scripts\utility::flag_init( "flag_obj_bio_weapons_complete" );
    common_scripts\utility::flag_init( "flag_obj_locate_atlas_tank" );
    common_scripts\utility::flag_init( "flag_combat_courtyard_jammer_complete" );
    common_scripts\utility::flag_init( "flag_obj_courtyard_jammer_start" );
    common_scripts\utility::flag_init( "flag_obj_courtyard_defend_start" );
    common_scripts\utility::flag_init( "flag_courtyard_sniper_sequence_complete" );
    common_scripts\utility::flag_init( "flag_courtyard_hangar_door_hack" );
    common_scripts\utility::flag_init( "flag_courtyard_hangar_door_hack_success" );
    common_scripts\utility::flag_init( "flag_obj_tank_02" );
    common_scripts\utility::flag_init( "hangar_door_closing" );
    common_scripts\utility::flag_init( "flag_obj_tank_04" );
    common_scripts\utility::flag_init( "flag_obj_tank_05" );
    common_scripts\utility::flag_init( "flag_obj_tank_06" );
    common_scripts\utility::flag_init( "flag_obj_tank_complete" );
    common_scripts\utility::flag_init( "flag_player_exfil_enter_ready" );
    common_scripts\utility::flag_init( "flag_obj_hide_marker_during_tank_exit" );
    common_scripts\utility::flag_init( "flag_obj_show_razorback_marker" );
    common_scripts\utility::flag_init( "flag_obj_battle_exfil_complete" );
    common_scripts\utility::flag_init( "flag_burke_server_room_ready" );
    common_scripts\utility::flag_init( "flag_cormack_server_room_ready" );
    common_scripts\utility::flag_init( "flag_knox_server_room_ready" );
    common_scripts\utility::flag_init( "flag_se_server_room_start" );
    common_scripts\utility::flag_init( "flag_se_server_room_guy_dead" );
    common_scripts\utility::flag_init( "flag_knox_get_ready_enter_server_room" );
    common_scripts\utility::flag_init( "flag_se_server_room_exit" );
    common_scripts\utility::flag_init( "monitor_finished_animating" );
    common_scripts\utility::flag_init( "flag_obj_neutralize_bio_weapons_complete" );
    common_scripts\utility::flag_init( "flag_hangar_mech_01_dead" );
    common_scripts\utility::flag_init( "flag_foam_corridor_exit" );
    common_scripts\utility::flag_init( "flag_player_starts_entering_mobile_turret" );
    common_scripts\utility::flag_init( "flag_player_enters_mobile_turret" );
    common_scripts\utility::flag_init( "flag_hovertank_reveal_scene_started" );
    common_scripts\utility::flag_init( "flag_move_knox_to_console" );
    common_scripts\utility::flag_init( "player_entering_hovertank" );
    common_scripts\utility::flag_init( "player_in_hovertank" );
    common_scripts\utility::flag_init( "flag_log_pile_scripted_destroyed" );
    common_scripts\utility::flag_init( "flag_burke_destroy_tank" );
    common_scripts\utility::flag_init( "flag_player_cloak_on_pressed" );
    common_scripts\utility::flag_init( "flag_player_cloak_on" );
    common_scripts\utility::flag_init( "flag_player_cloak_off" );
    common_scripts\utility::flag_init( "tank_defend_wave_1" );
    common_scripts\utility::flag_init( "hovertank_defend_complete" );
    common_scripts\utility::flag_init( "flag_burke_ready_for_exfil" );
    common_scripts\utility::flag_init( "flag_se_hovertank_exit" );
    common_scripts\utility::flag_init( "flag_exfil_start" );
    common_scripts\utility::flag_init( "flag_show_cloak_cover" );
    common_scripts\utility::flag_init( "flag_delete_cloak_cover" );
    common_scripts\utility::flag_init( "flag_mission_complete" );
    common_scripts\utility::flag_init( "flag_light_security_camera_off" );
    common_scripts\utility::flag_init( "flag_disable_takedown_hint" );
    common_scripts\utility::flag_init( "flag_stop_hint_emp" );
    common_scripts\utility::flag_init( "flag_stop_hint_cannon" );
    common_scripts\utility::flag_init( "flag_stop_hint_missile" );
    common_scripts\utility::flag_init( "flag_player_close_to_exfil" );
    common_scripts\utility::flag_init( "thruster_big" );
    common_scripts\utility::flag_init( "flag_vo_stealth_broken" );
    common_scripts\utility::flag_init( "flag_vo_stealth_recovered" );
    common_scripts\utility::flag_init( "flag_vo_chopper_moving_off" );
    maps\_weapon_pdrone::initialize();
    vehicle_scripts\_pdrone_tactical_picker::main();
    maps\_flashlight_cheap::cheap_flashlight_init();
    maps\lab_breach::init_facility_breach();
    thread animscripts\free_run::init();
    maps\lab_vo::main();
    maps\_foam_bomb::main();
    maps\_patrol_extended::main();
    maps\_stealth::main();
    maps\_cloak::main();
    setsaveddvar( "r_hudoutlineenable", 1 );
    setsaveddvar( "r_hudoutlinewidth", 5 );
    setsaveddvar( "r_chromaticaberration", 2 );
    setsaveddvar( "r_chromaticseparationr", 3 );
    setsaveddvar( "r_chromaticseparationb", 3 );
    setsaveddvar( "r_chromaticseparationg", -3 );
    setsaveddvar( "r_reactiveMotionWindFrequencyScale", "0.2" );

    if ( level.currentgen )
    {
        setsaveddvar( "r_gunSightColorEntityScale", "7" );
        setsaveddvar( "r_gunSightColorNoneScale", "0.8" );
    }

    maps\_variable_grenade::main();

    foreach ( var_2 in level.player getweaponslistoffhands() )
        level.player setweaponammostock( var_2, 0 );

    maps\lab_utility::spawn_metrics_init();
    setup_portal_scripting();
    thread setup_cloak_cover();
    thread umbra_accuracy_tweaks();
    thread umbra_accuracy_tweaks_tank_field();
    global_spawn_functions();
    thread maps\lab_utility::monitor_out_of_bounds_areas();

    if ( level.currentgen )
    {
        common_scripts\utility::flag_init( "tff_trans_middle_to_outro_allies_ready" );
        thread transient_transition_middle_to_outro();
        thread cull_distance_triggers();
        tff_setup_blockers();
    }

    thread maps\lab_utility::player_exo_monitor();
    thread maps\lab_code::disable_static_mobile_cover();
}

tff_setup_start_points()
{
    var_0 = [ "lab_intro_tr", "lab_intro_audio_tr" ];
    maps\_utility::set_start_transients( "crash", var_0 );
    maps\_utility::set_start_transients( "forest_start", var_0 );
    maps\_utility::set_start_transients( "forest_takedown", var_0 );
    maps\_utility::set_start_transients( "logging_road", var_0 );
    maps\_utility::set_start_transients( "mech_march", var_0 );
    maps\_utility::set_start_transients( "cliff_rappel", var_0 );
    maps\_utility::set_start_transients( "cliff_rappel", var_0 );
    var_0 = [ "lab_middle_tr", "lab_intro_audio_tr" ];
    maps\_utility::set_start_transients( "facility_breach", var_0 );
    var_0 = [ "lab_middle_tr" ];
    maps\_utility::set_start_transients( "server_room_promo", var_0 );
    maps\_utility::set_start_transients( "server_room", var_0 );
    maps\_utility::set_start_transients( "research_facility_bridge", var_0 );
    maps\_utility::set_start_transients( "foam_room", var_0 );
    maps\_utility::set_start_transients( "courtyard", var_0 );
    maps\_utility::set_start_transients( "courtyard_jammer", var_0 );
    var_0 = [ "lab_outro_tr" ];
    maps\_utility::set_start_transients( "tank_hangar", var_0 );
    maps\_utility::set_start_transients( "tank_board", var_0 );
    maps\_utility::set_start_transients( "tank_road", var_0 );
    maps\_utility::set_start_transients( "tank_field", var_0 );
    maps\_utility::set_start_transients( "tank_field_left_fork", var_0 );
    maps\_utility::set_start_transients( "tank_field_right_fork", var_0 );
    maps\_utility::set_start_transients( "tank_ascent", var_0 );
    maps\_utility::set_start_transients( "exfil", var_0 );
}

tff_setup_blockers()
{
    thread tff_setup_blocker_hangar_backtrack();
    thread tff_setup_blocker_hangar_load();
}

tff_setup_blocker_hangar_load()
{
    var_0 = getent( "tff_hangar_door_load_wait_r", "targetname" );
    var_1 = getent( "tff_hangar_door_load_wait_l", "targetname" );
    var_2 = getent( "tff_hangar_door_load_wait_r_coll", "targetname" );
    var_3 = getent( "tff_hangar_door_load_wait_l_coll", "targetname" );
    var_2 linkto( var_0 );
    var_3 linkto( var_1 );
    var_4 = ( -48, 0, 0 );
    var_5 = ( 48, 0, 0 );
    var_2 connectpaths();
    var_3 connectpaths();

    if ( !istransientloaded( "lab_outro_tr" ) )
        level waittill( "tff_post_middle_to_outro" );

    soundscripts\_snd::snd_message( "current_gen_hangar_door_open" );
    var_1 moveto( var_1.origin + var_5, 0.5 );
    var_0 moveto( var_0.origin + var_4, 0.5 );
}

tff_setup_blocker_hangar_backtrack()
{
    var_0 = getent( "tff_hangar_door_back_blocker_l", "targetname" );
    var_1 = getent( "tff_hangar_door_back_blocker_r", "targetname" );
    var_2 = getent( "tff_hangar_door_back_blocker_coll", "targetname" );
    var_3 = ( 0, 0, 105 );
    var_4 = ( 0, 26, 0 );
    var_5 = ( 0, -26, 0 );
    var_2 connectpaths();
    var_2.origin -= var_3;
    var_0.origin -= var_4;
    var_1.origin -= var_5;

    if ( !istransientloaded( "lab_outro_tr" ) )
        level waittill( "tff_pre_middle_to_outro" );

    var_2.origin += var_3;
    var_0.origin += var_4;
    var_1.origin += var_5;
    var_2 disconnectpaths();
}

set_completed_flags()
{
    if ( maps\_utility::is_default_start() )
        return;

    var_0 = level.start_point;

    if ( var_0 == "crash" )
        return;

    if ( var_0 == "demo_with_itiot" )
        return;

    common_scripts\utility::flag_set( "flag_escape_the_sniper_obj_give" );
    common_scripts\utility::flag_set( "flag_increase_sinper_shots_01" );
    common_scripts\utility::flag_set( "flag_helo_spotlight_path_02" );
    common_scripts\utility::flag_set( "flag_burke_cross_river" );
    common_scripts\utility::flag_set( "flag_helo_spotlight_path_03" );
    common_scripts\utility::flag_set( "flag_player_enters_forest" );

    if ( var_0 == "forest_start" )
        return;

    common_scripts\utility::flag_set( "flag_helo_low_pass_complete" );
    common_scripts\utility::flag_set( "flag_forest_climb_wall_start" );
    common_scripts\utility::flag_set( "player_climbing_wall" );
    common_scripts\utility::flag_set( "flag_forest_climb_wall_complete" );
    common_scripts\utility::flag_set( "flag_player_exo_enabled" );
    common_scripts\utility::flag_set( "flag_player_cloak_enabled" );
    common_scripts\utility::flag_set( "flag_player_cloak_on" );
    common_scripts\utility::flag_set( "forest_start_portalgrp_on" );

    if ( var_0 == "forest_takedown" )
        return;

    common_scripts\utility::flag_set( "flag_forest_takedown_01" );

    if ( var_0 == "logging_road" )
        return;

    common_scripts\utility::flag_set( "flag_vrap_mute_start" );
    common_scripts\utility::flag_set( "flag_vehicle_takedown_01" );
    common_scripts\utility::flag_set( "flag_se_vehicle_takedown_01_complete" );

    if ( var_0 == "mech_march" )
        return;

    common_scripts\utility::flag_set( "flag_logging_road_complete" );
    common_scripts\utility::flag_set( "flag_obj_crawl_under_log" );
    common_scripts\utility::flag_set( "flag_seeker_clear" );

    if ( var_0 == "cliff_rappel" )
        return;

    common_scripts\utility::flag_set( "flag_cormack_meet_init" );
    common_scripts\utility::flag_set( "flag_cormack_meet_start" );
    common_scripts\utility::flag_set( "flag_player_ready_to_rappel" );
    common_scripts\utility::flag_set( "flag_rappel_start" );
    common_scripts\utility::flag_set( "flag_facility_breach_start" );

    if ( var_0 == "facility_breach" )
        return;

    common_scripts\utility::flag_set( "flag_breach_guards_clear" );
    common_scripts\utility::flag_set( "flag_facility_breach_complete" );
    common_scripts\utility::flag_set( "flag_obj_bio_weapons_02" );
    common_scripts\utility::flag_set( "flag_obj_bio_weapons_03" );
    common_scripts\utility::flag_set( "flag_obj_bio_weapons_04" );

    if ( var_0 == "server_room" )
        return;

    if ( var_0 == "server_room_promo" )
        return;

    common_scripts\utility::flag_set( "flag_enable_battle_chatter" );
    common_scripts\utility::flag_set( "flag_combat_research_02" );
    common_scripts\utility::flag_set( "flag_obj_bio_weapons_05" );
    common_scripts\utility::flag_set( "flag_obj_bio_weapons_complete" );
    common_scripts\utility::flag_set( "flag_enemy_server_room_se_dead" );
    common_scripts\utility::flag_set( "flag_obj_bio_weapons_hack" );

    if ( var_0 == "research_facility_bridge" )
        return;

    common_scripts\utility::flag_set( "flag_research_building_combat_complete" );
    common_scripts\utility::flag_set( "flag_combat_research_05" );

    if ( var_0 == "foam_room" )
        return;

    common_scripts\utility::flag_set( "flag_obj_neutralize_bio_weapons_complete" );
    common_scripts\utility::flag_set( "flag_player_inside_foam_room" );
    common_scripts\utility::flag_set( "flag_obj_locate_atlas_tank" );

    if ( var_0 == "courtyard" )
        return;

    common_scripts\utility::flag_set( "flag_courtyard_hangar_door_block" );
    common_scripts\utility::flag_set( "flag_obj_courtyard_jammer_start" );
    common_scripts\utility::flag_set( "flag_courtyard_hangar_door_hack" );
    common_scripts\utility::flag_set( "flag_hangar_mech_01_dead" );

    if ( var_0 == "courtyard_jammer" )
        return;

    common_scripts\utility::flag_set( "flag_obj_jammer_interact" );
    common_scripts\utility::flag_set( "flag_obj_jammer_complete" );
    common_scripts\utility::flag_set( "flag_obj_courtyard_defend_start" );
    common_scripts\utility::flag_set( "flag_courtyard_hangar_door_hack_success" );
    common_scripts\utility::flag_set( "flag_obj_tank_02" );
    common_scripts\utility::flag_set( "flag_obj_tank_03" );

    if ( var_0 == "tank_hangar" )
        return;

    common_scripts\utility::flag_set( "flag_obj_tank_04" );
    common_scripts\utility::flag_set( "flag_obj_tank_05" );
    common_scripts\utility::flag_set( "flag_obj_tank_06" );

    if ( var_0 == "tank_board" )
        return;

    common_scripts\utility::flag_set( "flag_obj_battle_exfil_02" );
    common_scripts\utility::flag_set( "flag_courtyard_gate_01_explode" );
    common_scripts\utility::flag_set( "flag_courtyard_gate_02_explode" );
    common_scripts\utility::flag_set( "flag_obj_tank_complete" );
    common_scripts\utility::flag_set( "player_entering_hovertank" );
    common_scripts\utility::flag_set( "player_in_hovertank" );

    if ( var_0 == "tank_road" )
        return;

    common_scripts\utility::flag_set( "flag_obj_battle_exfil_03" );

    if ( var_0 == "tank_field" )
        return;

    if ( var_0 == "tank_field_left_fork" )
        return;

    if ( var_0 == "tank_field_right_fork" )
        return;

    if ( var_0 == "tank_ascent" )
        return;

    if ( var_0 == "exfil" )
        return;
}

global_spawn_functions()
{
    maps\_utility::add_global_spawn_function( "axis", ::toggle_battle_chatter );
    maps\_utility::add_global_spawn_function( "allies", ::toggle_battle_chatter );
}

toggle_battle_chatter()
{
    self endon( "death" );

    for (;;)
    {
        maps\_utility::set_battlechatter( 0 );
        common_scripts\utility::flag_wait( "flag_enable_battle_chatter" );
        maps\_utility::set_battlechatter( 1 );
        common_scripts\utility::flag_waitopen( "flag_enable_battle_chatter" );
    }
}

spawn_burke_common()
{
    level.burke = maps\_utility::spawn_targetname( "hero_burke" );
    level.burke thread maps\_utility::deletable_magic_bullet_shield();
    level.burke maps\lab_utility::assign_cloak_model( level.burke.model );
    level.burke.animname = "burke";
    level.burke thread maps\lab_utility::prevent_friendly_from_shooting_during_stealth();
    level.burke thread maps\lab_vo::burke_drone_warning_dialogue();
    level.burke thread maps\_cloak::check_for_npc_weapon_cloak_status_update();
}

spawn_cormack_common()
{
    level.cormack = maps\_utility::spawn_targetname( "hero_cormack" );
    level.cormack maps\lab_utility::assign_cloak_model( level.cormack.model );
    level.cormack thread maps\_utility::deletable_magic_bullet_shield();
    level.cormack.animname = "cormack";
}

spawn_knox_common()
{
    level.knox = maps\_utility::spawn_targetname( "hero_knox" );
    level.knox maps\lab_utility::assign_cloak_model( level.knox.model );
    level.knox thread maps\_utility::deletable_magic_bullet_shield();
    level.knox.animname = "knox";
}

debug_start_crash()
{
    thread maps\lab_lighting::lab();
    soundscripts\_snd::snd_message( "start_crash" );
    spawn_burke_common();
    level.burke.cloak = "off";
    level.burke animscripts\free_run::enable_free_running();
    level.burke maps\lab_utility::set_helmet_open( 0 );
    level.burke setthreatbiasgroup( "cloak_friendly_npcs" );
    set_completed_flags();

    if ( common_scripts\utility::flag( "flag_demo_itiot_start" ) )
        thread maps\_shg_utility::show_player_hud( "0" );
    else
        thread maps\_shg_utility::show_player_hud();

    if ( level.nextgen )
        thread maps\lab_code::startcloakingbinksequence();

    thread objective_init();
    thread maps\lab_code::setup_combat();
    thread maps\lab_code::player_movement_tweaks();
}

crash_logic()
{
    thread maps\lab_code::se_intro();
    maps\lab_code::se_intro_burke_react();
    maps\lab_code::se_intro_shack();
    maps\lab_code::se_burke_stumble_run();
    maps\lab_code::se_burke_dive_over_log();
    maps\lab_code::se_burke_hill_slide();
    maps\lab_code::se_burke_river_cross();
}

debug_start_forest_start()
{
    soundscripts\_snd::snd_message( "start_forest" );
    thread maps\lab_lighting::enter_forest();
    spawn_burke_common();
    level.burke maps\_utility::disable_ai_color();
    level.burke animscripts\free_run::enable_free_running();
    level.burke maps\lab_utility::set_helmet_open( 0 );
    level.burke setthreatbiasgroup( "cloak_friendly_npcs" );
    set_completed_flags();
    thread maps\lab_code::se_wall_climb_roots();
    thread maps\_shg_utility::show_player_hud();

    if ( level.nextgen )
        thread maps\lab_code::startcloakingbinksequence_debug();

    thread objective_init();
    thread maps\lab_code::setup_combat();
    thread maps\lab_code::player_movement_tweaks();
    level.player thread maps\lab_code::river_slow_movement_ai_think();
    setsaveddvar( "ammoCounterHide", "1" );
    common_scripts\utility::flag_set( "flag_helo_spotlight_on" );
    thread maps\lab_code::helo_spotlight_init();
    thread maps\lab_code::helo_spotlight_movement();
    maps\lab_utility::teleport_to_scriptstruct( "checkpoint_forest_start" );
}

forest_start_logic()
{
    thread maps\lab_code::se_burke_forest_wall_climb();
    maps\lab_code::se_search_drones_01();
}

debug_start_forest_takedown()
{
    soundscripts\_snd::snd_message( "start_forest_takedown" );
    thread maps\lab_lighting::forest_takedown();
    spawn_burke_common();
    level.burke maps\_utility::disable_ai_color();
    level.burke thread maps\lab_utility::cloak_on();
    level.burke animscripts\free_run::enable_free_running();
    level.burke setthreatbiasgroup( "cloak_friendly_npcs" );
    set_completed_flags();
    thread maps\_shg_utility::show_player_hud();
    thread objective_init();
    thread maps\lab_code::setup_combat();
    maps\_cloak::turn_on_the_cloak_effect();
    thread maps\lab_code::player_movement_tweaks();
    setsaveddvar( "ammoCounterHide", "1" );
    thread maps\lab_code::spawn_takedown_01_guys();
    maps\lab_utility::teleport_to_scriptstruct( "checkpoint_forest_takedown" );
}

forest_takedown_start_logic()
{
    maps\lab_code::se_forest_takedown_01();
}

debug_start_logging_road()
{
    soundscripts\_snd::snd_message( "start_logging_road" );
    thread maps\lab_lighting::logging_road();
    spawn_burke_common();
    level.burke maps\_utility::disable_ai_color();
    level.burke thread maps\_utility::enable_cqbwalk();
    level.burke thread maps\lab_utility::cloak_on();
    level.burke setthreatbiasgroup( "cloak_friendly_npcs" );
    set_completed_flags();
    thread maps\_shg_utility::show_player_hud();
    thread objective_init();
    thread maps\lab_code::setup_combat();
    maps\_cloak::turn_on_the_cloak_effect();
    thread maps\lab_code::player_movement_tweaks();
    level.player thread maps\lab_code::equip_player_smg();
    maps\lab_utility::teleport_to_scriptstruct( "checkpoint_logging_road_start" );
}

logging_road_logic()
{
    thread maps\lab_code::burke_forest_stealth_movement();
    thread maps\lab_code::se_vehicle_takedown_01();
    level.player setclutforplayer( "clut_lab_exterior", 0 );
}

debug_start_mech_march()
{
    soundscripts\_snd::snd_message( "start_mech_march" );
    thread maps\lab_lighting::logging_road();
    spawn_burke_common();
    level.burke maps\_utility::disable_ai_color();
    level.burke thread maps\_utility::enable_cqbwalk();
    level.burke thread maps\lab_utility::cloak_on();
    level.burke setthreatbiasgroup( "cloak_friendly_npcs" );
    set_completed_flags();
    thread maps\_shg_utility::show_player_hud();
    thread objective_init();
    thread maps\lab_code::setup_combat();
    maps\_cloak::turn_on_the_cloak_effect();
    thread maps\lab_code::player_movement_tweaks();
    level.player thread maps\lab_code::equip_player_smg();
    maps\lab_utility::teleport_to_scriptstruct( "checkpoint_mech_march_start" );
}

mech_march_logic()
{
    level.player setclutforplayer( "clut_lab_exterior", 0 );
    thread maps\lab_code::burke_mech_march_movement();
    thread maps\lab_code::logging_road_end_drop_logic();
    maps\lab_code::se_mech_march();
}

debug_start_cliff_rappel()
{
    soundscripts\_snd::snd_message( "start_cliff_rappel" );
    spawn_burke_common();
    level.burke maps\_utility::disable_ai_color();
    level.burke thread maps\lab_utility::cloak_on();
    set_completed_flags();
    thread maps\_shg_utility::show_player_hud();
    level.player thread maps\lab_code::equip_player_smg();
    thread maps\lab_lighting::cliff_rappel();
    thread objective_init();
    thread maps\lab_code::setup_combat();
    thread maps\lab_code::player_movement_tweaks();
    level.player thread maps\lab_code::equip_player_smg();
    maps\lab_utility::teleport_to_scriptstruct( "checkpoint_cliff_rappel_start" );
}

cliff_rappel_logic()
{
    thread maps\lab_utility::player_falling_to_death();
    maps\lab_code::se_cormack_meet();
}

debug_start_facility_breach()
{
    soundscripts\_snd::snd_message( "start_facility_breach" );
    spawn_burke_common();
    level.burke thread maps\lab_utility::cloak_on();
    level.burke maps\_utility::place_weapon_on( "iw5_bal27_sp_silencer01_variablereddot", "right" );
    spawn_cormack_common();
    level.cormack thread maps\lab_utility::cloak_on();
    spawn_knox_common();
    level.knox thread maps\lab_utility::cloak_on();
    set_completed_flags();
    thread maps\_shg_utility::show_player_hud();
    thread maps\lab_lighting::facility_breach();
    level.player thread maps\lab_code::equip_player();
    level.player thread maps\lab_code::debug_start_equip_player();
    maps\_cloak::turn_on_the_cloak_effect();
    thread objective_init();
    thread maps\lab_code::setup_combat();
    thread maps\lab_code::player_movement_tweaks();
    maps\lab_utility::teleport_to_scriptstruct( "checkpoint_facility_breach_start" );
}

facility_breach_logic()
{
    maps\lab_code::se_breach_guards();
    thread maps\lab_code::se_facility_breach();
    thread maps\lab_code::combat_post_breach_patrol();
}

debug_start_server_room()
{
    soundscripts\_snd::snd_message( "start_server_room" );
    maps\_stealth_utility::disable_stealth_system();
    spawn_burke_common();
    level.burke thread maps\_utility::enable_cqbwalk();
    level.burke thread maps\lab_utility::cloak_off();
    level.burke maps\_utility::place_weapon_on( "iw5_bal27_sp_silencer01_variablereddot", "right" );
    spawn_cormack_common();
    level.cormack thread maps\_utility::enable_cqbwalk();
    level.cormack thread maps\lab_utility::cloak_off();
    spawn_knox_common();
    level.knox thread maps\_utility::enable_cqbwalk();
    level.knox thread maps\lab_utility::cloak_off();
    set_completed_flags();
    thread maps\_shg_utility::show_player_hud();
    thread maps\lab_utility::enable_all_fixed_scanners();
    thread maps\lab_lighting::building_1();
    level.player thread maps\lab_code::equip_player();
    level.player thread maps\lab_code::debug_start_equip_player();
    thread objective_init();
    thread maps\lab_code::setup_combat();
    thread maps\lab_code::player_movement_tweaks();
    maps\lab_utility::teleport_to_scriptstruct( "checkpoint_server_room_start" );
}

server_room_logic()
{
    maps\lab_code::se_server_room_entrance();
}

debug_start_server_room_promo()
{
    soundscripts\_snd::snd_message( "start_server_room_promo" );
    maps\_stealth_utility::disable_stealth_system();
    spawn_burke_common();
    level.burke thread maps\_utility::enable_cqbwalk();
    level.burke thread maps\lab_utility::cloak_off();
    level.burke maps\_utility::place_weapon_on( "iw5_bal27_sp_silencer01_variablereddot", "right" );
    spawn_cormack_common();
    level.cormack thread maps\_utility::enable_cqbwalk();
    level.cormack thread maps\lab_utility::cloak_off();
    spawn_knox_common();
    level.knox thread maps\_utility::enable_cqbwalk();
    level.knox thread maps\lab_utility::cloak_off();
    set_completed_flags();
    thread maps\_shg_utility::show_player_hud();
    thread maps\lab_utility::enable_all_fixed_scanners();
    thread maps\lab_lighting::building_1();
    level.player thread maps\lab_code::equip_player();
    level.player thread maps\lab_code::debug_start_equip_player();
    common_scripts\utility::flag_set( "flag_server_room_promo" );
    thread objective_init();
    thread maps\lab_code::setup_combat();
    thread maps\lab_code::player_movement_tweaks();
    maps\lab_utility::teleport_to_scriptstruct( "checkpoint_server_room_start" );
}

server_room_promo_logic()
{

}

debug_start_research_facility_bridge()
{
    soundscripts\_snd::snd_message( "start_research_facility_bridge" );
    maps\_stealth_utility::disable_stealth_system();
    spawn_burke_common();
    level.burke maps\_utility::place_weapon_on( "iw5_bal27_sp_silencer01_variablereddot", "right" );
    spawn_cormack_common();
    spawn_knox_common();
    level.cormack thread maps\lab_utility::cloak_off();
    level.knox thread maps\lab_utility::cloak_off();
    set_completed_flags();
    common_scripts\utility::flag_set( "bridge_portalgrp_on" );
    thread maps\_shg_utility::show_player_hud();
    thread maps\lab_utility::enable_all_fixed_scanners();
    thread maps\lab_lighting::building_research_bridge();
    level.player thread maps\lab_code::equip_player();
    level.player thread maps\lab_code::debug_start_equip_player();
    thread objective_init();
    thread maps\lab_code::setup_combat();
    thread maps\lab_code::player_movement_tweaks();
    thread maps\lab_code::foam_room_door_think();
    common_scripts\utility::flag_set( "flag_enable_dsm_usetrigger" );
    maps\_utility::activate_trigger_with_targetname( "dsm_usetrigger" );
    maps\_utility::activate_trigger_with_targetname( "trig_color_research_facility_bridge" );
    maps\lab_utility::teleport_to_scriptstruct( "checkpoint_research_facility_bridge_start" );
}

research_facility_bridge_logic()
{

}

debug_start_foam_room()
{
    soundscripts\_snd::snd_message( "start_foam_room" );
    maps\_stealth_utility::disable_stealth_system();
    spawn_burke_common();
    level.burke maps\_utility::place_weapon_on( "iw5_bal27_sp_silencer01_variablereddot", "right" );
    spawn_cormack_common();
    spawn_knox_common();
    level.cormack thread maps\lab_utility::cloak_off();
    level.knox thread maps\lab_utility::cloak_off();
    set_completed_flags();
    thread maps\_shg_utility::show_player_hud();
    thread maps\lab_lighting::foam_room();
    level.player thread maps\lab_code::equip_player();
    level.player thread maps\lab_code::debug_start_equip_player();
    thread objective_init();
    thread maps\lab_code::setup_combat();
    thread maps\lab_code::player_movement_tweaks();
    thread maps\lab_code::foam_room_door_think();
    thread maps\lab_code::control_foam_room_door02_clip();
    common_scripts\utility::flag_set( "flag_enable_dsm_usetrigger" );
    maps\_utility::activate_trigger_with_targetname( "dsm_usetrigger" );
    maps\lab_utility::teleport_to_scriptstruct( "checkpoint_foam_room_start" );
}

foam_room_logic()
{
    thread maps\lab_code::se_foam_room_player();
}

debug_start_courtyard()
{
    soundscripts\_snd::snd_message( "start_courtyard" );
    maps\_stealth_utility::disable_stealth_system();
    spawn_burke_common();
    level.burke maps\_utility::place_weapon_on( "iw5_bal27_sp_silencer01_variablereddot", "right" );
    spawn_cormack_common();
    spawn_knox_common();
    level.cormack thread maps\lab_utility::cloak_off();
    level.knox thread maps\lab_utility::cloak_off();
    set_completed_flags();
    thread maps\_shg_utility::show_player_hud();
    thread maps\lab_lighting::courtyard();
    level.player thread maps\lab_code::equip_player();
    level.player thread maps\lab_code::debug_start_equip_player();
    thread objective_init();
    thread maps\lab_code::setup_combat();
    thread maps\lab_code::player_movement_tweaks();
    thread maps\lab_code::foam_room_door_think();
    common_scripts\utility::flag_set( "flag_enable_dsm_usetrigger" );
    maps\_utility::activate_trigger_with_targetname( "dsm_usetrigger" );
    maps\_utility::activate_trigger_with_targetname( "c4_usetrigger" );
    wait 0.5;
    maps\lab_utility::teleport_to_scriptstruct( "checkpoint_courtyard_start" );
}

courtyard_logic()
{
    maps\lab_code::se_foam_room();
}

debug_start_courtyard_jammer()
{
    soundscripts\_snd::snd_message( "start_courtyard_jammer" );
    maps\_stealth_utility::disable_stealth_system();
    spawn_burke_common();
    level.burke maps\_utility::place_weapon_on( "iw5_bal27_sp_silencer01_variablereddot", "right" );
    spawn_cormack_common();
    spawn_knox_common();
    level.cormack thread maps\lab_utility::cloak_off();
    level.knox thread maps\lab_utility::cloak_off();
    set_completed_flags();
    common_scripts\utility::flag_set( "flag_combat_courtyard_jammer" );
    thread maps\_shg_utility::show_player_hud();
    thread maps\lab_lighting::courtyard_jammer();
    level.player thread maps\lab_code::equip_player();
    level.player thread maps\lab_code::debug_start_equip_player();
    thread objective_init();
    thread maps\lab_code::setup_combat();
    thread maps\lab_code::player_movement_tweaks();
    common_scripts\utility::flag_set( "flag_enable_dsm_usetrigger" );
    maps\_utility::activate_trigger_with_targetname( "dsm_usetrigger" );
    maps\_utility::activate_trigger_with_targetname( "c4_usetrigger" );
    maps\lab_utility::teleport_to_scriptstruct( "checkpoint_jammer_start" );
    thread maps\lab_code::courtyard_scrambler_rotate();
    thread maps\lab_code::courtyard_hangar_door_close();
    maps\lab_code::courtyard_hangar_door_hack();
}

courtyard_jammer_logic()
{
    maps\lab_code::courtyard_jammer_scene();
}

debug_start_tank_hangar()
{
    soundscripts\_snd::snd_message( "start_tank_hangar" );
    maps\_stealth_utility::disable_stealth_system();
    spawn_burke_common();
    level.burke maps\_utility::place_weapon_on( "iw5_bal27_sp_silencer01_variablereddot", "right" );
    spawn_cormack_common();
    spawn_knox_common();
    level.cormack thread maps\lab_utility::cloak_off();
    level.knox thread maps\lab_utility::cloak_off();
    set_completed_flags();
    thread maps\_shg_utility::show_player_hud();
    level.player thread maps\lab_code::equip_player();
    level.player thread maps\lab_code::debug_start_equip_player();
    thread maps\lab_lighting::tank_hangar();
    thread objective_init();
    thread maps\lab_code::setup_combat();
    thread maps\lab_code::player_movement_tweaks();
    common_scripts\utility::flag_set( "flag_enable_dsm_usetrigger" );
    maps\_utility::activate_trigger_with_targetname( "dsm_usetrigger" );
    maps\_utility::activate_trigger_with_targetname( "c4_usetrigger" );
    maps\lab_utility::teleport_to_scriptstruct( "checkpoint_tank_hangar_start" );
    thread maps\lab_code::courtyard_hangar_door_close();
    thread maps\lab_code::courtyard_traversal_tank();
    thread maps\lab_code::courtyard_scrambler_rotate();
}

tank_hangar_logic()
{
    maps\lab_code::se_hovertank_reveal();
}

debug_start_tank_board()
{
    soundscripts\_snd::snd_message( "start_tank_board" );
    maps\_stealth_utility::disable_stealth_system();
    spawn_burke_common();
    level.burke maps\_utility::place_weapon_on( "iw5_bal27_sp_silencer01_variablereddot", "right" );
    spawn_cormack_common();
    spawn_knox_common();
    level.cormack thread maps\lab_utility::cloak_off();
    level.knox thread maps\lab_utility::cloak_off();
    set_completed_flags();
    thread maps\_shg_utility::show_player_hud();
    level.player thread maps\lab_code::equip_player();
    level.player thread maps\lab_code::debug_start_equip_player();
    thread maps\lab_lighting::tank_board();
    thread maps\lab_lighting::tank_reveal_models_start_point();
    thread objective_init();
    thread maps\lab_code::setup_combat();
    thread maps\lab_code::player_movement_tweaks();
    common_scripts\utility::flag_set( "flag_enable_dsm_usetrigger" );
    maps\_utility::activate_trigger_with_targetname( "dsm_usetrigger" );
    maps\_utility::activate_trigger_with_targetname( "c4_usetrigger" );
    maps\lab_utility::teleport_to_scriptstruct( "checkpoint_tank_board_start" );
    thread maps\lab_code::courtyard_traversal_tank();
    thread maps\lab_code::allow_player_hovertank_mount();
    thread maps\lab_code::courtyard_scrambler_rotate();
}

tank_board_logic()
{

}

debug_start_tank_road()
{
    soundscripts\_snd::snd_message( "start_tank_road" );
    maps\_stealth_utility::disable_stealth_system();
    spawn_burke_common();
    level.burke maps\_utility::place_weapon_on( "iw5_bal27_sp_silencer01_variablereddot", "right" );
    spawn_cormack_common();
    spawn_knox_common();
    level.cormack thread maps\lab_utility::cloak_off();
    level.knox thread maps\lab_utility::cloak_off();
    set_completed_flags();
    thread maps\_shg_utility::show_player_hud();
    level.player thread maps\lab_code::equip_player();
    level.player thread maps\lab_code::debug_start_equip_player();
    thread maps\lab_lighting::tank_road();
    maps\lab_utility::move_hovertank_to_start( "checkpoint_tank_road_start" );
    thread objective_init();
    thread maps\lab_code::setup_combat();
    thread maps\lab_code::player_movement_tweaks();
    common_scripts\utility::flag_set( "flag_enable_dsm_usetrigger" );
    maps\_utility::activate_trigger_with_targetname( "dsm_usetrigger" );
    maps\_utility::activate_trigger_with_targetname( "c4_usetrigger" );
    maps\lab_utility::teleport_to_scriptstruct( "checkpoint_tank_road_start" );
    thread maps\lab_code::courtyard_traversal_tank();
    thread maps\lab_code::courtyard_scrambler_rotate();
}

tank_road_logic()
{

}

debug_start_tank_field()
{
    soundscripts\_snd::snd_message( "start_tank_field" );
    maps\_stealth_utility::disable_stealth_system();
    spawn_burke_common();
    level.burke maps\_utility::set_ignoreme( 1 );
    level.burke maps\_utility::set_ignoreall( 1 );
    level.burke maps\_utility::place_weapon_on( "iw5_bal27_sp_silencer01_variablereddot", "right" );
    spawn_cormack_common();
    level.cormack maps\_utility::set_ignoreme( 1 );
    level.cormack maps\_utility::set_ignoreall( 1 );
    spawn_knox_common();
    level.knox maps\_utility::set_ignoreme( 1 );
    level.knox maps\_utility::set_ignoreall( 1 );
    level.cormack thread maps\lab_utility::cloak_off();
    level.knox thread maps\lab_utility::cloak_off();
    set_completed_flags();
    thread maps\_shg_utility::show_player_hud();
    thread maps\lab_lighting::tank_field();
    level.player thread maps\lab_code::equip_player();
    level.player thread maps\lab_code::debug_start_equip_player();
    maps\lab_utility::move_hovertank_to_start( "checkpoint_tank_field_start" );
    thread objective_init();
    thread maps\lab_code::setup_combat();
    thread maps\lab_code::player_movement_tweaks();
    common_scripts\utility::flag_set( "flag_enable_dsm_usetrigger" );
    maps\_utility::activate_trigger_with_targetname( "dsm_usetrigger" );
    maps\_utility::activate_trigger_with_targetname( "c4_usetrigger" );
    maps\lab_utility::teleport_to_scriptstruct( "checkpoint_tank_field_start" );
    thread maps\lab_code::courtyard_hangar_door_close();
    thread maps\lab_code::courtyard_traversal_tank();
}

tank_field_logic()
{

}

debug_start_tank_field_left_fork()
{
    soundscripts\_snd::snd_message( "start_tank_field" );
    maps\_stealth_utility::disable_stealth_system();
    spawn_burke_common();
    level.burke maps\_utility::set_ignoreme( 1 );
    level.burke maps\_utility::set_ignoreall( 1 );
    level.burke maps\_utility::place_weapon_on( "iw5_bal27_sp_silencer01_variablereddot", "right" );
    spawn_cormack_common();
    level.cormack maps\_utility::set_ignoreme( 1 );
    level.cormack maps\_utility::set_ignoreall( 1 );
    spawn_knox_common();
    level.knox maps\_utility::set_ignoreme( 1 );
    level.knox maps\_utility::set_ignoreall( 1 );
    level.cormack thread maps\lab_utility::cloak_off();
    level.knox thread maps\lab_utility::cloak_off();
    set_completed_flags();
    thread maps\_shg_utility::show_player_hud();
    thread maps\lab_lighting::tank_field();

    if ( level.nextgen )
        setsaveddvar( "r_umbraAccurateOcclusionThreshold", 128 );

    level.player thread maps\lab_code::equip_player();
    level.player thread maps\lab_code::debug_start_equip_player();
    maps\lab_utility::move_hovertank_to_start( "checkpoint_tank_left_fork_start" );
    thread objective_init();
    thread maps\lab_code::setup_combat();
    thread maps\lab_code::player_movement_tweaks();
    common_scripts\utility::flag_set( "flag_enable_dsm_usetrigger" );
    maps\_utility::activate_trigger_with_targetname( "dsm_usetrigger" );
    maps\_utility::activate_trigger_with_targetname( "c4_usetrigger" );
    maps\lab_utility::teleport_to_scriptstruct( "checkpoint_tank_left_fork_start" );
    thread maps\lab_code::courtyard_hangar_door_close();
    thread maps\lab_code::courtyard_traversal_tank();
}

debug_start_tank_field_right_fork()
{
    soundscripts\_snd::snd_message( "start_tank_field" );
    maps\_stealth_utility::disable_stealth_system();
    spawn_burke_common();
    level.burke maps\_utility::set_ignoreme( 1 );
    level.burke maps\_utility::set_ignoreall( 1 );
    level.burke maps\_utility::place_weapon_on( "iw5_bal27_sp_silencer01_variablereddot", "right" );
    spawn_cormack_common();
    level.cormack maps\_utility::set_ignoreme( 1 );
    level.cormack maps\_utility::set_ignoreall( 1 );
    spawn_knox_common();
    level.knox maps\_utility::set_ignoreme( 1 );
    level.knox maps\_utility::set_ignoreall( 1 );
    level.cormack thread maps\lab_utility::cloak_off();
    level.knox thread maps\lab_utility::cloak_off();
    set_completed_flags();
    thread maps\_shg_utility::show_player_hud();
    thread maps\lab_lighting::tank_field();

    if ( level.nextgen )
        setsaveddvar( "r_umbraAccurateOcclusionThreshold", 128 );

    level.player thread maps\lab_code::equip_player();
    level.player thread maps\lab_code::debug_start_equip_player();
    maps\lab_utility::move_hovertank_to_start( "checkpoint_tank_right_fork_start" );
    thread objective_init();
    thread maps\lab_code::setup_combat();
    thread maps\lab_code::player_movement_tweaks();
    common_scripts\utility::flag_set( "flag_enable_dsm_usetrigger" );
    maps\_utility::activate_trigger_with_targetname( "dsm_usetrigger" );
    maps\_utility::activate_trigger_with_targetname( "c4_usetrigger" );
    maps\lab_utility::teleport_to_scriptstruct( "checkpoint_tank_right_fork_start" );
    thread maps\lab_code::courtyard_hangar_door_close();
    thread maps\lab_code::courtyard_traversal_tank();
}

debug_start_tank_ascent()
{
    soundscripts\_snd::snd_message( "start_tank_field" );
    maps\_stealth_utility::disable_stealth_system();
    spawn_burke_common();
    level.burke maps\_utility::set_ignoreme( 1 );
    level.burke maps\_utility::set_ignoreall( 1 );
    level.burke maps\_utility::place_weapon_on( "iw5_bal27_sp_silencer01_variablereddot", "right" );
    spawn_cormack_common();
    level.cormack maps\_utility::set_ignoreme( 1 );
    level.cormack maps\_utility::set_ignoreall( 1 );
    level.cormack thread maps\lab_utility::cloak_off();
    spawn_knox_common();
    level.knox maps\_utility::set_ignoreme( 1 );
    level.knox maps\_utility::set_ignoreall( 1 );
    level.knox thread maps\lab_utility::cloak_off();
    set_completed_flags();
    thread maps\_shg_utility::show_player_hud();
    thread maps\lab_lighting::tank_field();

    if ( level.nextgen )
        setsaveddvar( "r_umbraAccurateOcclusionThreshold", 128 );

    level.player thread maps\lab_code::equip_player();
    level.player thread maps\lab_code::debug_start_equip_player();
    maps\lab_utility::move_hovertank_to_start( "checkpoint_tank_ascent_start" );
    thread objective_init();
    thread maps\lab_code::setup_combat();
    thread maps\lab_code::player_movement_tweaks();
    common_scripts\utility::flag_set( "flag_enable_dsm_usetrigger" );
    maps\_utility::activate_trigger_with_targetname( "dsm_usetrigger" );
    maps\_utility::activate_trigger_with_targetname( "c4_usetrigger" );
    maps\lab_utility::teleport_to_scriptstruct( "checkpoint_tank_ascent_start" );
    thread maps\lab_code::courtyard_hangar_door_close();
    thread maps\lab_code::courtyard_traversal_tank();
}

tank_ascent_logic()
{

}

debug_start_exfil()
{
    soundscripts\_snd::snd_message( "start_exfil" );
    maps\_stealth_utility::disable_stealth_system();
    spawn_burke_common();
    level.burke maps\_utility::place_weapon_on( "iw5_bal27_sp_silencer01_variablereddot", "right" );
    spawn_cormack_common();
    spawn_knox_common();
    level.knox thread maps\lab_utility::cloak_off();
    level.cormack thread maps\lab_utility::cloak_off();
    set_completed_flags();
    thread maps\_shg_utility::show_player_hud();
    level.player thread maps\lab_code::equip_player();
    level.player thread maps\lab_code::debug_start_equip_player();

    if ( level.nextgen )
        setsaveddvar( "r_umbraAccurateOcclusionThreshold", 128 );

    thread maps\lab_lighting::exfil();
    thread objective_init();
    thread maps\lab_code::setup_combat();
    thread maps\lab_code::player_movement_tweaks();
    common_scripts\utility::flag_set( "flag_enable_dsm_usetrigger" );
    maps\_utility::activate_trigger_with_targetname( "dsm_usetrigger" );
    maps\_utility::activate_trigger_with_targetname( "c4_usetrigger" );
    waittillframeend;
    maps\lab_utility::teleport_to_scriptstruct( "checkpoint_exfil_start" );
    thread maps\lab_code::courtyard_hangar_door_close();
    thread maps\lab_code::courtyard_traversal_tank();
    thread maps\lab_code::se_exfil_razorback();
    common_scripts\utility::flag_set( "flag_exfil_start" );
    var_0 = common_scripts\utility::getstruct( "hovertank_exit_org", "targetname" );
    var_1 = "hovertank_exit";
    level.hovertank_exterior_model = maps\_utility::spawn_anim_model( "hovertank", level.hovertank.origin );
    var_0 thread maps\_anim::anim_first_frame_solo( level.hovertank_exterior_model, var_1 );
}

exfil_logic()
{
    maps\lab_code::se_exfil();
}

start_demo_with_itiot()
{
    thread itiot_logic( "flag_demo_itiot" );

    if ( isdefined( level.introscreen.customfunc ) )
        thread [[ level.introscreen.customfunc ]]();

    debug_start_crash();
    crash_logic();
    forest_start_logic();
    forest_takedown_start_logic();
    logging_road_logic();
    mech_march_logic();
    cliff_rappel_logic();
    facility_breach_logic();
    server_room_logic();
    research_facility_bridge_logic();
    tank_hangar_logic();
    tank_board_logic();
    tank_road_logic();
    tank_field_logic();
    tank_ascent_logic();
    exfil_logic();
}

objective_init()
{
    thread setup_rappel_marker();
    setup_breach_marker();
    obj_escape_the_helo();
    obj_meet_cormack();
    obj_infiltrate_facility();
    obj_bio_weapons();
    obj_neutralize_bio_weapons();
    thread obj_locate_atlas_tank();
    obj_disable_courtyard_scrambler();
    obj_battle_to_exfil();
}

obj_escape_the_helo()
{
    common_scripts\utility::flag_wait( "flag_escape_the_sniper_obj_give" );
    objective_add( 1, "current", &"LAB_OBJECTIVE_ESCAPE_FOREST" );
    objective_onentity( 1, level.burke );
    common_scripts\utility::flag_wait( "flag_forest_climb_wall_start" );
    var_0 = getent( "obj_forest_climb_wall", "targetname" );
    objective_position( 1, var_0.origin );
    objective_setpointertextoverride( 1, &"LAB_OBJECTIVE_CLIMB" );
    common_scripts\utility::flag_wait( "player_climbing_wall" );
    objective_setpointertextoverride( 1, "" );
    objective_position( 1, ( 0, 0, 0 ) );
    common_scripts\utility::flag_wait( "flag_forest_climb_wall_complete" );
    maps\_utility::objective_complete( 1 );
    wait 0.5;
    thread maps\_utility::autosave_by_name( "wall_climb" );
}

obj_meet_cormack()
{
    common_scripts\utility::flag_wait( "flag_forest_climb_wall_complete" );
    objective_add( 2, "current", &"LAB_OBJECTIVE_MEET_CORMACK" );
    objective_onentity( 2, level.burke );
    common_scripts\utility::flag_wait_any( "flag_vehicle_takedown_01", "flag_se_vehicle_takedown_01_failed", "flag_forest_player_alt_path_01" );

    if ( common_scripts\utility::flag( "flag_vehicle_takedown_01" ) )
    {
        var_0 = getent( "obj_vrap_mute", "targetname" );
        objective_position( 2, var_0.origin );
        objective_setpointertextoverride( 2, &"LAB_OBJECTIVE_PLANT_CHARGE" );
        common_scripts\utility::flag_wait_any( "flag_vrap_mute_start", "flag_se_vehicle_takedown_01_complete" );

        if ( common_scripts\utility::flag( "flag_vrap_mute_start" ) )
        {
            objective_setpointertextoverride( 2, "" );
            objective_position( 2, ( 0, 0, 0 ) );
        }
    }

    common_scripts\utility::flag_wait( "flag_se_vehicle_takedown_01_complete" );
    objective_setpointertextoverride( 2, "" );
    objective_onentity( 2, level.burke );
    common_scripts\utility::flag_wait( "flag_obj_crawl_under_log" );

    if ( !common_scripts\utility::flag( "flag_seeker_clear" ) )
    {
        wait 3;
        var_1 = common_scripts\utility::getstruct( "obj_log_crawl", "targetname" );
        objective_position( 2, var_1.origin );
    }

    common_scripts\utility::flag_wait( "flag_seeker_clear" );
    var_2 = getent( "obj_meet_cormack", "targetname" );
    objective_position( 2, var_2.origin );
    common_scripts\utility::flag_wait( "flag_cormack_meet_start" );
    level.burke maps\_utility::gun_recall();
    level.burke animscripts\free_run::disable_free_running();
    maps\_utility::objective_complete( 2 );
    wait 0.5;
    thread maps\_utility::autosave_by_name( "cliff_rappel" );
}

obj_infiltrate_facility()
{
    var_0 = getent( "obj_cliff_rappel", "targetname" );
    objective_add( 3, "current", &"LAB_OBJECTIVE_INFILTRATE_FACILITY" );
    objective_position( 3, ( 0, 0, 0 ) );
    common_scripts\utility::flag_wait( "flag_player_ready_to_rappel" );
    objective_position( 3, var_0.origin );
    objective_setpointertextoverride( 3, &"LAB_OBJECTIVE_RAPPEL" );
    common_scripts\utility::flag_wait( "flag_rappel_start" );
    objective_position( 3, ( 0, 0, 0 ) );
    objective_setpointertextoverride( 3, "" );
    common_scripts\utility::flag_wait( "flag_breach_guards_clear" );

    if ( !common_scripts\utility::flag( "flag_facility_breach_complete" ) )
        wait 2;

    var_1 = getent( "obj_breach_research_facility", "targetname" );
    objective_position( 3, var_1.origin );

    if ( !common_scripts\utility::flag( "flag_facility_breach_complete" ) )
        wait 6;

    objective_position( 3, var_1.origin );
    objective_setpointertextoverride( 3, &"LAB_OBJECTIVE_PLANT_CHARGE" );

    if ( !common_scripts\utility::flag( "flag_facility_breach_complete" ) )
        common_scripts\utility::flag_wait( "breach_start" );

    objective_position( 3, ( 0, 0, 0 ) );
    objective_setpointertextoverride( 3, "" );
    common_scripts\utility::flag_wait( "flag_facility_breach_complete" );
    maps\_utility::objective_complete( 3 );
    wait 0.5;
    thread maps\_utility::autosave_by_name( "facility_breach" );
}

obj_bio_weapons()
{
    objective_add( 4, "current", &"LAB_OBJECTIVE_OBTAIN_EVIDENCE" );
    var_0 = getent( "obj_bio_weapons_01", "targetname" );
    objective_position( 4, var_0.origin );
    common_scripts\utility::flag_wait( "flag_obj_bio_weapons_02" );
    var_1 = getent( "obj_bio_weapons_02", "targetname" );
    objective_position( 4, var_1.origin );
    common_scripts\utility::flag_wait( "flag_obj_bio_weapons_03" );
    var_2 = getent( "obj_bio_weapons_03", "targetname" );
    objective_position( 4, var_2.origin );
    common_scripts\utility::flag_wait( "flag_obj_bio_weapons_04" );
    var_3 = getent( "obj_bio_weapons_04", "targetname" );
    objective_position( 4, var_3.origin );
    common_scripts\utility::flag_wait( "flag_obj_bio_weapons_05" );
    objective_position( 4, ( 0, 0, 0 ) );
    common_scripts\utility::flag_wait( "flag_enemy_server_room_se_dead" );
    var_4 = getent( "obj_bio_weapons_05", "targetname" );
    objective_position( 4, var_4.origin );
    objective_setpointertextoverride( 4, &"LAB_OBJECTIVE_USE" );
    var_5 = getent( "dsm_usetrigger", "targetname" );
    var_6 = var_5 maps\_shg_utility::hint_button_trigger( "x" );
    var_5 thread maps\_utility::addhinttrigger( &"LAB_DSM_PLANT_HINT", &"LAB_DSM_PLANT_HINT_PC" );
    common_scripts\utility::flag_wait( "flag_obj_bio_weapons_hack" );
    objective_position( 4, ( 0, 0, 0 ) );
    objective_setpointertextoverride( 4, "" );
    var_5 thread maps\_utility::addhinttrigger( "", "" );
    var_6 maps\_shg_utility::hint_button_clear();
    common_scripts\utility::flag_wait( "flag_obj_bio_weapons_complete" );
    maps\_utility::objective_complete( 4 );
}

obj_neutralize_bio_weapons()
{
    var_0 = getent( "foam_grenade_obj", "targetname" );
    var_0 hide();
    objective_add( 5, "current", &"LAB_OBJECTIVE_NEUTRALIZE_STORAGE" );
    var_1 = getent( "obj_destroy_equipment_01", "targetname" );
    objective_position( 5, var_1.origin );
    common_scripts\utility::flag_wait( "flag_player_inside_foam_room" );
    objective_setpointertextoverride( 5, &"LAB_OBJECTIVE_PLANT_CHARGE" );
    var_0 show();
    var_2 = getent( "c4_usetrigger", "targetname" );
    var_3 = var_2 maps\_shg_utility::hint_button_trigger( "x" );
    var_2 thread maps\_utility::addhinttrigger( &"LAB_EXPLOSIVE_PLANT_HINT", &"LAB_EXPLOSIVE_PLANT_HINT_PC" );
    common_scripts\utility::flag_wait( "flag_obj_neutralize_bio_weapons_planted" );
    level.burke maps\_utility::disable_cqbwalk();
    level.cormack maps\_utility::disable_cqbwalk();
    level.knox maps\_utility::disable_cqbwalk();
    var_0 hide();
    var_2 thread maps\_utility::addhinttrigger( "", "" );
    var_3 maps\_shg_utility::hint_button_clear();
    objective_onentity( 5, level.cormack );
    objective_setpointertextoverride( 5, "" );

    if ( !common_scripts\utility::flag( "flag_obj_neutralize_bio_weapons_complete" ) )
    {
        maps\lab_code::se_foam_room_bomb();
        common_scripts\utility::flag_set( "flag_obj_neutralize_bio_weapons_complete" );
        soundscripts\_snd::snd_message( "neutralize_bio_weapons_complete" );
    }

    common_scripts\utility::flag_wait( "flag_obj_neutralize_bio_weapons_complete" );
    maps\_utility::objective_complete( 5 );
    wait 0.5;
    thread maps\_utility::autosave_by_name( "foam_room" );
}

obj_disable_courtyard_scrambler()
{
    common_scripts\utility::flag_wait( "flag_obj_courtyard_jammer_start" );
    objective_add( 6, "current", &"LAB_OBJECTIVE_DISABLE_SCRAMBLER" );
    thread maps\_utility::autosave_by_name( "jammer" );
    var_0 = getent( "trig_jammer", "targetname" );
    var_1 = getent( "obj_jammer_01", "targetname" );
    objective_position( 6, var_0.origin );
    objective_setpointertextoverride( 6, &"LAB_PLANT_JAMMER" );
    var_0 = getent( "trig_jammer", "targetname" );
    var_0 thread maps\_utility::addhinttrigger( &"LAB_DISABLE_SCRAMBLER_HINT", &"LAB_DISABLE_SCRAMBLER_HINT_PC" );
    var_2 = var_0 maps\_shg_utility::hint_button_trigger( "x" );
    common_scripts\utility::flag_wait( "flag_obj_jammer_interact" );
    objective_position( 6, ( 0, 0, 0 ) );
    var_0 thread maps\_utility::addhinttrigger( "", "" );
    var_2 maps\_shg_utility::hint_button_clear();
    common_scripts\utility::flag_wait( "flag_obj_jammer_complete" );
    thread maps\lab_code::courtyard_hangar_door_logic();
    thread maps\_utility::autosave_by_name( "jammer_destroyed" );
    maps\_utility::objective_complete( 6 );
}

obj_defend_squad()
{
    common_scripts\utility::flag_wait( "flag_obj_courtyard_defend_start" );
    objective_add( 7, "current", &"LAB_OBJECTIVE_DEFEND_SQUAD" );
    var_0 = getent( "obj_defend_01", "targetname" );
    objective_position( 7, var_0.origin );
    objective_setpointertextoverride( 7, &"LAB_DEFEND" );
    common_scripts\utility::flag_wait( "flag_courtyard_hangar_door_hack_success" );
    maps\_utility::objective_complete( 7 );
}

obj_locate_atlas_tank()
{
    common_scripts\utility::flag_wait( "flag_obj_locate_atlas_tank" );
    objective_add( 8, "current", &"LAB_OBJECTIVE_LOCATE_TANK" );
    var_0 = getent( "obj_tank_01", "targetname" );
    objective_position( 8, var_0.origin );
    common_scripts\utility::flag_wait( "flag_courtyard_hangar_door_block" );
    objective_position( 8, ( 0, 0, 0 ) );
    common_scripts\utility::flag_wait( "flag_courtyard_hangar_door_hack_success" );
    objective_setpointertextoverride( 8, "" );
    objective_position( 8, var_0.origin );
    common_scripts\utility::flag_wait( "flag_obj_tank_02" );
    var_1 = getent( "obj_tank_02", "targetname" );
    objective_position( 8, var_1.origin );
    common_scripts\utility::flag_wait( "flag_obj_tank_03" );
    thread maps\_utility::autosave_by_name( "tank_hangar_approach" );
    var_2 = getent( "obj_tank_03", "targetname" );
    objective_position( 8, var_2.origin );
    common_scripts\utility::flag_wait( "flag_obj_tank_04" );
    var_3 = getent( "obj_tank_04", "targetname" );
    objective_position( 8, var_3.origin );
    common_scripts\utility::flag_wait( "flag_obj_tank_05" );
    objective_position( 8, ( 0, 0, 0 ) );
    common_scripts\utility::flag_wait( "flag_obj_tank_06" );
    var_4 = common_scripts\utility::getstruct( "obj_tank_06", "targetname" );
    objective_position( 8, var_4.origin );
    objective_setpointertextoverride( 8, &"LAB_OBJECTIVE_ENTER" );
    common_scripts\utility::flag_wait( "player_entering_hovertank" );
    common_scripts\utility::flag_set( "flag_obj_tank_complete" );
    maps\_utility::objective_complete( 8 );
    common_scripts\utility::flag_wait( "player_in_hovertank" );
}

obj_battle_to_exfil()
{
    common_scripts\utility::flag_wait( "player_in_hovertank" );
    objective_add( 9, "current", &"LAB_OBJECTIVE_EXFIL" );
    var_0 = getent( "obj_battle_exfil_00", "targetname" );
    objective_position( 9, var_0.origin );
    common_scripts\utility::flag_wait( "flag_courtyard_gate_01_explode" );
    var_1 = getent( "obj_battle_exfil_01", "targetname" );
    objective_position( 9, var_1.origin );
    common_scripts\utility::flag_wait( "flag_obj_battle_exfil_02" );
    var_2 = getent( "obj_battle_exfil_02", "targetname" );
    objective_position( 9, var_2.origin );
    common_scripts\utility::flag_wait( "flag_obj_battle_exfil_03" );
    var_3 = getent( "obj_battle_exfil_03", "targetname" );
    objective_position( 9, var_3.origin );
    delete_cloak_cover();
    common_scripts\utility::flag_wait( "flag_obj_hide_marker_during_tank_exit" );
    objective_position( 9, ( 0, 0, 0 ) );
    common_scripts\utility::flag_wait( "flag_player_exfil_enter_ready" );
    var_4 = getent( "obj_battle_exfil_04", "targetname" );
    objective_position( 9, var_4.origin );
    common_scripts\utility::flag_wait( "flag_player_exfil_enter" );
    soundscripts\_snd::snd_message( "aud_start_exfil_foley" );
    objective_position( 9, ( 0, 0, 0 ) );
    common_scripts\utility::flag_wait( "flag_obj_battle_exfil_complete" );
    maps\_utility::objective_complete( 9 );
    common_scripts\utility::flag_wait( "flag_mission_complete" );
}

setup_breach_marker()
{
    var_0 = getent( "breach_hint_01", "targetname" );
    var_1 = spawn( "script_model", ( 0, 0, 0 ) );
    var_1 setmodel( "mutecharge_obj" );
    var_1.angles = var_0.angles;
    var_1.origin = var_0.origin;
    thread breach_cleanup( var_1 );
}

breach_cleanup( var_0 )
{
    level endon( "missionfailed" );
    level waittill( "breaching" );
    wait 0.4;

    if ( isdefined( var_0 ) )
        var_0 delete();

    level waittill( "breach_explosion" );
    thread maps\lab_lighting::breach_fx();
    level waittill( "slowmo_breach_ending" );
    common_scripts\utility::flag_wait( "breach_done" );
    common_scripts\utility::flag_set( "flag_facility_breach_complete" );
    level.burke.animname = "burke";
    level.burke maps\_utility::enable_cqbwalk();
    level.cormack maps\_utility::enable_cqbwalk();
    level.knox maps\_utility::enable_cqbwalk();
}

setup_rappel_marker()
{
    var_0 = getent( "rappel_anchor_obj", "targetname" );
    var_0 hide();
    common_scripts\utility::flag_wait( "flag_player_ready_to_rappel" );
    var_0 show();
    common_scripts\utility::flag_wait( "flag_rappel_start" );
    var_0 delete();
}

setup_portal_scripting()
{
    common_scripts\utility::flag_init( "forest_start_portalgrp_on" );
    thread maps\_shg_utility::portal_group_on( "forest_start_portalgrp_on", "portal_grp_forest_start" );
    common_scripts\utility::flag_init( "facility_breach_portalgrp_on" );
    thread handle_lab_portal_scripting( "portal_grp_facility_breach", "facility_breach_portalgrp_on", "endPortalFacBreach" );
    common_scripts\utility::flag_init( "bridge_portalgrp_on" );
    thread handle_lab_portal_scripting( "portal_grp_bridge", "bridge_portalgrp_on", "endPortalBridge" );
    common_scripts\utility::flag_init( "tank_hangar_door_portalgrp_on" );
    thread handle_lab_portal_scripting( "portal_grp_tank_hangar_door", "tank_hangar_door_portalgrp_on", "endPortalHangarDoor" );
    thread handle_lab_portal_scripting( "portal_grp_tank_hangar", "flag_obj_tank_complete", "endPortalTankHangar" );
}

handle_lab_portal_scripting( var_0, var_1, var_2 )
{
    level.player endon( "death" );
    level endon( "missionfailed" );

    if ( isdefined( var_2 ) && isstring( var_2 ) )
        level endon( var_2 );

    var_3 = getentarray( var_0, "targetname" );
    var_3[0] enableportalgroup( 0 );

    for (;;)
    {
        common_scripts\utility::flag_wait( var_1 );
        var_3[0] enableportalgroup( 1 );

        if ( isdefined( var_2 ) )
            level notify( var_2 );

        common_scripts\utility::flag_waitopen( var_1 );
        var_3[0] enableportalgroup( 0 );
    }
}

setup_cloak_cover()
{
    level.player endon( "death" );
    level endon( "missionfailed" );
    level endon( "endCloakVis" );
    var_0 = getent( "cloaking_cover", "targetname" );
    var_0 hide();

    for (;;)
    {
        common_scripts\utility::flag_wait( "flag_show_cloak_cover" );
        var_0 show();
        common_scripts\utility::flag_waitopen( "flag_show_cloak_cover" );
        var_0 hide();
    }
}

delete_cloak_cover()
{
    var_0 = getent( "cloaking_cover", "targetname" );
    var_0 delete();
    level notify( "endCloakVis" );
}

tff_trans_middle_to_outro_ally_check()
{
    var_0 = getent( "tff_unload_middle_ally_check_trig", "targetname" );
    level.tff_trans_ally_check_count = 0;

    for (;;)
    {
        var_0 waittill( "trigger", var_1 );

        if ( isdefined( var_1.tff_trans_ally_check_active ) && var_1.tff_trans_ally_check_active )
            continue;

        if ( isdefined( var_1.script_friendname ) )
            var_2 = tolower( var_1.script_friendname );
        else
            var_2 = "";

        if ( var_1 == level.player || var_2 == "cormack" || var_2 == "gideon" || var_2 == "knox" )
        {
            level.tff_trans_ally_check_count++;

            if ( level.tff_trans_ally_check_count >= 4 )
            {
                common_scripts\utility::flag_set( "tff_trans_middle_to_outro_allies_ready" );
                break;
            }

            var_1.tff_trans_ally_check_active = 1;
            var_1 thread tff_trans_middle_to_outro_ally_touching( var_0 );
        }
    }
}

tff_trans_middle_to_outro_ally_touching( var_0 )
{
    while ( self istouching( var_0 ) )
        wait 0.05;

    level.tff_trans_ally_check_count--;
    self.tff_trans_ally_check_active = 0;
}

transient_transition_middle_to_outro()
{
    if ( !istransientloaded( "lab_outro_tr" ) )
    {
        thread tff_trans_middle_to_outro_ally_check();
        common_scripts\utility::flag_wait( "tff_trans_middle_to_outro_allies_ready" );
        level notify( "tff_pre_middle_to_outro" );
        unloadtransient( "lab_middle_tr" );
        loadtransient( "lab_outro_tr" );

        while ( !istransientloaded( "lab_outro_tr" ) )
            wait 0.05;

        level notify( "tff_post_middle_to_outro" );
    }
}

cull_distance_triggers()
{
    var_0 = getentarray( "current_gen_cull_reduction", "targetname" );

    for (;;)
    {
        var_1 = 0;

        foreach ( var_3 in var_0 )
        {
            if ( level.player istouching( var_3 ) )
            {
                var_4 = int( var_3.script_noteworthy );
                setculldist( var_4 );
                var_1 = 1;
            }
        }

        if ( !var_1 )
            setculldist( 0 );

        wait 0.2;
    }
}

itiot_logic( var_0 )
{
    common_scripts\utility::flag_set( "flag_demo_itiot_start" );
    common_scripts\utility::flag_wait( var_0 );
    soundscripts\_snd::snd_message( "e3_demo_fade_out" );
    level.player.auxillary_hud = newclienthudelem( level.player );
    level.player.auxillary_hud setshader( "black", 1280, 720 );
    level.player.auxillary_hud.horzalign = "fullscreen";
    level.player.auxillary_hud.vertalign = "fullscreen";
    level.player.auxillary_hud.alpha = 0;
    level.player.auxillary_hud fadeovertime( 0.5 );
    level.player.auxillary_hud.alpha = 1;
    level.player.auxillary_hud.foreground = 1;
    setsaveddvar( "objectiveHide", "1" );
    wait 0.5;
    common_scripts\utility::array_call( getaiarray( "axis" ), ::delete );
    soundscripts\_snd::snd_message( "e3_demo_clear_alarm" );
    level.player.auxillary_hud.foreground = 0;
    wait 5;
    common_scripts\utility::array_call( getaiarray( "axis" ), ::delete );
    maps\lab_utility::teleport_to_scriptstruct( "hovertank_reveal_demo_pos" );
    level.knox thread maps\lab_utility::goto_node( getnode( "tank_hangar_knox_node", "targetname" ), 0 );
    set_itiot_flags();
    wait 2;
    thread itiot_dialogue();
    soundscripts\_snd::snd_message( "e3_demo_fade_in" );
    level.player.auxillary_hud.alpha = 1;
    level.player.auxillary_hud fadeovertime( 1 );
    level.player.auxillary_hud.alpha = 0;
    tank_hangar_logic();
    tank_board_logic();
    tank_road_logic();
    tank_field_logic();
    tank_ascent_logic();
    exfil_logic();
}

set_itiot_flags()
{
    common_scripts\utility::flag_set( "flag_combat_foam_corridor" );
    common_scripts\utility::flag_set( "flag_foam_corridor_exit" );
    common_scripts\utility::flag_set( "flag_courtyard_hangar_door_block" );
    common_scripts\utility::flag_set( "flag_obj_bio_weapons_02" );
    common_scripts\utility::flag_set( "flag_obj_bio_weapons_03" );
    common_scripts\utility::flag_set( "flag_obj_bio_weapons_04" );
    common_scripts\utility::flag_set( "flag_obj_bio_weapons_05" );
    common_scripts\utility::flag_set( "flag_enemy_server_room_se_dead" );
    common_scripts\utility::flag_set( "flag_obj_bio_weapons_hack" );
    common_scripts\utility::flag_set( "flag_obj_bio_weapons_complete" );
    maps\_utility::objective_complete( 5 );
    thread obj_disable_courtyard_scrambler();
    thread obj_locate_atlas_tank();
    thread obj_battle_to_exfil();
    common_scripts\utility::flag_set( "flag_obj_courtyard_jammer_start" );
    common_scripts\utility::flag_set( "flag_obj_jammer_interact" );
    common_scripts\utility::flag_set( "flag_obj_jammer_complete" );
    common_scripts\utility::flag_set( "flag_obj_courtyard_defend_start" );
    common_scripts\utility::flag_set( "flag_courtyard_hangar_door_hack_success" );
    common_scripts\utility::flag_set( "flag_obj_locate_atlas_tank" );
    common_scripts\utility::flag_set( "flag_courtyard_hangar_door_block" );
    common_scripts\utility::flag_set( "flag_courtyard_hangar_door_hack_success" );
    common_scripts\utility::flag_set( "flag_obj_tank_02" );
    common_scripts\utility::flag_set( "flag_obj_tank_03" );
    common_scripts\utility::flag_set( "flag_obj_tank_04" );
}

itiot_dialogue()
{
    maps\lab_vo::tank_hangar_dialogue();
    maps\lab_vo::tank_board_dialogue();
    maps\lab_vo::tank_courtyard_dialogue();
    maps\lab_vo::tank_road_dialogue();
    maps\lab_vo::tank_field_dialogue();
    maps\lab_vo::tank_clearing_dialogue();
    maps\lab_vo::tank_ascent_dialogue();
    maps\lab_vo::tank_exit_dialogue();
    maps\lab_vo::exfil_dialogue();
}

umbra_accuracy_tweaks()
{
    if ( level.nextgen )
        setsaveddvar( "r_umbraAccurateOcclusionThreshold", 128 );

    common_scripts\utility::flag_wait( "flag_forest_climb_wall_start" );

    if ( level.nextgen )
        setsaveddvar( "r_umbraAccurateOcclusionThreshold", 1024 );
}

umbra_accuracy_tweaks_tank_field()
{
    common_scripts\utility::flag_wait( "flag_obj_battle_exfil_02" );
    var_0 = getent( "trig_umbra_tweak_128", "targetname" );
    var_1 = getent( "trig_umbra_tweak_1024", "targetname" );
    var_0 thread umbra_tweak_128( var_1 );
    var_1 thread umbra_tweak_1024( var_0 );
}

umbra_tweak_128( var_0 )
{
    for (;;)
    {
        self waittill( "trigger" );

        if ( level.nextgen )
            setsaveddvar( "r_umbraAccurateOcclusionThreshold", 128 );

        var_0 waittill( "trigger" );
    }
}

umbra_tweak_1024( var_0 )
{
    for (;;)
    {
        self waittill( "trigger" );

        if ( level.nextgen )
            setsaveddvar( "r_umbraAccurateOcclusionThreshold", 1024 );

        var_0 waittill( "trigger" );
    }
}
