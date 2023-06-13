// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    maps\_utility::template_level( "crash" );
    crash_precache();
    crash_starts();
    animscripts\traverse\seoul_zipline::load_scripted_anims();
    maps\createart\crash_art::main();
    maps\crash_fx::main();
    maps\crash_anim::main();
    maps\crash_vo::main();
    maps\crash_precache::main();
    precachesonarvisioncodeassets();
    thread init_water();

    if ( getdvar( "createfx" ) != "" )
        thread create_fx_ent_setup();

    if ( level.currentgen )
        maps\_utility::tff_sync_setup();

    maps\_load::main();
    thread maps\_player_exo::main( "assault", 0, 0 );
    setsaveddvar( "use_new_sva_system", 1 );
    thread maps\crash_fx::setup_footstep_fx();
    maps\crash_lighting::main();
    maps\crash_aud::main();
    maps\_drone_ai::init();
    maps\_microdronelauncher::init();
    maps\_stingerm7::init( "iw5_stingerm7fastprojectile_sp" );
    maps\_variable_grenade::main();
    maps\_microwave_grenade::main();
    thread give_player_exo();
    thread set_up_exo_temperature();
    animscripts\traverse\boost::precache_boost_fx_npc();
    level.player thread give_boost_jump();
    vehicle_scripts\_pdrone_tactical_picker::main();
    thread maps\_deployablecoverai::battle_deployable_cover_setup();

    if ( level.currentgen )
    {
        setsaveddvar( "r_gunSightColorEntityScale", 0.8 );
        setsaveddvar( "r_gunSightColorNoneScale", 0.8 );
    }

    setsaveddvar( "high_jump_double_tap", "1" );
    setsaveddvar( "high_jump_auto_mantle", "1" );
    level.player.drowning_deadquote = &"CRASH_DEATH_BY_DROWNING";
    level.player.drowning_warning = &"CRASH_DROWNING_WARNING";

    if ( level.currentgen )
    {
        tff_transitions();
        tff_blockers();
    }
}

#using_animtree("script_model");

init_water()
{
    maps\_water::init( "s1_gfl_ump45_viewhands_player" );
    level.visionset_underwater = "crash_narrow_cave_underwater";
    setdvar( "underwater_wading_speed_factor", 0.8 );
    level.swim_anim_idle_loop = %crash_vm_unarmed_swim_idle;
    level.player.no_breath_hud = 1;
    level._effect["water_wake_ai"] = loadfx( "vfx/treadfx/body_wake_water_crash" );
    level._effect["water_wake_stationary_ai"] = loadfx( "vfx/treadfx/body_wake_water_stationary" );
    level._effect["water_splash_enter_ai"] = loadfx( "vfx/water/body_splash" );
}

crash_precache()
{
    level.temperature_high_alt_wind = -54.7;
    level.temperature_high_alt = -48.2;
    level.temperature_outdoor = -12.8;
    level.temperature_indoor = 34.6;
    level.temperature_deep_caves = 14.4;
    level.temperature_water = 32.3;
    level.exo_max = 85;
    level.exo_reheat = 72;
    thread objective_flag_init();
    thread maps\crash_skyjack::precache_skyjack();
    thread maps\crash_crash_site::precache_crash_site();
    thread maps\crash_crash_site::precache_cave_entry();
    thread maps\crash_caves::precache_cave_hallway();
    thread maps\crash_caves::precache_big_cave();
    thread maps\crash_caves::precache_ice_bridge();
    thread maps\crash_caves::precache_narrow_cave();
    thread maps\crash_caves::precache_combat_cave();
    thread maps\crash_lake::precache_overlook();
    thread maps\crash_lake::precache_lake();
    thread maps\crash_lake::precache_lake_cinema();
    thread maps\crash_exfil::precache_vtol_takedown();
    thread maps\crash_exo_temperature::precache_exo_temperature();
}

crash_starts()
{
    maps\_utility::add_start( "skyjack", maps\crash_skyjack::debug_start_skyjack, "Skyjack", maps\crash_skyjack::begin_skyjack );
    maps\_utility::add_start( "crash_site", maps\crash_crash_site::debug_start_crash_site, "Crash Site", maps\crash_crash_site::begin_crash_site );
    maps\_utility::add_start( "cave_entry", maps\crash_crash_site::debug_start_cave_entry, "Cave Entry", maps\crash_crash_site::begin_cave_entry );
    maps\_utility::add_start( "cave_hallway", maps\crash_caves::debug_start_cave_hallway, "Cave Hallway", maps\crash_caves::begin_cave_hallway );
    maps\_utility::add_start( "big_cave", maps\crash_caves::debug_start_big_cave, "Big Cave", maps\crash_caves::begin_big_cave );
    maps\_utility::add_start( "ice_bridge", maps\crash_caves::debug_start_ice_bridge, "Ice Bridge", maps\crash_caves::begin_ice_bridge );
    maps\_utility::add_start( "narrow_cave", maps\crash_caves::debug_start_narrow_cave, "Narrow Cave", maps\crash_caves::begin_narrow_cave );
    maps\_utility::add_start( "combat_cave", maps\crash_caves::debug_start_combat_cave, "Combat Cave", maps\crash_caves::begin_combat_cave );
    maps\_utility::add_start( "overlook", maps\crash_lake::debug_start_overlook, "Overlook", maps\crash_lake::begin_overlook );
    maps\_utility::add_start( "lake", maps\crash_lake::debug_start_lake, "Underground Lake", maps\crash_lake::begin_lake );
    maps\_utility::add_start( "lake_cinema", maps\crash_lake::debug_start_lake_cinema, "Lake Cinema", maps\crash_lake::begin_lake_cinema );
    maps\_utility::add_start( "vtol_takedown", maps\crash_exfil::debug_start_vtol_takedown, "VTOL Takedown", maps\crash_exfil::begin_vtol_takedown );
    // level.start_point = "vtol_takedown";
    
    if ( level.currentgen )
        tff_start_points();
}

tff_start_points()
{
    var_0 = [];
    var_0[0] = "crash_sky_tr";
    maps\_utility::set_start_transients( "skyjack", var_0 );
    var_0[0] = "crash_site_tr";
    maps\_utility::set_start_transients( "crash_site", var_0 );
    maps\_utility::set_start_transients( "cave_entry", var_0 );
    var_0[0] = "crash_caves_tr";
    maps\_utility::set_start_transients( "cave_hallway", var_0 );
    maps\_utility::set_start_transients( "big_cave", var_0 );
    maps\_utility::set_start_transients( "ice_bridge", var_0 );
    maps\_utility::set_start_transients( "narrow_cave", var_0 );
    maps\_utility::set_start_transients( "combat_cave", var_0 );
    var_0[0] = "crash_lake_tr";
    maps\_utility::set_start_transients( "overlook", var_0 );
    maps\_utility::set_start_transients( "lake", var_0 );
    maps\_utility::set_start_transients( "lake_cinema", var_0 );
    maps\_utility::set_start_transients( "vtol_takedown", var_0 );
}

tff_blockers()
{
    thread tff_blocker_caves();
}

tff_blocker_caves()
{
    var_0 = getentarray( "tff_blocker_caves", "targetname" );
    var_1 = getent( "tff_blocker_caves_coll", "targetname" );
    var_2 = ( 0, 0, 380 );
    var_1 connectpaths();
    var_1.origin -= var_2;

    foreach ( var_4 in var_0 )
        var_4 common_scripts\utility::hide_notsolid();

    if ( !istransientloaded( "crash_lake_tr" ) )
        level waittill( "tff_pre_caves_to_lake" );

    foreach ( var_4 in var_0 )
        var_4 common_scripts\utility::show_solid();

    var_1.origin += var_2;
    var_1 disconnectpaths();
}

tff_transitions()
{
    if ( !istransientloaded( "crash_caves_tr" ) )
        thread tff_trans_site_to_caves();

    if ( !istransientloaded( "crash_lake_tr" ) )
        thread tff_trans_caves_to_lake();
}

tff_trans_site_to_caves()
{
    common_scripts\utility::flag_wait( "cave_entry_anim_start" );
    wait 5.0;
    level notify( "tff_pre_site_to_caves" );
    unloadtransient( "crash_site_tr" );
    loadtransient( "crash_caves_tr" );

    while ( !istransientloaded( "crash_caves_tr" ) )
        wait 0.05;

    level notify( "tff_post_site_to_caves" );
}

tff_ally_check( var_0, var_1, var_2 )
{
    var_3 = getent( var_0, "targetname" );
    level.tff_trans_ally_check_count = 0;

    if ( isdefined( var_2 ) )
        level endon( var_2 );

    for (;;)
    {
        var_3 waittill( "trigger", var_4 );

        if ( isdefined( var_4.tff_trans_ally_check_active ) && var_4.tff_trans_ally_check_active )
            continue;

        if ( isdefined( var_4.script_friendname ) )
            var_5 = tolower( var_4.script_friendname );
        else
            var_5 = "";

        if ( var_4 == level.player || common_scripts\utility::array_contains( var_1, var_5 ) )
        {
            level.tff_trans_ally_check_count++;

            if ( level.tff_trans_ally_check_count >= var_1.size + 1 )
                break;

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

tff_trans_caves_to_lake()
{
    tff_ally_check( "tff_unload_caves_check_allies", [ "cormack", "ilona" ], "flag_tff_trans_caves_to_lake" );

    if ( common_scripts\utility::flag( "flag_tff_trans_caves_to_lake" ) )
    {
        var_0 = getent( "tff_cave_unload_ally_teleport_01", "targetname" );
        var_1 = getent( "tff_cave_unload_ally_teleport_02", "targetname" );
        level.ilana teleport( var_0.origin, var_0.angles );
        level.cormack teleport( var_1.origin, var_1.angles );
    }

    level notify( "tff_pre_caves_to_lake" );
    unloadtransient( "crash_caves_tr" );
    loadtransient( "crash_lake_tr" );

    while ( !istransientloaded( "crash_lake_tr" ) )
        wait 0.05;

    level notify( "tff_post_caves_to_lake" );
}

set_completed_flags()
{
    if ( maps\_utility::is_default_start() )
        return;

    var_0 = level.start_point;

    if ( var_0 == "skyjack" )
        return;

    common_scripts\utility::flag_set( "obj_start_plant_charges" );
    common_scripts\utility::flag_set( "obj_end_plant_charges" );

    if ( var_0 == "crash_site" )
        return;

    common_scripts\utility::flag_set( "white_fade_done" );
    common_scripts\utility::flag_set( "obj_start_goto_razorback" );
    common_scripts\utility::flag_set( "obj_move_dot_razorback" );
    common_scripts\utility::flag_set( "start_background_elements" );
    common_scripts\utility::flag_set( "fallback_vol_3" );
    common_scripts\utility::flag_set( "unhide_cargo" );

    if ( var_0 == "cave_entry" )
        return;

    setsaveddvar( "r_gunSightColorEntityScale", 0 );
    setsaveddvar( "r_gunSightColorNoneScale", 0 );
    common_scripts\utility::flag_set( "player_loading_cargo" );
    common_scripts\utility::flag_set( "obj_update_goto_razorback" );
    common_scripts\utility::flag_set( "obj_end_goto_razorback" );
    common_scripts\utility::flag_set( "obj_start_locate_chopper" );

    if ( var_0 == "cave_hallway" )
        return;

    common_scripts\utility::flag_set( "obj_start_prometheus_drone" );
    common_scripts\utility::flag_set( "obj_end_prometheus_drone" );

    if ( var_0 == "big_cave" )
        return;

    common_scripts\utility::flag_set( "obj_start_resonance_wall" );
    common_scripts\utility::flag_set( "obj_end_resonance_wall" );

    if ( var_0 == "ice_bridge" )
        return;

    common_scripts\utility::flag_set( "crash_lighting_goliath_pit" );

    if ( var_0 == "narrow_cave" )
        return;

    common_scripts\utility::flag_set( "obj_follow_cormack_combat_to_lake" );

    if ( var_0 == "combat_cave" )
        return;

    if ( var_0 == "overlook" )
        return;

    common_scripts\utility::flag_set( "lake_begin_outdoors" );
    common_scripts\utility::flag_set( "obj_end_locate_chopper" );

    if ( var_0 == "lake" )
        return;

    common_scripts\utility::flag_set( "lake_start_collapse" );
    common_scripts\utility::flag_set( "lake_start_left" );
    common_scripts\utility::flag_set( "obj_start_recover_cargo" );
    common_scripts\utility::flag_set( "obj_start_lake_sniper_rifle" );
    common_scripts\utility::flag_set( "obj_end_lake_sniper_rifle" );
    common_scripts\utility::flag_set( "cargo_captured" );
    common_scripts\utility::flag_set( "go_gideon_moment" );

    if ( var_0 == "lake_cinema" )
        return;

    common_scripts\utility::flag_set( "cormack_start_vtol" );
    common_scripts\utility::flag_set( "obj_lake_fall" );
    common_scripts\utility::flag_set( "obj_lake_gideon_save" );
    common_scripts\utility::flag_set( "gideon_frees_you" );

    if ( var_0 == "vtol_takedown" )
        return;
}

give_boost_jump()
{
    if ( maps\_utility::is_default_start() )
        return;

    var_0 = level.start_point;

    if ( var_0 == "skyjack" )
        return;

    maps\_player_high_jump::enable_high_jump();
}

give_player_exo()
{
    if ( maps\_utility::is_default_start() )
        return;

    var_0 = level.start_point;

    if ( var_0 == "skyjack" || var_0 == "crash_site" )
        return;

    thread maps\crash_utility::player_exo_enable();
}

set_up_exo_temperature()
{
    var_0 = level.start_point;

    if ( maps\_utility::is_default_start() || var_0 == "skyjack" )
    {
        common_scripts\utility::flag_wait( "player_landed_on_plane" );
        wait 2.5;
        level.player thread maps\crash_exo_temperature::create_exo_temperature_hud( level.temperature_high_alt_wind );
        level.player thread maps\crash_exo_temperature::set_exo_temperature_over_time( level.exo_max, 0.05 );
        level.player thread maps\crash_exo_temperature::set_operator_temperature_over_time( 98.6, 0.05 );
        level.player thread maps\crash_utility::exo_temp_high_altitude();
        common_scripts\utility::flag_set( "start_skyjack_temperature" );
        return;
    }

    if ( var_0 == "crash_site" )
    {
        level.player thread maps\crash_exo_temperature::create_exo_temperature_hud( level.temperature_outdoor );
        level.player thread maps\crash_exo_temperature::set_exo_temperature_over_time( level.exo_max, 0.05 );
        level.player thread maps\crash_exo_temperature::set_operator_temperature_over_time( 98.6, 0.05 );
        return;
    }

    if ( var_0 == "cave_entry" )
    {
        level.player thread maps\crash_exo_temperature::create_exo_temperature_hud( level.temperature_outdoor );
        level.player thread maps\crash_exo_temperature::set_exo_temperature_over_time( level.exo_max, 0.05 );
        level.player thread maps\crash_exo_temperature::set_operator_temperature_over_time( 98.6, 0.05 );
        return;
    }

    if ( var_0 == "cave_hallway" )
    {
        level.player thread maps\crash_exo_temperature::create_exo_temperature_hud( level.temperature_outdoor );
        level.player thread maps\crash_exo_temperature::set_exo_temperature_over_time( level.exo_max, 0.05 );
        level.player thread maps\crash_exo_temperature::set_operator_temperature_over_time( 98.6, 0.05 );
        return;
    }

    if ( var_0 == "big_cave" )
    {
        level.player thread maps\crash_exo_temperature::create_exo_temperature_hud( level.temperature_deep_caves );
        level.player thread maps\crash_exo_temperature::set_exo_temperature_over_time( level.exo_max, 0.05 );
        level.player thread maps\crash_exo_temperature::set_operator_temperature_over_time( 98.6, 0.05 );
        return;
    }

    if ( var_0 == "ice_bridge" )
    {
        level.player thread maps\crash_exo_temperature::create_exo_temperature_hud( level.temperature_deep_caves );
        level.player thread maps\crash_exo_temperature::set_exo_temperature_over_time( level.exo_max, 0.05 );
        level.player thread maps\crash_exo_temperature::set_operator_temperature_over_time( 98.6, 0.05 );
        return;
    }

    if ( var_0 == "narrow_cave" )
    {
        level.player thread maps\crash_exo_temperature::create_exo_temperature_hud( level.temperature_deep_caves );
        level.player thread maps\crash_exo_temperature::set_exo_temperature_over_time( 68, 0.05 );
        level.player thread maps\crash_exo_temperature::set_operator_temperature_over_time( 95.6, 0.05 );
        return;
    }

    if ( var_0 == "combat_cave" )
    {
        level.player thread maps\crash_exo_temperature::create_exo_temperature_hud( level.temperature_indoor );
        level.player thread maps\crash_exo_temperature::set_exo_temperature_over_time( level.exo_max, 0.05 );
        level.player thread maps\crash_exo_temperature::set_operator_temperature_over_time( 98.6, 0.05 );
        return;
    }

    if ( var_0 == "overlook" )
    {
        level.player thread maps\crash_exo_temperature::create_exo_temperature_hud( level.temperature_outdoor );
        level.player thread maps\crash_exo_temperature::set_exo_temperature_over_time( level.exo_max, 0.05 );
        level.player thread maps\crash_exo_temperature::set_operator_temperature_over_time( 98.6, 0.05 );
        return;
    }

    if ( var_0 == "lake" )
    {
        level.player thread maps\crash_exo_temperature::create_exo_temperature_hud( level.temperature_indoor );
        level.player thread maps\crash_exo_temperature::set_exo_temperature_over_time( level.exo_max, 0.05 );
        level.player thread maps\crash_exo_temperature::set_operator_temperature_over_time( 98.6, 0.05 );
        return;
    }

    if ( var_0 == "lake_cinema" )
    {
        level.player thread maps\crash_exo_temperature::create_exo_temperature_hud( level.temperature_water );
        level.player thread maps\crash_exo_temperature::set_exo_temperature_over_time( 65, 0.05 );
        level.player thread maps\crash_exo_temperature::set_operator_temperature_over_time( 94.2, 0.05 );
        return;
    }

    if ( var_0 == "vtol_takedown" )
    {
        level.player thread maps\crash_exo_temperature::create_exo_temperature_hud( level.temperature_outdoor );
        level.player thread maps\crash_exo_temperature::set_exo_temperature_over_time( level.exo_max, 0.05 );
        level.player thread maps\crash_exo_temperature::set_operator_temperature_over_time( 98.6, 0.05 );
    }
}

objective_flag_init()
{
    common_scripts\utility::flag_init( "obj_start_plant_charges" );
    common_scripts\utility::flag_init( "obj_end_plant_charges" );
    common_scripts\utility::flag_init( "obj_start_goto_razorback" );
    common_scripts\utility::flag_init( "obj_move_dot_razorback" );
    common_scripts\utility::flag_init( "obj_update_goto_razorback" );
    common_scripts\utility::flag_init( "obj_end_goto_razorback" );
    common_scripts\utility::flag_init( "obj_start_locate_chopper" );
    common_scripts\utility::flag_init( "obj_end_locate_chopper" );
    common_scripts\utility::flag_init( "obj_hall_follow_start" );
    common_scripts\utility::flag_init( "obj_hall_follow_end" );
    common_scripts\utility::flag_init( "obj_follow_pod_room" );
    common_scripts\utility::flag_init( "FLAG_stop_follow_dot" );
    common_scripts\utility::flag_init( "goliath_exit_dot_start" );
    common_scripts\utility::flag_init( "goliath_exit_dot_end" );
    common_scripts\utility::flag_init( "obj_reso_move_start" );
    common_scripts\utility::flag_init( "obj_reso_move_end" );
    common_scripts\utility::flag_init( "narrow_cave_dot_start" );
    common_scripts\utility::flag_init( "narrow_cave_dot_update" );
    common_scripts\utility::flag_init( "narrow_cave_dot_end" );
    common_scripts\utility::flag_init( "obj_follow_cormack_combat_to_lake" );
    common_scripts\utility::flag_init( "obj_start_prometheus_drone" );
    common_scripts\utility::flag_init( "obj_end_prometheus_drone" );
    common_scripts\utility::flag_init( "obj_start_resonance_wall" );
    common_scripts\utility::flag_init( "obj_end_resonance_wall" );
    common_scripts\utility::flag_init( "obj_start_get_gun" );
    common_scripts\utility::flag_init( "obj_update_get_gun" );
    common_scripts\utility::flag_init( "obj_end_get_gun" );
    common_scripts\utility::flag_init( "obj_start_overlook_run" );
    common_scripts\utility::flag_init( "obj_end_overlook_run" );
    common_scripts\utility::flag_init( "obj_lake_enter" );
    common_scripts\utility::flag_init( "obj_lake_fall" );
    common_scripts\utility::flag_init( "obj_lake_gideon_save" );
    common_scripts\utility::flag_init( "obj_start_recover_cargo" );
    common_scripts\utility::flag_init( "obj_final_recover_cargo" );
    common_scripts\utility::flag_init( "obj_end_recover_cargo" );
    common_scripts\utility::flag_init( "obj_start_lake_sniper_rifle" );
    common_scripts\utility::flag_init( "obj_end_lake_sniper_rifle" );
    common_scripts\utility::flag_init( "obj_start_exfil" );
    common_scripts\utility::flag_init( "obj_end_exfil" );
    precachestring( &"CRASH_OBJ_SKYJACK" );
    precachestring( &"CRASH_OBJ_PLANT" );
    precachestring( &"CRASH_OBJ_DEFEND_CARGO" );
    precachestring( &"CRASH_OBJ_PUSH" );
    precachestring( &"CRASH_OBJ_FOLLOW" );
    precachestring( &"CRASH_OBJ_SUPPORT" );
    precachestring( &"CRASH_OBJ_FIND_CHOPPER" );
    precachestring( &"CRASH_OBJ_PICKUP" );
    precachestring( &"CRASH_OBJ_HIDE" );
    precachestring( &"CRASH_OBJ_RECOVER_CARGO" );
    precachestring( &"CRASH_OBJ_RECOVER" );
    precachestring( &"CRASH_OBJ_DESTROY_WARBIRD" );
    precachestring( &"CRASH_OBJ_DESTROY" );
}

objective_init()
{
    obj_plant_charges();
    obj_goto_razorback();
    thread obj_locate_chopper();
    thread obj_get_gun();
    thread obj_recover_cargo();
    thread obj_underwater();
    obj_destroy_vtol();
}

obj_plant_charges()
{
    common_scripts\utility::flag_wait( "obj_start_plant_charges" );
    objective_add( 1, "current", &"CRASH_OBJ_SKYJACK" );
    var_0 = common_scripts\utility::getstruct( "charge_x_objective", "targetname" );
    objective_position( 1, var_0.origin );
    objective_setpointertextoverride( 1, &"CRASH_OBJ_PLANT" );
    thread maps\crash_utility::handle_objective_marker_skyjack( var_0, "obj_end_plant_charges" );
    common_scripts\utility::flag_wait( "obj_end_plant_charges" );
    maps\_utility::objective_complete( 1 );
}

obj_goto_razorback()
{
    common_scripts\utility::flag_wait( "obj_start_goto_razorback" );
    objective_add( 3, "current", &"CRASH_OBJ_DEFEND_CARGO" );
    objective_onentity( 3, level.cormack, ( 0, 0, 72 ) );
    objective_setpointertextoverride( 3, &"CRASH_OBJ_FOLLOW" );
    common_scripts\utility::flag_wait( "obj_move_dot_razorback" );
    maps\_utility::objective_clearadditionalpositions( 3 );
    level.razorback_org = getent( "cargo_objective", "targetname" );
    var_0 = level.razorback_org;
    objective_position( 3, var_0.origin );
    objective_setpointertextoverride( 3, &"CRASH_OBJ_PUSH" );
    thread maps\crash_utility::handle_objective_marker( var_0, "player_loading_cargo", undefined, "cargo_trigger" );
    common_scripts\utility::flag_wait( "player_loading_cargo" );
    objective_state_nomessage( 3, "invisible" );
    common_scripts\utility::flag_wait( "obj_update_goto_razorback" );

    if ( !common_scripts\utility::flag( "start_bunker_collapse" ) )
    {
        objective_onentity( 3, level.cormack, ( 0, 0, 72 ) );
        objective_setpointertextoverride( 3, &"CRASH_OBJ_SUPPORT" );
        objective_state_nomessage( 3, "current" );
    }

    common_scripts\utility::flag_wait( "obj_end_goto_razorback" );
    maps\_utility::objective_complete( 3 );
}

obj_locate_chopper()
{
    common_scripts\utility::flag_wait( "obj_start_locate_chopper" );
    objective_add( 4, "current", &"CRASH_OBJ_FIND_CHOPPER" );
    thread pro_hall_follow_dot();
    thread golaith_exit_distance_dot();
    thread reso_bridge_distantce_dot();
    thread narrow_cave_follow_dot();
    thread combat_cave_to_lake_follow_dot();
    thread obj_overlook();
    common_scripts\utility::flag_wait( "obj_end_locate_chopper" );
    maps\_utility::objective_complete( 4 );
}

pro_hall_follow_dot()
{
    level endon( "obj_follow_pod_room" );
    common_scripts\utility::flag_wait( "obj_hall_follow_start" );
    objective_onentity( 4, level.cormack, ( 0, 0, 72 ) );
    objective_setpointertextoverride( 4, &"CRASH_OBJ_FOLLOW" );
    common_scripts\utility::flag_wait( "cormack_turkey_talk_hold" );
    maps\_utility::objective_clearadditionalpositions( 4 );
    common_scripts\utility::flag_wait( "wakeup_turkey" );
    objective_onentity( 4, level.cormack, ( 0, 0, 72 ) );
    objective_setpointertextoverride( 4, &"CRASH_OBJ_FOLLOW" );
    common_scripts\utility::flag_wait( "FLAG_caves_goliath" );
    maps\_utility::objective_clearadditionalpositions( 4 );
}

golaith_exit_distance_dot()
{
    common_scripts\utility::flag_wait( "goliath_exit_dot_start" );
    wait 1;
    maps\_utility::objective_clearadditionalpositions( 4 );
    var_0 = getent( "obj_exit_golaith", "targetname" );
    objective_additionalposition( 4, 1, var_0.origin );
    objective_setpointertextoverride( 4, "" );
    common_scripts\utility::flag_wait( "goliath_exit_dot_end" );
    maps\_utility::objective_clearadditionalpositions( 4 );
}

reso_bridge_distantce_dot()
{
    common_scripts\utility::flag_wait( "obj_reso_move_start" );
    var_0 = common_scripts\utility::getstruct( "obj_node_reso_device", "targetname" );
    objective_additionalposition( 4, 1, var_0.origin );
    objective_setpointertextoverride( 4, "" );
    common_scripts\utility::flag_wait( "obj_reso_move_end" );
    maps\_utility::objective_clearadditionalpositions( 4 );
}

narrow_cave_follow_dot()
{
    common_scripts\utility::flag_wait( "narrow_cave_dot_start" );
    objective_onentity( 4, level.cormack, ( 0, 0, 72 ) );
    objective_setpointertextoverride( 4, &"CRASH_OBJ_FOLLOW" );
    common_scripts\utility::flag_wait( "narrow_cave_dot_update" );
    var_0 = common_scripts\utility::getstruct( "breach_obj_dot", "targetname" );
    objective_position( 4, var_0.origin );
    objective_setpointertextoverride( 4, "" );
    common_scripts\utility::flag_wait( "narrow_cave_dot_end" );
    maps\_utility::objective_clearadditionalpositions( 4 );
}

combat_cave_to_lake_follow_dot()
{
    common_scripts\utility::flag_wait( "obj_follow_cormack_combat_to_lake" );
    objective_onentity( 4, level.cormack, ( 0, 0, 72 ) );
    objective_setpointertextoverride( 4, &"CRASH_OBJ_FOLLOW" );
    common_scripts\utility::flag_wait( "ice_lake_start_combat" );
    maps\_utility::objective_clearadditionalpositions( 4 );
}

obj_use_drone()
{
    common_scripts\utility::flag_wait( "obj_start_prometheus_drone" );
    objective_add( 5, "current", "Use the cave scanning drone" );
    common_scripts\utility::flag_wait( "obj_end_prometheus_drone" );
    maps\_utility::objective_complete( 5 );
}

obj_overlook()
{
    common_scripts\utility::flag_wait( "obj_start_overlook_run" );
    var_0 = common_scripts\utility::getstruct( "overlook_main_obj", "targetname" );

    if ( isdefined( var_0 ) )
    {
        objective_setpointertextoverride( 4, "" );
        maps\_utility::objective_clearadditionalpositions( 4 );
        objective_position( 4, var_0.origin );
    }

    common_scripts\utility::flag_wait( "obj_end_overlook_run" );
    var_0 = common_scripts\utility::getstruct( "overlook_exit_obj", "targetname" );

    if ( isdefined( var_0 ) )
    {
        objective_setpointertextoverride( 4, "" );
        maps\_utility::objective_clearadditionalpositions( 4 );
        objective_position( 4, var_0.origin );
    }

    common_scripts\utility::flag_wait( "obj_lake_enter" );
    objective_onentity( 4, level.cormack, ( 0, 0, 72 ) );
    objective_setpointertextoverride( 4, &"CRASH_OBJ_FOLLOW" );
}

obj_get_gun()
{
    common_scripts\utility::flag_wait( "obj_start_get_gun" );
    objective_add( 7, "current" );
    var_0 = common_scripts\utility::getstruct( "stinger_x_objective", "targetname" );

    if ( isdefined( var_0 ) )
    {
        objective_position( 7, var_0.origin );
        objective_setpointertextoverride( 7, &"CRASH_OBJ_PICKUP" );
        thread maps\crash_utility::handle_objective_marker( var_0, "obj_update_get_gun", undefined, "heli_weapon_trigger" );
    }

    common_scripts\utility::flag_wait( "obj_update_get_gun" );
    var_1 = common_scripts\utility::getstruct( "vtol_hide_01", "targetname" );
    objective_position( 7, var_1.origin );
    objective_setpointertextoverride( 7, &"CRASH_OBJ_HIDE" );
    common_scripts\utility::flag_wait( "obj_end_get_gun" );
    maps\_utility::objective_complete( 7 );
}

obj_recover_cargo()
{
    common_scripts\utility::flag_wait( "obj_start_recover_cargo" );
    objective_add( 8, "current", &"CRASH_OBJ_RECOVER_CARGO" );

    if ( isdefined( level.cargo ) )
    {
        var_0 = level.cargo;
        maps\_utility::objective_clearadditionalpositions( 8 );
        objective_setpointertextoverride( 8, &"CRASH_OBJ_RECOVER" );
        objective_onentity( 8, var_0 );
    }
}

obj_underwater()
{
    common_scripts\utility::flag_wait( "obj_lake_fall" );
    maps\_utility::objective_clearadditionalpositions( 8 );
    objective_add( 9, "current" );
    var_0 = common_scripts\utility::getstruct( "lake_underwater_obj_struct", "targetname" );
    objective_position( 9, var_0.origin );
    common_scripts\utility::flag_wait( "obj_lake_gideon_save" );
    maps\_utility::objective_complete( 9 );
    common_scripts\utility::flag_wait( "obj_final_recover_cargo" );
    maps\_utility::objective_clearadditionalpositions( 9 );
    objective_onentity( 8, level.final_loc );
    objective_setpointertextoverride( 8, &"CRASH_OBJ_RECOVER" );
    thread maps\crash_utility::handle_objective_marker_movable( level.final_use_struct, "obj_end_recover_cargo" );
    common_scripts\utility::flag_wait( "obj_end_recover_cargo" );
    maps\_utility::objective_complete( 8 );
}

obj_lake_sniper_rifle()
{
    common_scripts\utility::flag_wait( "obj_start_lake_sniper_rifle" );
}

obj_destroy_vtol()
{
    common_scripts\utility::flag_wait( "obj_start_exfil" );
    objective_add( 10, "current", &"CRASH_OBJ_DESTROY_WARBIRD" );
    var_0 = level.end_vtol common_scripts\utility::spawn_tag_origin();
    var_0 linkto( level.end_vtol );
    objective_onentity( 10, var_0, ( 0, 0, 160 ) );
    objective_setpointertextoverride( 10, &"CRASH_OBJ_DESTROY" );
    common_scripts\utility::flag_wait( "obj_end_exfil" );
    maps\_utility::objective_complete( 10 );
}

create_fx_ent_setup()
{
    wait 2;
    level.crash_site_animnode = common_scripts\utility::getstruct( "crash_site_animnode", "targetname" );
    var_0 = getent( "crash_site_plane", "targetname" );
    var_1 = getent( "crash_site_plane_snow", "targetname" );
    var_0.animname = "cargo_plane";
    var_0 maps\_anim::setanimtree();
    level.crash_site_animnode maps\_anim::anim_first_frame_solo( var_0, "atlas_plane_crash_plane" );
    waitframe();
    level.crash_site_animnode thread maps\_anim::anim_single_solo( var_0, "atlas_plane_crash_plane" );
    wait 1;
    var_0 setanimtime( var_0 maps\_utility::getanim( "atlas_plane_crash_plane" ), 1.0 );
    var_1 show();
    var_2 = getent( "runway_shell_geo_01", "targetname" );
    var_3 = getent( "runway_shell_geo_02", "targetname" );
    var_4 = getent( "runway_shell_geo_03", "targetname" );
    var_5 = getent( "runway_shell_geo_04", "targetname" );
    var_6 = getent( "runway_shell_geo_05", "targetname" );
    var_7 = getent( "runway_shell_geo_06", "targetname" );
    var_8 = getent( "runway_shell_geo_07", "targetname" );
    var_9 = getent( "runway_shell_geo_08", "targetname" );
    var_10 = getent( "runway_shell_geo_09", "targetname" );
    var_11 = getent( "runway_shell_geo_10", "targetname" );
    var_12 = getent( "runway_shell_geo_11", "targetname" );
    var_2 delete();
    var_3 delete();
    var_4 delete();
    var_5 delete();
    var_6 delete();
    var_7 delete();
    var_8 delete();
    var_9 delete();
    var_10 delete();
    var_11 delete();
    var_12 delete();
    var_13 = getentarray( "crash_site_scorching", "targetname" );

    foreach ( var_15 in var_13 )
        var_15 show();

    var_17 = getentarray( "crash_site_debris_models", "targetname" );

    foreach ( var_19 in var_17 )
        var_19 show();
}
