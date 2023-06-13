// S1 GSC SOURCE
// Dumped by https://github.com/xensik/gsc-tool

df_baghdad_intro_pre_load()
{
    common_scripts\utility::flag_init( "active_zone_finished" );
    common_scripts\utility::flag_init( "stop_all_zones" );
    common_scripts\utility::flag_init( "player_in_zone_barracks" );
    common_scripts\utility::flag_init( "player_in_zone_snipers" );
    common_scripts\utility::flag_init( "player_in_zone_tank" );
    common_scripts\utility::flag_init( "completed_zone_barracks" );
    common_scripts\utility::flag_init( "completed_zone_snipers" );
    common_scripts\utility::flag_init( "completed_zone_tank" );
    common_scripts\utility::flag_init( "zone_alerted_barracks" );
    common_scripts\utility::flag_init( "zone_alerted_snipers" );
    common_scripts\utility::flag_init( "zone_alerted_tank" );
    common_scripts\utility::flag_init( "zone_aborted_barracks" );
    common_scripts\utility::flag_init( "zone_aborted_snipers" );
    common_scripts\utility::flag_init( "zone_aborted_tank" );
    common_scripts\utility::flag_init( "snipers_move_to_top" );
    common_scripts\utility::flag_init( "sniper_cleared_roof" );
    common_scripts\utility::flag_init( "player_jump_off_roof" );
    common_scripts\utility::flag_init( "snipers_dead1" );
    common_scripts\utility::flag_init( "snipers_dead2" );
    common_scripts\utility::flag_init( "snipers_dead3" );
    common_scripts\utility::flag_init( "destroy_ally_right_tank" );
    common_scripts\utility::flag_init( "FLAG_snipers_kill_2" );
    common_scripts\utility::flag_init( "FLAG_snipers_kill_4" );
    common_scripts\utility::flag_init( "FLAG_snipers_kill_6" );
    common_scripts\utility::flag_init( "FLAG_snipers_kill_8" );
    common_scripts\utility::flag_init( "flag_reach_ilona_complete" );
    common_scripts\utility::flag_init( "flag_kickoff_VTOL_battle" );
    common_scripts\utility::flag_init( "flag_kickoff_VTOL_battle2" );
    common_scripts\utility::flag_init( "flag_start_propwash1" );
    common_scripts\utility::flag_init( "flag_end_propwash1" );
    common_scripts\utility::flag_init( "flag_turret2_lookat_spawns" );
    common_scripts\utility::flag_init( "approach_atlas_snipers_finished" );
    common_scripts\utility::flag_init( "approach_atlas" );
    common_scripts\utility::flag_init( "start_intro_anims" );
    common_scripts\utility::flag_init( "flag_head_to_snipers" );
    common_scripts\utility::flag_init( "sniper_support1" );
    common_scripts\utility::flag_init( "flag_heroes_shift_front1" );
    common_scripts\utility::flag_init( "display_boost_hint" );
    common_scripts\utility::flag_init( "ignore_outofbounds_clip" );
    common_scripts\utility::flag_init( "pergola_break" );
    thread intro_post_load();
    maps\_utility::add_hint_string( "boost_jump", &"DF_BAGHDAD_HINT_BOOST_JUMP", ::should_break_boost_jump_hint );
    maps\_utility::add_hint_string( "leave_mission", &"DF_BAGHDAD_WARN_LEAVEMISSION", maps\df_baghdad_code::should_break_leave_mission_hint );
    precacherumble( "heavy_3s" );
    precachemodel( "vehicle_xh9_warbird_pulley" );
    precachemodel( "vehicle_x4walker_wheels" );
    precachemodel( "com_hand_radio" );
    precachemodel( "trq_outdoor_umbrella_01_longlod" );
    precachemodel( "cafe_table_01_longlod" );
    precachemodel( "cafe_chair_02_longlod" );
    precachemodel( "nb_pergola_anim" );
}

intro_post_load()
{
    level waittill( "load_finished" );
}

setup_intro()
{
    level.start_point = "intro";
    maps\df_baghdad_code::setup_common();
    thread maps\df_baghdad_combat::ambient_combat_axis();
    thread maps\df_baghdad_combat::ambient_combat_allies();
    soundscripts\_snd::snd_message( "snd_start_intro" );
}

begin_intro()
{
    thread intro_beach_invasion();
    thread pod_flyin();
    thread surveillance_post_anims();

    if ( level.nextgen )
        thread palm_anims();

    wait 0.05;
    maps\df_baghdad_code::safe_activate_trigger_with_targetname( "beach_briefing_colors" );
    wait 2;
    level.allies[0] maps\_utility::clear_generic_idle_anim();
    level.allies[1] maps\_utility::clear_generic_idle_anim();
    thread player_boost_hint();
    common_scripts\utility::flag_wait( "player_on_intro_balcony" );
    thread intro_dialog();
}

intro_vo()
{
    level.allies[0] maps\_utility::smart_radio_dialogue_interrupt( "df_gid_wildride" );
    maps\_utility::smart_radio_dialogue_interrupt( "df_iln_damnsector" );
    level.allies[0] maps\_utility::smart_radio_dialogue_interrupt( "df_gid_gohigh1" );
}

player_boost_hint()
{
    common_scripts\utility::flag_wait( "display_boost_hint" );
    level.player maps\_utility::display_hint_timeout( "boost_jump", 8 );
}

should_break_boost_jump_hint()
{
    return level.player ishighjumping();
}

surveillance_post_anims()
{
    var_0 = getentarray( "surveillance_post", "targetname" );

    foreach ( var_2 in var_0 )
    {
        var_2.animname = "surveillance_post";
        wait 0.25;
        var_2 maps\_anim::setanimtree();
        var_2 thread maps\_anim::anim_loop_solo( var_2, "surveillance_post_idle" );
    }
}

palm_anims()
{
    var_0 = getentarray( "palm_01_anim", "targetname" );

    foreach ( var_2 in var_0 )
    {
        var_2.animname = "palm_01_anim";
        wait 0.25;
        var_2 maps\_anim::setanimtree();

        if ( common_scripts\utility::cointoss() )
        {
            var_2 thread maps\_anim::anim_loop_solo( var_2, "palm_01_anim_heavy" );
            continue;
        }

        var_2 thread maps\_anim::anim_loop_solo( var_2, "palm_01_anim_light" );
    }
}

intro_dialog()
{
    level.allies[2] maps\_utility::smart_radio_dialogue_interrupt( "df_iln_deadahead2" );
    level.allies[0] maps\_utility::smart_radio_dialogue_interrupt( "df_gid_advancingon" );
    wait 0.35;
    maps\_utility::smart_radio_dialogue_interrupt( "df_dav_moresquads" );
    wait 1;
    level.allies[0] maps\_utility::smart_radio_dialogue_interrupt( "df_gid_breakline" );
    thread watch_tower_nags();
    var_0 = 10;

    while ( !common_scripts\utility::flag( "player_near_tower" ) )
    {
        common_scripts\utility::flag_wait_or_timeout( "player_near_tower", var_0 );

        if ( !common_scripts\utility::flag( "player_near_tower" ) )
        {
            if ( common_scripts\utility::mod( var_0, 2 ) )
                maps\_utility::smart_radio_dialogue( "df_gid_keeppushing2" );
            else
                maps\_utility::smart_radio_dialogue( "df_gid_gettobuilding" );

            var_0 += 9;
        }
    }

    maps\_utility::smart_radio_dialogue( "df_nox_targetbuilding" );
}

watch_tower_nags()
{
    level endon( "player_near_tower" );
    var_0 = [];
    var_0[var_0.size] = "df_gid_getonpoint";
    var_0[var_0.size] = "df_nox_thisway4";
    var_0[var_0.size] = "df_gid_getbackhere";
    var_0[var_0.size] = "df_nox_getoverhere3";
    var_1 = 0;
    var_2 = 6;
    var_3 = length2d( level.df_objectives["tower"]["origin"] - level.player.origin );
    var_4 = var_3;

    for (;;)
    {
        var_5 = length2d( level.df_objectives["tower"]["origin"] - level.player.origin );

        if ( var_5 > var_4 + 500 )
        {
            maps\_utility::smart_radio_dialogue_interrupt( var_0[var_1] );
            var_1++;

            if ( var_1 >= var_0.size )
                var_1 = 0;

            wait( var_2 );
            var_2 *= 1.5;
        }
        else if ( var_5 < var_4 )
            var_4 = var_5;

        wait 0.5;
    }
}

intro_beach_briefing_anims()
{
    var_0 = common_scripts\utility::getstruct( "intro_beach_animate_to", "targetname" );
    waittillframeend;
    var_1 = [];
    var_1[0] = level.holt;
    var_1[1] = level.intro_ally1;
    var_1[2] = level.intro_ally2;
    var_1[3] = level.intro_ally3;
    var_1[0].animname = "holt";
    var_1[1].animname = "ally1";
    var_1[2].animname = "ally2";
    var_1[3].animname = "ally3";
    var_0 maps\_anim::anim_single( var_1, "shore_briefing" );
}

pod_flyin()
{
    thread fade_to_black();
    common_scripts\utility::flag_set( "ignore_outofbounds_clip" );
    setsaveddvar( "cg_cinematicfullscreen", "0" );
    common_scripts\utility::flag_wait( "start_intro_anims" );
    var_0 = getentarray( "intro_repulsor", "targetname" );

    foreach ( var_2 in var_0 )
    {
        var_3 = var_2 getorigin();
        var_4 = missile_createrepulsororigin( var_3, 2000, 2048 );
    }

    level.player disableweapons();
    var_6 = common_scripts\utility::getstruct( "intro_beach_animate_to", "targetname" );
    level.player_pod = maps\_utility::spawn_anim_model( "sentinel_drop_pod" );
    level.knox_pod = maps\_utility::spawn_anim_model( "sentinel_drop_pod" );
    level.gideon_pod = maps\_utility::spawn_anim_model( "sentinel_drop_pod" );
    var_7 = maps\_utility::spawn_anim_model( "player_rig" );
    var_7 setmodel( "s1_gfl_ump45_viewbody" );
    level.player playerlinktoabsolute( var_7, "tag_player" );
    var_8 = maps\_utility::spawn_anim_model( "prop30" );
    var_9 = maps\_utility::spawn_anim_model( "pergola" );
    wait 0.05;
    var_10 = [];
    var_11 = [];
    var_11[0] = level.allies[0];
    var_11[1] = level.allies[1];
    var_10[0] = var_7;
    var_10[1] = var_8;
    var_10[2] = var_9;
    var_10[3] = level.knox_pod;
    var_10[4] = level.gideon_pod;
    var_10[5] = level.player_pod;
    var_10[0].animname = "player_rig";
    var_10[3].animname = "knox_pod";
    var_10[4].animname = "gideon_pod";
    var_10[5].animname = "player_pod";
    var_10[2] thread maps\df_baghdad_fx::intro_infil_pergola_fx();
    var_10[3] thread maps\df_baghdad_fx::intro_infil_knox_pod_fx();
    var_10[4] thread maps\df_baghdad_fx::intro_infil_gideon_pod_fx();
    var_10[5] thread maps\df_baghdad_fx::intro_infil_player_pod_fx( var_11[0] );
    var_10[5] thread intro_player_rumble();
    var_11[0] thread maps\df_baghdad_fx::intro_infil_gideon_fx();
    var_11[1] thread maps\df_baghdad_fx::intro_infil_knox_fx();
    var_6 maps\_anim::anim_first_frame( var_10, "intro_pod_scene" );
    var_6 maps\_anim::anim_first_frame( var_11, "intro_pod_scene" );
    wait 0.05;

    for ( var_12 = 1; var_12 <= 25; var_12++ )
    {
        var_13 = "trq_outdoor_umbrella_01_longlod";

        if ( var_12 < 14 )
            var_13 = "cafe_chair_02_longlod";
        else if ( var_12 < 21 )
            var_13 = "cafe_table_01_longlod";

        var_14 = "j_prop_" + var_12;
        var_8 attach( var_13, var_14, 1 );
    }

    common_scripts\utility::flag_wait( "start_intro_anims" );
    level.allies[0].ignoreall = 1;
    level.allies[1].ignoreall = 1;
    var_6 = common_scripts\utility::getstruct( "intro_beach_animate_to", "targetname" );
    thread post_pod_intro_stuff();
    wait 0.05;
    level.player_pod thread damaged_planter();
    thread intro_pod_audio();
    var_6 thread maps\_anim::anim_single_run( var_11, "intro_pod_scene" );
    var_6 maps\_anim::anim_single( var_10, "intro_pod_scene" );
    level notify( "intro_pod_anims_finished" );
    thread maps\_utility::autosave_by_name( "post_pod_intro" );
    var_10[0] delete();
    thread intro_vo();
    level.player unlink();
    thread ignore_player_intro();
    level.player enableweapons();
    thread maps\df_baghdad_code::watch_follow_objective();
    wait 2;
    common_scripts\utility::flag_clear( "ignore_outofbounds_clip" );
}

ignore_player_intro()
{
    level.player.ignoreme = 1;

    if ( !common_scripts\utility::flag( "player_on_intro_balcony" ) )
        common_scripts\utility::flag_wait( "player_on_intro_balcony" );

    level.player.ignoreme = 0;
}

intro_player_rumble()
{
    self waittillmatch( "single anim", "flak1" );
    level.player playrumbleonentity( "damage_light" );
    self waittillmatch( "single anim", "flak2" );
    level.player playrumbleonentity( "damage_heavy" );
    wait 4.8;
    level.player playrumblelooponentity( "heavy_3s" );
    self waittillmatch( "single anim", "start_pod_slide" );
    level.player stoprumble( "heavy_3s" );
    self waittillmatch( "single anim", "planter_slam" );
    level.player playrumbleonentity( "damage_heavy" );
}

damaged_planter()
{
    var_0 = getentarray( "pod_intro_post_tiles", "targetname" );
    common_scripts\utility::array_call( var_0, ::hide );
    var_1 = getent( "pod_crash_tiles", "targetname" );
    var_1.origin += ( 0, 0, 2 );
    self waittillmatch( "single anim", "planter_slam" );
    var_2 = getentarray( "pre_pod_crash", "targetname" );
    common_scripts\utility::array_call( var_2, ::delete );
    var_1 hide();
    var_1.origin -= ( 0, 0, 2 );
    common_scripts\utility::array_call( var_0, ::show );
}

intro_pod_audio()
{
    wait 2;
    maps\_utility::smart_radio_dialogue_interrupt( "df_gid_inhot" );
    maps\_utility::smart_radio_dialogue_interrupt( "df_nox_roughlanding" );
    maps\_utility::smart_radio_dialogue_interrupt( "df_gid_reverse" );
}

fade_to_black()
{
    var_0 = newhudelem();
    var_0.x = 0;
    var_0.y = 0;
    var_0.horzalign = "fullscreen";
    var_0.vertalign = "fullscreen";
    var_0.foreground = 1;
    var_0 setshader( "black", 640, 480 );
    var_0 fadeovertime( 0.05 );
    var_0.alpha = 1;
    wait 1;
    common_scripts\utility::flag_set( "start_intro_anims" );
    wait 0.1;
    var_0 fadeovertime( 1.5 );
    var_0.alpha = 0;
}

water_explosions_near()
{
    var_0 = [];
    var_0[0] = 2345;
    var_0[0] = 2346;
    var_0[0] = 2347;

    for (;;)
    {
        common_scripts\_exploder::exploder( randomintrange( 2345, 2347 ) );
        wait( randomfloatrange( 1.0, 2.0 ) );
    }
}

water_explosions_far()
{
    var_0 = [];
    var_0[0] = 2348;
    var_0[0] = 2349;
    var_0[0] = 2350;
    var_0[0] = 2351;

    for (;;)
    {
        common_scripts\_exploder::exploder( randomintrange( 2348, 2351 ) );
        wait( randomfloatrange( 1.0, 2.0 ) );
    }
}

intro_anims()
{
    var_0 = maps\df_baghdad_code::array_spawn_targetname_allow_fail( "intro_radio_guy", 1 )[0];

    if ( !isdefined( var_0 ) )
        return;

    var_0.animname = "generic";
    var_0 thread maps\_anim::anim_loop_solo( var_0, "intro_balcony_radio" );
    var_0 attach( "com_hand_radio", "tag_inhand", 1 );
    common_scripts\utility::flag_wait( "flag_reach_ilona_complete" );
    var_1 = common_scripts\utility::getstruct( "drag_anim_struct", "targetname" );
    var_2 = maps\df_baghdad_code::array_spawn_targetname_allow_fail( "intro_drag_guys", 1 );
    var_2[0].animname = "ally1";
    var_2[1].animname = "ally2";
    var_1 maps\_utility::delaythread( 0.1, maps\_anim::anim_set_time, var_2, "intro_balcony_drag", 0.35 );
    var_1 maps\_anim::anim_single( var_2, "intro_balcony_drag" );
    var_1 thread maps\_anim::anim_loop( var_2, "intro_balcony_drag_loop" );
    level waittill( "flag_allies_frontline2" );

    if ( level.currentgen )
        common_scripts\utility::flag_wait( "intro_jumpdown" );

    if ( isalive( var_0 ) )
        var_0 delete();

    foreach ( var_4 in var_2 )
    {
        if ( isalive( var_4 ) )
            var_4 delete();
    }
}

post_pod_intro_stuff()
{
    var_0 = maps\_vehicle::spawn_vehicles_from_targetname_and_drive( "allies_intro_heli_flyby" );

    foreach ( var_2 in var_0 )
    {
        var_2.preferred_crash_style = 3;
        var_2.enablerocketdeath = 1;
    }

    thread intro_anims();
    maps\_utility::activate_trigger_with_targetname( "intro_allies_color" );
}

vig_ally_injured_drag()
{
    var_0 = getent( "vig_ally_injured_drag01", "targetname" );
    var_1 = var_0 maps\_utility::spawn_ai();
    var_2 = getent( "vig_ally_injured_drag02", "targetname" );
    var_3 = var_2 maps\_utility::spawn_ai();
    var_1 thread maps\_anim::anim_generic_first_frame( var_1, "injured_soldier_drag_guy01" );
    var_3 thread maps\_anim::anim_generic_first_frame( var_3, "injured_soldier_drag_guy02" );
    common_scripts\utility::flag_wait( "flag_start_intro_vig1" );
    var_1 thread maps\_anim::anim_generic( var_1, "injured_soldier_drag_guy01" );
    var_1 thread maps\_anim::anim_generic( var_3, "injured_soldier_drag_guy02" );
}

vig_ally_injured_cpr()
{
    var_0 = getent( "scn_vig_ally_injured_cpr", "targetname" );
    var_1 = getent( "vig_ally_injured_cpr01", "targetname" );
    var_2 = var_1 maps\_utility::spawn_ai();
    var_3 = getent( "vig_ally_injured_cpr02", "targetname" );
    var_4 = var_3 maps\_utility::spawn_ai();
    var_0 thread maps\_anim::anim_generic_first_frame( var_2, "injured_soldier_cpr_guy01" );
    var_0 thread maps\_anim::anim_generic_first_frame( var_4, "injured_soldier_cpr_guy02" );
    common_scripts\utility::flag_wait( "flag_start_intro_vig1" );
    var_0 thread maps\_anim::anim_generic( var_2, "injured_soldier_cpr_guy01" );
    var_0 thread maps\_anim::anim_generic( var_4, "injured_soldier_cpr_guy02" );
    var_0 thread maps\_anim::anim_generic_loop( var_2, "injured_soldier_cpr_guy01_idle" );
    var_0 thread maps\_anim::anim_generic_loop( var_4, "injured_soldier_cpr_guy02_idle" );
}

guy_unload_watcher( var_0 )
{
    self endon( "death" );
    var_0 maps\_utility::ent_flag_wait( "unloaded" );
    waitframe();
    maps\_utility::activate_trigger_with_targetname( "allies_heli_colors" );
}

send_ai_to_colorvolume( var_0, var_1 )
{
    self notify( "stop_color_move" );
    self.currentcolorcode = var_1;

    if ( isdefined( var_0.target ) )
    {
        var_2 = getnode( var_0.target, "targetname" );

        if ( isdefined( var_2 ) )
            self setgoalnode( var_2 );
    }

    self.fixednode = 0;
    self setgoalvolumeauto( var_0 );
}

warbird_handle_unload()
{
    self endon( "death" );
    self waittill( "unloaded" );
    maps\_utility::ent_flag_set( "unloaded" );
}

intro_heli_carry_walkers()
{
    var_0 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "vtol_carry_walker1" );
    var_1 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive( "vtol_carry_walker2" );
    wait 0.05;
    var_0 thread warbird_carrying_walker( "warbird_pulley", "warbird_walker" );
    var_1 thread warbird_carrying_walker( "warbird_pulley", "warbird_walker" );
}

warbird_carrying_walker( var_0, var_1 )
{
    maps\_vehicle::godon();
    var_2 = spawn( "script_model", ( 0, 0, 0 ) );
    var_2 linkto( self, "tag_guy0", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    var_2 setmodel( maps\_utility::getmodel( var_0 ) );
    var_3 = spawn( "script_model", ( 0, 0, 0 ) );
    var_3 linkto( var_2, "TAG_ATTACH", ( 0, 0, -114 ), ( 0, 90, 0 ) );
    var_3 setmodel( maps\_utility::getmodel( var_1 ) );
    self waittill( "reached_dynamic_path_end" );
    var_2 delete();
    var_3 delete();
}

intro_beach_invasion()
{
    var_0 = undefined;

    if ( level.nextgen )
        var_0 = maps\df_baghdad_code::array_spawn_targetname_allow_fail( "intro_beach_invasion_protect", 1 );

    if ( level.nextgen )
    {
        var_1 = maps\df_baghdad_code::array_spawn_targetname_allow_fail( "intro_beach_invasion_axis", 1 );

        foreach ( var_3 in var_1 )
        {
            var_3 thread delete_enemy_on_flag( "player_on_intro_balcony" );
            var_3 thread beach_guy_monitor();
        }

        foreach ( var_6 in var_0 )
        {
            var_6.canjumppath = 1;
            var_6.suppressionthreshold = 0.125;
            var_6 thread beach_guy_monitor();
        }
    }

    wait 15;
    var_8 = maps\df_baghdad_code::array_spawn_targetname_allow_fail( "intro_beach_invasion", 1 );

    foreach ( var_6 in var_8 )
    {
        var_6.canjumppath = 1;
        var_6.suppressionthreshold = 0.125;
        var_6 thread beach_guy_monitor();
    }
}

delete_enemy_on_flag( var_0 )
{
    self endon( "death" );
    common_scripts\utility::flag_wait( var_0 );

    if ( isdefined( self ) && isalive( self ) )
        self delete();
}

beach_guy_monitor()
{
    self endon( "death" );
    common_scripts\utility::flag_wait( "snipers_finished" );

    if ( isdefined( self ) && isalive( self ) )
        self delete();
}

init_zone_drones()
{
    init_snipers_drones();
}

handle_aa_guns()
{
    iprintlnbold( "Watching for aa gun approaches." );
    var_0 = "waiting";
    allies_inert();
    level.ally_alert_vol = "none";

    while ( !common_scripts\utility::flag( "stop_all_zones" ) )
    {
        var_0 = common_scripts\utility::flag_wait_any_return( "player_in_zone_snipers", "player_in_zone_tank", "player_in_zone_barracks" );
        iprintlnbold( "Active Zone now: " + var_0 );
        thread wait_current_zone_finish( var_0 );
        var_1 = common_scripts\utility::flag_wait_any_return( "active_zone_finished", "stop_all_zones" );

        if ( var_1 == "active_zone_finished" )
        {
            iprintlnbold( "Zone " + var_0 + " stopped because zone finished." );
            continue;
        }

        iprintlnbold( "Zone " + var_0 + " stopped for flag: " + var_1 );
    }

    iprintlnbold( "AA guns all stopped- handling end level conditions." );
    handle_level_exfil( var_0 );
}

wait_current_zone_finish( var_0 )
{
    common_scripts\utility::flag_clear( "active_zone_finished" );
    level endon( "stop_all_zones" );

    while ( common_scripts\utility::flag( var_0 ) )
    {
        common_scripts\utility::flag_waitopen( var_0 );
        var_1 = gettime() + 3000;

        while ( var_1 < gettime() )
        {
            if ( common_scripts\utility::flag( var_0 ) )
                break;

            wait 0.5;
        }

        if ( !( var_1 < gettime() ) )
        {
            level notify( "player_left_active_area" );
            iprintlnbold( "NOTIFYING: player_left_active_area" );
        }
    }

    common_scripts\utility::flag_set( "active_zone_finished" );
}

handle_level_exfil( var_0 )
{
    iprintlnbold( "Handling Exfil at location " + var_0 );
}

zone_handler_snipers()
{
    while ( !common_scripts\utility::flag( "completed_zone_snipers" ) )
    {
        common_scripts\utility::flag_wait( "player_in_zone_snipers" );
        handle_active_snipers();
    }
}

handle_active_snipers()
{
    if ( !common_scripts\utility::flag( "player_in_zone_snipers" ) )
    {
        iprintlnbold( "player_in_zone_snipers flag NOT SET- bailing." );
        return;
    }

    if ( common_scripts\utility::flag( "completed_zone_snipers" ) )
    {
        iprintlnbold( "COMPLETED snipers already- bailing." );
        return;
    }

    level endon( "completed_zone_snipers" );

    if ( !common_scripts\utility::flag( "c4_set_snipers" ) )
    {
        level.ally_alert_vol = "goal_snipers_all";
        thread refresh_core_snipers_enemies();
        player_assault_snipers();
    }

    if ( common_scripts\utility::flag( "c4_set_snipers" ) )
        player_defend_snipers();
}

init_snipers_drones()
{
    level.snipers_defenders = [];
    level.snipers_drone_spawners = getentarray( "snipers_defender", "targetname" );
    level.core_snipers_drone_spawners = getentarray( "snipers_defender_core", "targetname" );
    level.snipers_drones = [];

    foreach ( var_1 in level.snipers_drone_spawners )
        level.snipers_drones[level.snipers_drones.size] = var_1 maps\df_baghdad_code::ambient_animate( 0, "bogus", 1, 0 );

    spawn_core_snipers_guys();
}

refresh_core_snipers_enemies()
{
    level endon( "c4_set_snipers" );
    level waittill( "player_left_active_area" );

    foreach ( var_1 in level.snipers_defenders )
    {
        if ( isdefined( var_1 ) && isalive( var_1 ) && !isdefined( var_1.enemy ) )
            level.snipers_drones[level.snipers_drones.size] = maps\_spawner::spawner_swap_ai_to_drone( var_1 );
    }

    iprintlnbold( "Converted back TO drones: " + level.snipers_drones.size );
    wait 0.05;
    level.snipers_defenders = common_scripts\utility::array_removeundefined( level.snipers_defenders );

    if ( level.snipers_defenders.size > 0 )
        thread monitor_snipers_stragglers();
}

monitor_snipers_stragglers()
{
    iprintlnbold( "Stragglers left after snipers: " + level.snipers_defenders.size );

    foreach ( var_1 in level.snipers_defenders )
    {
        if ( isdefined( var_1 ) && isalive( var_1 ) )
        {
            var_1 setgoalentity( level.player, 2 );
            var_1.goalradius = 384;
        }
    }
}

spawn_core_snipers_guys()
{
    if ( !isdefined( level.snipers_drones ) )
        level.snipers_drones = [];

    foreach ( var_1 in level.core_snipers_drone_spawners )
        level.snipers_drones[level.snipers_drones.size] = var_1 maps\df_baghdad_code::ambient_animate( 0, "bogus", 1, 0 );
}

player_assault_snipers()
{
    var_0 = [];

    foreach ( var_2 in level.snipers_drones )
    {
        if ( isdefined( var_2 ) )
        {
            var_3 = maps\_utility::swap_drone_to_ai( var_2 );

            if ( isdefined( var_3.spawner.animation ) && isarray( level.scr_anim["generic"][var_3.spawner.animation] ) )
            {
                wait 0.05;
                var_3 thread maps\_anim::anim_generic_loop( var_3, var_3.spawner.animation );
                var_3 childthread maps\df_baghdad_code::on_alert_go_volume( "zone_alerted_snipers" );
                var_3.fovcosine = 0.5;
                var_3.fovcosinebusy = 0.1;
            }

            var_0[var_0.size] = var_3;
        }
    }

    level.snipers_drones = common_scripts\utility::array_removeundefined( level.snipers_drones );
    level.snipers_defenders = common_scripts\utility::array_combine( level.snipers_defenders, var_0 );
    level endon( "player_left_active_area" );
    maps\_utility::waittill_dead_or_dying( level.snipers_defenders, level.snipers_defenders.size );
    iprintlnbold( "Ally moving into position to set the charges." );
    common_scripts\utility::flag_set( "c4_set_snipers" );
}

player_defend_snipers()
{
    var_0 = getent( "ally_defend_area_snipers", "targetname" );
    level.allies[1] setgoalvolumeauto( var_0 );
    level.allies[2] setgoalvolumeauto( var_0 );
    position_ally_for_bomb_plant( level.allies[0], "bomb_plant_snipers" );
    var_1 = maps\df_baghdad_code::array_spawn_targetname_allow_fail( "snipers_defend_enemies", 1 );

    foreach ( var_3 in var_1 )
    {
        var_0 = getent( var_3.target, "targetname" );

        if ( !isdefined( var_0 ) )
        {
            iprintlnbold( "Guy Could not find goal vol " + var_3.target );
            var_0 = getent( "snipers_vol", "script_noteworthy" );
        }

        var_3 setgoalvolumeauto( var_0 );
    }

    wait 15;
    iprintlnbold( "45 seconds to go." );
    wait 15;
    iprintlnbold( "30 seconds to go." );
    wait 15;
    iprintlnbold( "15 seconds to go." );
    wait 15;
    iprintlnbold( "Charges set- move out now- blowing in 15 seconds.!." );
    var_0 = getent( "aa_ally_flee_volume_snipers", "targetname" );

    foreach ( var_6 in level.allies )
        var_6 setgoalvolumeauto( var_0 );

    wait 15;
    iprintlnbold( "Boom! Objective completed." );
    common_scripts\utility::flag_set( "completed_zone_snipers" );
    cleanup_snipers_zone();
}

cleanup_snipers_zone()
{
    foreach ( var_1 in level.allies )
        var_1 maps\_utility::enable_ai_color();
}

position_ally_for_bomb_plant( var_0, var_1 )
{
    var_2 = common_scripts\utility::getstruct( var_1, "targetname" );
    var_0 maps\_utility::disable_ai_color();
    var_0 maps\_utility::set_goal_pos( var_2.origin );
    var_0 maps\_utility::set_goal_radius( 32 );
    var_0 waittill( "goal" );
    iprintlnbold( "Ally in position to set charges" );
}

allies_inert()
{
    foreach ( var_1 in level.allies )
    {
        var_1 maps\_utility::set_ignoreall( 1 );
        var_1 maps\_utility::set_ignoreme( 1 );
    }

    thread watch_ally_alert();
}

watch_ally_alert()
{
    level notify( "end_ally_alert_watch" );
    level endon( "end_ally_alert_watch" );
    level waittill( "alert_inert_allies" );

    foreach ( var_1 in level.allies )
    {
        var_1 maps\_utility::set_ignoreall( 0 );
        var_1 maps\_utility::set_ignoreme( 0 );
    }

    if ( level.ally_alert_vol != "none" )
    {
        var_3 = getent( level.ally_alert_vol, "targetname" );
        common_scripts\utility::array_call( level.allies, ::setgoalvolumeauto, var_3 );
        level.ally_alert_vol = "none";
    }
}
