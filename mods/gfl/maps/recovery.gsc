// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    maps\_utility::template_level( "recovery" );
    init_level_flags();
    setup_start_points();
    maps\createart\recovery_art::main();
    maps\recovery_anim::main();
    maps\recovery_fx::main();
    maps\recovery_precache::main();
    maps\recovery_lighting::hide_reveal_screen_reflections();

    if ( level.currentgen )
        maps\_utility::tff_sync_setup();

    maps\_load::main();
    thread maps\_player_exo::main( "specialist", 1, 0 );
    thread manage_player_exo();
    maps\recovery_lighting::main();
    maps\recovery_aud::main();
    maps\recovery_vo::prepare_dialogue();
    maps\_stealth::main();
    maps\_patrol_extended::main();
    maps\_stealth_debug::main();
    maps\_weapon_pdrone::initialize();
    maps\_tagging::main();
    level.player maps\_tagging::tagging_set_enabled( 0 );

    if ( level.nextgen )
        setsaveddvar( "r_adaptiveSubdiv", "0" );

    level.player maps\_stealth_utility::stealth_plugin_basic();
    set_completed_flags();
    thread objective_init();
    setup_precache();
    thread maps\recovery_code::setup_gameplay();
    thread maps\recovery_exo_punch_door::exo_door_init();
    setup_button_notifies();
    level.player.showhint = 1;
    maps\_utility::add_control_based_hint_strings( "repair_prompt", &"RECOVERY_PROMPT_ARM_REPAIR", ::stop_hint, &"RECOVERY_PROMPT_ARM_REPAIR_PC", &"RECOVERY_PROMPT_ARM_REPAIR_SP" );
    maps\_utility::add_hint_string( "threat_prompt", &"RECOVERY_PROMPT_TUTORIAL_THREAT", ::stop_hint );
    maps\_utility::add_hint_string( "pc_threat_prompt", &"RECOVERY_PROMPT_TUTORIAL_PC_THREAT", ::stop_hint );
    maps\_utility::add_hint_string( "emp_prompt", &"RECOVERY_PROMPT_TUTORIAL_EMP", ::stop_hint );
    maps\_utility::add_hint_string( "pc_emp_prompt", &"RECOVERY_PROMPT_TUTORIAL_PC_EMP", ::stop_hint );
    maps\_utility::add_hint_string( "smart_prompt", &"RECOVERY_PROMPT_TUTORIAL_SMART", ::stop_hint );
    maps\_utility::add_hint_string( "pc_smart_prompt", &"RECOVERY_PROMPT_TUTORIAL_PC_SMART", ::stop_hint );
    maps\_utility::add_hint_string( "drone_deploy_prompt", &"RECOVERY_PROMPT_DEPLOY_DRONE", ::stop_hint );
    maps\_utility::add_hint_string( "drone_deploy_fail_prompt", &"PDRONE_PLAYER_PROMPT_DEPLOY_DRONE_FAIL", ::stop_hint );
    maps\_utility::add_hint_string( "threat_breach_prompt", &"RECOVERY_PROMPT_THREAT_BREACH", ::stop_hint );
    maps\_utility::add_hint_string( "prone_prompt", &"RECOVERY_PROMPT_PRONE", ::stop_hint );
    maps\_utility::add_hint_string( "pc_prone_prompt", &"RECOVERY_PROMPT_PC_PRONE", ::stop_hint );
    maps\_utility::add_hint_string( "warning_prompt", &"RECOVERY_OUT_OF_BOUNDS_WARNING", ::stop_hint_mission_fail );
    maps\_utility::add_hint_string( "jeep_warning_prompt", &"RECOVERY_OUT_OF_BOUNDS_WARNING", ::stop_hint );
    maps\_utility::add_hint_string( "overdrive_prompt", &"RECOVERY_PROMPT_OVERDRIVE", ::stop_hint );
    maps\_utility::add_hint_string( "overdrive_prompt_sim", &"RECOVERY_PROMPT_OVERDRIVE", ::over_drive_is_active );
    maps\_utility::add_hint_string( "shield_prompt_sim", &"RECOVERY_PROMPT_SHIELD", ::exo_shield_is_active );
    maps\_utility::add_hint_string( "stim_prompt", &"RECOVERY_PROMPT_STIM", ::stop_hint );
    setup_portal_scripting();

    if ( level.currentgen )
        thread tff_setups();
}

setup_button_notifies()
{
    level.player notifyonplayercommand( "dpad_down", "+actionslot 2" );
    level.player notifyonplayercommand( "dpad_left", "+actionslot 3" );
    level.player notifyonplayercommand( "dpad_right", "+actionslot 4" );
    level.player notifyonplayercommand( "dpad_up", "+actionslot 1" );
    level.player notifyonplayercommand( "a_pressed", "+gostand" );
    level.player notifyonplayercommand( "b_pressed", "+stance" );
    level.player notifyonplayercommand( "y_pressed", "weapnext" );
    level.player notifyonplayercommand( "x_pressed", "+usereload" );
    level.player notifyonplayercommand( "attack_pressed", "+attack" );
    level.player notifyonplayercommand( "ads_pressed", "+speed_throw" );
}

stop_hint()
{
    return level.player.showhint == 0;
}

stop_hint_mission_fail()
{
    return !common_scripts\utility::flag( "training_out_of_bounds_warning" );
}

over_drive_is_active()
{
    return level.player maps\_player_exo::overdrive_is_on() == 1;
}

exo_shield_is_active()
{
    return level.player maps\_player_exo::exo_shield_is_on() == 1;
}

init_level_flags()
{
    common_scripts\utility::flag_init( "onBase" );
    common_scripts\utility::flag_init( "flag_mountains_visible" );
    common_scripts\utility::flag_init( "threat_grenade_hint_text_off" );
    common_scripts\utility::flag_init( "flag_gideon_use_custom_anim_set" );
    common_scripts\utility::flag_init( "gideon_early_exit_grenade_range" );
    common_scripts\utility::flag_init( "gideon_early_exit_holo_range" );
    common_scripts\utility::flag_init( "flag_obj_funeral_casket_start" );
    common_scripts\utility::flag_init( "flag_obj_funeral_casket_complete" );
    common_scripts\utility::flag_init( "flag_obj_funeral_irons_start" );
    common_scripts\utility::flag_init( "flag_obj_funeral_irons_complete" );
    common_scripts\utility::flag_init( "tour_ride_gideon_pcap" );
    common_scripts\utility::flag_init( "flag_obj_follow_gideon" );
    common_scripts\utility::flag_init( "flag_obj_base_start" );
    common_scripts\utility::flag_init( "flag_shield_turret_shooting" );
    common_scripts\utility::flag_init( "flag_obj_arm_repair_pre" );
    common_scripts\utility::flag_init( "flag_obj_arm_repair_start" );
    common_scripts\utility::flag_init( "flag_obj_arm_repair_complete" );
    common_scripts\utility::flag_init( "arm_repair_attempt_1" );
    common_scripts\utility::flag_init( "arm_repair_attempt_2" );
    common_scripts\utility::flag_init( "arm_repair_attempt_3" );
    common_scripts\utility::flag_init( "flag_obj_arm_repair_desk_enabled" );
    common_scripts\utility::flag_init( "desk_exit" );
    common_scripts\utility::flag_init( "tour_end" );
    common_scripts\utility::flag_init( "flag_obj_equip_firing_range" );
    common_scripts\utility::flag_init( "flag_obj_gun_range_active" );
    common_scripts\utility::flag_init( "flag_shooting_range_playable" );
    common_scripts\utility::flag_init( "shooting_range_started_once" );
    common_scripts\utility::flag_init( "shooting_range_completed_once" );
    common_scripts\utility::flag_init( "flag_lock_shooting_range_ok" );
    common_scripts\utility::flag_init( "flag_obj_gun_range_start" );
    common_scripts\utility::flag_init( "flag_obj_gun_range_complete" );
    common_scripts\utility::flag_init( "grenade_range_started_once" );
    common_scripts\utility::flag_init( "grenade_range_completed_once" );
    common_scripts\utility::flag_init( "gideon_range_exit_ok" );
    common_scripts\utility::flag_init( "ilona_range_turn_ok" );
    common_scripts\utility::flag_init( "training_room_elevator_completed" );
    common_scripts\utility::flag_init( "flag_obj_grenade_range_pre_1" );
    common_scripts\utility::flag_init( "flag_obj_grenade_range_pre_2" );
    common_scripts\utility::flag_init( "flag_obj_grenade_range_tutorial_start" );
    common_scripts\utility::flag_init( "flag_obj_grenade_tutorial_threat_start" );
    common_scripts\utility::flag_init( "flag_obj_grenade_tutorial_threat_complete" );
    common_scripts\utility::flag_init( "flag_obj_grenade_range_tutorial_complete" );
    common_scripts\utility::flag_init( "flag_obj_grenade_range_minigame_start" );
    common_scripts\utility::flag_init( "flag_obj_grenade_range_minigame_complete" );
    common_scripts\utility::flag_init( "flag_obj_elevators_exit_complete" );
    common_scripts\utility::flag_init( "flag_obj_rescue1_start" );
    common_scripts\utility::flag_init( "flag_obj_rescue1_start_clear" );
    common_scripts\utility::flag_init( "flag_obj_rescue1_enter" );
    common_scripts\utility::flag_init( "flag_obj_rescue1_enter_clear" );
    common_scripts\utility::flag_init( "flag_obj_rescue1_flash" );
    common_scripts\utility::flag_init( "flag_obj_rescue1_flash_clear" );
    common_scripts\utility::flag_init( "flag_obj_rescue1_breach" );
    common_scripts\utility::flag_init( "flag_obj_rescue1_breach_clear" );
    common_scripts\utility::flag_init( "flag_obj_rescue1_drone_attack" );
    common_scripts\utility::flag_init( "flag_obj_rescue1_drone_attack_clear" );
    common_scripts\utility::flag_init( "threat_breach_kickoff_gunfire" );
    common_scripts\utility::flag_init( "flag_obj_rescue1_patio_ambush" );
    common_scripts\utility::flag_init( "flag_obj_rescue1_patio_ambush_clear" );
    common_scripts\utility::flag_init( "flag_obj_rescue1_golf_course" );
    common_scripts\utility::flag_init( "flag_obj_rescue1_golf_course_clear" );
    common_scripts\utility::flag_init( "flag_obj_rescue1_golf_course2" );
    common_scripts\utility::flag_init( "flag_obj_rescue1_golf_course2_clear" );
    common_scripts\utility::flag_init( "flag_obj_rescue1_escape_location" );
    common_scripts\utility::flag_init( "flag_obj_rescue1_escape_location_clear" );
    common_scripts\utility::flag_init( "flag_obj_rescue1_escape_vehicle" );
    common_scripts\utility::flag_init( "flag_obj_rescue1_escape_vehicle_clear" );
    common_scripts\utility::flag_init( "flag_obj_rescue1_allow_end_enter_jeep" );
    common_scripts\utility::flag_init( "flag_obj_rescue1_allow_end_enter_jeep_clear" );
    common_scripts\utility::flag_init( "flag_obj_rescue1_complete" );
    common_scripts\utility::flag_init( "flag_obj_rescue2_start" );
    common_scripts\utility::flag_init( "flag_obj_rescue2_entrance" );
    common_scripts\utility::flag_init( "flag_obj_rescue2_entrance_clear" );
    common_scripts\utility::flag_init( "flag_obj_rescue2_living_room" );
    common_scripts\utility::flag_init( "flag_obj_rescue2_living_room_clear" );
    common_scripts\utility::flag_init( "flag_obj_rescue2_breach" );
    common_scripts\utility::flag_init( "flag_obj_rescue2_breach_clear" );
    common_scripts\utility::flag_init( "flag_obj_rescue2_drone_living_room" );
    common_scripts\utility::flag_init( "flag_obj_rescue2_drone_living_room_clear" );
    common_scripts\utility::flag_init( "flag_obj_rescue2_patio_drone_ambush" );
    common_scripts\utility::flag_init( "flag_obj_rescue2_patio_drone_ambush_clear" );
    common_scripts\utility::flag_init( "flag_obj_rescue2_golf_course" );
    common_scripts\utility::flag_init( "flag_obj_rescue2_golf_course_clear" );
    common_scripts\utility::flag_init( "flag_obj_rescue2_golf_course2" );
    common_scripts\utility::flag_init( "flag_obj_rescue2_golf_course2_clear" );
    common_scripts\utility::flag_init( "flag_obj_rescue2_escape_location" );
    common_scripts\utility::flag_init( "flag_obj_rescue2_escape_location_clear" );
    common_scripts\utility::flag_init( "flag_obj_rescue2_escape_vehicle" );
    common_scripts\utility::flag_init( "flag_obj_rescue2_escape_vehicle_clear" );
    common_scripts\utility::flag_init( "flag_obj_rescue2_complete" );
    common_scripts\utility::flag_init( "flag_obj_rescue2_complete_clear" );
    common_scripts\utility::flag_init( "eulogy_complete" );
    common_scripts\utility::flag_init( "interact_casket" );
    common_scripts\utility::flag_init( "player_proximity_irons" );
    common_scripts\utility::flag_init( "card_obtained" );
    common_scripts\utility::flag_init( "funeral_complete" );
    common_scripts\utility::flag_init( "deck_reinforcement_1" );
    common_scripts\utility::flag_init( "training_s1_flag_entrance" );
    common_scripts\utility::flag_init( "training_s1_spawn_starting_enemies" );
    common_scripts\utility::flag_init( "training_s1_start_alerted" );
    common_scripts\utility::flag_init( "training_s1_enemies_start_charge" );
    common_scripts\utility::flag_init( "training_s1_clear_initial_spawn" );
    common_scripts\utility::flag_init( "training_s1_snipers_attack" );
    common_scripts\utility::flag_init( "training_s1_run_to_door" );
    common_scripts\utility::flag_init( "training_s1_living_room_approach" );
    common_scripts\utility::flag_init( "training_s1_peak_flash_door" );
    common_scripts\utility::flag_init( "training_s1_open_flash_door" );
    common_scripts\utility::flag_init( "training_s1_flag_flash" );
    common_scripts\utility::flag_init( "training_s1_enable_living_room" );
    common_scripts\utility::flag_init( "training_s1_enter_vo_complete" );
    common_scripts\utility::flag_init( "training_s1_start_alerted_enemies_dead" );
    common_scripts\utility::flag_init( "training_s1_flag_thermal" );
    common_scripts\utility::flag_init( "training_s1_peak_thermal_door" );
    common_scripts\utility::flag_init( "training_s1_open_thermal_door" );
    common_scripts\utility::flag_init( "training_flash_complete" );
    common_scripts\utility::flag_init( "training_s1_prepare_breach_room" );
    common_scripts\utility::flag_init( "training_s1_mute_breach_setup" );
    common_scripts\utility::flag_init( "training_s1_spawn_breach_door" );
    common_scripts\utility::flag_init( "door_breach_s1" );
    common_scripts\utility::flag_init( "training_s1_breach_begin" );
    common_scripts\utility::flag_init( "training_s1_spawn_breach_door" );
    common_scripts\utility::flag_init( "training_s1_flag_screen_smash" );
    common_scripts\utility::flag_init( "training_s1_spawn_breach_enemies" );
    common_scripts\utility::flag_init( "training_s1_flag_bathroom_guy_shot" );
    common_scripts\utility::flag_init( "training_s1_flag_president_shot" );
    common_scripts\utility::flag_init( "training_s1_flag_president_dead" );
    common_scripts\utility::flag_init( "training_s1_breach_enemy_dead" );
    common_scripts\utility::flag_init( "training_s1_bathroom_enemy_dead" );
    common_scripts\utility::flag_init( "training_s1_release_president" );
    common_scripts\utility::flag_init( "training_s1_exo_breach_clear" );
    common_scripts\utility::flag_init( "training_s1_president_free" );
    common_scripts\utility::flag_init( "training_s1_breach_done" );
    common_scripts\utility::flag_init( "training_s1_living_room_return" );
    common_scripts\utility::flag_init( "training_s1_search_drones_attack" );
    common_scripts\utility::flag_init( "training_s1_joker_search_drones_cover" );
    common_scripts\utility::flag_init( "training_s1_patio_doors_joker_in" );
    common_scripts\utility::flag_init( "training_s1_breach_patio_doors_open" );
    common_scripts\utility::flag_init( "training_s1_slow_patio_doors_open" );
    common_scripts\utility::flag_init( "training_s1_spawn_drones_reinforcements" );
    common_scripts\utility::flag_init( "training_s1_search_drones_done" );
    common_scripts\utility::flag_init( "training_s1_clear_flash_spawn" );
    common_scripts\utility::flag_init( "training_s1_close_living_room_door" );
    common_scripts\utility::flag_init( "training_s1_living_room_return" );
    common_scripts\utility::flag_init( "training_s1_living_room_ambush_scene" );
    common_scripts\utility::flag_init( "training_s1_ambush_cleanup" );
    common_scripts\utility::flag_init( "training_s1_spawn_patio_enemies" );
    common_scripts\utility::flag_init( "training_s1_spawn_patio_enemies_wave2" );
    common_scripts\utility::flag_init( "training_s1_spawn_patio_enemies_wave3" );
    common_scripts\utility::flag_init( "training_s1_spawn_patio_wave1_dead" );
    common_scripts\utility::flag_init( "training_s1_spawn_patio_wave2" );
    common_scripts\utility::flag_init( "training_s1_spawn_patio_wave3" );
    common_scripts\utility::flag_init( "training_s1_patio_alerted" );
    common_scripts\utility::flag_init( "training_s1_clear_patio1" );
    common_scripts\utility::flag_init( "training_s1_clear_patio2" );
    common_scripts\utility::flag_init( "training_s1_clear_patio3" );
    common_scripts\utility::flag_init( "training_s1_patio_clear" );
    common_scripts\utility::flag_init( "training_s1_hide" );
    common_scripts\utility::flag_init( "training_s1_allow_path_to_level_end" );
    common_scripts\utility::flag_init( "training_s1_start_patrol" );
    common_scripts\utility::flag_init( "training_s1_hide_from_patrols_done" );
    common_scripts\utility::flag_init( "training_s1_spotted" );
    common_scripts\utility::flag_init( "training_s1_vehicle_ready" );
    common_scripts\utility::flag_init( "training_s1_allow_escape" );
    common_scripts\utility::flag_init( "training_s1_escape_vehicle_ready" );
    common_scripts\utility::flag_init( "training_s1_end_anim_started" );
    common_scripts\utility::flag_init( "training_s1_end_setup_gideon" );
    common_scripts\utility::flag_init( "training_s1_end_setup_president" );
    common_scripts\utility::flag_init( "training_s1_end_setup_driver" );
    common_scripts\utility::flag_init( "training_s1_end_setup_cart" );
    common_scripts\utility::flag_init( "training_s1_end_setup_irons" );
    common_scripts\utility::flag_init( "training_s1_start_escape_vehicle" );
    common_scripts\utility::flag_init( "training_s1_ambush" );
    common_scripts\utility::flag_init( "training_s1_end_cease_fire" );
    common_scripts\utility::flag_init( "training_remove_player_weapons" );
    common_scripts\utility::flag_init( "training_s1_end" );
    common_scripts\utility::flag_init( "training_s1_flag_vfx_rain_stops" );
    common_scripts\utility::flag_init( "training_s1_flag_lights_on" );
    common_scripts\utility::flag_init( "training_s1_flag_wall_interior_decloak" );
    common_scripts\utility::flag_init( "training_s1_flag_trees_cloak" );
    common_scripts\utility::flag_init( "training_s1_flag_doors_open" );
    common_scripts\utility::flag_init( "training_s1_allow_end_enter_jeep" );
    common_scripts\utility::flag_init( "training_s1_end_enter_jeep" );
    common_scripts\utility::flag_init( "tour_exo_begin" );
    common_scripts\utility::flag_init( "tour_exo_hangar" );
    common_scripts\utility::flag_init( "arm_swapped" );
    common_scripts\utility::flag_init( "tour_exo_exit" );
    common_scripts\utility::flag_init( "tour_firing_range" );
    common_scripts\utility::flag_init( "shooting_range_talk" );
    common_scripts\utility::flag_init( "flag_enable_grenade_autofill" );
    common_scripts\utility::flag_init( "drone_flight" );
    common_scripts\utility::flag_init( "flag_drone_range_start" );
    common_scripts\utility::flag_init( "training_s1_end_enter_jeep" );
    common_scripts\utility::flag_init( "start_tour_ride" );
    common_scripts\utility::flag_init( "training_end" );
    common_scripts\utility::flag_init( "training_round_2" );
    common_scripts\utility::flag_init( "training_s2_ready" );
    common_scripts\utility::flag_init( "training_2_begin" );
    common_scripts\utility::flag_init( "_stealth_spotted" );
    common_scripts\utility::flag_init( "training_s2_start_charge" );
    common_scripts\utility::flag_init( "training_s2_path_end1" );
    common_scripts\utility::flag_init( "training_s2_path_end2" );
    common_scripts\utility::flag_init( "training_s2_path_end3" );
    common_scripts\utility::flag_init( "training_s2_start_alerted" );
    common_scripts\utility::flag_init( "training_s2_clear_start_spawn" );
    common_scripts\utility::flag_init( "training_s2_living_room_alert" );
    common_scripts\utility::flag_init( "training_s2_threat_enabled" );
    common_scripts\utility::flag_init( "training_s2_flag_thermal" );
    common_scripts\utility::flag_init( "training_s2_peak_thermal_door" );
    common_scripts\utility::flag_init( "training_s2_open_thermal_door" );
    common_scripts\utility::flag_init( "training_s2_hallway_surprise_enemy" );
    common_scripts\utility::flag_init( "training_s2_start_alert" );
    common_scripts\utility::flag_init( "training_s2_start_drone_scout" );
    common_scripts\utility::flag_init( "training_s2_start_player_in_sniper_attack_position" );
    common_scripts\utility::flag_init( "training_s2_start_player_sniper_attack" );
    common_scripts\utility::flag_init( "training_s2_spawn_starting_enemies" );
    common_scripts\utility::flag_init( "training_s2_clear_initial_spawn" );
    common_scripts\utility::flag_init( "training_s2_snipers_attack" );
    common_scripts\utility::flag_init( "training_s2_living_room_approach" );
    common_scripts\utility::flag_init( "training_s2_flag_entrance" );
    common_scripts\utility::flag_init( "training_s2_enable_living_room" );
    common_scripts\utility::flag_init( "training_s2_prep_breach" );
    common_scripts\utility::flag_init( "training_s2_mute_breach_setup" );
    common_scripts\utility::flag_init( "door_breach_s2" );
    common_scripts\utility::flag_init( "training_s2_spawn_breach_door" );
    common_scripts\utility::flag_init( "flag_living_room_dead" );
    common_scripts\utility::flag_init( "flag_hallway_dead" );
    common_scripts\utility::flag_init( "flag_surprise_dead" );
    common_scripts\utility::flag_init( "flag_bedrooms_dead" );
    common_scripts\utility::flag_init( "training_s2_mute_breach" );
    common_scripts\utility::flag_init( "training_s2_mute_breach_enabled" );
    common_scripts\utility::flag_init( "training_s2_breach_begin" );
    common_scripts\utility::flag_init( "training_s2_breach_done" );
    common_scripts\utility::flag_init( "training_s2_breach_enemy_dead" );
    common_scripts\utility::flag_init( "training_s2_breach_enemies_dead" );
    common_scripts\utility::flag_init( "training_s2_flag_president_dead" );
    common_scripts\utility::flag_init( "training_s2_flag_president_shot" );
    common_scripts\utility::flag_init( "training_s2_spawn_breach_enemies" );
    common_scripts\utility::flag_init( "training_s2_bathroom_enemy_dead" );
    common_scripts\utility::flag_init( "training_s2_release_president" );
    common_scripts\utility::flag_init( "training_s2_president_free" );
    common_scripts\utility::flag_init( "training_s2_drone_attack_setup" );
    common_scripts\utility::flag_init( "training_s2_living_room_drone_attack" );
    common_scripts\utility::flag_init( "training_s2_ready_living_room_drone_attack" );
    common_scripts\utility::flag_init( "training_s2_ambush_cleanup" );
    common_scripts\utility::flag_init( "training_s2_living_room_drone_attack_done" );
    common_scripts\utility::flag_init( "training_s2_gideon_smash_french_door" );
    common_scripts\utility::flag_init( "training_s2_drone_start" );
    common_scripts\utility::flag_init( "flag_player_using_drone" );
    common_scripts\utility::flag_init( "flag_training_s2_patio_enemies_charge" );
    common_scripts\utility::flag_init( "training_s2_start_enter_patio" );
    common_scripts\utility::flag_init( "training_s2_enter_patio" );
    common_scripts\utility::flag_init( "training_s2_drone_attack_done" );
    common_scripts\utility::flag_init( "training_s2_patio_alert" );
    common_scripts\utility::flag_init( "training_s2_clear_patio_spawn" );
    common_scripts\utility::flag_init( "training_s2_golf_course_hide" );
    common_scripts\utility::flag_init( "flag_training_s2_squad_advance_golf_course" );
    common_scripts\utility::flag_init( "training_s2_hide_from_patrols_done" );
    common_scripts\utility::flag_init( "training_s2_start_escape_vehicle" );
    common_scripts\utility::flag_init( "training_s2_start_exo_shield_tutorial" );
    common_scripts\utility::flag_init( "training_s2_golf_course_vehicles" );
    common_scripts\utility::flag_init( "training_s2_vehicle_ready" );
    common_scripts\utility::flag_init( "training_s2_end_setup_president" );
    common_scripts\utility::flag_init( "flag_training_s2_guard_house_doors_stay_open" );
    common_scripts\utility::flag_init( "training_s2_start_warbird" );
    common_scripts\utility::flag_init( "training_s2_warbird_uncloak" );
    common_scripts\utility::flag_init( "training_s2_warbird_attack" );
    common_scripts\utility::flag_init( "training_s2_warbird_kill_enemies" );
    common_scripts\utility::flag_init( "training_s2_end_helicopter_setup_irons" );
    common_scripts\utility::flag_init( "training_s2_end_helicopter_setup_gideon" );
    common_scripts\utility::flag_init( "training_enable_end" );
    common_scripts\utility::flag_init( "training_s2_enter_helicopter" );
    common_scripts\utility::flag_init( "training_s2_end_helicopter_irons_end" );
    common_scripts\utility::flag_init( "play_tv_news" );
    common_scripts\utility::flag_init( "flag_enable_overdrive" );
    common_scripts\utility::flag_init( "flag_disable_exo" );
    common_scripts\utility::flag_init( "gideon_jog_and_speedup" );

    if ( level.currentgen )
    {
        common_scripts\utility::flag_init( "flag_tff_trans_tour_ride_to_tour_exo" );
        common_scripts\utility::flag_init( "tff_tour_ride_over" );
        common_scripts\utility::flag_init( "flag_tff_exo_unload_ally_ready" );
        common_scripts\utility::flag_init( "flag_tff_firing_range_unload_ally_ready" );
    }
}

disable_default_exo_powers()
{
    level.player.disabled_exo = maps\_player_exo::player_exo_get_owned_array();
    maps\_player_exo::player_exo_remove_array( level.player.disabled_exo );
}

restore_default_exo_powers()
{
    if ( isdefined( level.player.disabled_exo ) )
    {
        maps\_player_exo::player_exo_add_array( level.player.disabled_exo );
        level.player.disabled_exo = undefined;
    }
}

manage_player_exo_toggling()
{
    for (;;)
    {
        common_scripts\utility::flag_wait( "flag_disable_exo" );
        disable_default_exo_powers();
        common_scripts\utility::flag_waitopen( "flag_disable_exo" );
        restore_default_exo_powers();
    }
}

manage_player_exo()
{
    maps\_player_exo::player_exo_remove_single( "overdrive" );
    maps\_player_exo::player_exo_activate();
    maps\_player_exo::update_overdrive_icon( 0 );
    thread manage_player_exo_toggling();
    common_scripts\utility::flag_wait( "flag_enable_overdrive" );
    maps\_player_exo::player_exo_add_single( "overdrive" );
}

setup_start_points()
{
    maps\_utility::add_start( "funeral", ::funeral );
    maps\_utility::add_start( "training_begin", ::training_begin );
    maps\_utility::add_start( "training_lodge_begin", ::training_lodge_begin );
    maps\_utility::add_start( "training_lodge_breach", ::training_lodge_breach );
    maps\_utility::add_start( "training_lodge_exit", ::training_lodge_exit );
    maps\_utility::add_start( "training_golf_course", ::training_golf_course );
    maps\_utility::add_start( "training_end", ::training_end );
    maps\_utility::add_start( "tour_ride_begin", ::tour_ride_begin );
    maps\_utility::add_start( "tour_exo_begin", ::tour_exo_begin );
    maps\_utility::add_start( "tour_exo_exit", ::tour_exo_exit );
    maps\_utility::add_start( "tour_firing_range", ::tour_firing_range );
    maps\_utility::add_start( "tour_augmented_reality", ::tour_augmented_reality );
    maps\_utility::add_start( "tour_end", ::tour_end );
    maps\_utility::add_start( "training_2_begin", ::training_2_begin );
    maps\_utility::add_start( "training_2_lodge_begin", ::training_2_lodge_begin );
    maps\_utility::add_start( "training_2_lodge_breach", ::training_2_lodge_breach );
    maps\_utility::add_start( "training_2_lodge_exit", ::training_2_lodge_exit );
    maps\_utility::add_start( "training_2_golf_course", ::training_2_golf_course );
    maps\_utility::add_start( "training_2_end", ::training_2_end );
    // level.start_point = "tour_exo_begin";

    if ( level.currentgen )
        setup_start_transients();
}

setup_start_transients()
{
    var_0 = [ "recovery_funeral_tr" ];
    maps\_utility::set_start_transients( "funeral", var_0 );
    var_0[0] = "recovery_training_tr";
    maps\_utility::set_start_transients( "training_begin", var_0 );
    maps\_utility::set_start_transients( "training_lodge_begin", var_0 );
    maps\_utility::set_start_transients( "training_lodge_exit", var_0 );
    maps\_utility::set_start_transients( "training_golf_course", var_0 );
    maps\_utility::set_start_transients( "training_end", var_0 );
    var_0[0] = "recovery_base_tr";
    var_0[1] = "recovery_tour_ride_tr";
    maps\_utility::set_start_transients( "tour_ride_begin", var_0 );
    var_0[1] = "recovery_tour_exo_tr";
    maps\_utility::set_start_transients( "tour_exo_begin", var_0 );
    maps\_utility::set_start_transients( "tour_exo_exit", var_0 );
    var_0[1] = "recovery_tour_firing_range_tr";
    maps\_utility::set_start_transients( "tour_firing_range", var_0 );
    var_0[1] = "recovery_tour_augmented_reality_tr";
    maps\_utility::set_start_transients( "tour_augmented_reality", var_0 );
    var_0 = [ "recovery_base_tr" ];
    maps\_utility::set_start_transients( "tour_end", var_0 );
    var_0 = [ "recovery_training_tr" ];
    maps\_utility::set_start_transients( "training_2_begin", var_0 );
    maps\_utility::set_start_transients( "training_2_lodge_begin", var_0 );
    maps\_utility::set_start_transients( "training_2_lodge_breach", var_0 );
    maps\_utility::set_start_transients( "training_2_lodge_exit", var_0 );
    maps\_utility::set_start_transients( "training_2_golf_course", var_0 );
    maps\_utility::set_start_transients( "training_2_end", var_0 );
}

tff_setups()
{
    thread setup_tff_transitions();
    thread setup_tff_cleanups();
}

tff_ally_check( var_0, var_1, var_2 )
{
    var_3 = getent( var_0, "targetname" );
    level.tff_trans_ally_check_count = 0;

    for (;;)
    {
        var_3 waittill( "trigger", var_4 );

        if ( isdefined( var_2 ) && !common_scripts\utility::flag( var_2 ) )
            continue;

        if ( isdefined( var_4.tff_trans_ally_check_active ) && var_4.tff_trans_ally_check_active )
            continue;

        if ( isdefined( var_4.script_friendname ) )
            var_5 = tolower( var_4.script_friendname );
        else
            var_5 = "";

        if ( var_4 == level.player || var_5 == "gideon" )
        {
            level.tff_trans_ally_check_count++;

            if ( level.tff_trans_ally_check_count >= 2 )
            {
                common_scripts\utility::flag_set( var_1 );
                break;
            }

            var_4.tff_trans_ally_check_active = 1;
            var_4 thread tff_trans_ally_check_touching( var_3 );
        }
    }
}

tff_trans_ally_check_touching( var_0 )
{
    while ( self istouching( var_0 ) )
        wait 0.05;

    level.tff_trans_ally_check_count--;
    self.tff_trans_ally_check_active = 0;
}

setup_tff_transitions()
{
    if ( !istransientloaded( "recovery_tour_ride_tr" ) )
        thread tff_trans_training_to_tour_ride();

    if ( !istransientloaded( "recovery_tour_exo_tr" ) )
        thread tff_trans_tour_ride_to_tour_exo();

    if ( !istransientloaded( "recovery_tour_firing_range_tr" ) )
        thread tff_trans_tour_exo_to_tour_firing_range();

    if ( !istransientloaded( "recovery_tour_augmented_reality_tr" ) )
        thread tff_trans_tour_firing_range_to_tour_augmented_reality();

    if ( !istransientloaded( "recovery_training_tr" ) || level.start_point == "training_begin" || level.start_point == "training_lodge_begin" || level.start_point == "training_lodge_exit" || level.start_point == "training_golf_course" || level.start_point == "training_end" )
        thread tff_trans_tour_augmented_reality_to_training();
}

tff_trans_training_to_tour_ride()
{
    common_scripts\utility::flag_wait( "training_s1_end_anim_started" );
    level notify( "tff_pre_training_to_tour_ride" );
    unloadtransient( "recovery_training_tr" );
    loadtransient( "recovery_base_tr" );

    while ( !istransientloaded( "recovery_base_tr" ) )
        wait 0.05;

    loadtransient( "recovery_tour_ride_tr" );

    while ( !istransientloaded( "recovery_tour_ride_tr" ) )
        wait 0.05;

    level notify( "tff_post_training_to_tour_ride" );
}

tff_trans_tour_ride_to_tour_exo()
{
    common_scripts\utility::flag_wait( "flag_tff_trans_tour_ride_to_tour_exo" );
    common_scripts\utility::flag_set( "tff_tour_ride_over" );
    level notify( "tff_pre_tour_ride_to_tour_exo" );
    unloadtransient( "recovery_tour_ride_tr" );
    loadtransient( "recovery_tour_exo_tr" );

    while ( !istransientloaded( "recovery_tour_exo_tr" ) )
        wait 0.05;

    level notify( "tff_post_tour_ride_to_tour_exo" );
}

tff_trans_tour_exo_to_tour_firing_range()
{
    thread tff_ally_check( "tff_ally_check_tour_exo_unload", "flag_tff_exo_unload_ally_ready", "arm_swapped" );
    common_scripts\utility::flag_wait( "flag_tff_trans_tour_exo_to_tour_firing_range" );
    common_scripts\utility::flag_wait( "flag_tff_exo_unload_ally_ready" );
    level notify( "tff_pre_tour_exo_to_tour_firing_range" );
    var_0 = getent( "tour_glass_door_02_l", "targetname" );
    var_1 = getent( "tour_glass_door_02_r", "targetname" );
    var_2 = common_scripts\utility::getstruct( "tour_glass_door_02_closed", "targetname" );
    var_3 = 0.6;
    soundscripts\_snd::snd_message( "rec_star_trek_door_close", var_0, var_1 );
    var_0 moveto( var_2.origin, var_3, 0.2, 0.2 );
    var_1 moveto( var_2.origin, var_3, 0.2, 0.2 );
    wait(var_3);
    unloadtransient( "recovery_tour_exo_tr" );
    loadtransient( "recovery_tour_firing_range_tr" );

    while ( !istransientloaded( "recovery_tour_firing_range_tr" ) )
        wait 0.05;

    level notify( "tff_post_tour_exo_to_tour_firing_range" );
}

tff_trans_tour_firing_range_to_tour_augmented_reality()
{
    thread tff_ally_check( "tff_ally_check_tour_firing_range_unload", "flag_tff_firing_range_unload_ally_ready", "shooting_range_completed_once" );
    common_scripts\utility::flag_wait( "flag_tff_trans_tour_firing_range_to_aug_reality" );
    common_scripts\utility::flag_wait( "flag_tff_firing_range_unload_ally_ready" );
    level notify( "tff_pre_tour_firing_range_to_tour_aug_reality" );
    var_0 = getent( "tour_glass_door_04_l", "targetname" );
    var_1 = getent( "tour_glass_door_04_r", "targetname" );
    var_2 = common_scripts\utility::getstruct( "tour_glass_door_04_closed", "targetname" );
    var_3 = 0.6;
    soundscripts\_snd::snd_message( "rec_star_trek_door_close", var_0, var_1 );
    var_0 moveto( var_2.origin, var_3, 0.2, 0.2 );
    var_1 moveto( var_2.origin, var_3, 0.2, 0.2 );
    wait(var_3);
    unloadtransient( "recovery_tour_firing_range_tr" );
    loadtransient( "recovery_tour_augmented_reality_tr" );

    while ( !istransientloaded( "recovery_tour_augmented_reality_tr" ) )
        wait 0.05;

    level notify( "tff_post_tour_firing_range_to_tour_aug_reality" );
}

tff_trans_tour_augmented_reality_to_training()
{
    common_scripts\utility::flag_wait( "elevator_room_interior" );

    if ( istransientloaded( "recovery_tour_augmented_reality_tr" ) )
    {
        level notify( "tff_pre_tour_aug_reality_to_training" );
        unloadtransient( "recovery_tour_augmented_reality_tr" );
    }

    common_scripts\utility::flag_waitopen( "tour_glass_door_05" );
    wait 2.0;
    unloadtransient( "recovery_base_tr" );
    loadtransient( "recovery_training_tr" );

    while ( !istransientloaded( "recovery_training_tr" ) )
        wait 0.05;

    level notify( "tff_post_tour_aug_reality_to_training" );
}

setup_tff_cleanups()
{
    thread tff_cleanup_tour_ride_ambient_vehicles();
}

tff_cleanup_tour_ride_ambient_vehicles()
{
    level waittill( "tff_pre_tour_ride_to_tour_exo" );
    var_0 = getentarray( "tour_ride_ambient_vehicle", "script_noteworthy" );

    foreach ( var_2 in var_0 )
    {
        if ( isdefined( var_2 ) )
        {
            if ( !isspawner( var_2 ) )
            {
                var_2 freevehicle();
                var_2 delete();
            }
        }
    }
}

set_completed_flags()
{
    var_0 = level.start_point;

    if ( !isdefined( var_0 ) )
        return;

    if ( var_0 == "funeral" )
        return;

    common_scripts\utility::flag_set( "funeral_complete" );
    common_scripts\utility::flag_set( "flag_obj_funeral_casket_start" );
    common_scripts\utility::flag_set( "flag_obj_funeral_casket_complete" );
    common_scripts\utility::flag_set( "flag_obj_funeral_irons_start" );
    common_scripts\utility::flag_set( "flag_obj_funeral_irons_complete" );

    if ( var_0 == "training_begin" )
        return;

    common_scripts\utility::flag_set( "flag_obj_rescue1_start" );
    common_scripts\utility::flag_set( "flag_obj_rescue1_start_clear" );
    common_scripts\utility::flag_set( "flag_obj_rescue1_enter" );
    common_scripts\utility::flag_set( "flag_obj_rescue1_enter_clear" );
    common_scripts\utility::flag_set( "flag_obj_rescue1_flash" );

    if ( var_0 == "training_lodge_begin" )
        return;

    common_scripts\utility::flag_set( "flag_obj_rescue1_flash_clear" );
    common_scripts\utility::flag_set( "flag_obj_rescue1_breach" );

    if ( var_0 == "training_lodge_breach" )
        return;

    common_scripts\utility::flag_set( "flag_obj_rescue1_breach_clear" );
    common_scripts\utility::flag_set( "flag_obj_rescue1_drone_attack" );

    if ( var_0 == "training_lodge_exit" )
        return;

    common_scripts\utility::flag_set( "flag_obj_rescue1_drone_attack_clear" );
    common_scripts\utility::flag_set( "flag_obj_rescue1_patio_ambush" );
    common_scripts\utility::flag_set( "flag_obj_rescue1_patio_ambush_clear" );
    common_scripts\utility::flag_set( "flag_obj_rescue1_patio_mid" );
    common_scripts\utility::flag_set( "flag_obj_rescue1_golf_course" );

    if ( var_0 == "training_golf_course" )
        return;

    common_scripts\utility::flag_set( "flag_obj_rescue1_golf_course_clear" );
    common_scripts\utility::flag_set( "flag_obj_rescue1_golf_course2" );
    common_scripts\utility::flag_set( "flag_obj_rescue1_golf_course2_clear" );
    common_scripts\utility::flag_set( "flag_obj_rescue1_escape_location" );
    common_scripts\utility::flag_set( "flag_obj_rescue1_escape_location_clear" );
    common_scripts\utility::flag_set( "training_s1_allow_path_to_level_end" );

    if ( var_0 == "training_end" )
        return;

    common_scripts\utility::flag_set( "onBase" );
    common_scripts\utility::flag_set( "flag_obj_rescue1_escape_vehicle" );
    common_scripts\utility::flag_set( "flag_obj_rescue1_escape_vehicle_clear" );
    common_scripts\utility::flag_set( "flag_obj_rescue1_allow_end_enter_jeep" );
    common_scripts\utility::flag_set( "flag_obj_rescue1_allow_end_enter_jeep_clear" );
    common_scripts\utility::flag_set( "flag_obj_rescue1_complete" );
    common_scripts\utility::flag_set( "flag_obj_follow_gideon" );
    common_scripts\utility::flag_set( "flag_mountains_visible" );

    if ( var_0 == "tour_ride_begin" )
        return;

    common_scripts\utility::flag_set( "tour_end" );
    common_scripts\utility::flag_set( "flag_obj_base_start" );
    common_scripts\utility::flag_set( "dropoff_complete" );

    if ( var_0 == "tour_exo_begin" )
        return;

    common_scripts\utility::flag_set( "arm_swapped" );
    common_scripts\utility::flag_set( "flag_obj_arm_repair_pre" );
    common_scripts\utility::flag_set( "flag_obj_arm_repair_desk_enabled" );
    common_scripts\utility::flag_set( "flag_obj_arm_repair_start" );
    common_scripts\utility::flag_set( "flag_obj_arm_repair_complete" );

    if ( var_0 == "tour_exo_exit" )
        return;

    if ( var_0 == "tour_firing_range" )
        return;

    common_scripts\utility::flag_set( "tour_range_door_01_gideon" );
    common_scripts\utility::flag_set( "flag_start_shooting" );
    common_scripts\utility::flag_set( "flag_obj_firing_range_pre" );
    common_scripts\utility::flag_set( "flag_obj_equip_firing_range" );
    common_scripts\utility::flag_set( "flag_obj_gun_range_active" );
    common_scripts\utility::flag_set( "flag_obj_gun_range_start" );
    common_scripts\utility::flag_set( "flag_obj_gun_range_complete" );
    common_scripts\utility::flag_set( "shooting_range_started_once" );
    common_scripts\utility::flag_set( "shooting_range_completed_once" );

    if ( var_0 == "tour_augmented_reality" )
        return;

    common_scripts\utility::flag_set( "training_round_2" );
    common_scripts\utility::flag_set( "flag_obj_grenade_range_pre_1" );
    common_scripts\utility::flag_set( "flag_obj_grenade_range_pre_2" );
    common_scripts\utility::flag_set( "flag_obj_grenade_tutorial_threat_start" );
    common_scripts\utility::flag_set( "flag_obj_grenade_tutorial_threat_complete" );
    common_scripts\utility::flag_set( "flag_obj_grenade_range_tutorial_start" );
    common_scripts\utility::flag_set( "flag_obj_grenade_range_tutorial_complete" );
    common_scripts\utility::flag_set( "flag_obj_grenade_range_minigame_start" );
    common_scripts\utility::flag_set( "flag_obj_grenade_range_minigame_complete" );
    common_scripts\utility::flag_set( "grenade_range_started_once" );
    common_scripts\utility::flag_set( "grenade_range_completed_once" );

    if ( var_0 == "tour_end" )
        return;

    common_scripts\utility::flag_set( "flag_obj_elevator_room" );
    common_scripts\utility::flag_set( "training_room_elevator_activated" );
    common_scripts\utility::flag_set( "training_room_elevator_completed" );
    common_scripts\utility::flag_set( "flag_obj_elevators_exit_complete" );
    common_scripts\utility::flag_clear( "onBase" );

    if ( var_0 == "training_2_begin" )
        return;

    common_scripts\utility::flag_set( "flag_obj_rescue2_start" );
    common_scripts\utility::flag_set( "flag_obj_rescue2_entrance" );
    common_scripts\utility::flag_set( "flag_obj_rescue2_entrance_clear" );
    common_scripts\utility::flag_set( "flag_obj_rescue2_living_room" );

    if ( var_0 == "training_2_lodge_begin" )
        return;

    common_scripts\utility::flag_set( "flag_obj_rescue2_living_room_clear" );
    common_scripts\utility::flag_set( "flag_obj_rescue2_breach" );

    if ( var_0 == "training_2_lodge_breach" )
        return;

    common_scripts\utility::flag_set( "flag_obj_rescue2_breach_clear" );
    common_scripts\utility::flag_set( "flag_obj_rescue2_drone_living_room" );

    if ( var_0 == "training_2_lodge_exit" )
        return;

    common_scripts\utility::flag_set( "flag_obj_rescue2_drone_living_room_clear" );
    common_scripts\utility::flag_set( "flag_obj_rescue2_patio_drone_ambush" );
    common_scripts\utility::flag_set( "flag_obj_rescue2_patio_drone_ambush_clear" );
    common_scripts\utility::flag_set( "flag_obj_rescue2_golf_course" );
    common_scripts\utility::flag_set( "training_s2_drone_attack_done" );

    if ( var_0 == "training_2_golf_course" )
        return;

    common_scripts\utility::flag_set( "flag_obj_rescue2_golf_course_clear" );
    common_scripts\utility::flag_set( "flag_obj_rescue2_golf_course2" );
    common_scripts\utility::flag_set( "flag_obj_rescue2_golf_course2_clear" );
    common_scripts\utility::flag_set( "flag_obj_rescue2_escape_location" );
    common_scripts\utility::flag_set( "flag_obj_rescue2_escape_location_clear" );
    common_scripts\utility::flag_set( "flag_obj_rescue2_escape_vehicle" );
    common_scripts\utility::flag_set( "flag_obj_rescue2_escape_vehicle_clear" );

    if ( var_0 == "training_2_end" )
        return;
}

objective_init()
{
    obj_funeral();
    obj_rescue_1();
    obj_base();
    obj_rescue_2();
}

obj_funeral()
{
    common_scripts\utility::flag_wait( "flag_obj_funeral_casket_start" );
    objective_add( maps\_utility::obj( "funeral" ), "current", &"RECOVERY_OBJ_PAY_RESPECTS" );
    var_0 = common_scripts\utility::getstruct( "obj_marker_funeral_casket", "targetname" );
    objective_position( maps\_utility::obj( "funeral" ), var_0.origin );
    objective_setpointertextoverride( maps\_utility::obj( "funeral" ), &"RECOVERY_PAY_RESPECTS" );
    var_1 = getent( "trig_coffin", "targetname" );
    var_1 maps\_utility::addhinttrigger( &"RECOVERY_PROMPT_CASKET", &"RECOVERY_PROMPT_CASKET_PC" );
    var_2 = var_1 maps\_shg_utility::hint_button_trigger( "use" );
    common_scripts\utility::flag_wait( "flag_obj_funeral_casket_complete" );
    var_1 common_scripts\utility::trigger_off();
    var_2 maps\_shg_utility::hint_button_clear();
    objective_position( maps\_utility::obj( "funeral" ), ( 0, 0, 0 ) );
    common_scripts\utility::flag_wait( "flag_obj_funeral_irons_start" );
    maps\_utility::objective_complete( maps\_utility::obj( "funeral" ) );
    objective_add( maps\_utility::obj( "cormack" ), "current", &"RECOVERY_OBJ_FOLLOW_CORMACK" );
    objective_setpointertextoverride( maps\_utility::obj( "cormack" ), "" );

    if ( isdefined( level.funeral_cormack ) )
        objective_onentity( maps\_utility::obj( "cormack" ), level.funeral_cormack );

    common_scripts\utility::flag_wait( "flag_obj_funeral_irons_complete" );
    maps\_utility::objective_complete( maps\_utility::obj( "cormack" ) );
}

obj_rescue_1()
{
    common_scripts\utility::flag_wait( "flag_obj_rescue1_start" );
    objective_add( maps\_utility::obj( "Rescue" ), "current", &"RECOVERY_OBJ_RESCUE_PRESIDENT" );
    var_0 = common_scripts\utility::getstruct( "obj_marker_rescue1_start", "targetname" );
    objective_position( maps\_utility::obj( "Rescue" ), var_0.origin );
    common_scripts\utility::flag_wait( "flag_obj_rescue1_start_clear" );
    objective_position( maps\_utility::obj( "Rescue" ), ( 0, 0, 0 ) );
    common_scripts\utility::flag_wait( "flag_obj_rescue1_enter" );
    var_1 = common_scripts\utility::getstruct( "obj_marker_rescue1_entrance", "targetname" );
    objective_position( maps\_utility::obj( "Rescue" ), var_1.origin );
    common_scripts\utility::flag_wait( "flag_obj_rescue1_enter_clear" );
    objective_position( maps\_utility::obj( "Rescue" ), ( 0, 0, 0 ) );
    common_scripts\utility::flag_wait( "flag_obj_rescue1_flash" );
    var_2 = common_scripts\utility::getstruct( "obj_marker_rescue1_flash", "targetname" );
    objective_position( maps\_utility::obj( "Rescue" ), var_2.origin );
    common_scripts\utility::flag_wait( "flag_obj_rescue1_flash_clear" );
    objective_position( maps\_utility::obj( "Rescue" ), ( 0, 0, 0 ) );
    common_scripts\utility::flag_wait( "flag_obj_rescue1_breach" );
    var_3 = getent( "training_s1_breach_door_trigger", "targetname" );
    var_3 maps\_utility::addhinttrigger( &"RECOVERY_PROMPT_MUTE_DEVICE", &"RECOVERY_PROMPT_MUTE_DEVICE_PC" );
    objective_position( maps\_utility::obj( "Rescue" ), var_3.origin );
    objective_setpointertextoverride( maps\_utility::obj( "Rescue" ), &"RECOVERY_PLANT" );
    common_scripts\utility::flag_wait( "flag_obj_rescue1_breach_clear" );
    objective_position( maps\_utility::obj( "Rescue" ), ( 0, 0, 0 ) );
    objective_setpointertextoverride( maps\_utility::obj( "Rescue" ), "" );
    common_scripts\utility::flag_wait( "flag_obj_rescue1_drone_attack" );
    waitframe();
    var_4 = common_scripts\utility::getstruct( "obj_marker_rescue1_drone_attack", "targetname" );
    objective_position( maps\_utility::obj( "Rescue" ), var_4.origin );
    common_scripts\utility::flag_wait( "flag_obj_rescue1_drone_attack_clear" );
    objective_position( maps\_utility::obj( "Rescue" ), ( 0, 0, 0 ) );
    common_scripts\utility::flag_wait( "flag_obj_rescue1_patio_ambush" );
    var_5 = common_scripts\utility::getstruct( "obj_marker_rescue1_patio_ambush", "targetname" );
    objective_position( maps\_utility::obj( "Rescue" ), var_5.origin );
    common_scripts\utility::flag_wait( "flag_obj_rescue1_patio_ambush_clear" );
    var_6 = common_scripts\utility::getstruct( "obj_marker_rescue1_patio_mid", "targetname" );
    objective_position( maps\_utility::obj( "Rescue" ), var_6.origin );
    common_scripts\utility::flag_wait( "flag_obj_rescue1_patio_mid" );
    objective_position( maps\_utility::obj( "Rescue" ), ( 0, 0, 0 ) );
    common_scripts\utility::flag_wait( "flag_obj_rescue1_golf_course" );

    if ( !common_scripts\utility::flag( "onBase" ) )
    {
        for (;;)
        {
            if ( isdefined( level.joker ) )
                break;
            else
                waitframe();
        }
    }

    if ( isdefined( level.joker ) )
        objective_onentity( maps\_utility::obj( "Rescue" ), level.joker );

    common_scripts\utility::flag_wait( "flag_obj_rescue1_golf_course_clear" );
    objective_position( maps\_utility::obj( "Rescue" ), ( 0, 0, 0 ) );
    common_scripts\utility::flag_wait( "flag_obj_rescue1_golf_course2" );
    waitframe();

    if ( isdefined( level.joker ) )
        objective_onentity( maps\_utility::obj( "Rescue" ), level.joker );

    common_scripts\utility::flag_wait( "flag_obj_rescue1_escape_location_clear" );
    waitframe();
    objective_position( maps\_utility::obj( "Rescue" ), ( 0, 0, 0 ) );
    common_scripts\utility::flag_wait( "flag_obj_rescue1_escape_vehicle" );
    var_7 = getent( "training_s1_ending_trigger", "targetname" );
    var_7 maps\_utility::addhinttrigger( &"RECOVERY_PROMPT_OPEN", &"RECOVERY_PROMPT_OPEN_PC" );
    objective_position( maps\_utility::obj( "Rescue" ), var_7.origin );
    objective_setpointertextoverride( maps\_utility::obj( "Rescue" ), &"RECOVERY_OPEN" );
    common_scripts\utility::flag_wait( "flag_obj_rescue1_escape_vehicle_clear" );
    objective_setpointertextoverride( maps\_utility::obj( "Rescue" ), "" );
    objective_position( maps\_utility::obj( "Rescue" ), ( 0, 0, 0 ) );
    common_scripts\utility::flag_wait( "flag_obj_rescue1_complete" );
    objective_state( maps\_utility::obj( "Rescue" ), "failed" );
}

obj_base()
{
    common_scripts\utility::flag_wait( "flag_obj_follow_gideon" );

    for (;;)
    {
        if ( isdefined( level.gideon ) )
            break;
        else
            waitframe();
    }

    objective_add( maps\_utility::obj( "gideon" ), "current", &"RECOVERY_OBJ_FOLLOW_GIDEON" );
    var_0 = getent( "training_s1_jeep_enter_trigger", "targetname" );
    objective_position( maps\_utility::obj( "gideon" ), var_0.origin );
    objective_setpointertextoverride( maps\_utility::obj( "gideon" ), &"RECOVERY_ENTER" );
    common_scripts\utility::flag_wait( "flag_obj_rescue1_allow_end_enter_jeep_clear" );
    objective_position( maps\_utility::obj( "gideon" ), ( 0, 0, 0 ) );
    objective_setpointertextoverride( maps\_utility::obj( "gideon" ), "" );
    common_scripts\utility::flag_wait( "flag_obj_base_start" );
    objective_onentity( maps\_utility::obj( "gideon" ), level.gideon );
    common_scripts\utility::flag_wait( "flag_obj_arm_repair_pre" );
    var_1 = common_scripts\utility::getstruct( "obj_prep_arm_repair", "targetname" );
    objective_position( maps\_utility::obj( "gideon" ), var_1.origin );
    common_scripts\utility::flag_wait( "flag_obj_arm_repair_desk_enabled" );
    objective_setpointertextoverride( maps\_utility::obj( "gideon" ), &"RECOVERY_USE" );
    var_2 = getent( "trig_desk_interact", "targetname" );
    var_2 maps\_utility::addhinttrigger( &"RECOVERY_PROMPT_USE_GENERAL", &"RECOVERY_PROMPT_USE_GENERAL_PC" );
    var_3 = var_2 maps\_shg_utility::hint_button_trigger( "use" );
    common_scripts\utility::flag_wait( "flag_obj_arm_repair_start" );
    var_3 maps\_shg_utility::hint_button_clear();
    var_2 delete();
    objective_position( maps\_utility::obj( "gideon" ), ( 0, 0, 0 ) );
    objective_setpointertextoverride( maps\_utility::obj( "gideon" ), "" );
    common_scripts\utility::flag_wait( "flag_obj_arm_repair_complete" );
    objective_onentity( maps\_utility::obj( "gideon" ), level.gideon );
    common_scripts\utility::flag_wait( "flag_obj_firing_range_pre" );
    maps\_utility::objective_complete( maps\_utility::obj( "gideon" ) );
    objective_add( maps\_utility::obj( "firing_range" ), "current", &"RECOVERY_OBJ_FIRING_RANGE" );
    var_4 = common_scripts\utility::getstruct( "obj_equip_firing_range", "targetname" );
    objective_position( maps\_utility::obj( "firing_range" ), var_4.origin );
    objective_setpointertextoverride( maps\_utility::obj( "firing_range" ), &"RECOVERY_EQUIP" );
    common_scripts\utility::flag_wait( "flag_obj_equip_firing_range" );
    objective_position( maps\_utility::obj( "firing_range" ), ( 0, 0, 0 ) );
    objective_setpointertextoverride( maps\_utility::obj( "firing_range" ), "" );
    common_scripts\utility::flag_wait( "flag_obj_gun_range_active" );
    var_5 = common_scripts\utility::getstruct( "obj_prep_firing_range", "targetname" );
    objective_position( maps\_utility::obj( "firing_range" ), ( 0, 0, 0 ) );
    common_scripts\utility::flag_wait( "flag_obj_gun_range_start" );
    objective_position( maps\_utility::obj( "firing_range" ), ( 0, 0, 0 ) );
    common_scripts\utility::flag_wait( "flag_obj_gun_range_complete" );
    maps\_utility::objective_complete( maps\_utility::obj( "firing_range" ) );
    objective_add( maps\_utility::obj( "gideon2" ), "current", &"RECOVERY_OBJ_FOLLOW_GIDEON" );
    objective_onentity( maps\_utility::obj( "gideon2" ), level.gideon );
    common_scripts\utility::flag_wait( "flag_obj_grenade_range_pre_1" );
    maps\_utility::objective_complete( maps\_utility::obj( "gideon2" ) );
    objective_add( maps\_utility::obj( "grenade_range" ), "current", &"RECOVERY_OBJ_GRENADE_TRAINING" );
    objective_position( maps\_utility::obj( "grenade_range" ), ( 0, 0, 0 ) );
    common_scripts\utility::flag_wait( "flag_obj_grenade_range_pre_2" );
    var_6 = common_scripts\utility::getstruct( "obj_prep_grenade_emp", "targetname" );
    var_7 = getent( "grenade_range_start", "targetname" );
    objective_position( maps\_utility::obj( "grenade_range" ), var_6.origin );
    objective_setpointertextoverride( maps\_utility::obj( "grenade_range" ), &"RECOVERY_ACTIVATE" );
    common_scripts\utility::flag_wait( "flag_obj_grenade_range_tutorial_start" );
    objective_position( maps\_utility::obj( "grenade_range" ), ( 0, 0, 0 ) );
    objective_setpointertextoverride( maps\_utility::obj( "grenade_range" ), "" );
    common_scripts\utility::flag_wait( "flag_obj_grenade_tutorial_threat_start" );
    var_8 = common_scripts\utility::getstruct( "obj_grenade_range_threat_tutorial", "targetname" );
    objective_position( maps\_utility::obj( "grenade_range" ), var_8.origin );
    common_scripts\utility::flag_wait( "flag_obj_grenade_tutorial_threat_complete" );
    objective_position( maps\_utility::obj( "grenade_range" ), ( 0, 0, 0 ) );
    common_scripts\utility::flag_wait( "flag_obj_grenade_range_tutorial_complete" );
    var_6 = common_scripts\utility::getstruct( "obj_prep_grenade_emp", "targetname" );
    var_7 = getent( "grenade_range_start", "targetname" );
    objective_position( maps\_utility::obj( "grenade_range" ), var_6.origin );
    objective_setpointertextoverride( maps\_utility::obj( "grenade_range" ), &"RECOVERY_ACTIVATE" );
    common_scripts\utility::flag_wait( "flag_obj_grenade_range_minigame_start" );
    objective_position( maps\_utility::obj( "grenade_range" ), ( 0, 0, 0 ) );
    objective_setpointertextoverride( maps\_utility::obj( "grenade_range" ), "" );
    common_scripts\utility::flag_wait( "flag_obj_grenade_range_minigame_complete" );
    maps\_utility::objective_complete( maps\_utility::obj( "grenade_range" ) );
    objective_add( maps\_utility::obj( "gideon3" ), "current", &"RECOVERY_OBJ_FOLLOW_GIDEON" );
    objective_onentity( maps\_utility::obj( "gideon3" ), level.gideon );
    common_scripts\utility::flag_wait( "flag_obj_elevator_room" );
    var_9 = common_scripts\utility::getstruct( "obj_prep_elevators_exit", "targetname" );
    objective_position( maps\_utility::obj( "gideon3" ), var_9.origin );
    common_scripts\utility::flag_wait( "flag_obj_elevators_exit_complete" );
    maps\_utility::objective_complete( maps\_utility::obj( "gideon3" ) );
}

obj_rescue_2()
{
    waitframe();
    common_scripts\utility::flag_wait( "flag_obj_rescue2_start" );
    waitframe();
    objective_add( maps\_utility::obj( "Rescue2" ), "current", &"RECOVERY_OBJ_RESCUE_PRESIDENT" );
    objective_position( maps\_utility::obj( "Rescue2" ), ( 0, 0, 0 ) );
    common_scripts\utility::flag_wait( "flag_obj_rescue2_entrance" );
    var_0 = common_scripts\utility::getstruct( "obj_marker_rescue2_entrance", "targetname" );
    objective_position( maps\_utility::obj( "Rescue2" ), var_0.origin );
    common_scripts\utility::flag_wait( "flag_obj_rescue2_entrance_clear" );
    objective_position( maps\_utility::obj( "Rescue2" ), ( 0, 0, 0 ) );
    common_scripts\utility::flag_wait( "flag_obj_rescue2_living_room" );
    var_1 = common_scripts\utility::getstruct( "obj_s2_living_room_breach_01", "targetname" );
    var_2 = common_scripts\utility::getstruct( "obj_s2_living_room_breach_02", "targetname" );
    var_3 = common_scripts\utility::getstruct( "obj_s2_living_room_breach_03", "targetname" );
    objective_position( maps\_utility::obj( "Rescue2" ), var_1.origin );
    objective_additionalposition( maps\_utility::obj( "Rescue2" ), 1, var_2.origin );
    objective_additionalposition( maps\_utility::obj( "Rescue2" ), 2, var_3.origin );
    objective_setpointertextoverride( maps\_utility::obj( "Rescue2" ), &"RECOVERY_BREACH" );
    common_scripts\utility::flag_wait( "flag_obj_rescue2_living_room_clear" );
    waitframe();
    maps\_utility::objective_clearadditionalpositions( maps\_utility::obj( "Rescue2" ) );
    objective_position( maps\_utility::obj( "Rescue2" ), ( 0, 0, 0 ) );
    objective_setpointertextoverride( maps\_utility::obj( "Rescue2" ), "" );
    common_scripts\utility::flag_wait( "flag_obj_rescue2_breach" );
    var_4 = getent( "training_s2_breach_trigger", "targetname" );
    var_5 = getent( "training_s2_breach_trigger_use", "targetname" );
    var_5 sethintstring( &"RECOVERY_PROMPT_BREACH" );
    objective_position( maps\_utility::obj( "Rescue2" ), var_4.origin );
    objective_setpointertextoverride( maps\_utility::obj( "Rescue2" ), &"RECOVERY_BREACH" );
    common_scripts\utility::flag_wait( "flag_obj_rescue2_breach_clear" );
    objective_position( maps\_utility::obj( "Rescue2" ), ( 0, 0, 0 ) );
    objective_setpointertextoverride( maps\_utility::obj( "Rescue2" ), "" );
    common_scripts\utility::flag_wait( "flag_obj_rescue2_drone_living_room" );
    var_6 = common_scripts\utility::getstruct( "obj_marker_rescue2_living_room", "targetname" );
    objective_position( maps\_utility::obj( "Rescue2" ), var_6.origin );
    common_scripts\utility::flag_wait( "flag_obj_rescue2_drone_living_room_clear" );
    objective_position( maps\_utility::obj( "Rescue2" ), ( 0, 0, 0 ) );
    common_scripts\utility::flag_wait( "flag_obj_rescue2_patio_drone_ambush" );
    var_7 = common_scripts\utility::getstruct( "obj_marker_rescue2_patio_drone_ambush", "targetname" );
    objective_position( maps\_utility::obj( "Rescue2" ), var_7.origin );
    common_scripts\utility::flag_wait( "flag_obj_rescue2_patio_drone_ambush_clear" );
    objective_position( maps\_utility::obj( "Rescue2" ), ( 0, 0, 0 ) );
    common_scripts\utility::flag_wait( "flag_obj_rescue2_golf_course" );
    waitframe();

    for (;;)
    {
        if ( isdefined( level.gideon ) )
            break;
        else
            waitframe();
    }

    objective_onentity( maps\_utility::obj( "Rescue2" ), level.gideon );
    common_scripts\utility::flag_wait( "flag_obj_rescue2_escape_location_clear" );
    objective_position( maps\_utility::obj( "Rescue2" ), ( 0, 0, 0 ) );
    common_scripts\utility::flag_wait( "flag_obj_rescue2_escape_vehicle" );
    var_8 = getent( "training_s2_ending_trigger", "targetname" );
    var_8 maps\_utility::addhinttrigger( &"RECOVERY_PROMPT_OPEN", &"RECOVERY_PROMPT_OPEN_PC" );
    objective_position( maps\_utility::obj( "Rescue2" ), var_8.origin );
    objective_setpointertextoverride( maps\_utility::obj( "Rescue2" ), &"RECOVERY_OPEN" );
    common_scripts\utility::flag_wait( "flag_obj_rescue2_escape_vehicle_clear" );
    objective_position( maps\_utility::obj( "Rescue2" ), ( 0, 0, 0 ) );
    objective_setpointertextoverride( maps\_utility::obj( "Rescue2" ), "" );
    common_scripts\utility::flag_wait( "flag_obj_rescue2_complete" );
    var_9 = common_scripts\utility::getstruct( "obj_marker_rescue2_complete", "targetname" );
    objective_position( maps\_utility::obj( "Rescue2" ), var_9.origin );
    common_scripts\utility::flag_wait( "flag_obj_rescue2_complete_clear" );
    maps\_utility::objective_complete( maps\_utility::obj( "Rescue2" ) );
}

funeral()
{
    level.player disableweapons();
    level.player freezecontrols( 1 );
    thread maps\_shg_utility::play_chyron_video( "chyron_text_recovery", 2, 2 );
    common_scripts\utility::flag_wait( "chyron_video_done" );
    soundscripts\_snd::snd_message( "start_funeral" );
    maps\_shg_utility::move_player_to_start( "funeral" );
    common_scripts\utility::flag_set( "funeral" );
}

training_begin()
{
    maps\_shg_utility::move_player_to_start( "training_begin" );
    common_scripts\utility::flag_set( "training_begin" );
    maps\recovery_code::training_s1_opening();
    soundscripts\_snd::snd_message( "start_training_01" );
}

training_lodge_begin()
{
    soundscripts\_snd::snd_message( "start_training_01_lodge" );
    maps\_shg_utility::move_player_to_start( "training_lodge_begin" );
    setup_allies( "training_lodge_begin" );
    common_scripts\utility::flag_set( "training_lodge_begin_lighting" );
    common_scripts\utility::flag_set( "training_s1_clear_initial_spawn" );
    common_scripts\utility::flag_set( "training_s1_living_room_approach" );
    maps\_utility::activate_trigger( "training_s1_color_trigger2_cover", "targetname" );
    maps\_utility::activate_trigger( "training_s1_color_trigger2", "targetname" );
    common_scripts\utility::flag_set( "flag_obj_rescue1_enter_clear" );
    common_scripts\utility::flag_set( "flag_obj_rescue1_flash" );
    common_scripts\utility::flag_set( "training_ready_flash_bang" );
    common_scripts\utility::flag_set( "flag_vo_training_s1_prophet_tracking_potus" );
    maps\recovery_code::camp_david_play_videos();
}

training_lodge_breach()
{
    soundscripts\_snd::snd_message( "start_training_01_lodge_breach" );
    maps\_shg_utility::move_player_to_start( "training_lodge_breach" );
    setup_allies( "training_lodge_breach" );
    common_scripts\utility::flag_set( "training_lodge_breach_lighting" );
    common_scripts\utility::flag_set( "training_s1_spawn_breach_door" );
    common_scripts\utility::flag_set( "training_s1_mute_breach_setup" );
    maps\recovery_code::camp_david_play_videos();
}

training_lodge_exit()
{
    soundscripts\_snd::snd_message( "start_training_01_lodge_exit" );
    maps\_shg_utility::move_player_to_start( "training_lodge_exit" );
    setup_allies( "training_lodge_exit" );
    common_scripts\utility::flag_set( "training_lodge_exit_lighting" );
    common_scripts\utility::flag_set( "training_s1_living_room_return" );
    common_scripts\utility::flag_set( "training_s1_breach_done" );
    common_scripts\utility::flag_set( "training_s1_flag_drone_hallway" );
    maps\recovery_code::camp_david_play_videos();
}

training_golf_course()
{
    soundscripts\_snd::snd_message( "start_training_01_golf_course" );
    maps\_shg_utility::move_player_to_start( "training_golf_course" );
    setup_allies( "training_golf_course" );
    common_scripts\utility::flag_set( "training_golf_course_lighting" );
    common_scripts\utility::flag_set( "training_s1_hide" );
    common_scripts\utility::flag_set( "training_s1_patio_clear" );
}

training_end()
{
    soundscripts\_snd::snd_message( "start_training_01_end" );
    maps\_shg_utility::move_player_to_start( "training_end" );
    setup_allies( "training_end" );
    common_scripts\utility::flag_set( "training_s1_start_escape_vehicle" );
    common_scripts\utility::flag_set( "training_s1_allow_escape" );
    common_scripts\utility::flag_set( "training_end_lighting" );
}

tour_ride_begin()
{
    soundscripts\_snd::snd_message( "start_tour_ride" );
    maps\_shg_utility::move_player_to_start( "tour_ride_begin" );
    setup_allies( "tour_ride_begin" );
    common_scripts\utility::flag_set( "start_tour_ride" );
    common_scripts\utility::flag_set( "tour_ride_begin_lighting" );
    common_scripts\utility::flag_set( "training_remove_player_weapons" );
    common_scripts\utility::flag_set( "training_s1_start_escape_vehicle" );
    common_scripts\utility::flag_set( "training_s1_end" );
}

tour_exo_begin()
{
    soundscripts\_snd::snd_message( "start_tour_exo" );
    maps\_shg_utility::move_player_to_start( "tour_exo_begin" );
    setup_allies( "tour_exo_begin" );
    common_scripts\utility::flag_set( "flag_gideon_use_custom_anim_set" );
    common_scripts\utility::flag_set( "tour_exo_begin_lighting" );
    common_scripts\utility::flag_set( "tour_exo_begin" );
    common_scripts\utility::flag_set( "tour_ambient_00" );

    if ( level.currentgen )
        common_scripts\utility::flag_set( "tff_tour_ride_over" );
}

tour_exo_exit()
{
    soundscripts\_snd::snd_message( "start_tour_exo_exit" );
    maps\_shg_utility::move_player_to_start( "tour_exo_exit" );
    setup_allies( "tour_exo_exit" );
    common_scripts\utility::flag_set( "flag_gideon_use_custom_anim_set" );
    common_scripts\utility::flag_set( "tour_exo_exit_lighting" );
    common_scripts\utility::flag_set( "tour_exo_exit" );
    common_scripts\utility::flag_set( "tour_exo_hangar" );
    common_scripts\utility::flag_set( "tour_ambient_00" );

    if ( level.currentgen )
        common_scripts\utility::flag_set( "tff_tour_ride_over" );
}

tour_firing_range()
{
    soundscripts\_snd::snd_message( "start_tour_firing_range" );
    maps\_shg_utility::move_player_to_start( "tour_firing_range" );
    setup_allies( "tour_firing_range" );
    common_scripts\utility::flag_set( "flag_gideon_use_custom_anim_set" );
    common_scripts\utility::flag_set( "tour_firing_range" );
    common_scripts\utility::flag_set( "tour_firing_range_lighting" );
    common_scripts\utility::flag_set( "tour_ambient_00" );

    if ( level.currentgen )
        common_scripts\utility::flag_set( "tff_tour_ride_over" );
}

tour_augmented_reality()
{
    soundscripts\_snd::snd_message( "start_tour_augmented_reality" );
    maps\_shg_utility::move_player_to_start( "tour_augmented_reality" );
    setup_allies( "tour_augmented_reality" );
    common_scripts\utility::flag_set( "flag_gideon_use_custom_anim_set" );
    common_scripts\utility::flag_set( "tour_augmented_reality_lighting" );
    common_scripts\utility::flag_set( "tour_ambient_00" );
    common_scripts\utility::flag_set( "flag_enable_overdrive" );

    if ( level.currentgen )
        common_scripts\utility::flag_set( "tff_tour_ride_over" );
}

tour_end()
{
    soundscripts\_snd::snd_message( "start_tour_end" );
    maps\_shg_utility::move_player_to_start( "tour_end" );
    setup_allies( "tour_end" );
    common_scripts\utility::flag_set( "flag_gideon_use_custom_anim_set" );
    common_scripts\utility::flag_set( "tour_end_lighting" );
    common_scripts\utility::flag_set( "flag_enable_overdrive" );
    maps\_variable_grenade::give_player_variable_grenade();
    level notify( "variable_grenades_acquired_initial" );
    common_scripts\utility::flag_set( "tour_ambient_00" );

    if ( level.currentgen )
        common_scripts\utility::flag_set( "tff_tour_ride_over" );
}

training_2_begin()
{
    maps\_shg_utility::move_player_to_start( "training_2_begin" );
    common_scripts\utility::flag_set( "flag_enable_overdrive" );
    common_scripts\utility::flag_set( "training_2_begin" );
    common_scripts\utility::flag_set( "training_s2_ready" );
    common_scripts\utility::flag_set( "training_2_begin_lighting" );
    set_up_player_s2();
    maps\recovery_code::training_s2_opening();
    soundscripts\_snd::snd_message( "start_training_02" );
}

training_2_lodge_begin()
{
    soundscripts\_snd::snd_message( "start_training_02_lodge" );
    maps\_shg_utility::move_player_to_start( "training_2_lodge_begin" );
    common_scripts\utility::flag_set( "flag_enable_overdrive" );
    setup_allies( "training_2_lodge_begin" );
    common_scripts\utility::flag_set( "training_s2_living_room_approach" );
    common_scripts\utility::flag_set( "training_2_lodge_begin_lighting" );
    maps\_player_exo::batteryfillmax();
    maps\_utility::activate_trigger( "training_s2_color_entrance_trigger", "targetname" );
    maps\recovery_code::camp_david_play_videos();
}

training_2_lodge_breach()
{
    soundscripts\_snd::snd_message( "start_training_02_lodge_breach" );
    maps\_shg_utility::move_player_to_start( "training_2_lodge_breach" );
    common_scripts\utility::flag_set( "flag_enable_overdrive" );
    setup_allies( "training_2_lodge_breach" );
    common_scripts\utility::flag_set( "training_s2_prep_breach" );
    common_scripts\utility::flag_set( "training_s2_mute_breach_setup" );
    common_scripts\utility::flag_set( "training_2_lodge_breach_lighting" );
    common_scripts\utility::flag_set( "training_s2_spawn_breach_door" );
    common_scripts\utility::flag_set( "training_s2_mute_breach_enabled" );
    maps\_player_exo::batteryfillmax();
    maps\recovery_code::camp_david_play_videos();
}

training_2_lodge_exit()
{
    soundscripts\_snd::snd_message( "start_training_02_lodge_exit" );
    maps\_shg_utility::move_player_to_start( "training_2_lodge_exit" );
    common_scripts\utility::flag_set( "flag_enable_overdrive" );
    setup_allies( "training_2_lodge_exit" );
    common_scripts\utility::flag_set( "training_s2_drone_attack_setup" );
    common_scripts\utility::flag_set( "training_s2_breach_done" );
    common_scripts\utility::flag_set( "training_2_lodge_exit_lighting" );
    maps\_player_exo::batteryfillmax();
    maps\recovery_code::camp_david_play_videos();
}

training_2_golf_course()
{
    soundscripts\_snd::snd_message( "start_training_02_golf_course" );
    maps\_shg_utility::move_player_to_start( "training_2_golf_course" );
    common_scripts\utility::flag_set( "flag_enable_overdrive" );
    setup_allies( "training_2_golf_course" );
    common_scripts\utility::flag_set( "training_2_golf_course_lighting" );
    common_scripts\utility::flag_set( "training_2_golf_course_lighting" );
    common_scripts\utility::flag_set( "training_s2_start_enter_patio" );
    common_scripts\utility::flag_set( "flag_training_s2_squad_advance_golf_course" );
    maps\_player_exo::batteryfillmax();
    maps\_utility::activate_trigger( "training_s2_golf_course_cover", "targetname" );
}

training_2_end()
{
    soundscripts\_snd::snd_message( "start_training_02_end" );
    maps\_shg_utility::move_player_to_start( "training_2_end" );
    common_scripts\utility::flag_set( "flag_enable_overdrive" );
    setup_allies( "training_2_end" );
    common_scripts\utility::flag_set( "training_2_end_lighting" );
    maps\_utility::activate_trigger( "training_s2_color_trigger_escape", "targetname" );
    maps\_player_exo::batteryfillmax();
    common_scripts\utility::flag_set( "training_s2_start_warbird" );
}

setup_precache()
{
    precacherumble( "damage_heavy" );
    precacherumble( "damage_light" );
    precacherumble( "heavy_1s" );
    precacherumble( "heavy_2s" );
    precacherumble( "heavy_3s" );
    precacherumble( "light_1s" );
    precacherumble( "light_2s" );
    precacherumble( "light_3s" );
    precacherumble( "defaultweapon_fire" );
    precacherumble( "defaultweapon_melee" );
    precacherumble( "tank_rumble" );
    precacherumble( "grenade_rumble" );
    precacherumble( "viewmodel_small" );
    precacherumble( "viewmodel_medium" );
    precacherumble( "viewmodel_large" );
    precacherumble( "silencer_fire" );
    precacherumble( "steady_rumble" );
    precacherumble( "steady_h" );
    precacherumble( "steady_l" );
    // precacheshellshock( "iw5_titan45_sp" );
    // precacheshellshock( "iw5_titan45_sp_silencerpistol" );
    // precacheshellshock( "iw5_titan45_sp_opticstargetenhancer" );
    // precacheshellshock( "iw5_m990_sp_m990scope" );
    // precacheshellshock( "iw5_hmr9_sp" );
    // precacheshellshock( "iw5_uts19_sp" );
    // precacheshellshock( "iw5_bal27_sp" );
    // precacheshellshock( "iw5_bal27_sp_opticstargetenhancer" );
    // precacheshellshock( "iw5_bal27_sp_silencer01_variablereddot" );
    // precacheshellshock( "iw5_bal27_sp_variablereddot" );
    // precacheshellshock( "iw5_bal27_sp_opticsthermal" );
    precacheshellshock( "iw5_himar_sp" );
    precacheshellshock( "iw5_m182spr_sp" );
    precacheshellshock( "iw5_ak12_sp" );
    precacheshellshock( "iw5_gm6_sp" );
    precacheshellshock( "iw5_hbra3_sp" );
    precacheshellshock( "iw5_unarmed_nullattach" );
    // precacheshellshock( "smoke_grenade_cheap" );
    precachemodel( "genericprop" );
    precachemodel( "worldhands_atlas_pmc_smp" );
    precachemodel( "head_hero_gideon_mask_down" );
    precachemodel( "viewbody_atlas_pmc_smp_custom" );

    if ( level.nextgen )
        precachemodel( "viewbody_atlas_pmc_smp_custom_noscreen" );

    precachemodel( "viewbody_marines_dress" );
    precachemodel( "vb_civilian_mitchell" );
    precachemodel( "viewhands_atlas_pmc_smp" );
    precachemodel( "head_urban_civ_female_a" );
    precachemodel( "civ_urban_female_body_f" );
    precachemodel( "body_complete_civilian_suit_male_1" );
    precachemodel( "rec_irons_card" );
    precachemodel( "rec_flag_folded_01" );
    precachemodel( "npc_hbra3_base" );
    precachemodel( "rec_elevator" );
    precachemodel( "npc_m990_base_loot" );
    precachemodel( "kva_body_assault" );
    precachemodel( "atlas_pmc_body" );
    precachemodel( "rec_holo_emitter_floor_on" );
    precachemodel( "rec_holo_emitter_floor_off" );
    precachemodel( "vm_bal27_base_black" );
    precachemodel( "rec_cd_window_blinds_D_01_a" );
    precachemodel( "rec_cd_window_blinds_D_01_b" );
    precachemodel( "rec_cd_window_blinds_D_01_c" );
    precachemodel( "Rec_cd_window_blinds_DSTRY_01" );
    precachemodel( "weapon_spyderco_folding_knife" );
    precachemodel( "rec_zip_cuffs" );
    precachemodel( "dem_tablet_pc_01" );
    precachemodel( "vehicle_rec_walker_tank" );
    precachemodel( "npc_sentry_minigun_turret_base" );
    precachemodel( "prop_exo_riot_shield_B" );
    precachemodel( "npc_exo_riot_shield_B" );

    if ( level.nextgen )
        precacheshader( "m/mtl_bal27_base_black_logo" );
    else
        precacheshader( "mq/mtl_bal27_base_black_logo" );

    precacheshader( "dpad_icon_drone" );
    precacheshader( "dpad_icon_drone_off" );
    maps\recovery_utility::leaderboard_precache();
}

setup_allies( var_0 )
{
    var_1 = getent( "gideon", "targetname" );
    var_1 thread maps\_utility::add_spawn_function( ::setup_gideon );
    var_2 = getent( "joker", "targetname" );
    var_2 thread maps\_utility::add_spawn_function( ::setup_joker );
    var_3 = getent( "joker2", "targetname" );
    var_3 thread maps\_utility::add_spawn_function( ::setup_joker );

    if ( isdefined( var_0 ) )
    {
        if ( var_0 == "training_begin" || var_0 == "training_lodge_begin" || var_0 == "training_lodge_breach" || var_0 == "training_lodge_exit" || var_0 == "training_golf_course" || var_0 == "training_end" )
        {
            for ( var_4 = 1; var_4 <= 4; var_4++ )
            {
                var_5 = getent( "ally_squad_member_" + var_4, "targetname" );
                var_5 thread maps\_utility::add_spawn_function( ::setup_ally_squad_member, var_4 );
            }
        }

        if ( var_0 == "training_2_begin" || var_0 == "training_2_lodge_begin" || var_0 == "training_2_lodge_breach" || var_0 == "training_2_lodge_exit" || var_0 == "training_2_golf_course" || var_0 == "training_2_end" )
        {
            for ( var_4 = 1; var_4 <= 1; var_4++ )
            {
                var_5 = getent( "ally_s2_squad_member_" + var_4, "targetname" );
                var_5 thread maps\_utility::add_spawn_function( ::setup_s2_ally_squad_member, var_4 );
            }
        }
    }

    if ( isdefined( var_0 ) )
    {
        if ( var_0 == "training_begin" )
        {
            maps\_shg_utility::spawn_friendlies( var_0, "joker", 0 );
            maps\_shg_utility::spawn_friendlies( var_0, "training_ally", 0 );
        }

        if ( var_0 == "training_lodge_begin" )
        {
            maps\_shg_utility::spawn_friendlies( var_0, "joker", 0 );
            maps\_shg_utility::spawn_friendlies( var_0, "training_ally", 0 );
            thread set_up_player_s1();
            level.joker thread training_s1_allies_setup( "lodge_begin_joker_start_point", "training_s1_end" );
            level.ally_squad_member_1 thread training_s1_allies_setup( "lodge_begin_squad_1_start_point", "training_s1_end" );
            level.ally_squad_member_2 thread training_s1_allies_setup( "lodge_begin_squad_2_start_point", "training_s1_end" );
            level.ally_squad_member_3 thread training_s1_allies_setup( "lodge_begin_squad_3_start_point", "training_s1_end" );
            level.ally_squad_member_4 thread training_s1_allies_setup( "lodge_begin_squad_4_start_point", "training_s1_end" );
            level.ally_squad_member_2.animname = "rivers";
            maps\recovery_utility::training_s1_squad_allow_run();
        }

        if ( var_0 == "training_lodge_breach" )
        {
            maps\_shg_utility::spawn_friendlies( var_0, "joker", 0 );
            maps\_shg_utility::spawn_friendlies( var_0, "training_ally", 0 );
            thread set_up_player_s1();
            level.joker thread training_s1_allies_setup( "lodge_breach_joker_start_point", "training_s1_end" );
            level.ally_squad_member_1 thread training_s1_allies_setup( "lodge_breach_squad_1_start_point", "training_s1_end" );
            level.ally_squad_member_2 thread training_s1_allies_setup( "lodge_breach_squad_2_start_point", "training_s1_end" );
            level.ally_squad_member_3 thread training_s1_allies_setup( "lodge_breach_squad_3_start_point", "training_s1_end" );
            level.ally_squad_member_4 thread training_s1_allies_setup( "lodge_breach_squad_4_start_point", "training_s1_end" );
            level.ally_squad_member_3 maps\_utility::stop_magic_bullet_shield();
            level.ally_squad_member_3 kill();
            level.ally_squad_member_2.animname = "rivers";
            maps\_utility::activate_trigger( "training_s1_color_trigger_breach", "targetname" );
            maps\recovery_utility::training_s1_squad_allow_run();
        }

        if ( var_0 == "training_lodge_exit" )
        {
            maps\_shg_utility::spawn_friendlies( var_0, "joker", 0 );
            maps\_shg_utility::spawn_friendlies( var_0, "training_ally", 0 );
            thread set_up_player_s1();
            thread spawn_president( "lodge_exit_president_start_point", "tour_exo_hangar" );
            level.joker thread training_s1_allies_setup( "lodge_exit_joker_start_point", "training_s1_end" );
            level.ally_squad_member_1 thread training_s1_allies_setup( "lodge_exit_squad_1_start_point", "training_s1_end" );
            level.ally_squad_member_2 thread training_s1_allies_setup( "lodge_exit_squad_2_start_point", "training_s1_end" );
            level.ally_squad_member_3 thread training_s1_allies_setup( "lodge_breach_squad_3_start_point", "training_s1_end" );
            level.ally_squad_member_4 thread training_s1_allies_setup( "lodge_exit_squad_4_start_point", "training_s1_end" );
            level.ally_squad_member_3 maps\_utility::stop_magic_bullet_shield();
            level.ally_squad_member_3 kill();
            level.ally_squad_member_2.animname = "rivers";
            wait 1;
            maps\recovery_utility::training_s1_squad_allow_run();
            maps\_utility::activate_trigger( "training_s1_livingroom_ambush", "targetname" );
        }

        if ( var_0 == "training_golf_course" )
        {
            maps\_shg_utility::spawn_friendlies( var_0, "joker", 0 );
            maps\_shg_utility::spawn_friendlies( var_0, "training_ally", 0 );
            thread set_up_player_s1();
            thread spawn_president( "golf_course_president_start_point", "tour_exo_hangar" );
            level.joker thread training_s1_allies_setup( "golf_course_joker_start_point", "tour_exo_hangar" );
            level.ally_squad_member_1 thread training_s1_allies_setup( "lodge_exit_squad_1_start_point", "training_s1_end" );
            level.ally_squad_member_2 thread training_s1_allies_setup( "golf_course_squad_2_start_point", "training_s1_end" );
            level.ally_squad_member_3 thread training_s1_allies_setup( "lodge_breach_squad_3_start_point", "training_s1_end" );
            level.ally_squad_member_4 thread training_s1_allies_setup( "lodge_exit_squad_4_start_point", "training_s1_end" );
            level.ally_squad_member_1 maps\_utility::stop_magic_bullet_shield();
            level.ally_squad_member_3 maps\_utility::stop_magic_bullet_shield();
            level.ally_squad_member_4 maps\_utility::stop_magic_bullet_shield();
            level.ally_squad_member_1 kill();
            level.ally_squad_member_3 kill();
            level.ally_squad_member_4 kill();
            level.ally_squad_member_2.animname = "rivers";
            wait 1;
            thread maps\recovery_utility::training_s1_squad_allow_run();
            maps\_utility::activate_trigger( "training_s1_hide_from_patrols", "targetname" );
        }

        if ( var_0 == "training_end" )
        {
            maps\_shg_utility::spawn_friendlies( var_0, "joker", 0 );
            maps\_shg_utility::spawn_friendlies( var_0, "training_ally", 0 );
            thread set_up_player_s1();
            thread spawn_president( "training_end_s1_president_start_point", "tour_exo_hangar" );
            level.joker thread training_s1_allies_setup( "training_end_s1_joker_start_point", "training_s1_end" );
            level.ally_squad_member_1 thread training_s1_allies_setup( "lodge_exit_squad_1_start_point", "training_s1_end" );
            level.ally_squad_member_2 thread training_s1_allies_setup( "training_end_s1_squad_2_start_point", "training_s1_end" );
            level.ally_squad_member_3 thread training_s1_allies_setup( "lodge_breach_squad_3_start_point", "training_s1_end" );
            level.ally_squad_member_4 thread training_s1_allies_setup( "lodge_exit_squad_4_start_point", "training_s1_end" );
            level.ally_squad_member_1 maps\_utility::stop_magic_bullet_shield();
            level.ally_squad_member_3 maps\_utility::stop_magic_bullet_shield();
            level.ally_squad_member_4 maps\_utility::stop_magic_bullet_shield();
            level.ally_squad_member_1 kill();
            level.ally_squad_member_3 kill();
            level.ally_squad_member_4 kill();
            level.ally_squad_member_2.animname = "rivers";
            wait 1;
            thread maps\recovery_utility::training_s1_squad_allow_run();
            maps\_utility::activate_trigger( "training_s1_color_trigger_escape_car", "targetname" );
        }

        if ( var_0 == "tour_exo_begin" || var_0 == "tour_exo_exit" || var_0 == "tour_firing_range" || var_0 == "tour_augmented_reality" || var_0 == "tour_end" )
        {
            maps\_shg_utility::spawn_friendlies( var_0, "gideon", 0 );
            var_6 = common_scripts\utility::getstruct( var_0, "targetname" );
            level.gideon teleport( var_6.origin + anglestoforward( var_6.angles ) * 200, var_6.angles );
            level.gideon maps\_utility::gun_remove();
        }

        if ( var_0 == "tour_exo_begin" || var_0 == "tour_exo_exit" || var_0 == "tour_firing_range" )
            thread set_up_player_gundown();

        if ( var_0 == "tour_augmented_reality" || var_0 == "tour_end" )
            thread set_up_player_s2();

        if ( var_0 == "training_2_begin" )
        {
            if ( !isdefined( level.gideon ) )
                maps\_shg_utility::spawn_friendlies( var_0, "gideon", 0 );

            maps\_shg_utility::spawn_friendlies( var_0, "training_s2_ally", 0 );
        }

        if ( var_0 == "training_2_lodge_begin" )
        {
            maps\_shg_utility::spawn_friendlies( var_0, "gideon", 0 );
            maps\_shg_utility::spawn_friendlies( var_0, "joker2", 0 );
            maps\_shg_utility::spawn_friendlies( var_0, "training_s2_ally", 0 );
            thread set_up_player_s2();
            level.gideon thread training_s2_allies_setup( "lodge_begin_gideon_start_point" );
            level.joker thread training_s2_allies_setup( "lodge_begin_s2_squad_1_start_point" );
            level.ally_s2_squad_member_1 thread training_s2_allies_setup( "lodge_begin_s2_squad_2_start_point" );
            maps\recovery_utility::training_s2_squad_allow_run();
        }

        if ( var_0 == "training_2_lodge_breach" )
        {
            maps\_shg_utility::spawn_friendlies( var_0, "gideon", 0 );
            maps\_shg_utility::spawn_friendlies( var_0, "joker2", 0 );
            maps\_shg_utility::spawn_friendlies( var_0, "training_s2_ally", 0 );
            thread set_up_player_s2();
            level.gideon thread training_s2_allies_setup( "lodge_breach_gideon_start_point" );
            level.joker thread training_s2_allies_setup( "lodge_breach_s2_squad_1_start_point" );
            level.ally_s2_squad_member_1 thread training_s2_allies_setup( "lodge_breach_s2_squad_2_start_point" );
            maps\recovery_utility::training_s2_squad_allow_run();
        }

        if ( var_0 == "training_2_lodge_exit" )
        {
            maps\_shg_utility::spawn_friendlies( var_0, "gideon", 0 );
            maps\_shg_utility::spawn_friendlies( var_0, "joker2", 0 );
            maps\_shg_utility::spawn_friendlies( var_0, "training_s2_ally", 0 );
            thread set_up_player_s2();
            thread spawn_president_s2( "lodge_exit_president_start_point" );
            level.gideon thread training_s2_allies_setup( "lodge_exit_gideon_start_point" );
            level.joker thread training_s2_allies_setup( "lodge_s2_exit_squad_1_start_point" );
            level.ally_s2_squad_member_1 thread training_s2_allies_setup( "lodge_s2_exit_squad_2_start_point" );
            wait 1;
            maps\recovery_utility::training_s2_squad_allow_run();
            maps\_utility::activate_trigger( "training_s2_enter_drone_attack", "targetname" );
        }

        if ( var_0 == "training_2_golf_course" )
        {
            maps\_shg_utility::spawn_friendlies( var_0, "gideon", 0 );
            maps\_shg_utility::spawn_friendlies( var_0, "joker2", 0 );
            maps\_shg_utility::spawn_friendlies( var_0, "training_s2_ally", 0 );
            thread set_up_player_s2();
            thread spawn_president_s2( "golf_course_president_start_point" );
            level.gideon thread training_s2_allies_setup( "golf_course_gideon_start_point" );
            level.joker thread training_s2_allies_setup( "golf_course_s2_squad_1_start_point" );
            level.ally_s2_squad_member_1 thread training_s2_allies_setup( "golf_course_s2_squad_2_start_point" );
            wait 1;
            maps\recovery_utility::training_s2_squad_allow_run();
            maps\_utility::activate_trigger( "training_s2_golf_course_cover", "targetname" );
        }

        if ( var_0 == "training_2_end" )
        {
            maps\_shg_utility::spawn_friendlies( var_0, "gideon", 0 );
            maps\_shg_utility::spawn_friendlies( var_0, "joker2", 0 );
            maps\_shg_utility::spawn_friendlies( var_0, "training_s2_ally", 0 );
            thread set_up_player_s2();
            level.gideon thread training_s2_allies_setup( "training2_end_gideon_start_point" );
            level.joker thread training_s2_allies_setup( "training_end_s2_squad_1_start_point" );
            level.ally_s2_squad_member_1 thread training_s2_allies_setup( "training_end_s2_squad_2_start_point" );
            maps\recovery_utility::training_s2_squad_allow_run();
        }
        else
        {

        }
    }
    else
    {

    }
}

set_up_player_s1()
{
    level.player giveweapon( "iw5_bal27_sp_silencer01_variablereddot" );
    level.player giveweapon( "iw5_titan45_sp_silencerpistol" );
    maps\_variable_grenade::give_player_variable_grenade();
    maps\_variable_grenade::set_variable_grenades_with_no_switch( "tracking_grenade_var", "paint_grenade_var" );
    level.player switchtoweaponimmediate( "iw5_bal27_sp_silencer01_variablereddot" );

    if ( level.nextgen )
        level.player overrideviewmodelmaterial( "m/mtl_bal27_base_black", "m/mtl_bal27_base_black_logo" );
    else
        level.player overrideviewmodelmaterial( "mq/mtl_bal27_base_black", "mq/mtl_bal27_base_black_logo" );

    level.player enableweapons();
    level.player allowfire( 1 );
    level.player allowads( 1 );
    level.player allowmelee( 1 );
}

training_s1_allies_setup( var_0, var_1 )
{
    self endon( "death" );
    var_2 = common_scripts\utility::getstruct( var_0, "targetname" );
    self forceteleport( var_2.origin, var_2.angles );
    self setgoalpos( self.origin );
    maps\_utility::forceuseweapon( "iw5_bal27_sp_silencer01_variablereddot", "primary" );
    maps\_utility::disable_surprise();

    if ( !isdefined( level.allies_s1 ) )
        level.allies_s1 = [];

    level.allies_s1 = common_scripts\utility::array_add( level.allies_s1, self );
    common_scripts\utility::flag_wait( var_1 );

    if ( isdefined( self.magic_bullet_shield ) )
        maps\_utility::stop_magic_bullet_shield();

    maps\recovery_utility::bloody_death();
}

training_s2_allies_setup( var_0 )
{
    var_1 = common_scripts\utility::getstruct( var_0, "targetname" );
    self forceteleport( var_1.origin, var_1.angles );
    self setgoalpos( self.origin );
    maps\_utility::disable_surprise();

    if ( !isdefined( level.allies_s2 ) )
        level.allies_s2 = [];

    level.allies_s2 = common_scripts\utility::array_add( level.allies_s2, self );
}

spawn_president( var_0, var_1 )
{
    var_2 = getent( "training_s1_president_spawner", "targetname" );
    level.president = var_2 maps\_utility::spawn_ai( 1 );
    level.president maps\_president::set_president_anims();
    level.president thread set_up_president( var_0, var_1 );
}

set_up_president( var_0, var_1 )
{
    self endon( "death" );
    maps\_utility::magic_bullet_shield();
    self.animname = "president";
    self.ignoreme = 1;
    maps\_utility::set_battlechatter( 0 );
    self.team = "allies";
    maps\_utility::clear_color_order( "y", "allies" );
    maps\_utility::set_force_color( "y" );
    var_2 = common_scripts\utility::getstruct( var_0, "targetname" );
    self forceteleport( var_2.origin, var_2.angles );
    common_scripts\utility::flag_wait( var_1 );
    maps\_utility::stop_magic_bullet_shield();
    self delete();
}

spawn_president_s2( var_0 )
{
    var_1 = getent( "training_s2_president_spawner", "targetname" );
    level.president = var_1 maps\_utility::spawn_ai( 1 );
    level.president maps\_president::set_president_anims();
    level.president thread set_up_president_s2( var_0 );
}

set_up_president_s2( var_0 )
{
    self endon( "death" );
    maps\_utility::magic_bullet_shield();
    self.animname = "president";
    self.name = "POTUS";
    self.ignoreme = 1;
    maps\_utility::set_battlechatter( 0 );
    self.team = "allies";
    maps\_utility::clear_color_order( "y", "allies" );
    maps\_utility::set_force_color( "y" );
    var_1 = common_scripts\utility::getstruct( var_0, "targetname" );
    self forceteleport( var_1.origin, var_1.angles );
    self setgoalpos( self.origin );
}

set_up_player_gundown()
{
    level.player takeallweapons();
    common_scripts\utility::flag_set( "flag_disable_exo" );
    level.player allowfire( 0 );
    level.player allowads( 0 );
    level.player allowmelee( 0 );
}

set_up_player_s2()
{
    level.player takeallweapons();
    level.player giveweapon( "iw5_titan45_sp" );
    level.player giveweapon( "iw5_bal27_sp_variablereddot" );
    level.player switchtoweaponimmediate( "iw5_bal27_sp_variablereddot" );

    if ( level.nextgen )
        level.player overrideviewmodelmaterial( "m/mtl_bal27_base_black", "m/mtl_bal27_base_black_logo" );
    else
        level.player overrideviewmodelmaterial( "mq/mtl_bal27_base_black", "mq/mtl_bal27_base_black_logo" );

    level.player enableweapons();
    level.player allowfire( 1 );
    level.player allowads( 1 );
    level.player allowmelee( 1 );
    maps\_variable_grenade::give_player_variable_grenade();
}

setup_joker()
{
    level.joker = self;
    level.joker.script_pushable = 0;
    self.animname = "joker";
    thread maps\_utility::magic_bullet_shield();
}

setup_gideon()
{
    level.gideon = self;
    level.gideon.script_pushable = 0;
    self.animname = "gideon";
    thread maps\_utility::magic_bullet_shield();
    thread gideon_anim_set_manager();
}

gideon_outfit_manager()
{
    level.gideon.outfit_initial = level.gideon.model;
    // level.gideon setmodel( "kva_body_assault" );
    common_scripts\utility::flag_wait( "arm_swapped" );

    // if ( isdefined( level.gideon.outfit_initial ) )
    //     level.gideon setmodel( level.gideon.outfit_initial );
}

disable_gideon_jog_when_turning()
{
    for (;;)
    {
        level.gideon waittill( "turn_start" );
        common_scripts\utility::flag_clear( "gideon_jog_and_speedup" );
        level.gideon waittill( "turn_end" );
        wait 0.25;
        common_scripts\utility::flag_set( "gideon_jog_and_speedup" );
    }
}

#using_animtree("generic_human");

speed_up_gideon_when_u_cant_see_him()
{
    level endon( "speed_up_gideon_when_u_cant_see_him_stop" );
    wait 3;
    childthread disable_gideon_jog_when_turning();
    var_0 = %bet_unarmed_casual_walk01_gideon;
    var_1 = %rec_gideon_unarmed_jog;
    var_2 = gettime();

    for (;;)
    {
        if ( !isdefined( level.gideon ) || isremovedentity( level.gideon ) )
        {
            iprintlnbold( "Warning : Gideon ent is removed or not defined!" );
            waitframe();
            continue;
        }

        if ( !common_scripts\utility::flag( "gideon_jog_and_speedup" ) )
            common_scripts\utility::flag_wait( "gideon_jog_and_speedup" );

        var_3 = level.player maps\_utility::player_looking_at( level.gideon geteye(), 0.6 );
        var_4 = level.gideon geteye() - level.player geteye();
        var_5 = length( var_4 );
        var_6 = vectornormalize( level.gideon.goalpos - level.gideon.origin );
        var_7 = vectordot( var_6, vectornormalize( level.gideon.lookaheaddir ) );
        var_8 = length( level.gideon.goalpos - level.gideon.origin );

        if ( var_8 > 300 && var_7 > 0.75 && var_2 > 2000 )
            level.gideon.run_overrideanim = var_1;
        else
        {
            level.gideon.run_overrideanim = var_0;
            var_2 = gettime();
        }

        if ( !var_3 && var_5 > 500 )
        {
            var_9 = 1;

            if ( var_5 > 700 )
                var_9 = 1.75;
            else if ( var_5 > 500 )
                var_9 = 1.5;

            var_10 = level.gideon getactiveanimations();

            foreach ( var_12 in var_10 )
            {
                if ( var_12["animation"] == var_1 )
                    level.gideon setanimrate( var_12["animation"], var_9 );
            }
        }

        waitframe();
    }
}

gideon_anim_set_manager()
{
    common_scripts\utility::flag_wait( "flag_gideon_use_custom_anim_set" );
    common_scripts\utility::flag_set( "gideon_jog_and_speedup" );
    thread speed_up_gideon_when_u_cant_see_him();
    level.gideon maps\_urgent_walk::set_urgent_walk_anims();
    common_scripts\utility::flag_waitopen( "flag_gideon_use_custom_anim_set" );
    level notify( "speed_up_gideon_when_u_cant_see_him_stop" );
    level.gideon maps\_urgent_walk::clear_urgent_walk_anims();
}

training_s1_startpoint_guy_think( var_0, var_1 )
{
    self endon( "death" );
    var_2 = common_scripts\utility::getstruct( var_0, "targetname" );
    self forceteleport( var_2.origin, var_2.angles );
    self setgoalpos( self.origin );
    maps\_stealth_utility::stealth_plugin_basic();
    maps\_stealth_utility::stealth_plugin_accuracy();
    maps\_stealth_utility::stealth_plugin_smart_stance();
    maps\_utility::forceuseweapon( "iw5_bal27_sp_silencer01_variablereddot", "primary" );
    common_scripts\utility::flag_wait( var_1 );

    if ( isdefined( self.magic_bullet_shield ) )
        maps\_utility::stop_magic_bullet_shield();

    maps\recovery_utility::bloody_death();
}

training_s2_startpoint_guy_think( var_0 )
{
    var_1 = common_scripts\utility::getstruct( var_0, "targetname" );
    self forceteleport( var_1.origin, var_1.angles );
    self setgoalpos( self.origin );
    maps\_stealth_utility::stealth_plugin_basic();
    maps\_stealth_utility::stealth_plugin_accuracy();
    maps\_stealth_utility::stealth_plugin_smart_stance();
    maps\_utility::forceuseweapon( "iw5_bal27_sp_silencer01_variablereddot", "primary" );
}

setup_ally_squad_member( var_0 )
{
    switch ( var_0 )
    {
        case 1:
            level.ally_squad_member_1 = self;
            break;
        case 2:
            level.ally_squad_member_2 = self;
            level.ally_squad_member_2.animname = "rivers";
            break;
        case 3:
            level.ally_squad_member_3 = self;
            break;
        case 4:
            level.ally_squad_member_4 = self;
            break;
        default:
            break;
    }

    self.animname = "ally_squad_member_" + var_0;
    thread maps\_utility::magic_bullet_shield();
}

setup_s2_ally_squad_member( var_0 )
{
    switch ( var_0 )
    {
        case 1:
            level.ally_s2_squad_member_1 = self;
            maps\_utility::clear_color_order( "o", "allies" );
            level.ally_s2_squad_member_1 maps\_utility::set_force_color( "o" );
            break;
        case 2:
            level.ally_s2_squad_member_2 = self;
            break;
        case 3:
            level.ally_s2_squad_member_3 = self;
            break;
        case 4:
            level.ally_s2_squad_member_4 = self;
            break;
        default:
            break;
    }

    self.animname = "ally_s2_squad_member_" + var_0;
    thread maps\_utility::magic_bullet_shield();
}

setup_portal_scripting()
{
    thread maps\_shg_utility::portal_group_on( "training_s1_flag_doors_open", "portal_hangar_door" );
    thread maps\_shg_utility::portal_group_off( "training_s2_ready", "portal_hangar_door" );
}

tv_movie2()
{
    setsaveddvar( "cg_cinematicFullScreen", "0" );
    cinematicingameloop( "business_card_master" );
}
