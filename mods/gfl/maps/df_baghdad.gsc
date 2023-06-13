// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

main()
{
    maps\_utility::template_level( "df_baghdad" );
    maps\_utility::set_console_status();
    maps\createart\df_baghdad_art::main();
    maps\df_baghdad_fx::main();
    level.vehicle_death_fx_override["script_vehicle_xh9_warbird_no_zipline_atlas_desert"] = 1;
    maps\df_baghdad_precache::main();
    df_baghdad_pre_load();
    df_baghdad_starts();

    if ( level.currentgen )
        maps\_utility::tff_sync_setup();

    maps\df_baghdad_vo::main();
    maps\_mech_grapple::mech_grapple_init();

    if ( getdvar( "createfx" ) != "" )
        thread create_fx_ent_setup();

    maps\_load::main();
    thread maps\_player_exo::main( "assault" );
    maps\df_baghdad_lighting::main();
    maps\df_baghdad_aud::main();
    thread df_baghdad_global_spawnfunctions();
    df_baghdad_precache();
    maps\df_baghdad_anim::main();
    maps\_car_door_shield::init_door_shield();
    maps\_player_high_jump::main();
    maps\_variable_grenade::main();
    maps\_vehicle::build_deathfx_override( "script_vehicle_xh9_warbird_no_zipline_atlas_desert", undefined, "vehicle_xh9_warbird_desert", "vfx/map/baghdad/bagh_warbird_explosion_midair", "tag_origin", "sfb_warbird_death_explo", undefined, undefined, undefined, -1, 1 );
    setsaveddvar( "high_jump_double_tap", "1" );
    animscripts\traverse\boost::precache_boost_fx_npc();
    maps\_grapple::main( "s1_gfl_ump45_viewbody", "s1_gfl_ump45_viewhands" );
    setdvar( "grapple_magnet_required", 1 );
    setdvar( "grapple_concealed_kill", 0 );
    var_0 = getdvarint( "scr_traverse_debug" );
    setsaveddvar( "high_jump_auto_mantle", "1" );
    setsaveddvar( "moving_platform_keep_previous", "0" );

    if ( level.currentgen )
    {
        setsaveddvar( "r_gunSightColorEntityScale", "7" );
        setsaveddvar( "r_gunSightColorNoneScale", "0.8" );
    }

    maps\_drone_ai::init();
    vehicle_scripts\_attack_drone_common::attack_drone_formation_init();
    vehicle_scripts\_attack_drone::drone_swarm_init();

    if ( level.currentgen )
        tff_setup_transitions();

    if ( level.currentgen )
    {
        var_1 = [];
        var_2 = [ "neverDelete", "mech1_streets", "mech3_streets", "mech4_streets" ];
        thread maps\_cg_encounter_perf_monitor::cg_spawn_perf_monitor( "", undefined, 14, 0, var_2 );
    }
}

df_baghdad_precache()
{
    precacheitem( "rpg_player" );
    precacheitem( "bagh_mahem_cheaptrail" );
    precacheitem( "rsass_silenced" );
    precacheitem( "iw5_mors_sp_morsscope" );
    precacheitem( "iw5_titan45_sp" );
    precacheitem( "iw5_himar_sp" );
    precachemodel( "sentinel_drop_pod" );
    precachemodel( "viewhands_sentinel_pilot_mitchell" );
    precachemodel( "viewbody_sentinel_pilot_mitchell" );
    precachemodel( "viewbody_sentinel_pilot_mitchell_grapple" );
    precachemodel( "cluster_bomb_sphere_static" );
    precachemodel( "sentinel_survey_drone_sphere_ai_swarm" );
    precacherumble( "dna_carpet_bomb" );
}

df_baghdad_starts()
{
    maps\_utility::add_start( "intro", maps\df_baghdad_intro::setup_intro, "Intro", maps\df_baghdad_intro::begin_intro );
    maps\_utility::add_start( "snipers", maps\df_baghdad_snipers::setup_snipers, "Snipers", maps\df_baghdad_snipers::begin_snipers );
    maps\_utility::add_start( "post_tower", maps\df_baghdad_post_tower_combat::setup_post_tower, "Barracks Approach", maps\df_baghdad_post_tower_combat::begin_post_tower );
    maps\_utility::add_start( "dnabomb", maps\df_baghdad_dnabomb::setup_dnabomb, "Boom!", maps\df_baghdad_dnabomb::begin_dnabomb );
    maps\_utility::add_start( "capture", maps\df_baghdad_dnabomb::setup_capture, "Captured", maps\df_baghdad_dnabomb::begin_capture );

    // level.start_point = "dnabomb";
    if ( level.currentgen )
        tff_setup_start_points();
}

df_baghdad_global_spawnfunctions()
{
    maps\_utility::add_global_spawn_function( "axis", ::df_cheap_rpgs );
    maps\_utility::add_global_spawn_function( "axis", ::df_global_accuracy );
    maps\_utility::add_global_spawn_function( "axis", ::df_enable_boostjump );
}

df_cheap_rpgs()
{
    if ( !issubstr( self.classname, "rpg" ) )
        return;

    if ( isremovedentity( self ) || !isdefined( self ) )
        return;

    maps\_utility::forceuseweapon( "bagh_mahem_cheaptrail", "primary" );
}

df_enable_boostjump()
{
    if ( !issubstr( self.classname, "jump" ) )
        return;

    if ( isremovedentity( self ) || !isdefined( self ) )
        return;

    self.canjumppath = 10;
}

df_global_accuracy()
{
    if ( isremovedentity( self ) || !isdefined( self ) )
        return;

    if ( !issubstr( self.classname, "mech" ) )
        maps\_utility::set_baseaccuracy( 0.9 );
    else
        maps\_utility::set_baseaccuracy( 0.7 );
}

tff_setup_start_points()
{
    var_0 = [ "df_baghdad_intro_tr" ];
    maps\_utility::set_start_transients( "intro", var_0 );
    var_0[0] = "df_baghdad_middle_tr";
    maps\_utility::set_start_transients( "snipers", var_0 );
    maps\_utility::set_start_transients( "post_tower", var_0 );
    var_0[0] = "df_baghdad_outro_tr";
    maps\_utility::set_start_transients( "dnabomb", var_0 );
}

tff_setup_transitions()
{
    if ( !istransientloaded( "df_baghdad_middle_tr" ) )
        thread tff_trans_intro_to_middle();

    if ( !istransientloaded( "df_baghdad_outro_tr" ) )
        thread tff_trans_middle_to_outro();
}

tff_trans_intro_to_middle()
{
    common_scripts\utility::flag_wait( "flag_tff_trans_intro_to_middle" );
    level notify( "tff_pre_intro_to_middle" );
    unloadtransient( "df_baghdad_intro_tr" );
    loadtransient( "df_baghdad_middle_tr" );

    while ( !istransientloaded( "df_baghdad_middle_tr" ) )
        wait 0.05;

    level notify( "tff_post_intro_to_middle" );
}

tff_trans_middle_to_outro()
{
    common_scripts\utility::flag_wait( "flag_tff_trans_middle_to_outro" );
    level notify( "tff_pre_middle_to_outro" );
    unloadtransient( "df_baghdad_middle_tr" );
    loadtransient( "df_baghdad_outro_tr" );

    while ( !istransientloaded( "df_baghdad_outro_tr" ) )
        wait 0.05;

    level notify( "tff_post_middle_to_outro" );
}

df_baghdad_pre_load()
{
    maps\df_baghdad_intro::df_baghdad_intro_pre_load();
    maps\df_baghdad_combat::df_baghdad_combat_pre_load();
    maps\df_baghdad_dnabomb::df_baghdad_dnabomb_pre_load();
    maps\df_baghdad_post_tower_combat::df_baghdad_post_tower_pre_load();
}

#using_animtree("animated_props");

create_fx_ent_setup()
{
    level.scr_animtree["pergola"] = #animtree;
    level.scr_model["pergola"] = "nb_pergola_anim";
    level.scr_anim["pergola"]["intro_pod_scene"] = %dogfight_shore_briefing_pergola;
    wait 1;
    var_0 = maps\_utility::spawn_anim_model( "pergola" );
    var_1 = common_scripts\utility::getstruct( "intro_beach_animate_to", "targetname" );
    var_1 maps\_anim::anim_first_frame_solo( var_0, "intro_pod_scene" );
    var_2 = 1;
    var_3 = 0.62;

    for (;;)
    {
        level notify( "starting_pergola_createfx" );

        if ( !var_2 )
        {
            var_1 thread maps\_anim::anim_single_solo( var_0, "intro_pod_scene" );
            continue;
        }

        var_1 thread maps\_anim::anim_single_solo( var_0, "intro_pod_scene" );
        wait 0.05;
        var_0 setanimtime( level.scr_anim["pergola"]["intro_pod_scene"], var_3 );
        var_0 waittillmatch( "single anim", "end" );
    }
}
