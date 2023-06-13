// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    maps\_utility::template_level( "lagos" );
    setup_start_points();
    init_level_flags();
    animscripts\traverse\boost::precache_boost_fx_npc();
    maps\_exo_climb::load_precache();

    if ( level.currentgen )
        maps\_utility::tff_sync_setup();

    maps\createart\lagos_art::main();
    maps\lagos_fx::main();
    maps\lagos_precache::main();
    maps\_load::main();
    thread maps\_player_exo::main( "specialist" );
    maps\lagos_lighting::main();
    maps\lagos_anim::main();
    maps\lagos_aud::main();
    maps\lagos_vo::main();
    maps\lagos_jump::main();
    maps\_player_high_jump::main();
    maps\_variable_grenade::main();
    maps\_drone_ai::init();
    maps\_drone_civilian::init();
    maps\_microwave_grenade::main();
    maps\_exo_climb::main( "atlas_pmc" );
    level.scr_model["player_climb_rig"] = "s1_gfl_ump45_viewbody";
    
    mag_wall_gov_setup();
    vehicle_scripts\_generic_script_model_lagos::main( "script_model", "script_model", "script_model" );

    if ( level.currentgen )
    {
        thread transient_transitions();
        thread transient_cleanup();
    }

    var_0 = getdvarint( "scr_traverse_debug" );
    maps\lagos_h_breach::precacheharmonicbreach();
    maps\_controlled_orbiting_drone::precacheassets_and_initflags();
    precacheshader( "overlay_static_digital" );
    precacheshader( "s1_railgun_hud_outer_shadow" );
    precachemodel( "viewhands_atlas_pmc_smp" );
    precachemodel( "worldhands_atlas_pmc_smp" );
    precachemodel( "viewbody_atlas_pmc_smp_custom" );
    precachemodel( "npc_titan45_base_loot" );
    precachemodel( "npc_titan45_nocamo" );
    precacheshellshock( "iw5_bal27_sp" );
    // precacheshellshock( "iw5_titan45_sp" );
    precacheshellshock( "iw5_asm1_sp" );
    // precacheshellshock( "iw5_uts19_sp" );
    precachemodel( "vm_hms_rhino" );
    precacheshader( "mtl_lag_exo_door_breach" );
    precacheshellshock( "iw5_sn6_sp" );
    precacheshellshock( "iw5_mors_sp" );
    precachemodel( "npc_bal27_nocamo" );
    // precacheshellshock( "iw5_kf5_sp" );
    // precacheshellshock( "iw5_mahemstraight_sp" );
    precachemodel( "vehicle_ind_semi_truck_fuel_tanker" );
    precachemodel( "ind_semi_truck_fuel_tank_destroy" );
    precachemodel( "ind_semi_truck_03_destroy" );
    precachemodel( "com_bike_animated" );
    precachemodel( "s1_bicycle" );
    precachemodel( "vehicle_scooter_vespa_static_blue" );
    precachemodel( "vehicle_scooter_vespa_static_green" );
    precachemodel( "vehicle_scooter_vespa_static_lightblue" );
    precachemodel( "vehicle_scooter_vespa_static_cream" );
    precachemodel( "weapon_rpg7" );
    precachemodel( "vehicle_civ_det_train_car_01" );
    precachemodel( "rope50ft" );
    precachemodel( "viewhands_player_delta" );
    precachemodel( "lag_harmonic_breach_device" );
    precachemodel( "lag_harmonic_breach_device_obj" );
    precachemodel( "electronics_pda_big" );
    precachemodel( "vehicle_civ_boxtruck_highres_ai" );
    precachemodel( "tag_laser" );
    precachemodel( "npc_exo_launch_pad" );
    precachemodel( "vehicle_civ_full_size_technical_turret" );
    precacheturret( "vehicle_civ_full_size_technical_turret" );
    precacheturret( "50cal_turret_technical_lagos" );
    precachemodel( "muteCharge" );
    precachemodel( "lag_roof_breach_device" );
    precachemodel( "com_hand_radio" );
    precachelaser( "prison_laser" );
    precachelaser( "lag_snipper_laser" );
    precachelaser( "tracking_drone_laser" );
    precachelaser( "orbital_strike_laser" );
    precacherumble( "damage_light" );
    precacherumble( "light_1s" );
    precacherumble( "light_2s" );
    precacherumble( "light_3s" );
    precacherumble( "damage_heavy" );
    precacherumble( "heavy_1s" );
    precacherumble( "heavy_2s" );
    precacherumble( "heavy_3s" );
    precacherumble( "artillery_rumble" );
    precacherumble( "steady_rumble" );
    setsaveddvar( "r_hudoutlineenable", 1 );
    precachesonarvisioncodeassets();

    if ( level.currentgen )
    {
        setsaveddvar( "r_gunSightColorEntityScale", "7" );
        setsaveddvar( "r_gunSightColorNoneScale", "0.8" );
    }

    setdvar( "qte_show_real_weapon", 1 );
    maps\lagos_anim::precachecivilian();
    maps\_swim_player::init_player_swim();

    if ( level.nextgen )
    {
        maps\_utility::array_spawn_function_noteworthy( "delete_at_path_end", maps\lagos_utility::delete_at_path_end );
        maps\_utility::array_spawn_function_noteworthy( "delete_at_path_end", maps\lagos_utility::walking_civilian_react );
    }

    maps\_utility::array_spawn_function_targetname( "alley1_stage3_refill", maps\lagos_utility::alley1_stage3_refill_think );
    maps\_utility::array_spawn_function_noteworthy( "equip_microwave_grenade", maps\lagos_utility::equip_microwave_grenade );
    maps\_utility::array_spawn_function_noteworthy( "KVA", maps\lagos_utility::immune_sonic_blast );
    maps\_utility::array_spawn_function_noteworthy( "Hostage", maps\lagos_utility::immune_sonic_blast );
    maps\_utility::array_spawn_function_noteworthy( "gov_building_kva_soldier", maps\lagos_utility::immune_sonic_blast );
    maps\_utility::array_spawn_function_noteworthy( "immune_sonic_blast", maps\lagos_utility::immune_sonic_blast );
    level thread handle_objectives();
    thread maps\_vehicle_traffic::traffic_init();
    thread maps\lagos_code::setup_gameplay();
    maps\_utility::add_control_based_hint_strings( "move_fly_drone", &"LAGOS_FLY_DRONE_CONTROL", maps\_controlled_orbiting_drone::move_fly_drone_check, &"LAGOS_FLY_DRONE_CONTROL_PC", &"LAGOS_FLY_DRONE_CONTROL_SP" );
    maps\_utility::add_control_based_hint_strings( "use_exo_shield", &"LAGOS_EXO_SHIELD", maps\lagos_code::use_exo_shield_check );
    maps\_utility::add_hint_string( "player_exo_jump", &"LAGOS_EXO_JUMP_HINT", maps\lagos_code::player_exo_jump_hint_off );
    maps\_utility::add_hint_string( "player_exo_jump_release", &"LAGOS_EXO_JUMP_RELEASE_HINT", maps\lagos_code::player_exo_jump_release_hint_off );
    maps\_utility::add_hint_string( "qte_grab_hold", &"LAGOS_QTE_GRAB_HOLD", maps\lagos_qte::qte_grab_hold_off );
    maps\_utility::add_hint_string( "qte_shoot_kva", &"LAGOS_QTE_SHOOT_KVA", maps\lagos_qte::qte_shoot_kva_off );
    maps\_utility::add_hint_string( "qte_pry_open", &"LAGOS_QTE_PRY_OPEN", maps\lagos_qte::qte_pry_open_off );
    maps\_utility::add_hint_string( "qte_swim", &"LAGOS_QTE_SWIM", maps\lagos_qte::qte_swim_off );
    maps\_utility::add_hint_string( "qte_success", &"LAGOS_QTE_SUCCESS", maps\lagos_qte::qte_success_off );
    maps\_utility::add_hint_string( "qte_fail", &"LAGOS_QTE_FAIL", maps\lagos_qte::qte_fail_off );
    maps\_utility::add_hint_string( "qte_middle_shoot", &"LAGOS_QTE_MIDDLE_SHOOT", maps\lagos_qte_middle::qte_middle_shoot_off );
    maps\_utility::add_hint_string( "qte_middle_dodge", &"LAGOS_QTE_MIDDLE_DODGE", maps\lagos_qte_middle::qte_middle_dodge_off );
    maps\_utility::add_hint_string( "qte_middle_jump", &"LAGOS_QTE_MIDDLE_JUMP", maps\lagos_qte_middle::qte_middle_jump_off );
    maps\_utility::add_hint_string( "qte_middle_pull_windshield", &"LAGOS_QTE_MIDDLE_PULL_WINDSHIELD", maps\lagos_qte_middle::qte_middle_pull_windshield_off );
    maps\_utility::add_hint_string( "qte_middle_pull_kva", &"LAGOS_QTE_MIDDLE_PULL_KVA", maps\lagos_qte_middle::qte_middle_pull_kva_off );
    maps\_utility::add_hint_string( "left_climb_hint", &"LAGOS_PRESS_CLIMB_LEFT", maps\lagos_utility::break_left_climb_hint );
    maps\_utility::add_hint_string( "right_climb_hint", &"LAGOS_PRESS_CLIMB_RIGHT", maps\lagos_utility::break_right_climb_hint );
    maps\_utility::add_hint_string( "start_fly_drone", &"LAGOS_START_FLY_DRONE", maps\lagos_utility::hint_string_disable_exo_door );
    maps\_utility::add_hint_string( "exo_door_breach", &"LAGOS_EXO_DOOR_BREACH", maps\lagos_utility::hint_string_disable_exo_door );
    maps\_utility::add_hint_string( "roof_mute_charge", &"LAGOS_ROOF_MUTE_CHARGE", maps\lagos_utility::hint_string_disable_mute_charge );
    maps\_utility::add_hint_string( "place_sensor", &"LAGOS_PLACE_SENSOR", maps\lagos_utility::hint_string_disable_place_sensor );
    maps\_utility::add_hint_string( "release_pm", &"LAGOS_RELEASE_PM", maps\lagos_utility::hint_string_disable_place_sensor );
    maps\_utility::add_hint_string( "bus_ledge", &"LAGOS_BUS_JUMP_1", maps\lagos_utility::hint_string_disable_place_sensor );
    createthreatbiasgroup( "friendly_squad" );
    createthreatbiasgroup( "player_haters" );
    createthreatbiasgroup( "frogger_middle" );
    createthreatbiasgroup( "player" );
    level.player.hack_fix_lagos_flank_alley_camera_pop = 1;
    var_1 = getent( "harmonic_breach_player_blocker", "targetname" );
    var_1 notsolid();
}

#using_animtree("player");

mag_wall_gov_setup()
{
    var_0 = getent( "anim_org_exo_climb_player", "targetname" );
    var_1 = getent( "lighting_centroid_overlook_door_exterior", "targetname" );
    var_0 overridelightingorigin( var_1.origin );
    var_2 = getanimlength( %lag_gov_wallpullup_start_vm ) - 1;
    maps\_exo_climb::override_mount_anim( "mag_climb_gov_wall", %lag_gov_wallpullup_start_vm, var_0, undefined, var_2 );
}

transient_cleanup()
{
    var_0 = getent( "alley_vehicle_technical_backalley", "targetname" );
    var_0 thread maps\lagos_code::tff_cleanup_vehicle( "alley" );
}

transient_transitions()
{
    thread transient_transition_intro_to_middle();
    thread transient_transition_unload_middle();
    thread transient_transition_unload_lobby();
    thread transient_transition_load_alley();
    thread transient_transition_alley_to_outro();
}

transient_transition_alley_to_outro()
{
    common_scripts\utility::flag_wait( "flag_start_mag_climb_flank" );

    while ( !isdefined( level.exo_climb_rig ) )
        wait 0.05;

    level notify( "tff_pre_alley_to_outro" );
    unloadtransient( "lagos_alley_tr" );
    loadtransient( "lagos_outro_tr" );

    while ( !istransientloaded( "lagos_outro_tr" ) )
        wait 0.05;

    level notify( "tff_post_alley_to_outro" );
}

transient_transition_load_alley()
{
    common_scripts\utility::flag_wait( "flag_tff_transition_load_alley" );
    loadtransient( "lagos_alley_tr" );

    while ( !istransientloaded( "lagos_alley_tr" ) )
        wait 0.05;

    level notify( "tff_post_load_alley" );
}

transient_transition_intro_to_middle()
{
    if ( level.start_point == "roundabout" )
        return;

    common_scripts\utility::flag_wait( "flag_leaving_gov_building" );
    loadtransient( "lagos_roundabout_lobby_tr" );
    common_scripts\utility::flag_wait( "gov_player_exiting_area" );
    level notify( "tff_pre_intro_to_middle" );
    var_0 = getent( "anim_HM_post_breach_door", "targetname" );
    var_1 = getent( "gov_hostage_ext_door", "targetname" );
    var_0 thread maps\_anim::anim_first_frame_solo( var_1, "h_breach_exit_door_open" );
    unloadtransient( "lagos_intro_tr" );
    loadtransient( "lagos_middle_tr" );

    while ( !istransientloaded( "lagos_middle_tr" ) )
        wait 0.05;

    level notify( "tff_post_intro_to_middle" );
}

transient_transition_unload_lobby()
{
    common_scripts\utility::flag_wait( "tff_transition_unload_lobby" );
    level notify( "tff_pre_unload_lobby" );
    unloadtransient( "lagos_roundabout_lobby_tr" );
}

transient_transition_unload_middle()
{
    common_scripts\utility::flag_wait( "flag_tff_trans_unload_middle" );
    level notify( "tff_pre_unload_middle" );
    unloadtransient( "lagos_middle_tr" );
}

init_level_flags()
{
    common_scripts\utility::flag_init( "fly_drone_start" );
    common_scripts\utility::flag_init( "fly_drone_in_progess" );
    common_scripts\utility::flag_init( "fly_drone_done" );
    common_scripts\utility::flag_init( "intro_playerstart" );
    common_scripts\utility::flag_init( "gov_transition_door_close" );
    common_scripts\utility::flag_init( "government_courtyard_playerstart" );
    common_scripts\utility::flag_init( "pre_h_breach_playerstart" );
    common_scripts\utility::flag_init( "post_h_breach_playerstart" );
    common_scripts\utility::flag_init( "pm_released" );
    common_scripts\utility::flag_init( "gov_hostage_exit_door_open" );
    common_scripts\utility::flag_init( "road_block_patrol_go" );
    common_scripts\utility::flag_init( "roundabout_playerstart" );
    common_scripts\utility::flag_init( "alley1_playerstart" );
    common_scripts\utility::flag_init( "oncoming_playerstart" );
    common_scripts\utility::flag_init( "oncoming_downhill_playerstart" );
    common_scripts\utility::flag_init( "oncoming_hit" );
    common_scripts\utility::flag_init( "alley2_jumpers" );
    common_scripts\utility::flag_init( "alley2_playerstart" );
    common_scripts\utility::flag_init( "flank_playerstart" );
    common_scripts\utility::flag_init( "frogger_playerstart" );
    common_scripts\utility::flag_init( "rail_playerstart" );
    common_scripts\utility::flag_init( "shooting_rail_playerstart" );
    common_scripts\utility::flag_init( "takedown_playerstart" );
    common_scripts\utility::flag_init( "takedown_underwater" );
    common_scripts\utility::flag_init( "shore_pcap_playerstart" );
    common_scripts\utility::flag_init( "outro_playerstart" );
    common_scripts\utility::flag_init( "flag_alley1_clear" );
    common_scripts\utility::flag_init( "obj_rescue_PM" );
    common_scripts\utility::flag_init( "obj_rescue_PM_pos" );
    common_scripts\utility::flag_init( "obj_find_hostage_truck" );
    common_scripts\utility::flag_init( "obj_pursue_hostage_truck" );
    common_scripts\utility::flag_init( "obj_rescue_hostages" );
    common_scripts\utility::flag_init( "obj_progress_exo_door_goto" );
    common_scripts\utility::flag_init( "obj_progress_exo_door_clear" );
    common_scripts\utility::flag_init( "obj_progress_exo_climb_clear" );
    common_scripts\utility::flag_init( "obj_progress_tram_track" );
    common_scripts\utility::flag_init( "obj_progress_roof_breach_goto" );
    common_scripts\utility::flag_init( "obj_progress_roof_breach_clear" );
    common_scripts\utility::flag_init( "obj_progress_h_breach_goto" );
    common_scripts\utility::flag_init( "obj_progress_h_breach_clear" );
    common_scripts\utility::flag_init( "obj_progress_free_pm" );
    common_scripts\utility::flag_init( "obj_progress_free_pm_clear" );
    common_scripts\utility::flag_init( "obj_progress_find_hostage_truck_roundabout" );
    common_scripts\utility::flag_init( "obj_progress_find_hostage_truck_roundabout_complete" );
    common_scripts\utility::flag_init( "obj_pos_pursue_hostage_truck_oncoming1_wait" );
    common_scripts\utility::flag_init( "obj_pos_pursue_hostage_truck_oncoming1_set" );
    common_scripts\utility::flag_init( "obj_pos_find_hostage_truck_oncoming2" );
    common_scripts\utility::flag_init( "obj_progress_pursue_hostage_truck_flankalley" );
    common_scripts\utility::flag_init( "obj_progress_mag_climb_flank_complete" );
    common_scripts\utility::flag_init( "obj_pos_pursue_hostage_truck_oncoming2" );
    common_scripts\utility::flag_init( "obj_progress_pursue_hostage_truck_highway" );
    common_scripts\utility::flag_init( "obj_progress_pursue_hostage_truck_highway_traverse" );
    common_scripts\utility::flag_init( "obj_progress_pursue_hostage_truck_highway_swim" );
    common_scripts\utility::flag_init( "obj_progress_pursue_hostage_truck_highway_rescue" );
    common_scripts\utility::flag_init( "obj_complete_rescue_PM" );
    common_scripts\utility::flag_init( "obj_complete_pursue_hostage_truck" );
    common_scripts\utility::flag_init( "obj_complete_rescue_hostages" );
    common_scripts\utility::flag_init( "flag_hostage_scan_started" );
    common_scripts\utility::flag_init( "flag_player_input_for_drone_start" );
    common_scripts\utility::flag_init( "no_anim_squad_opening" );
    common_scripts\utility::flag_init( "roundabout_RPG_start" );
    common_scripts\utility::flag_init( "roundabout_wave_1A_complete" );
    common_scripts\utility::flag_init( "roundabout_wave_1B_complete" );
    common_scripts\utility::flag_init( "roundabout_wave_2A_complete" );
    common_scripts\utility::flag_init( "roundabout_wave_2B_complete" );
    common_scripts\utility::flag_init( "roundabout_wave_3A_complete" );
    common_scripts\utility::flag_init( "roundabout_wave_3B_complete" );
    common_scripts\utility::flag_init( "roundabout_wave_3_complete" );
    common_scripts\utility::flag_init( "roundabout_combat_starting_soon" );
    common_scripts\utility::flag_init( "flag_roundabout_tanker_explode" );
    common_scripts\utility::flag_init( "flag_Roundabout_Civilians_Flee" );
    common_scripts\utility::flag_init( "roundabout_burke_hood_anim_begin" );
    common_scripts\utility::flag_init( "frogger_squad_at_middle" );
    common_scripts\utility::flag_init( "frogger_squad_at_end" );
    common_scripts\utility::flag_init( "roundabout_wave_2_all_spawned" );
    common_scripts\utility::flag_init( "roundabout_wave_3_all_spawned" );
    common_scripts\utility::flag_init( "flank_vehicle_turret_dead" );
    common_scripts\utility::flag_init( "frogger_stop_lane_1" );
    common_scripts\utility::flag_init( "frogger_stop_lane_2" );
    common_scripts\utility::flag_init( "frogger_stop_lane_3" );
    common_scripts\utility::flag_init( "frogger_stop_lane_4" );
    common_scripts\utility::flag_init( "frogger_stop_lane_5" );
    common_scripts\utility::flag_init( "frogger_stop_lane_6" );
    common_scripts\utility::flag_init( "frogger_stop_lane_7" );
    common_scripts\utility::flag_init( "frogger_stop_lane_8" );
    common_scripts\utility::flag_init( "frogger_restart_lane_1" );
    common_scripts\utility::flag_init( "frogger_restart_lane_2" );
    common_scripts\utility::flag_init( "frogger_restart_lane_3" );
    common_scripts\utility::flag_init( "frogger_restart_lane_4" );
    common_scripts\utility::flag_init( "frogger_restart_lane_5" );
    common_scripts\utility::flag_init( "frogger_restart_lane_6" );
    common_scripts\utility::flag_init( "frogger_restart_lane_7" );
    common_scripts\utility::flag_init( "frogger_restart_lane_8" );
    common_scripts\utility::flag_init( "flag_roof_charge_planted" );
    common_scripts\utility::flag_init( "flag_h_breach_started" );
    common_scripts\utility::flag_init( "flag_Flank_Alley_react" );
    common_scripts\utility::flag_init( "flag_Flank_Alley_civilians_flee" );
    common_scripts\utility::flag_init( "trigger_start_frogger_kva_A" );
    common_scripts\utility::flag_init( "trigger_start_frogger_kva_C" );
    common_scripts\utility::flag_init( "flag_frogger_complete" );
    common_scripts\utility::flag_init( "begin_traffic_traverse" );
    common_scripts\utility::flag_init( "flag_start_traffic_traverse" );
    common_scripts\utility::flag_init( "flag_highway_ledge_jump_started" );
    common_scripts\utility::flag_init( "flag_highway_ledge_jump_fail" );
    common_scripts\utility::flag_init( "flag_highway_ledge_climb_started" );
    common_scripts\utility::flag_init( "flag_highway_VM_looking_forward" );
    common_scripts\utility::flag_init( "flag_highway_final_takedown_started" );
    common_scripts\utility::flag_init( "flag_begin_suv_takedown" );
    common_scripts\utility::flag_init( "alley2_complete" );
    common_scripts\utility::flag_init( "flag_roof_breach_mute_complete" );
    common_scripts\utility::flag_init( "flag_player_traversing_traffic" );
    common_scripts\utility::flag_init( "flank_alley_complete" );
    common_scripts\utility::flag_init( "flag_frogger_middle_dead" );
    common_scripts\utility::flag_init( "flag_middle_takedown_complete" );
    common_scripts\utility::flag_init( "flag_van_door_open" );
    common_scripts\utility::flag_init( "gov_transition_delete_intro" );
    common_scripts\utility::flag_init( "flag_delete_other_tanker_enemies" );
    common_scripts\utility::flag_init( "flag_exo_door_started" );
    common_scripts\utility::flag_init( "flag_roundabout_exo_shield" );
    common_scripts\utility::flag_init( "flag_exo_climb_started" );
    common_scripts\utility::flag_init( "flag_roundabout_magic_MWG" );
    common_scripts\utility::flag_init( "flag_frogger_middle_spawned" );
    common_scripts\utility::flag_init( "drone_fly_anim_done" );
    common_scripts\utility::flag_init( "flag_start_mag_climb" );
    common_scripts\utility::flag_init( "flag_irons_videolog_complete" );
    common_scripts\utility::flag_init( "flag_h_breach_complete" );
    common_scripts\utility::flag_init( "flag_traffic_helicopter_stop_left" );
    common_scripts\utility::flag_init( "flag_traffic_helicopter_stop_right" );
    common_scripts\utility::flag_init( "dialogue_playing" );
    common_scripts\utility::flag_init( "done_gov_building_h_breach_start" );
    common_scripts\utility::flag_init( "player_marking_targets" );
    common_scripts\utility::flag_init( "done_exo_door_kick" );
    common_scripts\utility::flag_init( "done_roof_breach_start" );
    common_scripts\utility::flag_init( "done_traffic_ledge_jump_start" );
    common_scripts\utility::flag_init( "flag_player_shot_enemy" );
    common_scripts\utility::flag_init( "flag_player_hold_on" );
    common_scripts\utility::flag_init( "flag_player_pry_open" );
    common_scripts\utility::flag_init( "flag_hostage_truck_is_failure" );
    common_scripts\utility::flag_init( "flag_hostage_truck_fire_input_window_started" );
    common_scripts\utility::flag_init( "flag_hostage_truck_fire_input_window_done" );
    common_scripts\utility::flag_init( "player_swimming_end" );
    common_scripts\utility::flag_init( "player_swimming_drown" );
    common_scripts\utility::flag_init( "pry_chk_trigger" );
    common_scripts\utility::flag_init( "flag_player_dodge" );
    common_scripts\utility::flag_init( "flag_player_jump" );
    common_scripts\utility::flag_init( "flag_player_jump2" );
    common_scripts\utility::flag_init( "flag_player_pull_windshield" );
    common_scripts\utility::flag_init( "flag_player_pull_kva" );
    common_scripts\utility::flag_init( "flag_truck_middle_takedown_is_failure" );
    common_scripts\utility::flag_init( "player_landed_roof_breach" );
}

handle_objectives()
{
    waittillframeend;
    set_completed_objective_flags();
    common_scripts\utility::flag_wait( "obj_rescue_PM" );
    objective_add( maps\_utility::obj( "rescue PM" ), "current", &"LAGOS_OBJECTIVE_RESCUE_PM" );
    common_scripts\utility::flag_wait( "obj_rescue_PM_pos" );
    var_0 = common_scripts\utility::getstruct( "obj_rescue_pm_1", "targetname" );
    objective_position( maps\_utility::obj( "rescue PM" ), var_0.origin );
    common_scripts\utility::flag_wait( "obj_progress_exo_door" );
    var_1 = getent( "exo_door_trigger", "targetname" );
    objective_position( maps\_utility::obj( "rescue PM" ), var_1.origin );
    common_scripts\utility::flag_wait( "flag_irons_videolog_complete" );
    common_scripts\utility::flag_wait( "exo_door_trigger" );
    objective_setpointertextoverride( maps\_utility::obj( "rescue PM" ), &"LAGOS_BREACH" );
    common_scripts\utility::flag_wait( "obj_progress_exo_door_clear" );
    maps\_utility::objective_clearadditionalpositions( maps\_utility::obj( "rescue PM" ) );
    objective_setpointertextoverride( maps\_utility::obj( "rescue PM" ), "" );
    common_scripts\utility::flag_wait( "obj_progress_tram_track" );
    var_2 = common_scripts\utility::getstruct( "obj_progress_tram_track", "targetname" );
    objective_position( maps\_utility::obj( "rescue PM" ), var_2.origin );
    common_scripts\utility::flag_wait( "obj_progress_exo_climb_goto" );
    var_3 = common_scripts\utility::getstruct( "obj_exo_climb", "targetname" );
    objective_position( maps\_utility::obj( "rescue PM" ), var_3.origin );
    common_scripts\utility::flag_wait( "flag_obj_exo_climb_text" );
    objective_setpointertextoverride( maps\_utility::obj( "rescue PM" ), &"LAGOS_CLIMB" );
    common_scripts\utility::flag_wait( "obj_progress_exo_climb_clear" );
    maps\_utility::objective_clearadditionalpositions( maps\_utility::obj( "rescue PM" ) );
    objective_setpointertextoverride( maps\_utility::obj( "rescue PM" ), "" );
    common_scripts\utility::flag_wait( "obj_progress_roof_breach_goto" );
    var_4 = getent( "gov_breach_trigger", "targetname" );
    objective_position( maps\_utility::obj( "rescue PM" ), var_4.origin );
    objective_setpointertextoverride( maps\_utility::obj( "rescue PM" ), &"LAGOS_PLANT" );
    common_scripts\utility::flag_wait( "obj_progress_roof_breach_clear" );
    maps\_utility::objective_clearadditionalpositions( maps\_utility::obj( "rescue PM" ) );
    objective_setpointertextoverride( maps\_utility::obj( "rescue PM" ), "" );
    common_scripts\utility::flag_wait( "obj_progress_h_breach_goto" );
    var_5 = getent( "gov_h_breach_trigger", "targetname" );
    objective_position( maps\_utility::obj( "rescue PM" ), var_5.origin );
    common_scripts\utility::flag_wait( "gov_h_breach_init" );
    objective_setpointertextoverride( maps\_utility::obj( "rescue PM" ), &"LAGOS_PLANT" );
    common_scripts\utility::flag_wait( "obj_progress_h_breach_clear" );
    maps\_utility::objective_clearadditionalpositions( maps\_utility::obj( "rescue PM" ) );
    objective_setpointertextoverride( maps\_utility::obj( "rescue PM" ), "" );
    common_scripts\utility::flag_wait( "obj_progress_free_pm" );
    var_6 = getent( "player_release_pm_trigger", "targetname" );
    objective_position( maps\_utility::obj( "rescue PM" ), var_6.origin );
    objective_setpointertextoverride( maps\_utility::obj( "rescue PM" ), &"LAGOS_RESCUE" );
    common_scripts\utility::flag_wait( "obj_progress_free_pm_clear" );
    maps\_utility::objective_clearadditionalpositions( maps\_utility::obj( "rescue PM" ) );
    objective_setpointertextoverride( maps\_utility::obj( "rescue PM" ), "" );
    common_scripts\utility::flag_wait( "obj_complete_rescue_PM" );
    maps\_utility::objective_complete( maps\_utility::obj( "rescue PM" ) );
    common_scripts\utility::flag_wait( "obj_find_hostage_truck" );
    objective_add( maps\_utility::obj( "pursue truck" ), "current", &"LAGOS_OBJECTIVE_STOP_TRUCK" );
    var_7 = common_scripts\utility::getstruct( "obj_pos_find_hostage_truck_stairwell", "targetname" );
    objective_position( maps\_utility::obj( "pursue truck" ), var_7.origin );
    common_scripts\utility::flag_wait( "obj_progress_find_hostage_truck_lobby" );
    var_8 = common_scripts\utility::getstruct( "obj_pos_find_hostage_truck_lobby", "targetname" );
    objective_position( maps\_utility::obj( "pursue truck" ), var_8.origin );
    common_scripts\utility::flag_wait( "obj_progress_find_hostage_truck_to_roundabout" );
    var_9 = getent( "obj_pos_find_hostage_truck_roundabout", "targetname" );
    objective_position( maps\_utility::obj( "pursue truck" ), var_9.origin );
    common_scripts\utility::flag_wait( "obj_progress_find_hostage_truck_roundabout" );
    maps\_utility::objective_clearadditionalpositions( maps\_utility::obj( "pursue truck" ) );
    common_scripts\utility::flag_wait( "obj_progress_find_hostage_truck_roundabout_complete" );
    var_9 = getent( "obj_pos_find_hostage_truck_alley1", "targetname" );
    objective_position( maps\_utility::obj( "pursue truck" ), var_9.origin );
    common_scripts\utility::flag_wait( "obj_pos_pursue_hostage_truck_alley2" );
    objective_position( maps\_utility::obj( "pursue truck" ), ( 0, 0, 0 ) );
    common_scripts\utility::flag_wait( "obj_pos_pursue_hostage_truck_oncoming1_wait" );
    var_9 = getent( "obj_pos_find_hostage_truck_alley2", "targetname" );
    objective_position( maps\_utility::obj( "pursue truck" ), var_9.origin );
    common_scripts\utility::flag_wait( "obj_pos_pursue_hostage_truck_oncoming1" );
    objective_position( maps\_utility::obj( "pursue truck" ), ( 0, 0, 0 ) );
    common_scripts\utility::flag_wait( "obj_pos_pursue_hostage_truck_oncoming1_set" );
    var_9 = getent( "obj_pos_find_hostage_truck_oncoming1", "targetname" );
    objective_position( maps\_utility::obj( "pursue truck" ), var_9.origin );
    common_scripts\utility::flag_wait( "obj_pos_pursue_hostage_truck_oncoming2" );
    var_9 = getent( "obj_pos_find_hostage_truck_oncoming2", "targetname" );
    objective_position( maps\_utility::obj( "pursue truck" ), var_9.origin );
    common_scripts\utility::flag_wait( "obj_pos_pursue_hostage_truck_alley3" );
    var_9 = getent( "obj_pos_find_hostage_truck_alley3", "targetname" );
    objective_position( maps\_utility::obj( "pursue truck" ), var_9.origin );
    common_scripts\utility::flag_wait( "obj_pos_pursue_hostage_truck_to_flankalley" );
    var_9 = getent( "obj_pos_pursue_hostage_truck_flankalley_kill_gunner", "targetname" );
    objective_position( maps\_utility::obj( "pursue truck" ), var_9.origin );
    common_scripts\utility::flag_wait( "flank_vehicle_turret_dead" );
    var_9 = getent( "obj_pos_pursue_hostage_truck_flankalley_wall_climb", "targetname" );
    objective_position( maps\_utility::obj( "pursue truck" ), var_9.origin );
    objective_setpointertextoverride( maps\_utility::obj( "pursue truck" ), &"LAGOS_CLIMB" );
    common_scripts\utility::flag_wait( "flag_start_mag_climb_flank" );
    objective_setpointertextoverride( maps\_utility::obj( "pursue truck" ), "" );
    objective_position( maps\_utility::obj( "pursue truck" ), ( 0, 0, 0 ) );
    common_scripts\utility::flag_wait( "obj_progress_mag_climb_flank_complete" );
    var_9 = getent( "obj_pos_pursue_hostage_truck_flankalley", "targetname" );
    objective_position( maps\_utility::obj( "pursue truck" ), var_9.origin );
    common_scripts\utility::flag_wait( "obj_progress_pursue_hostage_truck_flankalley" );
    var_9 = getent( "obj_pos_pursue_hostage_truck_highway", "targetname" );
    objective_position( maps\_utility::obj( "pursue truck" ), var_9.origin );
    common_scripts\utility::flag_wait( "obj_progress_pursue_hostage_truck_highway" );
    maps\_utility::objective_clearadditionalpositions( maps\_utility::obj( "pursue truck" ) );
    common_scripts\utility::flag_wait( "obj_progress_pursue_hostage_truck_highway_traverse" );
    objective_onentity( maps\_utility::obj( "pursue truck" ), level.burke );
    common_scripts\utility::flag_wait( "flag_begin_suv_takedown" );
    maps\_utility::objective_clearadditionalpositions( maps\_utility::obj( "pursue truck" ) );
    common_scripts\utility::flag_wait( "flag_middle_takedown_complete" );
    objective_onentity( maps\_utility::obj( "pursue truck" ), level.burke );
    common_scripts\utility::flag_wait( "flag_highway_final_takedown_started" );
    maps\_utility::objective_clearadditionalpositions( maps\_utility::obj( "pursue truck" ) );
    common_scripts\utility::flag_wait( "obj_progress_pursue_hostage_truck_highway_swim" );
    maps\_utility::objective_complete( maps\_utility::obj( "pursue truck" ) );
    objective_add( maps\_utility::obj( "rescue hostage" ), "current", &"LAGOS_OBJECTIVE_RESCUE_SCIENTIST" );

    if ( !isdefined( level.obj_tag ) )
        wait 0.2;

    if ( isdefined( level.obj_tag ) )
        objective_onentity( maps\_utility::obj( "rescue hostage" ), level.obj_tag );

    common_scripts\utility::flag_wait( "flag_van_door_open" );
    maps\_utility::objective_clearadditionalpositions( maps\_utility::obj( "rescue hostage" ) );
    common_scripts\utility::flag_wait( "obj_progress_pursue_hostage_truck_highway_rescue" );
    objective_onentity( maps\_utility::obj( "rescue hostage" ), level.burke );
    common_scripts\utility::flag_wait( "obj_complete_pursue_hostage_truck" );
    maps\_utility::objective_complete( maps\_utility::obj( "rescue hostage" ) );
}

set_completed_objective_flags()
{
    if ( maps\_utility::is_default_start() )
        return;

    var_0 = level.start_point;

    if ( var_0 == "intro_drone" )
        return;

    common_scripts\utility::flag_set( "obj_rescue_PM" );

    if ( var_0 == "intro_squad" )
        return;

    common_scripts\utility::flag_set( "obj_rescue_PM_pos" );
    common_scripts\utility::flag_set( "no_anim_squad_opening" );
    common_scripts\utility::flag_set( "exo_door_trigger" );
    common_scripts\utility::flag_set( "flag_irons_videolog_complete" );
    common_scripts\utility::flag_set( "obj_progress_exo_door" );
    common_scripts\utility::flag_set( "obj_progress_exo_door_clear" );
    common_scripts\utility::flag_set( "obj_progress_tram_track" );
    common_scripts\utility::flag_set( "obj_progress_exo_climb_goto" );

    if ( var_0 == "government_building" )
        return;

    common_scripts\utility::flag_set( "obj_progress_exo_climb_clear" );
    common_scripts\utility::flag_set( "obj_progress_roof_breach_goto" );
    common_scripts\utility::flag_set( "obj_progress_roof_breach_clear" );
    common_scripts\utility::flag_set( "obj_progress_h_breach_goto" );
    common_scripts\utility::flag_set( "flag_obj_exo_climb_text" );

    if ( var_0 == "pre_h_breach" )
        return;

    common_scripts\utility::flag_set( "obj_progress_h_breach_clear" );
    common_scripts\utility::flag_set( "gov_h_breach_init" );

    if ( var_0 == "post_h_breach" )
        return;

    common_scripts\utility::flag_set( "obj_progress_free_pm" );
    common_scripts\utility::flag_set( "obj_progress_free_pm_clear" );
    common_scripts\utility::flag_set( "obj_complete_rescue_PM" );
    common_scripts\utility::flag_set( "obj_find_hostage_truck" );
    common_scripts\utility::flag_set( "obj_progress_find_hostage_truck_lobby" );
    common_scripts\utility::flag_set( "obj_progress_find_hostage_truck_to_roundabout" );

    if ( var_0 == "roundabout" )
        return;

    common_scripts\utility::flag_set( "obj_progress_find_hostage_truck_roundabout" );
    common_scripts\utility::flag_set( "obj_progress_find_hostage_truck_roundabout_complete" );

    if ( var_0 == "alley_1" )
        return;

    common_scripts\utility::flag_set( "obj_pos_pursue_hostage_truck_alley2" );
    common_scripts\utility::flag_set( "obj_pos_pursue_hostage_truck_oncoming1_wait" );
    common_scripts\utility::flag_set( "obj_pos_pursue_hostage_truck_oncoming1" );

    if ( var_0 == "oncoming_alley" )
        return;

    common_scripts\utility::flag_set( "obj_pos_pursue_hostage_truck_oncoming1_set" );
    common_scripts\utility::flag_set( "obj_pos_pursue_hostage_truck_oncoming2" );
    common_scripts\utility::flag_set( "obj_pos_pursue_hostage_truck_alley3" );

    if ( var_0 == "alley_2" )
        return;

    common_scripts\utility::flag_set( "obj_pos_pursue_hostage_truck_to_flankalley" );

    if ( var_0 == "flank_alley" )
        return;

    common_scripts\utility::flag_set( "flank_vehicle_turret_dead" );
    common_scripts\utility::flag_set( "flag_start_mag_climb_flank" );
    common_scripts\utility::flag_set( "obj_progress_mag_climb_flank_complete" );
    common_scripts\utility::flag_set( "obj_progress_pursue_hostage_truck_flankalley" );

    if ( var_0 == "traffic_frogger" )
        return;

    if ( var_0 == "traffic_traverse" )
        return;

    common_scripts\utility::flag_set( "obj_progress_pursue_hostage_truck_highway" );
    common_scripts\utility::flag_set( "obj_progress_pursue_hostage_truck_highway_traverse" );

    if ( var_0 == "middle_takedown" )
        return;

    if ( var_0 == "post_middle_takedown" )
        return;

    common_scripts\utility::flag_set( "flag_begin_suv_takedown" );
    common_scripts\utility::flag_set( "flag_middle_takedown_complete" );
    common_scripts\utility::flag_set( "flag_highway_final_takedown_started" );

    if ( var_0 == "van_takedown" )
        return;

    common_scripts\utility::flag_set( "obj_progress_pursue_hostage_truck_highway_swim" );

    if ( var_0 == "van_takedown_underwater" )
        return;

    common_scripts\utility::flag_set( "obj_progress_pursue_hostage_truck_highway_rescue" );
    common_scripts\utility::flag_set( "obj_complete_pursue_hostage_truck" );

    if ( var_0 == "shore_pcap" )
        return;
}

setup_start_points()
{
    maps\_utility::add_start( "intro_drone", ::start_intro_drone, "" );
    maps\_utility::add_start( "intro_squad", ::start_intro_squad );
    maps\_utility::add_start( "government_building", ::start_government_courtyard );
    maps\_utility::add_start( "pre_h_breach", ::start_pre_h_breach );
    maps\_utility::add_start( "post_h_breach", ::start_post_h_breach );
    maps\_utility::add_start( "roundabout", ::start_roundabout );
    maps\_utility::add_start( "alley_1", ::start_alley1 );
    maps\_utility::add_start( "oncoming_alley", ::start_oncoming_downhill );
    maps\_utility::add_start( "alley_2", ::start_alley2 );
    maps\_utility::add_start( "flank_alley", ::start_flank );
    maps\_utility::add_start( "traffic_frogger", ::start_frogger );
    maps\_utility::add_start( "traffic_traverse", ::start_traverse );
    maps\_utility::add_start( "middle_takedown", ::start_middle_takedown );
    maps\_utility::add_start( "post_middle_takedown", ::start_post_middle_takedown );
    maps\_utility::add_start( "van_takedown", ::start_van_takedown );
    maps\_utility::add_start( "van_takedown_underwater", ::start_van_takedown_underwater );
    maps\_utility::add_start( "shore_pcap", ::start_shore_pcap );
    // maps\_utility::default_start( ::start_frogger );

    if ( level.currentgen )
    {
        var_0 = [ "lagos_intro_tr" ];
        maps\_utility::set_start_transients( "intro_drone", var_0 );
        maps\_utility::set_start_transients( "intro_squad", var_0 );
        maps\_utility::set_start_transients( "government_building", var_0 );
        maps\_utility::set_start_transients( "pre_h_breach", var_0 );
        maps\_utility::set_start_transients( "post_h_breach", var_0 );
        var_0[0] = "lagos_middle_tr";
        var_0[1] = "lagos_roundabout_lobby_tr";
        maps\_utility::set_start_transients( "roundabout", var_0 );
        var_0[1] = "lagos_alley_tr";
        maps\_utility::set_start_transients( "alley_1", var_0 );
        maps\_utility::set_start_transients( "oncoming_alley", var_0 );
        maps\_utility::set_start_transients( "alley_2", var_0 );
        var_0 = [ "lagos_alley_tr" ];
        maps\_utility::set_start_transients( "flank_alley", var_0 );
        var_0 = [ "lagos_outro_tr" ];
        maps\_utility::set_start_transients( "traffic_frogger", var_0 );
        maps\_utility::set_start_transients( "traffic_traverse", var_0 );
        maps\_utility::set_start_transients( "middle_takedown", var_0 );
        maps\_utility::set_start_transients( "post_middle_takedown", var_0 );
        maps\_utility::set_start_transients( "van_takedown", var_0 );
        maps\_utility::set_start_transients( "van_takedown_underwater", var_0 );
        maps\_utility::set_start_transients( "shore_pcap", var_0 );
    }
}

start_intro_drone()
{
    soundscripts\_snd::snd_message( "start_intro_drone" );
    maps\_shg_utility::move_player_to_start( "intro_playerstart" );
    common_scripts\utility::flag_set( "fly_drone_start" );
    thread maps\lagos_code::drone_intro();
    maps\_utility::battlechatter_off( "allies" );
    maps\_utility::battlechatter_off( "axis" );
}

start_intro_squad()
{
    soundscripts\_snd::snd_message( "start_intro_squad" );
    thread maps\_player_exo::player_exo_deactivate();
    maps\_shg_utility::move_player_to_start( "intro_playerstart" );
    common_scripts\utility::flag_set( "intro_playerstart" );
    common_scripts\utility::flag_set( "obj_rescue_PM" );
    thread maps\lagos_code::gov_hostage_h_breach_doors();
    maps\_utility::battlechatter_off( "allies" );
    maps\_utility::battlechatter_off( "axis" );
}

start_government_courtyard()
{
    soundscripts\_snd::snd_message( "start_government_building" );
    maps\_shg_utility::move_player_to_start( "government_building_playerstart" );
    common_scripts\utility::flag_set( "government_courtyard_playerstart" );
    maps\_utility::battlechatter_off( "allies" );
    maps\_utility::battlechatter_off( "axis" );
    thread maps\lagos_code::vig_vehicle_removal();
    thread maps\lagos_code::gov_hostage_h_breach_doors();
    thread maps\lagos_code::gov_building_mil_devstart_setup();
    thread maps\lagos_code::gov_building_firefight_driveup();
    thread maps\lagos_code::gov_roof_breach_anim_chunks();
    waitframe();
    level notify( "remove_civs" );
    level notify( "gov_driveup_go" );
    thread maps\lagos_code::gov_building_firefight_setup();
    wait 0.5;
    level notify( "gov_driveup_started" );
}

start_pre_h_breach()
{
    soundscripts\_snd::snd_message( "start_pre_h_breach" );
    maps\_shg_utility::move_player_to_start( "h_breach_playerstart" );
    common_scripts\utility::flag_set( "pre_h_breach_playerstart" );
    common_scripts\utility::flag_clear( "gov_h_breach_init" );
    thread maps\lagos_code::vig_vehicle_removal();
    level notify( "remove_civs" );
    thread maps\lagos_code::gov_rear_setup();
    thread maps\lagos_code::gov_hostage_h_breach_doors();
    thread maps\lagos_code::gov_hostage_breach_setup();
    maps\_utility::battlechatter_off( "allies" );
    maps\_utility::battlechatter_off( "axis" );
    thread maps\lagos_vo::harmonic_breach_prep_dialogue();
    wait 3;
    level notify( "h_breach_prep" );
    common_scripts\utility::flag_wait( "flag_h_breach_started" );
    common_scripts\utility::flag_set( "begin_harmonic_breach_lighting" );
    common_scripts\utility::flag_set( "obj_progress_h_breach_clear" );
    level notify( "h_breach_anim_init" );
    common_scripts\utility::flag_set( "done_gov_building_h_breach_start" );
    thread maps\lagos_vo::harmonic_breach_start_dialogue();
    wait 2;
    level.anim_org_ajani_post_breach = getent( "anim_HM_post_breach", "targetname" );
    level.anim_org_ajani_post_breach maps\_anim::anim_loop_solo( level.ajani, "h_breach_pre_idle", "end_pre_idle" );
}

start_post_h_breach()
{
    soundscripts\_snd::snd_message( "start_post_h_breach" );
    maps\_shg_utility::move_player_to_start( "h_breach_playerstart" );
    common_scripts\utility::flag_set( "post_h_breach_playerstart" );
    thread maps\lagos_code::vig_vehicle_removal();
    level notify( "remove_civs" );
    maps\_utility::battlechatter_off( "allies" );
    maps\_utility::battlechatter_off( "axis" );
    thread maps\lagos_code::gov_rear_setup();
    thread maps\lagos_code::gov_hostage_h_breach_doors();
    thread maps\lagos_code::gov_hostage_breach_post_anim_setup();
    waitframe();
    level notify( "BreachComplete" );
}

start_roundabout()
{
    soundscripts\_snd::snd_message( "start_roundabout" );
    maps\_shg_utility::move_player_to_start( "roundabout_playerstart" );
    common_scripts\utility::flag_set( "roundabout_playerstart" );
    thread maps\lagos_code::vig_vehicle_removal();
    level notify( "remove_civs" );
    maps\_utility::battlechatter_off( "allies" );
    maps\_utility::battlechatter_off( "axis" );
    common_scripts\utility::flag_wait( "roundabout_squad_teleport" );
    level.player freezecontrols( 1 );
    thread maps\_introscreen::introscreen_generic_black_fade_in( 2, 1 );
    var_0 = getnode( "roundabout_start_burke", "targetname" );
    var_1 = getnode( "roundabout_start_joker", "targetname" );
    var_2 = getnode( "roundabout_start_ajani", "targetname" );
    level.burke maps\_utility::teleport_ai( var_0 );
    level.joker maps\_utility::teleport_ai( var_1 );
    level.ajani maps\_utility::teleport_ai( var_2 );
    wait 2;
    level.player freezecontrols( 0 );
}

start_alley1()
{
    soundscripts\_snd::snd_message( "start_alley1" );
    maps\_shg_utility::move_player_to_start( "alley1_playerstart" );
    common_scripts\utility::flag_set( "alley1_playerstart" );
    thread maps\lagos_code::vig_vehicle_removal();
    level notify( "remove_civs" );
}

start_oncoming_downhill()
{
    soundscripts\_snd::snd_message( "start_oncoming_downhill" );
    maps\_shg_utility::move_player_to_start( "oncoming_downhill_playerstart" );
    common_scripts\utility::flag_set( "oncoming_downhill_playerstart" );
    thread maps\lagos_code::vig_vehicle_removal();
    level notify( "remove_civs" );
    level notify( "alley_oncoming_ally_goto" );
}

start_alley2()
{
    soundscripts\_snd::snd_message( "start_alley2" );
    maps\_shg_utility::move_player_to_start( "alley2_playerstart" );
    common_scripts\utility::flag_set( "alley2_playerstart" );
    thread maps\lagos_code::vig_vehicle_removal();
    level notify( "remove_civs" );
}

start_flank()
{
    soundscripts\_snd::snd_message( "start_flank" );
    maps\_shg_utility::move_player_to_start( "flank_playerstart" );
    common_scripts\utility::flag_set( "flank_playerstart" );
    thread maps\lagos_code::vig_vehicle_removal();
    level notify( "remove_civs" );
    level.player freezecontrols( 1 );
    thread maps\_introscreen::introscreen_generic_black_fade_in( 2, 1 );
    var_0 = getnode( "flank_start_burke", "targetname" );
    var_1 = getnode( "flank_start_joker", "targetname" );
    var_2 = getnode( "flank_start_ajani", "targetname" );
    level.burke maps\_utility::teleport_ai( var_0 );
    level.joker maps\_utility::teleport_ai( var_1 );
    level.ajani maps\_utility::teleport_ai( var_2 );
    level.burke maps\_utility::enable_ai_color();
    level.joker maps\_utility::enable_ai_color();
    level.ajani maps\_utility::enable_ai_color();
    wait 2;
    level.player freezecontrols( 0 );
}

start_frogger()
{
    soundscripts\_snd::snd_message( "start_traffic_frogger" );
    maps\_shg_utility::move_player_to_start( "frogger_playerstart" );
    common_scripts\utility::flag_set( "frogger_playerstart" );
    thread maps\lagos_code::vig_vehicle_removal();
    level notify( "remove_civs" );
    level.player freezecontrols( 1 );
    thread maps\_introscreen::introscreen_generic_black_fade_in( 2, 1 );
    maps\_exo_climb::disable_mount_point( "climb_mount_flank_alley" );
    var_0 = getnode( "frogger_start_burke", "targetname" );
    var_1 = getnode( "frogger_start_joker", "targetname" );
    var_2 = getnode( "frogger_start_ajani", "targetname" );
    level.burke maps\_utility::teleport_ai( var_0 );
    level.joker maps\_utility::teleport_ai( var_1 );
    level.ajani maps\_utility::teleport_ai( var_2 );
    level.burke maps\_utility::enable_ai_color();
    level.joker maps\_utility::enable_ai_color();
    level.ajani maps\_utility::enable_ai_color();
    wait 2;
    level.player freezecontrols( 0 );
    thread maps\lagos_vo::highway_frogger_dialogue();
}

start_traverse()
{
    soundscripts\_snd::snd_message( "start_traffic_traverse" );
    maps\_shg_utility::move_player_to_start( "rail_playerstart" );
    common_scripts\utility::flag_set( "rail_playerstart" );
    thread maps\lagos_code::vig_vehicle_removal();
    level notify( "remove_civs" );
    maps\_utility::battlechatter_off( "axis" );
    maps\_utility::battlechatter_off( "allies" );
    level.player freezecontrols( 1 );
    thread maps\_introscreen::introscreen_generic_black_fade_in( 2, 1 );
    maps\_exo_climb::disable_mount_point( "climb_mount_flank_alley" );
    var_0 = getnode( "traverse_start_burke", "targetname" );
    level.burke maps\_utility::teleport_ai( var_0 );
    level.burke maps\_utility::enable_ai_color();
    wait 2;
    level.player freezecontrols( 0 );
    common_scripts\utility::flag_set( "begin_traffic_traverse" );
    maps\lagos_code::traffic_traverse_start();
}

start_middle_takedown()
{
    soundscripts\_snd::snd_message( "start_middle_takedown" );
    level.debugstart_middle_takedown = 1;
    level.burke_middle_takedown = 1;
    maps\_exo_climb::disable_mount_point( "climb_mount_flank_alley" );
    maps\_shg_utility::move_player_to_start( "rail_playerstart" );
    common_scripts\utility::flag_set( "alley2_playerstart" );
    thread maps\lagos_code::vig_vehicle_removal();
    level notify( "remove_civs" );
    maps\_utility::battlechatter_off( "axis" );
    maps\_utility::battlechatter_off( "allies" );
    common_scripts\utility::flag_wait( "flag_setup_highway_vehicles" );
    common_scripts\utility::flag_set( "flag_begin_suv_takedown" );
}

start_post_middle_takedown()
{
    soundscripts\_snd::snd_message( "start_post_middle_takedown" );
    level.debugstart_post_middle_takedown = 1;
    maps\_exo_climb::disable_mount_point( "climb_mount_flank_alley" );
    maps\_utility::battlechatter_off( "axis" );
    maps\_utility::battlechatter_off( "allies" );
    start_middle_takedown();
    common_scripts\utility::flag_set( "flag_post_suv_takedown_lighting" );
}

start_shooting_rail()
{
    soundscripts\_snd::snd_message( "start_shooting_rail" );
    maps\_exo_climb::disable_mount_point( "climb_mount_flank_alley" );
    maps\_utility::battlechatter_off( "axis" );
    maps\_utility::battlechatter_off( "allies" );
    maps\_shg_utility::move_player_to_start( "shooting_rail_playerstart" );
    common_scripts\utility::flag_set( "shooting_rail_playerstart" );
    thread maps\lagos_code::vig_vehicle_removal();
    level notify( "remove_civs" );
}

start_van_takedown()
{
    soundscripts\_snd::snd_message( "start_van_takedown" );
    maps\_exo_climb::disable_mount_point( "climb_mount_flank_alley" );
    maps\_utility::battlechatter_off( "axis" );
    maps\_utility::battlechatter_off( "allies" );
    maps\_shg_utility::move_player_to_start( "takedown_playerstart" );
    common_scripts\utility::flag_set( "flag_bus_traverse_5_start_takedown" );
    common_scripts\utility::flag_set( "takedown_playerstart" );
    common_scripts\utility::flag_set( "takedown_playerstart_lighting" );
    thread maps\lagos_code::vig_vehicle_removal();
    level notify( "remove_civs" );
}

start_van_takedown_underwater()
{
    soundscripts\_snd::snd_message( "start_van_takedown_underwater" );
    maps\_exo_climb::disable_mount_point( "climb_mount_flank_alley" );
    maps\_utility::battlechatter_off( "axis" );
    maps\_utility::battlechatter_off( "allies" );
    common_scripts\utility::flag_set( "flag_bus_traverse_5_start_takedown" );
    common_scripts\utility::flag_set( "takedown_underwater" );
    common_scripts\utility::flag_set( "takedown_underwater_lighting" );
    common_scripts\utility::flag_set( "flag_takedown_kva_van_approach" );
    common_scripts\utility::flag_set( "takedown_playerstart" );
    soundscripts\_snd::snd_message( "van_takedown" );
    thread maps\lagos_code::vig_vehicle_removal();
    level notify( "remove_civs" );
}

start_shore_pcap()
{
    soundscripts\_snd::snd_message( "start_shore_pcap" );
    maps\_exo_climb::disable_mount_point( "climb_mount_flank_alley" );
    maps\_utility::battlechatter_off( "axis" );
    maps\_utility::battlechatter_off( "allies" );
    maps\_shg_utility::move_player_to_start( "shore_pcap_playerstart" );
    common_scripts\utility::flag_set( "shore_pcap_playerstart" );
    level.player freezecontrols( 1 );
    thread maps\_introscreen::introscreen_generic_black_fade_in( 1.5, 0.5 );
    thread maps\lagos_code::shore_pcap( 1.5 );
}
