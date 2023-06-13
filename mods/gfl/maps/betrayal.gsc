// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    maps\_utility::template_level( "betrayal" );
    precache_main();
    init_level_flags();
    init_vo_flags();
    init_lighting_flags();
    setup_start_points();
    setsaveddvar( "r_hudoutlineenable", 1 );

    if ( level.currentgen )
    {
        setsaveddvar( "r_gunSightColorEntityScale", "7" );
        setsaveddvar( "r_gunSightColorNoneScale", "0.8" );
        maps\_utility::tff_sync_setup();
    }

    forcesharedammo();
    maps\createart\betrayal_art::main();
    maps\betrayal_fx::main();
    maps\betrayal_precache::main();
    maps\_load::main();
    thread maps\_player_exo::main( "specialist" );
    maps\betrayal_lighting::main2();
    maps\betrayal_aud::main();
    maps\betrayal_anim::main();
    maps\_variable_grenade::main();
    maps\_drone_civilian::init();
    maps\_drone_ai::init();
    maps\_exo_climb::main( "atlas_army" );
    level.scr_model["player_climb_rig"] = "s1_gfl_ump45_viewbody";
    level.player.exo_climb_overrides = spawnstruct();
    level.player.exo_climb_overrides.idle_look_sideways_limit_mag = 50;
    level.player.exo_climb_overrides.idle_look_down_limit_mag = 30;
    maps\_exo_punch_door::exo_door_init();
    maps\_microwave_grenade::main();
    maps\_grapple::main( "s1_gfl_ump45_viewbody", "s1_gfl_ump45_viewhands" );
    level.player.grapple["dist_max"] = 750;
    level.player.no_breath_hud = 1;
    level.player.drowning_deadquote = &"BETRAYAL_DEATH_BY_DROWNING";
    level.player.drowning_warning = &"BETRAYAL_DROWNING_WARNING_HINT";
    level.player.drowning_damage = 12;
    level.player maps\_water::init( "s1_gfl_ump45_viewhands_player" );
    level.underwater_visionset_callback = maps\betrayal_lighting::underwater_visionset_change;
    maps\betrayal_vo::prepare_dialog();
    thread maps\betrayal_vo::play_dialog();
    thread global_spawn_functions();
    maps\betrayal_util::civilian_init_props();
    level.default_goalradius = 512;
    level.friendlyfire["friend_kill_points"] = -500;

    if ( level.currentgen )
    {
        setup_tff_transitions();
        setup_tff_cleanups();
    }

    level thread betrayal_intro_screen();
    setupbetrayalportalscripting();
}

betrayal_intro_screen()
{
    if ( !isdefined( level.start_point ) || level.start_point == "atlas_building_lobby" )
    {
        level thread maps\_shg_utility::play_chyron_video( "chyron_text_betrayal", 2, 2 );
        common_scripts\utility::flag_wait( "chyron_video_done" );
        common_scripts\utility::flag_set( "flag_office_start_intro_pcap" );
    }
    else
        thread maps\_introscreen::introscreen_generic_black_fade_in( 2, 2 );
}

precache_main()
{
    precacheshellshock( "flash_grenade" );
    precachestring( &"BETRAYAL_OBJ_FOLLOW_GIDEON" );
    precachestring( &"BETRAYAL_OBJ_ESCAPE_ATLAS" );
    precachestring( &"BETRAYAL_OBJ_FOLLOW_ILONA" );
    precachestring( &"BETRAYAL_OBJ_ESCAPE_OLDTOWN" );
    precachestring( &"BETRAYAL_OBJ_KILL_MECH" );
    precachestring( &"BETRAYAL_OBJ_BOAT_GOAL" );
    precachestring( &"BETRAYAL_OBJ_CLIMB_EXTRACTION" );
    precachestring( &"BETRAYAL_USE" );
    precachestring( &"BETRAYAL_OPEN" );
    precachestring( &"BETRAYAL_CLIMB" );
    precachestring( &"BETRAYAL_DESTROY" );
    precachestring( &"BETRAYAL_MANTLE" );
    precachestring( &"BETRAYAL_BOAT_ENTER" );
    precachestring( &"BETRAYAL_CRANE_TRIGGER_HINT" );
    maps\_utility::add_control_based_hint_strings( "boat_gas", &"BETRAYAL_BOAT_HINT_GAS", ::player_boat_gas );
    maps\_utility::add_control_based_hint_strings( "boat_dive", &"BETRAYAL_BOAT_HINT_DIVE", ::player_boat_dive );
    maps\_utility::add_hint_string( "leaving_mission_area", &"BETRAYAL_WARN_LEAVE_MISSION_AREA" );
    maps\_utility::add_control_based_hint_strings( "leaving_mission_area_trigger", &"BETRAYAL_WARN_LEAVE_MISSION_AREA", ::leaving_mission_area_while_in_trig );
    maps\_utility::add_control_based_hint_strings( "player_moved_forward", &"BETRAYAL_MAG_CLIMB_HINT", ::player_moved_forward, &"BETRAYAL_MAG_CLIMB_HINT_CRANE_PC", &"BETRAYAL_MAG_CLIMB_HINT_SP" );
    maps\_utility::add_control_based_hint_strings( "grapple", &"BETRAYAL_GRAPPLE_HINT", ::player_used_grapple );
    precachemodel( "security_lock_01_unlocked_glow" );
    precachemodel( "security_lock_01_unlocked" );
    precachemodel( "btr_elevator_vent_cover_a_closed" );
    precachemodel( "electronics_pda" );
    precachemodel( "com_cellphone_on" );
    precachemodel( "prop_cigarette" );
    precachemodel( "lab_tablet_flat_on" );
    precachemodel( "cs_coffeemug02" );
    precachemodel( "com_metal_briefcase" );
    precachemodel( "paper_memo" );
    precachemodel( "open_book" );
    precachemodel( "genericprop" );
    precachemodel( "hjk_metal_briefcase" );
    precachemodel( "electronics_pda_big" );
    precachemodel( "ma_cup_single_closed" );
    precachemodel( "deployable_cover" );
    precachemodel( "vehicle_mobile_cover" );
    precacheshellshock( "iw5_mahemcustombetrayalboatdive_sp" );
    precacheshellshock( "iw5_bal27_sp" );
    precacheshellshock( "iw5_unarmed_nullattach" );
    precacheshellshock( "betrayal_missile_small_harass" );
    precacheshellshock( "betrayal_missile_small_lethal" );
    precacheshellshock( "iw5_sn6_sp" );
    precachemodel( "npc_flash_grenade" );
    precachemodel( "irons_casual_nogun" );
    precachemodel( "npc_mp443_nocamo" );
    precachemodel( "lag_harmonic_breach_device" );
    precachemodel( "dem_irons_chair_01_cloaktrans" );
    precachemodel( "dem_irons_guest_chair_01_rig_cloaktrans" );
    precachemodel( "dr_mwi_body_cloaktrans" );
    precachemodel( "irons_casual_cloaktrans" );
    precacheshader( "overlay_static" );
    precachemodel( "btr_sewer_cover_01_rig" );
    precacheshellshock( "javelin" );
    precachemodel( "vm_grapple_launcher_base_lodvm" );
    precachemodel( "viewbody_atlas_military_smp_grapple" );
    precachemodel( "ilana_atlas_pmc_launcher" );
    precachemodel( "btr_construction_crate_with_door_anim_01_exterior" );
    precachemodel( "btr_construction_crate_with_door_anim_01_interior" );
    maps\_exo_climb::load_precache();
    animscripts\traverse\boost::precache_boost_fx_npc();
    maps\_swim_ai::init_ai_swim();
    vehicle_scripts\_attack_drone::drone_swarm_init();
    vehicle_scripts\_attack_drone_common::attack_drone_formation_init();
    precachemodel( "vehicle_mil_atlas_speedboat_glass_cracked_ai" );
    precachemodel( "body_hero_cormack_sentinel_covert_cloak" );
    precachemodel( "sentinel_covert_body_a" );

    if ( level.nextgen )
    {
        precacheshader( "m/mtl_burke_sentinel_covert_headgear_a_cloak" );
        precacheshader( "mc/mtl_burke_sentinel_covert_headgear_a_cloak" );
        precacheshader( "m/cloak_generic" );
    }
    else
    {
        precacheshader( "mq/mtl_burke_sentinel_covert_headgear_a_cloak" );
        precacheshader( "mqc/mtl_burke_sentinel_covert_headgear_a_cloak" );
        precacheshader( "mq/cloak_generic" );
    }
}

init_level_flags()
{
    common_scripts\utility::flag_init( "flag_hint_player_exoclimb_jumped" );
    common_scripts\utility::flag_init( "flag_hint_player_exoclimb_magmoved" );
    common_scripts\utility::flag_init( "flag_hint_player_exoclimb_combat" );
    common_scripts\utility::flag_init( "flag_hint_player_exoclimb_cover" );
    common_scripts\utility::flag_init( "flag_office_start_intro_pcap" );
    common_scripts\utility::flag_init( "office_scene_heli_go_1" );
    common_scripts\utility::flag_init( "flag_office_gideon_at_roof_door" );
    common_scripts\utility::flag_init( "flag_office_gideon_clear_to_move_to_roof" );
    common_scripts\utility::flag_init( "flag_office_clean_up_awards" );
    common_scripts\utility::flag_init( "flag_office_gideon_at_stairs_door" );
    common_scripts\utility::flag_init( "flag_office_gideon_ready_to_move_down_stairs" );
    common_scripts\utility::flag_init( "flag_office_gideon_scanning_door" );
    common_scripts\utility::flag_init( "flag_confrontation_give_player_real_gun" );
    common_scripts\utility::flag_init( "flag_confrontation_gideon_at_exit_door" );
    common_scripts\utility::flag_init( "flag_escape_pt1_passed" );
    common_scripts\utility::flag_init( "flag_escape_pt2_passed" );
    common_scripts\utility::flag_init( "flag_escape_irons_leaving_room" );
    common_scripts\utility::flag_init( "flag_escape_start_escape" );
    common_scripts\utility::flag_init( "flag_escape_flashbang_guards" );
    common_scripts\utility::flag_init( "flag_escape_ilana_at_door" );
    common_scripts\utility::flag_init( "flag_escape_scene_rush_door_open" );
    common_scripts\utility::flag_init( "flag_escape_clean_up_secret_room" );
    common_scripts\utility::flag_init( "flag_escape_ilana_at_climb_door" );
    common_scripts\utility::flag_init( "flag_escape_open_elevator" );
    common_scripts\utility::flag_init( "flag_escape_clean_up_hallway" );
    common_scripts\utility::flag_init( "flag_roof_player_on_roof" );
    common_scripts\utility::flag_init( "flag_roof_swarm_spawned" );
    common_scripts\utility::flag_init( "flag_roof_swarm_launched" );
    common_scripts\utility::flag_init( "flag_roof_ilona_past_fence" );
    common_scripts\utility::flag_init( "flag_roof_player_past_fence" );
    common_scripts\utility::flag_init( "flag_roof_open_mrX_blast_doors" );
    common_scripts\utility::flag_init( "flag_roof_close_mrX_blast_doors" );
    common_scripts\utility::flag_init( "flag_roof_player_has_mantled" );
    common_scripts\utility::flag_init( "roof_scene_ilana_at_escape" );
    common_scripts\utility::flag_init( "roof_scene_player_escaped" );
    common_scripts\utility::flag_init( "flag_roof_player_jumped_off_atlas_building" );
    common_scripts\utility::flag_init( "flag_roof_escape_complete" );
    common_scripts\utility::flag_init( "flag_stop_drone_magic_bullets" );
    common_scripts\utility::flag_init( "flag_swim_water_motion_on" );
    common_scripts\utility::flag_init( "flag_swim_water_player_out_of_water" );
    common_scripts\utility::flag_init( "swim_devstart" );
    common_scripts\utility::flag_init( "flag_swim_tunnel" );
    common_scripts\utility::flag_init( "flag_swim_remove_boats" );
    common_scripts\utility::flag_init( "flag_sewer_backtrack_ender" );
    common_scripts\utility::flag_init( "flag_sewer_swap_to_oldtown_swarm" );
    common_scripts\utility::flag_init( "flag_sewer_exit_drone_suprise_flag" );
    common_scripts\utility::flag_init( "flag_sewer_exit_civ_setup" );
    common_scripts\utility::flag_init( "flag_sewer_exit_player_fired_weapon" );
    common_scripts\utility::flag_init( "flag_sewer_oppression_event_start" );
    common_scripts\utility::flag_init( "flag_sewer_oppression_event_ilona_start_secret" );
    common_scripts\utility::flag_init( "flag_sewer_oppression_event_ilona_building_start" );
    common_scripts\utility::flag_init( "start_oppression_event" );
    common_scripts\utility::flag_init( "oppression_ent_completed_beat_01" );
    common_scripts\utility::flag_init( "oppression_ent_completed_beat_02" );
    common_scripts\utility::flag_init( "oppression_ent_completed_beat_03" );
    common_scripts\utility::flag_init( "flag_sewer_player_jumped_in_market" );
    common_scripts\utility::flag_init( "flag_sewer_checkpoint_guards_wakeup" );
    common_scripts\utility::flag_init( "flag_sewer_player_failed_checkpoint" );
    common_scripts\utility::flag_init( "flag_sewer_scene_transfer_to_free_run" );
    common_scripts\utility::flag_init( "flag_sewer_oldtown_intro_complete" );
    common_scripts\utility::flag_init( "flag_sewer_finish_sewer_scene_cleanup" );
    common_scripts\utility::flag_init( "rear_pressure_go" );
    common_scripts\utility::flag_init( "rear_pressure_go_setup" );
    common_scripts\utility::flag_init( "mech_start_hunt" );
    common_scripts\utility::flag_init( "oldtown_section2" );
    common_scripts\utility::flag_init( "oldtown_section3" );
    common_scripts\utility::flag_init( "oldtown_section4" );
    common_scripts\utility::flag_init( "freerun_flash_go" );
    common_scripts\utility::flag_init( "freerun_dresser_go" );
    common_scripts\utility::flag_init( "freerun_frag_go" );
    common_scripts\utility::flag_init( "freerun_micro_go" );
    common_scripts\utility::flag_init( "freerun_doorkick_enemy_go" );
    common_scripts\utility::flag_init( "freerun_doorkick_player_go" );
    common_scripts\utility::flag_init( "freerun_vis_jump_go" );
    common_scripts\utility::flag_init( "freerun_vis_jump2_go" );
    common_scripts\utility::flag_init( "freerun_cover_go" );
    common_scripts\utility::flag_init( "oldtown_dock_civ_go" );
    common_scripts\utility::flag_init( "boat_scene_start" );
    common_scripts\utility::flag_init( "oldtown_dock_flyby" );
    common_scripts\utility::flag_init( "swarm_docks_entrance" );
    common_scripts\utility::flag_init( "dock_cleanup" );
    common_scripts\utility::flag_init( "dock_cover_go" );
    common_scripts\utility::flag_init( "mech_docks_entrance" );
    common_scripts\utility::flag_init( "flag_dialogue_docks_backtrack" );
    common_scripts\utility::flag_init( "docks_end_fail_state_monitor" );
    common_scripts\utility::flag_init( "flag_boat_early_setup_complete" );
    common_scripts\utility::flag_init( "flag_boat_start_bobbing_boats" );
    common_scripts\utility::flag_init( "flag_boat_player_in_boat" );
    common_scripts\utility::flag_init( "flag_boat_chase_boats_active" );
    common_scripts\utility::flag_init( "flag_incoming_missile_warning" );
    common_scripts\utility::flag_init( "flag_climb_falling_fail" );
    common_scripts\utility::flag_init( "flag_climb_player_begin_fall_fails" );
    common_scripts\utility::flag_init( "flag_climb_searchers_at_water" );
    common_scripts\utility::flag_init( "flag_climb_warbird_on_scene" );
    common_scripts\utility::flag_init( "flag_climb_start_investigate_climb" );
    common_scripts\utility::flag_init( "flag_climb_player_discovered" );
    common_scripts\utility::flag_init( "flag_climb_warbird_engaged_player" );
    common_scripts\utility::flag_init( "flag_climb_move_warbird_to_climb" );
    common_scripts\utility::flag_init( "flag_climb_player_first_magnet_wall" );
    common_scripts\utility::flag_init( "flag_climb_warbird_rise_1" );
    common_scripts\utility::flag_init( "flag_climb_warbird_rise_2" );
    common_scripts\utility::flag_init( "flag_climb_player_off_first_magnet_wall" );
    common_scripts\utility::flag_init( "flag_climb_player_second_magnet_wall" );
    common_scripts\utility::flag_init( "flag_climb_warbird_rise_3" );
    common_scripts\utility::flag_init( "flag_climb_warbird_rise_4" );
    common_scripts\utility::flag_init( "flag_climb_player_off_second_magnet_wall" );
    common_scripts\utility::flag_init( "flag_climb_start_searcher_clean_up" );
    common_scripts\utility::flag_init( "flag_climb_player_on_mag_wall" );
    common_scripts\utility::flag_init( "flag_climb_player_at_first_onfoot" );
    common_scripts\utility::flag_init( "flag_climb_ilana_past_crate" );
    common_scripts\utility::flag_init( "flag_climb_player_at_second_climb" );
    common_scripts\utility::flag_init( "flag_climb_warbird_rise_5" );
    common_scripts\utility::flag_init( "flag_climb_warbird_rise_6" );
    common_scripts\utility::flag_init( "flag_climb_warbird_rise_7" );
    common_scripts\utility::flag_init( "flag_climb_warbird_skybridge_fly_off" );
    common_scripts\utility::flag_init( "flag_climb_player_at_magwallstart" );
    common_scripts\utility::flag_init( "flag_climb_player_at_magwalltop" );
    common_scripts\utility::flag_init( "flag_climb_player_at_skybridge" );
    common_scripts\utility::flag_init( "flag_climb_player_can_jump_to_crane" );
    common_scripts\utility::flag_init( "flag_climb_player_at_finale" );
    common_scripts\utility::flag_init( "flag_climb_player_started_moving" );
    common_scripts\utility::flag_init( "flag_climb_player_finished_first_grapple" );
    common_scripts\utility::flag_init( "flag_objective_office_scene_follow_gideon" );
    common_scripts\utility::flag_init( "flag_objective_office_scene_follow_gideon_complete" );
    common_scripts\utility::flag_init( "flag_objective_escape_scene_start" );
    common_scripts\utility::flag_init( "flag_objective_escape_scene_elevator_open" );
    common_scripts\utility::flag_init( "flag_objective_escape_scene_on_roof" );
    common_scripts\utility::flag_init( "flag_objective_escape_scene_complete" );
    common_scripts\utility::flag_init( "flag_objective_swim_scene_start" );
    common_scripts\utility::flag_init( "flag_objective_swim_scene_complete" );
    common_scripts\utility::flag_init( "flag_objective_freerun_scene_start" );
    common_scripts\utility::flag_init( "flag_objective_freerun_scene_complete" );
    common_scripts\utility::flag_init( "flag_objective_dock_scene_start" );
    common_scripts\utility::flag_init( "flag_objective_dock_scene_complete" );
    common_scripts\utility::flag_init( "flag_objective_boat_chase_start" );
    common_scripts\utility::flag_init( "flag_objective_boat_chase_complete" );
    common_scripts\utility::flag_init( "flag_objective_climb_start" );
    common_scripts\utility::flag_init( "flag_objective_climb_start_crane" );
    common_scripts\utility::flag_init( "flag_objective_climb_complete" );
    common_scripts\utility::flag_init( "flag_autofocus_on" );

    if ( level.currentgen )
        common_scripts\utility::flag_init( "flag_tff_trans_canals_to_finale" );
}

init_vo_flags()
{
    common_scripts\utility::flag_init( "flag_enable_battle_chatter" );
    common_scripts\utility::flag_init( "flag_dialogue_start_office" );
    common_scripts\utility::flag_init( "flag_dialogue_office_congrats" );
    common_scripts\utility::flag_init( "flag_dialogue_office_baghdad" );
    common_scripts\utility::flag_init( "flag_dialogue_office_kva" );
    common_scripts\utility::flag_init( "flag_dialogue_office_guard" );
    common_scripts\utility::flag_init( "flag_dialogue_office_door" );
    common_scripts\utility::flag_init( "flag_dialogue_start_confrontation" );
    common_scripts\utility::flag_init( "flag_dialog_confrontation_mrX" );
    common_scripts\utility::flag_init( "flag_dialog_confrontation_go" );
    common_scripts\utility::flag_init( "flag_dialog_confrontation_leave" );
    common_scripts\utility::flag_init( "flag_dialogue_start_escape" );
    common_scripts\utility::flag_init( "flag_dialogue_escape_intros" );
    common_scripts\utility::flag_init( "flag_dialogue_escape_guarddoor" );
    common_scripts\utility::flag_init( "flag_dialogue_escape_announce" );
    common_scripts\utility::flag_init( "flag_dialogue_escape_deadend" );
    common_scripts\utility::flag_init( "flag_dialogue_escape_climb" );
    common_scripts\utility::flag_init( "flag_dialogue_escape_swarm" );
    common_scripts\utility::flag_init( "flag_dialogue_start_roof" );
    common_scripts\utility::flag_init( "flag_dialogue_roof_swarm" );
    common_scripts\utility::flag_init( "flag_dialogue_roof_away" );
    common_scripts\utility::flag_init( "flag_dialogue_roof_run" );
    common_scripts\utility::flag_init( "flag_dialogue_roof_gates" );
    common_scripts\utility::flag_init( "flag_dialogue_roof_jump" );
    common_scripts\utility::flag_init( "flag_dialogue_roof_fall" );
    common_scripts\utility::flag_init( "flag_dialogue_start_swim" );
    common_scripts\utility::flag_init( "flag_dialogue_swim_sewer" );
    common_scripts\utility::flag_init( "flag_dialogue_swim_cough" );
    common_scripts\utility::flag_init( "flag_dialogue_start_sewer" );
    common_scripts\utility::flag_init( "flag_dialogue_sewer_guards" );
    common_scripts\utility::flag_init( "flag_dialogue_sewer_announcement" );
    common_scripts\utility::flag_init( "flag_dialogue_sewer_checkpoint" );
    common_scripts\utility::flag_init( "flag_dialogue_start_oldtown" );
    common_scripts\utility::flag_init( "flag_dialogue_oldtown_contact" );
    common_scripts\utility::flag_init( "flag_dialogue_oldtown_naglines" );
    common_scripts\utility::flag_init( "flag_dialogue_start_docks" );
    common_scripts\utility::flag_init( "flag_dialogue_docks_intro" );
    common_scripts\utility::flag_init( "flag_dialogue_docks_ast" );
    common_scripts\utility::flag_init( "flag_dialogue_docks_boat" );
    common_scripts\utility::flag_init( "flag_dialogue_docks_boatnag" );
    common_scripts\utility::flag_init( "flag_dialogue_start_boat" );
    common_scripts\utility::flag_init( "flag_dialogue_boat_grapple" );
    common_scripts\utility::flag_init( "flag_dialogue_boat_intro" );
    common_scripts\utility::flag_init( "flag_dialogue_boat_dive" );
    common_scripts\utility::flag_init( "flag_dialogue_boat_ramp" );
    common_scripts\utility::flag_init( "flag_dialogue_boat_close" );
    common_scripts\utility::flag_init( "flag_dialogue_boat_missiles" );
    common_scripts\utility::flag_init( "flag_dialogue_start_climb" );
    common_scripts\utility::flag_init( "flag_dialogue_climb_intro" );
    common_scripts\utility::flag_init( "flag_dialogue_climb_boatexit" );
    common_scripts\utility::flag_init( "flag_dialogue_climb_grapple1" );
    common_scripts\utility::flag_init( "flag_dialogue_climb_grapple2" );
    common_scripts\utility::flag_init( "flag_dialogue_climb_grapple3" );
    common_scripts\utility::flag_init( "flag_dialogue_climb_contact" );
    common_scripts\utility::flag_init( "flag_dialogue_climb_containers" );
    common_scripts\utility::flag_init( "flag_dialogue_climb_careful" );
    common_scripts\utility::flag_init( "flag_dialogue_climb_tower" );
    common_scripts\utility::flag_init( "flag_dialogue_climb_ledge" );
    common_scripts\utility::flag_init( "flag_dialogue_climb_climb" );
    common_scripts\utility::flag_init( "flag_dialogue_climb_way" );
    common_scripts\utility::flag_init( "flag_dialogue_climb_bridge" );
    common_scripts\utility::flag_init( "flag_dialogue_climb_drop" );
    common_scripts\utility::flag_init( "flag_dialogue_climb_cross" );
    common_scripts\utility::flag_init( "flag_dialogue_climb_crane" );
    common_scripts\utility::flag_init( "flag_dialogue_crane_start" );
    common_scripts\utility::flag_init( "flag_dialogue_crane_go" );
    common_scripts\utility::flag_init( "flag_dialogue_crane_jump" );
    common_scripts\utility::flag_init( "flag_dialogue_crane_slide" );
}

init_lighting_flags()
{

}

player_boat_gas()
{
    if ( common_scripts\utility::flag( "missionfailed" ) )
        return 1;

    if ( level.player attackbuttonpressed() )
        return 1;

    return 0;
}

player_boat_dive( var_0 )
{
    if ( common_scripts\utility::flag( "missionfailed" ) )
        return 1;

    if ( level.player jumpbuttonpressed() )
        return 1;

    if ( isdefined( var_0 ) && !level.player istouching( var_0 ) )
        return 1;

    return 0;
}

climbing_hint_display( var_0, var_1 )
{
    maps\betrayal_util::waittill_player_exo_climbing();
    maps\_utility::display_hint( var_0 );

    if ( isdefined( level.current_hint ) )
        level.current_hint waittill( "destroying" );

    if ( maps\_exo_climb::is_exo_climbing() && !common_scripts\utility::flag( var_1 ) )
        common_scripts\utility::flag_set( var_1 );
}

grapple_hint_display( var_0, var_1 )
{
    if ( common_scripts\utility::flag( "missionfailed" ) )
        return 1;

    maps\_utility::display_hint( var_0 );

    if ( common_scripts\utility::flag( "flag_climb_player_finished_first_grapple" ) )
        return 1;

    if ( maps\_exo_climb::is_exo_climbing() && !common_scripts\utility::flag( var_1 ) )
        common_scripts\utility::flag_set( var_1 );
}

player_exoclimb_moved()
{
    if ( common_scripts\utility::flag( "missionfailed" ) )
        return 1;

    if ( !maps\_exo_climb::is_exo_climbing() )
        return 1;

    if ( maps\_exo_climb::is_exoclimb_jumped() )
    {
        common_scripts\utility::flag_set( "flag_hint_player_exoclimb_jumped" );
        return 1;
    }

    return 0;
}

player_exoclimb_mag_moved()
{
    if ( common_scripts\utility::flag( "missionfailed" ) )
        return 1;

    if ( !maps\_exo_climb::is_exo_climbing() )
        return 1;

    if ( maps\_exo_climb::is_exoclimb_mag_moved() )
    {
        common_scripts\utility::flag_set( "flag_hint_player_exoclimb_magmoved" );
        return 1;
    }

    return 0;
}

player_used_exoclimb_combat()
{
    if ( common_scripts\utility::flag( "missionfailed" ) )
        return 1;

    if ( !maps\_exo_climb::is_exo_climbing() )
        return 1;

    if ( maps\_exo_climb::is_exoclimb_combat() )
    {
        common_scripts\utility::flag_set( "flag_hint_player_exoclimb_combat" );
        return 1;
    }

    return 0;
}

player_used_exoclimb_cover()
{
    if ( common_scripts\utility::flag( "missionfailed" ) )
        return 1;

    if ( !maps\_exo_climb::is_exo_climbing() )
        return 1;

    if ( maps\_exo_climb::is_exoclimb_cover() )
    {
        common_scripts\utility::flag_set( "flag_hint_player_exoclimb_cover" );
        return 1;
    }

    return 0;
}

player_moved_forward()
{
    if ( common_scripts\utility::flag( "missionfailed" ) )
        return 1;

    if ( common_scripts\utility::flag( "flag_climb_player_started_moving" ) )
        return 1;

    return 0;
}

leaving_mission_area_while_in_trig( var_0 )
{
    if ( isdefined( var_0 ) && !level.player istouching( var_0 ) )
        return 1;
    else
        return 0;
}

player_used_grapple()
{
    var_0 = getentarray( "grapple_hint_trig", "targetname" );

    if ( common_scripts\utility::flag( "missionfailed" ) )
        return 1;

    if ( common_scripts\utility::flag( "flag_climb_player_finished_first_grapple" ) )
        return 1;

    foreach ( var_2 in var_0 )
    {
        if ( !level.player istouching( var_2 ) )
            return 1;
    }

    return 0;
}

setup_start_points()
{
    maps\_utility::add_start( "atlas_building_lobby", ::start_office );
    maps\_utility::add_start( "atlas_building_confrontation", ::start_confrontation );
    maps\_utility::add_start( "atlas_building_confrontation_QTE", ::start_confrontation_qte );
    maps\_utility::add_start( "atlas_building_escape", ::start_escape );
    maps\_utility::add_start( "atlas_building_roof", ::start_roof );
    maps\_utility::add_start( "escape_swim", ::start_swim );
    maps\_utility::add_start( "old_town_sewer", ::start_sewer );
    maps\_utility::add_start( "old_town_freerun", ::start_oldtown );
    maps\_utility::add_start( "old_town_docks", ::start_docks );
    maps\_utility::add_start( "boat_chase_start", ::start_boat );
    maps\_utility::add_start( "boat_chase_jump", ::start_boatjump );
    maps\_utility::add_start( "boat_chase_warbird", ::start_boatwarbird );
    maps\_utility::add_start( "boat_chase_mall", ::start_boatmall );
    maps\_utility::add_start( "boat_chase_crash", ::start_boatcrash );
    maps\_utility::add_start( "finale_climb", ::start_climb );
    maps\_utility::add_start( "finale_roof", ::start_climbroof );
    maps\_utility::add_start( "finale_crates", ::start_climbcrates );
    maps\_utility::add_start( "finale_skybridge", ::start_climbskybridge );
    maps\_utility::add_start( "finale_outro", ::start_outro );
    // level.start_point = "atlas_building_confrontation";

    if ( level.currentgen )
        setup_start_transients();
}

setup_start_transients()
{
    var_0 = [ "betrayal_atlas_building_tr" ];
    maps\_utility::set_start_transients( "atlas_building_lobby", var_0 );
    maps\_utility::set_start_transients( "atlas_building_confrontation", var_0 );
    maps\_utility::set_start_transients( "atlas_building_escape", var_0 );
    maps\_utility::set_start_transients( "atlas_building_roof", var_0 );
    maps\_utility::set_start_transients( "escape_swim", var_0 );
    var_0[0] = "betrayal_old_town_tr";
    maps\_utility::set_start_transients( "old_town_sewer", var_0 );
    maps\_utility::set_start_transients( "old_town_freerun", var_0 );
    maps\_utility::set_start_transients( "old_town_docks", var_0 );
    maps\_utility::set_start_transients( "boat_chase_start", var_0 );
    var_0[0] = "betrayal_canals_tr";
    maps\_utility::set_start_transients( "boat_chase_jump", var_0 );
    maps\_utility::set_start_transients( "boat_chase_warbird", var_0 );
    maps\_utility::set_start_transients( "boat_chase_mall", var_0 );
    maps\_utility::set_start_transients( "boat_chase_crash", var_0 );
    var_0[0] = "betrayal_finale_tr";
    maps\_utility::set_start_transients( "finale_climb", var_0 );
    maps\_utility::set_start_transients( "finale_roof", var_0 );
    maps\_utility::set_start_transients( "finale_crates", var_0 );
    maps\_utility::set_start_transients( "finale_skybridge", var_0 );
    maps\_utility::set_start_transients( "finale_outro", var_0 );
}

setup_tff_cleanups()
{
    thread tff_cleanup_canal_boats();
}

tff_cleanup_canal_boats()
{
    level waittill( "tff_pre_canals_to_finale" );
    var_0 = getentarray( "boats_to_cleanup", "script_noteworthy" );

    foreach ( var_2 in var_0 )
    {
        if ( isdefined( var_2 ) && !isremovedentity( var_2 ) && var_2 maps\_vehicle::isvehicle() )
            var_2 delete();
    }
}

setup_tff_transitions()
{
    if ( !istransientloaded( "betrayal_old_town_tr" ) )
        thread tff_trans_atlas_building_to_old_town();

    if ( !istransientloaded( "betrayal_canals_tr" ) )
        thread tff_trans_old_town_to_canals();

    if ( !istransientloaded( "betrayal_finale_tr" ) )
        thread tff_trans_canals_to_finale();
}

tff_trans_atlas_building_to_old_town()
{
    common_scripts\utility::flag_wait( "flag_tff_trans_atlas_building_to_old_town" );
    level notify( "tff_pre_atlas_building_to_old_town" );
    unloadtransient( "betrayal_atlas_building_tr" );
    loadtransient( "betrayal_old_town_tr" );

    while ( !istransientloaded( "betrayal_old_town_tr" ) )
        wait 0.05;

    level notify( "tff_post_atlas_building_to_old_town" );
}

tff_trans_old_town_to_canals()
{
    common_scripts\utility::flag_wait( "flag_tff_trans_old_town_to_canals" );
    level notify( "tff_pre_old_town_to_canals" );
    unloadtransient( "betrayal_old_town_tr" );
    loadtransient( "betrayal_canals_tr" );

    while ( !istransientloaded( "betrayal_canals_tr" ) )
        wait 0.05;

    level notify( "tff_post_old_town_to_canals" );
}

tff_trans_canals_to_finale()
{
    common_scripts\utility::flag_wait( "flag_tff_trans_canals_to_finale" );
    level notify( "tff_pre_canals_to_finale" );
    unloadtransient( "betrayal_canals_tr" );
    loadtransient( "betrayal_finale_tr" );

    while ( !istransientloaded( "betrayal_finale_tr" ) )
        wait 0.05;

    level notify( "tff_post_canals_to_finale" );
}

start_office()
{
    maps\betrayal_util::spawn_squad( "start_office", 1, 0 );
    level thread maps\betrayal_code::office_scene_master_handler();
    level thread objectives();
    common_scripts\utility::flag_set( "office_start_lighting" );
    maps\_player_exo::player_exo_deactivate();
    level.player maps\_grapple::grapple_take();
    setupbetrayalportalscripting();
    soundscripts\_snd::snd_message( "start_office" );
}

start_confrontation()
{
    maps\betrayal_util::spawn_squad( "start_confrontation", 1, 0 );
    maps\betrayal_util::move_player_to_ent_by_targetname( "start_confrontation_player" );
    maps\betrayal_util::give_player_just_hands();
    level thread maps\betrayal_code::confrontation_scene_master_handler();
    level thread objectives();
    common_scripts\utility::flag_set( "confrontation_start_lighting" );
    maps\_player_exo::player_exo_deactivate();
    level.player maps\_grapple::grapple_take();
    setupbetrayalportalscripting();
    soundscripts\_snd::snd_message( "start_confrontation" );
}

start_confrontation_qte()
{
    maps\betrayal_util::spawn_squad( "start_confrontation", 1, 0 );
    maps\betrayal_util::move_player_to_ent_by_targetname( "start_confrontation_player" );
    maps\betrayal_util::give_player_just_hands();
    level thread maps\betrayal_code::confrontation_scene_master_handler( "qte" );
    level thread objectives();
    common_scripts\utility::flag_set( "confrontation_start_lighting" );
    maps\_player_exo::player_exo_deactivate();
    level.player maps\_grapple::grapple_take();
    setupbetrayalportalscripting();
    soundscripts\_snd::snd_message( "start_confrontation_qte" );
}

start_escape()
{
    maps\betrayal_util::spawn_squad( "start_escape", 0, 1 );
    level.ilana maps\_utility::gun_recall();
    maps\betrayal_util::move_player_to_ent_by_targetname( "start_escape_player" );
    level thread maps\betrayal_code::escape_scene_master_handler();
    var_0 = maps\betrayal_util::get_ents_by_targetname( "confrontation_room_exit_door_right" );
    thread maps\betrayal_util::open_sliding_door_toggle( var_0, "confrontation_room_exit_door", 1.0 );
    level thread objectives();
    maps\_player_exo::player_exo_activate();
    level.player maps\_grapple::grapple_take();

    if ( level.nextgen )
        common_scripts\utility::flag_set( "escape_start_lighting" );

    setupbetrayalportalscripting();
    soundscripts\_snd::snd_message( "start_escape" );
}

start_roof()
{
    maps\betrayal_util::spawn_squad( "start_roof", 0, 1 );
    level.ilana maps\_utility::gun_recall();
    var_0 = maps\betrayal_util::get_ent_by_targetname( "roof_scene_ilona_start" );

    if ( isdefined( var_0 ) )
        maps\_utility::activate_trigger_with_targetname( "roof_scene_ilona_start" );

    maps\betrayal_util::move_player_to_ent_by_targetname( "start_roof_player" );
    thread maps\betrayal_util::handle_ally_keep_up_with_player( level.ilana );
    level thread maps\betrayal_code::roof_scene_master_handler();
    thread maps\betrayal_code::roof_scene_industrial_drone_swarm_launch_manager( 0 );
    maps\_player_exo::player_exo_activate();
    level.player maps\_grapple::grapple_take();
    level thread objectives();
    common_scripts\utility::flag_set( "roof_start_lighting" );
    setupbetrayalportalscripting();
    soundscripts\_snd::snd_message( "start_roof" );
}

start_swim()
{
    maps\betrayal_util::spawn_squad( "start_swim", 0, 1 );
    level.ilana maps\_utility::gun_recall();
    maps\betrayal_util::move_player_to_ent_by_targetname( "start_swim_player" );
    thread maps\betrayal_util::handle_ally_keep_up_with_player( level.ilana );
    wait 0.1;
    common_scripts\utility::flag_set( "swim_devstart" );
    level thread maps\betrayal_code::swim_scene_master_handler();
    maps\_player_exo::player_exo_deactivate();
    level.player maps\_grapple::grapple_take();
    level thread objectives();
    common_scripts\utility::flag_set( "swim_start_lighting" );
    setupbetrayalportalscripting();
    soundscripts\_snd::snd_message( "start_swim" );
}

start_sewer()
{
    maps\betrayal_util::spawn_squad( "start_sewer", 0, 1 );
    level.ilana maps\_utility::gun_recall();
    maps\betrayal_util::move_player_to_ent_by_targetname( "start_sewer_player" );
    thread maps\betrayal_util::handle_ally_keep_up_with_player( level.ilana );
    level thread maps\betrayal_code::sewer_scene_master_handler();
    level.player maps\_grapple::grapple_take();
    level thread objectives();
    common_scripts\utility::flag_set( "sewer_start_lighting" );
    setupbetrayalportalscripting();
    soundscripts\_snd::snd_message( "start_sewer" );
}

start_oldtown()
{
    maps\betrayal_util::spawn_squad( "start_oldtown", 0, 1 );
    level.ilana maps\_utility::gun_recall();
    maps\betrayal_util::move_player_to_ent_by_targetname( "start_oldtown_player" );
    thread maps\betrayal_util::handle_ally_keep_up_with_player( level.ilana );
    common_scripts\utility::flag_set( "flag_sewer_oldtown_intro_complete" );
    common_scripts\utility::flag_set( "flag_sewer_checkpoint_guards_wakeup" );
    level thread maps\betrayal_code::oldtown_scene_master_handler();
    maps\_player_exo::player_exo_activate();
    level.player maps\_grapple::grapple_take();
    level thread objectives();
    maps\_utility::activate_trigger( "oldtown_first_contact", "targetname", level.player );
    common_scripts\utility::flag_set( "flag_sewer_scene_transfer_to_free_run" );
    common_scripts\utility::flag_set( "rear_pressure_go_setup" );
    wait 3.2;
    common_scripts\utility::flag_set( "rear_pressure_go" );
    level notify( "freerun_go" );
    common_scripts\utility::flag_set( "oldtown_start_lighting" );
    setupbetrayalportalscripting();
    soundscripts\_snd::snd_message( "start_oldtown" );
}

start_docks()
{
    maps\betrayal_util::spawn_squad( "start_docks", 0, 1 );
    level.ilana maps\_utility::gun_recall();
    maps\betrayal_util::move_player_to_ent_by_targetname( "start_docks_player" );
    thread maps\betrayal_util::handle_ally_keep_up_with_player( level.ilana );
    level thread maps\betrayal_code::oldtown_dock_master_handler();
    maps\_player_exo::player_exo_activate();
    level.player maps\_grapple::grapple_take();
    level thread objectives();
    common_scripts\utility::flag_set( "oldtown_start_lighting" );
    common_scripts\utility::flag_set( "oldtown_dock_flyby" );
    wait 0.3;
    common_scripts\utility::flag_set( "oldtown_boat_spawn" );
    setupbetrayalportalscripting();
    soundscripts\_snd::snd_message( "start_docks" );
}

start_boat()
{
    maps\betrayal_util::spawn_squad( "start_boat", 0, 1 );
    level.ilana maps\_utility::gun_recall();
    maps\betrayal_util::move_player_to_ent_by_targetname( "start_boat_player" );
    level thread maps\betrayal_code::boat_scene_master_handler();
    level.player maps\_grapple::grapple_take();
    maps\_player_exo::player_exo_deactivate();
    level thread objectives();
    common_scripts\utility::flag_set( "boat_start_lighting" );
    setupbetrayalportalscripting();
    soundscripts\_snd::snd_message( "start_boat" );
}

start_boatjump()
{
    var_0 = maps\betrayal_util::get_ent_by_targetname( "start_boat_jump" );
    var_1 = maps\betrayal_util::get_ent_by_targetname( "vehicle_player_boat" );
    var_1.origin = var_0.origin;
    var_1.angles = var_0.angles;
    level.player_boat = maps\_vehicle::spawn_vehicle_from_targetname( "vehicle_player_boat" );
    level.player_boat makeusable();
    maps\betrayal_util::spawn_squad( "start_boat", 0, 1 );
    level.ilana maps\_utility::gun_recall();
    maps\betrayal_util::start_player_diveboat_ride();
    level thread maps\betrayal_code::boat_scene_master_handler( 1 );
    maps\_player_exo::player_exo_deactivate();
    level.player maps\_grapple::grapple_take();
    level thread objectives();
    common_scripts\utility::flag_set( "boat_start_lighting" );
    setupbetrayalportalscripting();
    soundscripts\_snd::snd_message( "start_boatjump" );
}

start_boatwarbird()
{
    var_0 = maps\betrayal_util::get_ent_by_targetname( "start_boat_warbird" );
    var_1 = maps\betrayal_util::get_ent_by_targetname( "vehicle_player_boat" );
    var_1.origin = var_0.origin;
    var_1.angles = var_0.angles;
    level.player_boat = maps\_vehicle::spawn_vehicle_from_targetname( "vehicle_player_boat" );
    level.player_boat makeusable();
    maps\betrayal_util::spawn_squad( "start_boat", 0, 1 );
    level.ilana maps\_utility::gun_recall();
    maps\betrayal_util::start_player_diveboat_ride();
    level thread maps\betrayal_code::boat_scene_master_handler( 1 );
    maps\_player_exo::player_exo_deactivate();
    level.player maps\_grapple::grapple_take();
    level thread objectives();
    common_scripts\utility::flag_set( "boat_start_lighting" );
    soundscripts\_snd::snd_message( "start_boatwarbird" );
}

start_boatmall()
{
    var_0 = maps\betrayal_util::get_ent_by_targetname( "start_boat_mall" );
    var_1 = maps\betrayal_util::get_ent_by_targetname( "vehicle_player_boat" );
    var_1.origin = var_0.origin;
    var_1.angles = var_0.angles;
    level.player_boat = maps\_vehicle::spawn_vehicle_from_targetname( "vehicle_player_boat" );
    level.player_boat makeusable();
    maps\betrayal_util::spawn_squad( "start_boat", 0, 1 );
    level.ilana maps\_utility::gun_recall();
    maps\betrayal_util::start_player_diveboat_ride();
    level thread maps\betrayal_code::boat_scene_master_handler( 1 );
    maps\_player_exo::player_exo_deactivate();
    level.player maps\_grapple::grapple_take();
    level thread objectives();
    common_scripts\utility::flag_set( "boat_start_lighting" );
    soundscripts\_snd::snd_message( "start_boatmall" );
}

start_boatcrash()
{
    var_0 = maps\betrayal_util::get_ent_by_targetname( "start_boat_crash" );
    var_1 = maps\betrayal_util::get_ent_by_targetname( "vehicle_player_boat" );
    var_1.origin = var_0.origin;
    var_1.angles = var_0.angles;
    level.player_boat = maps\_vehicle::spawn_vehicle_from_targetname( "vehicle_player_boat" );
    level.player_boat makeusable();
    maps\betrayal_util::spawn_squad( "start_boat", 0, 1 );
    level.ilana maps\_utility::gun_recall();
    maps\betrayal_util::start_player_diveboat_ride();
    level thread maps\betrayal_code::boat_scene_master_handler( 1 );
    maps\_player_exo::player_exo_deactivate();
    level.player maps\_grapple::grapple_take();
    level thread objectives();
    common_scripts\utility::flag_set( "boat_start_lighting" );
    soundscripts\_snd::snd_message( "start_boatcrash" );
}

start_climb()
{
    maps\betrayal_util::spawn_squad( "start_climb", 0, 1 );
    level.ilana maps\_utility::gun_recall();
    maps\betrayal_util::move_player_to_ent_by_targetname( "start_climb_player" );
    level thread maps\betrayal_code::climb_scene_master_handler();
    maps\_player_exo::player_exo_activate();
    level.player maps\_grapple::grapple_take();
    level thread objectives();
    common_scripts\utility::flag_set( "climb_start_lighting" );
    maps\betrayal_util::player_knockout_white();
    soundscripts\_snd::snd_message( "start_climb" );
}

start_climbroof()
{
    maps\betrayal_util::spawn_squad( "start_climbroof", 0, 1 );
    level.ilana maps\_utility::gun_recall();
    maps\betrayal_util::move_player_to_ent_by_targetname( "start_climbroof_player" );
    level thread maps\betrayal_code::climb_scene_master_handler( "roof" );
    maps\_player_exo::player_exo_activate();
    level thread objectives();
    common_scripts\utility::flag_set( "climb_start_lighting" );
    soundscripts\_snd::snd_message( "start_climbroof" );
}

start_climbcrates()
{
    maps\betrayal_util::spawn_squad( "start_climbcrates", 0, 1 );
    level.ilana maps\_utility::gun_recall();
    maps\betrayal_util::move_player_to_ent_by_targetname( "start_climbcrates_player" );
    level thread maps\betrayal_code::climb_scene_master_handler( "crates" );
    maps\_player_exo::player_exo_activate();
    level thread objectives();
    common_scripts\utility::flag_set( "climb_start_lighting" );
    soundscripts\_snd::snd_message( "start_climbcrates" );
}

start_climbskybridge()
{
    maps\betrayal_util::spawn_squad( "start_climbskybridge", 0, 1 );
    level.ilana maps\_utility::gun_recall();
    maps\betrayal_util::move_player_to_ent_by_targetname( "start_climbskybridge_player" );
    level thread maps\betrayal_code::climb_scene_master_handler( "skybridge" );
    maps\_player_exo::player_exo_activate();
    level thread objectives();
    common_scripts\utility::flag_set( "climb_start_lighting" );
    soundscripts\_snd::snd_message( "start_climbskybridge" );
}

start_outro()
{
    maps\betrayal_util::spawn_squad( "start_outro", 0, 1 );
    level.ilana maps\_utility::gun_recall();
    maps\betrayal_util::move_player_to_ent_by_targetname( "start_outro_player" );
    level thread maps\betrayal_code::climb_scene_master_handler( "finale_outro" );
    maps\_player_exo::player_exo_deactivate();
    level thread objectives();
    common_scripts\utility::flag_set( "climb_start_lighting" );
    soundscripts\_snd::snd_message( "start_outro" );
}

global_spawn_functions()
{
    maps\_utility::add_global_spawn_function( "axis", ::enable_jump_jet_pathing );
    maps\_utility::add_global_spawn_function( "axis", ::toggle_battle_chatter );
    maps\_utility::add_global_spawn_function( "allies", ::toggle_battle_chatter );
}

enable_jump_jet_pathing()
{
    if ( isdefined( self.script_noteworthy ) && self.script_noteworthy == "has_boost_jump" )
        self.canjumppath = 1;
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

setup_objective_flags()
{
    if ( maps\_utility::is_default_start() )
        return;

    var_0 = level.start_point;

    if ( var_0 == "atlas_building_lobby" )
        return;

    common_scripts\utility::flag_set( "flag_objective_office_scene_follow_gideon_complete" );

    if ( var_0 == "atlas_building_confrontation" )
        return;

    if ( var_0 == "atlas_building_confrontation_qte" )
        return;

    if ( var_0 == "atlas_building_escape" )
        return;

    common_scripts\utility::flag_set( "flag_objective_escape_scene_start" );
    common_scripts\utility::flag_set( "flag_objective_escape_scene_on_roof" );

    if ( var_0 == "atlas_building_roof" )
        return;

    common_scripts\utility::flag_set( "flag_objective_escape_scene_complete" );

    if ( var_0 == "escape_swim" )
        return;

    common_scripts\utility::flag_set( "flag_objective_swim_scene_start" );

    if ( var_0 == "old_town_sewer" )
        return;

    common_scripts\utility::flag_set( "flag_objective_swim_scene_complete" );
    common_scripts\utility::flag_set( "flag_objective_freerun_scene_start" );

    if ( var_0 == "old_town_freerun" )
        return;

    common_scripts\utility::flag_set( "flag_objective_freerun_scene_complete" );

    if ( var_0 == "old_town_docks" )
        return;

    common_scripts\utility::flag_set( "flag_objective_dock_scene_complete" );

    if ( var_0 == "boat_chase_start" )
        return;

    common_scripts\utility::flag_set( "flag_objective_boat_chase_start" );

    if ( var_0 == "boat_chase_jump" )
        return;

    if ( var_0 == "boat_chase_warbird" )
        return;

    if ( var_0 == "boat_chase_mall" )
        return;

    if ( var_0 == "boat_chase_crash" )
        return;

    common_scripts\utility::flag_set( "flag_objective_boat_chase_complete" );

    if ( var_0 == "finale_climb" )
        return;

    common_scripts\utility::flag_set( "flag_objective_climb_start" );

    if ( var_0 == "finale_roof" )
        return;

    if ( var_0 == "finale_crates" )
        return;

    if ( var_0 == "finale_skybridge" )
        return;

    common_scripts\utility::flag_set( "flag_objective_climb_complete" );

    if ( var_0 == "finale_outro" )
        return;
}

objectives()
{
    setup_objective_flags();

    if ( common_scripts\utility::flag( "flag_objective_office_scene_follow_gideon_complete" ) )
        objective_add( maps\_utility::obj( "Follow Gideon" ), "done", &"BETRAYAL_OBJ_FOLLOW_GIDEON" );
    else
    {
        common_scripts\utility::flag_wait( "flag_objective_office_scene_follow_gideon" );
        objective_add( maps\_utility::obj( "Follow Gideon" ), "current", &"BETRAYAL_OBJ_FOLLOW_GIDEON", level.gideon.origin );
        objective_onentity( maps\_utility::obj( "Follow Gideon" ), level.gideon );
        common_scripts\utility::flag_wait( "flag_objective_office_scene_follow_gideon_complete" );
        maps\_utility::objective_complete( maps\_utility::obj( "Follow Gideon" ) );
    }

    if ( common_scripts\utility::flag( "flag_objective_escape_scene_complete" ) )
        objective_add( maps\_utility::obj( "Escape Atlas" ), "done", &"BETRAYAL_OBJ_ESCAPE_ATLAS" );
    else
    {
        common_scripts\utility::flag_wait( "flag_objective_escape_scene_start" );
        common_scripts\utility::run_thread_on_targetname( "trigger_objective_escape_update_position", ::objective_trigger_path_objective_updates, "Escape Atlas", "flag_objective_escape_scene_complete", &"BETRAYAL_OBJ_ESCAPE_ATLAS" );
        common_scripts\utility::flag_wait( "flag_objective_escape_scene_complete" );
        maps\_utility::objective_complete( maps\_utility::obj( "Escape Atlas" ) );
    }

    if ( common_scripts\utility::flag( "flag_objective_swim_scene_complete" ) )
        objective_add( maps\_utility::obj( "Sewer" ), "done", &"BETRAYAL_OBJ_FOLLOW_ILONA" );
    else
    {
        common_scripts\utility::flag_wait( "flag_objective_swim_scene_start" );
        common_scripts\utility::run_thread_on_targetname( "trigger_objective_swim_update_position", ::objective_trigger_path_objective_updates, "Sewer", "flag_objective_swim_scene_complete", &"BETRAYAL_OBJ_FOLLOW_ILONA" );
        common_scripts\utility::flag_wait( "flag_objective_swim_scene_complete" );
        maps\_utility::objective_complete( maps\_utility::obj( "Sewer" ) );
    }

    if ( common_scripts\utility::flag( "flag_objective_freerun_scene_complete" ) )
        objective_add( maps\_utility::obj( "Old Town" ), "done", &"BETRAYAL_OBJ_ESCAPE_OLDTOWN" );
    else
    {
        common_scripts\utility::flag_wait( "flag_objective_freerun_scene_start" );
        objective_add( maps\_utility::obj( "Old Town" ), "current", &"BETRAYAL_OBJ_ESCAPE_OLDTOWN" );
        objective_onentity( maps\_utility::obj( "Old Town" ), level.ilana );
        common_scripts\utility::run_thread_on_targetname( "trigger_objective_freerun_update_position", ::objective_trigger_path_objective_updates, "Old Town", "flag_objective_freerun_scene_complete" );
        common_scripts\utility::flag_wait( "flag_objective_freerun_scene_complete" );
        maps\_utility::objective_complete( maps\_utility::obj( "Old Town" ) );
    }

    if ( common_scripts\utility::flag( "flag_objective_dock_scene_complete" ) )
        objective_add( maps\_utility::obj( "Mech" ), "done", &"BETRAYAL_OBJ_KILL_MECH" );
    else
    {
        common_scripts\utility::flag_wait( "flag_objective_dock_scene_start" );
        objective_add( maps\_utility::obj( "Mech" ), "current", &"BETRAYAL_OBJ_KILL_MECH" );
        objective_onentity( maps\_utility::obj( "Mech" ), level.dock_mech );
        objective_setpointertextoverride( maps\_utility::obj( "Mech" ), &"BETRAYAL_DESTROY" );
        common_scripts\utility::flag_wait( "flag_objective_dock_scene_complete" );
        maps\_utility::objective_complete( maps\_utility::obj( "Mech" ) );
    }

    if ( common_scripts\utility::flag( "flag_objective_boat_chase_complete" ) )
        objective_add( maps\_utility::obj( "Boat" ), "done", &"BETRAYAL_OBJ_BOAT_GOAL" );
    else
    {
        wait 0.05;
        objective_add( maps\_utility::obj( "Boat" ), "current", &"BETRAYAL_OBJ_BOAT_GOAL" );

        if ( !common_scripts\utility::flag( "flag_objective_boat_chase_start" ) )
        {
            while ( !isdefined( level.obj_get_in_org ) )
                wait 0.05;

            objective_position( maps\_utility::obj( "Boat" ), level.obj_get_in_org );
            objective_setpointertextoverride( maps\_utility::obj( "Boat" ), &"BETRAYAL_BOAT_ENTER" );
        }

        common_scripts\utility::run_thread_on_targetname( "trigger_objective_boat_update_position", ::objective_trigger_path_objective_updates, "Boat", "flag_objective_boat_chase_complete" );
        common_scripts\utility::flag_wait( "flag_objective_boat_chase_complete" );
        maps\_utility::objective_complete( maps\_utility::obj( "Boat" ) );
    }

    if ( common_scripts\utility::flag( "flag_objective_climb_complete" ) )
        objective_add( maps\_utility::obj( "Climb" ), "done", &"BETRAYAL_OBJ_CLIMB_EXTRACTION" );
    else
    {
        common_scripts\utility::flag_wait( "flag_objective_climb_start" );
        common_scripts\utility::run_thread_on_targetname( "trigger_objective_climb_update_position", ::objective_trigger_path_objective_updates, "Climb", "flag_objective_climb_start_crane", &"BETRAYAL_OBJ_CLIMB_EXTRACTION" );
        common_scripts\utility::flag_wait( "flag_objective_climb_start_crane" );
        setsaveddvar( "compass", "0" );
        common_scripts\utility::flag_wait( "flag_climb_player_started_moving" );
        var_0 = maps\betrayal_util::get_ent_by_targetname( "origin_button_crane_dismount" );
        objective_position( maps\_utility::obj( "Climb" ), var_0.origin );
        objective_setpointertextoverride( maps\_utility::obj( "Climb" ), &"BETRAYAL_MANTLE" );
        setsaveddvar( "compass", "1" );
        common_scripts\utility::flag_wait( "flag_objective_climb_complete" );
        maps\_utility::objective_complete( maps\_utility::obj( "Climb" ) );
    }
}

objective_trigger_path_objective_updates( var_0, var_1, var_2 )
{
    level endon( var_1 );

    if ( !isdefined( level.objective_state_tracker ) )
        level.objective_state_tracker = [];

    if ( !isdefined( level.objective_state_tracker[var_0] ) )
    {
        if ( isdefined( var_2 ) )
            level.objective_state_tracker[var_0] = "none";
        else
            level.objective_state_tracker[var_0] = "current";
    }

    self waittill( "trigger" );
    var_3 = maps\betrayal_util::get_ent_by_targetname( self.target );

    if ( isdefined( var_3 ) )
    {
        if ( isdefined( self.script_noteworthy ) )
        {
            if ( self.script_noteworthy == "climbing_wait" )
                maps\betrayal_util::waittill_player_exo_climbing();

            if ( self.script_noteworthy == "climbing_not_wait" )
                maps\betrayal_util::waittill_player_not_exo_climbing();
        }

        if ( isdefined( self.script_flag_wait ) )
        {
            setsaveddvar( "compass", "0" );
            common_scripts\utility::flag_wait( self.script_flag_wait );
        }

        if ( level.objective_state_tracker[var_0] == "none" )
        {
            objective_add( maps\_utility::obj( var_0 ), "current", var_2 );
            level.objective_state_tracker[var_0] = "current";
        }

        objective_position( maps\_utility::obj( var_0 ), var_3.origin );
        wait 0.1;
        setsaveddvar( "compass", "1" );

        if ( isdefined( self.script_noteworthy ) && self.script_noteworthy == "jump" )
            objective_setpointertextoverride( maps\_utility::obj( var_0 ), &"BETRAYAL_MANTLE" );
        else if ( isdefined( self.script_noteworthy ) && self.script_noteworthy == "climb" )
            objective_setpointertextoverride( maps\_utility::obj( var_0 ), &"BETRAYAL_CLIMB" );
        else if ( isdefined( self.script_noteworthy ) && self.script_noteworthy == "open" )
            objective_setpointertextoverride( maps\_utility::obj( var_0 ), &"BETRAYAL_OPEN" );
        else
            objective_setpointertextoverride( maps\_utility::obj( var_0 ) );
    }

    self delete();
}

setupbetrayalportalscripting()
{
    if ( level.nextgen )
    {
        var_0 = getent( "portalGrp_betrayal_start2", "targetname" );
        var_1 = getent( "portalGrp_betrayal_start3", "targetname" );
        var_2 = getentarray( "trigger_boat_raise_canal_blocker", "targetname" );
        var_3 = getent( "betrayal_river_out", "targetname" );
        var_4 = "";

        foreach ( var_6 in var_2 )
        {
            if ( var_6.target == "boat_blast_doors_2" )
                var_4 = var_6;
        }

        thread boat_portal_tigger_on( var_4, var_3, var_0, var_1 );
        var_0 enableportalgroup( 1 );
        var_1 enableportalgroup( 1 );
        thread maps\_shg_utility::portal_group_off( "portalGrp_betrayal_start", "portalGrp_betrayal_start2" );
        thread maps\_shg_utility::portal_group_off( "portalGrp_betrayal_start", "portalGrp_betrayal_start3" );
    }
}

boat_portal_tigger_on( var_0, var_1, var_2, var_3 )
{
    for (;;)
    {
        var_0 waittill( "trigger" );
        common_scripts\utility::flag_set( "portalGrp_betrayal_start" );
        var_1 waittill( "trigger" );
        var_2 enableportalgroup( 1 );
        var_3 enableportalgroup( 1 );
    }
}
